Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5413F3804
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 04:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhHUCMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 22:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhHUCMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 22:12:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E8AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:11:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l24so9025675qtj.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gOO2S7Mv0HOYYeN5193uyMUGfsmPjSlzi2OFU8Y+fo=;
        b=L8bsYCZr6W6WOVgqBP0nhp9qabhe3vp0nXQEfWFvEEp2V3ftXg/ZVGt48988QCyJSN
         g25s9q0q+k+UI5gdlyy9fDtxUQoosqOy3QODvoWrq8d0AnMZhf1sxLSuZPst5G6XO6xG
         2hwDr+08s5ajJotnhZDie1AgvEX74LQd6O7wpL3SXiNZ44td+ePm+EA7aFhW04nhLXm7
         uXG5PwIm36yZVEfQh3e28iJymNdJctSE/4a3tpCFmkjnzZ3fpIulLnS+f1cVjo0KlD1s
         Jizp09BdIWghNYDyA/mEQ/CDqEyNTeKUZdu8AFvQ7PyKOUsUIjvlHXPIXPdetrTN/ykm
         5nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gOO2S7Mv0HOYYeN5193uyMUGfsmPjSlzi2OFU8Y+fo=;
        b=FAHKzb9g7NnoVqK8jzy804v5+wuj2CdEOGt/+F22AOiDFIGEZOipT3khBQfmCooQnc
         d+ignaq+xIrHEwy6Fj3nA/n3vErtc967ftbr4xUS0Cl+4wNM9XsxZeiKQ/rQMPDvQY2u
         UkMFUrsEvCVaU2a3F6hLcMvGvjHGxd80ZnZD/aXYCmB6R1X+xTbymoHR5+b4K9VJMC2O
         nAAx0kPWf7mIR+9DLeuuGUk3htoweE/hXsFhxEWDmnWPEfEkGYMdi/cl9V+It57lGYHW
         n1VCWeT4Fo95sFgQlM37OEtvuF4/kzdMYRIJCLk3MNw3AypvU1aLWz+SKWO/DjryK811
         Zo6w==
X-Gm-Message-State: AOAM531eKPipFEX4EYIs9uV3wWKCEmAs8jmf+SEMqo5t3Q0IJRmt/y6H
        a6iPGI0akmrZRt5wYT+dcYeI/RP29P08yhKUA3f8pQ==
X-Google-Smtp-Source: ABdhPJxvczIWQNg+cxCoCUPQp8oANeSbmnqZtLwQvuXY+SvSo6y+6aTdmCOV51JpAiZA3j9p/g2HEN6baPINaTMxVno=
X-Received: by 2002:a05:622a:488:: with SMTP id p8mr20558647qtx.159.1629511917617;
 Fri, 20 Aug 2021 19:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210818053908.1907051-1-mizhang@google.com> <20210818053908.1907051-2-mizhang@google.com>
In-Reply-To: <20210818053908.1907051-2-mizhang@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Fri, 20 Aug 2021 19:11:46 -0700
Message-ID: <CAA03e5Ggh4gODFspxcXAU6WRe0aMCvkG794JpwvyBf6ERs_6dA@mail.gmail.com>
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

On Tue, Aug 17, 2021 at 10:39 PM Mingwei Zhang <mizhang@google.com> wrote:
>
> sev_decommission is needed in the error path of sev_bind_asid. The purpose
> of this function is to clear the firmware context. Missing this step may
> cause subsequent SEV launch failures.
>
> Although missing sev_decommission issue has previously been found and was
> fixed in sev_launch_start function. It is supposed to be fixed on all
> scenarios where a firmware context needs to be freed. According to the AMD
> SEV API v0.24 Section 1.3.3:
>
> "The RECEIVE_START command is the only command other than the LAUNCH_START
> command that generates a new guest context and guest handle."
>
> The above indicates that RECEIVE_START command also requires calling
> sev_decommission if ASID binding fails after RECEIVE_START succeeds.
>
> So add the sev_decommission function in sev_receive_start.
>
> Cc: Alper Gun <alpergun@google.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: David Rienjes <rientjes@google.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Vipin Sharma <vipinsh@google.com>
>
> Fixes: af43cbbf954b ("KVM: SVM: Add support for KVM_SEV_RECEIVE_START command")
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/svm/sev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 75e0b21ad07c..55d8b9c933c3 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1397,8 +1397,10 @@ static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
>
>         /* Bind ASID to this guest */
>         ret = sev_bind_asid(kvm, start.handle, error);
> -       if (ret)
> +       if (ret) {
> +               sev_decommission(start.handle);
>                 goto e_free_session;
> +       }
>
>         params.handle = start.handle;
>         if (copy_to_user((void __user *)(uintptr_t)argp->data,
> --
> 2.33.0.rc1.237.g0d66db33f3-goog

Should this patch have the following Fixes tag?

Fixes: af43cbbf954b ("KVM: SVM: Add support for KVM_SEV_RECEIVE_START command")

Reviewed-by: Marc Orr <marcorr@google.com>
