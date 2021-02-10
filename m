Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED39316F23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhBJSrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234158AbhBJSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612982263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkZWpbYsRKJjW/NAfUknYV9OoyTRDMeK+ozCPOtJ+JU=;
        b=J+44i1p+Mi3SL2g0QT+lnZwGHbJjL9fsTp5EDEFEo++puhB0WpXPfwyxF6CKtCKa5TMI5j
        oK7GO6wpMcfnzHvw5autD1OB4paoRHnOQQRMLPWJgAPQsf7R2Ms2rb4I56oP5uM4vjf9HF
        roJG7muLmPSvQhtzfDm9z9NTBZhPOUE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-eNWS9-s_MMSLygNvnCfcgQ-1; Wed, 10 Feb 2021 13:37:39 -0500
X-MC-Unique: eNWS9-s_MMSLygNvnCfcgQ-1
Received: by mail-wm1-f70.google.com with SMTP id b62so1808931wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkZWpbYsRKJjW/NAfUknYV9OoyTRDMeK+ozCPOtJ+JU=;
        b=jJ+nzAzVs9o8Rm8peC8J7aKgOuVxeGu/fVbSpiSrRxuv9LnC9HtlZvSLnEq0yV7ZQu
         G59x+U61s/HBG23acorzIr1hFqhX7x0aAbOFPj4AP0h1KbKwlbRsS6UlK6Du5UdOQNcm
         tloFk3n6sNyyBP30U9yVQoKwE7rrAw04UZxj69IaZz/SleSc1APxSdDrIGu6favE7bhh
         o7J6IQTVqGULbZeKbgkW0xajI2TxsCBAxZaOwMw/TY3xjuae/r/M54xNOqRqyhVX+6CB
         LzTxjqJ1msbzMGHCIE2TgGm2rHyPHwBlUrt93iZLZh3gGqW3vOMCbIbYHp8kcyUySAGn
         kUuQ==
X-Gm-Message-State: AOAM53377qhCZenqfUcT4QNKqZF1B8XcKbB1EJAcVSzBFAFCr7m344+0
        GOsuxSBQlFJQcMc0CYjGK0mgBcubz0o+IFLdvajmHDfFFiE1YGKYXchfqunFsE68Ks+JraBjECP
        qzk3Q57brShlbSsRHXGjxaDp1
X-Received: by 2002:a05:600c:4242:: with SMTP id r2mr238756wmm.109.1612982258413;
        Wed, 10 Feb 2021 10:37:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvYPABVcDXEVZzk5DLGtlJTGuU5nmbBaGPIcD5k+EhFtjbWNd0Jaor9nUC8Ahgggr2TYTRsA==
X-Received: by 2002:a05:600c:4242:: with SMTP id r2mr238737wmm.109.1612982258248;
        Wed, 10 Feb 2021 10:37:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w25sm3494429wmc.42.2021.02.10.10.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 10:37:37 -0800 (PST)
Subject: Re: [PATCH 0/5] KVM: x86/xen: Selftest fixes and a cleanup
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
References: <20210210182609.435200-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc334fe4-0ddc-b991-ad76-1d70c065fc16@redhat.com>
Date:   Wed, 10 Feb 2021 19:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210210182609.435200-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/21 19:26, Sean Christopherson wrote:
> Fix a '40' vs '0x40' bug in the new Xen shinfo selftest, and clean up some
> other oddities that made root causing the problem far more painful than it
> needed to be.
> 
> Note, Paolo already queued a patch from Vitaly that adds the tests to
> .gitignore[*], i.e. patch 01 can likely be dropped.  I included it here
> for completeness.
> 
> [*] https://lkml.kernel.org/r/20210129161821.74635-1-vkuznets@redhat.com
> 
> Sean Christopherson (5):
>    KVM: selftests: Ignore recently added Xen tests' build output
>    KVM: selftests: Fix size of memslots created by Xen tests
>    KVM: selftests: Fix hex vs. decimal snafu in Xen test
>    KVM: sefltests: Don't bother mapping GVA for Xen shinfo test
>    KVM: x86/xen: Explicitly pad struct compat_vcpu_info to 64 bytes
> 
>   arch/x86/kvm/xen.h                                   | 11 ++++++-----
>   tools/testing/selftests/kvm/.gitignore               |  2 ++
>   tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 12 +++++-------
>   tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c |  3 +--
>   4 files changed, 14 insertions(+), 14 deletions(-)
> 

Stupid question: how did you notice that?  In other words what broke for 
you and not for me?

Paolo

