Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B744EB91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhKLQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhKLQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:50:32 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FDAC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:47:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y5so9000481pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3rAF7X0X6/EMnU6+94v5BwiYzou8rEtKzMTAU/xLi9M=;
        b=eXlnDGE/KrB7BNIkkxQcMGueDxOwOcODdNpPMAhlIoYidCad09yQWTLFj+yulxFpgn
         Px1Ujn85BI2lclSL8i0FC8I7GbPOmtr/MBaularsTk7F33Hocj1Q0ceXwc9rvIBUEEa+
         Kx5NokZ1rBZlN9S9Pc374yF/LbSvn/CGOYaga3kYnLa6zyT7q+SglORqFj+iHytg9ec3
         TV5LPzmnEW5R3oWq74NOJdvMK2bj4KQI6n8DT65uULDtHwsF/smPLdqBoTLjzrGcX555
         nT6xjDwur2o/5ORYrhYk2otO9QPB+h+YUH63HYa2Nib8DjZ6J2hLVgLhWYXhRQ6htTjp
         TXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3rAF7X0X6/EMnU6+94v5BwiYzou8rEtKzMTAU/xLi9M=;
        b=GUqgcFlQ4y7iS4woA84AwS9o71/jKDsu6tsCWvzqXilQxEB7f7TCkyMrxnBJkVGCIw
         a9ilCQiU7z+YZqHl7DqvH4daRe45YRZIjex14j1l8oyRHM7BirHtk2BadSO0X0+pLOxD
         UcWDebrO1nwPV7yUPZ2Y1O+nl6Mn/ihtEnWO4Dha/9ByOYRfwa7lbTxoCv6l9PaQy//N
         MMOs1RO50OovDabocv3CjDoXGmOcYL/gND7sWGV3Jh9pwjXr5prOja2IA1bFWKvnjVkj
         92KkVa6SvdzTQBrLaVXt9yOjug7wdf8c+qSQai0O4QUClAjdFTPqqYcfZOVDSKO+AeGm
         PsCg==
X-Gm-Message-State: AOAM533cLnuy/u1dACAonoyX/OtVJd1UFKnuS/LT17DDmLataxN+0bQ8
        jnEB7GJZCH4K69P/hi2EOMaiaQ==
X-Google-Smtp-Source: ABdhPJzgx1IAK301rj4zJBjuC3cCz0eNcw07dPNbYus/Wab1XodRTQxrfTPOuQTF41bh8C3kETNwkg==
X-Received: by 2002:a05:6a00:130c:b0:4a2:6c4c:55d0 with SMTP id j12-20020a056a00130c00b004a26c4c55d0mr6706623pfu.5.1636735661245;
        Fri, 12 Nov 2021 08:47:41 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i13sm5081490pgr.22.2021.11.12.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:47:40 -0800 (PST)
Date:   Fri, 12 Nov 2021 16:47:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@intel.com, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH 01/11] KVM: x86: Introduce vm_type to differentiate
 normal VMs from confidential VMs
Message-ID: <YY6aqVkHNEfEp990@google.com>
References: <20211112153733.2767561-1-xiaoyao.li@intel.com>
 <20211112153733.2767561-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112153733.2767561-2-xiaoyao.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021, Xiaoyao Li wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Unlike normal VMs, confidential VMs (Intel TDX and AMD SEV-ES) don't
> allow some operations (e.g., memory read/write, register state acces, etc).
> 
> Introduce vm_type to track the type of the VM. Further, different policy
> can be made based on vm_type.
> 
> Define KVM_X86_NORMAL_VM for normal VM as default and define
> KVM_X86_TDX_VM for Intel TDX VM.

I still don't like the "normal" terminology, I would much prefer we use "auto"
or "default".

https://lkml.kernel.org/r/YQsjQ5aJokV1HZ8N@google.com
