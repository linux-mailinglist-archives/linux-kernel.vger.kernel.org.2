Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6783B3FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhFYJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230072AbhFYJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624611475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7hC2aDaEZMwZuCypCIswjUuv9JA1ZXi3BbgeUjua2c=;
        b=JLWESkJ1kRXWyQdhixV4wsvckfdw5rgISRfpADGxDC5gWyNvFzOWugTkqv9SY9hyQBVEKL
        CKJe2eqRqMxGsHZZcm5M8o0zYs5XodsHpyb9crcaidhgguHGTpPH6NxBhyFBzZXZ9Id7NM
        ydWUlILCUDE4mKUK5yULM5EywMwfkzw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-OQ94ZYe9MayeHPwigXf2mw-1; Fri, 25 Jun 2021 04:57:54 -0400
X-MC-Unique: OQ94ZYe9MayeHPwigXf2mw-1
Received: by mail-ej1-f69.google.com with SMTP id jw19-20020a17090776b3b0290481592f1fc4so2875542ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7hC2aDaEZMwZuCypCIswjUuv9JA1ZXi3BbgeUjua2c=;
        b=aS7Ns5wC4ZXzHa/IC4s3MKICsgmRjak/J9Sw60d1/B1P0XI6SnSSbAlXz7BiEkJfKE
         Uh9iaOAz0H6htYLpDmKs4XlYWRTvVgEHqDBbWOQUSFZR8Br1gGhybTyfefTZ0LRXEgwB
         wRWvaTEYytHFRsb2i6vLw9k9vL2TC2uLLkcRH9S7AkLLcSEWJ8TfhIWLju3kcawFlmbK
         kpRq4/POZjUWjYrAN9pXQPru15nqebmUp9XjEBYq12EIBhWE4kI86e/TeqmtQFJ9H2U0
         WzCjgs/R8mDzzvA20XZfFztq1IG+tgii6Nt3G6ZBGkU7+v8rQKEoxq5zPHSGfg2HVgl+
         vOYA==
X-Gm-Message-State: AOAM530HJigjK5dZSMWJGcQB9e4g2bESQo0IlAR5sombH+RTXCC+dwHs
        Eyn3/g4TnhVYSpEx4Jz/OnV18s+YFxCxbKOZRRbIDyT3LkoKI8GxU8avbyIGmuZ1VPs2/RQxAMn
        Rn1OH04eFyv8OoqIuH5pEcl0z
X-Received: by 2002:aa7:c648:: with SMTP id z8mr1097317edr.384.1624611473119;
        Fri, 25 Jun 2021 01:57:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysSqfGdK5bBctBEQT5D4lGEIgTGtqG/WbIFUmNaQcm+60RoRS+vvF3iacOwH1FhxuIliPxYA==
X-Received: by 2002:aa7:c648:: with SMTP id z8mr1097302edr.384.1624611473014;
        Fri, 25 Jun 2021 01:57:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id qq26sm2408826ejb.6.2021.06.25.01.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 01:57:52 -0700 (PDT)
Subject: Re: [PATCH 05/54] Revert "KVM: x86/mmu: Drop
 kvm_mmu_extended_role.cr4_la57 hack"
To:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-6-seanjc@google.com>
 <20210625084644.ort4oojvd27oy4ca@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09a49caf-6ff5-295b-d1ab-023549f6a23b@redhat.com>
Date:   Fri, 25 Jun 2021 10:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625084644.ort4oojvd27oy4ca@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/21 10:47, Yu Zhang wrote:
>> But if L1 is crafty, it can load a new CR4 on VM-Exit and toggle LA57
>> without having to bounce through an unpaged section.  L1 can also load a
>
> May I ask how this is done by the guest? Thanks!

It can set HOST_CR3 and HOST_CR4 to a value that is different from the 
one on vmentry.

Paolo

