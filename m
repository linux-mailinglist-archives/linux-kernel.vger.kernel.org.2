Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F7306487
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhA0T5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhA0T5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:57:17 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89171C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:56:36 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i7so2301214pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GImFoGYcNJGIlSVASv34elepIVVeNB6p/eEooIUJu8=;
        b=KDv48PwP712haw3IbzSZaM2h0jC+ygqomCAI46Y3xKqSHzaaO1PRlX+i9ffaKeJ0Mr
         rBDLRJgjwfFb/IpBUTC9Fwg71AWniW7XdogOVOooq45Py+m6aV+/sCaawPWcJIMIG5yZ
         UyyITLSUVOWpCEovy3riPGPH48pf6G6knetV2HBv3sTtXTZqCLsICZ2EYpqYQTOXZexD
         hmhJOxzBB3RNxCACXvDqCpvzQm/RK9ZGlzyppmMEhqSAhvCkhhG321ULlobxle7oUsrK
         l7O1oLpacfSAY60hhSeGwryFQ03Wf8/KrBL4BXwjq4KtKamJt/MVlIFLKASIwr2Fh56S
         Xrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GImFoGYcNJGIlSVASv34elepIVVeNB6p/eEooIUJu8=;
        b=i8wo9eb2RZtnlRwbfVmWydYiK5iBVdl/K0jTiy5E69MdV6pRniI4f9orhOmWv8riXk
         A1TgixUgYNPCb9Nd2zDjRCiIplLwbPQOF+mPWNwzM2jo3iI84+Go6wiYQ53VAKjUHHol
         Fn8VDg57TA5CIcDFioQBI2RPbLPMdr+NsO+zNvvJLTBkdgIh5ZQL00nmAmTa8U6PC/ou
         DfGWH4UtvtMQt9XyqEMdAZgngXoNU2/78ODjGQTn6uo21vdxGi5jC5pSCpLjY9Iseoef
         NuZrssycWTTITrnR49MeBTwLoIH+pMH37E7jnCirKUjD4W+jCMy4vzONxDcgjDmslwU9
         kGsA==
X-Gm-Message-State: AOAM530+83bbGQHyCt8LrUu2o5JLF0h7H9ItF+qUq459NhZEWane0pc1
        WxPTq6koygwGSlE5Q0x7AfdfQTYzGFE3sUxbKaopUQ==
X-Google-Smtp-Source: ABdhPJz/2pLLSsdzKGYDOEWU6C7XBwNNdqtewYhCG150JXIDNw0HI9Mc3Gd3JLdKfCoBH55qIbi7jYEQrJ2MVaF1rA8=
X-Received: by 2002:a62:18d6:0:b029:1bf:1c5f:bfa4 with SMTP id
 205-20020a6218d60000b02901bf1c5fbfa4mr12062685pfy.24.1611777395982; Wed, 27
 Jan 2021 11:56:35 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009bbb7905b9e4a624@google.com> <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
 <20210127171453.GC358@willie-the-truck> <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
 <CAAeHK+yWe_GRDi8j7aPZAauTrfdjgYpYoj9F_KrsG3vtHDwTsw@mail.gmail.com>
 <CACT4Y+bSUnXoB_GtaFG7Vhe3bDr5MY6ZWdvcvw=uy+4-ZD7B-A@mail.gmail.com>
 <CAAeHK+xx7sGZPbSmZ1k0F31=V=zCAqdsh7jd-rjWLO6wJWdV4w@mail.gmail.com> <CACT4Y+Y=4yYf1qXxRkNdxHfZU89sRMxwT9JN8_irwGK8mTsZLw@mail.gmail.com>
In-Reply-To: <CACT4Y+Y=4yYf1qXxRkNdxHfZU89sRMxwT9JN8_irwGK8mTsZLw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 27 Jan 2021 20:56:24 +0100
Message-ID: <CAAeHK+wDz8aSLyjq1b=q3+HG9aJXxwYR6+gN_fTttMN5osM5gg@mail.gmail.com>
Subject: Re: WARNING in __do_kernel_fault
To:     Dmitry Vyukov <dvyukov@google.com>, Will Deacon <will@kernel.org>
Cc:     syzbot <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 8:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > > > This happens on arm64 instance with mte enabled.
> > > > > > > There is a GPF in reiserfs_xattr_init on x86_64 reported:
> > > > > > > https://syzkaller.appspot.com/bug?id=8abaedbdeb32c861dc5340544284167dd0e46cde
> > > > > > > so I would assume it's just a plain NULL deref. Is this WARNING not
> > > > > > > indicative of a kernel bug? Or there is something special about this
> > > > > > > particular NULL deref?
> > > > > >
> > > > > > Congratulations, you're the first person to trigger this warning!
> > > > > >
> > > > > > This fires if we take an unexpected data abort in the kernel but when we
> > > > > > get into the fault handler the page-table looks ok (according to the CPU via
> > > > > > an 'AT' instruction). Are you using QEMU system emulation? Perhaps its
> > > > > > handling of AT isn't quite right.
> > > > >
> > > > > Hi Will,
> > > > >
> > > > > Yes, it's qemu-system-aarch64 5.2 with -machine virt,mte=on -cpu max.
> > > > > Do you see any way forward for this issue? Can somehow prove/disprove
> > > > > it's qemu at fault?
> > > >
> > > > I've reproduced this crash (by taking [1] and changing
> > > > sys_memfd_create to 279), but it manifests as a normal null-ptr-deref
> > > > for me. I'm using the latest QEMU master. Which QEMU does syzbot use
> > > > exactly?
> > >
> > > qemu-system-aarch64 5.2 from this container:
> > > https://github.com/google/syzkaller/blob/master/tools/docker/syzbot/Dockerfile
> > > you can get a prebuilt version with:
> > > docker pull gcr.io/syzkaller/syzbot
> >
> > Reproduced with this QEMU, still a normal null-ptr-deref. Where do I
> > find the full list of arguments that are passed to QEMU on syzbot?
>
> I am yet to document all details of these new instances, but the
> syzkaller config contains:
> "qemu_args": "-machine
> virt,virtualization=on,mte=on,graphics=on,usb=on -cpu max"
> the rest are in vm/qemu/qemu.go

OK, the virtualization=on part is what causes this. Bug in QEMU?
