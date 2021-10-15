Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC80742FB02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242659AbhJOSbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbhJOSbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:31:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE1C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:29:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so7951701pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TK4muVKMb7Ns+Xm1yOVCrF80lAvUzC674/4hmCymmzI=;
        b=kFiY0V76tvuiBdKEyFm6uZctaGl8xd81qkNBeHvZBH74WLJYLf/yci+KauLh1L8bdR
         W5mhe8ch3GwrVQo/W3GgUXG6cyDIkAqBH5IBPj6ljfvlv2cFvSisusYB3wKRlzMRlmLG
         0Lu7SNsx7cGp5UKnjDKbb0xgwo1JZKrtqcYwgQegrEe7SKLBh9WxtzTGA+OZH/UzuZdu
         6uTcyk7KKr+j6+8bgjBlRmu98IHS/3ax/xIN3OZZ7dktY1Scv9kIgg7dNyLAnnSw1Y+/
         5O0yafF3WgvCOP6hO9guSr0cKXf856RSOamLajzcCNjDLO149KyXbguWgW8i2a0Wb5Sh
         zhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TK4muVKMb7Ns+Xm1yOVCrF80lAvUzC674/4hmCymmzI=;
        b=B4KqX7sPAdW14Iq6o0XMiW/bnloe3+nuXMJ09bGYHFjRIv4H+3Z0f4EmD1V5LuhkJe
         htmFg5CFp5MYy4boSf91F0KnYyGvyYQpd1xTPYXufbcTtXYA5q7tcBn/i/QEZzMvUwK7
         rV4RU0cQE2pyrAAGQYTjRbFWZmhk3gXHYi2X+ZAhoHMh3NbC0PDXWp+SKK4Tepz1cxCs
         gCOJ3cvfftqBgJIdC3FvDsLBenUeGiY8tEGtRgyj3ympKjqBqPXu5iTaiuwivnZEuhXQ
         ypMbb4GjKEklE/fTHCNz0kntloS1iYLe6QJGeXZxGF1IgxhGL6VgLP/K8yJvD9GJXl76
         IHMA==
X-Gm-Message-State: AOAM5331spVFNIwez1TqLkg2P8ebBTh4TEXzBagsGtRcHSS/xLW7enLt
        yfGd/MRoOep/GFkRn5Xrg+jynQ==
X-Google-Smtp-Source: ABdhPJyu5fsJR3Urt8tdse5UH4SX2Fs4cnY02yurIUXa0m+4xXB8sH7PZ487K9LjH8EGX2Qt3tHFyg==
X-Received: by 2002:a17:902:ec81:b0:13f:19b3:c0cd with SMTP id x1-20020a170902ec8100b0013f19b3c0cdmr12380227plg.81.1634322551884;
        Fri, 15 Oct 2021 11:29:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v12sm5481261pjd.9.2021.10.15.11.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 11:29:11 -0700 (PDT)
Date:   Fri, 15 Oct 2021 18:29:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: VMX: Enable Notify VM exit
Message-ID: <YWnIc7wVLBjaTcBX@google.com>
References: <20210525051204.1480610-1-tao3.xu@intel.com>
 <YQRkBI9RFf6lbifZ@google.com>
 <b0c90258-3f68-57a2-664a-e20a6d251e45@intel.com>
 <YQgTPakbT+kCwMLP@google.com>
 <080602dc-f998-ec13-ddf9-42902aa477de@intel.com>
 <YTD4l7L0CKMCQwd5@google.com>
 <YTD9kIIzAz34Ieeu@google.com>
 <118cd1b9-1b50-3173-05b8-4293412ca78c@intel.com>
 <YTpZeVZb5tsscAmv@google.com>
 <b6f2acf8-eef4-9483-1937-191209bcef9f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f2acf8-eef4-9483-1937-191209bcef9f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021, Xiaoyao Li wrote:
> On 9/10/2021 2:59 AM, Sean Christopherson wrote:
> > Yes, and no longer being able to run the vCPU is precisely the problem.  The
> > condition(s) matters because if there's a possibility, however small, that enabling
> > NOTIFY_WINDOW can kill a well-behaved guest then it absolutely cannot be enabled by
> > default.
> 
> For now, no condition will set it. For future, I believe it will be set only
> for some fatal case. However, we cannot guarantee no silicon bug to break a
> well-behaved the guest. Maybe let's make it opt-in?

Ya, I think an off-by-default module param makes sense.

> > > Either KVM_BUG_ON() or a specific EXIT to userspace should be OK?
> > 
> > Not if the VM_CONTEXT_INVALID happens while L2 is running.  If software can trigger
> > VM_CONTEXT_INVALID at will, then killing the VM would open up the door to a
> > malicious L2 killing L1 (which would be rather ironic since this is an anti-DoS
> > feature).  IIUC, VM_CONTEXT_INVALID only means the current VMCS is garbage, thus
> > an occurence while L2 is active means that vmcs02 is junk, but L1's state in vmcs01,
> > vmcs12, etc... is still valid.
> > 
> 
> Maybe we can kill the L2 when VM_CONTEXT_INVALID happens in L2.

Ya, synthesizing a nested EXIT_REASON_TRIPLE_FAULT and sanitizing vmcs02/vmcs12 is
the least awful solution I can think of.  I could have sworn I suggested as much,
but apparently that thought never made it from my brain to the keyboard.
