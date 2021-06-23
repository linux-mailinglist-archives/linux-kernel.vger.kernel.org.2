Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C03B1F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFWQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624467246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnWqNpZjxa8PSj4WCQhRZUcTS8WNyX/P84LcySX9I+0=;
        b=ekcc8ZitZ1dnUx0SzJ5bHryA5WNiBhQOiy6+ktrf4PtP6wKRkWl6EpBr0Jon1Vsz2nOP14
        ebn9FeVXRpkMpjN6KSdiz19r56kKp7O5HIm/kBPM8rlejNCJcuhyFD5F3B2C+rNnVwpzWD
        ck+D6+FV0wXBnHbASJmsDKSpkve/dKk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-a4ipSI3CMRCs12-2DLnTzQ-1; Wed, 23 Jun 2021 12:54:04 -0400
X-MC-Unique: a4ipSI3CMRCs12-2DLnTzQ-1
Received: by mail-ej1-f70.google.com with SMTP id lt4-20020a170906fa84b0290481535542e3so1208982ejb.18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vnWqNpZjxa8PSj4WCQhRZUcTS8WNyX/P84LcySX9I+0=;
        b=rAzmKaDUHFylnd7vOORxe7D/Fhdg9JDXVJrBq7ohvlLLRs7j/3hUFL4q1ijBwGA2cf
         zMO3odG4Yzn2wwaCihugMLGLfvsXNtfzuuYuZtcWYxq9xObDXofg+L9BsvvxUIkfaRti
         25StNnYdDAgNMcjdTsmOYs+90G45zlBOOXF7SMjnEtsPnJl3zOJFPSS+tDn4/txIMmqL
         LGUcOFCxDc09bfOp6ZotReJ6go9PoWtrT+XF5AYoUF0fIDx57ubhv2XmE7RzxaDrVJbv
         kbzaVdaoeUptmqyytl6sVgxTeCSb/W6zTEUaW8PwyCXJPAlQybrOm3GLLi84RM0ri1p3
         eRFw==
X-Gm-Message-State: AOAM532AzelV5TNII8fl1WMct+PNkJFkxsoFiKEl+g9Q8X+EtL75/Mo4
        1NxIhHwLnFJ5/bZn1ealBomrdwptoLVAH2iUcRGZrot2SlYnlGGA498eSjAjaxCpG7P/mPcdMl1
        3xFgHvfm665WZaMsb8P4vsJSi
X-Received: by 2002:a05:6402:30a8:: with SMTP id df8mr966976edb.7.1624467243559;
        Wed, 23 Jun 2021 09:54:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO0FxB536UZ2+tuygUHR0WhBNRzPenZ91hXh6Pvei98xcu2zGCe+8AWzSElLqLVbms1mcfVg==
X-Received: by 2002:a05:6402:30a8:: with SMTP id df8mr966961edb.7.1624467243383;
        Wed, 23 Jun 2021 09:54:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id jz27sm143372ejc.33.2021.06.23.09.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 09:54:02 -0700 (PDT)
Subject: Re: [PATCH 12/54] KVM: x86/mmu: Drop the intermediate "transient"
 __kvm_sync_page()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-13-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ceaf3545-42ce-e855-bd3a-ac470edb7e08@redhat.com>
Date:   Wed, 23 Jun 2021 18:54:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-13-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:56, Sean Christopherson wrote:
> @@ -2008,10 +2001,19 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>   			goto trace_get_page;
>   
>   		if (sp->unsync) {
> -			/* The page is good, but __kvm_sync_page might still end
> -			 * up zapping it.  If so, break in order to rebuild it.
> +			/*
> +			 * The page is good, but is stale.  "Sync" the page to
> +			 * get the latest guest state, but don't write-protect
> +			 * the page and don't mark it synchronized!  KVM needs
> +			 * to ensure the mapping is valid, but doesn't need to
> +			 * fully sync (write-protect) the page until the guest
> +			 * invalidates the TLB mapping.  This allows multiple
> +			 * SPs for a single gfn to be unsync.
> +			 *
> +			 * If the sync fails, the page is zapped.  If so, break
> +			 * If so, break in order to rebuild it.
>   			 */

This should be a separate patch I think.  In addition it should point out the
place where write protection does happen, which is mmu_unsync_children:

                         /*
                          * The page is good, but is stale.  kvm_sync_page does
                          * get the latest guest state, but (unlike mmu_unsync_children)
                          * it doesn't write-protect the page or mark it synchronized!
                          * This way the validity of the mapping is ensured, but the
                          * overhead of write protection is not incurred until the
                          * guest invalidates the TLB mapping.  This allows multiple
                          * SPs for a single gfn to be unsync.
                          *
                          * If the sync fails, the page is zapped.  If so, break
                          * in order to rebuild it.
                          */

Paolo

