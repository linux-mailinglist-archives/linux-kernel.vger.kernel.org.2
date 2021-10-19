Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEAA433CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhJSRCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhJSRCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634662787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRL6nOjnZK6b2+TcoLEmu3K5pdW1k8luCFoncQ412YQ=;
        b=M7AgYvtHT7Trjh2iYCaOz3s2onFx9kKS3fUUdhe6KxCBQnNNL7xjnrHoxOo7Owup0zKbrj
        XnzVBeFnigkjcaA32CiRD/fJ0WMgXtk6i8hP+E579LsHESWroSqtkkDQa78FhIZbeJnTNb
        NFDNKvDOaYvP9EZdxo9CkQW7yTXzqxg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-W2J9e-49N_iZ62zhZxVLRQ-1; Tue, 19 Oct 2021 12:59:46 -0400
X-MC-Unique: W2J9e-49N_iZ62zhZxVLRQ-1
Received: by mail-ed1-f72.google.com with SMTP id a3-20020a50da43000000b003dca31dcfc2so1811004edk.14
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yRL6nOjnZK6b2+TcoLEmu3K5pdW1k8luCFoncQ412YQ=;
        b=w4sij0jUyBvhIo8wcl13RFvPcXzQFWYRwvHRkmUBPPP9Rr+tukhkuI1WX6TEA9htr1
         kHM2G84ak7QFsFyfiV1ANkrF+38RFp+56Mh2h6AkHIQ4v6Py88r4zjgZmsQwFahcV2c7
         P32hensc5k7c6MWmeGo8FqUNPMHs1OKTQ5ac5u0Fu9G704ZYydzNQajVJEC0RxipQJU9
         Sx9sNMxnwcMAW99iJzIIKUtx2gy7rj1xhBIFcKybl0561ZC8ROvMlUc9dpu9x7NSjAuX
         JMnglvbZKLc9A8hZVHqez+3LdADGZKzGrb94qxQqj7mOC5W9YE2TOr4g6M8f71SoOOc7
         51oQ==
X-Gm-Message-State: AOAM530pVl1YpMt90EJDAGabOveu0hO/Zjp8enx9KSi0tSrq/4QBtLCT
        Jqe7hG8ZQdNhy09hshP7ONl8yAx+CN13xICozNbhiRprcza/7MRVrY4R6HBfMNg3LptV95xpHWl
        P/6kSzgD9GeJSNHijSr003JKm
X-Received: by 2002:a17:907:1006:: with SMTP id ox6mr39717453ejb.146.1634662785168;
        Tue, 19 Oct 2021 09:59:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqI0DI3vHAHu36Mp/AOE/8zmn2909YkRm8xBz5go4Ysf4/It0HRvh0G4456fXpfkQ2JUaAcw==
X-Received: by 2002:a17:907:1006:: with SMTP id ox6mr39717415ejb.146.1634662784936;
        Tue, 19 Oct 2021 09:59:44 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8e02:b072:96b1:56d0? ([2001:b07:6468:f312:8e02:b072:96b1:56d0])
        by smtp.gmail.com with ESMTPSA id l19sm12897787edb.65.2021.10.19.09.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 09:59:44 -0700 (PDT)
Message-ID: <24e67e43-c50c-7e0f-305a-c7f6129f8d70@redhat.com>
Date:   Tue, 19 Oct 2021 18:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 3/3] KVM: vCPU kick tax cut for running vCPU
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1634631160-67276-1-git-send-email-wanpengli@tencent.com>
 <1634631160-67276-3-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1634631160-67276-3-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/21 10:12, Wanpeng Li wrote:
> -	if (kvm_vcpu_wake_up(vcpu))
> -		return;
> +	me = get_cpu();
> +
> +	if (rcuwait_active(kvm_arch_vcpu_get_wait(vcpu)) && kvm_vcpu_wake_up(vcpu))
> +		goto out;

This is racy.  You are basically doing the same check that 
rcuwait_wake_up does, but without the memory barrier before.

Also here:

> +	if (vcpu == __this_cpu_read(kvm_running_vcpu)) {
> +		WARN_ON_ONCE(vcpu->mode == IN_GUEST_MODE);

it's better to do

	if (vcpu == ... && !WARN_ON_ONCE(vcpu->mode == IN_GUEST_MODE))
		goto out;

so that if the bug happens you do get a smp_send_reschedule() and fail 
safely.

Paolo

> +		goto out;
> +	}

