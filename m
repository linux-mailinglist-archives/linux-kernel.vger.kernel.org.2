Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED11E33DB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbhCPRze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbhCPRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:55:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B54C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:55:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a13so2214930pln.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SXXfUbxitLxem4y5IOmlGNcXjSvMqPDKJf33Q5FpRTM=;
        b=WKpOqCF2yNa6NbXAk4agTwGEwEFghqxwPSDrHSduOe7200kg90HR301qhsVIL4nG5j
         Q1smXNi9Mrp30eaInSJYZBVYsBvKiKQRDvWi/i6cDWyScxsO+MiXkFDFP0ry9N4s4BbG
         o2TPjVS2zkSOujnaHEV8H1hCj8qI7Wg9GPEgH+tPbaOx33d+eTGEOT7eYwf34xrSnURM
         LjY85t36WyaTAyCPrPOegGaUlTcpzA50K+y04TTbp9kcHvQ5v0w7+loSfEQGSHVCIO/W
         2eCQ19e2xqhYCpfsh6asfu4Hu+rG/cypocGOEx+rf15jHeeuZEjLQz0K3cglGyn3jSTL
         1DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SXXfUbxitLxem4y5IOmlGNcXjSvMqPDKJf33Q5FpRTM=;
        b=VHBlLLgQcHtOXbqHVD5YRhzI6EgxOdRzni6sz7aINNC+bXTdWNd+yVeRZJ0JMNu772
         +FE7NdtWhUUZr81PivkRoimIXMcC32RrHZllo1JIPtx589SJiNiYExLHnlql1+l04UYh
         Yp1I1V3CYa+NAs0zryaSOZys69iNMhVuQnyHV4o5FSE4V7Ec5GKdDu0VfNkCYif4LI1p
         WvrFDXTOsZTuFy7n2KPcLjzYqRiJfwkPek2wQArOcQTsCoaXEg+VkvUI4MjmNy1/VTWp
         PesyP4Ok7rKOSlMRSYqX2puJ6C+Lb2vSAk1Szuo1eW80ZNCuWHnFaOmX1BQg6gm0fydX
         Bp4A==
X-Gm-Message-State: AOAM5302pQXKc5lk79seYI1uVrJzNOGSIWOuexpA9yuAyDYegbTaNf5l
        JkImeJkvTt/ExctHz/ROc5Mf0w==
X-Google-Smtp-Source: ABdhPJz8/SDeSpcGidRjCZbld8vpoMWRnFLtdVkni4anFrrGeMm2W+Kiyse612dNA+S0YGp1yo8nxQ==
X-Received: by 2002:a17:90a:b007:: with SMTP id x7mr231047pjq.27.1615917303570;
        Tue, 16 Mar 2021 10:55:03 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
        by smtp.gmail.com with ESMTPSA id v1sm97126pjt.1.2021.03.16.10.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:55:02 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:54:56 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/4] KVM: x86/mmu: Fix RCU usage when atomically
 zapping SPTEs
Message-ID: <YFDw8CL1kvVbE90Z@google.com>
References: <20210315233803.2706477-1-bgardon@google.com>
 <20210315233803.2706477-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315233803.2706477-3-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021, Ben Gardon wrote:
> Fix a missing rcu_dereference in tdp_mmu_zap_spte_atomic.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
