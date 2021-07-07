Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862FF3BF262
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhGGXWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGGXWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:22:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA26C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 16:20:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h4so3942163pgp.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R8rdLFZzl8soE/vbDXvznl/oWc7Zde3z5S9I562dGps=;
        b=v9lbd2SBb2lEjgqXRJ4glMfd5IXQBpVWEbyUHmpFqRUmP7nvdpuLopgf8sLPMqUcE/
         Nef9/qL6QCncg+T4BxAmPczeb2riAXkcHbbr6n8d6lhLtHXFBx/CFABZNreJfYJsWmqj
         ynC+tY2tACgJtZ3rQa31AkKjVqZoiY13ZaFZ+mG+bGMtd16w7K2AnYsKWN24mw6iKgYh
         s1wj/PNjujyeU7+m5wlFYSFUYcKhMLOIfkXt69OhwERkKoyMX4BrUAMzYIKxofOMMYZI
         ArXJ5nOMLbhuRlX7jSYBYV+rA08Zd8X/tv96cSo2JzK0dpZK+TdS9IdZ/Zyj4S6Gf4A3
         nlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R8rdLFZzl8soE/vbDXvznl/oWc7Zde3z5S9I562dGps=;
        b=m6NW2371Fn5stMeMrLnhBYdbEHBTKnk0sUnkyyY3VVXvOkHBSFsLn1tRKNU97t9rS9
         dtt4r5XdEhhjECKCGSlcCCxwE99uQM13yl3nNaMjtBxushXI/UoVADkiEM+uZno4wwJv
         4qHpxcuXjXSF2tmsFn2MN9T14v1LoFu+O9TkDkkuPMnouoznOndMwuNqUZVv6WA7co1w
         krPcbZOX+9SMzrCFmKVszTl0IoaNuePKie/2VXtKJSp97wDQH2klTgDBmzfZ4RqZEv9B
         V4AYWObPrn+mVeKCk4hHrmvuvl1dXHmmCpj5lUmWTvP0gYqv/Rn7fwrgLp/GChZf0f93
         YMmA==
X-Gm-Message-State: AOAM532U6xU1Ld640tG02oP/cZy70tsbULgkbUCrMgNy+s/0XuGG/wsi
        xpxlnsUUVpGNoXl0yrY8hB1bhw==
X-Google-Smtp-Source: ABdhPJytVWWZQOwm+QTA8XO1kepG6J2Hz8iocVD0Zh3m1q0t92PKY9yVjJ0ftDspEPsM5unYzzlaqw==
X-Received: by 2002:a63:5450:: with SMTP id e16mr28082816pgm.50.1625700009374;
        Wed, 07 Jul 2021 16:20:09 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id x18sm292148pfc.76.2021.07.07.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 16:20:08 -0700 (PDT)
Date:   Wed, 7 Jul 2021 23:20:04 +0000
From:   David Matlack <dmatlack@google.com>
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/2] kvm: x86: Convey the exit reason to user-space on
 emulation failure
Message-ID: <YOY2pLoXQ8ePXu0W@google.com>
References: <20210706101207.2993686-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706101207.2993686-1-david.edmondson@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 11:12:05AM +0100, David Edmondson wrote:
> To help when debugging failures in the field, if instruction emulation
> fails, report the VM exit reason to userspace in order that it can be
> recorded.

What is the benefit of seeing the VM-exit reason that led to an
emulation failure?

> 
> I'm unsure whether sgx_handle_emulation_failure() needs to be adapted
> to use the emulation_failure part of the exit union in struct kvm_run
> - advice welcomed.
> 
> v2:
> - Improve patch comments (dmatlack)
> - Intel should provide the full exit reason (dmatlack)
> - Pass a boolean rather than flags (dmatlack)
> - Use the helper in kvm_task_switch() and kvm_handle_memory_failure()
>   (dmatlack)
> - Describe the exit_reason field of the emulation_failure structure
>   (dmatlack)
> 
> David Edmondson (2):
>   KVM: x86: Add kvm_x86_ops.get_exit_reason
>   KVM: x86: On emulation failure, convey the exit reason to userspace
> 
>  arch/x86/include/asm/kvm-x86-ops.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  3 +++
>  arch/x86/kvm/svm/svm.c             |  6 ++++++
>  arch/x86/kvm/vmx/vmx.c             | 11 +++++++----
>  arch/x86/kvm/x86.c                 | 22 +++++++++++++---------
>  include/uapi/linux/kvm.h           |  7 +++++++
>  6 files changed, 37 insertions(+), 13 deletions(-)
> 
> -- 
> 2.30.2
> 
