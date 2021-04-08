Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9DD358B81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhDHRhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:37:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E03C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:37:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t22so1093408ply.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hVZgbh4zEEXOJBrSWQCq6IMMudTOr92ycubeG9UlX0U=;
        b=MhfTAti86tKItO88AcfDU5vF5tY1xDstmQO5FJYjR+a5YSx3EvaPy3jEJHDYEQmcK/
         aPFlk04sIuXReOxM1199liMx0B//1t9w3buF7geu+CRg7GKZKXeDGn+UWxqZyPyQVGcU
         Eyq3SIB9uZ5xGlXgEiF2UEVu5QqgqSqCcU7gPToN3O3erVl1suY9qRwLSbdkP2Z+VQSF
         kIWMw9s8VgLBvZg5PxtmrYBxYgCDMUgqDXW05wm9YdBg+JOMYAaBl8c631KgtpCpuhMX
         SrQmH7WxZAth0w0tHB/FwWpHXWy+zZ1sBcJDgVJDIR+T81R4h0Jj3D3bOpFDa+wsEPwG
         4tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hVZgbh4zEEXOJBrSWQCq6IMMudTOr92ycubeG9UlX0U=;
        b=r8gYjIhSCnGyqIiijEx/3SYxZQdk9mk6WGujl4nz/GP5q1Jtgwi9McPhhtmR9RZy1s
         z5rmQe0FDBpka3UTeLPJZZkett1S89/+8hSr5prLX7IJ1IqQ8/JjcMK8XzQotPuGW4o4
         MFQnmtTYnulO1hGaPu40y8j7NgwUjPyNRDE40JnLAOLqJ3CSBt3IpbM7m11vAFVcZblD
         YwOsmgwhMim0l3/Pzqv24Xd8Iq4DXLQMdRtRMgqfu/cXIlPrdK6dKRi9Zbkk4uydWFzb
         9Dgxa6jUfaVeLWuuKRHw9dqbOTlbEL4riaqmrS4GVC1KaTys/zZr/Qhb31U63o0czjrp
         rPDA==
X-Gm-Message-State: AOAM532BnRoVbqxKpUXc6RYPAERbMW7OmNwbgstks3vUdn9FyF2uEsMq
        ujU7pCcvplDzg2FEZUuggiR2Ow==
X-Google-Smtp-Source: ABdhPJxhENBCnEW26BKzJQRlggIxwanHciEldY60tfSuxbu/j+3CRL/d2SokWC55V/DlHoUVzDqQlQ==
X-Received: by 2002:a17:90a:b00c:: with SMTP id x12mr3609139pjq.216.1617903452750;
        Thu, 08 Apr 2021 10:37:32 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id x9sm88802pfn.182.2021.04.08.10.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:37:32 -0700 (PDT)
Date:   Thu, 8 Apr 2021 17:37:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] KVM: SVM: Make sure GHCB is mapped before updating
Message-ID: <YG8/WHFOPX6H1eJf@google.com>
References: <1ed85188bee4a602ffad9632cdf5b5b5c0f40957.1617900892.git.thomas.lendacky@amd.com>
 <YG85HxqEAVd9eEu/@google.com>
 <923548be-db20-7eea-33aa-571347a95526@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923548be-db20-7eea-33aa-571347a95526@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021, Tom Lendacky wrote:
> On 4/8/21 12:10 PM, Sean Christopherson wrote:
> > On Thu, Apr 08, 2021, Tom Lendacky wrote:
> >> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> >> index 83e00e524513..7ac67615c070 100644
> >> --- a/arch/x86/kvm/svm/sev.c
> >> +++ b/arch/x86/kvm/svm/sev.c
> >> @@ -2105,5 +2105,8 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
> >>  	 * the guest will set the CS and RIP. Set SW_EXIT_INFO_2 to a
> >>  	 * non-zero value.
> >>  	 */
> >> +	if (WARN_ON_ONCE(!svm->ghcb))
> > 
> > Isn't this guest triggerable?  I.e. send a SIPI without doing the reset hold?
> > If so, this should not WARN.
> 
> Yes, it is a guest triggerable event. But a guest shouldn't be doing that,
> so I thought adding the WARN_ON_ONCE() just to detect it wasn't bad.
> Definitely wouldn't want a WARN_ON().

WARNs are intended only for host issues, e.g. a malicious guest shouldn't be
able to crash the host when running with panic_on_warn.
