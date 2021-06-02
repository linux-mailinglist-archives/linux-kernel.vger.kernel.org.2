Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9388397E16
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFBBgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFBBgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:36:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 18:34:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cb9so925298edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 18:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzQRMvD+3GTyeQsWjmhKf7su1vPqupNvqasfaYdmnEM=;
        b=Tlie0Y+iuMMFltqLLt6YrYeS9DGu33VbHvstCQYs0hOXeC8JSYpuPKLjS6qY/pDd7d
         W7QTp7v8Ma7NUoSNrDNqAwaxaG9AkEwtBZaDJ1ArEdzn+3T6a3w6OKYElLElx/+W7vsP
         ZuzJq+uZJ+LNJ6GOs7htiUpOUh5L16uZHgLdhRO3w0qIUokTYCUkfKWeWn/NFoe7Sa2/
         bUJCGx7Dt43t2aSovWG8oiDfV134+gkAdW3aqBmba8550lahmzQ3ToqQKog9UKi1VhpI
         LX1Ld2YyU9oExkI5gvEDMBVMtPKNVflrmybQq3ULmADrtL5HsajbOK6y8FyiMshojfVE
         XRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzQRMvD+3GTyeQsWjmhKf7su1vPqupNvqasfaYdmnEM=;
        b=sQjJF2m1IvJTKoaYWjI07gbW9VI3ANYHh74dH5Cu/TmKPY9154bU8FqyuiKzFGlH2U
         j961RT1Rv6a4G9beib4hpnhsLyUTLp3N6NpS3r8k0s1VGNLHKBTUsjVohuYoRzX6AXkl
         0fSmO6AawQZR5tXoK1rHoyxYt0Ikq8rLsX2hOb972o6SI1+7Th+JWuCe1U0gQjK/aFld
         ARTE8f6BIlPYtTpnstunBu+QtWZMZxmyhTqa7gaIcmQlz9dcJETb5psJkzUad65wer/s
         eAQnqZ6CBmwsYAbe37DL0X7tf27H8SN+9pOEInXkV4V9GjJh/tIBP5JdgxWMSR5MdaDE
         hc3Q==
X-Gm-Message-State: AOAM531zClsmb3vB8cqkXCHNvNzP6PKE5Edin6MMrSJZc2s6q1SrbJDm
        7J6vNmIU/u56J5NtFSkOz334LMRow6uwyTU8XiDHVg==
X-Google-Smtp-Source: ABdhPJzJBLev2U/cTkcAahBZDqG98LlZAJfadAqq8754ugipQmIGWvT2RI9yxn+JEBFHT9mqfGvTyPSXtsPca+jZRrk=
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr35404936edd.26.1622597667909;
 Tue, 01 Jun 2021 18:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
 <20210527150526.271941-5-pasha.tatashin@soleen.com> <87pmx52212.wl-maz@kernel.org>
In-Reply-To: <87pmx52212.wl-maz@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 1 Jun 2021 21:33:52 -0400
Message-ID: <CA+CK2bChDqMKGAG8_rEigWcXRaBN=rnuV_WLnU=1TPjJRtpc5A@mail.gmail.com>
Subject: Re: [PATCH 04/18] arm64: kernel: add helper for booted at EL2 and not VHE
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 8:38 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 27 May 2021 16:05:12 +0100,
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > Replace places that contain logic like this:
> >       is_hyp_mode_available() && !is_kernel_in_hyp_mode()
> >
> > With a dedicated boolean function  is_hyp_callable(). This will be needed
> > later in kexec in order to sooner switch back to EL2.
>
> This looks like the very definition of "run in nVHE mode", so I'd
> rather you call it like this, rather than "callable", which is
> extremely ambiguous (if running at EL2, I call it any time I want, for
> free).

Hi Marc,

Naming is hard. Are you proposing  s/is_hyp_callable/run_in_nvhe_mode/
? This is also not a very good name because it does not sound like a
boolean, but instead that we know that there is nvhe mode available
and we can switch to it.

>
> >
> > Suggested-by: James Morse <james.morse@arm.com>
> >
> > [Fixed merging issues]
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/include/asm/virt.h | 5 +++++
> >  arch/arm64/kernel/cpu-reset.h | 3 +--
> >  arch/arm64/kernel/hibernate.c | 9 +++------
> >  arch/arm64/kernel/sdei.c      | 2 +-
> >  4 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> > index 7379f35ae2c6..4216c8623538 100644
> > --- a/arch/arm64/include/asm/virt.h
> > +++ b/arch/arm64/include/asm/virt.h
> > @@ -128,6 +128,11 @@ static __always_inline bool is_protected_kvm_enabled(void)
> >               return cpus_have_final_cap(ARM64_KVM_PROTECTED_MODE);
> >  }
> >
> > +static inline bool is_hyp_callable(void)
> > +{
> > +     return is_hyp_mode_available() && !is_kernel_in_hyp_mode();
> > +}
>
> nit: consider switching the two members of the expression so that you
> don't have extra memory accesses when running at EL2.

Sure, I will do that.


> > -/* Do we need to reset el2? */
> > -#define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
> > -
>
> Please keep the macro, as it explains *why* we're doing things (we
> need to reset EL2), and replacing it with a generic macro drops the
> documentation aspect.

OK, I will keep the macro, and redefine it to use the common macro.

Thank you,
Pasha
