Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48661414CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhIVPZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhIVPZ5 (ORCPT
        <rfc822;Linux-Kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:25:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A53C061574
        for <Linux-Kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:24:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k23so2355291pji.0
        for <Linux-Kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qoUCKun9GOqpNGoTy8WaehZ/oDjPVJ/YWHnCEdsLlKI=;
        b=NCFHxJkJaSuc8ezfgccDGxy89T4yLV+mnMNf8zxTD2Vxzx53ifSv4bdZAUNQp3IZrg
         JW9s4Q5ei2MKlMrNQl0FEzbPHA8+VeL5fuzup08ErGEJ0hKGilqBJ8jnncP85TaAPtJR
         GZCb95Zz9M96jRusGMJZV8PQMyOxFu10+Y1yzgKG+fjyfwAmyDkL2K2Z74Eo63rpl1tk
         tSuSpinobM7L/iZSDR2fRsoU84osWIm5qw469xUuZgwG2f4yw6riC6r1JyXHEX98DtRD
         oVikUXc9ALSImcZvxmtHc79w+VE2CURQeXbaZLLLF9tNExduoK+Rx6GzyPgeUV8SMKM+
         Dr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qoUCKun9GOqpNGoTy8WaehZ/oDjPVJ/YWHnCEdsLlKI=;
        b=nbwc/P4mpdP+GC5QaUL3GYw25kJIk1YRJt100/oJsCjM/Mt6CI+/uSKKLaxt2DoNoB
         VPGRiSgQK9KIvV/3zh2rbvvBUtWRDLBYeTTTxdKk4fj5ilP+RMfccTB1s1UCFIhfuXuP
         gJCv7kBYud/EXBvkRu1xly0man2eu7LhrRYJ+HaqipVyjf7297RQ9Pwu7wO/JKEjcFyi
         7HWTrsIVlYS7ZCx8GQ7GceFbm0YZElHOu20NONCSiIlskrJDOBcdeJN5Gr/MHMOjR8Qe
         WY3ZcrSI+6pumHZDFRiAXg+GltMuhUZAyO0zShG7elDnZsyTWkTXmEHGiyTsh5BootTc
         SVHQ==
X-Gm-Message-State: AOAM530s781vTfUT9wYPI5r1Q5G63RrZYKyHKa0fRFfnHmcgHvPdRxfP
        IQrlmnngmqO3qTJgJtyltXij1ju4tdp+6aO9onu67A32dCc=
X-Google-Smtp-Source: ABdhPJyszb4zfnzJl8jwFZobnxQ6IYG2XWIbcTyos30ue2RhYKBhXAvSbUHtZRWqmnUnX++XiJPrk4HxIGJpfOZvAe0=
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr35644pjg.79.1632324266800;
 Wed, 22 Sep 2021 08:24:26 -0700 (PDT)
MIME-Version: 1.0
From:   cp <carlojpisani@gmail.com>
Date:   Wed, 22 Sep 2021 17:24:30 +0200
Message-ID: <CA+QBN9AoDRAGg=zkfa5B5DBYt-amTrnBkYz+RWoyS95xcjJ9EQ@mail.gmail.com>
Subject: Linux PowerPC 4xx doesn't boot when linkaddr=0x0090.0000
To:     Linux-Kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi
I am new to this list. Hope this is the right place to ask.

I am working with a PPC405GP board, and as far as I understand, the
support for ppc40x platforms like Acadia and Walnut were dropped with
kernel 5.8.0, so this seems like a pretty straightforward question,
but extensive experiments from kernel 4.11 to kernel 5.7.19 haven't
shown a really clear, up-to-date answer.

In k4.11 .. k5.7.19, when the kernel size is bigger than 8 MB, the
final kernel doesn't boot but rather arch/powerpc/boot/main.c dies
before the first message from the kernel shows up.

Why?

Digging deeper I see the relation between the kernel size and link_addr

        # Round the size to next higher MB limit
        round_size=$(((strip_size + 0xfffff) & 0xfff00000))

        round_size=0x$(printf "%x" $round_size)
        link_addr=$(printf "%d" $link_address)

and this is where link_addr is involved

        text_start="-Ttext $link_address"

My kernels are compiled for cuboot, and the code that invokes "kentry"
is entirely located in arch/powerpc/boot/main.c

I instrumned that module, and this is what I see on the condole

The following is the same kernel, compiled with the same .config, but
with two link_addr values

A) with link_addr=0x0080.0000
image loaded from 0x00800000
SP=0x03eb1b80
kernel_size = 7411084 bytes
copying 256 bytes from kernel-image at 0x0080f000 to elfheader
elf_info.loadsize = 0x00700e68
elf_info.memsize  = 0x0074234c
allocating 7611212 bytes for the new kernel
copying ...
from = 0x0081f000
to = 0x00000000
size = 7343720
flush_cache, 32Mbyte flushed
cmdline: uboot bootargs overridden
cmdline=[console=ttyS0,115200 root=/dev/sda2 rootfstype=ext2 rw
init=/sbin/init ]
Finalizing device tree... flat tree at 0xf23b80
ft_addr=0xf23b80
my tp1: success
kernel booting ....
(it boots)

B) with link_addr=0x0080.0000
image loaded from 0x00900000
SP=0x03eb1b80
kernel_size = 7411084
copying 256 bytes from kernel-image at 0x0090f000 to elfheader
elf_info.loadsize = 0x00700e68
elf_info.memsize  = 0x0074234c
allocating 7611212 bytes for the new kernel
copying ...
from = 0x0091f000
to = 0x00000000
size = 7343720
flush_cache, 32Mbyte flushed
cmdline: uboot bootargs overridden
cmdline=[console=ttyS0,115200 root=/dev/sda2 rootfstype=ext2 rw
init=/sbin/init ]
Finalizing device tree... flat tree at 0x1023b80
ft_addr=0x1023b80
my tp2: success
my tp3: success
invalidate_cache 0x00000000+0x02000000
my tp4: (point of no return)
calling kentry()...
kernel booting ....
(it dies at this point, but without a debugger it's like watching
something fall into a black hole)

Any ideas?
I am lost ...

Carlo
