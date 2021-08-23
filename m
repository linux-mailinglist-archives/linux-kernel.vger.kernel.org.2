Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B2A3F461F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhHWHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235168AbhHWHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629705261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LNQHzhBU61w8aySVKkAPo9NSfHYRJWrZd0ke9vwfjJk=;
        b=ElEXmOCgua7ofb/Z5PlVt0TfFfzkunHRx48CfI7+B2gFgRvaXAcXkidOdNRCRTrVZopEos
        pUzelNBOX8TjA1q8QhexYOgQXE6Kw8asyrJzyx6yZdLo3JYI2YNT0/U7llGt4Wb6zFYmdh
        X2F5URR5Nc8BmFsWYJRP01GPWOUHttc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-vol2L9BuP8WwvGRfRSsp6w-1; Mon, 23 Aug 2021 03:54:19 -0400
X-MC-Unique: vol2L9BuP8WwvGRfRSsp6w-1
Received: by mail-wm1-f69.google.com with SMTP id y23-20020a7bcd97000000b002e6e4a2a332so2717204wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LNQHzhBU61w8aySVKkAPo9NSfHYRJWrZd0ke9vwfjJk=;
        b=pCLnqnHACv58qhudK8LEiZafTxYOTTW6W+J2h0W5W+5CD6E4pcbSlvH4qXm6qIYB6w
         zHtvj99LUFmrxXNI+764gnL5DGFjc8cAQDiu0442FCw/xAlYFKw2iM1VbJzrl9phsm75
         Wy1JwVkm+77q0GHQUShL7fEpgSSWP/CkzDCBoxOtG9aUHBErqm2QyjRZEb+4ewVIXA5x
         hSnVAbb8z4L6SRtHRH5zgwrYRiwsoHj9VERD5uPWtYVriAm1vI9qRxys1uJyrONZz4VN
         dJ51oAvTMSikxSzXUhdhMLX2ANqm2+MVsuPFZHXAzM5lA4KxHMCdGvh7qD8TxUZcjNIR
         kpxQ==
X-Gm-Message-State: AOAM533eLo+Hl0LQ00hi87/mHOyRV8SJXxKbFFk7/b+fgXuU3XYQoVa2
        gQE/EDCeDOoMQtmelBFhYKwi+N5GWn0OKlo3Okpl2c5rFPSeX5fBhddQ4iQT9ThDh+iZYjt5r8a
        XQmrt9n79bChG5D5VCxo8+KSD
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr14936193wmg.138.1629705258656;
        Mon, 23 Aug 2021 00:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzND033zGe/eugLPehvBvzHmQ600rjQM2jZoXTXeTOGRVMQhD5X4o8/yaxNE5yMWDNWZwjh7w==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr14936177wmg.138.1629705258455;
        Mon, 23 Aug 2021 00:54:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s16sm7245700wrw.44.2021.08.23.00.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 00:54:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Venkatesh Srinivas <venkateshs@google.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 2/2] KVM: Guard cpusmask NULL check with
 CONFIG_CPUMASK_OFFSTACK
In-Reply-To: <20210821000501.375978-3-seanjc@google.com>
References: <20210821000501.375978-1-seanjc@google.com>
 <20210821000501.375978-3-seanjc@google.com>
Date:   Mon, 23 Aug 2021 09:54:16 +0200
Message-ID: <871r6klhp3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Check for a NULL cpumask_var_t when kicking multiple vCPUs if and only if
> cpumasks are configured to be allocated off-stack.  This is a meaningless
> optimization, e.g. avoids a TEST+Jcc and TEST+CMOV on x86, but more
> importantly helps document that the NULL check is necessary even though
> all callers pass in a local variable.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/kvm_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 786b914db98f..82c5280dd5ce 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -247,7 +247,7 @@ static void ack_flush(void *_completed)
>  
>  static inline bool kvm_kick_many_cpus(const struct cpumask *cpus, bool wait)
>  {
> -	if (unlikely(!cpus))
> +	if (IS_ENABLED(CONFIG_CPUMASK_OFFSTACK) && unlikely(!cpus))
>  		cpus = cpu_online_mask;
>  
>  	if (cpumask_empty(cpus))
> @@ -277,6 +277,14 @@ bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
>  		if (!(req & KVM_REQUEST_NO_WAKEUP) && kvm_vcpu_wake_up(vcpu))
>  			continue;
>  
> +		/*
> +		 * tmp can be NULL if cpumasks are allocated off stack, as
> +		 * allocation of the mask is deliberately not fatal and is
> +		 * handled by falling back to kicking all online CPUs.
> +		 */
> +		if (IS_ENABLED(CONFIG_CPUMASK_OFFSTACK) && !tmp)
> +			continue;
> +
>  		/*
>  		 * Note, the vCPU could get migrated to a different pCPU at any
>  		 * point after kvm_request_needs_ipi(), which could result in
> @@ -288,7 +296,7 @@ bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
>  		 * were reading SPTEs _before_ any changes were finalized.  See
>  		 * kvm_vcpu_kick() for more details on handling requests.
>  		 */
> -		if (tmp != NULL && kvm_request_needs_ipi(vcpu, req)) {
> +		if (kvm_request_needs_ipi(vcpu, req)) {
>  			cpu = READ_ONCE(vcpu->cpu);
>  			if (cpu != -1 && cpu != me)
>  				__cpumask_set_cpu(cpu, tmp);

In case MM people don't like us poking into CONFIG_CPUMASK_OFFSTACK
details we can probably get away with a comment. Otherwise

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

