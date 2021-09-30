Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3B41D55F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349092AbhI3I1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348048AbhI3I1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632990327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZDlrtySWZ8aKYElfHM2QvkjVRqwG+Yrljzwwq0Gl48=;
        b=iwn1wDd6DugpCLFen0QeHSDkhmo38eEFP3atbfzEPOUzGIYOpxx2f8eX4Hj6yjUP9bu6qV
        Bs8wESJabcgVOZHc3lObe6x7v26yF0AtF96oSbse0KAXCsP6AEvYch9/q1dy4oWKSlIIn8
        cc5ucGpMcExi0xVG2M8GzyvAAxW7rHE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-z8g20zW5P4edOUrSh7Ue4A-1; Thu, 30 Sep 2021 04:25:26 -0400
X-MC-Unique: z8g20zW5P4edOUrSh7Ue4A-1
Received: by mail-ed1-f69.google.com with SMTP id e7-20020a50d4c7000000b003d871ecccd8so5407563edj.18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 01:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qZDlrtySWZ8aKYElfHM2QvkjVRqwG+Yrljzwwq0Gl48=;
        b=22nSAHVf/UHKG13zztifLLhGgZK69/12jmLvhJ+QJYPtWvfrVXk5byiQDWLU43Uhwn
         ex/+nLBoLqOorJhmTiuIz4HF1a1LR0JCfwP2FaiVmquvwPgNV459Jp4qSLeKzhY6Z93t
         K3jhLhhLWdS+vX48JH+4I0o085Ydp5Ei5el9LAKrwwejkU/NmBshTPh9eVXtdUFAAa9I
         8meJSxtklSP47xeL2aaoOd8rKcvckIsVyhiQzRxXQ497FxADukoXWJ2GkRIC1VaUqQq7
         1yVlX0Lk+IZdZNxULhrPYfQ9pjYtVruKZcf4WF7W6cCo0CiDtEqCgLWz83QNM9+xfUOs
         H1sQ==
X-Gm-Message-State: AOAM530btBAcZtREDPs3gpmZUVLw97GBjAL/CA5R4A/8VRSdBHPDflpB
        YUaIRKZx0Di7CKWNdNtUaqM6+Wdv12dyI322IgTQ4fjHyAPUohDOfAVY4jMe2L0RKHF7gvmFIUh
        DJttD3jS5eprccEj8imJzMMDS
X-Received: by 2002:a17:906:4f82:: with SMTP id o2mr5306283eju.10.1632990325031;
        Thu, 30 Sep 2021 01:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6dmrAQnGVYDpSFITeZQ5J78A0Qbz6DDf8Zt8iSZNnThEDyhAzvKmWq+5AFnH0Qaik7Pezug==
X-Received: by 2002:a17:906:4f82:: with SMTP id o2mr5306267eju.10.1632990324849;
        Thu, 30 Sep 2021 01:25:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id k7sm1052460eds.96.2021.09.30.01.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 01:25:24 -0700 (PDT)
Message-ID: <75632fa9-e813-266c-7b72-cf9d8142cebf@redhat.com>
Date:   Thu, 30 Sep 2021 10:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 2/2] KVM: x86: Manually retrieve CPUID.0x1 when getting
 FMS for RESET/INIT
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+f3985126b746b3d59c9d@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>
References: <20210929222426.1855730-1-seanjc@google.com>
 <20210929222426.1855730-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210929222426.1855730-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/21 00:24, Sean Christopherson wrote:
>  	 * RESET since KVM emulates RESET before exposing the vCPU to userspace,
>  	 * i.e. it'simpossible for kvm_cpuid() to find a valid entry on RESET.
> +	 * But, go through the motions in case that's ever remedied.  Note, the
> +	 * index for CPUID.0x1 is not significant, arbitrarily specify '0'.

Just one nit, this comment change is not really needed because almost 
all callers are using '0' for the same reason.

But, perhaps adding kvm_find_cpuid_entry_index and removing the last 
parameter from kvm_find_cpuid_entry would be a good idea.

Also, the kvm_cpuid() reference needs to be changed, which I did upon 
commit.

Paolo


>   	 */
> -	eax = 1;
> -	if (!kvm_cpuid(vcpu, &eax, &dummy, &dummy, &dummy, true))
> -		eax = 0x600;
> -	kvm_rdx_write(vcpu, eax);
> +	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1, 0);
> +	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);

