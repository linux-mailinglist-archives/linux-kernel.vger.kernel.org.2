Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDDE34D789
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhC2Snj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhC2SnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:43:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287B6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:43:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f17so4830651plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LlNrP/9Ut5sXN3pkzKNi+WSrlgUBYs/IFekoNMyL2Jw=;
        b=T+DpvsxQed12BAoexlkki+09jZcOH2cjiPTOOafDyn6acCeGPxIcFenrtcJ3zGGa8+
         mSk7Iu22+Txx0wacKigEu3+FnKaFEgH82nuqdasm4GN0gQoF+hpT3m52TrAsh9p0Gnkv
         ME2leGRxC72wu2uxStmg0L9ey3ygUFNqHk0V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LlNrP/9Ut5sXN3pkzKNi+WSrlgUBYs/IFekoNMyL2Jw=;
        b=EEBdBRtUPGakjKFdlSRNgy+YIxYO7rE0G3w2bJZcKdAiV0ImR03a3sbw2Ww2K+zwBu
         qRWRNR2Mp8dA/e27LhMwx8aOTG8j/LjlOL7Y0YiT9783PHiX2a0OP/PvbWIU4xZC9jUT
         Qirr5cdeT2ahGPztuT3lKp2MhAaasRwCPITmeU5EhHcg8XUUMXw0qFP3UkqcD9NB8Iwm
         6/iB+zjM77CjtzYUS2weVfMw/75fRvsEOLdtyyEWvnrMyWJJ1nrtkbPl2cv4pyobymwI
         THzGJPxcoXuLZ2HvOT/Xj37U/GbYpqNQogVCxycrZefiZPDuvDKE9mGgGNe54MktMJlH
         DD8w==
X-Gm-Message-State: AOAM533ggg6Dz1DIsIAIcmLpG/QoFLm8xxO2AVtoB4+P5f9EKz9Msnnt
        /+eyKB9ASwMAbNsW1QLHTWcRAA==
X-Google-Smtp-Source: ABdhPJxToxGXO0GwIsEriJuM+yDUQVqjN+yq+LJpGrMhEoXh9Okut5BCawWoS9xITNbBK4nDieDGBg==
X-Received: by 2002:a17:90a:bd09:: with SMTP id y9mr458540pjr.179.1617043404655;
        Mon, 29 Mar 2021 11:43:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u9sm17260832pgc.59.2021.03.29.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:43:23 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:43:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] x86/entry: Enable random_kstack_offset support
Message-ID: <202103291141.EC2A77731@keescook>
References: <20210319212835.3928492-1-keescook@chromium.org>
 <20210319212835.3928492-5-keescook@chromium.org>
 <87h7kvcqen.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7kvcqen.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 04:18:56PM +0200, Thomas Gleixner wrote:
> On Fri, Mar 19 2021 at 14:28, Kees Cook wrote:
> > +
> > +	/*
> > +	 * x86_64 stack alignment means 3 bits are ignored, so keep
> > +	 * the top 5 bits. x86_32 needs only 2 bits of alignment, so
> > +	 * the top 6 bits will be used.
> > +	 */
> > +	choose_random_kstack_offset(rdtsc() & 0xFF);
> 
> Comment mumbles about 5/6 bits and the TSC value is masked with 0xFF and
> then the applied offset is itself limited with 0x3FF.
> 
> Too many moving parts for someone who does not have the details of all
> this memorized.

Each piece is intentional -- I will improve the comments to explain
each level of masking happening (implicit compiler stack alignment mask,
explicit per-arch mask, and the VLA upper-bound protection mask).

-- 
Kees Cook
