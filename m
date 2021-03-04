Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C10532DBBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhCDV0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCDV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:26:34 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE1EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 13:25:53 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a9so18395uat.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCwoe+nr6h8/KUCkhmMjNpvzna+/assXUeU6NY8XPQw=;
        b=qNfhikGP/Y+wem+C6aP2zxL/0tWtf9IiSe6JA9ksOlB1STeGcs3MOep8E8xqEXHUUV
         08n7jU8Ti46BVhcBp5UcIw1VhqPrNv+3tFzjpM0dcg2rtOrTDbvjkRhq+atik1A0mWBa
         w9Vl0ueK6N/SLNESzCtvoaVKG8DSYp94p5JXIHT+uUvbqxpFeEBR6dbugzDA2WyYEHpx
         NEf1lXg3klrbeaHNWugn/3ftddgDTXgGBPxAAIusRbhizy+RPdxBP6JziO28z8fP6HBZ
         l88Zi3sMqiDBdiaxwWiLlDzhK4zNFu8tuKOF3ZbE6D0PSfR8mVWzp6QTuujWkyTQld/h
         P9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCwoe+nr6h8/KUCkhmMjNpvzna+/assXUeU6NY8XPQw=;
        b=Wv8r1fIiQjvCeiBX/s6EmzjN/7KjdI4GiEXxmWTCQ8Talmqn1k0M5UH5cl+/4GTW1S
         e8/78SkibL8jMxOqH5V1ml4eg3p95+pxMo7MzodJJQBYg4qWwc9ZGzqlVcDq77aU+aLX
         I4jBb5lvtnj3raP62/F6oIH6onHt7bZpNDlWSbT4JxOoUpIXVzSPRVemZX/lx04SPj3q
         YpkjTdTsYwLsAjv7mHlRgfs6WP4kS6Eaqh/aD67YHR7tenCaapcu6oB6iwiU7x77Pxpr
         AXylfknZRqR++mBTihJAbTVLwIG7BzJgrRvmvBzee8vaERlW1U6c1gNv/xG5+MzqahLY
         bkaw==
X-Gm-Message-State: AOAM530d8NBraVg6t4ZCi3MndJQ1nPcU6b/5xUEWw1QaHv4+jyiGYxiz
        wolb9F9ljWge87U03x2OtglxNg6nIjlEcM0AU1pUqw==
X-Google-Smtp-Source: ABdhPJy/oonaLJwQYkh03ssEj0zP6DykmvSGVfCb4vLaenGZYrlXd7G63N7OJvZ/l0mjcOAbE1mlQEK9CcmrkmWhq5E=
X-Received: by 2002:ab0:5ead:: with SMTP id y45mr3705042uag.33.1614893152797;
 Thu, 04 Mar 2021 13:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20210304184544.2014171-1-samitolvanen@google.com> <87k0qmzq5u.wl-maz@kernel.org>
In-Reply-To: <87k0qmzq5u.wl-maz@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 4 Mar 2021 13:25:41 -0800
Message-ID: <CABCJKufmjMT8+hGEnL3aJM7-OSwhYSHiJA=i8e7dHSGDWXYtsg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Disable LTO in hyp
To:     Marc Zyngier <maz@kernel.org>, Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 11:15 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 04 Mar 2021 18:45:44 +0000,
> Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
> > linker errors:
> >
> >   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
>
> I assume this message is only an oddity, right? Because
> __guest_enter() is as far as you can imagine from irqbypass.c...

I'm not sure what's up with the filename in the error message. Fangrui
or Nick probably have a better idea.

> >   relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
> >   [-1048576, 1048575]; references hyp_panic
> >   >>> defined in vmlinux.o
> >
> >   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21E0):
> >   relocation R_AARCH64_ADR_PREL_LO21 out of range: 2031200 is not in
> >   [-1048576, 1048575]; references hyp_panic
> >   >>> defined in vmlinux.o
> >
> > As LTO is not really necessary for the hypervisor code, disable it for
> > the hyp directory to fix the build.
>
> Can you shed some light on what the problem is exactly?

I assume hyp_panic() ends up being placed too far from __guest_enter()
when the kernel is large enough. Possibly something to do with LLVM
always splitting functions into separate sections with LTO. I'm not
sure why the linker cannot shuffle things around to make everyone
happy in this case, but I confirmed that this patch also fixes the
build issue for me:

diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index af8e940d0f03..128197b7c794 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -214,7 +214,7 @@ static void __hyp_call_panic(u64 spsr, u64 elr, u64 par)
 }
 NOKPROBE_SYMBOL(__hyp_call_panic);

-void __noreturn hyp_panic(void)
+void __noreturn hyp_panic(void) __section(".text")
 {
        u64 spsr = read_sysreg_el2(SYS_SPSR);
        u64 elr = read_sysreg_el2(SYS_ELR);

> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1317
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/arm64/kvm/hyp/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> > index 687598e41b21..e8116016e6a8 100644
> > --- a/arch/arm64/kvm/hyp/Makefile
> > +++ b/arch/arm64/kvm/hyp/Makefile
> > @@ -11,3 +11,6 @@ subdir-ccflags-y := -I$(incdir)                             \
> >                   $(DISABLE_STACKLEAK_PLUGIN)
> >
> >  obj-$(CONFIG_KVM) += vhe/ nvhe/ pgtable.o
> > +
> > +# Disable LTO for the files in this directory
> > +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
> >
> > base-commit: f69d02e37a85645aa90d18cacfff36dba370f797
>
> Can this be reduced to the nvhe part of the tree? The rest of the
> hypervisor should support being built with LTO, I'd expect. Or am I
> missing something more significant?

No, this error appears to be about hyp_panic() in the vhe code. While
I'm not sure how beneficial LTO is in hypervisor code, there shouldn't
be any other reason we can't use it there.

Sami
