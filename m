Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA4358361
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhDHMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbhDHMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617885470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69zA1bhHptdUoU8kGQcTxZKNjzEk/X7EQu4AbY435gw=;
        b=JgWb/lOOMHWA5V3U+B+xDkfP86hjxDxD7hYxCElBE2F2k/Zd8EszgoAdaD5CaPc7CabIT0
        xilmywEsPS+GK+Frhm0U/+Yo2dS8zx4Xx4cJbAewaBQQwOejCC8BCqVcQ1PAusr/q6yW0L
        JLUTB9JGrzRJ4LNbLhrEFSMoKtGs/eI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-FIEg1IUaPDqmkbFW4Dq2-g-1; Thu, 08 Apr 2021 08:37:49 -0400
X-MC-Unique: FIEg1IUaPDqmkbFW4Dq2-g-1
Received: by mail-ed1-f69.google.com with SMTP id l11so966842edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 05:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=69zA1bhHptdUoU8kGQcTxZKNjzEk/X7EQu4AbY435gw=;
        b=h9vMvLwknWXODyP6jU0r+L6mrHiBvRpBLDE3yrPbgDaQ3YmWVzkX2OVAa9rtMuwKjd
         UASxYhS43t2CXQvAIJ1+I7udm1J/ymHJDkBKq5C9BsmQQr/aeElnqhwe0B2pa48Wn0ne
         6Fpa0VxguMjHwNV2ZcJh+pi/3XwQd5jr5L1Ef6b0/ZtHojxDHmwlOhPdUithgMp+BER2
         0sJLjgQno6kT6bU/0SsINnS4PqCNtvgz2mfr4Bqx/l9Rs8CkVppQyYHy8TCxK6/qkztE
         gNpgpC4p2P4Zu0STTcJ+uL36bcFw7RD5T+G/LOgiAywDhza6iGQSjnKqdvepsNXEMvdL
         kgQQ==
X-Gm-Message-State: AOAM530y8sg1OlX0p7UsChW04o+zMRFVo6osJs3bpPqqHP8vKVHvpxXk
        uCLM4nMA5nAzQnWobQ7ztG/nYnCj68io6i97GRjI9J33slYxfg4M1n5I0BRWzFCeclIs8EIwnSr
        ZCZjFLG1Z2cLIBJiwQkFs9xyI
X-Received: by 2002:a05:6402:8d0:: with SMTP id d16mr11466691edz.188.1617885467876;
        Thu, 08 Apr 2021 05:37:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw76kziLfjbuXhsqlp1TrtaLd1hK1hbVJFzsqDBDTZxforS60mer4C1Apk6o11RACcFo9O6+w==
X-Received: by 2002:a05:6402:8d0:: with SMTP id d16mr11466668edz.188.1617885467742;
        Thu, 08 Apr 2021 05:37:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v8sm17388506edc.30.2021.04.08.05.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 05:37:47 -0700 (PDT)
Subject: Re: [PATCH 3/4] KVM: x86: kvm_hv_flush_tlb use inputs from XMM
 registers
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210407211954.32755-1-sidcha@amazon.de>
 <20210407211954.32755-4-sidcha@amazon.de>
 <87eefl7zp4.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <01fc0ac9-f159-d3df-6c8c-8f8122fe31ea@redhat.com>
Date:   Thu, 8 Apr 2021 14:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87eefl7zp4.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/21 14:01, Vitaly Kuznetsov wrote:
> 
> Also, we can probably defer kvm_hv_hypercall_read_xmm() until we know
> how many regs we actually need to not read them all (we will always
> need xmm[0] I guess so we can as well read it here).

The cost is get/put FPU, so I think there's not much to gain from that.

Paolo

