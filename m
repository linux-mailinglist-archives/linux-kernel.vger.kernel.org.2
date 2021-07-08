Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49DE3C15F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhGHPb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231804AbhGHPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625758154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ytWqP0MZDHhVybckN5p2iymaMJbhbiYb8z9pc5/aYg=;
        b=ftdIukn+2oYhLs5PmvL0G1e3d/RkW+3RcReyBRJZLHD0qmuZ+DEBawvrB+czXrEw8j1OkJ
        GfijvbNnp+7/fRWpgABtZiMnd6UQQnXnnKN8yBX/PfzXFoGPubHdP7HLhLLqy+kzEccI1I
        gC4OozGg8u6wDh9ERibEsdbl9+pJB6E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-MEdjYmx6MhCeEHpYcoIXBQ-1; Thu, 08 Jul 2021 11:29:13 -0400
X-MC-Unique: MEdjYmx6MhCeEHpYcoIXBQ-1
Received: by mail-ej1-f70.google.com with SMTP id h14-20020a1709070b0eb02904d7c421e00bso1995493ejl.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 08:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ytWqP0MZDHhVybckN5p2iymaMJbhbiYb8z9pc5/aYg=;
        b=CUnE2TsxZS9hoIKNXrQKSvdnjgou11RURxFAhP/nyNpVDU/GEpCxiH7VXoZBLxPs88
         9W9DIvDBYrKSbnOspaDjroEhkHStId7b11gmjFEuJnLY36I1QiskUrDQJqv9I48XebAH
         VX7OjDRACneuoFVsV15XPFve6C+kN6vTi4MyBMaMIUz39A/5gDU4FgOfsxNvyX206xk6
         cVvIGzIXZDBiMwokb8/d+eB/mW5TRLlP9ATNxHxdgzo2h0jKwrPs4tRypQFTWB5S9OJt
         ST2PNcycW8bGobiFJbWuMdx+bNl4+xfTqRa8o0KpS00Trl4iFM6RfereegUHSt/sndqq
         sQYA==
X-Gm-Message-State: AOAM530cZsxqm2Bc0oOzJYwci0WjkVus1Vufu7iSDbuy7uQlZ3uT7qu/
        Jps3docILcuzaSEC3iwMnK5NJMpTpWie5paAJCARBl3C92wpOeMOFsl/wgmHa/RCvlj5mx7s955
        Iclbe0ITa+obhQUuvrH+4eGZ1
X-Received: by 2002:a17:906:70b:: with SMTP id y11mr4774263ejb.328.1625758152481;
        Thu, 08 Jul 2021 08:29:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIamEdl87GewWt/JixiXsX8CrG7mkexH8ZHezkNMDbGG/XPBriNEikqufYoK38vtVIIia6ig==
X-Received: by 2002:a17:906:70b:: with SMTP id y11mr4774237ejb.328.1625758152291;
        Thu, 08 Jul 2021 08:29:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g11sm1448256edt.85.2021.07.08.08.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 08:29:11 -0700 (PDT)
Subject: Re: [RFC PATCH v2 55/69] KVM: VMX: Add 'main.c' to wrap VMX and TDX
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kernel test robot <lkp@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <52e7bb9f6bd27dc56880d81e232270679ffee601.1625186503.git.isaku.yamahata@intel.com>
 <0b1edf62-fce8-f628-b482-021f99004f38@redhat.com>
 <20210708152152.GB278847@private.email.ne.jp>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aca9277a-da65-ab0b-f499-28da1da112e8@redhat.com>
Date:   Thu, 8 Jul 2021 17:29:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708152152.GB278847@private.email.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/21 17:21, Isaku Yamahata wrote:
> On Tue, Jul 06, 2021 at 04:43:22PM +0200,
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 03/07/21 00:05, isaku.yamahata@intel.com wrote:
>>> +#include "vmx.c"
>>
>> What makes it particularly hard to have this as a separate .o file rather
>> than an #include?
> 
> It's to let complier to optimize functionc call of "if (tdx) tdx_xxx() else vmx_xxx()",
> given x86_ops static call story.

As long as it's not an indirect call, not inlining tdx_xxx and vmx_xxx 
is unlikely to give a lot of benefit.

What you could do, is use a static branch that bypasses the 
"is_tdx_vcpu/vm" check if no TDX VM is running.  A similar technique is 
used to bypass the test for in-kernel APIC if all VM have it.

Paolo

