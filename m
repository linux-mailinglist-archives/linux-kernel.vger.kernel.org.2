Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC053109C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhBELF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:05:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231965AbhBELCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612522864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlQHxvz68herj6uUlAqo6cNNlISG8mBPX3iyJA1YfgY=;
        b=U2R7dq0veCLLFAVwqOxvVea3BPvYdvokhPTfULuAhI6A4XeySy63DjAVyJcnCbRVrkR6zX
        Wpn5bRZyNzi+n8f6hFmcNpvvdV3YNIGn1/hNYjea7bwdvNBMVohSoXQmT8Fiv/NzsjcCn4
        xvWmheoU8pNCX+B64VpCHF2LcEveh0E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-XMZ3BsibNCmkIiYAPxHyiQ-1; Fri, 05 Feb 2021 06:01:03 -0500
X-MC-Unique: XMZ3BsibNCmkIiYAPxHyiQ-1
Received: by mail-ej1-f69.google.com with SMTP id n25so6711746ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hlQHxvz68herj6uUlAqo6cNNlISG8mBPX3iyJA1YfgY=;
        b=lxkhUIjkllwQXWxcJMg4WIdgJWMifQNFnc/wuDjp0H+ZQPHMCWcpO1pEZTackOk78X
         NUoi/fBaXNJs8G8dsInU21UcNDAH5KrXM/g5K0/VtA+F0UsL2MAo9SyfK4Frm38piu47
         n4ej+zv5OQ++kNyaomuEoIJ17Pnv472FUJJgB4JO+a0LjzNp0jYK9aSggJ5khAopNtiY
         0kyA41A1eNA6rE2fsBEW0IT+oruURUDlI6hWB57JhExvxmFoFJaB6U7xw5oUd7YFoj8d
         WcjcNTfQwo3sjS8O4swYo6x2HPgFUeLkzh0J9M1oqFOGjrqeHq5pjN7AW14mq0LLkM9W
         mPcQ==
X-Gm-Message-State: AOAM5339wWStsAeCo0+E6IFQNlxce6IS1qXgd9yCOBQrvuSYCYJzEJm7
        zw2JSYf+r5Cm8fTynjmfijPxlUKgDttwtS9pWgw8OMQFjRPrsfOSymN/fX50lgPO9Q5EDRFy1l6
        BNfSmq8NkdYvA5PySl9BM1w3X
X-Received: by 2002:a17:906:d84:: with SMTP id m4mr3483451eji.437.1612522861723;
        Fri, 05 Feb 2021 03:01:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4F1t/R+DPSOQFVqV3fjaYushABxmKmxDzt7PERmONeplKqUD5cGkaLMtwig78BxPe+5fXxw==
X-Received: by 2002:a17:906:d84:: with SMTP id m4mr3483425eji.437.1612522861540;
        Fri, 05 Feb 2021 03:01:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x25sm3802377edv.65.2021.02.05.03.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:01:00 -0800 (PST)
Subject: Re: [PATCH v2 4/4] KVM: x86: Expose Architectural LBR CPUID and its
 XSAVES bit
To:     "Xu, Like" <like.xu@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu@linux.intel.com>
References: <20210203135714.318356-1-like.xu@linux.intel.com>
 <20210203135714.318356-5-like.xu@linux.intel.com>
 <8321d54b-173b-722b-ddce-df2f9bd7abc4@redhat.com>
 <219d869b-0eeb-9e52-ea99-3444c6ab16a3@intel.com>
 <b73a2945-11b9-38bf-845a-c64e7caa9d2e@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7698fd6c-94da-e352-193f-e09e002a8961@redhat.com>
Date:   Fri, 5 Feb 2021 12:00:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b73a2945-11b9-38bf-845a-c64e7caa9d2e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 09:16, Xu, Like wrote:
> Hi Paolo,
> 
> I am wondering if it is acceptable for you to
> review the minor Architecture LBR patch set without XSAVES for v5.12 ?
> 
> As far as I know, the guest Arch LBR  can still work without XSAVES 
> support.

I dopn't think it can work.  You could have two guests on the same 
physical CPU and the MSRs would be corrupted if the guests write to the 
MSR but they do not enable the LBRs.

Paolo

