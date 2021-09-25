Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285AA41834C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 17:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbhIYPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbhIYPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 11:41:39 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBEBC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 08:40:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n18so12946866pgm.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0gLSxoWjIglR0vF9p3Om4tGlkObXsXDpYB02Tj9xZpQ=;
        b=kRCpRy/nggUySF4t6vaq30xpKW6nK7qstPC+hNVaRQEr8dWypivH5djyomP60zKZJ9
         Iaf04yF5JKMMmbY8WW7UNaddL0Kt5YY8LMuOFSx8mCpIbCuamyc7YSlHT4UtruJ0DP2P
         QMDxpbEZHqpQ3nJacQ/dL3CM8IuoyEjA1fdy+YZR6rk6Jx88fXvlCi6dyf/1QVMSUaJk
         1TyN7d4Sy1ITlvmj71DhDOuYo52UGEmH35VsZMZsehhCwEMfkhLLxODOXJ+TE0Ia26tG
         cTFI9cHT9o2vkbeeOkrnEn41+9kVZABFS+aVX2rirIT59JB140cKJwBua6/qOQJ721FL
         qTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0gLSxoWjIglR0vF9p3Om4tGlkObXsXDpYB02Tj9xZpQ=;
        b=S3+76aOnq5UheCkfprLA2IIFwvsFktkiY+X/uRkYcDsbjqSHEHXz8leUEnL1o+4nkQ
         CUKup+k48Mqi1QhvldTUmgKJfCT2CayIIGWyMGnfDGhnZYY7ZLeRL0raRaWzcYvdDuHL
         2+wtUR8ZpU9+mScgy0ewZbHB0Z2AvAnd3jn1x2m/Omdn9oRjHLHH+ImxyLN5cP9CXeGp
         8MRZUZz4s7OmfJpnYoqZruAJV8x6Mb/gtEBQ1/npKkNTg6d/9FN3tRBn80G2HE6HdabU
         3lJ73uB9LZWBMrKGFCD/UnmXhR7RffQxm0lyd5WfJ2TyGJF4FBKWKj7Y1F30IEu5UThj
         cxNw==
X-Gm-Message-State: AOAM533sdWQ033EayprspkJq3iTuuX9WMV6SwuRdQGzoz1RHh0eBd96R
        BHZLIOWaIgBA+vEiTFu/ag==
X-Google-Smtp-Source: ABdhPJzC/48g6rDBLAHRPqT6AxXL/xThXY8UV7zkaSTxbdLcEKF7PXUJCKBPZ4hn8SvbsK14bOi+iw==
X-Received: by 2002:a65:434c:: with SMTP id k12mr8622911pgq.17.1632584404071;
        Sat, 25 Sep 2021 08:40:04 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m1sm10633861pfc.183.2021.09.25.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 08:40:03 -0700 (PDT)
Date:   Sat, 25 Sep 2021 23:39:55 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/5] arm64/entry-common: push the judgement of nmi ahead
Message-ID: <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
 <20210924175306.GB42068@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924175306.GB42068@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:53:06PM +0100, Mark Rutland wrote:
> On Fri, Sep 24, 2021 at 09:28:33PM +0800, Pingfan Liu wrote:
> > In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
> > irq, which makes the condition !interrupts_enabled(regs) fail to detect
> > the NMI. This will cause a mistaken account for irq.
> 
Sorry about the confusing word "account", it should be "lockdep/rcu/.."

> Can you please explain this in more detail? It's not clear which
> specific case you mean when you say "NMI interrupts an irq", as that
> could mean a number of distinct scenarios.
> 
> AFAICT, if we're in an IRQ handler (with NMIs unmasked), and an NMI
> causes a new exception we'll do the right thing. So either I'm missing a
> subtlety or you're describing a different scenario..
> 
> Note that the entry code is only trying to distinguish between:
> 
> a) This exception is *definitely* an NMI (because regular interrupts
>    were masked).
> 
> b) This exception is *either* and IRQ or an NMI (and this *cannot* be
>    distinguished until we acknowledge the interrupt), so we treat it as
>    an IRQ for now.
> 
b) is the aim.

At the entry, enter_el1_irq_or_nmi() -> enter_from_kernel_mode()->rcu_irq_enter()/rcu_irq_enter_check_tick() etc.
While at irqchip level, gic_handle_irq()->gic_handle_nmi()->nmi_enter(),
which does not call rcu_irq_enter_check_tick(). So it is not proper to
"treat it as an IRQ for now"

> ... and we leave it to the irqchip to handle the gory details. We only

The detail should hide in irqchip to decide if an exception is either
NMI or IRQ. But could irqchip export the interface to entry? (This patch
export two: handle_arch_nmi() and interrupt_is_nmi() ).

Thanks,

	Pingfan
