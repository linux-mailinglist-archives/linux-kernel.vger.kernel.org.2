Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E4E339183
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhCLPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhCLPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:37:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B36DC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:37:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 18so2111218pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jt792dKs/llgyWo33ymCHaCpazZPEqhvhL9FOp358RY=;
        b=QPGQHAi8U/A8w1ozQCOU/Sp7LU/rEAp/duoe1R09x6vf8uNlf96uvoVoCvXv0Y0Gns
         2dHixhTPIxSQG0erhnkUDsm0gFXbesWBuaT6u/msjXrwkYlj3v5QDYW9taAo/PGOlXkL
         YRKZk6/yjFL2epGSNWNXiwtABmPLrafl9RMtFrye/de9eZ5nNLePa70ziFrGCUJrl2na
         lA1BoJpbAflNA6j1uJ8bHglxKBUOGI925DbfnpLJbozUJLhETto4nR61qj/SbJwDaS17
         tWtUTmGMpTx8kAsRSDENkwQ2k7aTwxGbLNHwhKTrmutcUptbymYKHnNt2OMQfDf+o1zQ
         sxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jt792dKs/llgyWo33ymCHaCpazZPEqhvhL9FOp358RY=;
        b=dVb1dDp5csBsFOC5VAKeQZEeHQXzODhacEUwdD6kBvo5+rjbu9N1FlM4Rql6iuPDA7
         YFtIhIRdg6IhCnTThYQQ6mzquzRUk72zmmd3iVjB6qXPrD3nPupX8cMs0Uj6YIylv0ea
         UyMPKdGYZHToVy5J1/49uWXhUrkpXFXj/MUzDTR0HGYi0CE4QoKFY4eeH3SD1vWmekz2
         RoNwCcvrDINn1QXMpKwyPVjyKiaJBOjwRyF5agHYSeiKukPGI43BfKCq9oOtZB41FUW8
         RVbv6qHtiwbdMSayuXWfkdfMq25/tQcWAw14dO09mQMsj6L+nopNCWK7PviTf2hf8+yz
         aYaA==
X-Gm-Message-State: AOAM533aOso21gQ13K80fTKkVN0XYDkeD+GCrFuwT1cmDviHK4ENHr9D
        BSa2qpKgRjA2ORGi7nNhED2+Jw==
X-Google-Smtp-Source: ABdhPJy7W4+TtX5yPhl51VidgkDEFB41N9o6eUWz+XIlw9pLvmmH+nNSdsbWFo95/Bk7G1dsBd4juw==
X-Received: by 2002:a63:fc12:: with SMTP id j18mr12234082pgi.334.1615563470368;
        Fri, 12 Mar 2021 07:37:50 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1a6:2eeb:4e45:756])
        by smtp.gmail.com with ESMTPSA id e1sm5905729pfi.175.2021.03.12.07.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:37:49 -0800 (PST)
Date:   Fri, 12 Mar 2021 07:37:43 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: Fix RCU usage in
 handle_removed_tdp_mmu_page
Message-ID: <YEuKx6ZveaT5RgAs@google.com>
References: <20210311231658.1243953-1-bgardon@google.com>
 <20210311231658.1243953-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311231658.1243953-2-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021, Ben Gardon wrote:
> The pt passed into handle_removed_tdp_mmu_page does not need RCU
> protection, as it is not at any risk of being freed by another thread at
> that point. However, the implicit cast from tdp_sptep_t to u64 * dropped
> the __rcu annotation without a proper rcu_derefrence. Fix this by
> passing the pt as a tdp_ptep_t and then rcu_dereferencing it in
> the function.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Reported-by: kernel test robot <lkp@xxxxxxxxx>

Should be <lkp@intel.com>.  Looks like you've been taking pointers from Paolo :-)

https://lkml.org/lkml/2019/6/17/1210

Other than that,

Reviewed-by: Sean Christopherson <seanjc@google.com>

> Signed-off-by: Ben Gardon <bgardon@google.com>
