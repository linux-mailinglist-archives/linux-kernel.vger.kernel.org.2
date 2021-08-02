Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B43DDE32
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhHBRHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhHBRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627924020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4lwMKCC7NlkG4ATSmT+uT5CYPJxY1OG3QxbgWoAHRM=;
        b=Xf0xKK8SsBf7sjbdq8ShhvsO3NV3OtFUbhw/SvfFcbGiBiOJ0d1uleAzvv6pY13BzhGUoY
        PZlipct8phIjSY2jgFvHrfGTTTsSjWpNIAFT9cqzj+lrLymreqwX3duvRENAy0ajc5k4gA
        1n9wzLD4xW0F3HKjoP8o3zxJOkuyjwQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-xpsptzWAOoC-ztydD4_IEw-1; Mon, 02 Aug 2021 13:06:52 -0400
X-MC-Unique: xpsptzWAOoC-ztydD4_IEw-1
Received: by mail-wr1-f72.google.com with SMTP id d12-20020a056000186cb02901548bff164dso699416wri.18
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4lwMKCC7NlkG4ATSmT+uT5CYPJxY1OG3QxbgWoAHRM=;
        b=RD9VLpXV+aux2Nld9xFsR9NffjSW84j5xarlgon81+Kx7dC1TfzVFzIrhM/VAFW98D
         3cOx9r3pX1VhsCMU8BZemiR9U3a3IofpxOD/zKXEIVUKH3bHhS8EY/h9bA+U/pbRPPnJ
         WGc8/ZPO6zMwSCIReIePO2wCf4x3zlfcJcX5lIoV+l6ZFP+6ae7EjcmGiVIRkE1V2gZC
         HQcQv8qz3zlM5C57p02MRTPNp5uZD4EIhG6ccqVFZ4izUFEnlHvY/ck6JbVblFVE1ST8
         Fn6Dx7i38t0kwEp6IJZqa1Bv41G0WW6KkcwcrREs/sS3A1SnhTnm1PPx1VV0m0KpN8gZ
         Om1w==
X-Gm-Message-State: AOAM5310auLxXUgkh1iB14k1SiJaW6bNOjK0oA+/CR1l14tZb9Pk481D
        6DX2Vcns/PYuUKTV7KFXa5D4e/NxlDUnerYh+O36DcoRX077c+MmaNPqOIPGLcuRzmEvl+ri6e0
        HFxycnsibOv9RJsuj4jztuaht
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr18972753wro.207.1627924011235;
        Mon, 02 Aug 2021 10:06:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo5sPteImDc9abUNEZYX0kzt1dGg74F8oz5KGqicdPKEDIqO068oh3dyWbeHS0FkMU9BubBg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr18972742wro.207.1627924011077;
        Mon, 02 Aug 2021 10:06:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j6sm10537227wmq.29.2021.08.02.10.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 10:06:50 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Exit to userspace when kvm_check_nested_events
 fails
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210728115317.1930332-1-pbonzini@redhat.com>
 <87o8am62ac.fsf@vitty.brq.redhat.com>
 <73c45041-6bb3-801c-bd80-f48b2e525548@redhat.com>
 <YQGZpPUC5TViIRih@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f309e9ff-92f3-8dd3-6c31-071e02b9c387@redhat.com>
Date:   Mon, 2 Aug 2021 19:06:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQGZpPUC5TViIRih@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/21 19:53, Sean Christopherson wrote:
> Alternatively, what about punting all of this in favor of targeting the full
> cleanup[*] for 5.15?  I believe I have the bandwidth to pick that up.

That's fine of course.  I'll keep this in queue for the moment so that I 
can at least run Jim's testcase, but otherwise won't merge it to kvm/next.

Paolo

