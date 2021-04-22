Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D123D3686E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbhDVTDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVTDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:03:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69059C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:02:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m11so32388966pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDg1aD567r790FBm59yB32VSiEfP4a8Vhdm7ZOlyWSE=;
        b=euriQQ4HYSFTyle9ZIz/Kj+95qPHjc2RZKOpm3tx0GJHl/9ATsgit+ukV1RHMcsY+o
         VgcXzxUWzvwNiNMDlkacK9TYjHIlgQ5l7gRHNTCXoKNiyqKvuTSD8/tGVxYqsuFJIoh8
         xewigEVoIBgO1oy8w/w0xAWDmlZk9uwJYVRStiGpW2DMuqgNz3y7Y6Qc7Ks4gT0TVF9L
         CeT0d/7onAzaaPsTeMFZeC3xaVyRUEOY2n//UXefJuaXEptg09gzeXyhiv3n8jPQ9qyQ
         qlLhA3VpG8NM42Y8DrIUy3f90XGk8N7XBLm0CW3ZiFUWUK98Kf85Zp784WBU3pt1T3VR
         YaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDg1aD567r790FBm59yB32VSiEfP4a8Vhdm7ZOlyWSE=;
        b=AumGMgcNLr7VABLWNyRKXbCsXWDSTKPdVcpivaLlG8+Nptgip8KB3jreqsYnZ0p+y/
         JvD0wXw+hvlHvpQJOXzUnqH/dbYIMOBFGigvEdZubfbRPLGg0WgJ5HzQKw+HlFKqB/ht
         bPqe957lbMgk3gMJeZRz/M2QhGOWKSYJDT6B72zY3nnk6nv6PYcYozs31a+jYK6n6yWp
         KTuq1m5sxb8UXmJ717vAXWhMg0l/QcfR5xj119DjumJus6c29JYJ/RrXfSYhb159y0qV
         Q1vKFNZ1BFrre97D+faoGmIVf/CwjG87JlNqU9Bi1qW5QAaMyAmE24PxLMCelo/pthHU
         RHtw==
X-Gm-Message-State: AOAM532vP0HAIFjWVkafIZm5v9HIduJ5Umq2AZXG2xGtTa15njCmEuR2
        8HDCFgMpL02nCX3Tsm4SkhzY7neGPoIJ2IiSbkGegw==
X-Google-Smtp-Source: ABdhPJzu+LO3Vq6UjOF9vfqE0F/kGHQOn08KBci7pvBqj26HJBSZceKpfo1pqUr72AxVxlJW2tbmIhRvhi1UB74GV8I=
X-Received: by 2002:aa7:91d1:0:b029:1fe:2a02:73b9 with SMTP id
 z17-20020aa791d10000b02901fe2a0273b9mr81424pfa.2.1619118160718; Thu, 22 Apr
 2021 12:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210422001736.3255735-1-seanjc@google.com>
In-Reply-To: <20210422001736.3255735-1-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Thu, 22 Apr 2021 12:02:24 -0700
Message-ID: <CAAeT=FxaRV+za7yk8_9p45k4ui3QJx90gN4b8k4egrxux=QWFA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: SVM: Delay restoration of host MSR_TSC_AUX until
 return to userspace
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@@ -2893,12 +2882,15 @@ static int svm_set_msr(struct kvm_vcpu *vcpu,
struct msr_data *msr)
                        return 1;

                /*
-                * This is rare, so we update the MSR here instead of using
-                * direct_access_msrs.  Doing that would require a rdmsr in
-                * svm_vcpu_put.
+                * TSC_AUX is usually changed only during boot and never read
+                * directly.  Intercept TSC_AUX instead of exposing it to the
+                * guest via direct_acess_msrs, and switch it via user return.
                 */

'direct_acess_msrs' should be 'direct_access_msrs'.


                svm->tsc_aux = data;
-               wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
+
+               preempt_disable();
+               kvm_set_user_return_msr(TSC_AUX_URET_SLOT, data, -1ull);
+               preempt_enable();
                break;

One of the callers of svm_set_msr() is kvm_arch_vcpu_ioctl(KVM_SET_MSRS).
Since calling kvm_set_user_return_msr() looks unnecessary for the ioctl
case and makes extra things for the CPU to do when the CPU returns to
userspace for the case, I'm wondering if it might be better to check
svm->guest_state_loaded before calling kvm_set_user_return_msr() here.

The patch looks good to me other than those two minor things.

Thanks,
Reiji
