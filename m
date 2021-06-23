Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8D3B1F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFWRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 13:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhFWRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624468717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6avEDBgEg/m6epnbR31G0pmFV1cXbC29MU0UeyyuH4I=;
        b=QimkoAMgnuV1SiuhdxPKAQh/1ANA9AUJGWKdoBxMZA/T61jgk1guGDPfoENXazbSwflqqH
        iHjLWy50lUvmCbbRjIvCL7k4ayUMSomVlzOQLdBozjR/6OD5aPxOi+XCy83RfdGA6p8Igk
        qDBfFaSF+wr39lL9bR0DVxHlHMdtI/w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-enS3LwkCOU6B68oT6hWTpg-1; Wed, 23 Jun 2021 13:18:36 -0400
X-MC-Unique: enS3LwkCOU6B68oT6hWTpg-1
Received: by mail-ej1-f71.google.com with SMTP id f8-20020a1709064dc8b02904996ccd94c0so1238705ejw.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6avEDBgEg/m6epnbR31G0pmFV1cXbC29MU0UeyyuH4I=;
        b=Y4bjGDraPJ53Odrss7qoB3weTkmS3NM7gE0HjV9LNrlYZSJ+aLcYGXbPWs1k/IG21x
         CZ0h1ZjsvidOYgE+seXzXwLr19LBwZQFJIzHHui5bLL/pU+oASUvxrHoc+qtr7NZvb3t
         YfjAAVxsGE7agqUnuEQDJHvKLREkvUiXeMBUMo6HW7RA+YIDgC3RvGNKkr82Lz1HaJyc
         2e3zXvwjYbTu8zYxG3Jf2GmXrnQ/sxb2w95Z66TaP7c1yu0s8PNxp9OoHhmgJEgJIsew
         Sak2XYx38nppi1tIAb5k/ETWPInCjwlGI0SsWoyJ+6T+7HFmiCQUMCMVSMMnnZhluBSF
         zIGQ==
X-Gm-Message-State: AOAM53340KF+vWQpihNURE/G58tqgyNLx53rlWTyM35Fd69Pv/wCfWML
        ahAc5j3zFiQzR9B1aFF1Tw2a3YVWkZnVnt7WLKUuwOggaCOcD+MuLGxYKa6ag4u00r3rHz+Ws78
        Y7yN9Lv7t+RHmlhF5UReR4p/O
X-Received: by 2002:a17:907:6fd:: with SMTP id yh29mr1168037ejb.432.1624468715232;
        Wed, 23 Jun 2021 10:18:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzz2Z2ugg1KGq4OmFuDAXL2mGlkfLATWN6gvMvTiBP+rn9k965qo/kW3qBks/ZBZ+QfZ8PyQ==
X-Received: by 2002:a17:907:6fd:: with SMTP id yh29mr1168025ejb.432.1624468715091;
        Wed, 23 Jun 2021 10:18:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n13sm380399edx.30.2021.06.23.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 10:18:34 -0700 (PDT)
Subject: Re: [PATCH 20/54] KVM: x86/mmu: Add struct and helpers to retrieve
 MMU role bits from regs
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-21-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e1a0bb6-cd73-70c7-0b94-4a52f5b04577@redhat.com>
Date:   Wed, 23 Jun 2021 19:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-21-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:57, Sean Christopherson wrote:
> +/*
> + * Yes, lot's of underscores.  They're a hint that you probably shouldn't be
> + * reading from the role_regs.  Once the mmu_role is constructed, it becomes
> + * the single source of truth for the MMU's state.
> + */
> +#define BUILD_MMU_ROLE_REGS_ACCESSOR(reg, name, flag)			\
> +static inline bool ____is_##reg##_##name(struct kvm_mmu_role_regs *regs)\
> +{									\
> +	return !!(regs->reg & flag);					\
> +}

Ok, that's a decent reason to have these accessors in the first place. :)

Paolo

