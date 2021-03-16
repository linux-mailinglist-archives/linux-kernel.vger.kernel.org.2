Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE89A33DBB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhCPR5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbhCPR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:56:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2ABC061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:56:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1849245pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Fb2x79U5zaHbdcvBiPOeYxbZaxlZ4awwzl5b67JIsM=;
        b=m2j6LyS9YlCfS3STNf7qlGcxc1tXrWIcBoUy3NQ4dKmevWQabCEkq/qd0r63RSAiuC
         lBXpXtFGc/IvwQL6J1ONaPV8nP/EMtgZQOnq1/GDAhFgDoJMGqUTq99Gh5w5DgZFlAKR
         GUjRwj2ekreC4yZIHWXklYup63XEoIbSowlLMYeRg1a9viw/vBaLAA1+3AdrU1bFaMPt
         LhXH7V3YIJ60B9wiLRPUJIcMHYZMzzjQBgDti9bZfILeI0aK7M97vfLpK2YcPwihIpQh
         2SeBze0R7N4gEosu7o0tYDo+ztj5sBwJuMFEDEO0UIqE7Axq1a4si5vwkN33qkDVJF/0
         J0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Fb2x79U5zaHbdcvBiPOeYxbZaxlZ4awwzl5b67JIsM=;
        b=Wr/j1+8K02nab+BgrP3zqSMBFGyHa7zyvq89d/BZqIjI15ZujtcpH2BvFnygtSA6qg
         /+vvNaF19QePxxsqGhGnG9IKgBkWf/8Z03Ikk5Ic/VpwEo32Dx481Bt08R9QGS21i0S3
         6i0mtB6szJkX+qMAAZS925Zw9kYBKbwChQzLsCP1q07tIANQE+WEVd3SFdE/9iPYVM0C
         ZpM9pXj/LoUl7xeU5RhCbw0d6vVV2uY6O/AT9flA5FDPZjIDJXr/HWqQSpNrdq65YW8U
         Y1Wo23FUIILETgGXzkB4hwlJpJ4LMPOM7aKGcQ6SmNKoMKlAmakwwvNlp5XNUBfSJtnW
         wLIA==
X-Gm-Message-State: AOAM532roL+R4Xi0kqX+5RUPBSyh94fyFqjbu88oh5Cmjk2r58eL98V8
        7IcUw5uxwLRQwitUP8ABiPFpew==
X-Google-Smtp-Source: ABdhPJxsL6PpqPY6ix5HMRn40GECN+ZQ+YyV42zz/Qa0uymjHU0buUNurr3OUlzCGS0ODC+r05iJFA==
X-Received: by 2002:a17:903:1cb:b029:e5:f712:c13c with SMTP id e11-20020a17090301cbb02900e5f712c13cmr583155plh.22.1615917366104;
        Tue, 16 Mar 2021 10:56:06 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
        by smtp.gmail.com with ESMTPSA id gg22sm90105pjb.20.2021.03.16.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:56:05 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:55:59 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v3 3/4] KVM: x86/mmu: Factor out tdp_iter_return_to_root
Message-ID: <YFDxL657K7ApIto0@google.com>
References: <20210315233803.2706477-1-bgardon@google.com>
 <20210315233803.2706477-4-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315233803.2706477-4-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021, Ben Gardon wrote:
> No functional change intended.

I want royalties.

> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
