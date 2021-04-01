Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA5351CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhDASWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235668AbhDASDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617300193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGo5aCFzWLPFdqWarT9HN3GzQnGQRhvp+99kHe7viFs=;
        b=BETwC2IxVwBlQgxuonQXOx8ghDDLuEWoCmuITmk3BtzJqlM7raoEAwoiiXnZgMMOZRE5Y9
        0sbDGnLwG2F5u7vHlS4pi7Dux0T/aJnzC5hL4AD/8cdSfO68oXMzk3Jy+8e4DAzHkobG5h
        oo9dA9p9sd/k84kX6D3Dh4BNVgbZhgk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-vowpUZJBNGeCFQPwvda6pA-1; Thu, 01 Apr 2021 13:02:47 -0400
X-MC-Unique: vowpUZJBNGeCFQPwvda6pA-1
Received: by mail-ej1-f69.google.com with SMTP id a22so2479185ejx.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 10:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YGo5aCFzWLPFdqWarT9HN3GzQnGQRhvp+99kHe7viFs=;
        b=E89jKCLchU07O4od+BRgWOVLWNIVcJKm7eaX1NN8ConjFC9FNxNgWilkKZc4+exHgK
         uC0DW477wGUS/zWv7Cg0eEAA8SdDq8FJSy7pzqkToly1ITI7qCZ545vkqhleO94PYKyd
         xli6sKjFimUdVHU3G2q84N+nPyWf0vV7x/W10s96vHtGLKLxEvOItlxyDIX+5mbABJRX
         pZ1xp1CAisArz3Yq09jexGH1G5A5Lu9Ww9eFIDuA6XoivAhsV374HwOnx8KH/CGllWOj
         ltWB/bpA8jLU9LvG1iSS8HSq72/1EYz03tPOHLmotE5Ub9r3FFD6YI0kfdcVhHtW57ye
         zTiw==
X-Gm-Message-State: AOAM533Spw2v2RrVBwd4c/iITwp09DFDNM5iSZNMIv+Z5G/OH6sB536v
        dW1An5Sotg4IpVpX2WHLG38CUYL6sqkY/8tJPMGN/i8MuqQ6i5k08H0qnaA0YEj+PZPkxGXzeOx
        0Xb/ZsycvyU95ZPY7PDfKyHMH
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr10915645edu.52.1617296565738;
        Thu, 01 Apr 2021 10:02:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzolAWMkpQ5Y9P+YUh5Vnzzb+VXLCMKbrUQiiJrWsH/T62mYb0n7+YgohunYzJ3M+hzu7GIA==
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr10915628edu.52.1617296565600;
        Thu, 01 Apr 2021 10:02:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n25sm3875720edq.55.2021.04.01.10.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 10:02:44 -0700 (PDT)
Subject: Re: [PATCH 12/13] KVM: x86/mmu: Fast invalidation for TDP MMU
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210331210841.3996155-1-bgardon@google.com>
 <20210331210841.3996155-13-bgardon@google.com>
 <79548215-b86f-99de-9322-c76ba5a1802d@redhat.com>
 <CANgfPd_wFMFQgqSG9gi5zo3=WMGVST-66DkNJTopvTBZoangmQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <701dd0d8-79a3-29c3-c184-bd93a136f8b3@redhat.com>
Date:   Thu, 1 Apr 2021 19:02:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd_wFMFQgqSG9gi5zo3=WMGVST-66DkNJTopvTBZoangmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/21 18:50, Ben Gardon wrote:
>> This is just cosmetic, but I'd prefer to keep the call to
>> kvm_tdp_mmu_invalidate_roots at the original place, so that it's clear
>> in the next patch that it's two separate parts because of the different
>> locking requirements.
> I'm not sure exactly what you mean and I could certainly do a better
> job explaining in the commit description, but it's actually quite
> important that kvm_tdp_mmu_invalidate_roots at least precede
> kvm_zap_obsolete_pages as kvm_zap_obsolete_pages drops the lock and
> yields. If kvm_tdp_mmu_invalidate_roots doesn't go first then vCPUs
> could wind up dropping their ref on an old root and then picking it up
> again before the last root had a chance to drop its ref.
> Explaining in the description that kvm_tdp_mmu_zap_all is being
> dropped because it is no longer necessary (as opposed to being moved)
> might help make that cleaner.

No, what would help is the remark you just made about 
kvm_zap_obsolete_pages yielding.  But that doesn't matter after 13/13 
though, does it?  Perhaps it's easier to just combine them.

Paolo

