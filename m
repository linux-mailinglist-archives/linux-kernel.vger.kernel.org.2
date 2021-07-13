Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B138F3C75F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhGMRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhGMRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:52:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6DC0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:49:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l11so12578860pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yXz5SZYhJFQ5rmn/Ssf8L6wKyoGLCudJATpd74s+yXw=;
        b=vaxecE7vRw5jdKsbzPNK05mEQM6dGDFHY2yAwByMcGJk26SebCFBHHn0n6t045+DAr
         Wyu3+0dxhwxmIFP0uz6GU0pQYsIqBPzQZdl3INEOiJzgPcGBr6ahX4U1tRoIvPyzSQJC
         JTJYv2okDk8zum3YZoFehv8A99oN7DxdvXQVyeyYNTMYANbuEyeVu6uc4Ya0iZXfd9Nz
         rLk4b0VytMFL+gXQhsW3pcQq4z6t+4rcEeVNMueBtkdKTAr5JRhNaBVMqlbIqlAHLf1e
         tnbZ8re8J3xqGzOQcl+yR07YFI3eBmmaHD95TE74zVBZLJexpKatIq6oeZj2IdT5b8ly
         HaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXz5SZYhJFQ5rmn/Ssf8L6wKyoGLCudJATpd74s+yXw=;
        b=e4jK8R5R4oHgbcBRDa4Tths5a14GQMx83xIAYZOlOyv0oBIHauIqQxj0VAnbgWdGTA
         IoBkJ7r7afrwk6wXymppdx/g15Mtg71/CeHr/+NNmoc1SrpqDiyAQcVC4RjgCgTkWNWg
         z9MD5ib8pKrSQmKz5je3bgCWe+g61bqlJT6vs7WpFtCaDd1m4XfwA08ZffzSqcbZ8lsg
         zkk1noI8Nt+2K5SxekxpORcNM0bySKIYNzdL+xjsAqdYk63UgrVsP17RLHcNMHAIk5O4
         viuiybDyJaGID+0EZl+w6XBpfZ4K0Pt2MoYz5L0N8Hz/RU7BUjEo80j+OT2W+EuYM0Es
         QbAw==
X-Gm-Message-State: AOAM532R1WtDIGG+/n/rozwfEOX7K82qqFBLXiHzGoQZYVeJXCpEf/FA
        p3qZeYrdlb+MhwMzQ+1NlWZ9cg==
X-Google-Smtp-Source: ABdhPJx9hpbMAIO9agDZpdwnBXUWw1cQ4vYR2gBkqCKocfq9tp7VqFM1UL0j3m8TwXv4upPS0Hz3Aw==
X-Received: by 2002:a17:90a:564a:: with SMTP id d10mr5456913pji.120.1626198561523;
        Tue, 13 Jul 2021 10:49:21 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d3sm16980036pjo.31.2021.07.13.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:49:21 -0700 (PDT)
Date:   Tue, 13 Jul 2021 17:49:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com
Subject: Re: [RFC PATCH v2 02/69] KVM: X86: move kvm_cpu_vmxon() from vmx.c
 to virtext.h
Message-ID: <YO3SHUzwCH+haEgZ@google.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <cb2256563ec5aacdb7ab6122343e86be9f1cbd60.1625186503.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2256563ec5aacdb7ab6122343e86be9f1cbd60.1625186503.git.isaku.yamahata@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> This is preparatory clean up for TDX support.
> Move out kvm_cpu_vmxon() from vmx.c to virtext.h with rename to
> vcpu_vmxon(). Which will be used outside of kvm.
> SEAMLDER to load TDX module which occurs at kernel early boot phase.
  ^^^^^^^^
  SEAMLDR?

This patch can't be reviewed without seeing the TDX-Module load/init code, and
that code has been moved to a different (not yet posted?) series.  E.g. at the
end of this series, KVM is still the only user.

> As bonus, this also increases the symetry with cpu_vmxoff().
                                    ^^^^^^^
                                    symmetry
