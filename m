Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647ED3FE378
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbhIAT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhIAT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:58:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A3C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 12:57:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so531031pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tMTG80t3wz+BbsYt7/vMbgUKt2cALKcGrfxmvyDVycI=;
        b=GDxzDHx6y4t2OpIpS+RJgk1VtJMeiB8knpDgvYQPSsFfHb9myS2i8Y8zKivTuXuXjD
         80WQ7dy0hlk1NsTkOvIPxXdqWLOvHI003J78+jnvMmt2AHjFlmWer9qGm5PPsff+b2qd
         aOvfuEe5agrtLAxrPIEsh+gBgAiw95ASoDg+uPHtcGd0X5xUl+uFpwYV5yGFPfy3nYSe
         X7GTPNiKRIHN5GQzk78FQkxMTyXT4uS5O8MwskFj3Q3faG/t/NUqScAQalxcqTeIbxdC
         r6CJv4p/DQwb/7mJW/KCjNyL/lqHQmBPjT5leuOBgEo6MdmgGRm0IRJ3pJtpXO6I5Yni
         WUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMTG80t3wz+BbsYt7/vMbgUKt2cALKcGrfxmvyDVycI=;
        b=S65gT+Q0KCYt4QHCtBcBBYEJ136IBUrzs+o7FDOzIii5C1vfI9LLiGqhgkMvnRxA8+
         bcQkmO9bYie/LtVIPY1yWsBLN8RvsTBmdaYu0d7Vr7ghm0NmZb8XyoJYQQgGo5BRwgUS
         BP71JClpBpelQKj9TaMJEOLW7yQWKdE6L/xFIWunS4B3UXUSNu8AzDE3fLlVxRKbQS4y
         zwd6oTsLJ4mjdZ8Gc4cXJrhWlw0m9fF4k53z8i3RWfSn9U8YQKyVkrtSJrjzZ3LuEY5a
         +XYwQeaxCtMMOlT9f02R0tkLPYKE+f4VaJaHkCUG3j5K8oBZgEBOF/z7CEclQNQWafa+
         id2Q==
X-Gm-Message-State: AOAM533pVrrYNSu9iO/I6baYcQyc6iw7CvB/ovZB49EH/01/sPq510u8
        aOZpKQ49//5vxx8FXZH84W+xYA==
X-Google-Smtp-Source: ABdhPJyjE7jv9C7nQQ332L+GGCxxc0l51kKj4TvBYL6j4Mk0NOTmNP6mrLfjZrAOXlarJRfAETU5Gg==
X-Received: by 2002:a17:90b:88e:: with SMTP id bj14mr1067223pjb.115.1630526249849;
        Wed, 01 Sep 2021 12:57:29 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z7sm306742pjr.42.2021.09.01.12.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 12:57:29 -0700 (PDT)
Date:   Wed, 1 Sep 2021 19:57:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jia He <justin.he@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Remove unused field mmio_cached in struct
 kvm_mmu_page
Message-ID: <YS/bJbzgG+pasIxu@google.com>
References: <20210830145336.27183-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830145336.27183-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021, Jia He wrote:
> After reverting and restoring the fast tlb invalidation patch series,
> the mmio_cached is not removed. Hence a unused field is left in
> kvm_mmu_page.
> 
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Jia He <justin.he@arm.com>

Reviewed-by: Sean Christopherson <seanjc@google.com> 

There's also additional cleanup we can do to take advantage of the free byte.
I'll include this patch in a follow-up mini-series to hopefully make life a bit
easier for Paolo.

Thanks!
