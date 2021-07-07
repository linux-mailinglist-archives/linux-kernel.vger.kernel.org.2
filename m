Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF63F3BF265
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGGXZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGGXZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:25:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292EEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 16:22:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y4so1472598pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKd8HDMrjBFzk0VAe0M8v1m4ouhHl4ySw1cEWElJcmo=;
        b=Er5fM8T7T1Q/k5rScY29CLM72/C2mVp6/IuOE2sL3+ynyAkqXl+OqtmcGoryLo3xH6
         nmgM2zQeQJ6Nvi6x0SZZ2TUaTrUJ6CYQ316Tv0MdHI2cOe4uRG7XzBHt3YluxiW1tEpD
         D330D6W/kSyivKd5O4tzPi/E/6Vq0woMdaMbLxCucEuxMvlB/jX8aYHbMlFHJLiWOkCg
         NJFrg5bMTWkSacvpRXspojqxjmEVrdUhjyY8OTdiie5sewZQI2aNhpuoEBEYPl9AEmvB
         K60041p4jIk9NqOqOxyqOETbMFjByP9IKKrWVLAsBbugikVQ5Z5TxTClNkYAlYkhhw8z
         rzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKd8HDMrjBFzk0VAe0M8v1m4ouhHl4ySw1cEWElJcmo=;
        b=hDPCD5M4Xi5xbwY1s4hziCRsmAu9tyf4pC5kgfgcFJMrGzif0/aE8UHgIk7HGncB8C
         iiK1phSTMlFEQ5qxxUDlM+a7nd3SFY5xRuzopv79dkZGb7iNdwwlWJttkGkv5eYbkRLQ
         nZPu50k9rq/WclAJggfwUGPQaazC9f58VynnJbuUONKjHeZwY6fO+kmnFeehpJVV6mrM
         B5IqPM5uShsiDoFT/8Dmro8LMXoE5GlVjwIDhgOwXZkLodLeJ67EtyfcIvTN7a/kX4zH
         VgxucgJc7520Flx0eOYquB5WFSGDy4Zegf34FDj0RVr06Poa9AV48Iv9Ryk4/mI5scGi
         MD6g==
X-Gm-Message-State: AOAM532XpWKE2XCQboVt3LRYV3g2QaY2gUr/q/JlgSgpcV8YEDIziYzl
        m/nUWHzW3DZLHQuj+jiFaNv2DQ==
X-Google-Smtp-Source: ABdhPJzh9BGFbFuxvGs7no5halNClQJ4ARXKZ11cDaqJQcr3A1ELX4x6t3WE8OWICjaRF3XoWpfe/Q==
X-Received: by 2002:aa7:9d1a:0:b029:30f:df6a:77aa with SMTP id k26-20020aa79d1a0000b029030fdf6a77aamr27238659pfp.35.1625700169406;
        Wed, 07 Jul 2021 16:22:49 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id w5sm284204pfu.121.2021.07.07.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 16:22:48 -0700 (PDT)
Date:   Wed, 7 Jul 2021 23:22:44 +0000
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
Message-ID: <YOY3RP8iLuWl1Zwh@google.com>
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
> 
> I'm unsure whether sgx_handle_emulation_failure() needs to be adapted
> to use the emulation_failure part of the exit union in struct kvm_run
> - advice welcomed.
> 
> v2:
> - Improve patch comments (dmatlack)
> - Intel should provide the full exit reason (dmatlack)

I just asked if Intel should provide the full exit reason, I do not have
an opinion either way. It really comes down to your usecase for wanting
the exit reason. Would the full exit reason be useful or do you just
need the basic exit number?

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
