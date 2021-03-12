Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8517D3398D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhCLVFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbhCLVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:05:14 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A16C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:05:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id p21so16650838pgl.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Dit5vwBS0Tl56hF0sV6VbghcZIe1S41EYMzdih+yBg=;
        b=nEeSswegnhhkAibhJ1uTCz7k5obZ5nRpCoOdtmVAkMw2qaaCjJhhVDtmoL4tNpnCDw
         Y5LFSWSrhdqOAuH/HVKJ4dk5mN5Mx6FvXYQxPN2A7CDRD9SK5Oc4qZ5qKjf/y10yIm+U
         OSKK9/uMf/AV42XbKI7nsC/a4baXpBGqGB8GsManeYAWIrs59hulg3oAnNh9jUEjTB66
         vNO8UAvI9plmjN4fIXrVe6H2bUJUzRmL67aCRXe27F25eXLrkmwsdExayHAA4a9qeQo8
         Vtf8UudYTpY17b50gdeUC06E0XHFn37p5YCbAkpbpoA8ra/9ybWm42/JtkMCKoUrew5E
         yXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Dit5vwBS0Tl56hF0sV6VbghcZIe1S41EYMzdih+yBg=;
        b=A2eDj0hHpEw8dTqqT5m1wiGwcjsGh4vbrpdSxi3H5IL1TZ4Yly2MPtdcMxnrsS2M1S
         10j0yf7o/lBVzQwsxLl51lhlgN+CpeaF3sdMdQBFDLz1/0YwvOX695L3o8cya0iwOIF4
         5vxIdGNjUebV0KLPezgHH/aJqV2StfTfLjhp4mJEH0RqoGSxwZa+LTGz1Kzn+51mUGZZ
         Bnba+jWJY/tLDEhE7DNjmic1MR+RyRYZCN2BOMYpSV3yM8gnj5oMXtgjFEUfbwezg0yM
         Vd8cnDOHioh2n7bZ9euv1d5SfV60/hW7aI6YX+WX4YnK7cxbuhbQjD7zVKJyTmdjs91n
         s+wA==
X-Gm-Message-State: AOAM533qv7G3Xn6lfoRzVPbd45iRZcllRNauRYalbG4Slu+ebBVQ0LPx
        +sBglK8v+ZzNndHBq/6U8IcjGg==
X-Google-Smtp-Source: ABdhPJzmemUX7SbHrAbNu7g0mrdTwUprvem2ml8WOxUCNjRg9YPyfEYgNbttg2HkiAkobkQsrqU4rQ==
X-Received: by 2002:a63:f14e:: with SMTP id o14mr14118322pgk.260.1615583113422;
        Fri, 12 Mar 2021 13:05:13 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1a6:2eeb:4e45:756])
        by smtp.gmail.com with ESMTPSA id v18sm6632395pfn.117.2021.03.12.13.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:05:12 -0800 (PST)
Date:   Fri, 12 Mar 2021 13:05:06 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, pbonzini@redhat.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH v2 01/25] x86/cpufeatures: Make SGX_LC feature bit depend
 on SGX bit
Message-ID: <YEvXgpqvwH2O/5pE@google.com>
References: <cover.1615250634.git.kai.huang@intel.com>
 <eaf02a594f0fb27ab3f358a0effef5519f4824e8.1615250634.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf02a594f0fb27ab3f358a0effef5519f4824e8.1615250634.git.kai.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021, Kai Huang wrote:
> Move SGX_LC feature bit to CPUID dependency table to make clearing all
> SGX feature bits easier. Also remove clear_sgx_caps() since it is just
> a wrapper of setup_clear_cpu_cap(X86_FEATURE_SGX) now.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
