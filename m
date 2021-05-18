Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5D38770D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348266AbhERLDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbhERLDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:03:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164DAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:02:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so1230371wmn.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ODZu957DIFm73DXjmBGOo+SbGeoYd9t83KWfjWOGESQ=;
        b=OV46vw/Xw5rivr9umOBpPJm9zaA9HHctDjUUllafzLDjhAuA5PcEccaW9c6Q5ClqPs
         fNT/nOe8gckSrdGB7KfKVCAtLLew8cIH7wLxLYjvxb89wmWAoZ1u+ri+fzR7c6yvIhc0
         fAk43nQOBH6CsbszJGH/bIr8vpsDl3RsC6gsVrauYWLzWJDc0z+APIoobWA3u9pM8DLD
         BI29lUFSx5DeTfe+gvEostr5aoPNk2Hf0QesEB01CQF27heU8Qx81+i0VUdEp96h32SR
         g5wYeoIpOet2O8HlBXx/uRe4jQKCVYfRxKSeLFpIXsdE728qETrPKIKCOgLW5goPMdAA
         GIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ODZu957DIFm73DXjmBGOo+SbGeoYd9t83KWfjWOGESQ=;
        b=VWeEbhZvComHTjyWdahLlocxEdrAgOBdDjAcYjff3/+dQ23YCSJ8GPj/VR1T+FL6sg
         fF7DfLrrdqTMY1wcLY0kMQBmy/n2c14KMDNW5R2ARHCwsk4UcWz8UiT4E8OexCJbgAAk
         zlBygA8O1klMO1AwPgET86pjN1vk0oKBwvU6ftT+7Wwvu5Km/ATGsrnfa6iN+hzxptgG
         My9YpYEsaMLuhulhYfF9hOxCmW6ZMx3zkAdjtZdL4ddKUpb8A+cyf9HTLYQRmwMtuZEV
         kGk5zwbiTIys5REQyFKE4aEYVcE1AyaFvUs3y+aq8dzUDkVRwxqzpEL1+OtJWdTcVVWY
         ahLw==
X-Gm-Message-State: AOAM531sK7R/JSIGaHvrqYri3X5lU68/eU/NcRoF5BCtQy5mxD/pH8Ko
        HAlRodw7BeI1QT/ajx+QNdpYc2oVmaY=
X-Google-Smtp-Source: ABdhPJwqU6ufHu2UL0u33Va3Xm9VL1RKmLQC2sNIOoYdvXeOIsllaX56eDnAnywRbKrV/3vM8K1opg==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr4375215wma.39.1621335732861;
        Tue, 18 May 2021 04:02:12 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id p10sm19453141wrr.58.2021.05.18.04.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 04:02:12 -0700 (PDT)
Date:   Tue, 18 May 2021 13:02:10 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: initrd is disabled due to memory overlap
Message-ID: <YKOesr9CrvT4gRHx@Red>
References: <YKOVzLHGcHoVTqSi@Red>
 <20210518103546.GU12395@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210518103546.GU12395@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, May 18, 2021 at 11:35:46AM +0100, Russell King (Oracle) a écrit :
> On Tue, May 18, 2021 at 12:24:12PM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > On my SSI1328 gemini board, I use initrd=0x800000,9M in cmdline.
> > On next-20210518 and 5.13-rc1 I got:
> > Booting Linux on physical CPU 0x0
> > Linux version 5.13.0-rc2-next-20210518+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 10.2.0-r5 p6) 10.2.0, GNU ld (Gentoo 2.35.2 p1) 2.35.2) #77 PREEMPT Tue May 18 12:14:41 CEST 2021
> > CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
> > CPU: VIVT data cache, VIVT instruction cache
> > OF: fdt: Machine model: SSI 1328
> > Memory policy: Data cache writeback
> > INITRD: 0x00800000+0x00900000 overlaps in-use memory region - disabling initrd
> > Zone ranges:
> >   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
> >   HighMem  empty
> > Movable zone start for each node
> > Early memory node ranges
> >   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> > Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> > Built 1 zonelists, mobility grouping on.  Total pages: 32512
> > Kernel command line: console=ttyS0,19200n8 initrd=0x800000,9M
> > Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> > Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
> > mem auto-init: stack:off, heap alloc:off, heap free:off
> > Memory: 117480K/131072K available (5459K kernel code, 595K rwdata, 1508K rodata, 180K init, 376K bss, 13592K reserved, 0K cma-reserved, 0K highmem)
> > 
> > On 5.12, initrd is used and works.
> 
> I think this is caused by the normal growth of the size of the kernel.
> If you look in the System.map for the _end symbol, I think you'll find
> that its address is larger than PAGE_OFFSET + 0x800000, causing the
> overlap.
> 
> If so, the only realistic thing to do is to move the initrd higher up
> in memory - I don't think you'll get much traction with the idea of
> reducing the kernel's memory footprint.
> 

Thanks, moving initrd to 0x90000 made it works.
next:
cat /proc/iomem 
00000000-07ffffff : System RAM
  00008000-006f8fff : Kernel code
  00726000-00818edb : Kernel data
v5.12:
# cat /proc/iomem 
00000000-07ffffff : System RAM
  00008000-006d5fff : Kernel code
  00704000-007ee2b3 : Kernel data
So yes, it seems getting bigger.

Thanks for your help.
