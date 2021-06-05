Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5625F39C739
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 12:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFEKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 06:01:49 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:41795 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFEKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 06:01:48 -0400
Received: by mail-pg1-f179.google.com with SMTP id r1so9810453pgk.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rU2usZ6VpDrKQ/HrTkQUgy/LgHtMhtKYtSjZTXup1js=;
        b=FNbHgZgVHC73euLBNurTr2gkMzOg9gUTR9Xn/anWwvF5F/LJ1cWHmTL/AMCZ96DOpb
         cW9ljrC5vSTCKlvBmB+T7wuci/0UqH8tmGwp8Ymb4t6uJfrLXsOzdsE/aCipTiLwQwQJ
         CFzWyXdBitc+67wvyN3ObwB8U5WHQjJtS7U5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rU2usZ6VpDrKQ/HrTkQUgy/LgHtMhtKYtSjZTXup1js=;
        b=PS7dmKmex/JYHCeXchUe2gDfnT+OprGWMAaqFcr3FvcUyAuY1xqsHydgHaz7QnHpH9
         D75Gc3Bp+BVquiyi/p0/b7AXaKEKHfI3AT/pSYpXcODR0wx6NAPixDi3kx0Wp1IZtpOB
         p2thFu+DFRI2OjkH95D5uVk8A4PnAO0ymrhdXiSbmZidnlX4mzxCwpdFD4HazqAr50rD
         dTIXrd2UhAi6Ak6L6j8YOyNi4ZmrqfdqakH2gpMY6HdWgYC4p2BpfBEQXy1/xLE/tZXj
         QbTLWZj1OLFNrT6rOQY6xqF5hfdpHuYZdlgwD9ioc85A0zOEiwLKnt4cUqhTuZ4T5Guh
         tWKA==
X-Gm-Message-State: AOAM532Cq9HC/yXW3jqBflDmYVpLU/DuPStTGBCvI+86XQ5VXy+aQ45o
        X+eIKZhmbsbWIrTibd7uXgtB4Q==
X-Google-Smtp-Source: ABdhPJwGDuNhrymzH8+2TldAhTJbECpNX2SQAoAgQnmb139POYKcBzQCqbfUJo5CsVrYUjn2f6SSog==
X-Received: by 2002:a63:6644:: with SMTP id a65mr9070398pgc.431.1622887129571;
        Sat, 05 Jun 2021 02:58:49 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:5981:261e:350c:bb45])
        by smtp.gmail.com with ESMTPSA id b23sm3659986pfi.34.2021.06.05.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 02:58:48 -0700 (PDT)
Date:   Sat, 5 Jun 2021 18:58:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kvm: x86: implement KVM PM-notifier
Message-ID: <YLtK09pY1EjOtllS@google.com>
References: <20210605023042.543341-1-senozhatsky@chromium.org>
 <20210605023042.543341-2-senozhatsky@chromium.org>
 <87k0n8u1nk.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0n8u1nk.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/05 10:00), Marc Zyngier wrote:
[..]
> > +	select HAVE_KVM_PM_NOTIFIER
> 
> if you write this as:
> 
> 	select HAVE_KVM_PM_NOTIFIER if PM

[..]
> > +#if defined(CONFIG_PM) && defined(CONFIG_HAVE_KVM_PM_NOTIFIER)
> 
> ... you can simplify this expression to be a simple
> 
> #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
> 
> in both patches.

Thanks.

> > +static int kvm_arch_suspend_notifier(struct kvm *kvm)
> > +{
> > +	struct kvm_vcpu *vcpu;
> > +	int i, ret;
> > +
> > +	mutex_lock(&kvm->lock);
> > +	kvm_for_each_vcpu(i, vcpu, kvm) {
> > +		ret = kvm_set_guest_paused(vcpu);
> > +		if (ret) {
> > +			pr_err("Failed to pause guest VCPU%d: %d\n",
> > +			       vcpu->vcpu_id, ret);
> 
> Is it really a good idea to fail suspend when a guest doesn't have PV
> time enabled? I also wonder how useful the pr_err() is, given that it
> contains no information that would help identifying which guest failed
> to pause.

No opinion. What shall we do when we fail to suspend the VM?
VM's watchdogs will trigger and maybe panic the system after
resume.
