Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD820452E54
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhKPJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232326AbhKPJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637056004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fc0gngviw+IZIFxYalZL+iadKVgfg2lYYkw0vHrMjNs=;
        b=QbR1ciX3tLM6g4dkKlMBaTjICIk+VuCNgHLSFY4UaMfwAC3KipC009sa+puyjvfhd9eRnb
        kRRZR6kVTYPs5UUbpOFkoRtlOc3KhBHrNTfagj9V1Xy1ciDlckdbYstpndMgwCobGXnybE
        KvRb/7IM1ul/XUMtcFyz5lSTirrD6yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-vYO4E3Y2OJOwOt0j00Id4g-1; Tue, 16 Nov 2021 04:46:39 -0500
X-MC-Unique: vYO4E3Y2OJOwOt0j00Id4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BD291923769;
        Tue, 16 Nov 2021 09:46:37 +0000 (UTC)
Received: from [10.39.192.245] (unknown [10.39.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69C385DF5D;
        Tue, 16 Nov 2021 09:46:30 +0000 (UTC)
Message-ID: <1f7c6347-368b-0959-d506-a938f2585591@redhat.com>
Date:   Tue, 16 Nov 2021 10:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] KVM: Fix steal time asm constraints in 32-bit mode
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        kernel test robot <lkp@intel.com>, kvm <kvm@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>, karahmed@amazon.com
References: <202111141550.hY7mszt8-lkp@intel.com>
 <89bf72db1b859990355f9c40713a34e0d2d86c98.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <89bf72db1b859990355f9c40713a34e0d2d86c98.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/21 09:59, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> In 64-bit mode, x86 instruction encoding allows us to use the low 8 bits
> of any GPR as an 8-bit operand. In 32-bit mode, however, we can only use
> the [abcd] registers. For which, GCC has the "q" constraint instead of
> the less restrictive "r".
> 
> Fixes: 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time / preempted status")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/x86.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8f156905ae38..0a689bb62e9e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3307,7 +3307,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>   			     "xor %1, %1\n"
>   			     "2:\n"
>   			     _ASM_EXTABLE_UA(1b, 2b)
> -			     : "+r" (st_preempted),
> +			     : "+q" (st_preempted),
>   			       "+&r" (err)
>   			     : "m" (st->preempted));
>   		if (err)
> 

Queued with the addition of the "m" -> "+m" change, thanks.

Paolo

