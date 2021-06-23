Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C73B1ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFWQk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWQk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624466318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzECnKDBmIvo/ujBqWPH8Hf50HLw/m8oX6rv0gXcfxQ=;
        b=XSlkvbokyar+XZML9HJbUVvoPPFZmCiixzpkarB5H91o00rtjvUEyZiRzx22cGcdxjaCnO
        OuFN7YSSBOvVp31A4uFJAnULnU6QD0b/RKsrik9aXP/8eibu3xjrf28DBoKO4+lNcppOmK
        YpOgrruJRRmjLQ6KSaFSPZt8U9bZn10=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-h-qh4zrGPiqGaNlfATuzAQ-1; Wed, 23 Jun 2021 12:38:37 -0400
X-MC-Unique: h-qh4zrGPiqGaNlfATuzAQ-1
Received: by mail-ej1-f69.google.com with SMTP id u4-20020a1709061244b02904648b302151so1187440eja.17
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZzECnKDBmIvo/ujBqWPH8Hf50HLw/m8oX6rv0gXcfxQ=;
        b=AtN+j+LdzA6X/nu5+9XWrBi4dsxTnJ1IpYspiElaPOJZgk6cdL90duz2OIQTg2E7SQ
         WT9UW7Am73qMQF983eK6LONue0NZ4wONEUjYQrB4xPiBWFMu/wpxbRX8DR0Kg0vtP7wC
         OgwgRQx8rPUzyCOvapizcGxxt1IAN2NfnSE6uj6xPWjh03/zBgWPR5au8dmxS+F3Uu2T
         TlI+aFHMSrx39GbCvRaswzHvB4FdFK/vLSieHyZ8jM+cAUDlDqW7oCPPSMQyFd/e7oCc
         mVfI+PdQ8jS+ChqfJQWUxfdn33599+MhRqWpUEbR3WsxATLzO1NDpBYS4TaIkObLxOoZ
         npYA==
X-Gm-Message-State: AOAM532hG6BNI1+GVI2rNg189ISdqCfF/cXiS72dD3/FFuZBFHwD7YIb
        nXyNu0tEuR8ur6VGEXIjhtRnp7Hj9I5sSrS/zg7cW2iCPFwa+n7ODR0bT6TrrhsWYkyA+l39Tt8
        LKCmGBLf0X4Wa+HNSbn6nJT00
X-Received: by 2002:a17:907:98c4:: with SMTP id kd4mr943068ejc.119.1624466315855;
        Wed, 23 Jun 2021 09:38:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdyc0GxzXAVwYD9leeHbZf3Ojn8RjxXdUDPOsa5C3q1WvM24iq/adb2MXELwzuVvE/n2m6Zw==
X-Received: by 2002:a17:907:98c4:: with SMTP id kd4mr943052ejc.119.1624466315643;
        Wed, 23 Jun 2021 09:38:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d6sm318843edq.37.2021.06.23.09.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 09:38:34 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-10-seanjc@google.com>
 <f2dcfe12-e562-754e-2756-1414e8e2775f@redhat.com>
 <YNNOeIWqNoZ3j8o+@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/54] KVM: x86/mmu: Unconditionally zap unsync SPs when
 creating >4k SP at GFN
Message-ID: <f13fcf5b-f6bc-fb95-6f69-ea524ae446f5@redhat.com>
Date:   Wed, 23 Jun 2021 18:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNNOeIWqNoZ3j8o+@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/21 17:08, Sean Christopherson wrote:
> Because the shadow page's level is incorporated into its role, if the level of
> the new page is >4k, the branch at (1) will be taken for all 4k shadow pages.
> 
> Maybe something like this for a comment?

Good, integrated.

Though I also wonder why breaking out of the loop early is okay.  Initially I thought
that zapping only matters if there's no existing page with the desired role,
because otherwise the unsync page would have been zapped already by an earlier
kvm_get_mmu_page, but what if the page was synced at the time of kvm_get_mmu_page
and then both were unsynced?

It may be easier to just split the loop to avoid that additional confusion,
something like:

         /*
          * If the guest is creating an upper-level page, zap unsync pages
          * for the same gfn, because the gfn will be write protected and
          * future syncs of those unsync pages could happen with an incompatible
          * context.  While it's possible the guest is using recursive page
          * tables, in all likelihood the guest has stopped using the unsync
          * page and is installing a completely unrelated page.
          */
         if (level > PG_LEVEL_4K) {
                 for_each_valid_sp(vcpu->kvm, sp, sp_list)
                         if (sp->gfn == gfn && sp->role.word != role.word && sp->unsync)
                                 kvm_mmu_prepare_zap_page(vcpu->kvm, sp,
                                                          &invalid_list);
         }

Paolo

