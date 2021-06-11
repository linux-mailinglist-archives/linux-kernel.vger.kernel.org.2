Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3702C3A49A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFKTxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhFKTxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:53:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F28EC0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:51:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 11so3343692plk.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KNnmLVhW7Z1eL7dw7enmn8fL0DRewbys9VcQYNN94sw=;
        b=PXJN45iO63AhJtr+07L3oKwMOh7AoNpPIYu+O9WNx7LLtJvZ+Oec+wQGhNFMQRsYCa
         udlh78px7qmNGpVeq7VkKSbOGH1tbqO5E2K1hQv9qXdtYBJ/UN8sCS6dQs5UfRt11pH5
         ghAUFBM1m143/yrBdAxknmXJZy8b7PlhUQK7Z7LQqZvT67HjAhQdJhiE4vQt6O97XskB
         h+H4M7u7P1VEQAJfx8wW9RzxZKP92EaF0g3OGEilZFOZirBszAXdLMlnkOhUhUVmZVRq
         w+g2fPVKxlZZTkA4dkwHzGZnubLk9RkI6ZnoZgDc4ijDmY7q8jbSR93c1+w439etKJUD
         q9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KNnmLVhW7Z1eL7dw7enmn8fL0DRewbys9VcQYNN94sw=;
        b=sXo0+1g+GTGzK6G6jOhrmh8fVAVKHmYU3qcXnigSzks9FJe01sFmGekDdBEuUjpqFf
         5ADKzEzPAyBXwmi7rOasnO0l6h5JYtUjZLBCz5reb/TxoXliCigrNrXwhuJCfxkgPPls
         PqKzxrSWJ2q4BSzRCeEUBPVUwWA8pYg7U47MsghTP9U48khbqJC3quSSefQSfCPrltu0
         S43YwkzUBd1H9fXCkXpa7mPe8hk4+pw+KTduDZqDY9CgsbRnd11nBeCedSVzchPwqJtc
         6vGeGOWdnElEDn1aQEr98Bcv9Q0UP2yA0g7Wfc3TzQbJ8I9Zr6n6lCgq08kISWWos9rU
         68Uw==
X-Gm-Message-State: AOAM533AIe+5sIvQ1YkjFz5l8tfVJHaoY+w1UWRPzuJJ6lnQZeTv2oGG
        c0ERRn3AWcnmlQPaLkUjwir7Qw==
X-Google-Smtp-Source: ABdhPJxOwJGLQJdwVp9Vddr3Kc2Bbcwu0hUwM6B5+1idM8n7fog0q3E5z/G1ULw/JMXbRqhuyY3LAA==
X-Received: by 2002:a17:902:748c:b029:119:653b:a837 with SMTP id h12-20020a170902748cb0290119653ba837mr459711pll.68.1623441070787;
        Fri, 11 Jun 2021 12:51:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f18sm2402766pfk.27.2021.06.11.12.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:51:10 -0700 (PDT)
Date:   Fri, 11 Jun 2021 19:51:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Calculate and check "full" mmu_role for
 nested MMU
Message-ID: <YMO+qj36W2isnlxC@google.com>
References: <20210610220026.1364486-1-seanjc@google.com>
 <87bl8cye1k.fsf@vitty.brq.redhat.com>
 <YMNxkRq5IIv+RWLN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMNxkRq5IIv+RWLN@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021, Sean Christopherson wrote:
> On Fri, Jun 11, 2021, Vitaly Kuznetsov wrote:
> > What I don't quite like (besides the fact that this 'nested_mmu' exists
> > but I don't see an elegant way to get rid of it) is the fact that we now
> > have the same logic to compute 'level' both in
> > kvm_calc_nested_mmu_role() and init_kvm_nested_mmu(). We could've
> > avoided that by re-aranging code in init_kvm_nested_mmu() I
> > guess. Something like (untested):
> 
> Yep, cleaning all that up is on my todo list, but there are some hurdles to
> clear first.
> 
> My thought is to either (a) initialize the context from the role, or (b) drop the
> duplicate context information altogether.  For (a), the NX bit is calculated
> incorrectly in the role stuff, e.g. if paging is disabled then NX is effectively 0,
> and I need that fix for the vCPU RESET/INIT series.  It's benign for the role,
> but not for the context.  And (b) will require auditing for all flavors of MMUs;
> I wouldn't be the least bit surprised to discover there's a corner case (or just
> a regular case) that I'm overlooking.

Ugh, nested NPT is completely fubar.  Except for the "core" mode, all of the role
and context calculations are done using L2 state instead of L1 host state.  The
APM explicitly states that CR0.WP is ignored, and SMEP/SMAP are implicitly ignored
by virtue of the NPT walks always being tagged "user", but KVM botches the NX
behavior and would mess up LA57 if it were supported.

I sort out the mess, though I'm not sure how it will interact with the reset series...
