Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6AB307CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhA1RtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:49:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232693AbhA1Rqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611855913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ia40WvOilz7nSgwNJj+1gY05Fmsq3ciD2xdjd10Q8I=;
        b=FqHgysWPB9Y5fyLNHtEC75kXP2nsYhx0Xwk1XbbjB+ZHHkkL7sUXc+47zTH1SC000o0bJ9
        kOBug6fiUWePrqarC6M3oZmc+h8+rNfpnelUA+sBGVDGY28U61wCW4ZZC9EEMFpnbOzouw
        F+dsegq8N+lQng5IQBOiBOCQhf7di/Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-r9KnUkvwOpSa4Rfi4kCTrQ-1; Thu, 28 Jan 2021 12:45:11 -0500
X-MC-Unique: r9KnUkvwOpSa4Rfi4kCTrQ-1
Received: by mail-ej1-f72.google.com with SMTP id by20so2531446ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ia40WvOilz7nSgwNJj+1gY05Fmsq3ciD2xdjd10Q8I=;
        b=W6VW8XmLLrnRPe0lDKrz8d2sm1/uxU6ck1BetFR63GPWb9J6eMhqJbAlwW86lfINuh
         jt/wQ8U3bklnd6ts+ImU+5OSI4w1hEFvSz8YeaCbff+TP85Dkh4DKgUfiNNfewW+oQCg
         oUHkUkvuwFGKsmd2htw5qbV3f+2XmFu/rLJSi4Xlb91/9f/LtNgJEadYiS3wOojKSeY0
         wVD5/rx60/b7g9jqiYquYNNQGm8boq7wW6wbE/GP6d26DYMf0Fnz9QwavKY6KQYXRBEF
         hCGKUOstSy0yEg3wsGxXSOaDmlb4U5+GTKA/OBD8lJyfOZfXUu1FeOVxgEFlUf5a5Uib
         AYrg==
X-Gm-Message-State: AOAM5313eUh0O39eObgbiIv9Um/1IK46Hi0ENTE4oL3+mW7flHh2AxN3
        DaWlrKtUfDciwca16PkELYZoI9Nnq6tjfubsYlJvbc0KY7pHH/EcSG8H5BSck0y49amAUpenmM4
        EgKxzCNQbNjKr4AzgCaE3xEWK
X-Received: by 2002:aa7:dace:: with SMTP id x14mr779771eds.300.1611855910389;
        Thu, 28 Jan 2021 09:45:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBGPiVvzjEVC+Ug1YWET/SGcYt3kNFgRVkbAbpEE+scOYjuDSh4WNQDHXnLmx6pMYRluRHsg==
X-Received: by 2002:aa7:dace:: with SMTP id x14mr779759eds.300.1611855910266;
        Thu, 28 Jan 2021 09:45:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id bc6sm3348248edb.52.2021.01.28.09.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 09:45:09 -0800 (PST)
Subject: Re: [PATCH v14 07/13] KVM: VMX: Emulate reads and writes to CET MSRs
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        jmattson@google.com
Cc:     yu.c.zhang@linux.intel.com
References: <20201106011637.14289-1-weijiang.yang@intel.com>
 <20201106011637.14289-8-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a73b590d-4cd3-f1b3-bea2-e674846595b3@redhat.com>
Date:   Thu, 28 Jan 2021 18:45:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201106011637.14289-8-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/20 02:16, Yang Weijiang wrote:
> 
> +static bool cet_is_ssp_msr_accessible(struct kvm_vcpu *vcpu,
> +				      struct msr_data *msr)
> +{
> +	u64 mask;
> +
> +	if (!kvm_cet_supported())
> +		return false;
> +
> +	if (msr->host_initiated)
> +		return true;
> +
> +	if (!guest_cpuid_has(vcpu, X86_FEATURE_SHSTK))
> +		return false;
> +
> +	if (msr->index == MSR_IA32_INT_SSP_TAB)
> +		return false;

Shouldn't this return true?

Paolo

> +	mask = (msr->index == MSR_IA32_PL3_SSP) ? XFEATURE_MASK_CET_USER :
> +						  XFEATURE_MASK_CET_KERNEL;
> +	return !!(vcpu->arch.guest_supported_xss & mask);
> +}

