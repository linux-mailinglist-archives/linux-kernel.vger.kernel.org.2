Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0648F40FEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbhIQRiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237238AbhIQRiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631900249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQ69tgYk0yh6UZaHgteT2LE/TfdaRnldb8roVNiJD38=;
        b=iiyeAz9QaH+6lxRvjURkqzMp+5SJz8MSIDhUVSt4+bj3U9P3exX4kDYn4QL0HrqG+jsIrQ
        ve9QcdgtmIahEHzzrUPWbNXSbdAVt8faFZCj6pLzWWZgUWCEjjkBUuwVzvmtt7tZRvM522
        Z/7cpWb+9fUP8qXtNxuuc5DA93EpaSM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-fmyQeStBPa-D0aHZfepvJg-1; Fri, 17 Sep 2021 13:37:25 -0400
X-MC-Unique: fmyQeStBPa-D0aHZfepvJg-1
Received: by mail-ed1-f70.google.com with SMTP id r7-20020aa7c147000000b003d1f18329dcso9795522edp.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TQ69tgYk0yh6UZaHgteT2LE/TfdaRnldb8roVNiJD38=;
        b=H4idvV+kWMy0DgYQhRdlTN9XY2xgMSpVCGbl/9d0H1lEnX0FuljttdGhVwTL/Qrclm
         WtM12+rsTSW6NrZD8U5yf+YCv5oAD5ufScOGoe+lCR4AGAXfxXyuVsCUvLyULRmqi181
         YLoDFJr49tTFl+kBPHHLlTZbGc0Q0CMBu8y9zVY6jbHOZcktKnfZFcuXKvjavG+kn/rG
         QX0pmb1Kf5A9d/H8yHxH+VWp+n4V0IwDcP5Ssp9VZ232s5cvssfsLNoqDnqvcbCa65G/
         TxGNiddM4L8g/eDryIRzLbrikqv9/qI9NOcN4KwniMqfZbXSs4TtsTA4G9qWjQxuiQgM
         xnHw==
X-Gm-Message-State: AOAM530CyGLR2m6HFWdZ78+2pOvgtf1aofmT7lljVqQiL4Z9nDORBdl2
        2nQpxF07yEqIVc5fOq6IUpk6TrVqVNRAZwnbGiFExQfkdVHuzv4hp68FboPy0c6Oz4en3kh6twW
        zDyVr02/pwX0MJo1VvMFK2gVH
X-Received: by 2002:aa7:d582:: with SMTP id r2mr13896173edq.324.1631900244583;
        Fri, 17 Sep 2021 10:37:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLtBte+3SaIrVpcwkvtQdqnblyNWMQHx8gbT1bNYByKRPARqRI8cZxbuL5acvrGWIvc77JMg==
X-Received: by 2002:aa7:d582:: with SMTP id r2mr13896157edq.324.1631900244407;
        Fri, 17 Sep 2021 10:37:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k20sm2532336ejd.33.2021.09.17.10.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 10:37:22 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86: Clean up RESET "emulation"
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        Reiji Watanabe <reijiw@google.com>
References: <20210914230840.3030620-1-seanjc@google.com>
 <CABgObfYz1b3YO4a9tR02TourLmsnS48RWrOprrsEh=NpbQfjRA@mail.gmail.com>
 <YUTRwNT/O5Ny0MOQ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a77e3edd-2b58-fb46-8a76-2d8446892992@redhat.com>
Date:   Fri, 17 Sep 2021 19:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUTRwNT/O5Ny0MOQ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/21 19:34, Sean Christopherson wrote:
>> but I do like it so yes, that was it. Especially the fact that init_vmcb now
>> has a single caller. I would further consider moving save area initialization
>> to *_vcpu_reset, and keeping the control fields in init_vmcb/vmcs. That would
>> make it easier to relate the two functions to separate parts of the manuals.
>
> I like the idea, but I think I'd prefer to tackle that at the same time as generic
> support for handling MSRs at RESET/INIT.

No problem, just roughly sketching some ideas for the future.  But 
you're absolutely right that some MSRs have effects on the control areas 
rather than the save area (and some have effects on neither).

Thanks,

Paolo

> E.g. instead of manually writing
> vmcs.GUEST_SYSENTER_* at RESET, provide infrastruture to automagically run through
> all emulated/virtualized at RESET and/or INIT as appropriate to initialize the
> guest value.
> 

