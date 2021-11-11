Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D8C44D6E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhKKMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232203AbhKKMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636635132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izEEkdfiq7NVpY8kXHf0OcoN5YJMfZrmMQlE+w7PjLQ=;
        b=bI8/VS+1Ujb2LAjbiQBrog7KBEGRI+VwxS3zRT8LAoFEwkuSB8o7ZPe4tlpCxauhART68I
        kF0E7IVfm3yK2G9M24geV5XjPsQ1asBt77Iz1Pq3F4CSMyDVIk3Xvc+wngWMxX3klDRHrn
        EGikP2Gdf6nW8RrudNyjBg5mrft5acw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-kAMBlW0nP2Waw_hxyjMRLg-1; Thu, 11 Nov 2021 07:52:11 -0500
X-MC-Unique: kAMBlW0nP2Waw_hxyjMRLg-1
Received: by mail-ed1-f69.google.com with SMTP id w12-20020a056402268c00b003e2ab5a3370so5365427edd.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=izEEkdfiq7NVpY8kXHf0OcoN5YJMfZrmMQlE+w7PjLQ=;
        b=rYNOcdR4f+1H072/4VZF95AEoRnDRT3+rOvCmaIYJTTpancMKg7VriI7gaReAlKm+N
         HWetjOEiEU4j3V7fHrZoF3xRDpPdKfXJj2FVxO8ogb6PMCC24JzPdyhRLvDn859KTmxh
         eN3OQ39FhrU5aDRk6w+y1CJGAhPegb/VToegR7GzlEyl49TewDBVvO394kxEHrG87i5i
         V07YBBKvUYC6K6LJ8gAz/iuMvsprM0I+3UON4xXIEC0QJPz47OAHoQm7lkxBkeLG89e0
         Ecz/CIYwGhG9wAcTGzdwBBcCfAXHmacVqVAsv6it1BVP1G0DzDmBEBoXdsG88Jmsyqj5
         99qA==
X-Gm-Message-State: AOAM530raJHCcuYVXAIMTApfuhLobXSINvZL+Wc4q0R4l9wLhF6MdiPW
        NGFKn/AiJK66Z3TJCi3BQ4kRDcyDSmxlK/sfaEqJJUyg0W2FssQAXo+qTulam6t0/LR9ibKJT1a
        zM/1auSBwM5vVnwZm/zBtkdSL
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr8981735ejc.179.1636635129278;
        Thu, 11 Nov 2021 04:52:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbb99NWRupFa9BjRYCWvu5jNGhN8uooO1296jBViRhy7AurDCYM4fd/rSTJahV29MSoaUOKw==
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr8981692ejc.179.1636635129081;
        Thu, 11 Nov 2021 04:52:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id lv19sm1431396ejb.54.2021.11.11.04.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 04:52:08 -0800 (PST)
Message-ID: <e7b2172f-c0d9-41ef-0607-257c3871b376@redhat.com>
Date:   Thu, 11 Nov 2021 13:52:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] KVM: SEV: Fall back to __vmalloc() for SEV-ES scratch
 area if necessary
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20211109222350.2266045-1-seanjc@google.com>
 <20211109222350.2266045-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211109222350.2266045-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 23:23, Sean Christopherson wrote:
> The buffer is purely a KVM software construct, i.e. there's
> no need for it to be physically contiguous, and at a max allowed size of
> 16kb it's just large enough that kzalloc() could feasibly fail due to
> memory fragmentation.

That isn't entirely correct, as kzalloc() won't really fail for requests 
up to 32kb, i.e. order <= PAGE_ALLOC_COSTLY_ORDER.  However, the 
reasoning is correct so I queued the patches.

Paolo

