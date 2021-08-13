Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB39C3EB18E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhHMHgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239212AbhHMHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628840185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgCfryqKF2Cdg7hVMN9+I8BgqPGPa0snvR67nUzXlLs=;
        b=SH0k8bL9HcaeQp/91QUWjfgWBGlV24IpXM/1daxPD16xt7Q10GBtVPBf5e5SADOSyMyiFD
        RWclf0g+Xu7N7yZsnX30oVKOfXXn2PhxV144YWM0PsxZXWjd49pTcUv2UoQ2r5KPjz24YG
        1OK4dOffblycFVwnEz3DR7jipLr/wLc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-k1tPCapbP-qqnYPN8mPpGA-1; Fri, 13 Aug 2021 03:36:24 -0400
X-MC-Unique: k1tPCapbP-qqnYPN8mPpGA-1
Received: by mail-ed1-f69.google.com with SMTP id y22-20020a0564023596b02903bd9452ad5cso4413953edc.20
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lgCfryqKF2Cdg7hVMN9+I8BgqPGPa0snvR67nUzXlLs=;
        b=GKYo4ydKE7itcMQ5MvMI9MsgSCmw7c9cLfvPCYjd1qAupgunHdwvQQKL6aT7+iNp0b
         3/5wAqZfi1idFIqvxi08oZR+LmMSCCHsHq+IObGBhH+4bs67M//y20a/L4BdCrUSV3g0
         jkcicGfO1nFq8OmgIQhsIIQJ4BIjroAf9nn/72aCglrtefybdjDQUSask3sQmvdK6ejk
         tVCKAyxt1Wf0oQffIjiWBWKPWpq+wpnQ8JllQK3g+Y2oAl/4NPJwVeqvSdf6fJFWn0/z
         aZZ8sj6dQ+GGD0SQAlD/WIzy7j/gttAfLXJrDnouDRggEdkEHHYUj/TDA7mLcrKvk3iC
         /QzA==
X-Gm-Message-State: AOAM531vchAjyVku5uqhikQYS0I6jqz0i8N4Bmjew/1hxlgwlUv6tkQY
        hkkoszC6eLhsaxuBKcpccxUpzcfTKzHdqZluwPQNOzwFLmvQobgIvd79GfvxSJTazkYZZZnCfd+
        9jhnvqGzpwnKat9fybfVAp+Qj
X-Received: by 2002:a05:6402:29a:: with SMTP id l26mr1405540edv.347.1628840183255;
        Fri, 13 Aug 2021 00:36:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi6Jui8Gk/1qkUmTVeHkmruZrHapUZimrK5Dyoz1qJwO/PfoSACJNOMQXbGjcyST2+EjEfxA==
X-Received: by 2002:a05:6402:29a:: with SMTP id l26mr1405528edv.347.1628840183125;
        Fri, 13 Aug 2021 00:36:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e22sm443803edu.35.2021.08.13.00.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:36:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] KVM: x86/mmu: Fix a TDP MMU leak and optimize zap
 all
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
References: <20210812181414.3376143-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93efa388-ed99-f6b4-4a2b-352632aa8a18@redhat.com>
Date:   Fri, 13 Aug 2021 09:36:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812181414.3376143-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/21 20:14, Sean Christopherson wrote:
> Patch 1 fixes a leak of root-1 shadow pages, patch 2 is a minor
> optimization to the zap all flow that avoids re-reading and re-checking
> the root-1 SPTEs after they've been zapped by "zap all" flows.
> 
> I'm still somewhat on the fence for patch 2, feel free to drop it.
> 
> v2:
>   - Replaced magic number silliness with Paolo's much more clever suggestion.
>   - Elaborated on the benefits of the optimization.
>   - Add Ben's somewhat reluctant review for the optimization.
> 
> v1: https://lkml.kernel.org/r/20210812050717.3176478-1-seanjc@google.com
> 
> Sean Christopherson (2):
>    KVM: x86/mmu: Don't leak non-leaf SPTEs when zapping all SPTEs
>    KVM: x86/mmu: Don't step down in the TDP iterator when zapping all
>      SPTEs
> 
>   arch/x86/kvm/mmu/tdp_mmu.c | 35 ++++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
> 

Queued, thanks.

Paolo

