Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4D30D8A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhBCL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234217AbhBCL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612351554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEB/LyeruEcu4oLY1qq972Bq0pPdpUz5iU5q3+LYBtU=;
        b=RsRl5fMjKTfslSTE6pG7cd9MzYyeMLanY0JRLGyp16m3RvW+TD8Ay41h2MdvcMHM6Q6nFy
        hAeWDHl0vZRb10BRi6BShT0tRrNCunFdIigFSevie65GvMtJOEhH9/l47An/s2y24PE6Zq
        3JWJBSyTDbUd2INOnpPeeV3gAPcZCRk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-lH_NPUi8M5Sbp-BwQKjHMQ-1; Wed, 03 Feb 2021 06:25:53 -0500
X-MC-Unique: lH_NPUi8M5Sbp-BwQKjHMQ-1
Received: by mail-ed1-f72.google.com with SMTP id o8so11326871edh.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sEB/LyeruEcu4oLY1qq972Bq0pPdpUz5iU5q3+LYBtU=;
        b=qXjqzOub1BXNDLY4dGP5tRYJCza7yDepTjWVZ5DaJg4H08y40+JdiaqzEkhKdYfK5p
         IP2nbRdGZn6xc8cnUU4GZcWKpdBbUc4VL+2poGxaKeCKFLVIY9+1CBVe6A3TaZb3bN0R
         jxsV43dOHK3vBgQlR9mnOBNd5OWVEN7kQSaOxbcvoKJmbJSahdKc3mn4bceysj65sCYE
         jBggny0n7L0fuBQEuDiRP0cmShx5A5Lw+i5hGz2hpfv5CP19eMQqz1ogbB20jgKaXMXo
         MN9oP02g0wMobS7VGjEkgP3IhksqmiIoHE1XShKmANww4PUrKyhV3b2X/lzSexzjYArv
         F7yQ==
X-Gm-Message-State: AOAM530fcR1MTUyiRapAvN7EflLKSNJGVuv9BeKfZyzKxuQzFegcHDtd
        OSKWm+8SSdTih4NXeWp9Q7FR1rFTy681ngOKoyelQfWlJIwZvYTA3N1j0Wqecyukob6nrf3MjJw
        niXPOK6WKwZ/0PQ/61og+lB8g
X-Received: by 2002:a17:906:9588:: with SMTP id r8mr2780621ejx.167.1612351552077;
        Wed, 03 Feb 2021 03:25:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5LF7V/ZFdg7RG3zBOSMF7OAPRHvwsAl6XPGFjrumkESOYUbSt8oa9zNB8/FuSYZsHp14QOw==
X-Received: by 2002:a17:906:9588:: with SMTP id r8mr2780602ejx.167.1612351551955;
        Wed, 03 Feb 2021 03:25:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id bo24sm711966edb.51.2021.02.03.03.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:25:51 -0800 (PST)
Subject: Re: [PATCH v2 24/28] KVM: x86/mmu: Allow zap gfn range to operate
 under the mmu read lock
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-25-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fee9f2d3-85f8-30de-b198-0b69e4a78628@redhat.com>
Date:   Wed, 3 Feb 2021 12:25:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202185734.1680553-25-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:57, Ben Gardon wrote:
> 
> @@ -5518,13 +5518,17 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>  		}
>  	}
>  
> +	kvm_mmu_unlock(kvm);
> +
>  	if (kvm->arch.tdp_mmu_enabled) {

Temporary compile error.

Paolo

