Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0FF305034
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhA0DvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390066AbhA0AOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:14:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F98C061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:13:56 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f63so17398pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eg1+IXQ+KG25hfpLfWECGEtHCa9ZmmkTs6X5ipIqXso=;
        b=A3+wyR7Tw2RVfQ5N8CwLN9nmb2NGSUCXSUCy16AfW2YHvHVpbMca9k7+Uqg6BydcUP
         CD8uyf6CKxoeIIpz9A3BcpPdPpJtVaosFsS7U0+SLb6+V9bH1jH/dBrH5Z0Ue41dGrUH
         5kY6RcLOjt0LlXl2Yew8J1x4Tf6aUy+yfb+yGSJ+yw7OX5K2e0UkIzcp1vPwQsOwjMYG
         qnzl4kORkTc51FIIR5EP0Pwz5it0Xgdi43WiS8Pc55RIw4FKim1ZMw8bl0bXbBmgf6b2
         f/6SSEpJZbpEIMcA2LA6EBijbjGtXSGZBdkq1fN6oZbmQdhpMgS3sgzBCbBFIH/x1Ke5
         G1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eg1+IXQ+KG25hfpLfWECGEtHCa9ZmmkTs6X5ipIqXso=;
        b=glYLFBWCoTtHoytusS74iMikd5m4eOQ0ruVyYEZKRrbhxgbH2QRhWz5w+5NLZ+Ms8X
         p1zXPsumqe6vm6TwhU6TH34zxwmaUJm5TlczUbDc/sNTj7Y5odndYt8c/nBT9gaupRR7
         2vGi/0vrCRAJ6CjUr51i5mS4tepaerMBBSN5hmjAvc+2a+SC6R4rkGhhuMkRS4z0Jp8X
         rPcJFI1XjcBxUg+FaV8afSB+y4bT4ywPiUfQMND18FxO9arCmeq9cFzjJHaMPsu2ZRM0
         mSA7mCLZqD4p9Lt7Rowg0VcLOYkhJX2GWgqCdYR7tn5v/eGdLhaousTK16CK8uFiSM4V
         6Y+A==
X-Gm-Message-State: AOAM533MGPFhFnYQkvQRIDd6QtV9hnk0cW0onBJdilUfDWkhMDBsLRQ9
        wwgjVdWPhGdyMQ85sWkmqniYgQ==
X-Google-Smtp-Source: ABdhPJwi/cjpRNck5xySzt/sdXxpPflSZCwPr7heWqTtNlCahUQS3RnLmA1I2IW5y20J/WIYUexGKg==
X-Received: by 2002:a62:1a50:0:b029:1c5:112a:f42f with SMTP id a77-20020a621a500000b02901c5112af42fmr4242651pfa.77.1611706435561;
        Tue, 26 Jan 2021 16:13:55 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id 21sm209985pfu.136.2021.01.26.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 16:13:54 -0800 (PST)
Date:   Tue, 26 Jan 2021 16:13:48 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, tony.luck@intel.com,
        wanpengli@tencent.com, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, peterz@infradead.org, joro@8bytes.org,
        x86@kernel.org, kyung.min.park@intel.com,
        linux-kernel@vger.kernel.org, krish.sadhukhan@oracle.com,
        hpa@zytor.com, mgross@linux.intel.com, vkuznets@redhat.com,
        kim.phillips@amd.com, wei.huang2@amd.com, jmattson@google.com
Subject: Re: [PATCH v3 2/2] KVM: SVM: Add support for Virtual SPEC_CTRL
Message-ID: <YBCwPHOXgVqnnMQ6@google.com>
References: <161073115461.13848.18035972823733547803.stgit@bmoger-ubuntu>
 <161073130040.13848.4508590528993822806.stgit@bmoger-ubuntu>
 <YAclaWCL20at/0n+@google.com>
 <c3a81da0-4b6a-1854-1b67-31df5fbf30f6@amd.com>
 <YAdvGkwtJf3CDxo6@google.com>
 <ae97b4c2-6f19-f539-a7ab-f91385449e8f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae97b4c2-6f19-f539-a7ab-f91385449e8f@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021, Babu Moger wrote:
> 
> On 1/19/21 5:45 PM, Sean Christopherson wrote:

> > Potentially harebrained alternative...
> > 
> > From an architectural SVM perspective, what are the rules for VMCB fields that
> > don't exist (on the current hardware)?  E.g. are they reserved MBZ?  If not,
> > does the SVM architecture guarantee that reserved fields will not be modified?
> > I couldn't (quickly) find anything in the APM that explicitly states what
> > happens with defined-but-not-existent fields.
> 
> I checked with our hardware design team about this. They dont want
> software to make any assumptions about these fields.

Drat, I should have begged for forgiveness instead of asking for permission :-D
