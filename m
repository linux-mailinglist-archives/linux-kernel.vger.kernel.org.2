Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25439A4A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhFCPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhFCPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:36:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B5FC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 08:34:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso4131365pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dUPtvp2h+2uImUipkmU0sy9GVVBMJMgO0OxnHuqRqVI=;
        b=jRdBKbs/w0rrXeQFwYPcKPEXipJtKT/D2Ljs/5Puaw2vZnaK2AjmiMj9MOtenqoZKM
         E9MERsYKERGUTZh9ESvN1VM5v7icANR83t7N0kDfRPxV83HF4g+HDIaQOGP13YOFR8Kd
         EhVplYS+XrTqilwKkmvEFPDVvLA68tnqfbbAzmkO9gT6TqCZaTDhYXRrJuIHukjIlWrY
         j3aMy3WqppUcurHWoUn2tELrwyO0PW7JKa0Wgod9T1AXTlCtBBVe6udRge4c3ciULffd
         4Ql0uZqkLC2zunewUq9SQc179WtHEN1FBOdnZiOi54kWVgiwY/jRfHqeeIBpjL3AB0wr
         JD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dUPtvp2h+2uImUipkmU0sy9GVVBMJMgO0OxnHuqRqVI=;
        b=hiWqsnvjIeaPCAr0GK/pvuo+RGQBVimsXkecyRULnb5pyMjwy+OJeuBNYvFrfcOGTJ
         CtUvzSLVwW+RxC2z+mbJkTn/gS3sow8o9NZ8zRL3a6tx5OiR2GST4B7UQ+xqPHgsiXIf
         AC+JZYPX1PJFzKyp4wP0LiIXPR5VRKdSOGtzQp0UkgOQRWFkGicZwDCtb2H0TsiDDDmv
         TCXS2TrGfHvBUsuSS3B77uCqL6vLvdI0F9eAjIadXIWkSmhkBTbTey/Q0Wz+XFQ425d4
         8i6tqPKykjBEf9kYVQ7t1CjC/LGJBDvp5e/wtWuLc6uQYKMNtqEgX/hnWIQtD0g+UNyk
         aUhA==
X-Gm-Message-State: AOAM533/QB9u6QtCvbxvzPj7O60itfuuNGKJ1AO2+AZteKIY1Fz6IkBX
        GgzuNRR5zsP0ZoAhMX9k3LbOcg==
X-Google-Smtp-Source: ABdhPJyeNrHA2kVj4qyFnh8E5UqsZtT7NDEnlBu4yJ/PIKwiPADFfe7imukPFXdTL5qfWRDwdeViEg==
X-Received: by 2002:a17:902:7d92:b029:f5:72d4:c06a with SMTP id a18-20020a1709027d92b02900f572d4c06amr498570plm.33.1622734480153;
        Thu, 03 Jun 2021 08:34:40 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id c15sm3233916pgt.68.2021.06.03.08.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 08:34:39 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:34:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] KVM: LAPIC: reset TMCCT during vCPU reset
Message-ID: <YLj2jDKMYZatdl3a@google.com>
References: <1622710841-76604-1-git-send-email-wanpengli@tencent.com>
 <1622710841-76604-2-git-send-email-wanpengli@tencent.com>
 <CALMp9eSK-_xOp=WdRbOOHaHHMHuJkPhG+7h4M+_+=4d-GCNzwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eSK-_xOp=WdRbOOHaHHMHuJkPhG+7h4M+_+=4d-GCNzwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021, Jim Mattson wrote:
> On Thu, Jun 3, 2021 at 2:01 AM Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > The value of current counter register after reset is 0 for both Intel
> > and AMD, let's do it in kvm.
> >
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> 
> How did we miss that?

I suspect it's not actually a functional issue, and that writing '0' at reset is
a glorified nop.  The TMCCT is always computed on-demand and never directly
readable.

Is there an observable bug being fixed?  If not, the changelog should state that
this is a cosmetic change of sorts.

static u32 __apic_read(struct kvm_lapic *apic, unsigned int offset)
{
	u32 val = 0;

	if (offset >= LAPIC_MMIO_LENGTH)
		return 0;

	switch (offset) {
	case APIC_ARBPRI:
		break;

	case APIC_TMCCT:	/* Timer CCR */
		if (apic_lvtt_tscdeadline(apic))
			return 0;

		val = apic_get_tmcct(apic);
		break;
	...
}


static u32 apic_get_tmcct(struct kvm_lapic *apic)
{
	ktime_t remaining, now;
	s64 ns;
	u32 tmcct;

	ASSERT(apic != NULL);

	/* if initial count is 0, current count should also be 0 */
	if (kvm_lapic_get_reg(apic, APIC_TMICT) == 0 ||  <------------
		apic->lapic_timer.period == 0)
		return 0;

	now = ktime_get();
	remaining = ktime_sub(apic->lapic_timer.target_expiration, now);
	if (ktime_to_ns(remaining) < 0)
		remaining = 0;

	ns = mod_64(ktime_to_ns(remaining), apic->lapic_timer.period);
	tmcct = div64_u64(ns,
			 (APIC_BUS_CYCLE_NS * apic->divide_count));

	return tmcct;
}

int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
{
	memcpy(s->regs, vcpu->arch.apic->regs, sizeof(*s));

	/*
	 * Get calculated timer current count for remaining timer period (if
	 * any) and store it in the returned register set.
	 */
	__kvm_lapic_set_reg(s->regs, APIC_TMCCT,
			    __apic_read(vcpu->arch.apic, APIC_TMCCT));  <----

	return kvm_apic_state_fixup(vcpu, s, false);
}



