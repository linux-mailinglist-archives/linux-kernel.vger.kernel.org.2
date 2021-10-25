Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4340F439B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhJYQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhJYQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635177910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzjQqgInS5JAEVirRSYnDAHtmglC1CJYYuq7MCm+MDs=;
        b=CzrQsAYZG0JpijylkGbQvZk43Q5u42vgGR7oT4XPynEUNAJxQt7V9Kl/6Shd1eqAAM11q2
        Qa39bzBtyi73Yk42yjDPdn4WpXmIh92PNC/C0Wq+OMKW59Qms/V9EjxM1IjH3ZL64ACmQe
        fxSnrZ1v9q/TYtGjOGHFgLamqvaLeJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-OffhGlFoMQyo_Gv0PAFUoA-1; Mon, 25 Oct 2021 12:05:09 -0400
X-MC-Unique: OffhGlFoMQyo_Gv0PAFUoA-1
Received: by mail-wr1-f70.google.com with SMTP id z8-20020adfec88000000b00168672580e0so2031533wrn.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jzjQqgInS5JAEVirRSYnDAHtmglC1CJYYuq7MCm+MDs=;
        b=lyFuH1dY23axl5ISMJdlbC0Lb7KZnnk2HB74U1gDbXjLuhh9ZtVXKCBHE4PWEsoHI4
         Q0KiHPQukQBJfiHTLs2cXJzyT0zzmd3VjhbYGCskDMiRNZU+Cg+Vsb+qs8GkjHKvjG+n
         t4ikJ4SRznCZh0H3Aap70NGfQosyaCuH6xpUPoX5tAy+Bz4AYvKr3RmntVWaNpY+UzC2
         XCAk3zZsbMHV6Oo49hImgz0L6qhY1249h/xCoJHui6rAUPS8tO3G/CY4h+np3EkMMtHc
         SfMbnKg8//ObXb4LvoO737KeEx4ys9WsfIyEGPBglWzZsPMrr2deMy7Gj0QUd4jRuVGO
         Xy6w==
X-Gm-Message-State: AOAM531mc+0mLMsN6tjEpsxJVz/s3YFqiv6QB3LKo+DvVuHyogvLbBiq
        U9k1INipQNrYR/dZ+YNTxPDBl2NrrKf3MIaAQ9PE9h46lv98mciwztzI6pg4SX7Gz0KoAre1rUQ
        U4+g8WdScKAXRV1vCHCiEGAG+
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr583065wml.193.1635177907893;
        Mon, 25 Oct 2021 09:05:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Hpueg5Kgw92DDaHWA4oSbeV5VWaHUKB1yRpErsOuDKaAwhadRtMDiDg+VcgSV4nXnXK6UQ==
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr583011wml.193.1635177907493;
        Mon, 25 Oct 2021 09:05:07 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y8sm12173223wrq.39.2021.10.25.09.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:05:06 -0700 (PDT)
Message-ID: <3d72790d-64be-7409-1d92-db7ec92b932b@redhat.com>
Date:   Mon, 25 Oct 2021 18:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/4] KVM: x86: APICv cleanups
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211022004927.1448382-1-seanjc@google.com>
 <23d9b009-2b48-d93c-3c24-711c4757ca1b@redhat.com>
 <9c159d2f23dc3957a2fda0301b25fca67aa21b30.camel@redhat.com>
 <b931906f-b38e-1cb5-c797-65ef82c8b262@redhat.com>
 <YXbAxkf1W37m9eZp@google.com>
 <674bc620-f013-d826-a4d4-00a142755a9e@redhat.com>
 <YXbUbB+l++P3XSZ5@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXbUbB+l++P3XSZ5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/21 17:59, Sean Christopherson wrote:
>> No, checking for the update is worse and with this example, I can now point
>> my finger on why I preferred the VM check even before: because even though
>> the page fault path runs in vCPU context and uses a vCPU-specific role,
>> overall the page tables are still per-VM.
> Arguably the lack of incorporation into the page role is the underlying bug, and
> all the shenanigans with synchronizing updates are just workarounds for that bug.
> I.e. page tables are never strictly per-VM, they're per-role, but we fudge it in
> this case because we don't want to take on the overhead of maintaining two sets
> of page tables to handle APICv.

Yes, that makes sense as well:

- you can have simpler code by using the vCPU state, but then 
correctness requires that the APICv state be part of the vCPU-specific 
MMU state.  That is, of the role.

- if you don't want to do that, because you want to maintain one set of 
page tables only, the price to pay is the synchronization shenanigans, 
both those involving apicv_update mutex^Wrwsem (which ensure no one uses 
the old state) and those involving kvm_faultin_pfn/kvm_zap_pfn_range (to 
ensure the one state used by the MMU is the correct one).

So it's a pick your poison situation.

Paolo

