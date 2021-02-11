Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4B931908D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhBKRCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhBKPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:54:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4446C061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:53:26 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x136so3943455pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vnu2AtQ1spv0GWQmPrlWpgIMMltpVB1H3yMfq69YdQg=;
        b=U++q29GI0JS9qimHjYxoLWA88JdkGYxzQC7VLD7nkBcz2ogRcyFq0nPvDNcwlztw41
         49yM34YYFdP/2PbM53WapBfRyvXes0nJUcS3W07w1nGFCAJr/HlXg/mVhgnPMx8PSzkK
         PaYcgoZR7saPS6cb/fOkpWR7ijvHPNVyb6lGdxxQzfMeo0fMf7rea0d4ku91YWdOFAwJ
         fN7AgZZFKVbP3ued6lCe2wAnR9/08VK1+s439q/rMoSz0pP3V0LAmfH+LODOGx+5XofR
         2kPq8+NEGMbkpeh+l1aNjGXo7Y3u7LDD4LXWVmh8rrW+A3t1IEgXzE3I4uX9nUJ+q0ef
         nPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vnu2AtQ1spv0GWQmPrlWpgIMMltpVB1H3yMfq69YdQg=;
        b=h1hB8hK5Vaf0uBy8gQeNNk+kZuFpEQBe/EpPL/ApdksmlCxur0t1xY/xQTLHkXhaxm
         mtk56rso8z2l5ZpIh6xcFVvG+u0UMyYhhJ2ujRyqYLt7La+QmfXav8zqV6j929+ABGYn
         kVsIADcp8IpLhYCajWXmRJEsNnCJsfWuadHXoL9v9+zGUytLA6iBXbKDxRKpUwt5AhdD
         EVjpW+PCZ73DawfOIX7ImJmwN2i8grE6mHk/rWBf0mLU81KaBpaVKM6LbtqGLF+2CHAe
         sKFttmq6qzAa+XH9LaOouqMGnG0/vz9OAr+/a727OsZPqHp+x6rtd/cNi0HtCnritFsk
         m0NA==
X-Gm-Message-State: AOAM532yzY/jNHij9ZQ6hkWfPPtyQk1IxUb9c0jFlSKMO5BpoGdYOkZC
        Zv5+FHNZE8+AmcDlbNSkP/HyBh4m/k/YgA==
X-Google-Smtp-Source: ABdhPJw/TlRtkkNbkn2Zsea8YEd53t9+megM0TMZUVR3RMYIDC7aR4gTj2dH/GDqKoMwhcy5ttBbgQ==
X-Received: by 2002:a62:35c6:0:b029:1ba:e795:d20e with SMTP id c189-20020a6235c60000b02901bae795d20emr8538633pfa.37.1613058806192;
        Thu, 11 Feb 2021 07:53:26 -0800 (PST)
Received: from google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
        by smtp.gmail.com with ESMTPSA id h11sm5341715pjg.46.2021.02.11.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 07:53:25 -0800 (PST)
Date:   Thu, 11 Feb 2021 07:53:19 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Makarand Sonare <makarandsonare@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pshier@google.com,
        jmattson@google.com, Ben Gardon <bgardon@google.com>
Subject: Re: [RESEND PATCH ] KVM: VMX: Enable/disable PML when dirty logging
 gets enabled/disabled
Message-ID: <YCVS79fnRkDRqfL2@google.com>
References: <20210210212308.2219465-1-makarandsonare@google.com>
 <7c78c6df-36e7-1473-e834-3786e257ebc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c78c6df-36e7-1473-e834-3786e257ebc5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021, Paolo Bonzini wrote:
> On 10/02/21 22:23, Makarand Sonare wrote:
> > +void vmx_update_pml_in_vmcs(struct kvm_vcpu *vcpu)
> > +{
> > +	if (cpu_has_secondary_exec_ctrls()) {
> > +		if (is_guest_mode(vcpu)) {
> > +			to_vmx(vcpu)->nested.deferred_update_pml_vmcs = true;
> > +			return;
> > +		}
> > +
> > +		if (vcpu->kvm->arch.pml_enabled)
> > +			vmcs_set_bits(SECONDARY_VM_EXEC_CONTROL,
> > +				SECONDARY_EXEC_ENABLE_PML);
> > +		else
> > +			vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL,
> > +				SECONDARY_EXEC_ENABLE_PML);
> > +	}
> > +}
> 
> 
> Since the execution controls are shadowed, they can be read quite
> efficiently.  This means that there's no need for
> vcpu->kvm->arch.pml_enabled, and also that the copy can be done
> unconditionally in prepare_vmcs02 and nested_vmx_vmexit.
> 
> If the above is not true, we should at least combine
> change_vmcs01_virtual_apic_mode, reload_vmcs01_apic_access_page and the new
> field in a single bit field, for example vmx->nested.dirty_vmcs01_fields or
> vmx->nested.vmexit_requests.
> 
> In any case I expect Sean to take care of submitting this patch and I have
> to do nothing more about it, right?

Right, we'll sort it out.
