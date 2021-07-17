Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98FF3CC44C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhGQP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhGQP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:57:32 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE95C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 08:54:35 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m13so2882425qvh.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/AmEWCj5cXsx6W4oaKZsoab5w8JmJ+9MssIjB5+swwA=;
        b=Hd7cFMGqcK3734ZSRwBdBTBnPszJUkSaEgKGOSuTyf/9CVvvNfXluFBSaLkqh+vhUh
         QcrT26qOCpfZc1WiHF4mKDD77VaNcYLaA4X7EeCUnD599C/30/hYg2crk7JwD7LWYouM
         QOihc6TRUO3to8f8fESP33q4Y62wfeI36gXgoSU4oyvnNfExtwIvT+orPuGfx8DmHazn
         aiD+1sObT9TkpJVcTQyr+UmDLRLttJ+AV6/s1Qp++DeDte7qcMlwc05Jp5E2l9tnTn0i
         z/HU8M7Kh1ZgxSwCGUKkPA1Uhyo59wcJ9cyEWR9+YBPFTcnFad3dmDkblvyYHWAWCPeu
         ZbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/AmEWCj5cXsx6W4oaKZsoab5w8JmJ+9MssIjB5+swwA=;
        b=gYqHqrep0FYtXi+Q13cUEJiNwhhmEqVpP3Eu64U21xcQfE6kZFkdVeyd2XyMCetvRP
         cHGE+ldervj0D72NZou9TjkhcL0mZRFsUJ532/Bjo/AqSiksNzOlaMJkArR1AXru27xp
         3N4ByCOAChQQz05kTbsnUS98KAJPwKuLTYEwgKcekoRn+0tRVwwRhNusXBfYmZriq86a
         WBaSnmtAzn2Yzpdy+qqh9SNF/SpIxtpiZvG5OxQj6hqG6/W4zkKh3zlwqIGMw7jzekhS
         +9PgvqwhFn0JVE5/kRqlbFmyU5rcirlU3UWrQ21SSvn4onvekPnVaSSzT/qtMZed0KBq
         mvQA==
X-Gm-Message-State: AOAM532OAaLKvVCy7KN0JTWbSpZNWAHC3zvYKqnG6rqI2zjsiAxim3eI
        jDX+btEKXyD8tTLVFdqpiw24Rw3WeNQVe4x54BOuG834pwmyew==
X-Google-Smtp-Source: ABdhPJx6da7bNxrbahuQ1ZMmUEUmGz/s4AMwe9r3af+DEfFlkKfncSOREj83WikQRIBmu7VH6T14DsqX92XdK+L9ZyA=
X-Received: by 2002:a05:6214:1cb:: with SMTP id c11mr16338918qvt.47.1626537274819;
 Sat, 17 Jul 2021 08:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210716221159.3587039-1-linux@roeck-us.net>
In-Reply-To: <20210716221159.3587039-1-linux@roeck-us.net>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Sun, 18 Jul 2021 01:54:23 +1000
Message-ID: <CAOSf1CHuLhYO1rXiAhPz6xyQ-GgrjE-dj=Af6v7CWSH6QroEtQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/chrp: Revert "Move PHB discovery" and "Make
 hydra_init() static"
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 8:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch reverts commit 407d418f2fd4 ("powerpc/chrp: Move PHB
> discovery") and commit 9634afa67bfd ("powerpc/chrp: Make hydra_init()
> static").
>
> Running the upstream kernel on Qemu's brand new "pegasos2" emulation
> results in a variety of backtraces such as

...and actually using it appears to require both manually enabling it
in the qemu config and finding a random bios blob that is no longer
distributed by the manufacturer. Cool.

> Kernel attempted to write user page (a1) - exploit attempt? (uid: 0)
> ------------[ cut here ]------------
> Bug: Write fault blocked by KUAP!
> WARNING: CPU: 0 PID: 0 at arch/powerpc/mm/fault.c:230 do_page_fault+0x4f4/0x920
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.2 #40
> NIP:  c0021824 LR: c0021824 CTR: 00000000
> REGS: c1085d50 TRAP: 0700   Not tainted  (5.13.2)
> MSR:  00021032 <ME,IR,DR,RI>  CR: 24042254  XER: 00000000
>
> GPR00: c0021824 c1085e10 c0f8c520 00000021 3fffefff c1085c60 c1085c58 00000000
> GPR08: 00001032 00000000 00000000 c0ffb3ec 44042254 00000000 00000000 00000004
> GPR16: 00000000 ffffffff 000000c4 000000d0 0188c6e0 01006000 00000001 40b14000
> GPR24: c0ec000c 00000300 02000000 00000000 42000000 000000a1 00000000 c1085e60
> NIP [c0021824] do_page_fault+0x4f4/0x920
> LR [c0021824] do_page_fault+0x4f4/0x920
> Call Trace:
> [c1085e10] [c0021824] do_page_fault+0x4f4/0x920 (unreliable)
> [c1085e50] [c0004254] DataAccess_virt+0xd4/0xe4
>
> and the system fails to boot. Bisect points to commit 407d418f2fd4
> ("powerpc/chrp: Move PHB discovery"). Reverting this patch together with
> commit 9634afa67bfd ("powerpc/chrp: Make hydra_init() static") fixes
> the problem.

The rationale for adding ppc_md.discover_phbs() and shifting all the
platforms over to using it is in commit 5537fcb319d0 ("powerpc/pci:
Add ppc_md.discover_phbs()"). I'd rather not go back to having random
platforms doing their PCI init before the kernel has setup the page
allocator. You need to either debug the problem fully, or provide
enough replication details so that someone who isn't invested in
emulating ancient hardware (i.e. me) with enough information to
actually replicate the problem.

Oliver
