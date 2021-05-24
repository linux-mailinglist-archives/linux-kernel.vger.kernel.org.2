Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754DB38E665
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhEXMOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232494AbhEXMOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621858403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHS7kDDRvF5zOyGIv8drTO+Pb6C7Uho8V01CDj2scXk=;
        b=LRP4Ht7XzhO3JjUr2jbfejubplf2wU9LeOYpksdoSns2y8kWQzB/ogQoQ8xCqebxd4E3jk
        UQdDdtnoeCcleAD7f0yx1aj86hXkGJr4MfBzMb7V35RftlDFeF1sLEt1/4cQc6v5lxzHTY
        V+zcaGl41C4CbKi1TqPT7f/F2gLhZ6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-xqcLxzkAOvGzwvBOX-FM5g-1; Mon, 24 May 2021 08:13:19 -0400
X-MC-Unique: xqcLxzkAOvGzwvBOX-FM5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D7D58042C9;
        Mon, 24 May 2021 12:13:18 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DDCB7086A;
        Mon, 24 May 2021 12:13:15 +0000 (UTC)
Message-ID: <779a182e7ed08484658463a69cf3934dcc87464d.camel@redhat.com>
Subject: Re: [PATCH v2 2/7] KVM: nVMX: Release enlightened VMCS on VMCLEAR
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Date:   Mon, 24 May 2021 15:13:14 +0300
In-Reply-To: <20210517135054.1914802-3-vkuznets@redhat.com>
References: <20210517135054.1914802-1-vkuznets@redhat.com>
         <20210517135054.1914802-3-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-17 at 15:50 +0200, Vitaly Kuznetsov wrote:
> Unlike VMREAD/VMWRITE/VMPTRLD, VMCLEAR is a valid instruction when
> enlightened VMCS is in use. TLFS has the following brief description:
> "The L1 hypervisor can execute a VMCLEAR instruction to transition an
> enlightened VMCS from the active to the non-active state". Normally,
> this change can be ignored as unmapping active eVMCS can be postponed
> until the next VMLAUNCH instruction but in case nested state is migrated
> with KVM_GET_NESTED_STATE/KVM_SET_NESTED_STATE, keeping eVMCS mapped
> may result in its synchronization with VMCS12 and this is incorrect:
> L1 hypervisor is free to reuse inactive eVMCS memory for something else.
> 
> Inactive eVMCS after VMCLEAR can just be unmapped.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 3080e00c8f90..ea2869d8b823 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5008,6 +5008,8 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
>  				     vmptr + offsetof(struct vmcs12,
>  						      launch_state),
>  				     &zero, sizeof(zero));
> +	} else if (vmx->nested.hv_evmcs && vmptr == vmx->nested.hv_evmcs_vmptr) {
> +		nested_release_evmcs(vcpu);
>  	}

Releasing the eVMCS is a good thing not only for migration 
but for instance for nested_vmx_fail which could write to 
current eVMCS even outside of nested mode 
(there is a bug there but you fixed it in the patch 4).


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


>  
>  	return nested_vmx_succeed(vcpu);





