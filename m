Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9513DEA88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhHCKK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235290AbhHCKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627985425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfOI5BQLkvmy3gTPFxCm3AerU5X6fkkIIhM9umQ8DpQ=;
        b=Q9r/s5WE5cXZ9ZYGU9GHNcTlxEiCDmQEZDQiqKKcc9Nz7jwaIw2UNeSHCcWpurrtvA8g5X
        3tY4ap1s2QrXohHR7P3dTFNi1RbXOuYPuE7XzTibPVZYBQlggBRuUdasVOhuxia9pZAu4F
        tHJhTS9kWgJZM7+rof5s/wBTFrP05Kg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-mFdNTK13NWCTCC-4wofLNg-1; Tue, 03 Aug 2021 06:10:24 -0400
X-MC-Unique: mFdNTK13NWCTCC-4wofLNg-1
Received: by mail-ed1-f71.google.com with SMTP id u25-20020aa7d8990000b02903bb6a903d90so10231211edq.17
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OfOI5BQLkvmy3gTPFxCm3AerU5X6fkkIIhM9umQ8DpQ=;
        b=FzDKRwRCtEXQDlz/hJzuAdpIcertidL/yCPOPEfXIQPH69LN3kOof5nVq7S+KsOgyW
         5pwWe5az8VRcIT5w6rRFwvvSvfOoOolN+rB1yyQvuEN83YV2mwJW0H0Uim4Xx1ilMnPa
         nmHP9OYSBQGUb1tyf2a5MgdYDMxZdHjmXc6LUOqQK3RWXCdUsWDhsxlzmE5T+rOUhlwW
         bI4hJNyNLLK7qVVmKSg5FVST3bDPYmp5PScmmlkUW4mWl4phd78eEiFQWWsxxiZH3iJR
         efiILvBBcSDmJIZKWfotUTWtSr7nsoRxIJLlP9N2eoDqFdE9Xy17/oHbKHxStdyTyq8K
         +IRQ==
X-Gm-Message-State: AOAM531tLbZqMb3cIyZ28tDRXDgbFysU1iZzjusPJCdhmucyra7+Pke1
        1r3+9De34pFWAZHA8eWlOgkxRp64V38G09tJioOyD7NGXlkIl23pTj6yJP5VAhCZDmIH98HxNlL
        f881FxtNxUJlD4TQQYxpc1wJA2cyxAp+hVBc0ICNIvi6KXFr8QW78ydfYtcVnpjOQibSnPX5EMj
        nZ
X-Received: by 2002:aa7:c792:: with SMTP id n18mr25043047eds.269.1627985422302;
        Tue, 03 Aug 2021 03:10:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3kVrw5MTcDI9OybfehAfSQ7erslosbBvvpZwwtNS45igYKMuMk4BoT1R5P8G1dajNAUraxQ==
X-Received: by 2002:aa7:c792:: with SMTP id n18mr25043014eds.269.1627985422004;
        Tue, 03 Aug 2021 03:10:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id cf16sm7767366edb.92.2021.08.03.03.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 03:10:21 -0700 (PDT)
Subject: Re: [PATCH 4/4] KVM: selftests: Test access to XMM fast hypercalls
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20210730122625.112848-1-vkuznets@redhat.com>
 <20210730122625.112848-5-vkuznets@redhat.com>
 <20210730143530.GD20232@u366d62d47e3651.ant.amazon.com>
 <878s1namap.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1939b03b-cec3-2c2e-2f67-b0dfc2c83735@redhat.com>
Date:   Tue, 3 Aug 2021 12:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <878s1namap.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/21 16:50, Vitaly Kuznetsov wrote:
>> Should we also do WRITE_ONCE(nr_ur, 0) here?
> It could probably make sense to replace 'nr_ud = 0' above with this so
> compiler doesn't screw us up one day..
> 

It should be okay with the "memory" clobber.

Paolo

