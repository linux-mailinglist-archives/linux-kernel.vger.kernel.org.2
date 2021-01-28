Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AF1306F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhA1H3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231615AbhA1H0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611818721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=876r7X2bl4pl1WmykJyxzbtRsCkiukSI08W+mrYCajw=;
        b=dkV0wEWuHLI4M51xC/H638/cacRYcIbO/OoBLoTVaVPAOwvhvBVU/DAyxV3tgtF9/jXNev
        XB9YjYJD39Qa4caySSc1PRmA0wIMMkFiCQeclS6Z3sQOMwnVns/pXw98ER/xbxOlGRBEUk
        GjS6ahmpEp9eIlHa3JFWQizyibKsKtg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Dqn9w1YDNz6MxHembBX0WQ-1; Thu, 28 Jan 2021 02:25:20 -0500
X-MC-Unique: Dqn9w1YDNz6MxHembBX0WQ-1
Received: by mail-ej1-f70.google.com with SMTP id d15so1774826ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=876r7X2bl4pl1WmykJyxzbtRsCkiukSI08W+mrYCajw=;
        b=hHQ3d55fxdCifnP2FkPfrJS6+1qL3a/UNbmtb+0U8VOQDpNU+HSSWzaXDRnSnxt6cI
         n4krHUifmy3Bv6BGWoZGO2JWRByX1l/tCy9T+XA3oZSB708wUdkKDor4LeciYYvig0To
         Gch5csLaXd5KkyWgz8O5euEVavuJ51nkZuXHtLjexUG0LXvLMSuiM4U6QUtd7dPWbslZ
         D/+imAFKDWp3yPwQ2HAnHkN9deozYqsqa6gQ2Qi0pAuW3qc6hfzg75z4Fwke9OXLbGqb
         ZlJLDJqiZdnst96+uFtnXAC6wkOltore+UkjZuEJPR8nqzhCHaCTYsnjiGS6ohvRf+5N
         ooHg==
X-Gm-Message-State: AOAM533ASs0wCDszzmMuX4uoo9+89SnSHgoc9L+FM2p79hOpzo6xTzvK
        UCVVszOWIGbONEqCKW1T+gYsnZ4hVozHwoxc3agLmsDdi1rzN0ckyqi1wMeyJt1AS1BQXch+/6q
        OWBWQklGSNLYbQcuXaPumD7HYO7w8539QYDAW7AyjF8l5oRitvpfTValtycrnez/v/tyXEgYsQ3
        jK
X-Received: by 2002:aa7:cfda:: with SMTP id r26mr12375507edy.142.1611818718772;
        Wed, 27 Jan 2021 23:25:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjdSROnwh7bIj6CVtD12+IyP8ck2bYSFkWDuFm5WOs+E70kFpZ8mSNJbPg4ZcB3UDDn5FORw==
X-Received: by 2002:aa7:cfda:: with SMTP id r26mr12375489edy.142.1611818718588;
        Wed, 27 Jan 2021 23:25:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l16sm2588861edw.10.2021.01.27.23.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 23:25:17 -0800 (PST)
Subject: Re: [RESEND PATCH 1/2] KVM: X86: Add support for the emulation of
 DR6_BUS_LOCK bit
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210108064924.1677-1-chenyi.qiang@intel.com>
 <20210108064924.1677-2-chenyi.qiang@intel.com>
 <fc29c63f-7820-078a-7d92-4a7adf828067@redhat.com>
 <5f3089a2-5a5c-a839-9ed9-471c404738a3@intel.com>
 <6bf8fc0d-ad7d-0282-9dcc-695f16af0715@redhat.com>
 <ec623f67-d7b7-2d9a-1610-4da7702288b1@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4d66085-3cf9-afaf-97d0-3df2b5eb4a3c@redhat.com>
Date:   Thu, 28 Jan 2021 08:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ec623f67-d7b7-2d9a-1610-4da7702288b1@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/21 08:17, Xiaoyao Li wrote:
>>
>> "Active low" means that the bit is usually 1 and goes to 0 when the 
>> condition (such as RTM or bus lock) happens.  For almost all those DR6 
>> bits the value is in fact always 1, but if they are defined in the 
>> future it will require no code change.
> 
> Why not keep use DR6_INIT, or DR6_RESET_VALUE? or any other better name.
> 
> It's just the default clear value of DR6 that no debug condition is hit.

I preferred "DR6_ACTIVE_LOW" because the value is used only once or 
twice to initialize dr6, and many times to invert those bits.  For example:

vcpu->arch.dr6 &= ~DR_TRAP_BITS;
vcpu->arch.dr6 |= DR6_ACTIVE_LOW;
vcpu->arch.dr6 |= payload;
vcpu->arch.dr6 ^= payload & DR6_ACTIVE_LOW;

payload = vcpu->arch.dr6;
payload &= ~DR6_BT;
payload ^= DR6_ACTIVE_LOW;

The name conveys that it's not just the initialization value; it's also 
the XOR mask between the #DB exit qualification (which we also use as 
the "payload") and DR6.

Paolo

