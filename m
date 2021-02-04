Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9700D30F0FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhBDKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:36:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235469AbhBDKfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612434862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qWsTxPld0hEiuoxPO/c9bHf318nkKx5uc/Fo065i5o=;
        b=O8DEyTnfbFSQ0hgzmSvuE4LoPYHwnde9Nj4YYaTlyaDaZML6+F5ssJGlaAh2pDr5oW0h/Z
        CuJ3h7ijTxtK/Gy29L+kJc/FCCkT54VrjiSpOkNS9FPkkSs0plOaBoXtZfZ/0OLv+hIvM/
        X3gW+yipvlcLkrqToKUptvxOMm6KUt8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-qXTUkEeAP6C038dstHvJkQ-1; Thu, 04 Feb 2021 05:34:20 -0500
X-MC-Unique: qXTUkEeAP6C038dstHvJkQ-1
Received: by mail-ej1-f70.google.com with SMTP id aq28so2338225ejc.20
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qWsTxPld0hEiuoxPO/c9bHf318nkKx5uc/Fo065i5o=;
        b=hKXnbCPsPll0a5S3KwbHq72PckF7TDzVjV5U3nzgSuDqvCqQNh8icTHfCDr55SPJ3+
         uWhLoh/oX8kRwHgkiJBCPugtCoxPfp8malBGayLKRYdtxSdkNAIs4moARmYTiShqRFtN
         U8mm54yovx8DhQ6FzBABAi9dfMerTIZ9edoEvm7WnCmSQYzXY+K65je7rtybYI3JwEvn
         Yt315T9cWmD7ThL1PmB5euQy026zXQ8DFgN9zhkZIr6LH/V6NhjQ5zeeX6W2Gz+o05mx
         DyR5dIsIruyJLKp6l/6GBhN9gHsbcyebmrN6MJIyInhGsTEHOmiAtN5U/dXXUdzDdLcR
         UqKw==
X-Gm-Message-State: AOAM53041TmRSLCvU+yC+t5gjdkbkf/+9b2+LFhhBuc3SU7VoHZ9y5ZY
        dE9Z5yUJu9R4sbRQzJnTArXInbYyw3oqW1nplB1Xqq6K6XMcX40YezspKINTF86UKCwlFNhjk/o
        O5q1M0xaDMWNXIgg/0yw70uBv
X-Received: by 2002:a17:906:607:: with SMTP id s7mr7339848ejb.301.1612434859655;
        Thu, 04 Feb 2021 02:34:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyc26Db+8nKxp1WBsWO53i+fnEOMalBbhvFAN6L3W4Yk/kUZ3BoXarC4Jw3AV0aCs9W+kOHmQ==
X-Received: by 2002:a17:906:607:: with SMTP id s7mr7339829ejb.301.1612434859465;
        Thu, 04 Feb 2021 02:34:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r3sm2232360edi.49.2021.02.04.02.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 02:34:18 -0800 (PST)
Subject: Re: [PATCH 07/12] KVM: x86: SEV: Treat C-bit as legal GPA bit
 regardless of vCPU mode
To:     Sean Christopherson <seanjc@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>
References: <20210204000117.3303214-1-seanjc@google.com>
 <20210204000117.3303214-8-seanjc@google.com>
 <5fa85e81a54800737a1417be368f0061324e0aec.camel@intel.com>
 <YBtZs4Z2ROeHyf3m@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1d2f324-d309-5039-f4f6-bbec9220259f@redhat.com>
Date:   Thu, 4 Feb 2021 11:34:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBtZs4Z2ROeHyf3m@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/21 03:19, Sean Christopherson wrote:
> Ah, took me a few minutes, but I see what you're saying.  LAM will introduce
> bits that are repurposed for CR3, but not generic GPAs.  And, the behavior is
> based on CPU support, so it'd make sense to have a mask cached in vcpu->arch
> as opposed to constantly generating it on the fly.
> 
> Definitely agree that having a separate cr3_lm_rsvd_bits or whatever is the
> right way to go when LAM comes along.  Not sure it's worth keeping a duplicate
> field in the meantime, though it would avoid a small amount of thrash.

We don't even know if the cr3_lm_rsvd_bits would be a field in 
vcpu->arch, or rather computed on the fly.  So renaming the field in 
vcpu->arch seems like the simplest thing to do now.

Paolo

