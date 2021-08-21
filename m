Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5453F381A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 04:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbhHUCbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 22:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhHUCbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 22:31:37 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A30C061757
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:30:58 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y144so12891121qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooK0DyFfmJ4kDNoGRhTDLo5fbQ6yVEecKkqRgMQgWQQ=;
        b=ITmJh1iiIU25AZkkFiZ5AE7BFomVpuseXmmGmKgpouePfNV5ggDB6cjrFuu4TLD9lC
         5+ZO+FOVYnmxA1fSDV2SCW24GaQKPhgEIgMUYAU+0RYOlY/dzN2EglyhdXlfkjtxZnMW
         zuSuoS146oCPgzF0wDQErFxcWP2FoBFOVojWvmPvgRoo8FUxNkBaOfPqn10Vj/+e0xRl
         bxU6yvs25fr48KK6gFeCup+KgI8uT+Si4t22ntUzVFdKaLBDM04odzk2f4WOFyfkzAqW
         0RGCG5fMfZQzGOIyCozL/ERUFuu2D3TYN1LTJtpT1LcwsP/08TC8ReaVLCtbOkMEdhUJ
         yZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooK0DyFfmJ4kDNoGRhTDLo5fbQ6yVEecKkqRgMQgWQQ=;
        b=ZYJrnqUw8osrOgO57pD0fjYMXMUelauuUo9sgyVgdtOQGEFpAkQpfYdY7wg/lTQ7jS
         naAsgVlE96nbMVU+4JEJ2Aq2OYWeFVXavATKohgIrH6XRT/g+gup//XjnsjRxS0otP+o
         4PJDW91Tz2sOOieCwzn7kZNKKPbBlal06GeNf2Lb9gsUCEpZ1/H9oFTxiMOtrjs3krWD
         4AYliSrm6E9MtXRft61BTfm9O/E5uUtj+XLJh8k4jwHJZjezFMPnmMWZL/SkONxhOpcQ
         q5gYmaQQaUSadMwxVp+hkT0z8y52GdhOXFOerx+yt/rW+fjlcwg2tbL+GoHRQIh66Gk3
         hSNA==
X-Gm-Message-State: AOAM530F/PNo6/B84CXhvvq6P5XlvRWthhaQ4OL+A2hwIsL9j2ra26eN
        o+Aj0WvpyarctGeu52NjQFkGHJ9yxQemKpBh3lLNKg==
X-Google-Smtp-Source: ABdhPJzBI82AFlgMq6F3duk+Ox7U+VZVLJIBJLMMC9ts2qnK5WoE03gPHQK+On/4y9/yEHLF9jq/aA05TDO1hUQN2cA=
X-Received: by 2002:a37:45c9:: with SMTP id s192mr12038137qka.21.1629513057515;
 Fri, 20 Aug 2021 19:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210818053908.1907051-1-mizhang@google.com> <20210818053908.1907051-2-mizhang@google.com>
 <CAA03e5Ggh4gODFspxcXAU6WRe0aMCvkG794JpwvyBf6ERs_6dA@mail.gmail.com>
In-Reply-To: <CAA03e5Ggh4gODFspxcXAU6WRe0aMCvkG794JpwvyBf6ERs_6dA@mail.gmail.com>
From:   Marc Orr <marcorr@google.com>
Date:   Fri, 20 Aug 2021 19:30:46 -0700
Message-ID: <CAA03e5G9LKJjJuVD3aPT-nVj58MLeXPDuPqEfnjBeWh9eC=SAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: SVM: fix missing sev_decommission in sev_receive_start
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alper Gun <alpergun@google.com>,
        Borislav Petkov <bp@alien8.de>,
        David Rienjes <rientjes@google.com>,
        Peter Gonda <pgonda@google.com>,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:11 PM Marc Orr <marcorr@google.com> wrote:
>
> On Tue, Aug 17, 2021 at 10:39 PM Mingwei Zhang <mizhang@google.com> wrote:
> >
> > sev_decommission is needed in the error path of sev_bind_asid. The purpose
> > of this function is to clear the firmware context. Missing this step may
> > cause subsequent SEV launch failures.
> >
> > Although missing sev_decommission issue has previously been found and was
> > fixed in sev_launch_start function. It is supposed to be fixed on all
> > scenarios where a firmware context needs to be freed. According to the AMD
> > SEV API v0.24 Section 1.3.3:
> >
> > "The RECEIVE_START command is the only command other than the LAUNCH_START
> > command that generates a new guest context and guest handle."
> >
> > The above indicates that RECEIVE_START command also requires calling
> > sev_decommission if ASID binding fails after RECEIVE_START succeeds.
> >
> > So add the sev_decommission function in sev_receive_start.
> >
> > Cc: Alper Gun <alpergun@google.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: David Rienjes <rientjes@google.com>
> > Cc: Marc Orr <marcorr@google.com>
> > Cc: John Allen <john.allen@amd.com>
> > Cc: Peter Gonda <pgonda@google.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Vipin Sharma <vipinsh@google.com>
> >
> > Fixes: af43cbbf954b ("KVM: SVM: Add support for KVM_SEV_RECEIVE_START command")
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  arch/x86/kvm/svm/sev.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 75e0b21ad07c..55d8b9c933c3 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -1397,8 +1397,10 @@ static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
> >
> >         /* Bind ASID to this guest */
> >         ret = sev_bind_asid(kvm, start.handle, error);
> > -       if (ret)
> > +       if (ret) {
> > +               sev_decommission(start.handle);
> >                 goto e_free_session;
> > +       }
> >
> >         params.handle = start.handle;
> >         if (copy_to_user((void __user *)(uintptr_t)argp->data,
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
>
> Should this patch have the following Fixes tag?
>
> Fixes: af43cbbf954b ("KVM: SVM: Add support for KVM_SEV_RECEIVE_START command")

Oops. I missed that it already has the Fixes tag. Please ignore this comment.
