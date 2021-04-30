Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F0370295
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhD3VEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhD3VEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:04:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD890C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:03:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso18922pjn.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYfhsVJIyHJfS92pymwuH2XCIrd8pkRgZFdMBWUMzjs=;
        b=CTGiVfAZql7ogeFpgVT5I6iO3DOYf718hkwhUCTndgZkwI00AwILDq/CSb5IXE1VP+
         LfC0zb3JkHDU81OaKo0SuBEhlIozJOEQCFMch707O7XHZS1ataVNbGrpcJviC94IMTCB
         EpdyyBda6DRPdJJctv28zZAT0N9dA6qmd6LAl8s9aGtByd/pVE0eIdSTlLNAIY0+9DkW
         WukFYiBAbwrCJea6oXceR9UpybkNt6Ol7VOJahZUkedh9nYXoAK34xQzlz5AxGqQSjPI
         HH/3lAp2t4cy0rJpMutaJjjwubghS36yi3bUCZsqUVXi/lCTluY4eM6xDctOBQ/2zJ9w
         rBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYfhsVJIyHJfS92pymwuH2XCIrd8pkRgZFdMBWUMzjs=;
        b=CfVVBumGOnWjhh4NwNhDVcDyeGbipo0zIOxZxO7x+ShPVAbb2KXt+/3yOMoA7mfgjy
         lV/EcuK+Aib3bU5u3egBQkKJd52l0Q1iwfrYtk8klXF6OVjQYSSo4zYs0GkySXZDoUNS
         jCgWST2Eob1tSwMCctgCSGtn9JOUq3Z4mxA9pDuS4AjURDyPpzXhAJn/YcI9vhsJul4i
         b2wanKM7mRWvt9IYgE+YRG7EE7BlshfZkCUZxVQBLl00dQmD5mWGKiGylSpfcmv6TdNe
         jui6L/f9chGXobhfAtYvNn3tTxPg+pEhkWECAbAFPrXbzrlvQD5Zi5rHPjA5ZJOD7JBN
         1FJw==
X-Gm-Message-State: AOAM531/10qGKDX2N6OxebCj8qFP7lFOx5mYL0kzaoScwqBWn3DciyEN
        GIek+jou0eFlbNJeIFBMCPeaEVD3P+OTD5cI6ph3GQ==
X-Google-Smtp-Source: ABdhPJxob4CPW2ByXEvh0nM9H7a5caKPyjraP2cVOrDHqIvbLsoVZ5aqhnbvo+VxJKNIZIUceLqRdyJsnYI1jQisAVI=
X-Received: by 2002:a17:902:f203:b029:ee:af8f:8e4b with SMTP id
 m3-20020a170902f203b02900eeaf8f8e4bmr979769plc.23.1619816603963; Fri, 30 Apr
 2021 14:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210430131733.192414-1-rsaripal@amd.com> <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com> <YIxhCSt6t5U/Eldb@zn.tnic>
In-Reply-To: <YIxhCSt6t5U/Eldb@zn.tnic>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Fri, 30 Apr 2021 14:03:07 -0700
Message-ID: <CAAeT=FxqM5P+6U8vBywuvnaJ0s4sWdRHK2fvn4b1zf5mMLKReg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Then, it would be a problem if its guests want to use PSFD looking at
> > x86_virt_spec_ctrl().
>
> Well, will they want to do that? If so, why? Use case?
>
> We decided to do this lite version to give people the opportunity to
> evaluate whether there's a need to make full-blown mitigation-like,
> per-thread thing like the rest of the mitigations in bugs.c or leave it
> to be a chicken-bit thing.
>
> So do you have any particular use case in mind or are you simply poking
> holes in this?

I didn't mean per-thread thing but per-VM and I understand
the per-thread thing was dropped.
But, doesn't the current plan include even the per-VM control ?

Since the comments below from Ramakrishna (yesterday) mentioned
KVM/virtualization support, I assumed that there would be
per-VM control even in the current plan.
--------------------------------------------------------------
But I did test with KVM (with my patch that is not here) and I do not see
issues (meaning user space guest in QEMU is seeing PSF CPUID guest capability)
--------------------------------------------------------------
Yes this feature is needed for KVM/virtualization support.
--------------------------------------------------------------

Could you please clarify ?

Thanks,
Reiji
