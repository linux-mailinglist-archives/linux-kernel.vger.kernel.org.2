Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D26C44D279
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhKKHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhKKHb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636615718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ydg6KqnC0B5/gPwMhohiXCY4VRdObRCjUh42S4t7Hk=;
        b=Nma/z/6E530CsYoa4DEWZVzBQ8u/em/MZopPC6ny5IDwAAMSJLgbOPIZhXZWO4O9sOkAxm
        5s7NwcKsWGxeC2GNnmY5cZ14yrMzKrM033eEinXVaI3/JMXa/MJ/yGMU5i2dgEuLXBPJ2S
        ZXQ2hOebS1ZDifiESKvdevzdKfai5mU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-Wt4FQSgmNkeFxoY2zXHf2Q-1; Thu, 11 Nov 2021 02:28:37 -0500
X-MC-Unique: Wt4FQSgmNkeFxoY2zXHf2Q-1
Received: by mail-ed1-f70.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so4614602edx.15
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Ydg6KqnC0B5/gPwMhohiXCY4VRdObRCjUh42S4t7Hk=;
        b=07CNAuXk1V5FhReTPFnuJ3mbPTLLRh/4FT8fYQMjicvVs7fSIkHb1wB7rdQvgiK23T
         ttKcxwhh2nJlOQa1tMve4cOmGmv4n48+Q7JL8RPUZ/WHheqrGJ3uoyP517Qans9PbhVd
         Wy68sXyTNRSGs8PNyICZmOl65N2pK6l7z3FRB4CYwLVmlQ2aWTVGjSRqU8cMZLiXfhBx
         VCjAWrLy4BW4k1dBT/aMBycBoltyMTiLkwim0nyi2AzDWxZO5M818nqI7FgEfrlX/9+/
         WXJEpJTs+NdpdykCj5p7cgQlEtf92D22D7WPH0V7joUD8Ud48KQUiiZXce412nOKP6Vy
         /tIw==
X-Gm-Message-State: AOAM530i3hg+bWH3z7cO70hnwQ5f+RMujKgZkOvc6psHGqcPws7Lsyyz
        6HUcjzROKncL6q1pvnhAEWkOUxp2e0PHUBQgYY7OysRV+bOeFcpE9od16KWLHKM3GMzs95Kqa8R
        vBT02MNx8RoOcQbnXlo8mSKF8
X-Received: by 2002:aa7:d912:: with SMTP id a18mr7166810edr.16.1636615715981;
        Wed, 10 Nov 2021 23:28:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAknv8ARnxGEP2DleJJ5aDkvfRVXuAClG6ZgkOJkeRahbZJIjwffRZ5oSMX5RIVvLN4xlX1g==
X-Received: by 2002:aa7:d912:: with SMTP id a18mr7166785edr.16.1636615715787;
        Wed, 10 Nov 2021 23:28:35 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id t6sm1034094edj.27.2021.11.10.23.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 23:28:35 -0800 (PST)
Message-ID: <055d924e-2117-247f-8339-7487153e284b@redhat.com>
Date:   Thu, 11 Nov 2021 08:28:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v2 22/69] KVM: x86: Add vm_type to differentiate
 legacy VMs from protected VMs
Content-Language: en-US
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        Connor Kuehl <ckuehl@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <8eb87cd52a89d957af03f93a9ece5634426a7757.1625186503.git.isaku.yamahata@intel.com>
 <e2270f66-abd8-db17-c3bd-b6d9459624ec@redhat.com>
 <YO356ni0SjPsLsSo@google.com>
 <5689dc7e-b0e0-1733-f00f-66dc7b62b960@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <5689dc7e-b0e0-1733-f00f-66dc7b62b960@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 04:28, Xiaoyao Li wrote:
>>
>> Heh, because kvm_dev_ioctl_create_vm() takes an "unsigned long" for 
>> the type and
>> it felt wrong to store it as something else.  Storing it as a smaller 
>> field should
>> be fine, I highly doubt we'll get to 256 types anytime soon :-)
> 
> It's the bit position. We can get only 8 types with u8 actually.

Every architecture defines the meaning, and for x86 we can say it's not 
a bit position.

Paolo

