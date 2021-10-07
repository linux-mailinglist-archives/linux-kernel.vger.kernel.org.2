Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506574259BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbhJGRtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241071AbhJGRtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633628866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zMIgq/shF4zYaj1gUby36uqdLSqQ0DPEM64q06xf0oM=;
        b=VLyYn/prYDV98BIXWh3m31tZa0WcmpVkIxx0AGuUVC/mR/Y2/2JLSb7hoHjd/Ju0KtcknE
        7YdrzGpNA74Fg7VSaYO92+jhiqhfXdpD0zPZsmbnEteKufHhSGpXbhGIlqQuWMif4qjb+h
        8E1b8hw/9LjrILhoVR18ELRbZ5OoLoU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-5cIB6GkSOa-xBKBmy9zkgQ-1; Thu, 07 Oct 2021 13:47:45 -0400
X-MC-Unique: 5cIB6GkSOa-xBKBmy9zkgQ-1
Received: by mail-wr1-f72.google.com with SMTP id o2-20020a5d4a82000000b00160c6b7622aso5220198wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 10:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zMIgq/shF4zYaj1gUby36uqdLSqQ0DPEM64q06xf0oM=;
        b=DNpnE6XD7EPuU4Z3uOOb//iUuYEA/pfS7RyzWEFtUNHIBWx7kwAvsBozf1xprUag89
         /Vv8SWMIZ0DOQaRktQV6K0+YtJ94uCtjPsuGjKTx4Na53IC5h0tzR7NTN1geKX0eDKyO
         gtlXy/sn6umPAn474t8QGG5XzxK9qVeYFjx0X8+mAEI08185R4EPDfQCXf92Zjz2jzFq
         2i51UJWyKa4kJvo8ZObeNFC6cz/+u5TcKbmr7qtqeX7jKf6/4dIJJCquCegkJa3kgPy6
         daScEkVwLqjjJoQS0EGaa1eaw+M0uLfuH3lvFlNtJuuJO10MW+6gUWHUPNvzwYAj7G8z
         cNpA==
X-Gm-Message-State: AOAM5311cx4OxTtwqHZM7U3a0TLKwzZ0C8Bc0S9abL/+FkdpmdxmkO/O
        H7u/1Xj/bESo5eAKohLEYuCirAm3df9qiLNx9cMq0mlrJB3ejYag/6DUKkbbLvvOs0917FZxGyj
        w5FJRxKH3wCGBZbgkDFiMrvWM
X-Received: by 2002:adf:97d0:: with SMTP id t16mr6921551wrb.124.1633628864695;
        Thu, 07 Oct 2021 10:47:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVQLk62OBdz/FxDWWdF4DHH5+h/b3zennVSvs4B8TXw3JIJsMFZYSDdaYmn9xuR8+I3uSEKA==
X-Received: by 2002:adf:97d0:: with SMTP id t16mr6921533wrb.124.1633628864451;
        Thu, 07 Oct 2021 10:47:44 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h18sm84173wmq.23.2021.10.07.10.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 10:47:43 -0700 (PDT)
Message-ID: <81bfc7de-2b9e-f210-0073-b31535d7b302@redhat.com>
Date:   Thu, 7 Oct 2021 19:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.14 4/9] KVM: x86: reset pdptrs_from_userspace
 when exiting smm
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>
References: <20211006133021.271905-1-sashal@kernel.org>
 <20211006133021.271905-4-sashal@kernel.org>
 <e5b8a6d4-6d5c-ada9-bb36-7ed3c8b7d637@redhat.com>
 <CA+G9fYt6J2UTgC8Ths11xHefj6qYOqS0JMfSMoHYwvMy3NzxWQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CA+G9fYt6J2UTgC8Ths11xHefj6qYOqS0JMfSMoHYwvMy3NzxWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/21 17:23, Naresh Kamboju wrote:
> Is this expected to be in stable-rc 5.10 and below ?
> Because it is breaking the builds on queue/5.10, queue/5.4 and older branches.
> 
> arch/x86/kvm/x86.c: In function 'kvm_smm_changed':
> arch/x86/kvm/x86.c:6612:27: error: 'struct kvm_vcpu_arch' has no
> member named 'pdptrs_from_userspace'
>   6612 |                 vcpu->arch.pdptrs_from_userspace = false;
>        |                           ^
> make[3]: *** [scripts/Makefile.build:262: arch/x86/kvm/x86.o] Error 1

No, it was added in 5.14.

Paolo

