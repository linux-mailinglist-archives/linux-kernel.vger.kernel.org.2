Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4134FD12
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhCaJhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234686AbhCaJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617183418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPSZ7dxb3qsEMs5x97M5ADT7+JZHTIsRy6tbsYraIFw=;
        b=czCTIUEwhF3ubVhqq5MHCt1c7CGBhtb6EAOElU0xiVOu8q3ykxPuCOho38ceJ2GSFQj3eh
        9nNe8lSeNQKe2Qu/i+Jzgke7rX1I5vnR749ejBxH1gEwEjuXafZNDBOvrYFXCSLu0qzsFV
        MuSZak5RhmKHuHhD2VHMHt9nkTlFZVk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-jFeGqgyQPUCd8TUfRnNHdA-1; Wed, 31 Mar 2021 05:36:56 -0400
X-MC-Unique: jFeGqgyQPUCd8TUfRnNHdA-1
Received: by mail-ed1-f71.google.com with SMTP id m8so803695edv.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vPSZ7dxb3qsEMs5x97M5ADT7+JZHTIsRy6tbsYraIFw=;
        b=PUDTWx7JRoRtXzffxbnqsMM9imFzr0bofEZmdeUoeViAh2tKGMsPq8XGe+FgI4p+YS
         DBANzYcDaASQLsYljeU8JTc8AgzITNM69v/MQiO47H3wHBTawyONuKYaCpVXuZUNeNvf
         PAl0zlk8JjyjGfwk0X8eY2YfUejOMyrmDLM1qczEKo6KDFOwx6Lsw4AczsjXPYa2yvGa
         tNsyqsammKsb9mGd3ZW0kQ7x1h1yHOhVL14lC2UzEfRX+/U2BBgmVsaLIy0mSxitcXb3
         GqcEtPkA/qYbbomQZG0ncYvC1EfWHcQN/WcjuWlYxNwviBO9iYVkTUhvmYw1PGlloU0H
         3Uwg==
X-Gm-Message-State: AOAM530RQt6JvPqhOfK7BmCiQy6pDqBb96u21sRNytaivcKg56aykTaz
        SxFYbbj3woepW5wle0RyH671Zr8sEBuLccEmvJks7wdCOHvnmPejkUcc5rUfVFTw36bT6tpybYL
        lNeji+ykZv1hz6GR4xLjXdySp
X-Received: by 2002:a17:906:ecfb:: with SMTP id qt27mr2486133ejb.245.1617183414925;
        Wed, 31 Mar 2021 02:36:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0v85wpb8v1x9/F+l+ofzwyNdWiaBvwk7qCS7BunYpFql/vZ7HE5GkHFgjuu+1rqE7pfFRSA==
X-Received: by 2002:a17:906:ecfb:: with SMTP id qt27mr2486118ejb.245.1617183414792;
        Wed, 31 Mar 2021 02:36:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id q20sm825485ejs.41.2021.03.31.02.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 02:36:53 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: x86/mmu: TDP MMU fixes/cleanups
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
References: <20210331004942.2444916-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f57e4005-5a71-7fed-8328-88fddadd1443@redhat.com>
Date:   Wed, 31 Mar 2021 11:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210331004942.2444916-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/21 02:49, Sean Christopherson wrote:
> Two minor fixes/cleanups for the TDP MMU, found by inspection.
> 
> Sean Christopherson (2):
>    KVM: x86/mmu: Remove spurious clearing of dirty bit from TDP MMU SPTE
>    KVM: x86/mmu: Simplify code for aging SPTEs in TDP MMU
> 
>   arch/x86/kvm/mmu/tdp_mmu.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

Queued, thanks.

Paolo

