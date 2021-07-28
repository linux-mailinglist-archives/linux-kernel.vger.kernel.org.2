Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327433D9264
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbhG1Pzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236736AbhG1Pzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627487734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQeLlDrj+2zPGh64OQJME4svPnnDXTidciAnYNyVY3I=;
        b=bEF9tCWg2c4yRsdw4H6T97Q8HdweuEaFlGc8TlDjNFu1qIvbU0JxZ1AZC7a+SIC1S1Ou3T
        60m86LfzMZMCJczELb97Yi70aAnr0RzlPP3xoz4jp2Ar7HeHzz3XA5lNrtZFteSIAMlD/9
        O8zA+6UNatyumX3xRoNsnuMdBaoQieI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-_afE9NwPOpyHEVpCwwL6aA-1; Wed, 28 Jul 2021 11:55:33 -0400
X-MC-Unique: _afE9NwPOpyHEVpCwwL6aA-1
Received: by mail-wr1-f72.google.com with SMTP id z10-20020adfdf8a0000b02901536d17cd63so1101145wrl.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LQeLlDrj+2zPGh64OQJME4svPnnDXTidciAnYNyVY3I=;
        b=j7gzpfOA7JDb/+LOzdR9zbdLD/Xifgy2ylfKLbPLsmL1pN3/zIR9KNkD8RNqGTJd+t
         LzS+3p4KdRW2LqbxRU38wG0f2gVD9ZRXxzXOAgyFWeI6LRTDPPCt4dNTk3BiBAJJZZZd
         O2dpzTN+LVsb12rLaIcqlacpOQ1RggaF2tEzJOSJPzPZdu5SX52eQne5B0a/tqh0XbvN
         LypWzminlW0NxFspdiai7d7XHmLHOy12dlZSWaJ2o9ubFKH2cb2UW0/tgGmvuAZmvyPS
         PaeGeBovZF7W3GH4aQQpwjkp8P9L38pG49d4Z0B9hvFVHJYTWhhZm7MzFHuDzvj3rrHQ
         fjlg==
X-Gm-Message-State: AOAM531Sh1Ql6lWLBKWGzuQMFT/uxukRcd4WmyVr+6JVmZk1b35ZMlLW
        cIBjk59iinJJsf3wNU51J75Oj6T6B9sGYHGjy9r+vL4NialBOCeJjNoN13uCpkTLfs/fTbTSz6V
        BFAy9xsRGhFgFhlowbkgmc1JS
X-Received: by 2002:a5d:6184:: with SMTP id j4mr75404wru.340.1627487731770;
        Wed, 28 Jul 2021 08:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq32gJVrcQXXHobfwfbt6t5MlpipkUfSHbn6vLhAq9kx1TvR/Iqdm9vWPzj5mRQYkVSLgrQw==
X-Received: by 2002:a5d:6184:: with SMTP id j4mr75393wru.340.1627487731586;
        Wed, 28 Jul 2021 08:55:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v2sm180860wro.48.2021.07.28.08.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 08:55:30 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Exit to userspace when kvm_check_nested_events
 fails
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20210728115317.1930332-1-pbonzini@redhat.com>
 <87o8am62ac.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73c45041-6bb3-801c-bd80-f48b2e525548@redhat.com>
Date:   Wed, 28 Jul 2021 17:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87o8am62ac.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/21 14:39, Vitaly Kuznetsov wrote:
> Shouldn't we also change kvm_arch_vcpu_runnable() and check
> 'kvm_vcpu_running() > 0' now?

I think leaving kvm_vcpu_block on error is the better choice, so it 
should be good with returning true if kvm_vcpu_running(vcpu) < 0.

Paolo

