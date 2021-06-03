Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64339A26E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFCNpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230319AbhFCNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622727805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/YoXGStod1h/jERDJXuFzwuJE4tYR48fwiMDlbU5AI=;
        b=HGJMTlODCcjNoTPyL/qb4QqTcvJHeVSluvsyPemzxL/9TQF0Tg0GVatTKRQwNr3khlrSAD
        cveLnJSrwMIUVftEYcxkp8+dp82laoViBXNqQh9TFrmtI/pEFRgctJYwVtnx7ZSIyrL2NI
        WXl103JCaNUpoL904+qjKJphoWa5o+Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-yrPikXOAOIqJzRYm0-slSw-1; Thu, 03 Jun 2021 09:43:21 -0400
X-MC-Unique: yrPikXOAOIqJzRYm0-slSw-1
Received: by mail-ej1-f69.google.com with SMTP id hz18-20020a1709072cf2b02903fbaae9f4faso1963145ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=g/YoXGStod1h/jERDJXuFzwuJE4tYR48fwiMDlbU5AI=;
        b=tFHrbaGQ3efg+QlsnUiPceho6ikAiR7RE2GA4U6P3oCo226n3FhEKJ6A6oN36WaffM
         fdkfJD4cpG4Q6mELtO67r/wVzGZdJcPLBJQq/yXHhLbV8D9UjzWTQwyee7Ax60Z2cPx1
         iD2R/o+qV2HNdL2f45NgdShOJSH/TzYwW9loifApTjYLpRSOYIjMAvMZEzt/rNwRihHy
         G4LkuMSWOBhq4zjj/ZNu//dFgxSW2U2XFMjA4+Z9ho9NKJ/BScneYGIDbd05xbso8bzT
         2Pnw+WkbCsyMUithlfwk5SuCQ32libGOP9m+sJcfeRYlnNugAklMZalQBszsCSnkhtFu
         WOzg==
X-Gm-Message-State: AOAM531R9kj08OlazOggD/3rSRrF3Nn11x9OqoLdx+OZVnhitIm1CPnz
        so/lz1Skuz2nNwBGW/ercT+XzW96DMWsWphjDeYbT9fArc2ZE4yhcmbxxFGvzwBsXsZ2viHzcvT
        kfcfILYrXIXrzoWT7rceLTaFa
X-Received: by 2002:a17:906:c010:: with SMTP id e16mr39287405ejz.214.1622727800185;
        Thu, 03 Jun 2021 06:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkBAlTramcWK5Md2ZPw/anf2r6EF7CpGQ6+Wmz/53biaTbGsw8MFyAlqZyTTAGWiKmHbfy7Q==
X-Received: by 2002:a17:906:c010:: with SMTP id e16mr39287382ejz.214.1622727799958;
        Thu, 03 Jun 2021 06:43:19 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id cw10sm1099269ejb.62.2021.06.03.06.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 06:43:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tao Xu <tao3.xu@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com,
        seanjc@google.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH v2] KVM: VMX: Enable Notify VM exit
In-Reply-To: <12db5b88-a094-4fb0-eeac-e79396009f44@intel.com>
References: <20210525051204.1480610-1-tao3.xu@intel.com>
 <871r9k36ds.fsf@vitty.brq.redhat.com>
 <12db5b88-a094-4fb0-eeac-e79396009f44@intel.com>
Date:   Thu, 03 Jun 2021 15:43:17 +0200
Message-ID: <87im2v12tm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tao Xu <tao3.xu@intel.com> writes:

> On 6/2/21 6:31 PM, Vitaly Kuznetsov wrote:
>> Tao Xu <tao3.xu@intel.com> writes:
>> 
>>> There are some cases that malicious virtual machines can cause CPU stuck
>>> (event windows don't open up), e.g., infinite loop in microcode when
>>> nested #AC (CVE-2015-5307). No event window obviously means no events,
>>> e.g. NMIs, SMIs, and IRQs will all be blocked, may cause the related
>>> hardware CPU can't be used by host or other VM.
>>>
>>> To resolve those cases, it can enable a notify VM exit if no event
>>> window occur in VMX non-root mode for a specified amount of time
>>> (notify window). Since CPU is first observed the risk of not causing
>>> forward progress, after notify window time in a units of crystal clock,
>>> Notify VM exit will happen. Notify VM exit can happen incident to delivery
>>> of a vectored event.
>>>
>>> Expose a module param for configuring notify window, which is in unit of
>>> crystal clock cycle.
>>> - A negative value (e.g. -1) is to disable this feature.
>>> - Make the default as 0. It is safe because an internal threshold is added
>>> to notify window to ensure all the normal instructions being coverd.
>>> - User can set it to a large value when they want to give more cycles to
>>> wait for some reasons, e.g., silicon wrongly kill some normal instruction
>>> due to internal threshold is too small.
>>>
>>> Notify VM exit is defined in latest Intel Architecture Instruction Set
>>> Extensions Programming Reference, chapter 9.2.
>>>
>>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>> ---
>>>
>>> Changelog:
>>> v2:
>>>       Default set notify window to 0, less than 0 to disable.
>>>       Add more description in commit message.
>> 
>> Sorry if this was already discussed, but in case of nested
>> virtualization and when L1 also enables
>> SECONDARY_EXEC_NOTIFY_VM_EXITING, shouldn't we just reflect NOTIFY exits
>> during L2 execution to L1 instead of crashing the whole L1?
>> 
> Notify VM Exit will not crash L1 guest if VM context valid in exit 
> qualification. After VM exit, VMM can resume the guest normally.

Wrong choice of words, sorry. Indeed, VMM is free to decide what to do
upon such vmexit.

-- 
Vitaly

