Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588FC3FF0EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346132AbhIBQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhIBQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B145C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g184so2490681pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9hsKCsvAc+NpyKxD6LkPgUN99rsUl4Mu6Z/Upfc+vYg=;
        b=fSm9PxGOLu5qMyu+VGbGIhHJD+A0Uyzyb7tbkPtzhXuBdHHqrcbyTZr3pJiv55xTtA
         xghzr1DngMbiT0AKuqFPivm9uA36tidlTAt1orchxQOYSbLQIzOij0VT3cJ1N6NoGiAc
         Dnzk2wgptNKid5HkHDoM3hn775CKM8+3h1VsixoMlRPTCwGjZRXRFwwZjedCtht+khYZ
         /38fGrDFrjxmFrceoL0HkLzx9JKVidIHkcVF+vB/07E7OnYhWXk2lhJp+rFE1LDv3Bw1
         sJ/wfC5CURAsO3YS8XnbHTEI2hGFGDMzzwzL6bNkRWgPlBIHj7qzcA26bu7WDoel5YUb
         RFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9hsKCsvAc+NpyKxD6LkPgUN99rsUl4Mu6Z/Upfc+vYg=;
        b=Oi/2Kmc5ZJP59eQvXL1FEibNrL7KDR3Pkp42V/+Aw+l96fzPSEX8dhfA3ejcAWGNE2
         hLUwsLpIPH70anOT+t/QSQAaIPaRn3l+JoajIkPIXgs3yaU+ShSpUGas7+She45evEXI
         CxPYwxfmkoLtwh3OP+HnzVVDA98x4YplOJp5rD5rH6IY8klwZJlHsqpl4n1rBt1ndxVp
         0QFeBx9ibftgVb2a8oko8w2tL25h/XqDhv2Cyxx2I62WCwp63LCB4dORjOPbgwrfg0Wl
         Gk/4MppPV8VpVPQzVVFg0KL2c3WMze/vXOHrn7dP4msKVGbi19gtCzX6WL1FW1R/Xnys
         zFqg==
X-Gm-Message-State: AOAM533n5HYGMttGx1A3ZGH9muGd9J2eN5vQcMES618lT9qoxA3yCp0i
        t8IWWhKkdXgbgoN78NYkNjpHYg==
X-Google-Smtp-Source: ABdhPJyuWPgLWVgkJrTn8l+ao7PrF4vWzU62syPlrpdLHUAeVgPTArfKsqKMDXGEeS7YXLai10fklQ==
X-Received: by 2002:a63:9d4c:: with SMTP id i73mr1479588pgd.216.1630599323729;
        Thu, 02 Sep 2021 09:15:23 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l127sm2920354pfl.99.2021.09.02.09.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:22 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:15:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Tao Xu <tao3.xu@intel.com>, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: VMX: Enable Notify VM exit
Message-ID: <YTD4l7L0CKMCQwd5@google.com>
References: <20210525051204.1480610-1-tao3.xu@intel.com>
 <YQRkBI9RFf6lbifZ@google.com>
 <b0c90258-3f68-57a2-664a-e20a6d251e45@intel.com>
 <YQgTPakbT+kCwMLP@google.com>
 <080602dc-f998-ec13-ddf9-42902aa477de@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080602dc-f998-ec13-ddf9-42902aa477de@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021, Xiaoyao Li wrote:
> On 8/2/2021 11:46 PM, Sean Christopherson wrote:
> > > > > @@ -5642,6 +5653,31 @@ static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
> > > > >    	return 0;
> > > > >    }
> > > > > +static int handle_notify(struct kvm_vcpu *vcpu)
> > > > > +{
> > > > > +	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
> > > > > +
> > > > > +	if (!(exit_qual & NOTIFY_VM_CONTEXT_INVALID)) {
> > > > 
> > > > What does CONTEXT_INVALID mean?  The ISE doesn't provide any information whatsoever.
> > > 
> > > It means whether the VM context is corrupted and not valid in the VMCS.
> > 
> > Well that's a bit terrifying.  Under what conditions can the VM context become
> > corrupted?  E.g. if the context can be corrupted by an inopportune NOTIFY exit,
> > then KVM needs to be ultra conservative as a false positive could be fatal to a
> > guest.
> > 
> 
> Short answer is no case will set the VM_CONTEXT_INVALID bit.

But something must set it, otherwise it wouldn't exist.  The condition(s) under
which it can be set matters because it affects how KVM should respond.  E.g. if
the guest can trigger VM_CONTEXT_INVALID at will, then we should probably treat
it as a shutdown and reset the VMCS.  But if VM_CONTEXT_INVALID can occur if and
only if there's a hardware/ucode issue, then we can do:

	if (KVM_BUG_ON(exit_qual & NOTIFY_VM_CONTEXT_INVALID, vcpu->kvm))
		return -EIO;

Either way, to enable this by default we need some form of documentation that
describes what conditions lead to VM_CONTEXT_INVALID.

> VM_CONTEXT_INVALID is so fatal and IMHO it won't be set for any inopportune
> NOTIFY exit.
