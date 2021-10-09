Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B13427A8E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 15:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhJIN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 09:27:14 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:30870 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhJIN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 09:27:12 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 199DPEaA034049
        for <linux-kernel@vger.kernel.org>; Sat, 9 Oct 2021 16:25:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1633785909; x=1636377909;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LKgfWeR7ZhCTfdeuwvy2JeMeyWkTvqRR7ugkMIMnQl4=;
        b=dHfnCWgvOny+S1WEiB9lJDg8owB0nb3g1mDbYVEX2pJxMuhpmk3tPqFvOhaLgnQl
        r7GPRKDOdLFuOPapJCm7ywT/I5sEKMx44LoFO3ycH2UfA0qvZPScYzSnS233zyr2
        VWuUzyQ9A1OLscngKICsiQYvA0q9ndlqM/Xl1vtV0evCTuU2iBuZMoMPkiH/Cvkh
        z5Cz+efpJGL6aezFmyR6Po88wE1aF3wgDPeRN8wDVOustYQwfu+hF1pBrlSjz6lJ
        25c327kiIa9EOW1xXIjx5AuML0d+qlmo0r/Y94kV2dEKVgGEz1xf8wwfifj0p357
        hK2CJ19TASgIBjTQDHOtoQ==;
X-AuditID: 8b5b014d-b84f570000005d46-c7-616198350cae
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 55.96.23878.53891616; Sat,  9 Oct 2021 16:25:09 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 09 Oct 2021 16:25:05 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>, ebiederm@xmission.com,
        kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>, rppt@kernel.org,
        geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
Organization: FORTH
In-Reply-To: <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
Message-ID: <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXSHT1dWdd0RmKiwdoDchbP7nxltVi36AKr
        xZMPE9ksFq34zmLxf1sLu8Xc2ZMYLXaf/spkcXnXHDaLbZ9b2Cya351jt3h5uYfZontltcWR
        9duZLGZ/WMLiwOcxq6GXzePNy5csHvdOTGP1mHhW1+PhpktMHptWdbJ57J+7ht1j85J6j8+b
        5Dx23n7I5NF+oJvJY8qhdpYAnigum5TUnMyy1CJ9uwSujFXPL7EW9MlXPP7yk7WB8aFEFyMn
        h4SAicS06z/Zuxi5OIQEjjJKfDmxjhEiYSoxe28nmM0rIChxcuYTFhCbWcBCYuqV/YwQtrxE
        89bZzCA2i4CqxN6l35lAbDYBTYn5lw6C1YsIGEs8PjGRGaJ+OYvE63OqILawgKvEzt17weL8
        AsISn+5eZAWxOQUCJW4/nsQCcdAlRonG35NYII5wkdizvY0Z4jgViQ+/HwBdzcEhCmRvnqs0
        gVFwFpJTZyE5dRaSUxcwMq9iFEgsM9bLTC7WS8svKsnQSy/axAiOPEbfHYy3N7/VO8TIxMF4
        iFGCg1lJhFfLJDFRiDclsbIqtSg/vqg0J7X4EKM0B4uSOC+v3oR4IYH0xJLU7NTUgtQimCwT
        B6dUA9PZ8C3nGMUlV+qLOVzsW1LBtPKc4WK3kEdb5lq/V7Z2WjfpRDp3ZOqV7XZ2Jy0v6Dk5
        /GTcLhqhniZmyqnR584R63rZcj2nzhebCeaCl1yfngpuOuHXksicFJ8laeCktpZ9q6DBoQAV
        Q937AXfe1Kd8Zb2/SdeyffL7ktMOmj1tb4JWF5159GHfpfdRH55Zll4TvuJvsXrH3+Mb/uvx
        zn/QupWj8NtWk9zsTpfeD1PtxCba7Tvn4rmHubdzml5X5F75V6oaTVeYpujM0FcL/vh/ze2H
        bjMFcwSCXRe47zJsXsm71Jlv5p42/vo9N6JunEv2Xd/9J/XkX/mJK5nPSSQ9+HHx9bQlx62n
        9kdGrFRiKc5INNRiLipOBACMBsx2KwMAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-10-06 14:10, Alexandre Ghiti έγραψε:
> 
> So I followed the instructions here:
> https://documentation.suse.com/fr-fr/sles/12-SP3/html/SLES-all/cha-tuning-kexec.html#cha-tuning-kexec-basic-usage,
> below the output on an Unmatched board using a vmlinux stored on a sd
> card:
> 
> ubuntu@ubuntu:~$ sudo sbin/kexec -l vmlinux --append="$(cat
> /proc/cmdline)" --initrd=/boot/initrd.img
> Warning: No cmdline provided, using append string as cmdline
> Warning: No dtb provided, using /sys/firmware/fdt
> [ 1813.472671] INFO: task kworker/1:0:988 blocked for more than 120 
> seconds.
> [ 1813.478751]       Not tainted 5.15.0-rc1+ #15
> [ 1813.483110] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> Could not find a free area of memory of 0x3000 bytes...
> locate_hole failed
> 
> I used the Ubuntu kernel, so this is pretty large:
> -rwxrwxr-x 1 ubuntu ubuntu 277M Oct  5 15:47 vmlinux
> -rw-r--r-- 1 root root 98M Sep 21 03:25 /boot/initrd.img
> 

ACK, I haven't tested initrd much TBH, I usually don't use an initrd, 
and when I do it's a small busybox-based rootfs.

> Then if I don't load the initrd (I sometimes have the same warning as
> above) I can at least kexec the new kernel but it fails to boot:
> 
> ubuntu@ubuntu:~$ sudo ./sbin/kexec -e
> Warning: No cmdline or append string provided
> Warning: No dtb provided, using /sys/firmware/fdt
> [...]
> [    0.000000] SBI v0.2 HSM extension detected
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:107!
> [    0.000000] Kernel BUG [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc1+ #15
> [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
> [    0.000000] epc : setup_smp+0xcc/0x142
> [    0.000000]  ra : setup_smp+0xc4/0x142
> [    0.000000] epc : ffffffff80a04080 ra : ffffffff80a04078 sp :
> ffffffff81803ec0
> [    0.000000]  gp : ffffffff81a23220 tp : ffffffff81810500 t0 :
> ffffffff81a3551f
> [    0.000000]  t1 : ffffffffffffffff t2 : 0000000000000000 s0 :
> ffffffff81803f00
> [    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
> 0000000000000000
> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
> 0000000000000000
> [    0.000000]  a5 : ffffffff80c64500 a6 : 0000000000000004 a7 :
> 000000000000ff00
> [    0.000000]  s2 : 0000000000000005 s3 : 0000000000000000 s4 :
> ffffffff8118f9a8
> [    0.000000]  s5 : 0000000000000007 s6 : ffffffff80c0b790 s7 :
> 0000000080000200
> [    0.000000]  s8 : 0000000000000fff s9 : 0000000081000200 s10:
> 0000000000000018
> [    0.000000]  s11: 000000000000000b t3 : 0000000000ff0000 t4 :
> ffffffffffffffff
> [    0.000000]  t5 : ffffffff80c0b7a0 t6 : ffffffff81803bd8
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000
> cause: 0000000000000003
> [    0.000000] [<ffffffff80a04080>] setup_smp+0xcc/0x142
> [    0.000000] [<ffffffff80a03d88>] setup_arch+0x56a/0x590
> [    0.000000] [<ffffffff80a00aa2>] start_kernel+0xaa/0xa5c
> [    0.000000] random: get_random_bytes called from
> oops_exit+0x44/0x70 with crng_init=0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle 
> task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
> the idle task! ]---
> 
> This reliably fails here.
> 

This looks weird, I'll check it out (we have an unmatched here so I'll 
try to get my hands on it sometime next week).

Did you try kdump ? Do you get the same error ?

BTW this is what I use for testing most of the time:

For kexec:
kexec -l /mnt/shared/vmlinux --reuse-cmdline
kexec -e

For kdump:
kexec -p /mnt/shared/vmlinux
echo c > /proc/sysrq-trigger

Thanks a lot for your time !

Regards,
Nick
