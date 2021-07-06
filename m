Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9953BD8C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhGFOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233040AbhGFOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EficMBrK3RjxJdnJuXm2v4N67pBSOaJZzsEPYjWWVIY=;
        b=dJN8cEGa3NsLwskHc5UWimdmazY6onKthAvDg3rioZmfZS3M+/zQLd5FQJe/XRbtWlJ23o
        Jl+ezLVIJzGZR0jM8fcVNmQ/UNit92tAiXFs5OcWsdYx0uFZJcsYfz2KmIp/00otbqi3iH
        cJl1ub0NyZFFK3hcaPSmYinf79fm7is=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-Vj65RuMiMradKo235gKDKw-1; Tue, 06 Jul 2021 10:43:27 -0400
X-MC-Unique: Vj65RuMiMradKo235gKDKw-1
Received: by mail-ej1-f69.google.com with SMTP id jl8-20020a17090775c8b02904db50c87233so1750800ejc.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EficMBrK3RjxJdnJuXm2v4N67pBSOaJZzsEPYjWWVIY=;
        b=feAz2BuzMNLGPlt7BUfVbGGkBkw3LQ9GwscWp4uSOniBi5omi27EQFd2JEV2JC0Kio
         kTu524W1u7jdhBhCs5Blsdy0aXQCDY9CbbrHS5B0m7ltlZ2Ip1+J+BzeyL1qrFu/Nbf5
         UDOrdgS+UtSAzlxp4ql5oXvM0n1mOt4YomnxwhYtP8v5y+zUxaQxiv8l+7RCFkF45ADk
         azldzndDBnhu7D6YYYmz/GZX7seSyUvLqxwvBqx3TiEsDSm7P6xN0uQ5kezLQ1VVgxGi
         iFdK/4GlrxW7S3WOb/HPS1YuEpJ9Ums8Yy5gUrzdUWGcIKVGYeTNSRqGyVKCHh1mW/iU
         ON2Q==
X-Gm-Message-State: AOAM532Yk1JVBvE+Bc7imRlea5BE39viNdzP+4hFu+JQCi0HcMA4xygR
        o7ez7fqkpGH9duYN82gYum8ULPG9javLG1HM8M3MTqK9zhrxPORlw76/8Gf68Y+s15WKxODMLIP
        QD8XrobY8LT72BEC8YvsRBSCE
X-Received: by 2002:aa7:c38d:: with SMTP id k13mr1191943edq.178.1625582606513;
        Tue, 06 Jul 2021 07:43:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+uS6Tyn+IHvNxVFSFYvW5fgVnHf3+DF7oR5Td6gdpU6WnmzhBr3jYTHljIwwm1QPlRSm2lw==
X-Received: by 2002:aa7:c38d:: with SMTP id k13mr1191926edq.178.1625582606359;
        Tue, 06 Jul 2021 07:43:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i11sm7264840edu.97.2021.07.06.07.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:43:25 -0700 (PDT)
Subject: Re: [RFC PATCH v2 55/69] KVM: VMX: Add 'main.c' to wrap VMX and TDX
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kernel test robot <lkp@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <52e7bb9f6bd27dc56880d81e232270679ffee601.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b1edf62-fce8-f628-b482-021f99004f38@redhat.com>
Date:   Tue, 6 Jul 2021 16:43:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <52e7bb9f6bd27dc56880d81e232270679ffee601.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:05, isaku.yamahata@intel.com wrote:
> +#include "vmx.c"

What makes it particularly hard to have this as a separate .o file 
rather than an #include?

Paolo

