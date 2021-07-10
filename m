Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4493A3C2CAC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 03:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhGJBwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 21:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGJBwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 21:52:10 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5FCC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 18:49:25 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i5-20020a9d68c50000b02904b41fa91c97so6980433oto.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MYPx4iX7p7e1oDK1yRwFgkNCDq15P6lcDOndgthyp9c=;
        b=APOWKMZEoxZteufD2Rt9mcmt2qAHD1eX8IUarLbLhoqsmbCyYO8UtuR1aLf0foRVwC
         Q9Rm26e4KCK8MoVmji+domatJU1OPWQ3Q894qRjls4c7lg/lTmpJ8bletb3dVGywUluG
         WQeoLbdy5WtdxH50fnSMqKx+AKJTVu8SRQAmlvYOUSv7pdBbLAfXlhByvZe3hQDlrAaP
         r539aWKkNBK6YIkV02AJhBi0m2wRs+qijmeSBsoKWJeMtm/bs8XA/DamytLAtmnxkjqf
         xHmsZIECiovV5lMKjolo52hhU2CtYFQJDGq4ejOWhFtnwO7WsoIpVVp3fl9uaNbm+Hlu
         zS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MYPx4iX7p7e1oDK1yRwFgkNCDq15P6lcDOndgthyp9c=;
        b=ALQnvAeggiA2yUySEAcqgnCkfr6AfSvL3p/7nPunqxupYSmNmjkA+1t2zGKSfTaQ5M
         tgmTObGKyXR9aJAtdSd/3lMGBZZYAScBlZB6AgSAP9EZMGoQwV773lWsCjRVDcSD17HF
         Ksi9s0NaCFfXFp+6eV304qmLJbOmb/mF1gpJ4u2Rj+aJOXSuX92j3WpN4suwNz8Q9y4/
         X2JxY5vdPj68f6QFsvzmyHl+V+0frLAvv+VReEhnlLG5qdGbuiIoA39j/7pXrH8QLgnQ
         5Fe4YhTmmJC+aibnB4RnGwna3znlJ0AXar30hM6f5WjCU3fXlqZ9urUxZzxa/IaCOskr
         +ZcQ==
X-Gm-Message-State: AOAM533E5ngkAURXNkhxYSv6GIX4b2egN2aa9MPmNeacUA9d9tMEZrg9
        mKz4MRQMTUECLMHLc2MiPAM=
X-Google-Smtp-Source: ABdhPJw2NRTJpwpa7pabrMNuPAwtc4fwQ0YncE3mWJdWcCAKkq8vDUCtINQG5rFPbE3tWfnlE8irMg==
X-Received: by 2002:a9d:77c6:: with SMTP id w6mr7904625otl.123.1625881765055;
        Fri, 09 Jul 2021 18:49:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 76sm1500733otj.28.2021.07.09.18.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 18:49:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 9 Jul 2021 18:49:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] riscv: __asm_copy_to-from_user: Optimize
 unaligned memory access and pipeline stall
Message-ID: <20210710014915.GA149706@roeck-us.net>
References: <3e1dbea4-3b0f-de32-5447-2e23c6d4652a@gmail.com>
 <60c1f087-1e8b-8f22-7d25-86f5f3dcee3f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c1f087-1e8b-8f22-7d25-86f5f3dcee3f@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 23, 2021 at 09:40:39PM +0900, Akira Tsukamoto wrote:
> This patch will reduce cpu usage dramatically in kernel space especially
> for application which use sys-call with large buffer size, such as network
> applications. The main reason behind this is that every unaligned memory
> access will raise exceptions and switch between s-mode and m-mode causing
> large overhead.
> 
> First copy in bytes until reaches the first word aligned boundary in
> destination memory address. This is the preparation before the bulk
> aligned word copy.
> 
> The destination address is aligned now, but oftentimes the source address
> is not in an aligned boundary. To reduce the unaligned memory access, it
> reads the data from source in aligned boundaries, which will cause the
> data to have an offset, and then combines the data in the next iteration
> by fixing offset with shifting before writing to destination. The majority
> of the improving copy speed comes from this shift copy.
> 
> In the lucky situation that the both source and destination address are on
> the aligned boundary, perform load and store with register size to copy the
> data. Without the unrolling, it will reduce the speed since the next store
> instruction for the same register using from the load will stall the
> pipeline.
> 
> At last, copying the remainder in one byte at a time.
> 
> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>

This patch causes all riscv32 qemu emulations to stall during boot.
The log suggests that something in kernel/user communication may be wrong.

Bad case:

Starting syslogd: OK
Starting klogd: OK
/etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
/etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
Starting network: /bin/sh: syntax error: unterminated quoted string
sed: unmatched '/'
/bin/sh: syntax error: unterminated quoted string
FAIL
/etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution

Good case (this patch reverted):

Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: [   12.277714] random: dd: uninitialized urandom read (512 bytes read)
OK
Starting network: [   12.949529] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   12.951170] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
udhcpc: started, v1.33.0
udhcpc: sending discover
udhcpc: sending select for 10.0.2.15
udhcpc: lease of 10.0.2.15 obtained, lease time 86400
deleting routers
adding dns 10.0.2.3
OK
Found console ttyS0

Reverting this patch fixes the problem. Bisect log attached.

Guenter

---
# bad: [50be9417e23af5a8ac860d998e1e3f06b8fd79d7] Merge tag 'io_uring-5.14-2021-07-09' of git://git.kernel.dk/linux-block
# good: [f55966571d5eb2876a11e48e798b4592fa1ffbb7] Merge tag 'drm-next-2021-07-08-1' of git://anongit.freedesktop.org/drm/drm
git bisect start 'HEAD' 'f55966571d5e'
# good: [7a400bf28334fc7734639db3566394e1fc80670c] Merge tag 'for-linus-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
git bisect good 7a400bf28334fc7734639db3566394e1fc80670c
# bad: [d8dc121eeab9abfbc510097f8db83e87560f753b] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad d8dc121eeab9abfbc510097f8db83e87560f753b
# bad: [7761e36bc7222d1221242c5f195ee0fd40caea40] riscv: Fix PTDUMP output now BPF region moved back to module region
git bisect bad 7761e36bc7222d1221242c5f195ee0fd40caea40
# good: [5def4429aefe65b494816d9ba8ae7f971d522251] riscv: mm: Use better bitmap_zalloc()
git bisect good 5def4429aefe65b494816d9ba8ae7f971d522251
# good: [47513f243b452a5e21180dcf3d6ac1c57e1781a6] riscv: Enable KFENCE for riscv64
git bisect good 47513f243b452a5e21180dcf3d6ac1c57e1781a6
# good: [01112e5e20f5298a81639806cd0a3c587aade467] Merge branch 'riscv-wx-mappings' into for-next
git bisect good 01112e5e20f5298a81639806cd0a3c587aade467
# good: [70eee556b678d1e4cd4ea6742a577b596963fa25] riscv: ptrace: add argn syntax
git bisect good 70eee556b678d1e4cd4ea6742a577b596963fa25
# bad: [ca6eaaa210deec0e41cbfc380bf89cf079203569] riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall
git bisect bad ca6eaaa210deec0e41cbfc380bf89cf079203569
# good: [31da94c25aea835ceac00575a9fd206c5a833fed] riscv: add VMAP_STACK overflow detection
git bisect good 31da94c25aea835ceac00575a9fd206c5a833fed
# first bad commit: [ca6eaaa210deec0e41cbfc380bf89cf079203569] riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall
