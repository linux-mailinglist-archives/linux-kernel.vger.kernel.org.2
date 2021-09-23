Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F237C41611F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbhIWOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241565AbhIWOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632407794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tM3g7fUHbsu5UDZIXRUIRPhWsRqGb+aH3IjlBpgEGsU=;
        b=VqRhG2tC0TwluiuLGMRhbvsdRyJvCJ6wYtsfsJe8SJcLFbmYQ2uW2bgSPaEQ/PYLtHdlMM
        fytT326rLAd/K7XELk4/R7X/OoJaEKLo2qe8wbrB0RxVklQoSMdLwOWrSrKKogOKWUQnbD
        oXUXcS3mxeGk6qswZ3EHIv0ydodYafg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-NNJg_dDINSCBkcQ0Xcdx1A-1; Thu, 23 Sep 2021 10:36:32 -0400
X-MC-Unique: NNJg_dDINSCBkcQ0Xcdx1A-1
Received: by mail-wr1-f72.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso5268911wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tM3g7fUHbsu5UDZIXRUIRPhWsRqGb+aH3IjlBpgEGsU=;
        b=YKjjPt9zACQR/k1H0heNwtqH62VvaZEPn3c4owt8y5IWTltD95O4WunBXMNVxSyHAu
         iG9meTbnisDb2VJMgmyEvwejwPozkML0nGmsX14OR+ON0Hzi8NznDlokRloSFgdXdvCQ
         KrSduapldDF3fZWBKoJUzdmlUC25m2o/ZIFYrEQxD7S1G69zGw6ikP0w4DcRSWguRRu+
         WBTV0AL8TXGLAFi/0y7IG/0bj2UrM5aF4r8T5TgvIS15qbQjOq++4ddC1/R3OwheJvMQ
         95CY7Prkzv6q3tdeWXHDXRTlG7ULQlwOomc2viVoG6X5gJWxRUT2bWvBleWiIvgpl78Q
         mong==
X-Gm-Message-State: AOAM530XBsp39TxAdrqRwMgfPbB7FXxBG5yUzGNUK21OvCoBToqYcfZ9
        W94Lf4CVtD1lwsrrtnY5vIo9UPPBLvny77B6HOimx+HDcBf7hVcEpscJ64GXKCIGsMHuJ8SFqkd
        4/QLtdRBVKaEAiFuhDMBsEao1
X-Received: by 2002:a5d:568a:: with SMTP id f10mr5484166wrv.314.1632407791682;
        Thu, 23 Sep 2021 07:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI7VO+gl5FNNX2Qjt40hO60rJs1kdwuEagO0synF/stcFYOiwV4VSXa+cDxEnaUvFMYPBXcA==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr5484141wrv.314.1632407791497;
        Thu, 23 Sep 2021 07:36:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c9sm3493853wmb.41.2021.09.23.07.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 07:36:30 -0700 (PDT)
Subject: Re: [PATCH V2 02/10] KVM: X86: Synchronize the shadow pagetable
 before link it
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org
References: <20210918005636.3675-1-jiangshanlai@gmail.com>
 <20210918005636.3675-3-jiangshanlai@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40f67a70-5076-3806-1ec7-a4ac50d13774@redhat.com>
Date:   Thu, 23 Sep 2021 16:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210918005636.3675-3-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/21 02:56, Lai Jiangshan wrote:
> +			 * It also makes KVM_REQ_MMU_SYNC request if the @sp
> +			 * is linked on a different addr to expedite it.
> +			 */
> +			if (sp->unsync_children &&
> +			    mmu_sync_children(vcpu, sp, false)) {
> +				kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> +				return RET_PF_RETRY;
> +			}
>   		}

I think we can put the sync in mmu_sync_children:

-			if (!can_yield)
+			if (!can_yield) {
+				/*
+				 * Some progress has been made so the caller
+				 * can simply retry, but we can expedite the
+				 * process by forcing a sync to happen.
+				 */
+				kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
  				return -EINTR;
+			}

Paolo

