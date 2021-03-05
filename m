Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF0F32F145
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCERes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229642AbhCERe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614965668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AwcvmNyd8TJhEYQ41B0ZqMwHc4Pit4/K/RZB9QMn9JY=;
        b=AwEuTblvex72WQgN/VnczZmYZgIPr+ondntoQZSuNwS4SjKXkWZ/Bjy4/Ktg+EFWopEPpv
        4raSXkdxwcnsLDUlFDKbXVAlFFg/QlAq0uMz/rudb0pm82pQKeQ3uq7/O9xDEVmAMEHaX7
        oFv2MxJSEAoG73y0+AFzqeXFSpdhydY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-1MddPx2zPPynHjd_OBjOlA-1; Fri, 05 Mar 2021 12:34:26 -0500
X-MC-Unique: 1MddPx2zPPynHjd_OBjOlA-1
Received: by mail-wm1-f70.google.com with SMTP id i14so1095278wmq.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AwcvmNyd8TJhEYQ41B0ZqMwHc4Pit4/K/RZB9QMn9JY=;
        b=XssPkvNqI4aIynj8jKuZglOmegAcSCEENQ5acnOgLKAY3VsTL0rHx9tepg/GZnpEJo
         MP8vaq69QQPs5mhcpldvEDRckGaDpkW75LPNXMMwUe4iX4dxJinxZwrvNb+vQHNxhjHe
         vRN2MICouRJVJSJUkn3EJkXRGNDYinyDC2loHrFmVdFxhvr4Zq6htoGtqy0UyAR6dGFx
         taLcypoztjVdIEs+ZtI+DeyVMjZPLdbEknSMIXGymbyHtYVrKq2kR/3PIr1psnFPzARJ
         3XDwy5hBLT/h3tHG1FvJCEa2epvaPDCP5074xDl7aCwSpLR3IvErOdjjVBtgS8BHHhcZ
         otTg==
X-Gm-Message-State: AOAM530B812ztCjqYCLaRHDiD3E4uddN/4xNrt1qNdy+7Gbnq60/xdqM
        neai4t4c//Bb7a7gHIDu6cEN3dFg5MFI9y1M0dSKfFX2PhL7znLztFauqn6LbNVpDx9d10pfGZ5
        cTq2I4GZoV4iCTCx9bp5d9I1m
X-Received: by 2002:a1c:e389:: with SMTP id a131mr10091512wmh.78.1614965665497;
        Fri, 05 Mar 2021 09:34:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAtzQnqLYpKTx9k1+dfEF1yqaMxFSbQIjreB352fD+qUw+PsXpTW/EesxQZDcxOd7ID8tORQ==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr10091493wmh.78.1614965665338;
        Fri, 05 Mar 2021 09:34:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o2sm5741952wme.16.2021.03.05.09.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 09:34:24 -0800 (PST)
Subject: Re: [PATCH v2 05/17] KVM: x86/mmu: Allocate pae_root and lm_root
 pages in dedicated helper
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210305011101.3597423-1-seanjc@google.com>
 <20210305011101.3597423-6-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ef5e563-8d7d-3d5a-6a19-d7daaf5c0881@redhat.com>
Date:   Fri, 5 Mar 2021 18:34:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210305011101.3597423-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 02:10, Sean Christopherson wrote:
> +	/*
> +	 * This mess only works with 4-level paging and needs to be updated to
> +	 * work with 5-level paging.
> +	 */

Planning for this, it's probably a good idea to rename lm_root to 
pml4_root.  Can be done on top.

Paolo

