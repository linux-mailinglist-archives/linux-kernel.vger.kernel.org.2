Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5644B330
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243216AbhKIT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243202AbhKIT3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:29:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB5C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:26:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o8so814321edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 11:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ei0IjmYjF3Cz9j83zRSEUli+MBWkuUhizQs40K0x/A0=;
        b=jGcnUHEBsbodZFjwpoerQJ8EjsqCv3BcE+rQKXLFvhGfEL5lR0Zp2ogTeibupQhGvj
         CVqSXfL3y1szo+7gDT3kXSHAdIjM1a+zcto4+Rt0wevVKaRgDekNGHyd/D5neWOxrWf4
         EcGTlio1t/2hzh0opontENyuvQQDdBEByBCP2P4s0/nyv3Te+Ly/UqHh40z5JnV3Ji6t
         aQp+JDj0BkAWqHBtx8XjGweXL00rLKzYiDYANdD+RFTmx4DUTCSlpNiIy6Rip1sDo5X6
         IiklCrcmB3KDXrDhsIdc6GMHVX8okMG/jKqWo31KaOM2Z/iXCjisWP6Iq01VFbaVQzmU
         PkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ei0IjmYjF3Cz9j83zRSEUli+MBWkuUhizQs40K0x/A0=;
        b=p6GVbV/u9F+xxtXUEAY9VRzkx886PL6wxn506E5zXQS3093aUX2NGtQVBO+dwCBXCT
         rabO0RgLLDqM5UxtcfeLwgNxZFrz76jg0rc7NZB8J0eUH9jqEKEK9b0hbMpdJXZ2+8ml
         Ct88ym4TXfwCv99SyLT6GYzb1m+fH6mdHQaK7A0PK+h+LtDFFEww5pQXCesqK+ZEp6Cb
         +jhhX/US43tJRFA0UZAklZPAnWBFQf9/tsEF+x7lh/dmnQNIeMST2QJk2vam+2Rm49zf
         5XIz9TCrtLsrR7XYzRxn3UTBH77iZHc/Fpb5pdiqiqAAh8X4Fb+UszEYqC/I/ZbGqJyc
         X7EA==
X-Gm-Message-State: AOAM533F4m1r33KO+IAyQ+YQyowwJJzq9djZbta1qouOjS1a/N2fUCG/
        IhTV54uCIt4hyzZOtFxoOhlM3sNWkXydy0egx7FvAg==
X-Google-Smtp-Source: ABdhPJwjK0u0YQgI9Skl7GNuwhYEODMuBizImSvfAkYub3lLSu7HgvJZMiP17xU2OCxtdiCKXQU8aNVQLIccXSoZ3Eg=
X-Received: by 2002:a50:e184:: with SMTP id k4mr13491532edl.217.1636485995403;
 Tue, 09 Nov 2021 11:26:35 -0800 (PST)
MIME-Version: 1.0
References: <CADyq12yY25-LS8cV5LY-C=6_0HLPVZbSJCKtCDJm+wyHQSeVTg@mail.gmail.com>
 <cb682c8a-255e-28e5-d4e0-0981c2ab6ffd@intel.com> <85925a39-37c3-a79a-a084-51f2f291ca9c@intel.com>
 <CADyq12y0o=Y1MOMe7pCghy2ZEV2Y0Dd7jm5e=3o2N4-i088MWw@mail.gmail.com>
 <472b8dbf-2c55-98c9-39ad-2db32a649a20@intel.com> <CADyq12whSxPdJhf4qg_w-7YXgEKWx4SDHByNBNZbfWDOeEY-8w@mail.gmail.com>
 <649f4de7-3c91-4974-9af7-d981a2bf6224@www.fastmail.com> <CADyq12wXzitT4y38fUjiWq_Rq4AWQX4Z05Qpyuu-dNBzQc8Gmg@mail.gmail.com>
In-Reply-To: <CADyq12wXzitT4y38fUjiWq_Rq4AWQX4Z05Qpyuu-dNBzQc8Gmg@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 9 Nov 2021 14:25:59 -0500
Message-ID: <CADyq12yeSpsbty+qkdQz16Jy-==dXxYKoew_7TB9y9pnyFwA3A@mail.gmail.com>
Subject: Re: XSAVE / RDPKRU on Intel 11th Gen Core CPUs
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <groeck@google.com>,
        Borislav Petkov <bp@suse.de>, stable@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 1:58 PM Brian Geffon <bgeffon@google.com> wrote:
>
> Hi Andy,
>
> On Tue, Nov 9, 2021 at 9:58 AM Andy Lutomirski <luto@kernel.org> wrote:
> > Here's an excerpt from an old email that I, perhaps unwisely, sent to D=
ave but not to a public list:
> >
> > static inline void write_pkru(u32 pkru)
> > {
> >         struct pkru_state *pk;
> >
> >         if (!boot_cpu_has(X86_FEATURE_OSPKE))
> >                 return;
> >
> >         pk =3D get_xsave_addr(&current->thread.fpu.state.xsave,
> > XFEATURE_PKRU);
> >
> >         /*
> >          * The PKRU value in xstate needs to be in sync with the value
> > that is
> >          * written to the CPU. The FPU restore on return to userland wo=
uld
> >          * otherwise load the previous value again.
> >          */
> >         fpregs_lock();
> >         if (pk)
> >                 pk->pkru =3D pkru;
> >
> > ^^^
> > else we just write to the PKRU register but leave XINUSE[PKRU] clear on
> > return to usermode?  That seems... unwise.
> >
> >         __write_pkru(pkru);
> >         fpregs_unlock();
> > }
> >
> > I bet you're hitting exactly this bug.  The fix ended up being a whole =
series of patches, but the gist of it is that the write_pkru() slow path ne=
eds to set the xfeature bit in the xsave buffer and then do the write.  It =
should be possible to make a little patch to do just this in a couple lines=
 of code.
>
> I think you've got the right idea, the following patch does seem to
> fix the problem on this CPU, this is based on 5.13. It seems the
> changes to asm/pgtable.h were not enough, I also had to modify
> fpu/internal.h to get it working properly.
>

Actually, it seems that only the changes to fpu/internal.h seem
necessary. I guess the switch_fpu_finish explains how it's reverting
to the initial value.

diff --git a/arch/x86/include/asm/fpu/internal.h
b/arch/x86/include/asm/fpu/internal.h
index 16bf4d4a8159..ed2ce7d1afeb 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -564,18 +564,16 @@ static inline void switch_fpu_finish(struct fpu *new_=
fpu)
         * PKRU state is switched eagerly because it needs to be valid befo=
re we
         * return to userland e.g. for a copy_to_user() operation.
         */
-       if (!(current->flags & PF_KTHREAD)) {
-               /*
-                * If the PKRU bit in xsave.header.xfeatures is not set,
-                * then the PKRU component was in init state, which means
-                * XRSTOR will set PKRU to 0. If the bit is not set then
-                * get_xsave_addr() will return NULL because the PKRU value
-                * in memory is not valid. This means pkru_val has to be
-                * set to 0 and not to init_pkru_value.
-                */
-               pk =3D get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU)=
;
-               pkru_val =3D pk ? pk->pkru : 0;
-       }
+       /*
+        * If the PKRU bit in xsave.header.xfeatures is not set,
+        * then the PKRU component was in init state, which means
+        * XRSTOR will set PKRU to 0. If the bit is not set then
+        * get_xsave_addr() will return NULL because the PKRU value
+        * in memory is not valid. This means pkru_val has to be
+        * set to 0 and not to init_pkru_value.
+        */
+       pk =3D get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
+       pkru_val =3D pk ? pk->pkru : 0;
        __write_pkru(pkru_val);
 }
