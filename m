Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3239A45E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhFCPV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhFCPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:21:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C58C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 08:20:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d5-20020a17090ab305b02901675357c371so5341030pjr.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EM5lQ+MrZan5XXagwUBW9ttdhkPzpL4+w0s0X2CVGAY=;
        b=hQuy1dTxwDnv46KdNYBfAe/cdq8Wu5hRmeKWwVzoL1v4TqhFkcT9LWH9tjLcaaewtu
         0a6XUewjLCk4qxcP394ZVbZLW9IvuvGlb7m4oxkKRYwc8Uu8Jwabjg+ZlSE7+0v+a2hy
         /JbKOCQWuN4vqH2ryfeePbDzp1DpQJqxGubXm5Clnv8Osd0jWAP1Hld60lGFRhKPJ5kW
         WoK6cLMSJ3VWWayuActX2VL6ndQy88A46Id9wO83rOLIaMwZ7L4r3iKkWWy3OFpW5CL/
         WMO2wDvHIQ0kN23PuBbh8xehdlq+RFX6pInLAAxQTqSZi6IOyDChLDNqOzCr9LU0cfN9
         ULMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EM5lQ+MrZan5XXagwUBW9ttdhkPzpL4+w0s0X2CVGAY=;
        b=XEA/cgbwqAaR5hBOeaQqfWnmxlwEd8V7w5e/nusysWEEfxIgOgWcNtYjv5rEyx2IVg
         fHH9X/Q32hltnAYP9QEoSG47vGYdqo4eqUdjlIxLWoDdRCB3uhlOxVe43PoaKtJV/P/B
         nBMZ9/DHbMCc+B1G8Ia/gasyq5fESo1H/lUYf/xrO0vBUNt9fPijPSor6MAkICasdhvl
         yW5Lg3mfmFZc2zHBqUZe3t17iSqN/XEYpQmP2JZnad01Ky5A7JG37q/FLI37RY++Ccsn
         vrUeKvVSNCRKYnWFXKBVY8wU9jlGU+QuvXKKE3tGX7dNtP8hb+hlzVaKwpAnc7o1Zyo+
         cljQ==
X-Gm-Message-State: AOAM531fpiy6xnaJXCtM10VX+/6mlw8kLg3YAoVxu3NeC3tRKWxkuW+K
        Z8sv+TyBMxrP6zx5zCNqVHruCQ==
X-Google-Smtp-Source: ABdhPJy8UTjIiya3x+RJ7uVRs7WAk635j+A5JJEh7H9/tGIOH6RkCCeCYudrlbrRQhOW5o4dDyrCNA==
X-Received: by 2002:a17:90a:a60d:: with SMTP id c13mr11766792pjq.172.1622733611957;
        Thu, 03 Jun 2021 08:20:11 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id j1sm2536349pgq.23.2021.06.03.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 08:20:11 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:20:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] KVM: LAPIC: write 0 to TMICT should also cancel
 vmx-preemption timer
Message-ID: <YLjzJ59HPqGfhhvm@google.com>
References: <1622710841-76604-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622710841-76604-1-git-send-email-wanpengli@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
>  
> According to the SDM 10.5.4.1:
> 
>   A write of 0 to the initial-count register effectively stops the local
>   APIC timer, in both one-shot and periodic mode.
> 
> The lapic timer oneshot/periodic mode which is emulated by vmx-preemption 
> timer doesn't stop since vmx->hv_deadline_tsc is still set.

But the VMX preemption timer is only used for deadline, never for oneshot or
periodic.  Am I missing something?

static bool start_hv_timer(struct kvm_lapic *apic)
{
	struct kvm_timer *ktimer = &apic->lapic_timer;
	struct kvm_vcpu *vcpu = apic->vcpu;
	bool expired;

	WARN_ON(preemptible());
	if (!kvm_can_use_hv_timer(vcpu))
		return false;

	if (!ktimer->tscdeadline)  <-------
		return false;

	...
}
