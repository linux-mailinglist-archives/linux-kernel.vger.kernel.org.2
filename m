Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8C423C26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbhJFLMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:12:40 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45350
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238360AbhJFLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:12:20 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B1803F32F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633518626;
        bh=bS/xuDbJXJ9v8t2XCi3P2+tAt+BzdyUib/fXpbvCaRM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZE+Cb8lyZH+TZiQaRytTCDcK6h0Ua+idvxnFF1V0m5Qdplb+qB17nARiH6si+ChrU
         GigRPORDcoe2GkB89FEFfJzalSxBn4rZYVsfswkzkRmWwrimC738C3z2zYhkamCiAG
         gycTQVxrZWIulgQgZHQH5Df8OT0hdzKVXCG1mj6s8l9cmWUvcXoqmje7XDqKBC9SQ0
         UhK2cM3SAL2LsvhGFe656uj3XHRutqVrcWyVfEG96MBDX5P5RhaklZdBnRtZRTHDCd
         p+J5AB8NpITeiGtviQuUrA0cEHyExCmkTcbciuz1fETlKZLWF2b/TaHwFdnjJWWvtF
         FNjPW8OuPZJdg==
Received: by mail-ed1-f69.google.com with SMTP id bo2-20020a0564020b2200b003db3540f206so2077984edb.23
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bS/xuDbJXJ9v8t2XCi3P2+tAt+BzdyUib/fXpbvCaRM=;
        b=QwntuhSAUx7Jk8iWxDdPOgAESy1Ahg2m3Bqg+yiOpueEY6bNkesv+ka99h3zTPQ8tO
         5w0Oan4kLFNpW8L2PRwOTNnpP9f69/TMIxXHIHA2prB/75lXNGU9jCrFLXqHkpMsTjCp
         FDw55btAjh/fydOUY+5MCFbpXfNav9PVn9mUu+LdbLZ2i1gtpcq/L4hySTNce/GmfJ5G
         l/nG1Na0BovTROdNYgMqPjT+MHjajZS48iUKSUMdsSHc2yCgvTlNXf6MeensgjU+zkHg
         NLYlraeR4IN1RhgDwh4ZZlaf6IyQc2gqFNaNq/fVNuyd7gV2f2yFyZ7UVys3gkuDXagE
         dihw==
X-Gm-Message-State: AOAM533lflk6sSLh9n5jlJHuvBj4QzoctR8mBKJmKNQ39Vc28NJY8iW3
        c65dOaKGpDq7Y/cb4uQ+8O3whOAltAb6O7FHOxbLFLfa4ZHICIaiY47o51+lQLb482k8sntc8/K
        PgejdKWgD6VdiPX+TwOPM/OubSd0hWZkZQ3bDTKPxzqr6E9rJxOQKKQz8vQ==
X-Received: by 2002:a17:907:7755:: with SMTP id kx21mr31584842ejc.463.1633518625522;
        Wed, 06 Oct 2021 04:10:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwijEia3ygQvwVNcSjhpzLeZ5wD/V/UIziNbabK4yrQvZHCa4G0ujp0z5Ene8/LPIWpkj2WVVst4RuzlQQY0q0=
X-Received: by 2002:a17:907:7755:: with SMTP id kx21mr31584810ejc.463.1633518625317;
 Wed, 06 Oct 2021 04:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr> <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
In-Reply-To: <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Wed, 6 Oct 2021 13:10:14 +0200
Message-ID: <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Oct 5, 2021 at 4:07 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> On Tue, Oct 5, 2021 at 2:15 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
> >
> > Hello all,
> >
> > I've uploaded my kexec-tools patches for riscv on github for
> > testing/review before sending them upstream.
> > https://github.com/riscv-collab/kexec-tools/tree/riscv
> >
> > Both kexec and kdump were tested on latest rv64 qemu, using for-next
> > branch with this patch applied:
> > https://patchwork.kernel.org/project/linux-riscv/patch/20211002122026.1451269-1-mick@ics.forth.gr/
> >
>
> I'll test that asap and review your patch too.
>
> Thanks for your time Nick!
>
> Alex
>

So I followed the instructions here:
https://documentation.suse.com/fr-fr/sles/12-SP3/html/SLES-all/cha-tuning-kexec.html#cha-tuning-kexec-basic-usage,
below the output on an Unmatched board using a vmlinux stored on a sd
card:

ubuntu@ubuntu:~$ sudo sbin/kexec -l vmlinux --append="$(cat
/proc/cmdline)" --initrd=/boot/initrd.img
Warning: No cmdline provided, using append string as cmdline
Warning: No dtb provided, using /sys/firmware/fdt
[ 1813.472671] INFO: task kworker/1:0:988 blocked for more than 120 seconds.
[ 1813.478751]       Not tainted 5.15.0-rc1+ #15
[ 1813.483110] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
Could not find a free area of memory of 0x3000 bytes...
locate_hole failed

I used the Ubuntu kernel, so this is pretty large:
-rwxrwxr-x 1 ubuntu ubuntu 277M Oct  5 15:47 vmlinux
-rw-r--r-- 1 root root 98M Sep 21 03:25 /boot/initrd.img

Then if I don't load the initrd (I sometimes have the same warning as
above) I can at least kexec the new kernel but it fails to boot:

ubuntu@ubuntu:~$ sudo ./sbin/kexec -e
Warning: No cmdline or append string provided
Warning: No dtb provided, using /sys/firmware/fdt
[...]
[    0.000000] SBI v0.2 HSM extension detected
[    0.000000] CPU with hartid=0 is not available
[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:107!
[    0.000000] Kernel BUG [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc1+ #15
[    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
[    0.000000] epc : setup_smp+0xcc/0x142
[    0.000000]  ra : setup_smp+0xc4/0x142
[    0.000000] epc : ffffffff80a04080 ra : ffffffff80a04078 sp :
ffffffff81803ec0
[    0.000000]  gp : ffffffff81a23220 tp : ffffffff81810500 t0 :
ffffffff81a3551f
[    0.000000]  t1 : ffffffffffffffff t2 : 0000000000000000 s0 :
ffffffff81803f00
[    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
0000000000000000
[    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
0000000000000000
[    0.000000]  a5 : ffffffff80c64500 a6 : 0000000000000004 a7 :
000000000000ff00
[    0.000000]  s2 : 0000000000000005 s3 : 0000000000000000 s4 :
ffffffff8118f9a8
[    0.000000]  s5 : 0000000000000007 s6 : ffffffff80c0b790 s7 :
0000000080000200
[    0.000000]  s8 : 0000000000000fff s9 : 0000000081000200 s10:
0000000000000018
[    0.000000]  s11: 000000000000000b t3 : 0000000000ff0000 t4 :
ffffffffffffffff
[    0.000000]  t5 : ffffffff80c0b7a0 t6 : ffffffff81803bd8
[    0.000000] status: 0000000200000100 badaddr: 0000000000000000
cause: 0000000000000003
[    0.000000] [<ffffffff80a04080>] setup_smp+0xcc/0x142
[    0.000000] [<ffffffff80a03d88>] setup_arch+0x56a/0x590
[    0.000000] [<ffffffff80a00aa2>] start_kernel+0xaa/0xa5c
[    0.000000] random: get_random_bytes called from
oops_exit+0x44/0x70 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

This reliably fails here.

> > Regards,
> > Nick
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
