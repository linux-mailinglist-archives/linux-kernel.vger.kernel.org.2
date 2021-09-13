Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507A640851A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhIMHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237492AbhIMHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631516882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EWjxh5F2abgIo2Gnc7HdmKlyHPXEnf9KAGWr3gnnOYI=;
        b=MPCRnwyopUdZKF6YaHbT4Y81qoJe02Jdy1wKxzNSJqwMhSDN8UAF+fz2TYE7NskIOdvtl0
        QHcM6VSaugqX/CRkU75/+gxZWiUwjANg1kfbzCTShiUbDExIZLQ8uEsIYJAjYbtK0GLWl5
        syOy9IcEqiM35Xnxc9zSolBRfxGZT4w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-EMSk92P2OMa4OY7DOysNnQ-1; Mon, 13 Sep 2021 03:08:01 -0400
X-MC-Unique: EMSk92P2OMa4OY7DOysNnQ-1
Received: by mail-wm1-f72.google.com with SMTP id m22-20020a7bca56000000b002e7508f3faeso4512420wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EWjxh5F2abgIo2Gnc7HdmKlyHPXEnf9KAGWr3gnnOYI=;
        b=7qbMVxbQNGgUaeHGL1k3Mf/zLQzOkHRknxaOEU6LDNpr+V79Az3UfGsrfrnJ0A3pFy
         N8axeEZA8woDKs2dOOchZuAlk2l0zTUt2gfK8oQiYsJHdjK9cSjpK2oE8e7gWrH0YNp0
         abaHmvsg4EYc7gCB1F8xOdNWKx1zfoobKURGhdTP4wvS6c9MPbXkBGXkHldc6XNsIEg2
         ifpU1SLDxplT4zr31O6w1OFvexlWiqWOIGn0MqTfKlFN5INzuOz3g+nXnAli4G+K+LEg
         sAJmNPTPgqK4yI55Laiisy5GZH6oRP31vKba3xaBdBR6vazuKjQVFhWakN1vJs4yPvds
         7yyw==
X-Gm-Message-State: AOAM532C9y9OolmrIXHpP1AKPkMNgNBqmHFkE8vvG/Nx6zmQ/sR2j8NC
        LMM6xwfzmfQOfF20eE6sCFNymnkAVtV1VEo8iUMOaDyvXwiMhhefpVl/yjca5fO7rpGt3uU3o4e
        /I6P3ZFq0338UvcYJNy3NSlUpA0m+QIBb+aQBXfiR0X5sYjTts3PJUOYK0nt2q3pCeECRhENbur
        qS
X-Received: by 2002:adf:e983:: with SMTP id h3mr5459713wrm.231.1631516879910;
        Mon, 13 Sep 2021 00:07:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF8qp4hFXSGX7z49nSIIL+FQOUxQSvZ93DfhxsC7fRMoJHbuURkT4+vqpjPqMKGLXFk6ybpw==
X-Received: by 2002:adf:e983:: with SMTP id h3mr5459682wrm.231.1631516879583;
        Mon, 13 Sep 2021 00:07:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l7sm6455718wmj.9.2021.09.13.00.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:07:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Identify vCPU0 by its vcpu_idx instead of
 walking vCPUs array
In-Reply-To: <20210910183220.2397812-3-seanjc@google.com>
References: <20210910183220.2397812-1-seanjc@google.com>
 <20210910183220.2397812-3-seanjc@google.com>
Date:   Mon, 13 Sep 2021 09:07:57 +0200
Message-ID: <87czpd2bsi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Use vcpu_idx to identify vCPU0 when updating HyperV's TSC page, which is
> shared by all vCPUs and "owned" by vCPU0 (because vCPU0 is the only vCPU
> that's guaranteed to exist).  Using kvm_get_vcpu() to find vCPU works,
> but it's a rather odd and suboptimal method to check the index of a given
> vCPU.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 86539c1686fa..6ab851df08d1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2969,7 +2969,7 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
>  				       offsetof(struct compat_vcpu_info, time));
>  	if (vcpu->xen.vcpu_time_info_set)
>  		kvm_setup_pvclock_page(v, &vcpu->xen.vcpu_time_info_cache, 0);
> -	if (v == kvm_get_vcpu(v->kvm, 0))
> +	if (!v->vcpu_idx)
>  		kvm_hv_setup_tsc_page(v->kvm, &vcpu->hv_clock);
>  	return 0;
>  }

" ... instead of walking vCPUs array" in the Subject line is a bit
confusing because kvm_get_vcpu() doesn't actually walk anything, it just
returns 'kvm->vcpus[i]' after checking that we actually have that many
vCPUs. The patch itself is OK, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

