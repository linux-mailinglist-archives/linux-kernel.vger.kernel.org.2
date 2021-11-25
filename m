Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5666145E384
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 00:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbhKYXs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 18:48:28 -0500
Received: from mailgate.ics.forth.gr ([139.91.1.2]:41563 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKYXq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 18:46:27 -0500
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 1APNhD5A068689
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:43:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1637883788; x=1640475788;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UDrS+DoSn8uGZsnCRsfQCOc0/q698uwjMUOP3PeRipU=;
        b=V1u0iYtrokgo2vsmTEWqi/HhMXk4Oil2CI/3QsUybpUZMrDhCecIobrPK9T6/5S+
        IEe5S02BDIcf7LZHRQZ+6oBY3maHwQg0SUlgGeaMgV6jdTbUG40gKGXNhG6wsEKl
        72n21pAnWEICVPHQECgscC6bL3zdl8NoTIOy5XdcvXD05xuLaf15Bi8Za1x73wbW
        SEAU2mU1YZcBiT/Xxf4sQ0xm/7/4QHijSRsOZs1cJZSj9XJQBXuL1vNVInZlcNRW
        +8kgx6/ny3YN958oJ6osYD6c+9k38zdi4lI91KYlHr/OTpMPhgVDC09B/irB+PWr
        YtHOSYAEqP25YB85H6tXRQ==;
X-AuditID: 8b5b014d-ba8f670000005d46-0f-61a01f8bfe05
Received: from enigma.ics.forth.gr (enigma-2.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 7B.D2.23878.B8F10A16; Fri, 26 Nov 2021 01:43:08 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 26 Nov 2021 01:43:06 +0200
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
In-Reply-To: <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr>
 <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
Message-ID: <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXSHT1dWbdHfkGiwecpjBbP7nxltVi36AKr
        xZMPE9ksFq34zmLxf1sLu8Xc2ZMYLXaf/spkcXnXHDaLbZ9b2Cya351jt3h5uYfZontltcWR
        9duZLGZ/WMLiwOcxq6GXzePNy5csHvdOTGP1mHhW1+PhpktMHptWdbJ57J+7ht1j85J6j8+b
        5Dx23n7I5NF+oJvJY8qhdpYAnigum5TUnMyy1CJ9uwSujM89E9kK5mlVvP47m6mBcY1iFyMn
        h4SAicSn/UuZuhi5OIQEjjFKPG3bxQSRMJWYvbeTEcTmFRCUODnzCQuIzSxgITH1yn5GCFte
        onnrbGYQm0VAVWLF6j9gNpuApsT8SwfB6kUEjCUen5jIDFG/nEXi9TlVEFtYwFVi5+69YHF+
        AWGJT3cvsoLYnAKBEu/3T2KHOOgKk8S378dZII5wkZj4bCUbxHEqEh9+PwAq4uAQBbI3z1Wa
        wCg4C8mps5CcOgvJqQsYmVcxCiSWGetlJhfrpeUXlWTopRdtYgRHHqPvDsbbm9/qHWJk4mA8
        xCjBwawkwuscOD9RiDclsbIqtSg/vqg0J7X4EKM0B4uSOC+v3oR4IYH0xJLU7NTUgtQimCwT
        B6dUA1NWt/Sk3NUqU6dMu5Tz/5pTfL7A+/+8AWYvblvV5Wzr+Cw+xfvJUrcJRp1hE6rq6ko/
        tBsIbIueKMX8yv9LBfuyzQ1ML5dyMLabeO99vka/17C8taFtf1hLx/mLf7jy71w9qfz209fi
        4ImT7j37+ZI3nW/irk8JZ59/tGDYwrRwbZ5vgYGcwN7Q2AM8U6byuZ88PW8B++NlO++Jc2qo
        F+15HnvhF0dnlskDpwUMvHu93901klP+U9cTVHFgX37jARWhkM2RDMwxhvLbr/HeLDJuZk7z
        viRjxsXhIDbRaLtiTu2fs58NbpU8LVAN26hpxqj0OXvKw6501q8pZtdmcJjlH/sRzPOOVcY+
        3CSkXomlOCPRUIu5qDgRAAOO+XorAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-10-15 10:07, Alexandre Ghiti έγραψε:
> On Sat, Oct 9, 2021 at 3:25 PM Nick Kossifidis <mick@ics.forth.gr> 
> wrote:
>> 
>> Στις 2021-10-06 14:10, Alexandre Ghiti έγραψε:
>> >
>> > So I followed the instructions here:
>> > https://documentation.suse.com/fr-fr/sles/12-SP3/html/SLES-all/cha-tuning-kexec.html#cha-tuning-kexec-basic-usage,
>> > below the output on an Unmatched board using a vmlinux stored on a sd
>> > card:
>> >
>> > ubuntu@ubuntu:~$ sudo sbin/kexec -l vmlinux --append="$(cat
>> > /proc/cmdline)" --initrd=/boot/initrd.img
>> > Warning: No cmdline provided, using append string as cmdline
>> > Warning: No dtb provided, using /sys/firmware/fdt
>> > [ 1813.472671] INFO: task kworker/1:0:988 blocked for more than 120
>> > seconds.
>> > [ 1813.478751]       Not tainted 5.15.0-rc1+ #15
>> > [ 1813.483110] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> > disables this message.
>> > Could not find a free area of memory of 0x3000 bytes...
>> > locate_hole failed
>> >
>> > I used the Ubuntu kernel, so this is pretty large:
>> > -rwxrwxr-x 1 ubuntu ubuntu 277M Oct  5 15:47 vmlinux
>> > -rw-r--r-- 1 root root 98M Sep 21 03:25 /boot/initrd.img
>> >
>> 
>> ACK, I haven't tested initrd much TBH, I usually don't use an initrd,
>> and when I do it's a small busybox-based rootfs.
>> 
>> > Then if I don't load the initrd (I sometimes have the same warning as
>> > above) I can at least kexec the new kernel but it fails to boot:
>> >
>> > ubuntu@ubuntu:~$ sudo ./sbin/kexec -e
>> > Warning: No cmdline or append string provided
>> > Warning: No dtb provided, using /sys/firmware/fdt
>> > [...]
>> > [    0.000000] SBI v0.2 HSM extension detected
>> > [    0.000000] CPU with hartid=0 is not available
>> > [    0.000000] ------------[ cut here ]------------
>> > [    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:107!
>> > [    0.000000] Kernel BUG [#1]
>> > [    0.000000] Modules linked in:
>> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc1+ #15
>> > [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
>> > [    0.000000] epc : setup_smp+0xcc/0x142
>> > [    0.000000]  ra : setup_smp+0xc4/0x142
>> > [    0.000000] epc : ffffffff80a04080 ra : ffffffff80a04078 sp :
>> > ffffffff81803ec0
>> > [    0.000000]  gp : ffffffff81a23220 tp : ffffffff81810500 t0 :
>> > ffffffff81a3551f
>> > [    0.000000]  t1 : ffffffffffffffff t2 : 0000000000000000 s0 :
>> > ffffffff81803f00
>> > [    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
>> > 0000000000000000
>> > [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
>> > 0000000000000000
>> > [    0.000000]  a5 : ffffffff80c64500 a6 : 0000000000000004 a7 :
>> > 000000000000ff00
>> > [    0.000000]  s2 : 0000000000000005 s3 : 0000000000000000 s4 :
>> > ffffffff8118f9a8
>> > [    0.000000]  s5 : 0000000000000007 s6 : ffffffff80c0b790 s7 :
>> > 0000000080000200
>> > [    0.000000]  s8 : 0000000000000fff s9 : 0000000081000200 s10:
>> > 0000000000000018
>> > [    0.000000]  s11: 000000000000000b t3 : 0000000000ff0000 t4 :
>> > ffffffffffffffff
>> > [    0.000000]  t5 : ffffffff80c0b7a0 t6 : ffffffff81803bd8
>> > [    0.000000] status: 0000000200000100 badaddr: 0000000000000000
>> > cause: 0000000000000003
>> > [    0.000000] [<ffffffff80a04080>] setup_smp+0xcc/0x142
>> > [    0.000000] [<ffffffff80a03d88>] setup_arch+0x56a/0x590
>> > [    0.000000] [<ffffffff80a00aa2>] start_kernel+0xaa/0xa5c
>> > [    0.000000] random: get_random_bytes called from
>> > oops_exit+0x44/0x70 with crng_init=0
>> > [    0.000000] ---[ end trace 0000000000000000 ]---
>> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle
>> > task!
>> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
>> > the idle task! ]---
>> >
>> > This reliably fails here.
>> >
>> 
>> This looks weird, I'll check it out (we have an unmatched here so I'll
>> try to get my hands on it sometime next week).
>> 
>> Did you try kdump ? Do you get the same error ?
> 
> kdump works fine, it fails to find the rootfs but I think my setup is
> faulty here.
> I took a quick look at kexec_relocate.S, and the use of va_pa_offset
> is also wrong here, we should use va_kernel_pa_offset as it is used to
> modify a text address But fixing that did not work either.
> 
> Alex
> 

Sorry for the delay, I finally got some time to work on this. As it 
turns out I'm passing cpu id instead of hart id to the next kernel (that 
comment on smp.h claiming that raw_smp_processor_id returns the hart id 
didn't help much) and interestingly enough cpu id and hart id match on 
qemu and also sometimes match on the unmatched / unleashed board. Also 
on unmatched / unleashed, hart id 0 is used by the non-linux hart so if 
we pass the cpu id of the boot cpu that's always going to be 0 it'll be 
invalid, but that's not always the case, especially for kdump. I'm also 
getting an error when trying to mount the rootfs on kdump on the 
unmatched board, because swiotlb can't allocate bounce buffers and the 
pcie driver doesn't work, so no nvme access. I'm looking for a way to 
make this work without messing things up, in any case I'll send some 
patches over the weekend. For the initrd issue I need to patch 
kexec-tools.

Regards,
Nick
