Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038A53F170A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbhHSKFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbhHSKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:05:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278EEC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:04:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so8289290wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uVCUyG2NuSIGcMkq0WuvNZ15TJ1vZGR///Ye476yofU=;
        b=nwAomb8B5Z6qOhHACra0bNMOiT/F0ZhG8eVGMPO03+fXHIBmqBFgcL7WAr12sA8Kkt
         0+dKzgSMlY7DoaRlri+6N/R+VCxb3grrb5tO00owvnSCPC0KJkgmlqKzUtz1HRmjVsew
         5KoOHKe3MQTFoTotCaCW5zn2J8V13KVs78azbZSXfz9OQdJuM1ZqUca5ZAA/qPNdmcXr
         dPPPvdXKP6LBaeg94hj5rkj9vXIpaozoNeehz0+sIbkdvNnp+hZNwU/3h6bi75rrg4cV
         vMMIgLGk0YwXdcbPNHPd23/0RShR479q6zhMjVb+5lg6ESOrJjaoyNnrO2ZVX+1BFAyR
         rtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVCUyG2NuSIGcMkq0WuvNZ15TJ1vZGR///Ye476yofU=;
        b=OxZsDy4ZGYxGQWQuPV7VtygD8kw0bsHhoiQ0sNGQvc4Nduw0QD6VQCW4s9WI5DcWof
         3jEDWbWYcQ5kTR/qQAKRwHVXWQzvq/d9McC82CxgKgecJxhv3xX2ipT6yU9bMc2GyJsW
         fbu9ItQKbV43bIw7NmRumTQPBzaNshYSEsYYrNmboGoDwf4Bi+X294QDdFANMi2vWT4W
         WCILHpS3Kgz4uvszSqUTrSAW0Hui4DGvKDh7DQIZtqwGbHlBCOWH0SvT9DaO7gQbIWi2
         ezn3A7OxbrjmQQFIjOlocSwjsqUVN5nPc3mTIQqbGQi6boBeNvR7XIc1RYZMdz0E4OEl
         yDlQ==
X-Gm-Message-State: AOAM53080NE5DY2NffzXUT4rwMvnvwSeGXGQwzOLWcLQKyx6aj30g0xQ
        dBO2a7a/yuJZlLwVJI0N476z8GZoXPA=
X-Google-Smtp-Source: ABdhPJy0RCdpJZSxdWYA4M8BLM8ELYbTs6mzYB/w4z///HaYe6Nn7JRwws0HwPT9xnLZWKV/N4ZcQA==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr2743286wru.230.1629367463324;
        Thu, 19 Aug 2021 03:04:23 -0700 (PDT)
Received: from saturne.home ([2a01:cb1d:16b:7e00:d8a9:a24:4997:14eb])
        by smtp.gmail.com with ESMTPSA id x13sm2483778wrq.44.2021.08.19.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 03:04:22 -0700 (PDT)
From:   Laurent Stacul <captain.stac@gmail.com>
X-Google-Original-From: Laurent Stacul <laurent.stacul@gmail.com>
Date:   Thu, 19 Aug 2021 12:04:17 +0200
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Laurent Stacul <captain.stac@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: XFS/mmap reflink file question
Message-ID: <YR4soQ7AV+mxL2ml@saturne.home>
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

