Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BD4322AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhJRPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbhJRPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634570452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weGzz/RU3tcYXCDKayytqHwl63UjBOGSEo1p1tbZCGw=;
        b=VbbEvpCD5d2Xx0XsKJ7xF9WF7kd5JITxQ4vQWSEcoGZSuXWHLWSg0gh21BBBu+CBzkxGEC
        BCqFNXQVbjhR/zwyPAPcH40X+v+4w1PirQhorxAOh0EgO2CaSnsP4wFcPKlVNnMYEiYTUZ
        WYmgoC2bXIRYylIKvN4Hwm8HghwBZGQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-mhGL_1x_Mza_Z1KZ2jbLQw-1; Mon, 18 Oct 2021 11:20:51 -0400
X-MC-Unique: mhGL_1x_Mza_Z1KZ2jbLQw-1
Received: by mail-wr1-f71.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so8995492wrm.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=weGzz/RU3tcYXCDKayytqHwl63UjBOGSEo1p1tbZCGw=;
        b=HO6lZcksZgZ4HdgZ8QSLNfk5q0+P+mosLCrdyuM0HNLy16p7SF1UpxiW2suqYYx6Ea
         2urVfjQNJK1DCN2eGFBav4og4lwjLk4LmVi8UsU2+ura5Bbl85bHfjzmSZ9JpYLgz1AY
         0IINHq1oPuOXW6Q67sMeOr4pKEuG57BjlfZzWNKlQHffxQltx7Ej565mkriGNtmyOxnt
         AxNKx1vyhGsLWg2cQ90Bgqaxo5YYuS39vWVOhh/PMW84VT23Sudk+Eco0mNW3cXti8Zk
         B/2MPN2B1qxdiyGF633LgG9vTNMf3LzfWM3iGhHQOMxK7+drJNCTO0sGDoqXQT+hjH2f
         eyDA==
X-Gm-Message-State: AOAM530oCbWKu3cNHYWnTWnHWyWHCy+jL+n0AM3f7xr8IfVrTrX5Jfkr
        u+Kr6n1eEZ4njIF3W/+yeIfZF/FAEVE09AFhhH1lQCCmNjwg/oZ8iZ/ZwGVGnOjBJ+fE48cI5SV
        sm0z0f6Hy+DqpCAqI7BSqF8jr
X-Received: by 2002:adf:b348:: with SMTP id k8mr36302723wrd.435.1634570450119;
        Mon, 18 Oct 2021 08:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSU9ALI4vxdT0LUFYoXuruFKnLY/vFTpcmEgvyCKPpz+nFfh4q+eQTHiETxKUF6r7bU2FsEA==
X-Received: by 2002:adf:b348:: with SMTP id k8mr36302694wrd.435.1634570449934;
        Mon, 18 Oct 2021 08:20:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l5sm12672972wrq.77.2021.10.18.08.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 08:20:49 -0700 (PDT)
Message-ID: <96d0ff43-9b25-5f07-3fe8-7bd245ce06e4@redhat.com>
Date:   Mon, 18 Oct 2021 17:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 7/7] KVM: VMX: Only context switch some PT MSRs when
 they exist
Content-Language: en-US
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210827070249.924633-1-xiaoyao.li@intel.com>
 <20210827070249.924633-8-xiaoyao.li@intel.com>
 <50b4c1f0-be96-c1b5-aab1-69f4f61ec43f@redhat.com>
 <d54269db-d0ea-bcc3-935f-d29eb7c7d039@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <d54269db-d0ea-bcc3-935f-d29eb7c7d039@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/21 16:04, Xiaoyao Li wrote:
>>
>> If intel_pt_validate_hw_cap is not fast enough, it should be optimized.
>> Something like this:
> 
> If I understand correctly, you mean we don't need to cache the existence 
> with two variable, right?
> 

Yes, exactly.

Paolo

