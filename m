Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8027342E560
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhJOAr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhJOArZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:47:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA9C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:45:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so6037758pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+/y6cfCnkpf4h7nEzOZEu4s3NlJU3OS/ECOtQ/Xuc8=;
        b=tU/7IJDelI3YP64XCJzPolotjnzzXyoGuhQZ89VgcBkYmC0K44u/Rd0gHVUGe5nIN0
         HZMM3D8Vs9iyowGN+do61yhmRX3njzckUbJlhHzz/SXTQmG88H5hpJs5v2K4JQ1ZXogA
         DPqTQTUsojXh+WviX4uPDUOoycPersbnqWebKYohYZGi2q5dwEeDFioq5tXrlaEu3HsV
         NBBd3RDudIfdHfG/yrZO+I0cVYbeYvxgh9NyYYCw9S4M1V1JVb/dn0YTwRA8v1qZFuJ6
         ftkAW7PAH2QPhqic/it1IVk7qCxVn3z8p5PeVMcmGU6adaOR3lXSlBhQRmjRxsn4RlKX
         LrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+/y6cfCnkpf4h7nEzOZEu4s3NlJU3OS/ECOtQ/Xuc8=;
        b=NkYm2WW7P07Skq88AIji00+QHd5x+HgK3ERAG6ucruhvLRwWeyQneV6e70Ymu1l6Ah
         eR+ktnfOstisqPvWqwgXBCWSNiMVlhEjE3Zt/VZI7CkLFwSavcyYtB8qPHt4gOj+xTKS
         h1esiTobt+nLRtP6cCodFRsksCL/vQf4ILVU+6tGhDfk0p+iQR+3GCmtpERIEwFdvHx3
         UIb6dLBUB7FBBDfl1yK2pUpaNoZm6G4nMzOXFnACnXMPSFmi+DsAwzKu1IbiuTmh/NUO
         VUXfQue9Zq7FuvBfTSZTZsmVSmDvQSqs2eqCD/J//tAAxeButrI6wpghTg0hyxIaWLsA
         1eCw==
X-Gm-Message-State: AOAM531LND5hOnx7WZAE9xZmV9edo8XZNNbA4BHWCAm8MfojWkzK2mVa
        1XndqxKj7XbGtRNb+23rPWtEvQ==
X-Google-Smtp-Source: ABdhPJwfa/mi9hyzSxTdd7t58O6VReDwfghkIEXliheIZI+vkt5XSPqVq0DAH0gy13sQzk6Xvj+h5Q==
X-Received: by 2002:a17:90b:4c4a:: with SMTP id np10mr10077433pjb.233.1634258719594;
        Thu, 14 Oct 2021 17:45:19 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s8sm3381246pfh.186.2021.10.14.17.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 17:45:18 -0700 (PDT)
Date:   Fri, 15 Oct 2021 00:45:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/10] x86/tdx: Handle port I/O
Message-ID: <YWjPG7h/fzupVPnA@google.com>
References: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210922225239.3501262-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <c2fa7839-49d5-3e1c-97c4-c1b77e11ef93@amd.com>
 <6cb4efa4-6f40-37f4-8807-e44b2c069021@linux.intel.com>
 <0f2a09ca-b098-03ba-a166-6f31c718220b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f2a09ca-b098-03ba-a166-6f31c718220b@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021, Tom Lendacky wrote:
> On 9/23/21 12:24 PM, Kuppuswamy, Sathyanarayanan wrote:
> > Any reason for using sev_enable_key over CC attribute? IMO, CC attribute
> > exist to generalize the common feature code. My impression is SEV is
> > specific to AMD code.

Unless CC attributes have static_<whatever> support, that would add a CMP+Jcc to
every I/O instruction in the kernel.

> When the SEV series was initially submitted, it originally did an
> sev_active() check. For various reasons a static key and the
> sev_key_active() call was requested.
> 
> My suggestion was to change the name to something that doesn't have SEV/sev
> in it that can be used by both SEV and TDX. The sev_enable_key can be moved
> to a common file (maybe cc_platform.c) and renamed. Then
> arch/x86/include/asm/io.h can change the #ifdef from CONFIG_AMD_MEM_ENCRYPT
> to CONFIG_ARCH_HAS_CC_PLATFORM.
> 
> Not sure if anyone else feels the same, though, so just my suggestion.

+1 to a static key to gate high volume and/or performance critical things that
are common to SEV and TDX.
