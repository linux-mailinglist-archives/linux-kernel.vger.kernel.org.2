Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52139423266
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhJEUys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232250AbhJEUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633467175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXo9Quk6Y4H0fsDPUHzerD1eOvkjUACN8PkdHlibKSQ=;
        b=ZlAxyYhsQkqUL8IYbuzo7H4So7R+Ky8FCdRqUkvpyCBBNKegxCqo+e5EXaVnUb+eByFPcv
        p34IMEvDPMutBJL74zkprb9gRo6cIxYz7fhJ18A6Qu4n0IaH4v6TlthAGJtasvIlUAbQYd
        SoP5DHCbefMnGXZNaJxFQvnJ4sBLLdc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-sNI9Ef04P2-8SmAy7BumCQ-1; Tue, 05 Oct 2021 16:52:52 -0400
X-MC-Unique: sNI9Ef04P2-8SmAy7BumCQ-1
Received: by mail-ed1-f72.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so489543edl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZXo9Quk6Y4H0fsDPUHzerD1eOvkjUACN8PkdHlibKSQ=;
        b=DtDGdlaRNe2kRp1ir3K5WMX6EEaZ088KeHJLi0U+MK5cUxtDhr5iFL94TtAKXx0E1Q
         GhNmCi/65n83jDl3kwHvutGKX7irzMjkfXBwtKpV9PZGbUvdwHBc93/S/hAhhlxi3461
         iHRs2q4V0C+EtgbNJO2jzptacFoUjl4DK3SWyoHmWr1OFHPjAOxxFPWqc2A82wk0apNi
         Qj6knWyJlcZMh/KsN80opr3kCffckJL9X5MXvr7SdkH4rFxZ41YZIo9ZMP9jvywM8GRa
         8DTlptZa3dK+8DYC5YXUD99aDH+E/nfe5DF/wIw9fUOrqeH04wV3xpWFmvDJsPcJA46h
         DoUQ==
X-Gm-Message-State: AOAM533L7pi3QOcH7hpehQdr2aAzcuKVnvRqoxOMP0Rb0ZYBpVGjGVnk
        UPj7XuzYrKcfyC6RSiqp4s0+5cIMPo9nLebaIkuwN8tXU2v0u0W5JHmhAAIqWJgzBqddkhDuCa5
        167xIteONFKUhjPE5LxCmlLkQ
X-Received: by 2002:a17:906:d182:: with SMTP id c2mr27048698ejz.47.1633467171005;
        Tue, 05 Oct 2021 13:52:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS04pr73Ai2y9+5IP0WTOsQuT9DuyYh0xBiqeTFvHj3RCq/Wp2hs521FyPkADYGpY/sYu0lg==
X-Received: by 2002:a17:906:d182:: with SMTP id c2mr27048663ejz.47.1633467170772;
        Tue, 05 Oct 2021 13:52:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id n6sm9243298eds.10.2021.10.05.13.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 13:52:50 -0700 (PDT)
Message-ID: <54360564-57e4-60de-60be-13177448ebc5@redhat.com>
Date:   Tue, 5 Oct 2021 22:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH][next] KVM: x86: Fix allocation sizeof argument
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Colin King <colin.king@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        David Stevens <stevensd@chromium.org>, kvm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211001110106.15056-1-colin.king@canonical.com>
 <YVxyNgyyxA7EnvJb@google.com>
 <ebd506ba-05cc-99d7-ece5-34bd67fc2430@redhat.com>
 <YVyRnV9cMLzazBx6@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YVyRnV9cMLzazBx6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/21 19:55, Sean Christopherson wrote:
>   I wasn't suggesting a full revert,
> rather a "drop and pretend it never got applied", with a plan to apply a new
> version instead of fixing up the current code.

Considering that there are issues in the rmaps as well, I'd rather fix 
both the right way.

Paolo

