Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB03A8346
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFOOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhFOOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:55:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA9AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:53:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i34so11649937pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f+mb8hE5qEI8SFYdKsdXmbC7vnzJ890l7d6jep5B66Y=;
        b=LYh/29XOkqDQNUxW1cp+diIVw/W6KBSo0Tt0wzhVafr9ep70jVeKOqGPOmVZyi8LNI
         YU+ZmHf+sdXXG0BvM3oihR5dZbZmc+gKejJC7bNHHV3046IM6W4GzWJZPMOFuS/PGQOi
         NHdh3swAubUq5MwD5q7yaSEUMLGgmCCUkj97MUYAaT5wVOEtoGBr0NCL1sK0M1wlC8cH
         Pwn0IB8ttE8UCiWt2utkOCjJnXCycYY1rv0gMV16iVT+MU2Ks2F3fmTIXv7Rheew4TCp
         SbTCwp0p8fE2FLjvExh/vs06HiOnvfpV06OVgCUSX0nnF1hZ3KNopdcz/Dcz700GwJk2
         6WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+mb8hE5qEI8SFYdKsdXmbC7vnzJ890l7d6jep5B66Y=;
        b=XmxkjmBeRVMFhVGFXY7tAIN/xU2S6mdXx483SxyexRITOrcglcMpgc/ws3K+xYW7kR
         Y0rR2zkeq1p3Xm7l+MFK56SP/vAHHDRvjhu4klwihwIZgh6rp12SygjfEMfnkbrcygTd
         WgTlvGsVCAvglQz95wlneZO7YqGYwqFp6uAwvEmSGgAVho+ChsEvlsN0+wnCj+WY7lhd
         2+AF3WHMsQcycF4dXS4d9qo6aD5WWU/Y3q/0fXcG7Oi0C247/VoL+nS4r+OPhBgwsJwY
         lO2UZcKAWFxi5I6/NI/sIKmqankrrJTV2LLqzi4/k2jNrT8JHfHXdR5ZgLl2wwwt0VFj
         9Njg==
X-Gm-Message-State: AOAM53249DZ+qPpV9FRJmquTFGaD3cRkOEGSQVO4IfjC257MmcQcHYoy
        bpl+HBKTRJb7+WfUOVEPfF6LaQ==
X-Google-Smtp-Source: ABdhPJwOAV4Cy4XCSyqnDXDu9WbAj0nWVCvnYftwqVtM4oOSh2fUoWF3gKPbJ5G7kIYo+Yruveq+gA==
X-Received: by 2002:a63:2ac4:: with SMTP id q187mr22527029pgq.370.1623768799808;
        Tue, 15 Jun 2021 07:53:19 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gf10sm15331746pjb.35.2021.06.15.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:53:19 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:53:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: hyper-v: housekeeping: Remove unnecessary type cast
Message-ID: <YMi+2z+v6YLY/P55@google.com>
References: <20210603132712.518-1-sidcha@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603132712.518-1-sidcha@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021, Siddharth Chandrasekaran wrote:
> Remove unnecessary type cast of 'u8 instructions[]' to
> 'unsigned char *'.
> 
> Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
