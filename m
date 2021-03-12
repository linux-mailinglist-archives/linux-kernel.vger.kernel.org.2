Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820EC3395F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhCLSNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232583AbhCLSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615572763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUWzsLoozTTcmn+QM4/07lmzU/Q0q3Sz+mnRlNZfAzk=;
        b=INAqgMAKrQuXchmdIKzDER7AH58tVY39Uf3XwZ8vlgOYoq6szsq7hvtZaRwC8IAQR5bkTW
        uY7Z6KdrGxM+a90lBLPle9zzaqcJxYU7TWKU++ZA2QRw4itDeSAj5eXdk233Ek/VnxsDiP
        2VEGP7OVNLdtsbObiUZvcVnh1T13No4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-JDOJPHotM9OL9hGEoC1SFA-1; Fri, 12 Mar 2021 13:12:42 -0500
X-MC-Unique: JDOJPHotM9OL9hGEoC1SFA-1
Received: by mail-wr1-f71.google.com with SMTP id e13so11505944wrg.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUWzsLoozTTcmn+QM4/07lmzU/Q0q3Sz+mnRlNZfAzk=;
        b=XkpJC8nIprXAmwbX32xub4Ma/JA0WK/eGGdpR3BkgQJGm7D8rOjv9UemCX1k1ZNMhg
         zGJcREnXJKdmVnzrD0jjQ3Ta8hdheqI2fETexU+VNvLkF3J/W7SImpq9pA20L7ot1trq
         WtI4bBM3eECF/YTi4neqTvVg/9hESlZ4Xi7QWvgbmbEm6MO+TT0h4y5Ym3yPBJaUf/6O
         fIHVkjcH47QG32LjFIz/0LSzQD9SsXeRMaV3NVw+hfSQmFkJhUKNh4wIhIv6GyxPjT8L
         bNbLTm5TGzFxuhdZzPt4jk4XhL2v4qypGj7dRpPqiQElRR8/pPANb0dU4QSCVnr4ZHv2
         kioA==
X-Gm-Message-State: AOAM530Wkil3e7y1trv7+J+fZuuB7CQZ7wrRcftZNBftLQuZnaxNskcU
        LRp0OeiJZL0H9DTNWd8dqCnb31e/HXaeOCAhBBJr5EHL+WO1d/PHzUyIa6Rv9UxQLFqN+d8RLK/
        oX5c3KyJ5M+slIQZ0euPfOKCy
X-Received: by 2002:adf:ed12:: with SMTP id a18mr15415218wro.249.1615572761164;
        Fri, 12 Mar 2021 10:12:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJym36OZic3ZRkbaPewaIje3WJ+KPnJYffgTAjPe0HcOubZ8vFfEijSDsNnGkLSpNfH17jA+/w==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr15415199wro.249.1615572761003;
        Fri, 12 Mar 2021 10:12:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n6sm10113288wrw.63.2021.03.12.10.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 10:12:40 -0800 (PST)
Subject: Re: [PATCH v2] KVM: LAPIC: Advancing the timer expiration on guest
 initiated write
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1614818118-965-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4dd4f7c2-bd9e-31a9-3eec-86a96203b66f@redhat.com>
Date:   Fri, 12 Mar 2021 19:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614818118-965-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/21 01:35, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Advancing the timer expiration should only be necessary on guest initiated
> writes. When we cancel the timer and clear .pending during state restore,
> clear expired_tscdeadline as well.
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>   * update patch description
> 
>   arch/x86/kvm/lapic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 45d40bf..f2b6e79 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2595,6 +2595,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>   
>   	apic_update_ppr(apic);
>   	hrtimer_cancel(&apic->lapic_timer.timer);
> +	apic->lapic_timer.expired_tscdeadline = 0;
>   	apic_update_lvtt(apic);
>   	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
>   	update_divide_count(apic);
> 

Queued, thanks.

Paolo

