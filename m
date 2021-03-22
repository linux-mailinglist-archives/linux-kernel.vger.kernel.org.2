Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4C343AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCVHyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCVHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:54:00 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177EAC061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:54:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c4so9650015qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLRSZ9p0CZMIyqBziy7iz9HcUO6UY/LqAEu79X1+Jh0=;
        b=ErYo6sqKm+zFxbW5q5YWu4hy047L6uc7imUCqSKZUkOwdOpgwvjfAiuZWoDwOsH5r9
         ONBqE0Sw/v5XQxrZx95tFV1m9OxYu/VXB/ex3Hw4o4SWJZNX6qvenoL6ySpvoj/kr0ah
         4YRlAf5N59Mxv6+lIX5wj0dBE8Jj5rO9qZ1pAW3zAFookYmzUWYinCzsq1+Wo6spW40e
         5lAdxtOdD4GLQi2cliN6ic+XydNzOfabOxlfcAd7gyeAj7YTfCh/NPUtk3HGF7avpGfB
         VQRkmbqUDkNcegSHuKJ5g0oJDWaTpHsav/SGPbw/Xyd21jg8QJroGv5Tj9oC83et+Hn7
         Tq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLRSZ9p0CZMIyqBziy7iz9HcUO6UY/LqAEu79X1+Jh0=;
        b=UKi+bisx3lZxSCuRyiX3Bar1rVYrZ8dQmCrpKQzT/pE7Ttbwa4tKMW8KTz/nERKY72
         SSvG2RqVP/eG+KdHL31hq3I0ubN9O/hzoMfkR4eAsOJjn+omPfzLF6Zhj1yNCulp42+k
         vuaZvgX1kQ6mwfTPX3oQn71GHiUNIe9f/lbN8dtLOzfMQe4jHCcTY/OWKTUOvMdDS/c4
         WMex4KZ+VyH+nkD92WBU0L6t6LMLxF+fjbpnYwZwkf8uib1q5a0STgIDm2P7YxKtYzuz
         i5vBwfUIBC2hu9p5WIK8M5s5bK9CwjL+G/N+9cBfXuP91Dglo4mXm2xx9+l1XImNdGeS
         ErAw==
X-Gm-Message-State: AOAM532GGRpbrekeofHos6F16lyISLmo575TflteqzXy6YybbCtqqCGX
        sWcH47DPcRSexhUt9izM7j5d/r+iHGTVoVkaBGs3aQ==
X-Google-Smtp-Source: ABdhPJzb2gkbOBjoz7XmTLXsLY5BljsCFIBrjT5ENjWHBxposoY6P0vTUMjZzc5xYuZEY8iPvha23YDFshc0x8QZXhU=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr9327233qkx.501.1616399638939;
 Mon, 22 Mar 2021 00:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210319200358.22816-1-zohar@linux.ibm.com> <20210319200358.22816-2-zohar@linux.ibm.com>
 <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
In-Reply-To: <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Mar 2021 08:53:47 +0100
Message-ID: <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was initialized
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 8:11 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/03/20 5:03, Mimi Zohar wrote:
> > The integrity's "iint_cache" is initialized at security_init().  Only
> > after an IMA policy is loaded, which is initialized at late_initcall,
> > is a file's integrity status stored in the "iint_cache".
> >
> > All integrity_inode_get() callers first verify that the IMA policy has
> > been loaded, before calling it.  Yet for some reason, it is still being
> > called, causing a NULL pointer dereference.
> >
> > As reported by Dmitry Vyukov:
> > in qemu:
> > qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
> > max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
> > wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
> >  -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
> >    -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
> > nic,model=virtio-net-pci   -object
> > memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
> >   -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
> > root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
> > panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
> > vm_pid -m 2G -cpu host
> >
>
> I tried similar command line (without "-enable-kvm" and without "-cpu host"
> as I'm running from VMware, without "-soundhw all", without "-machine q35,nvdimm"
> and "-device nvdimm,id=nvdimm1,memdev=pmem1" etc.) on 5.12-rc4. While I was finally
> able to hit similar crash when I used "-smp 1" instead of "-smp 4", I suspect
> this is not a integrity module's problem but a memory initialization/corruption
> problem, for I got various different crashes (INT3) at memory allocation when
> I was trimming command line options trying to reproduce the same crash.
>
> Dmitry, do you get different crashes by changing command line arguments?

No, I have not seen any other crashes, one the reported one.
