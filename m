Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E3B3FE1CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346784AbhIASJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbhIASJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:09:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18266C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 11:08:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so305250pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yE8tcmnQlRJkc01OrA9qzGQH/BC22e0N905Nd/q0a5A=;
        b=mh1HFa3BDF9XsEzQwT2IgOMTU1lJ4iCmRyngLUo7jXJFb9BvG7iBgMxNtUubJ49zuv
         SB6D/BNHv4zvHAUlg8ujmYVlc3kd0h3kGIT/6E9GihkDNAz64wokdoVVkXn3GU+rgbXD
         jb3CztKFdKS96k1ZK7TQrOhaRAkKzaz4ps56ugtDVbZKDu7Wy9f89HWNxx7lQMOkP6Z3
         zkn5lf0nFkU1OVotasdkafDqhjWlRu6aclNSw+LPWLYI1Yq0O69iF9GjpjSniZU8Wf/s
         2QjU9mrvD32T//BGH3eRSOMdaj5aVPOxQRmrCl0/mE7BpCbJf3ClBSgTNHALMKuDvhD8
         +NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yE8tcmnQlRJkc01OrA9qzGQH/BC22e0N905Nd/q0a5A=;
        b=gkbt3a+/bdIp/LGsvL7K7Xq8XW/26x3c7SV16hdlIcVQHgM2WcpJZgNTGNL4lCCH3f
         1jM+qyliird6SZ100DfMrFDisJaOC59ATV0Ar4CBlP/qKHOzjDGnSsssKtA0Zdrv/Fek
         KDN/NEPmvhsD5EgW9FlfHn7EH1nRX7k/SqH60egts6cbskPl1kghIVDz6+cg+yk9jWQZ
         tddU2RQSlSwBNRtxV8rsfN1sYg3brGPSVndToZ9vmyc2uKzo6mr2VSj9X2rFeMSFhZiM
         uGl+B0801nwnooGEACLnQTeoFCUmUkzN+obG/6ZNTU0oQ0/l17WH2803QGsQ724MAGSZ
         FBRw==
X-Gm-Message-State: AOAM530xexWdWz1ckJK/Hmr904wzPSFysR9Iv2QWvJtCks43ENmoxmDE
        JOoNYxH/cICrrTZOJViX/p01ug==
X-Google-Smtp-Source: ABdhPJzgbcGlONSiOJrjgEmp15VZlZpb9iyDbFitWh2eTJuQj4QhvRFl9hllIBIDdul7S4FakyxxjQ==
X-Received: by 2002:a17:90a:9205:: with SMTP id m5mr688869pjo.172.1630519730398;
        Wed, 01 Sep 2021 11:08:50 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j16sm166837pfi.165.2021.09.01.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 11:08:49 -0700 (PDT)
Date:   Wed, 1 Sep 2021 18:08:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Fix nested bus lock VM exit
Message-ID: <YS/BrirERUK4uDaI@google.com>
References: <20210827085110.6763-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827085110.6763-1-chenyi.qiang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021, Chenyi Qiang wrote:
> Nested bus lock VM exits are not supported yet. If L2 triggers bus lock
> VM exit, it will be directed to L1 VMM, which would cause unexpected
> behavior. Therefore, handle L2's bus lock VM exits in L0 directly.
> 
> Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bc6327950657..754f53cf0f7a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5873,6 +5873,8 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
>  	case EXIT_REASON_VMFUNC:
>  		/* VM functions are emulated through L2->L0 vmexits. */
>  		return true;
> +	case EXIT_REASON_BUS_LOCK:
> +		return true;

Hmm, unless there is zero chance of ever exposing BUS_LOCK_DETECTION to L1, it
might be better to handle this in nested_vmx_l1_wants_exit(), e.g.

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b3f77d18eb5a..793534b7eaba 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6024,6 +6024,8 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
                        SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE);
        case EXIT_REASON_ENCLS:
                return nested_vmx_exit_handled_encls(vcpu, vmcs12);
+       case EXIT_REASON_BUS_LOCK:
+               return nested_cpu_has2(vmcs12, SECONDARY_EXEC_BUS_LOCK_DETECTION);
        default:
                return true;
        }

It's a rather roundabout way of reaching the same result, but I'd prefer to limit
nested_vmx_l0_wants_exit() to cases where L0 wants to handle the exit regardless
of what L1 wants.  This kinda fits that model, but it's not really that L0 "wants"
the exit, it's that L1 can't want the exit.  Does that make sense?


>  	default:
>  		break;
>  	}
> -- 
> 2.17.1
> 
