Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436D936CE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbhD0V71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbhD0V7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:59:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CDEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:58:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 20so27704638pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GM2oAi1eIassl2KE9QEB2DIOW4+0ysif8RFRhM2xzYI=;
        b=WG/aZBu2xYsBYP0PTRaptVMtN/fcTuR7BD/9Op2YIBWgCClIBBhHij0fZI/Cb8p2M8
         B/vSq/QWoue5+UrK/zKcotuDhJqw/g203QjwVTfNJtgi0pJ5HOGjzAXGmcHdKkMa2iS0
         olq9RVpkYDR51A55tjTQXTaOEauSqSiZZJ5LeyZsc9xcOCqryq9ZBHtv9CUhApCy2Op5
         sZyhYk4anVC5X0xu5CE43QB6ZHtNJlQHV9bHIDEC7dK463503lZQkHfBt+XQHTCG1vpa
         /cUlv2iwHrTYDCXXfDtiqbZERz5udd9/Q8UumEhpHcThFv38Z4f3b4aog5RC98KCnLjU
         3qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GM2oAi1eIassl2KE9QEB2DIOW4+0ysif8RFRhM2xzYI=;
        b=i+RQ8vpPkpoamxdxmMk4OxRVOQzEFtcI1Cbad0XxtwTWFLRQ1AeY0X1VjbNUUljUzs
         V/aw5nSg9NCCVsJlMQ+MVHSvN6rBo3KwjVd+KessKzd1a7PVAMGw2/+g1RO3KPpc2N/z
         Q/C90VvmsD4ovoLqU/1DhzlwNGDZhpMM5HnW/lBxpnoc1sSsD6TRSSaY1gJiZXWveKJL
         iQiEsnd30jnGdKbeRxayKyDqkLLzdGG/KCW00kh+xKXmR2x/danuC5B6bmMHUNCQQest
         w88f8kbwzLM+6CH3UvobuDy4x6+ayafyv2GJKbRjbH+OqeyDXZvdyjfV2Pb2hwuQAYA9
         TmOw==
X-Gm-Message-State: AOAM532jIVucJFVkPszOt1M2n2pGuqXsoL3rAzS2cnQft4ZFmT4d/+dR
        sq1Quly7U32O6qYm134FFp9TVQ==
X-Google-Smtp-Source: ABdhPJwoNIoYndE80IPG3x6wK5IIiV+e7UukRLYi6vTtjvv6ZEjgO5qlKYaLKDVs8gBqYQDd2r5/vQ==
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr388997pjb.201.1619560710674;
        Tue, 27 Apr 2021 14:58:30 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 14sm2682634pfv.33.2021.04.27.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 14:58:30 -0700 (PDT)
Date:   Tue, 27 Apr 2021 21:58:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Reiji Watanabe <reijiw@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: x86: Tie Intel and AMD behavior for
 MSR_TSC_AUX to guest CPU model
Message-ID: <YIiJAjZQevp+DT9h@google.com>
References: <20210423223404.3860547-1-seanjc@google.com>
 <20210423223404.3860547-4-seanjc@google.com>
 <CAAeT=FxhkRhwysd4mQa=iqEaje7R5nHew8ougtoyDEhL2sYxGA@mail.gmail.com>
 <YIcWvcneHWA9OPxv@google.com>
 <CAAeT=FzVDFVCjYAZyc+QXwtLeOW5UR6AsYZwNT6kFbOwnn=xFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeT=FzVDFVCjYAZyc+QXwtLeOW5UR6AsYZwNT6kFbOwnn=xFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021, Reiji Watanabe wrote:
 
> > There is also a kernel bug lurking; vgetcpu_cpu_init() doesn't check
> > X86_FEATURE_RDPID and will fail to initialize MSR_TSC_AUX if RDPID is supported
> > but RDTSCP is not, and __getcpu() uses RDPID.  I'll verify that's broken and
> > send a patch for that one too.
> 
> I don't find vgetcpu_cpu_init() or __getcpu() in
> https://github.com/torvalds/linux.
> I would assume you meant setup_getcpu() and vdso_read_cpunode() instead (?).

Ya, I was looking at an old kernel when I typed that up.  Bug is still there
though :-)
