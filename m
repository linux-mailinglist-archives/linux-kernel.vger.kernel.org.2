Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52263DDE07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhHBQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229945AbhHBQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627923179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5yXRDtcxx+lYhsKMFvTyTWw4OOI/miYLG3qItS8RDg=;
        b=acrFbOQzwo3Wv3VT0uUJZIvGVIk560VO+aM8bmWrlYMfaFzSQbs/sRPrOzHbApfOwCSd84
        oBTGMVb54qQu+SA9KBUHk1HYet9bMAM2+8f7ZaxWsYSqoB4cXscEmlKhrXWNYr0glnINRF
        l8E2HNqXD20B6EFQdUXVKycfIOsyYwk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-MinoYQ_CMba6ulwNi3uV0g-1; Mon, 02 Aug 2021 12:52:58 -0400
X-MC-Unique: MinoYQ_CMba6ulwNi3uV0g-1
Received: by mail-wr1-f72.google.com with SMTP id a9-20020a0560000509b029015485b95d0cso1107378wrf.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 09:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/5yXRDtcxx+lYhsKMFvTyTWw4OOI/miYLG3qItS8RDg=;
        b=HSN4MF7l/Nx6BVnIOz/DXM8etV5oAuIn1hbn6y6oaMVRUhu5A1RKlNN+npg4n7nG6o
         p9jPS/LYwFkvGWer/3eVOU91k3p+V3YVh8Xv+7zN59IWD/W30tdnrxn/1y2AExhXiewW
         zzv8+DIVZuhuYS1XWcg6qoLrHD7ukLCcF5h6qRGupbzCECuUh4UH4xI4J4OgvR9BAYCJ
         rBhyMlUiKfWAx7HGeWMYrqL1TNFClIZ/MvqCC4/TiKY8E+FyPfVxflMn3B429aP0Rnwd
         XiTzp8I28/1po9NHFB25iYT8u/e1Np+1iEgL6EGL21v2s7atyV1Ks01pRta/XFvhcZO7
         VV2Q==
X-Gm-Message-State: AOAM530Poklqk3wBCtYJGIN76jZ7vs81d4WQgLyttspiUl4FLiFP+EIJ
        4iYYE65W9zRD0mOpih8GdIRiUaKba1n65FjFPzVCoHJ5pC2ime20FDokvbPN/3KeiRyu6bbTziG
        EgR9sxhsD9WL4Zqk4a9s77RMr
X-Received: by 2002:a5d:6184:: with SMTP id j4mr18889841wru.340.1627923176987;
        Mon, 02 Aug 2021 09:52:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvhdCH2/tdqYCOMdRGFxIAzLd6brKr14f5SN7rUeCEDiOZsk0qTjmq/kSRJTHoau6cfGf9AQ==
X-Received: by 2002:a5d:6184:: with SMTP id j4mr18889829wru.340.1627923176813;
        Mon, 02 Aug 2021 09:52:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u11sm12164787wrt.89.2021.08.02.09.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 09:52:56 -0700 (PDT)
Subject: Re: [PATCH] KVM: SEV: improve the code readability for ASID
 management
To:     Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Alper Gun <alpergun@google.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Vipin Sharma <vipinsh@google.com>
References: <20210731011304.3868795-1-mizhang@google.com>
 <YQgamDDn6TVY/BoV@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71a905a1-0a6f-0d7a-f8fe-237b9e5af05c@redhat.com>
Date:   Mon, 2 Aug 2021 18:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQgamDDn6TVY/BoV@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/21 18:17, Sean Christopherson wrote:
> 
> Rather than adjusting the bitmap index, what about simply umping the bitmap size?
> IIRC, current CPUs have 512 ASIDs, counting ASID 0, i.e. bumping the size won't
> consume any additional memory.  And if it does, the cost is 8 bytes...
> 
> It'd be a bigger refactoring, but it should completely eliminate the mod-by-1
> shenanigans, e.g. a partial patch could look like

This is also okay by me if Mingwei agrees, of course.  I have already 
queued his patch, but I can replace it with one using a nr_asids-sized 
bitmap too.

Paolo

