Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2A63C780F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhGMUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhGMUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:38:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B78CC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:35:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a2so22599828pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4AmDsVu8C7+Vh6wJ1AauG4/nfKkfZ5m7flJ2GCQMZco=;
        b=m4SkF/hHghflqZHT/pRmE7NtDOkCNpy81YEGC+IhdJ9Rx/cT5SfAMC+awFq8gOpt+G
         He2FY2JqztL6dPS/SSKMRSG6Pkoq+FdWwHxeu4MxlWtQIhL1cJBJKizSHtoUD4vDVc1Q
         fOuewObDck+6tEHIlLdSY26T5LsaKnOyKWsXmcGvCvPqyNutDZ1e9o/HPyXyk/fhl0sv
         NF/8vSbdZ8dQfE2sLZ3/+h81AAURRf8XVw9jUmvJcWgbGvg7m6+i3eeZhu7uV4teXL3Q
         McOh6gH9ZbnYIEYukWKXo/ZqAS5I/mxxmV1+h7l2Jug4EfE/9GuyiJWJFJpDXe7VyXDs
         NArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4AmDsVu8C7+Vh6wJ1AauG4/nfKkfZ5m7flJ2GCQMZco=;
        b=CZ84qIQaAjwUWg2WeOXpabSPG5LSngvpdKGVHXcq89Yiw4D8fqLK+OyWeJBdWmarJY
         Xelc+G+6KkK/X8Wosd9gsOic/bHE1RT7bxmxaJtCs4oe3O/0o69drly5vj7MTWWU91JH
         y10Auqf4E6mkb4C2a2ljZP/2n3SIfXXg9FilFGShBdqZF22j0ks9+B6LZVS8dqK/qd97
         XQPzKfNfRfIoqOT68OpEzju/qRUVESWa4FdpglFn+Pju5nPP7SyPFGsB/GOIHiQW9qSu
         psxGjdn3kHg0QVwPGWoM4iQEf5P3K38Q4Tg8bhRWDTC058PeQVKJWoApCznhR3p/hMK+
         ydIg==
X-Gm-Message-State: AOAM533C/Z03EovZuq+Wh9C5KRuznphAHtBsUgEEFC7qof0O9197ivJS
        0yN+DI2ZNf2tVSyE2S+GP3RMPg==
X-Google-Smtp-Source: ABdhPJw36stDiatSrqUOjKH3K6JCfVV0uAc6YTTPBKatF5UY65R9llh4XPwfgwF0WIVEsNp7ktdhlg==
X-Received: by 2002:a63:4242:: with SMTP id p63mr5881087pga.185.1626208515649;
        Tue, 13 Jul 2021 13:35:15 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 11sm49387pfl.41.2021.07.13.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 13:35:15 -0700 (PDT)
Date:   Tue, 13 Jul 2021 20:35:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC PATCH v2 21/69] KVM: Add max_vcpus field in common 'struct
 kvm'
Message-ID: <YO34/91O242b8YS7@google.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <bf7685a4665a4f70259b0cd5f7d11a162753278c.1625186503.git.isaku.yamahata@intel.com>
 <b6323953-1766-ff6a-2b3c-428606144e5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6323953-1766-ff6a-2b3c-428606144e5f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021, Paolo Bonzini wrote:
> Please replace "Add" with "Move" and add a couple lines to the commit
> message.

  Move arm's per-VM max_vcpus field into the generic "struct kvm", and use
  it to check vcpus_created in the generic code instead of checking only
  the hardcoded absolute KVM-wide max.  x86 TDX guests will reuse the
  generic check verbatim, as the max number of vCPUs for a TDX guest is
  user defined at VM creation and immutable thereafter.
