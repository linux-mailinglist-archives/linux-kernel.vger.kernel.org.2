Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455D0306226
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhA0Rfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:35:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235791AbhA0RcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611768653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkzfQ7JLhuJiuzMMsy2O4iFme8poGbCus8N/6ZyaesA=;
        b=CAF7VA5NwxuaBgga7JSMP/KRZGVghboF7UKup62Swc07ZvCNT34ph/Jh446cCa0Lgqld3G
        rQ2GMLYog5QYtrP94pf7sqb1TaH5rZyh7Au1zQObOFU0ZQpnEompQ/ymbBTbdn9J69kWhB
        W3kadj7ze6bEgV7Fg4AAmtNMPEr5o6U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-kWTOu2AHNk6WPfuQF6Qg9Q-1; Wed, 27 Jan 2021 12:30:51 -0500
X-MC-Unique: kWTOu2AHNk6WPfuQF6Qg9Q-1
Received: by mail-ej1-f72.google.com with SMTP id x22so973508ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XkzfQ7JLhuJiuzMMsy2O4iFme8poGbCus8N/6ZyaesA=;
        b=lwOL9bjDDfOVJpYXSevbwNGzVbu7zjEpvnXPAhjJmZlredl23ZwgJVJSbN+OVAaP3s
         bb1ffij9XG5gduewCxrS3qBkBipYc0kTuXOZNdmFiD8/orh8lIqq1jvj0S+TnDGo0diD
         SFy6F8v1OTS8L65lSjeUC+8lB8/GsM7n49AdAmcalnKpSeK3NCEMkcZWcTy3iXyTRdjl
         BHj9NZefJH6IGjRXrf5eWIoLS0HzE3cnhkYUr767mUG0Mf01zblqP2RG2fathg1UN+WG
         KFJVL7tGmf8a0h1KYFueXa/ObZZNg+S/DgcO4LV9/GFONL0Br/xuwo+4jjbuZ3hqzM/P
         dFhQ==
X-Gm-Message-State: AOAM530adqEAR+V6KxhawIas10GAkGYoQrLaePTtYEXK7jElNJ7vk6fQ
        +N8lp2g9cXUieVXRbliPc2yLqi3Y4/L8+4pSVjnw1f13RwkUMBjkZ2MQIE+abkyowsVLpWWlak1
        Uw/LNbHYSFbTx3oNBYA5sGjKM/QnP+z4aJxe8J9n7HHuCdkX74D3x4TbT9F7a8Cfq4prZWshHtK
        zi
X-Received: by 2002:a17:906:7e42:: with SMTP id z2mr7688500ejr.177.1611768649569;
        Wed, 27 Jan 2021 09:30:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMmG2yA1LAIObXA6TKj+pk8FnGymREzDd1DtQq6L/KnoQ2xvOyjL1grH7QVqQIMxLWVgnaPQ==
X-Received: by 2002:a17:906:7e42:: with SMTP id z2mr7688476ejr.177.1611768649261;
        Wed, 27 Jan 2021 09:30:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f20sm1687594edd.47.2021.01.27.09.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 09:30:48 -0800 (PST)
Subject: Re: [PATCH v3 01/11] KVM: x86: Get active PCID only when writing a
 CR3 value
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201027212346.23409-1-sean.j.christopherson@intel.com>
 <20201027212346.23409-2-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e56d38bf-bc07-ebfb-5bec-60c60d664447@redhat.com>
Date:   Wed, 27 Jan 2021 18:30:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201027212346.23409-2-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/20 22:23, Sean Christopherson wrote:
> 
> +static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
>  			     int root_level)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	unsigned long cr3;
>  
> -	cr3 = __sme_set(root);
> +	cr3 = __sme_set(root_hpa) | kvm_get_active_pcid(vcpu);
>  	if (npt_enabled) {
>  		svm->vmcb->control.nested_cr3 = cr3;

SVM uses the name "nested CR3" so this variable actually could represent 
an NPT value that does not need the PCID.

Therefore, this change must be done in an else branch, which I've done 
on applying the patch.

Paolo

