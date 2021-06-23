Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BBB3B21DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFWUkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624480678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yzpn4h8z/3EwHO6Y56HGAwADTZHOyWPR+DhZ1Kza9PU=;
        b=A7tOsqDnXj2Z4YTbsRILncaIELIYxPQrKbFKCFwAHsdBdV2dITzANnAMtyrGBWHbYXtffb
        p/yIIQ1IWgQN1BJ1lRY10pQdEnhnsRRZgyRd59CZNDgMCD0k2SfajPGSGXIrMz47yQyFD7
        KzwnQbqXoBOh2MNXaQizdkhqyI/6ols=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-GPbAbd7OM-ay8wIV5dKG2g-1; Wed, 23 Jun 2021 16:37:56 -0400
X-MC-Unique: GPbAbd7OM-ay8wIV5dKG2g-1
Received: by mail-wr1-f72.google.com with SMTP id g8-20020a5d54080000b0290124a2d22ff8so888748wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yzpn4h8z/3EwHO6Y56HGAwADTZHOyWPR+DhZ1Kza9PU=;
        b=ddMm+YavF52EaMvI3n6Q2jerTT+zbDNSxa5wHhkXFRC86Xe8/mX2qUzthhWo89aKFV
         xcHAtcyHTK9iklL8ldVMsP6I9UcSNB2qUPHG+P1uLImvwvx/dv0f2Ocna1F+ByXycYAd
         RpwyGKYe5UB8N1t6XE4km7Gp3Rqn1m+FdiKO/xDEtXbO8YPT7Pz0yatfulk+ZCCrKQFU
         mjhJipiMTfoPAi97ULW2jHbkMwSPUK8DoeQn2WcMQc+5QEWI6oFv2zsyf7kObz5H9QKI
         cIH1SLrAJU4qF4o87ICoN7BCy9hP3FsLblr6HHERB85qTw5BxBH5pu9cxd8dS+AQJecS
         bZ0g==
X-Gm-Message-State: AOAM533hSFLyASgSgsWACg7FY2J6N/M1ndUwhdXj0m8Ap/hDgT5wNbdC
        AEOvB6wUUEsos4GaroHlMc6laZzjxbqjNcGfQZj8Zb1fVfuS2POjIZoDQj2KWhyv3ruZKJLbCzz
        I6Gr5h2nlxJEIyfGQxbpAhmZT
X-Received: by 2002:adf:b19a:: with SMTP id q26mr2227906wra.401.1624480675467;
        Wed, 23 Jun 2021 13:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF6HnFGwdSZyTZFUWJepWew1VorokOc1Gz3flZnu6SWH+qKjTuAaiD7ri24gdTzUxsbnMLug==
X-Received: by 2002:adf:b19a:: with SMTP id q26mr2227882wra.401.1624480675256;
        Wed, 23 Jun 2021 13:37:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w13sm1133784wrc.31.2021.06.23.13.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 13:37:54 -0700 (PDT)
Subject: Re: [PATCH RFC] KVM: nSVM: Fix L1 state corruption upon return from
 SMM
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210623074427.152266-1-vkuznets@redhat.com>
 <a3918bfa-7b4f-c31a-448a-aa22a44d4dfd@redhat.com>
 <53a9f893cb895f4b52e16c374cbe988607925cdf.camel@redhat.com>
 <ac98150acd77f4c09167bc1bb1c552db68925cf2.camel@redhat.com>
 <87pmwc4sh4.fsf@vitty.brq.redhat.com>
 <5fc502b70a89e18034716166abc65caec192c19b.camel@redhat.com>
 <YNNc9lKIzM6wlDNf@google.com> <YNNfnLsc+3qMsdlN@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82327cd1-92ca-9f6b-3af0-8215e9d21eae@redhat.com>
Date:   Wed, 23 Jun 2021 22:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNNfnLsc+3qMsdlN@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/21 18:21, Sean Christopherson wrote:
> On Wed, Jun 23, 2021, Sean Christopherson wrote:
>> And I believe this hackery is necessary only because nested_svm_vmexit() isn't
>> following the architcture in the first place.  I.e. using vmcb01 to restore
>> host state is flat out wrong.
> 
> Ah, that's not true, using vmcb01 is allowed by "may store some or all host state
> in hidden on-chip memory".

And also, "Different implementations may choose to save the hidden parts 
of the host’s segment registers as well as the selectors".

>  From a performance perspective, I do like the SMI/RSM shenanigans.  I'm not
> totally opposed to the trickery since I think it will break a guest if and only
> if the L1 guest is also violating the APM.  And we're not fudging the spec thaat
> much :-)

Yeah, that was my reasoning as well.  Any reference to "hidden on-chip 
memory", plus the forbidding modifications of the host save area, sort 
of implies that the processor can actually flush that hidden on-chip 
memory for whatever reason (such as on some sleep states?!?).

Paolo

