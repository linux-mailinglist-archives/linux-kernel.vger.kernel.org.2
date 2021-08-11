Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07243E8FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbhHKLsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236314AbhHKLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628682464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUoM+r7xLYH/eW2KKZORvWKAgZMeUfVXHNYLMtc9asU=;
        b=dfFfAXhSZTkfxHGLj6dkrYF9GL91fUKviFaC1EgdZyyCNTIHWc9e/hVduaaloUOC4asPOn
        lGoG7y7fz8ZHxQt2pp+YoXvcgtZZnDiNwI7m2iFHSfIMJpaITjESwFn5zTFC/42lSoq6vp
        socqMz4uxPUVgd5Elugefzw4Iq4XGB0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-lUaMsTmzNiio811V46WqUg-1; Wed, 11 Aug 2021 07:47:43 -0400
X-MC-Unique: lUaMsTmzNiio811V46WqUg-1
Received: by mail-ej1-f71.google.com with SMTP id k21-20020a1709062a55b0290590e181cc34so582324eje.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BUoM+r7xLYH/eW2KKZORvWKAgZMeUfVXHNYLMtc9asU=;
        b=Y8rpBmUAcLQcF7BkOC9E51bN6Gv212XIXiPrnU5A46FmR+b3k3zhpxxCAJByCJWIdm
         OVrgGXanTybW051lr4N6rGQWd0I1VCLuqgMAwCmCXmGvrj1gXOF24puhuIq1xrajDULC
         G+ozCOFW54aukn32OAIufWzWWmzgAKylIy6HqpMGzbFLCtFEbVP3RhF5RBfda+5se3Ut
         aG+Ow49qlCZZcBF0SbaFgDhopoLpLlqut2KD1sxq57OSyJp0b0WllwN82MwP8buPqV3I
         v7bRdvThe2uY7/cTH4UiX3LSAzoGLDSucwz9GRlnZ9vGrqY4fK2N8cIiWSJTKbuyAdN1
         IpPg==
X-Gm-Message-State: AOAM530Zu/W6RrH0MvPJNDZ3nZmmaPZB9hb4B70NVS54/eRChzoxwbIb
        BxDAt7lta6+e4zkEsl0D165SmKSc2A3aldkpKXA/pHR8k+XF0xvLVbrETNS1nep5kFYXBrdVJYp
        FftDKPgLhVysM1K8iUFzSQyxx
X-Received: by 2002:a17:907:7609:: with SMTP id jx9mr184739ejc.432.1628682462333;
        Wed, 11 Aug 2021 04:47:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkjbyTVqHOS6De80mXNgPVJcSiGwZCeWZ9asxTCFCxb7VvZEwSZCb9usxBi7FBprxHugpZEg==
X-Received: by 2002:a17:907:7609:: with SMTP id jx9mr184726ejc.432.1628682462190;
        Wed, 11 Aug 2021 04:47:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id o23sm11172664eds.75.2021.08.11.04.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 04:47:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Protect marking SPs unsync when using
 TDP MMU with spinlock
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
References: <20210810224554.2978735-1-seanjc@google.com>
 <20210810224554.2978735-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74bb6910-4a0c-4d2f-e6b5-714a3181638e@redhat.com>
Date:   Wed, 11 Aug 2021 13:47:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810224554.2978735-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/21 00:45, Sean Christopherson wrote:
> Use an entirely new spinlock even though piggybacking tdp_mmu_pages_lock
> would functionally be ok.  Usurping the lock could degrade performance when
> building upper level page tables on different vCPUs, especially since the
> unsync flow could hold the lock for a comparatively long time depending on
> the number of indirect shadow pages and the depth of the paging tree.

If we are to introduce a new spinlock, do we need to make it conditional 
and pass it around like this?  It would be simpler to just take it 
everywhere (just like, in patch 2, passing "shared == true" to 
tdp_mmu_link_page is always safe anyway).

Paolo

