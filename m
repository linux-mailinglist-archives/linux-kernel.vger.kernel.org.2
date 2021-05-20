Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840D238B510
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhETRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:19:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44739 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhETRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:19:20 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ljmJ3-0002uZ-Dl
        for linux-kernel@vger.kernel.org; Thu, 20 May 2021 17:17:57 +0000
Received: by mail-qt1-f199.google.com with SMTP id s11-20020ac8758b0000b029020e731296abso2149826qtq.22
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6MP/fdPas5lfpI47DCh6qhf5Z/7De9kGn188IW9vBiI=;
        b=M07EIEYJpMSKdvDTAY8OgRhyQ2CU6RsLQWH6BedbE905LizBqYI3JvE2Vp1EqUL+ER
         6X5+p9B0MwOeCqV/Y9IQ5crsRPKx+bGfdltCMubYD/S9tCXmkH6ncSF7b2udyvAY60iG
         35aMrPbKY85lNAFDcmNszkjyDq5bsjNDnycjP8Fh9xMGEe9NerpMaUQ11AMnRUha4G/F
         /odU1bg8YEskNs07qmJknHda6uiyhJ4ySLWj5H+YdO0MATiWJVKX3JUcBJPT2vzTCL0j
         zyDNxsVtWMD4xa4T9W9Rx89WlTO/ybyheFd9AeYcF6LC61uwsmtMlDJ5833I2nImARsz
         baxA==
X-Gm-Message-State: AOAM532HTSdTIWcoPUPN/Y9HYrFWKT/TPaf7RLTf5gQ2gPskEaVAycie
        i6u+VTitTSZJ2UzPrX6fX4qju/edB/peqTUCFsJPJZFpUPhpVBPFYS5xpM8ByPF45sEkRlgRjFT
        okdP3aNLPoKddV7m96J2PdpdnIiq4z8qoPsbPheeIuQ==
X-Received: by 2002:a0c:f792:: with SMTP id s18mr6786825qvn.46.1621531076593;
        Thu, 20 May 2021 10:17:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyTORXHaDcJJCAfP/vrlSqshMgptASKzlszax+wo8SgDUlWY30niziVRtFL+cCSn5cYRaN3g==
X-Received: by 2002:a0c:f792:: with SMTP id s18mr6786804qvn.46.1621531076467;
        Thu, 20 May 2021 10:17:56 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id k9sm2675056qkh.11.2021.05.20.10.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 10:17:55 -0700 (PDT)
Subject: Re: [PATCH stable v5.4+ 1/3] x86/kvm: Teardown PV features on boot
 CPU as well
To:     Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Righi <andrea.righi@canonical.com>
References: <20210520125625.12566-1-krzysztof.kozlowski@canonical.com>
 <2aff367f-74b5-ba03-229e-6d7b5b79815e@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <42392f1d-4547-9c66-f429-f81f55e86574@canonical.com>
Date:   Thu, 20 May 2021 13:17:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2aff367f-74b5-ba03-229e-6d7b5b79815e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2021 12:47, Paolo Bonzini wrote:
> On 20/05/21 14:56, Krzysztof Kozlowski wrote:
>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>>
>> commit 8b79feffeca28c5459458fe78676b081e87c93a4 upstream.
>>
>> Various PV features (Async PF, PV EOI, steal time) work through memory
>> shared with hypervisor and when we restore from hibernation we must
>> properly teardown all these features to make sure hypervisor doesn't
>> write to stale locations after we jump to the previously hibernated kernel
>> (which can try to place anything there). For secondary CPUs the job is
>> already done by kvm_cpu_down_prepare(), register syscore ops to do
>> the same for boot CPU.
>>
>> Krzysztof:
>> This fixes memory corruption visible after second resume from
>> hibernation:
> 
> Hi, you should include a cover letter detailing the differences between 
> the original patches and the backport.
> 
> (I'll review it anyway, but it would have helped).

My bad, I actually was not aware that backport differs that much. I can
describe in v2.

The patch context looks quite a different and now I see
kvm_guest_cpu_offline() ends up within CONFIG_SMP for unclear reasons.
Let me try to fix it in v2.


Best regards,
Krzysztof
