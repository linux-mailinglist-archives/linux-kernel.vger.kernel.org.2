Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4DB3F15AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhHSJAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhHSJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:00:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636A3C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:59:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v4so7842235wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uVCUyG2NuSIGcMkq0WuvNZ15TJ1vZGR///Ye476yofU=;
        b=KI0EaoIHCCtmAfSlWmcLr/ObZuekZhkwWEKURpSz4ItXaOXjyCdLXn9KWaWRBcmCgB
         qSfR57ZurpkJJY0m9Lg1RmcXVNZbQUUAMZadH/Ooz3pSTGVwHqbftl5+QBpMsw02cZ8i
         yjR2hjJbyC3KRbq9JQEAeUqkhPCiXgWTL85jOIt2KJUxsIY0QnZAUK55BHdezuyS7D8u
         DoOD/CvZ2nldKe/6xuQ/bLigBrMtEgDKbNKG5FjO3OHcIHiLi2A9utHfWOmnVAOBe8Pb
         zJJtjn7kgX25+GrQ04vKCt7KtyIPAGQp6Na+wRwZGk9Rxkce9Ml5ZWy2lEJ8TiRGdQ0a
         +i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVCUyG2NuSIGcMkq0WuvNZ15TJ1vZGR///Ye476yofU=;
        b=PM3MBPSLw1VPQq/JnaPeCeFOLkL7n+uCzS4d5DQUzy/IfJXKZFC9227kiz9B5Qv34A
         vda+Cbfp+mz3pGB9LuPc1JM6GC122GurDqG8S5esMlge0RRkmYgOaJm3TxvcMfZIBRkq
         KhX+L0Il92wwr3rmeQsGbyN+RoFkiqStMHHuXEKHPRCkCb/s5/VyYp2dZww/iRcaqBfy
         0d4Nm6hYcIrSFlGdKz5iskzuga0mIlTPzo02tkPAYj01afocjKHRWFl9am+LJqnf5vnG
         oRhI6v9KOOtT8SJqWaFmcZ9ILzaIb98GVl6tcPbkS92Y+EvC7zP9I0tyYQ9sJBBRtR4I
         vVIw==
X-Gm-Message-State: AOAM531eytz+uEYI6ZZxPRfw/6ROQHRTYR8C5qIfB15TSdFztSn7scgn
        oAFF8b27ki14MyOtp/M4ALlHvAm9/MU=
X-Google-Smtp-Source: ABdhPJz5HqPdhNwnLJ2lHu65HFgwpMni8O/WP9YdzyTXUBy1TcyTAjtHhYOipMS4VPFtw9ftfH28Uw==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr2416465wrs.12.1629363578975;
        Thu, 19 Aug 2021 01:59:38 -0700 (PDT)
Received: from saturne.home ([2a01:cb1d:16b:7e00:d8a9:a24:4997:14eb])
        by smtp.gmail.com with ESMTPSA id v5sm1336520wru.37.2021.08.19.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:59:37 -0700 (PDT)
From:   Laurent Stacul <captain.stac@gmail.com>
X-Google-Original-From: Laurent Stacul <laurent.stacul@gmail.com>
Date:   Thu, 19 Aug 2021 10:59:34 +0200
To:     Vito Caputo <vcaputo@pengaru.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS/mmap reflink file question
Message-ID: <YR4ddt89f6DVYa/O@saturne.home>
References: <YRupQKbg6uN8INCn@saturne.home>
 <20210817221258.jb4pg77bdle7t2oj@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210817221258.jb4pg77bdle7t2oj@shells.gnugeneration.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 03:12:58PM -0700, Vito Caputo wrote:
>On Tue, Aug 17, 2021 at 02:19:12PM +0200, Laurent Stacul wrote:
>> Hello,
>>
>> I spent much time digging into the mmap mechanism and I don't have a clear view
>> on mmap'ing a file and a reflink to this file would be mapped twice in memory
>> (this only applies in case the filesystem supports reflink feature like XFS).
>>
>> To describe my tests, I generate a file stored on an XFS partition and create a
>> reflink of it:
>>
>>     % dd if=/dev/zero of=./output.dat bs=1M count=24
>>     % cp --reflink -v output.dat output2.dat
>>     % xfs_bmap -v output.dat
>>     output.dat:
>>      EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL
>>        0: [0..49151]:      3756776..3805927  0 (3756776..3805927) 49152 100000
>>     % xfs_bmap -v output2.dat
>>     output2.dat:
>>      EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL
>>        0: [0..49151]:      3756776..3805927  0 (3756776..3805927) 49152 100000
>>
>> Then I mmap the first file twice using vmtouch tool:
>>
>>     % vmtouch -l output.dat&
>>     [1] 15870
>>     LOCKED 6144 pages (24M)
>>     % vmtouch -l output.dat&
>>     [2] 15872
>>     LOCKED 6144 pages (24M)
>>     % pmap -X 15872 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
>>          Address Perm Device      Inode        Rss        Pss
>>     7fcbb9eb9000 r--s  fc:10    3755268      24576      12288
>>
>> As we can see the Proportional Set Size is as expected the half of the Resident
>> Set Size because the memory is shared by the two processes. Now, I mmap the
>> reflink `output2.dat' of 'output.dat':
>>
>>     % vmtouch -l output2.dat&
>>     [3] 15892
>>     LOCKED 6144 pages (24M)
>>     % pmap -X 15872 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
>>          Address Perm Device      Inode        Rss        Pss
>>     7fcbb9eb9000 r--s  fc:10    3755268      24576      12288
>>
>> The Pss of mmap'ed file by the first process has not decreased (I expected a
>> value of Rss / 3 because I hoped the memory would have been shared by the 3
>> processes). If I look at the process map of the last process, we can interpret
>> a new memory area was allocated and locked.
>>
>>     % pmap -X 15892 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
>>           Address Perm Device      Inode        Rss        Pss
>>      7f5adc53f000 r--s  fc:10    3755269      24576      24576
>>
>> So my questions:
>> - Why can't we benefit from the memory sharing when reflinked files are mmap'ed
>>   ? It would be great because one application would be, in the context of
>>   containers, the possibility to share some read only areas between container
>>   that are built from the layer diff that are reproducible between images. We
>>   can imagine a layer that brings some shared libraries in an image from a
>>   reproducible FS diff so that containers would not load several times a
>>   library.
>> - I can think of many tricky cases with the behavior I was expecting (especially
>>   if a process has write access to the mapped area), but if you know a way, an
>>   option something to achieve what I am trying to do, I would be glad to hear
>>   it.
>> - Conversely, don't hesitate to tell me my expectation is just crazy.
>>
>> Anyway, I am always looking forward to listening to valuable specialist insights.
>> Thanks in advance,
>>
>> stac
>>
>> PS: Please, add me is CC if this message deserves an answer.
>>
>
>This is one of the major features overlayfs brings to the table over
>reflink's current implementation.
>
>With reflink copies you get distinct inodes and the data sharing
>occurs further down in the fs at the extent level, below the struct
>address_space instances.
>
>If memory serves Dave Chinner has given the issue some thought, but I
>haven't noticed/heard anything in terms of progress there.  Maybe
>he'll see this and chime in...
>
>Regards,
>Vito Caputo

Thanks for your answer. If I understand correctly, reflink feature
cannot be used in the scenario I propose because reflinks are
optimization occuring under the VFS. This makes sense to me and I was
not really confident this had a chance to work.

As you suggest, I will turn my effort on overlay.

Regards,
stac
