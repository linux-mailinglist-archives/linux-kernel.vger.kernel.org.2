Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B913E57C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbhHJKAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239500AbhHJJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ld0ov5ZFUXowL08LtrrPHuGTJpIQ0NXDqTK+zb0kPo=;
        b=OE2Rx4jZJjJdOyJlF9uKbpiIA5JzwLhdD3r2+XCub6fug44ND2rACiuQugeO/9nykRbw0a
        i8t6RJSWW20fwg+8Atn7Nrd6HRuYYBgY6U3q+p6LMJn7/CiD9wRIgHW/8qvBd2jQ9ETjVI
        HM3UQmaD6m0DmOz4wmc6W6zuNAo6GeQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-OO7AvfmJOwGbOxOaYkAguw-1; Tue, 10 Aug 2021 05:59:34 -0400
X-MC-Unique: OO7AvfmJOwGbOxOaYkAguw-1
Received: by mail-ej1-f69.google.com with SMTP id v3-20020a1709063383b02905b4d1d1e27cso759792eja.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ld0ov5ZFUXowL08LtrrPHuGTJpIQ0NXDqTK+zb0kPo=;
        b=PjPjaSy1ZBxcBfNXhqWgQdm7KJT8HLDBWhpi94r/IvPsTtqPwx6gdmK1Z5TtB1d3ix
         pn/C9QBucwSOaTHCC5P4hyUolqRRrQQVtqYNUDBIGpuYYfzxc2MFofUqFIlsKroqHBT5
         x9tT4TDn3vJkB2PD/kLPTjEQinfJRO/TGpLAqYJkIZM90ZCtc1P8+rrxtBHI31XLVEk8
         nLyx0NO0NsLt+d3JuzILy9QGtOOxXU7Eb5TrR70QxYQ3IOPp5Vth3nVT+7lb5ii6UO2W
         NEwPlWJwMM0ovzey5Ix5xxtKtjmSNKP7Tn1Z3ioIrX/r4mCuTx69KSY9SgsUfXzbDETl
         Ihhw==
X-Gm-Message-State: AOAM532ugN95GwTBoawuwQOoSNZmXajFDLll/iWgboxHox6Jf7cD54S8
        Kuszzv6YiFcMptPSb4MajHpWFdYZ5LCJSm202GCjq4rItQJG2Egq8Dlqgcesdw38ft24cqJppFG
        OIbqruKAy9PeOX2uGgebHJOWo
X-Received: by 2002:a50:bb2e:: with SMTP id y43mr3967347ede.103.1628589573592;
        Tue, 10 Aug 2021 02:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5saJYoklO3PlR4J0I3tkMX/trMfPhYNaGzws5Cn/JV+9a9cwjuu9i9GaWViUAQy7+HEBujw==
X-Received: by 2002:a50:bb2e:: with SMTP id y43mr3967341ede.103.1628589573452;
        Tue, 10 Aug 2021 02:59:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id b5sm6683059ejq.56.2021.08.10.02.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 02:59:32 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Don't reset dr6 unconditionally when the vcpu
 being scheduled out
To:     Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
References: <20210808232919.862835-1-jiangshanlai@gmail.com>
 <YRFdq8sNuXYpgemU@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8726aff8-f7d0-d4e0-ed59-aeffc2a4c2f5@redhat.com>
Date:   Tue, 10 Aug 2021 11:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRFdq8sNuXYpgemU@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/21 18:54, Sean Christopherson wrote:
> Not directly related to this patch, but why does KVM_DEBUGREG_RELOAD exist?
> Commit ae561edeb421 ("KVM: x86: DR0-DR3 are not clear on reset") added it to
> ensure DR0-3 are fresh when they're modified through non-standard paths, but I
> don't see any reason why the new values_must_  be loaded into hardware.  eff_db
> needs to be updated, but I don't see why hardware DRs need to be updated unless
> hardware breakpoints are active or DR exiting is disabled, and in those cases
> updating hardware is handled by KVM_DEBUGREG_WONT_EXIT and KVM_DEBUGREG_BP_ENABLED.

The original implementation of KVM_DEBUGREG_WONT_EXIT (by yours truly) 
had a bug where it did not call kvm_update_dr7 and thus 
KVM_DEBUGREG_BP_ENABLED was not set correctly.  I agree that commit 
70e4da7a8ff6 ("KVM: x86: fix root cause for missed hardware 
breakpoints") should have gotten rid of KVM_DEBUGREG_RELOAD altogether.


Paolo

