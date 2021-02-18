Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABB31EB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhBRPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233003AbhBRM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613652901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoL5IJK0wnV3SqWAZzfyOHTiK74bBoRTJKaiC70tzO8=;
        b=MucdpXr0wTSv7pFO8oPpOYqN8chxMeDjz9bUDsj6BjKXUveA9qVi0TLea3mXYByQ84B2dx
        2ZcQMDmytmqnQxdeax4T7vPmNU5Sa3AsJxIO6Xhnxjk4bvf0SDUS+WXh5f9G8MVyaiGSFx
        KxFzJ8aHZJjL0clSM+UN/PbvHMM6So4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-NgKUGm02NNSyQyNz8lmLoQ-1; Thu, 18 Feb 2021 07:43:48 -0500
X-MC-Unique: NgKUGm02NNSyQyNz8lmLoQ-1
Received: by mail-wr1-f71.google.com with SMTP id y6so930344wrl.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CoL5IJK0wnV3SqWAZzfyOHTiK74bBoRTJKaiC70tzO8=;
        b=lSdvbXMl+FLtX21MgegBvPa+22z+fhyokYbcRlV56qpQLKQzBCqm5jE79IP2Qvzk7T
         M0T6rmZGVvKCKdJlSP0ynLw7hCDzEfjA3Wedohs4UUVy/gEtwj5iRQfTQpMtxeP9P8gi
         sN5UDM7F5lO8n6SKM7DnhEWLfgwDTg54qOyhsaRxViwVqt5jnHjbLDcQ+adV1JJxriSh
         pMfNRv4TQaN4KQnR2Ciw6itb0DwNx5QXrTWoGeMS45uNzIm71Dp10Ygj5ULVs+kFWpF+
         jgx5keUiyO9pyP757OSpvoP6Wbmc44nceMOuRjtdSm4ZbUPVQEc8tqnvHWg1ki6qC5A1
         g8pA==
X-Gm-Message-State: AOAM530kOOTYyiQhabcgWy13RQy1VO5FNh88rIsD8eSGzb94ogfJ3qy5
        q1kRwMpHoLKJ6ODR2AXJpdbpIOOMEiOCKnkfTg5IJ3eMJEYz7VOuyf2b6yX9/BsOZ00byJMqlHf
        6+WK2bc0rqmFIbU4hgS+sqKZh
X-Received: by 2002:a1c:a795:: with SMTP id q143mr3483813wme.113.1613652227235;
        Thu, 18 Feb 2021 04:43:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBAxO15MXr//rnlF6I63/pZVcDmGH1FrUfG45+6JzkNwp43de8h/44CFBi0vu3YcmP57i4Lw==
X-Received: by 2002:a1c:a795:: with SMTP id q143mr3483790wme.113.1613652227023;
        Thu, 18 Feb 2021 04:43:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id z8sm8474317wrr.55.2021.02.18.04.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 04:43:46 -0800 (PST)
Subject: Re: [PATCH 05/14] KVM: x86/mmu: Consult max mapping level when
 zapping collapsible SPTEs
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20210213005015.1651772-1-seanjc@google.com>
 <20210213005015.1651772-6-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <caa90b6b-c2fa-d8b7-3ee6-263d485c5913@redhat.com>
Date:   Thu, 18 Feb 2021 13:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210213005015.1651772-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/21 01:50, Sean Christopherson wrote:
> 
>  		pfn = spte_to_pfn(iter.old_spte);
>  		if (kvm_is_reserved_pfn(pfn) ||
> -		    (!PageTransCompoundMap(pfn_to_page(pfn)) &&
> -		     !kvm_is_zone_device_pfn(pfn)))
> +		    iter.level >= kvm_mmu_max_mapping_level(kvm, slot, iter.gfn,
> +							    pfn, PG_LEVEL_NUM))
>  			continue;
>  


This changes the test to PageCompound.  Is it worth moving the change to 
patch 1?

Paolo

