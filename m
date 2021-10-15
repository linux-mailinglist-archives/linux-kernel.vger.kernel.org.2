Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D16C42FA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbhJORsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbhJORsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:48:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143FC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:46:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y15so44945195lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3liRWXWYS1s+kXeJAAKWiMsrJmxBJ1cDV26MMJDbes=;
        b=TnW3ABm0OVJvzPER3UibMgD2tHUWx8hIodouprolo1pQ2KcV7bKQL0W76OF0nQEwqE
         CS3avdCajvbDwFOzmCvQPcnST3AY2ZA/5G+9H2pleAT2YuPCvd4fuoawZVYTRA5cZzky
         NxeAh/qHsMmAgiFUrOw3qxRPCXYMZRbNLKyjci1/8UHRom3LINvZy//ZR90Pqj40D5ng
         wS98C3Aempy+c/KSaPERJlrPKcf6KVYJuFS4TDM6TsbFL4sVXVjbZOshphSqehtntNIa
         U/JPGmgTOdvddKiYJ/HZlKbiOtYhavrEuetc1ZTDMC/BwmQESrsbJNQzJ+AgUx3vFr+n
         f/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3liRWXWYS1s+kXeJAAKWiMsrJmxBJ1cDV26MMJDbes=;
        b=RfLvBeZPCSQigWcSUxNJnZx3ZUj9+JE0Xp88rxzYTvZK0SzUNdoJ4WZSNXkoacGO3E
         u9jqjW4S7ZfrV4i7yw4EtqDOWethbprlXHc7xUL1W8McFe617izGfijgAU8JnWwDCSPC
         8wPiZUX9vDCO2jJTQ34385cIPvWCQFNIDX83Ajiol41g9Wyw6DYIKFPLuXQBxl3FQfPA
         enkq15gufNXIvbgvhzXttErkd3FH0OF0EnhuGVa5xcMrTrmH5qfO7JiAI7nhXiu370EM
         s9Fc28hhE14p8XFML/UWN5zoTvj1PmmN4tUbiURmS6OyZz7vojbF/ugd8TebcFnMYEJc
         SPOA==
X-Gm-Message-State: AOAM533j62f4IpYV4UI4sAuPGnoa2Bv+EfbxIUOW5zQL8SI9/djEWUnI
        tR6M4V/gPNRQlu52s3nbfQ0xv3f9DdWLCsnxLSCLyw==
X-Google-Smtp-Source: ABdhPJzy6SjwnBkv257ZaQikJimUQZzZ6gtTxUBcl0CKOc48sbCnffXN2ruUTxquuXfacw9kpNhJsKXPMQBRIts8KKk=
X-Received: by 2002:a05:6512:398f:: with SMTP id j15mr11738210lfu.523.1634319997584;
 Fri, 15 Oct 2021 10:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211015085148.67943-1-pbonzini@redhat.com> <YWmuPOB6/rXWqXBH@archlinux-ax161>
In-Reply-To: <YWmuPOB6/rXWqXBH@archlinux-ax161>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Oct 2021 10:46:25 -0700
Message-ID: <CAKwvOdmnHYRqGxgx+G-_nAMC4ViYxYtTX4JMZ8b3YdXCrj=5tw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: avoid warning with -Wbitwise-instead-of-logical
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, seanjc@google.com, torvic9@mailbox.org,
        Jim Mattson <jmattson@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 9:37 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Oct 15, 2021 at 04:51:48AM -0400, Paolo Bonzini wrote:
> > This is a new warning in clang top-of-tree (will be clang 14):
> >
> > In file included from arch/x86/kvm/mmu/mmu.c:27:
> > arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
> >         return __is_bad_mt_xwr(rsvd_check, spte) |
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                                                  ||
> > arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning
> >
> > Reported-by: torvic9@mailbox.org
> > Suggested-by: Jim Mattson <jmattson@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Link: https://github.com/ClangBuiltLinux/linux/issues/1474
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> > ---
> >  arch/x86/kvm/mmu/spte.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> > index eb7b227fc6cf..32bc7268c9ea 100644
> > --- a/arch/x86/kvm/mmu/spte.h
> > +++ b/arch/x86/kvm/mmu/spte.h
> > @@ -314,9 +314,12 @@ static __always_inline bool is_rsvd_spte(struct rsvd_bits_validate *rsvd_check,
> >        * Use a bitwise-OR instead of a logical-OR to aggregate the reserved
> >        * bits and EPT's invalid memtype/XWR checks to avoid an extra Jcc
> >        * (this is extremely unlikely to be short-circuited as true).
> > +      *
> > +      * (int) avoids clang's "use of bitwise '|' with boolean operands"
> > +      * warning.
> >        */
> > -     return __is_bad_mt_xwr(rsvd_check, spte) |
> > -            __is_rsvd_bits_set(rsvd_check, spte, level);
> > +     return (int)__is_bad_mt_xwr(rsvd_check, spte) |
> > +            (int)__is_rsvd_bits_set(rsvd_check, spte, level);
> >  }
> >
> >  static inline bool spte_can_locklessly_be_made_writable(u64 spte)
> > --
> > 2.27.0
> >
> >
>


-- 
Thanks,
~Nick Desaulniers
