Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7571842E9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhJOHJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:09:48 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40204
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235868AbhJOHJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:09:47 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 07B783FFF1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634281660;
        bh=G8Q93E7oRDShB45M1rwQxN2oXFIEYpBkNOQla9tm8qk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WlZLb1GbbatkmlL7TDhK5oSGN4tSSazVf+5L37GDn/FsBZoI0NyQD2OKlzw4+ozSw
         R5IffyrkmT4qfoqP/yz5HvNfDmyE7jC7t51aB1awkA0JGGKRrgnCvMThhHEn+lFPyx
         1vw59oMbzVgEvqs8VFaJsTdfB2fO5cpLHdXhnbQloNjzobWp330xtj9yaNgz3uKpE+
         Amu9LPGCo0wZ0mpooKWM8hc/L8R/w19x1y/unz1Q3/g2VRjwX8JZOfqxDjMkXQni8j
         SU6RwP33iOHcjUZE+Nt8AtMdD5bfbYGyTeOksD8sPD4MEX0PD5tBqbbrhr2hyUelw2
         wvOg3wZzsIOuw==
Received: by mail-ed1-f70.google.com with SMTP id i7-20020a50d747000000b003db0225d219so2763352edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G8Q93E7oRDShB45M1rwQxN2oXFIEYpBkNOQla9tm8qk=;
        b=ioPl0xfqur7FeV2qj49rKuv2FkEmDgdzSqEqi4/JNhrxpVAcCBoaHhfaf83VdKo3jb
         gAA4/ObM2NNkfh9Lqn/yi+MhOWmaJKwPKTyerE/mvh1N+CB70CrUIsyDgadW98Lhb0Qx
         S5Bytn3D7qLBsRHImIWyBCmWy45ACcG9/GPJu0VYofBRgHw6l8yawUTA0znOplVLaz+p
         OME35GJwARrYLq3agaXL7pV7tePlswJ1350DX+PZZxMpRt+2M/SS6EmFyF4khv+46hN+
         9ta7ZG5rL+9O87nQGgkhQm618zU9WEuMYeOqwJczJCYODs1N13o8BZXxm729XhMeMyCe
         yieg==
X-Gm-Message-State: AOAM531Y2IJs4U7td/6VjfZX877BKvQupATpaKs6CYJlS76KAk3tZDpy
        MrEH0e+jwNR6FnWCJOh4uM6/72CfkO4ZoRZvUKwdttcIIwk5IosHyi2FA7ZiONItsNcsPfshfBt
        X2yAs0fPEqgpJ+v+QciqLzkaKZB/yCinlMlyzMhMR7MAHmCIDkJSS6M9DgA==
X-Received: by 2002:a17:906:3ec3:: with SMTP id d3mr4892310ejj.78.1634281659596;
        Fri, 15 Oct 2021 00:07:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV++T4yTsZA9PCCRraFWBpK4zouxtZ79qN3cY+6yt0w3IDoaYNxzE4AoE2Y1Mt1Wfzb4SwCKPo3SvVQ3uKMfg=
X-Received: by 2002:a17:906:3ec3:: with SMTP id d3mr4892279ejj.78.1634281659381;
 Fri, 15 Oct 2021 00:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com> <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr>
In-Reply-To: <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri, 15 Oct 2021 09:07:28 +0200
Message-ID: <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>, rppt@kernel.org,
        geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 3:25 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-10-06 14:10, Alexandre Ghiti =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> >
> > So I followed the instructions here:
> > https://documentation.suse.com/fr-fr/sles/12-SP3/html/SLES-all/cha-tuni=
ng-kexec.html#cha-tuning-kexec-basic-usage,
> > below the output on an Unmatched board using a vmlinux stored on a sd
> > card:
> >
> > ubuntu@ubuntu:~$ sudo sbin/kexec -l vmlinux --append=3D"$(cat
> > /proc/cmdline)" --initrd=3D/boot/initrd.img
> > Warning: No cmdline provided, using append string as cmdline
> > Warning: No dtb provided, using /sys/firmware/fdt
> > [ 1813.472671] INFO: task kworker/1:0:988 blocked for more than 120
> > seconds.
> > [ 1813.478751]       Not tainted 5.15.0-rc1+ #15
> > [ 1813.483110] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > Could not find a free area of memory of 0x3000 bytes...
> > locate_hole failed
> >
> > I used the Ubuntu kernel, so this is pretty large:
> > -rwxrwxr-x 1 ubuntu ubuntu 277M Oct  5 15:47 vmlinux
> > -rw-r--r-- 1 root root 98M Sep 21 03:25 /boot/initrd.img
> >
>
> ACK, I haven't tested initrd much TBH, I usually don't use an initrd,
> and when I do it's a small busybox-based rootfs.
>
> > Then if I don't load the initrd (I sometimes have the same warning as
> > above) I can at least kexec the new kernel but it fails to boot:
> >
> > ubuntu@ubuntu:~$ sudo ./sbin/kexec -e
> > Warning: No cmdline or append string provided
> > Warning: No dtb provided, using /sys/firmware/fdt
> > [...]
> > [    0.000000] SBI v0.2 HSM extension detected
> > [    0.000000] CPU with hartid=3D0 is not available
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:107!
> > [    0.000000] Kernel BUG [#1]
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc1+ #15
> > [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
> > [    0.000000] epc : setup_smp+0xcc/0x142
> > [    0.000000]  ra : setup_smp+0xc4/0x142
> > [    0.000000] epc : ffffffff80a04080 ra : ffffffff80a04078 sp :
> > ffffffff81803ec0
> > [    0.000000]  gp : ffffffff81a23220 tp : ffffffff81810500 t0 :
> > ffffffff81a3551f
> > [    0.000000]  t1 : ffffffffffffffff t2 : 0000000000000000 s0 :
> > ffffffff81803f00
> > [    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
> > 0000000000000000
> > [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
> > 0000000000000000
> > [    0.000000]  a5 : ffffffff80c64500 a6 : 0000000000000004 a7 :
> > 000000000000ff00
> > [    0.000000]  s2 : 0000000000000005 s3 : 0000000000000000 s4 :
> > ffffffff8118f9a8
> > [    0.000000]  s5 : 0000000000000007 s6 : ffffffff80c0b790 s7 :
> > 0000000080000200
> > [    0.000000]  s8 : 0000000000000fff s9 : 0000000081000200 s10:
> > 0000000000000018
> > [    0.000000]  s11: 000000000000000b t3 : 0000000000ff0000 t4 :
> > ffffffffffffffff
> > [    0.000000]  t5 : ffffffff80c0b7a0 t6 : ffffffff81803bd8
> > [    0.000000] status: 0000000200000100 badaddr: 0000000000000000
> > cause: 0000000000000003
> > [    0.000000] [<ffffffff80a04080>] setup_smp+0xcc/0x142
> > [    0.000000] [<ffffffff80a03d88>] setup_arch+0x56a/0x590
> > [    0.000000] [<ffffffff80a00aa2>] start_kernel+0xaa/0xa5c
> > [    0.000000] random: get_random_bytes called from
> > oops_exit+0x44/0x70 with crng_init=3D0
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle
> > task!
> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
> > the idle task! ]---
> >
> > This reliably fails here.
> >
>
> This looks weird, I'll check it out (we have an unmatched here so I'll
> try to get my hands on it sometime next week).
>
> Did you try kdump ? Do you get the same error ?

kdump works fine, it fails to find the rootfs but I think my setup is
faulty here.
I took a quick look at kexec_relocate.S, and the use of va_pa_offset
is also wrong here, we should use va_kernel_pa_offset as it is used to
modify a text address But fixing that did not work either.

Alex




>
> BTW this is what I use for testing most of the time:
>
> For kexec:
> kexec -l /mnt/shared/vmlinux --reuse-cmdline
> kexec -e
>
> For kdump:
> kexec -p /mnt/shared/vmlinux
> echo c > /proc/sysrq-trigger
>
> Thanks a lot for your time !
>
> Regards,
> Nick
