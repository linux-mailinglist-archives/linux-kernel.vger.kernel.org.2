Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EDE38F141
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhEXQLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbhEXQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:10:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C131EC0500F8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:48:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so187801pjr.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jdUvvHha+1E16rlXHQ/d/r5xAqyOfnIEzrFPg1F5AAo=;
        b=aL0BOIZVBAPpNeM5oKy4zCeXsmTnWh4dp6KbEgYIlrX80upgz696CSLkQACJf4Uh8b
         pfeLJB5d0a5zD6XYZ5b3UJhhKSVbZQOUlzGrcFmzotNEISCREgNpwGNcYrnYBONYo7kL
         ipt50uYGR6+v8871Ddk53u/HNcTnyeVlIkX8/mHc8gx/jK34rOKakgkSVxutwT03LsiL
         Yr52gxBT5H/2aMErSRnQPuaQig44LN2hMg+vNdJK3j50zn31WiWhPaEDHHFS7uK7xy20
         HdnLUAu2R5qZoGb7uskHHEmr5XHCSZhsiuPAj1S+umG6BYl2kFjKdTzvDE8yM9Wnhggc
         RlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jdUvvHha+1E16rlXHQ/d/r5xAqyOfnIEzrFPg1F5AAo=;
        b=XNp4TJFi4hDrQCdn/a13qXRI6uKi2ey2MwpZ4p3lW43g7GMJ4kBzLwlSizaTolhpSC
         73+O8Vdvc52sGIBJf72njrD6m8AV5BDY+E7owdGH+embeSK8BNWGaegQ/YsfBYrce/Ry
         LzYzl0qpsJpIxiwm0ZK2SFB/tkEr8nk+2qLbtMpXqJapMavs5Cf5x0NgXfYzDaw7OteK
         ThdLBP0jgF8CF6eB/dpkd1vW7x4AUWC/tVz5Q/g88SXxPtXsyzFCezJnbQySE/TI879P
         bUSsoLOzE5F02+LU2IJK0cWhDWKllKqcshPnDUlNVKNrs+5zks7OQWCmUkV41i+N5V8H
         98Zw==
X-Gm-Message-State: AOAM530S69hlgaWne3VRY8+X7VFnrTRPWpAcEhpF7qiYMoJruFKNzATV
        OL4CrjJ2e/BoTHns6qauHDgL4w==
X-Google-Smtp-Source: ABdhPJy/bUuyTo/E1j+DqZRrTOPTCCBOyB+/5eRJqHlyd8yOQuJZATJIWGHTb3UogaC8mv1oVZwmAA==
X-Received: by 2002:a17:902:6b81:b029:ea:dcc5:b841 with SMTP id p1-20020a1709026b81b02900eadcc5b841mr26213810plk.29.1621871303146;
        Mon, 24 May 2021 08:48:23 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id o10sm11154774pfh.67.2021.05.24.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 08:48:22 -0700 (PDT)
Date:   Mon, 24 May 2021 15:48:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ilias Stamatis <ilstam@amazon.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mlevitsk@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, zamsden@gmail.com, mtosatti@redhat.com,
        dwmw@amazon.co.uk
Subject: Re: [PATCH v3 04/12] KVM: X86: Add a ratio parameter to
 kvm_scale_tsc()
Message-ID: <YKvKwpRP6UcftcnQ@google.com>
References: <20210521102449.21505-1-ilstam@amazon.com>
 <20210521102449.21505-5-ilstam@amazon.com>
 <cba90aa4-0665-a2d5-29e0-133e0aa45ad2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba90aa4-0665-a2d5-29e0-133e0aa45ad2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021, Paolo Bonzini wrote:
> On 21/05/21 12:24, Ilias Stamatis wrote:
> > @@ -3537,10 +3539,14 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >   		 * return L1's TSC value to ensure backwards-compatible
> >   		 * behavior for migration.
> >   		 */
> > -		u64 tsc_offset = msr_info->host_initiated ? vcpu->arch.l1_tsc_offset :
> > -							    vcpu->arch.tsc_offset;
> > -
> > -		msr_info->data = kvm_scale_tsc(vcpu, rdtsc()) + tsc_offset;
> > +		if (msr_info->host_initiated)
> > +			msr_info->data = kvm_scale_tsc(
> > +				vcpu, rdtsc(), vcpu->arch.l1_tsc_scaling_ratio
> > +				) + vcpu->arch.l1_tsc_offset;
> 
> Better indentation:
> 
> 	msr_info->data = vcpu->arch.l1_tsc_offset +
> 		kvm_scale_tsc(vcpu, rdtsc(),

I like this more, but it's still a bit ugly.

> 			      vcpu->arch.tsc_scaling_ratio);

Wrong pairing of ratio and offset (not necessarily what you queued, obviously).

> 
> Same below.

Alternatively, what about something like this?

		u64 offset, ratio;

		if (msr_info->host_initiated) {
			offset = vcpu->arch.l1_tsc_offset;
			ratio = vcpu->arch.l1_tsc_scaling_ratio;
		} else {
			offset = vcpu->arch.tsc_offset;
			ratio = vcpu->arch.tsc_scaling_ratio;
		}
		msr_info->data = kvm_scale_tsc(vcpu, rdtsc(), ratio) + offset;

or an option that would require additional refactoring:

		struct kvm_guest_tsc *tsc;

		tsc = msr_info->host_initiated ? &vcpu->arch.l1_tsc :
						 &vcpu->arch.current_tsc;

		msr_info->data = tsc->offset +
				 kvm_scale_tsc(vcpu, rdtsc(), tsc->scaling_ratio);


> 
> Paolo
> 
> > +		else
> > +			msr_info->data = kvm_scale_tsc(
> > +				vcpu, rdtsc(), vcpu->arch.tsc_scaling_ratio
> > +				) + vcpu->arch.tsc_offset;
> >   		break;
> >   	}
> >   	case MSR_MTRRcap:
> > 
> 
