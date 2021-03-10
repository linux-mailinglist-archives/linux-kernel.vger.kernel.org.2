Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6678A33384D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhCJJIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:08:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232833AbhCJJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615367290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onwH43buJY+4pRwy25T93B+uL+ekLSAj/zUQnTgwwtE=;
        b=PkQfVXGnDBYxl3yI083pQK1ahqiucUJbA/lf5SahQUO86M0ZbndaQmTIKaLx8253nDN6RP
        lIatB/RruuE9S2WvS/Q6S3VvKpYqDMzSaheqDK+c75pJiRScoZ6cwNEkzlFz3Z7WIhb5ts
        M/Xy21QI4FVLpeEuwwODTDMx5p97Jng=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-noT44Bw_NiCn6ljmHLTwFg-1; Wed, 10 Mar 2021 04:08:08 -0500
X-MC-Unique: noT44Bw_NiCn6ljmHLTwFg-1
Received: by mail-wm1-f71.google.com with SMTP id v5so2368575wml.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=onwH43buJY+4pRwy25T93B+uL+ekLSAj/zUQnTgwwtE=;
        b=Th63RUeE1wLOS7lDGgetkiogMuzISeL5h29ER5inA5nxXTw2OLBcKBaPkC/d5Wa1X3
         7xTguJvw6VPdaUzJ0xqWwjhht/XmuAiM5ucr7xu9uBZfudWV5A45AmPf25qOADcgep41
         jNBKJG7o+csjpEZEWKgup5dV/Oevs0c1YZtElfxWIC/43GJiTI0L6TjZPmjTAMYbLeRg
         oB4jb/ePwyKszTyRspwB+rTwXnMv13ZCFN6U6aZcOZItbv3q5bBiK45/feEzKU7qA1F3
         2gXph7IHpymh2myhN6baR6BM1boi3Y5j6oaF2ao5mAp4SulDMsN/JyLaSPOXB2t7rXqy
         Wa+Q==
X-Gm-Message-State: AOAM532w2t0YQlkKUCisyhMDE3ms0WIaYaIrc53GMYq6k3hjadIyM+QF
        4ffeEPNUpHNTuaTaQb9YNXbMiN/RGcEveAbLvp6zK01p+Q2juhkt0EZ6qDZ/qPj55xOFzK1HBc3
        IdlNYji+bCYbDz4aq8YJk50hy
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr2273601wmg.108.1615367287035;
        Wed, 10 Mar 2021 01:08:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxramH2RbQZZh5ShQMu5/BRgsJl/CJyoOFHUKPgMzohma+8iv89kZpKLk/HpIKp0RgVaXnbw==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr2273576wmg.108.1615367286880;
        Wed, 10 Mar 2021 01:08:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n66sm7934392wmn.25.2021.03.10.01.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 01:08:06 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Skip !MMU-present SPTEs when removing SP in
 exclusive mode
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
References: <20210310003029.1250571-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <07cf7833-c74a-9ae0-6895-d74708b97f68@redhat.com>
Date:   Wed, 10 Mar 2021 10:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210310003029.1250571-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/21 01:30, Sean Christopherson wrote:
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 50ef757c5586..f0c99fa04ef2 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -323,7 +323,18 @@ static void handle_removed_tdp_mmu_page(struct kvm *kvm, u64 *pt,
>   				cpu_relax();
>   			}
>   		} else {
> +			/*
> +			 * If the SPTE is not MMU-present, there is no backing
> +			 * page associated with the SPTE and so no side effects
> +			 * that need to be recorded, and exclusive ownership of
> +			 * mmu_lock ensures the SPTE can't be made present.
> +			 * Note, zapping MMIO SPTEs is also unnecessary as they
> +			 * are guarded by the memslots generation, not by being
> +			 * unreachable.
> +			 */
>   			old_child_spte = READ_ONCE(*sptep);
> +			if (!is_shadow_present_pte(old_child_spte))
> +				continue;
>   
>   			/*
>   			 * Marking the SPTE as a removed SPTE is not

Ben, do you plan to make this path take mmu_lock for read?  If so, this 
wouldn't be too useful IIUC.

Paolo

