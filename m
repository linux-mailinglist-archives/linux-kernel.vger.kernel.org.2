Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1626F37315F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhEDU1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhEDU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620159988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmaFtxsE0S5qvJK+FcOeAQOG1JYRVA5bDwB/1VM2dIk=;
        b=b5OgF74wSIRBoNp6w1fMbpVGRyMFdZdhajCW4GglbqiKC8MnhOIX4mlsjCshmGXJnhac8E
        PNKLdJNuhBHwMF1jHgifNCPTfwkLgwaJWP10MvBG8wEk7FBS7GpvoHaEHh5BimfYAhqwvI
        TBZsdJgIpxy6pQxW/ZE8z8uho5li5DM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-Vu_bnvy0PF2FU7sNpj8pZA-1; Tue, 04 May 2021 16:26:24 -0400
X-MC-Unique: Vu_bnvy0PF2FU7sNpj8pZA-1
Received: by mail-ed1-f72.google.com with SMTP id y17-20020a0564023591b02903886c26ada4so6979661edc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmaFtxsE0S5qvJK+FcOeAQOG1JYRVA5bDwB/1VM2dIk=;
        b=GaKqANLIPO4qbeVbRbsWbH6ud0WYPow9O8xSZFW/ltCLYpYIviZMk5X/bZVlsF2iu8
         nQestm0VgFqeynq+sV690BZykZeR7oTEfC/oGNRdP8DSlEIpr9dTV4LW2a7yrjLiEXyN
         WMZOEfwUT8nviG8uXoKTROl9DqHDxevpbXKW5MqoJSY8tkUGUar4OGwf8B3g35QlHhGc
         HHENnSdokzZJwg9d6VLP4RCpnxf5qzGWIe38E/igICFK9hkfgQixJYMo+gaykJ77ImE/
         SfSFBTX1f5QqYqDM8gKP13uUINl/sbSltKYkR9UrPW9VecRJ3lfrTTmv44ftKkXVuaxd
         sikA==
X-Gm-Message-State: AOAM530aOg9kQP0hPoREq5wTIij6pgGNS81tvi9gPiGc01xJ7EUChA3T
        lh451HtmDVKk5yUwysc/1sUibeaMFiEyCuwhkxmjNYW6ZIQbp3tXJQRQYQ4HDDj8LgR1e/znT13
        6rhCajm3x6+xFJaVTJabXBtkO
X-Received: by 2002:a17:906:fcd6:: with SMTP id qx22mr24014614ejb.529.1620159983342;
        Tue, 04 May 2021 13:26:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh1zbFHg9vwi2oHIGX5YBErFcyt0Oodg4Od0An9+HOszlBG2A+myYeCIIk2cSbkE0RAwV6gQ==
X-Received: by 2002:a17:906:fcd6:: with SMTP id qx22mr24014595ejb.529.1620159983133;
        Tue, 04 May 2021 13:26:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id ca20sm1907157ejb.84.2021.05.04.13.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:26:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] KVM: x86/mmu: Track if shadow MMU active
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210429211833.3361994-1-bgardon@google.com>
 <20210429211833.3361994-2-bgardon@google.com> <YJGmpOzaFy9E0f5T@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <edfadb98-b86e-6d03-bdfc-9025fac73dee@redhat.com>
Date:   Tue, 4 May 2021 22:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJGmpOzaFy9E0f5T@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 21:55, Sean Christopherson wrote:
> But, I think we we can avoid bikeshedding by simply eliminating this flag.  More
> in later patches.

Are you thinking of checking slot->arch.rmap[0] directly?  That should 
work indeed.

>> -	kvm_mmu_init_tdp_mmu(kvm);
>> +	if (!kvm_mmu_init_tdp_mmu(kvm))
>> +		activate_shadow_mmu(kvm);
> Doesn't come into play yet, but I would strongly prefer to open code setting the
> necessary flag instead of relying on the helper to never fail.
> 

You mean

kvm->arch.shadow_mmu_active = !kvm_mmu_init_tdp_mmu(kvm);

(which would assign to alloc_memslot_rmaps instead if shadow_mmu_active 
is removed)?  That makes sense.

Paolo

