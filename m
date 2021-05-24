Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4003F38F095
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbhEXQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235193AbhEXP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621871778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8qJxDVQ1kylKNxI/QIRmzuDHoPUvchv3PrsNjGkPtA=;
        b=RtzUCCI9g79y398UdqB2WHkqvbhD6+CvULNXZJHkXmFaMyvMr857Cmq/Z0PZ9+lME/5HTy
        nkeBKjzKiZ2g5sHEX5eyEhp3kY9LL2EEAW8TZdKPc/zdVsLchNzFmxT2gKlDlxgqwAH3AV
        uw9i/wa6rPGL6YfjBwODAcRegJek+mQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-lUZXS0Y1PAuvtkqGUnSp0Q-1; Mon, 24 May 2021 11:56:16 -0400
X-MC-Unique: lUZXS0Y1PAuvtkqGUnSp0Q-1
Received: by mail-ej1-f72.google.com with SMTP id la2-20020a170906ad82b02903d4bcc8de3bso7738067ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8qJxDVQ1kylKNxI/QIRmzuDHoPUvchv3PrsNjGkPtA=;
        b=RnzVQO/dARn59soWxl9AFMcMGjvWpNgtIR6GM+kS3MFKFtsWTiXfRP4RYGgrSu+T84
         R9YJHF9gqG5wA6kkxu629tlpIiTrpA4DUO4ZVE/+pvG0yJEeo1euRDg/GHNzw9jat/7x
         OhXs1BXFNZ04j0oZyFpLxWimdi6v/YvLkGJOW0CHuLH67wd4Wqq9jfu6bPS6c3ReWPZE
         bKvyMTqDP3hn8rrp+zz61c8g5mizhfvtqEPopvENfPHpsjg2R9zRiIqX1h1UhYiE/8eg
         jcsPe8UcaG3VCTxj9cHQwk+r/cJ5ve/PFkiCv9jbbHfeQXaB2cIuL5JFY8Tfzky4VqxT
         08qg==
X-Gm-Message-State: AOAM532NmHoeXohYHyAGkd9tUUeYRs0Tkkg13RQn4T1I06CzRm3ugAWw
        sa04SbbevPApm9HnJNjPVO6GuprtvyRsVbGmGreAVrUrtwK/qwwDOYs3k4ErhzV2bUap7Drb9HT
        Ogr4ou0junpQlyUAZR9Lshan5
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr26499478edt.17.1621871775634;
        Mon, 24 May 2021 08:56:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxqIAdA2twCY/NYuWM5QhkC1u2I0/XA7NDRD7mYc3MYp9cHHNqJGAHpd6kL6COESUVJ4IpJQ==
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr26499455edt.17.1621871775453;
        Mon, 24 May 2021 08:56:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h9sm9168331ede.93.2021.05.24.08.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 08:56:14 -0700 (PDT)
Subject: Re: [PATCH v3 04/12] KVM: X86: Add a ratio parameter to
 kvm_scale_tsc()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ilias Stamatis <ilstam@amazon.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mlevitsk@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, zamsden@gmail.com, mtosatti@redhat.com,
        dwmw@amazon.co.uk
References: <20210521102449.21505-1-ilstam@amazon.com>
 <20210521102449.21505-5-ilstam@amazon.com>
 <cba90aa4-0665-a2d5-29e0-133e0aa45ad2@redhat.com>
 <YKvKwpRP6UcftcnQ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e3ccebe-cd18-ed4f-d362-384de0ebfa4a@redhat.com>
Date:   Mon, 24 May 2021 17:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKvKwpRP6UcftcnQ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/21 17:48, Sean Christopherson wrote:
> 
> 		if (msr_info->host_initiated) {
> 			offset = vcpu->arch.l1_tsc_offset;
> 			ratio = vcpu->arch.l1_tsc_scaling_ratio;
> 		} else {
> 			offset = vcpu->arch.tsc_offset;
> 			ratio = vcpu->arch.tsc_scaling_ratio;
> 		}
> 		msr_info->data = kvm_scale_tsc(vcpu, rdtsc(), ratio) + offset;

Looks good, indeed I didn't do this just out of laziness really (and 
instead got a typo).

Paolo

