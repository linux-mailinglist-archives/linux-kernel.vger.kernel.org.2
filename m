Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B963F3513C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhDAKle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232565AbhDAKlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617273664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbaTvFT9jV915Hh2tSzMnC9qOGARRNTOWV6YJrRhpRs=;
        b=DnUPfSHo/3dvAN77RpHLun8eQe3UBJIdnK0tcoTHkmclc4AVZv1F5XmaU+KwrlYBsBzpph
        UZ2tRA0hWM2CZneW6+FROC8zGaf/Pm6+P/I5GmgecYJ4OxL/O6oDnAgEAwQ0EbVRKcsfQE
        r922ySjChglUBsbPNB/t8x78YzToAbM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-5VfAc2lTM1OtSR0wFH42Vw-1; Thu, 01 Apr 2021 06:41:03 -0400
X-MC-Unique: 5VfAc2lTM1OtSR0wFH42Vw-1
Received: by mail-wr1-f72.google.com with SMTP id n16so2539300wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 03:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CbaTvFT9jV915Hh2tSzMnC9qOGARRNTOWV6YJrRhpRs=;
        b=OPrsk9TUhTvu0PkPW61TTMGs8tnLD3gt5kJqw/xrvgmjPbAWeOzwjeOZ2DU2Y2ACFF
         eK4royxJbTEcSQRCfl8gxnmHCy99WvXQhoELgKR7E9F+tHm4SGIQ7oWps4+clDhf3Wad
         hwmAQ7J561+jQAkcqXMplRmn6Pvecr1yzH8Sn4qp7WEdOTX7qza64Vj5oUUkQOupSGs7
         Hnvet0T3UKUrkdPbooJyh1nPxpwjCfqK/VhrfWPC8UeAX+EfdcvTiRLFPmNRd/I5kF6C
         KKHhBNIgiWR7wBNAzqRa+fTAABDJdZlQRMFvijDKSB8yPUvGviHiHe3msEvTlkuyug5e
         k/XQ==
X-Gm-Message-State: AOAM532anxtyJuVf9DVY604YQJV/9FiLtWSs7qI9/CFvdbbbH+yYL1AK
        +6ald/p8UramTuesm8+lY2SItTN4KPszF+IuWzEwQe3hooF7KTsbgkfvNhcOfdzTw6fwZ+fu/Mz
        k5V4cL9vBbzQL+wVpICoM3Ib3
X-Received: by 2002:a5d:4582:: with SMTP id p2mr8757243wrq.34.1617273662151;
        Thu, 01 Apr 2021 03:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsj33kTXQgfYY9muxulNGXdA3guJ/A5QPfb4dIyEUtaXTPvlUwaH3PhUPRfj3yFTOi1zGcSg==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr8757224wrq.34.1617273661994;
        Thu, 01 Apr 2021 03:41:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u20sm9714996wru.6.2021.04.01.03.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 03:41:01 -0700 (PDT)
Subject: Re: [PATCH 13/13] KVM: x86/mmu: Tear down roots in fast invalidation
 thread
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210331210841.3996155-1-bgardon@google.com>
 <20210331210841.3996155-14-bgardon@google.com> <YGT31GoDhVSXlgP4@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca227500-9fe9-0600-065c-70e02916488f@redhat.com>
Date:   Thu, 1 Apr 2021 12:41:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YGT31GoDhVSXlgP4@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/21 00:29, Sean Christopherson wrote:
>> +	if (is_tdp_mmu_enabled(kvm)) {
>> +		read_lock(&kvm->mmu_lock);
>> +		kvm_tdp_mmu_zap_all_fast(kvm);
> Purely because it exists first, I think we should follow the legacy MMU's
> terminology, i.e. kvm_tdp_mmu_zap_obsolete_pages().
> 

It's a bit different, obsolete pages in kvm_zap_obsolete_pages have an 
old mmu_valid_gen.  They are not invalid, so it is inaccurate to talk 
about obsolete pages in the context of the TDP MMU.  But I agree that 
the function should be renamed.

Paolo

