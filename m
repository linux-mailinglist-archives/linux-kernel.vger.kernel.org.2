Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AC3B22C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 23:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFWVxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 17:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhFWVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 17:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624485063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3gSPWC7IMsNkMZ2ELuN5o3usr9kao6KnJafO5GBUZ5Y=;
        b=YAmU0znEGT9F6UHt3vWotvd6jYWTPmFLGkIHIC1igH/LD6ijYhqHTtgMYpPXOn5l8iPJMa
        QZF4K7oiaxkPLFYEuCy73pTORjI3DiTBKWPVoUVK7SWR8KKeykUQn6zSacyQ0XiK09c6/d
        MgzuD3f92eOcyvX4nMdOv3b/8nZG4iY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-fb0ocxSKN_q4lu3pRIipgQ-1; Wed, 23 Jun 2021 17:51:02 -0400
X-MC-Unique: fb0ocxSKN_q4lu3pRIipgQ-1
Received: by mail-ej1-f69.google.com with SMTP id c13-20020a17090603cdb029049617c6be8eso1419978eja.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 14:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3gSPWC7IMsNkMZ2ELuN5o3usr9kao6KnJafO5GBUZ5Y=;
        b=BJoYcHF0mbtNN1qewJi/UEc6Yvzdn90XyG38s8CtK+zZMKo4+wae52m66bJdn3dWFt
         1f3eKVrNDUqSID1cNrS8Sp6oReEOP9qFkh/sL5OZ72Nj8uwA7FE5Sn5G4PslUXJ8vN1y
         DtJyDFdxOh/E9JRYkzLk/U71CiQmMIzoP6YhRQNEfoTcKl+YWWxLqtp7dNjr7XTmVzIO
         y9RgWW/w4GqayQWPwr7EkxkwECF4RPWrlYKL7UfEEFQ19gg6QV4Vfd3o3scy10Ba3Isx
         +DWchgprmbvzqB0785NyccR/Vhx+1dA7p9YIk6quy8iA3hLZLRGpq+F+CN5AGIJY5A6S
         0Ewg==
X-Gm-Message-State: AOAM531Ds41ekIpjohnFi44CZIXsS63xdhsfgCXBbdZH1rpyDA7D/pqc
        xJKDHbx3TBdmhNO4MSRRFiejvUtJlCzliWQ2fLscKa5RU6AltPGJgdMAkUvy2A0AmgQ7u/IhtBE
        yHYSKbLw2CTFkXrFp58tAKvgd
X-Received: by 2002:aa7:dd53:: with SMTP id o19mr2518248edw.259.1624485060929;
        Wed, 23 Jun 2021 14:51:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3fXQbvhv6tvmB+nbIKzAiOswAjQ+72S7Qm1E056hEehg2JXiwmIXoSTp4tkTqpmsD7YTvQA==
X-Received: by 2002:aa7:dd53:: with SMTP id o19mr2518226edw.259.1624485060763;
        Wed, 23 Jun 2021 14:51:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j1sm718371edl.80.2021.06.23.14.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 14:51:00 -0700 (PDT)
Subject: Re: [PATCH 03/10] KVM: x86: rename apic_access_page_done to
 apic_access_memslot_enabled
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>
References: <20210623113002.111448-1-mlevitsk@redhat.com>
 <20210623113002.111448-4-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b17cb687-2192-c439-c01d-68e7ceca7a05@redhat.com>
Date:   Wed, 23 Jun 2021 23:50:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210623113002.111448-4-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/21 13:29, Maxim Levitsky wrote:
> This better reflects the purpose of this variable on AMD, since
> on AMD the AVIC's memory slot can be enabled and disabled dynamically.

Queued, thanks.

Paolo

