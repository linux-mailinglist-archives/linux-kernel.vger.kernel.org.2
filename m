Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E918356E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352859AbhDGOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbhDGOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:23:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1616C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:23:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k128so9127137wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8uD970DyL69/a+sT6WwvE0oo6vo9VxC0QUchu0mlxcs=;
        b=FO5cvgAJuKrO888hGFQqN8wU5IR1/UqueMrDwvRliECK4Pr/DP9GtRnzFl+Yfeq2UF
         87g6UAm5hQeahmueoWKn1XUEfNnwsDyXjR+YElh0p0Ks69B5sZQx23xUnjFMK5H+o9Jn
         5NuvzAFU9fnSLJ6AHbW1sfQ8Zli0t0fdfl8M++Ym2EJypN7pFN2Lvnbv4Rjjd0bd2xj5
         FKPm+LbT5W2DC0VOER8NLIokvTR0UdvC5MnXiupN2y3Ynnve+Ga/y+h7rlhBKg6j50AR
         Bq8KSRzXH082LbMZdNopkm8fQZrL7JtUfbINpSTgQeIzPskqkas4bLPFgGzUY/+22Hxz
         zoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8uD970DyL69/a+sT6WwvE0oo6vo9VxC0QUchu0mlxcs=;
        b=s4U3ABVdgvlR775ZJT3J33s0vK3Z/+CpWxbH1V9sN1ykwkDa55BaPhHgkq1sgUYmpZ
         c1Ct5y5TS3UTWY2Q7dSfCF2WxHaR+mOG93niYVWAh2ZHsTN8AYoW/9auJfDefKRIYgVb
         Q3YvGB7BHigEXL9QWTZAkfXpieWYJwG1YJucASsxwJ3KCsLYAFs7iWYgEUomP4j2R0vy
         HEGsNNM141tmJByPm3o6lR7N4s/UZ+XmjuvVbV1jv/WZqot6XGJWtizOlFaGVBOKEprs
         a82fkZwZ0ebnfh4bQLjMGcRFC7YZKRtLxgKOs51+rI3JB5z/FMO58QiEbIin/x64e4at
         pqzQ==
X-Gm-Message-State: AOAM530yMkgfvWilncCOkrACU8BqU0qxnCdyrqgGl5Xzkl8qMIKQjecy
        PhY82Ujweo7UkxguKeNqgJI=
X-Google-Smtp-Source: ABdhPJxJUFEAvgBn9L6jjBIT5d4VGipOKGdsVWPKBQh1nQsELh6lVosJ3uBhBnzhB6XEMuTRfK3voQ==
X-Received: by 2002:a05:600c:14c6:: with SMTP id i6mr3411561wmh.4.1617805417657;
        Wed, 07 Apr 2021 07:23:37 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id s138sm8964397wme.8.2021.04.07.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:23:36 -0700 (PDT)
Date:   Wed, 7 Apr 2021 16:23:35 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: crashkernel reservation failed - No suitable area found on a
 cortina/gemini SoC
Message-ID: <YG3AZ4K2auqEz9BK@Red>
References: <YG2rfzRvHIZKXkf/@Red>
 <34ff1fcc-e9ee-02c2-b2a8-d98a24ce94c3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34ff1fcc-e9ee-02c2-b2a8-d98a24ce94c3@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 07, 2021 at 07:13:04AM -0700, Bruce Mitchell a écrit :
> On 4/7/2021 05:54, Corentin Labbe wrote:
> > Hello
> > 
> > I try to do kexec on a cortina/gemini SoC.
> > On a "normal" boot, kexec fail to find memory so I added crashkernel=8M to cmdline. (kernel size is ~6M).
> > But now, kernel fail to reserve memory:
> > Load Kern image from 0x30020000 to 0x800000 size 7340032
> > Booting Linux on physical CPU 0x0
> > Linux version 5.12.0-rc5-next-20210401+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #98 PREEMPT Wed Apr 7 14:14:08 CEST 2021
> > CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
> > CPU: VIVT data cache, VIVT instruction cache
> > OF: fdt: Machine model: Edimax NS-2502
> > Memory policy: Data cache writeback
> > Zone ranges:
> >    Normal   [mem 0x0000000000000000-0x0000000007ffffff]
> >    HighMem  empty
> > Movable zone start for each node
> > Early memory node ranges
> >    node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> > Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> > crashkernel reservation failed - No suitable area found.
> > Built 1 zonelists, mobility grouping on.  Total pages: 32512
> > Kernel command line: console=ttyS0,19200n8 ip=dhcp crashkernel=8M
> > Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> > Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
> > mem auto-init: stack:off, heap alloc:off, heap free:off
> > Memory: 119476K/131072K available (5034K kernel code, 579K rwdata, 1372K rodata, 3020K init, 210K bss, 11596K reserved, 0K cma-reserved, 0K highmem)
> > SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> > 
> > What can I do ?
> > 
> > Thanks
> > Regards
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> Hello Corentin,
> 
> I see much larger crashkernel=xxM being shown here
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kdump/kdump.rst
> and from many of my other searches.
> 
> Here is an interesting article on kdump for ARM-32
> https://kaiwantech.wordpress.com/2017/07/13/setting-up-kdump-and-crash-for-arm-32-an-ongoing-saga/
> 
> 
> Here is the kernel command line reference
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=v5.11#n732
> 
> I feel your frustrations too.

Hello

Thanks but I have already read those documentation.
I search to know why the kernel cannot find 8M of memory ouf of 128.

Regards
