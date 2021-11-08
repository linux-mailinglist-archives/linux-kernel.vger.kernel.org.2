Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C340D449B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhKHSJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhKHSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:09:55 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD67FC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 10:07:10 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g19so10809276pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7eQ8ia+dB2T87S9K7CaWuiJBvCWc/a1PJeN9BRnks1o=;
        b=Gj9i4t4iknOQDeZ7YeT2+v0YHX74Zso9nysBAufKMqGIV7zyEIHSvbUUDZKOQffn4k
         zLLOaNilf04ex9tsUxHrf/6q5gWV7GWII8Squu/FEs+tcKXsmVnS0kAwpZsnYbgqnf5P
         AcsMmGaUg2xzwL4qg0u/Ew8NtJ8krFcKZ16sMkr1tTUfKJSgwaZl2HoxzSf4ArOGQPJI
         GBV52ZtiOWcrSDI7JZ4u+QCmG2mxWaJLd584Jn4Y41tOKnI88GPpqsIilhVQ6Pworgn4
         /fXBDpMB3h1FY3ZGpJjp/Apm2O0dq5yNdOD5WG2UT4X//wgSROSa367BVXlCM0xYRm7J
         qgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7eQ8ia+dB2T87S9K7CaWuiJBvCWc/a1PJeN9BRnks1o=;
        b=me/9jJ+a1slyaavq87nblssWbQJTo7lM5O5SgVPdKYAAo/CgYxX12BNg+0Og+EG50s
         aoYMixVSvFmolp5VFi15zKKdRP6HFakYoiKqpgLcFcf9Hp2eixP0zPlsUI0g26BRlHY6
         oQTjqAoEBoDo6C0H+UJa5UzZ/s4gIMi1ThdFQOcDj9tRvtM3VRlDRXbx2hMnczwUVw/s
         i0dxdGUQJxQmpoXtWeVN1Gi2zcdQhJ1yVmfwpKTZrHu0+Gn5fHbe5L2sV+aBdqUHmSya
         eowiUso/ws/B8WU0VNgEUoc8RK/0G6bjvkIjS/lHt0i7IDdhvvKHI2hIDy/ulw7nBpW3
         k2tw==
X-Gm-Message-State: AOAM531YDl02MqBRD7e3mSX13rIOzGV+0PHVtlg7z7eopYBYlUvkQdrO
        cutc2mZQQrZGrfM/JDCtoP1sIg==
X-Google-Smtp-Source: ABdhPJxB1IdhseSV2aMwiBhebF4HV8tfAj7mXNlBpBQ+qWtDW/wYH1isLDJp19sxu4fmJWlVmAiumw==
X-Received: by 2002:a05:6a00:2146:b0:44c:2922:8abf with SMTP id o6-20020a056a00214600b0044c29228abfmr1079633pfk.27.1636394830113;
        Mon, 08 Nov 2021 10:07:10 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id mv22sm43754pjb.36.2021.11.08.10.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:07:09 -0800 (PST)
Date:   Mon, 8 Nov 2021 18:07:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] KVM: VMX: Add proper cache tracking for PKRS
Message-ID: <YYlnSdw+3dY/lJ25@google.com>
References: <20210811101126.8973-1-chenyi.qiang@intel.com>
 <20210811101126.8973-3-chenyi.qiang@intel.com>
 <YYlaw6v6GOgFUQ/Z@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYlaw6v6GOgFUQ/Z@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021, Sean Christopherson wrote:
> On Wed, Aug 11, 2021, Chenyi Qiang wrote:
> > +			vcpu->arch.pkrs = vmcs_read64(GUEST_IA32_PKRS);
> 
> Hrm.  I agree that it's extremely unlikely that IA32_PKRS will ever allow software
> to set bits 63:32, but at the same time there's no real advantage to KVM it as a u32,
> e.g. the extra 4 bytes per vCPU is a non-issue, and could be avoided by shuffling
> kvm_vcpu_arch to get a more efficient layout.  On the flip side, using a 32 means
> code like this _looks_ buggy because it's silently dropping bits 63:32, and if the
> architecture ever does get updated, we'll have to modify a bunch of KVM code.
> 
> TL;DR: I vote to track PRKS as a u64 even though the kernel tracks it as a u32.

Rats, I forgot that the MMU code for PKRU is going to be reused for PKRS.  I withdraw
my vote :-)

Maybe have this code WARN on bits 63:32 being set in the VMCS field?  E.g. to
detect if hardware ever changes and KVM fails to update this path, and to document
that KVM intentionally drops those bits.

	case VCPU_EXREG_PKRS: {
		u64 ia32_pkrs;

		ia32_pkrs = vmcs_read64(GUEST_IA32_PKRS);
		WARN_ON_ONCE(ia32_pkrs >> 32);
		vcpu->arch.pkrs = (u32)ia32_pkrs;
	}
