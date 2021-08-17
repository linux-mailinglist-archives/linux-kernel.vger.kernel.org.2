Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D53EF5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhHQWWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 18:22:48 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:39236 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHQWWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:22:47 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2021 18:22:47 EDT
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 29F5D1A5FF81; Tue, 17 Aug 2021 15:12:58 -0700 (PDT)
Date:   Tue, 17 Aug 2021 15:12:58 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Laurent Stacul <captain.stac@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: XFS/mmap reflink file question
Message-ID: <20210817221258.jb4pg77bdle7t2oj@shells.gnugeneration.com>
References: <YRupQKbg6uN8INCn@saturne.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRupQKbg6uN8INCn@saturne.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 02:19:12PM +0200, Laurent Stacul wrote:
> Hello,
> 
> I spent much time digging into the mmap mechanism and I don't have a clear view
> on mmap'ing a file and a reflink to this file would be mapped twice in memory
> (this only applies in case the filesystem supports reflink feature like XFS).
> 
> To describe my tests, I generate a file stored on an XFS partition and create a
> reflink of it:
> 
>     % dd if=/dev/zero of=./output.dat bs=1M count=24
>     % cp --reflink -v output.dat output2.dat
>     % xfs_bmap -v output.dat
>     output.dat:
>      EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL
>        0: [0..49151]:      3756776..3805927  0 (3756776..3805927) 49152 100000
>     % xfs_bmap -v output2.dat
>     output2.dat:
>      EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL
>        0: [0..49151]:      3756776..3805927  0 (3756776..3805927) 49152 100000
> 
> Then I mmap the first file twice using vmtouch tool:
> 
>     % vmtouch -l output.dat&
>     [1] 15870
>     LOCKED 6144 pages (24M)
>     % vmtouch -l output.dat&
>     [2] 15872
>     LOCKED 6144 pages (24M)
>     % pmap -X 15872 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
>          Address Perm Device      Inode        Rss        Pss
>     7fcbb9eb9000 r--s  fc:10    3755268      24576      12288
> 
> As we can see the Proportional Set Size is as expected the half of the Resident
> Set Size because the memory is shared by the two processes. Now, I mmap the
> reflink `output2.dat' of 'output.dat':
> 
>     % vmtouch -l output2.dat&
>     [3] 15892
>     LOCKED 6144 pages (24M)
>     % pmap -X 15872 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
>          Address Perm Device      Inode        Rss        Pss
>     7fcbb9eb9000 r--s  fc:10    3755268      24576      12288
> 
> The Pss of mmap'ed file by the first process has not decreased (I expected a
> value of Rss / 3 because I hoped the memory would have been shared by the 3
> processes). If I look at the process map of the last process, we can interpret
> a new memory area was allocated and locked.
> 
>     % pmap -X 15892 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
>           Address Perm Device      Inode        Rss        Pss
>      7f5adc53f000 r--s  fc:10    3755269      24576      24576
> 
> So my questions:
> - Why can't we benefit from the memory sharing when reflinked files are mmap'ed
>   ? It would be great because one application would be, in the context of
>   containers, the possibility to share some read only areas between container
>   that are built from the layer diff that are reproducible between images. We
>   can imagine a layer that brings some shared libraries in an image from a
>   reproducible FS diff so that containers would not load several times a
>   library.
> - I can think of many tricky cases with the behavior I was expecting (especially
>   if a process has write access to the mapped area), but if you know a way, an
>   option something to achieve what I am trying to do, I would be glad to hear
>   it.
> - Conversely, don't hesitate to tell me my expectation is just crazy.
> 
> Anyway, I am always looking forward to listening to valuable specialist insights.
> Thanks in advance,
> 
> stac
> 
> PS: Please, add me is CC if this message deserves an answer.
> 

This is one of the major features overlayfs brings to the table over
reflink's current implementation.

With reflink copies you get distinct inodes and the data sharing
occurs further down in the fs at the extent level, below the struct
address_space instances.

If memory serves Dave Chinner has given the issue some thought, but I
haven't noticed/heard anything in terms of progress there.  Maybe
he'll see this and chime in...

Regards,
Vito Caputo
