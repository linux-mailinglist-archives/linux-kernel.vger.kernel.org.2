Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF540E93C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356871AbhIPRvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355729AbhIPRmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:42:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1857C08ECAC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:23:58 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w7so6596878pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=os8rPPCaF89PPiVrnE71sKF7gfEFVZ9yV2+yV9yUHR4=;
        b=Qb7LcVXCEjjeuIheMzTtc2GBg9gKLbCPL2bZUc8zBpPNURrWsv9Dgnvee8UtwAWpM2
         KqT/003vxruXr7KvESOWEYGCW8cDiHRUrvna29ezRiXEL0TG94mmXTtGX1qDpQheicNK
         EJpOb2fAMBJcuXde7O4ul41Iesw4VTEKh6ryNr188Zt3lxJIhepqVgbGqltAtB8l7cJC
         x+Lwo12+goZKaiUbtn4AKpOiy98M1xmhxYd9QVM7NtVIHyWIpiL2gX+CfyqquAh+t7D9
         fYg7i6oEdhc/SOq5/aTlsBUyZuH+LbjSZnyz/W7186frV3GulKYIBjerp9S0M0sKpBB7
         NMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=os8rPPCaF89PPiVrnE71sKF7gfEFVZ9yV2+yV9yUHR4=;
        b=YYSpTIcCXHNCnCz7GEs7G6skkuV+i0KCrg4XFFOfXnulNVfIBLyN4B0NJtM3LDeH1X
         UC/c+N54LwWXhP9r2uqPH/UACq2qqE+eEXzoOA06qVjDnPeDd9y/u586fC8+RJh6KzX/
         0aFgvlfSbYQrhetkswnbQAKvqIG7mFiccdLomR1VOgIfmmNhhcuwIbpylD2k0fuhvBwk
         TeLQEE1gH7EmVWBsVp/1yMf8LoQa7o/O0P2NsJcmBr/ltlNKCJDxeUzt1T2RHV6p8yHR
         IlSRI//pJLPRG+Xebeq8V1p29ZROVJc0QfsXVJDri9h6OPVm9TH1PLZYy5Tn6lgbcHov
         L0lw==
X-Gm-Message-State: AOAM5313XveJOmU2IPtPAy5ct77kHV+wqoxQ4NcukzTHORKGRYlO2O1O
        gnuBfpMlx1mZW8+JXhE+P3CqpA==
X-Google-Smtp-Source: ABdhPJwl7DlrIO8koo0hDyar+Y2gWKmCVex6gaphG2oB4GTxCDsWv80YTpH1lwK43hPlXQ/YtKlphw==
X-Received: by 2002:a63:b349:: with SMTP id x9mr5643759pgt.139.1631809438005;
        Thu, 16 Sep 2021 09:23:58 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 19sm3761871pfh.12.2021.09.16.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:23:57 -0700 (PDT)
Date:   Thu, 16 Sep 2021 16:23:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Edmondson <dme@dme.org>
Cc:     linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>,
        David Edmondson <david.edmondson@oracle.com>
Subject: Re: [PATCH v5 2/4] KVM: x86: Get exit_reason as part of
 kvm_x86_ops.get_exit_info
Message-ID: <YUNvmbtmgRkhLguj@google.com>
References: <20210916083239.2168281-1-david.edmondson@oracle.com>
 <20210916083239.2168281-3-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916083239.2168281-3-david.edmondson@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021, David Edmondson wrote:
> Extend the get_exit_info static call to provide the reason for the VM
> exit. Modify relevant trace points to use this rather than extracting
> the reason in the caller.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---

With the From: / Author thing fixed,

Reviewed-by: Sean Christopherson <seanjc@google.com>
