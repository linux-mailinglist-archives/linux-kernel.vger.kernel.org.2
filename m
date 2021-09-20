Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBCA412321
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377482AbhITSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358228AbhITSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632161061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gopq2BZfkhjQI2xV/FKOoo6DL77eDjWiZmjGPcNNBzk=;
        b=TbWuNdPYobo4tMZEHf49jhXuraQ7qnb6/itxXs2lpYA4HcOc1VAoKThz2mAFt4FbSiqGvF
        oxDDWxFMLQF/MMM2aeuiNyM4e+QxEALrVwHV/vvqUHAp65uX2R1AcufhgWjCOdK9nnlSLw
        jj6xmNhKTHw8CRx/sLfc/yhWlpfacSQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-27fxhFY8Ncmu5WW4bDsyJg-1; Mon, 20 Sep 2021 14:04:20 -0400
X-MC-Unique: 27fxhFY8Ncmu5WW4bDsyJg-1
Received: by mail-wr1-f72.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so6759524wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gopq2BZfkhjQI2xV/FKOoo6DL77eDjWiZmjGPcNNBzk=;
        b=yOgYLKHuRfM/mlKwDn08xdBeC64+i9gCjWg/ZLsFlbRrLmlzR34IkYibBeLf9A3Lb1
         i0zIBNVsH6f75zBZLwO28SzDMA+WDGZ1czNqtypymd9vXE0jxS5Czqm1e9k2ygajePp9
         ll67sSzwwOumdRmszFwKEsVn8+IciuPaImX5t+5SwyQkNBRhh505H0PaUwpleVvVQW6l
         i3ZUHyY3MaSQog9xCEM7244nqap6jQqOwtturgYa4cshB0k/wJZizUgAlvSbleUt8N3Q
         JwQw1UvllU0d/9+DRR1vVKovd1zHzrQV1DjTjnOEfOrpJlVwb7WRzwIs4RkwpsrW2PoM
         Ir/w==
X-Gm-Message-State: AOAM5321VT21GqXXGLeIyCcLIyc5BQvMNkJk1Hm/zfFlOuiAfcp7+P8Q
        6dl22Q82ngQmdBV1MOoOEIpLbHV6Iq8M/zYxQNAXb0tuCL0AqTWBwQLBunJAe0B+SJKidYvuiCJ
        HtryvZ2Lbn/ZkeBlXRjLucIl0
X-Received: by 2002:a05:600c:4b87:: with SMTP id e7mr368767wmp.108.1632161058107;
        Mon, 20 Sep 2021 11:04:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8yCyXTPQoZtRcZQsJIQbJE0GIxqbCuoyPq+LQY2WknfXjhfcSPzpz1/IggdbHc197w7rocw==
X-Received: by 2002:a05:600c:4b87:: with SMTP id e7mr368722wmp.108.1632161057696;
        Mon, 20 Sep 2021 11:04:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f5sm199154wmb.47.2021.09.20.11.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 11:04:17 -0700 (PDT)
Subject: Re: [PATCH v5 0/8] KVM: Various fixes and improvements around kicking
 vCPUs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210903075141.403071-1-vkuznets@redhat.com>
 <87h7ef9ubo.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21214d34-68b6-ba8e-c12e-2fa44a430540@redhat.com>
Date:   Mon, 20 Sep 2021 20:04:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7ef9ubo.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/21 16:48, Vitaly Kuznetsov wrote:
> 
>> Patch6 fixes a real problem with ioapic_write_indirect() KVM does
>> out-of-bounds access to stack memory.
> Paolo,
> 
> while the rest of the series is certainly not urgent, PATCH6 seems to be
> fixing a real problem introduced in 5.10. Would it be possible to send
> it for one of the upcoming 5.15 rcs (and probably to stable@)?

Yep, I'm back to KVM now.

Paolo

