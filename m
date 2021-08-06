Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3600A3E31E1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243836AbhHFWp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbhHFWp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:45:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE4EC061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 15:45:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so21607059pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UzCR/9NC0Lqzg67J83YfWAxveUHo8UKLJmwFA7rLd58=;
        b=oD/emD+F53dzP56D+8dYdvZ5uG1tnPr5myJfEYcyYnhVMc1Eox2QjcElVBvFpgj51U
         qdBpvCjQjZxrQ0dGr1HBqkLtsLyy6IZUzKxviFQC46LpibxPRTMNEHNF/lbk/jLtqHnL
         lpa2Rz7Y/WxqvDcSMCCKabu8iTe1K9bij3tvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UzCR/9NC0Lqzg67J83YfWAxveUHo8UKLJmwFA7rLd58=;
        b=LPjPqkKc6N37boCY3AO13O6etDNEHE7gcbyEvirbmjMvV4ALofS5tl6RttHS5HNTw4
         S34yCgfdQjlWNv9h8UqMRtRHzsI3FbKoLEssCl0EU8Ppp38wvRf3N01tN3TI/Ywc8T5h
         lcTy1LwuYgWMcUBizy0UcHP+Zt5B56Amt0V7XxAk6Ipg3MIxmcIb9tci5kjAzMFYwb6H
         bp17+1XzZBYx2dr+hjWKyfT8/YqhNE9PwjNvd6QxY/mWVLvXVDI6Y0gwMnLaXjL6gXx8
         Leh/cpnu0jVzFC5S1em6TneQJoIsCL1NEuuDiCrtsI4WdzBZOtIrbwmUz3dFddIU7eRh
         CkuA==
X-Gm-Message-State: AOAM532JIW+0wxI/bS53M3368IXaiWfc5DYxjkb0CzHzXdQGYJbDTxC2
        Xs1SEpv3VfDAlsRfIEFscOHhzw==
X-Google-Smtp-Source: ABdhPJwcFp9hsz479TQPygcQjTQtKpERR7hjQYzDhnV/zuqFEc0XAweADxVvB1a9P7bEzEvcPMNeig==
X-Received: by 2002:a17:902:c20c:b029:12c:afb8:fad2 with SMTP id 12-20020a170902c20cb029012cafb8fad2mr10533211pll.19.1628289938652;
        Fri, 06 Aug 2021 15:45:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15sm10169135pjt.3.2021.08.06.15.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:45:38 -0700 (PDT)
Date:   Fri, 6 Aug 2021 15:45:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: Avoid field-overflowing memcpy()
Message-ID: <202108061541.976BE67@keescook>
References: <20210806215003.2874554-1-keescook@chromium.org>
 <920853c06192a4f5cadf59c90b1510411b197a5e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920853c06192a4f5cadf59c90b1510411b197a5e.camel@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 03:17:56PM -0700, Saeed Mahameed wrote:
> On Fri, 2021-08-06 at 14:50 -0700, Kees Cook wrote:
> > [...]
> > So, split the memcpy() so the compiler can reason about the buffer
> > sizes.
> > 
> > "pahole" shows no size nor member offset changes to struct > > mlx5e_tx_wqe
> > nor struct mlx5e_umr_wqe. "objdump -d" shows no meaningful object
> > code changes (i.e. only source line number induced differences and
> > optimizations).
> 
> spiting the memcpy doesn't induce any performance degradation ? extra
> instruction to copy the 1st 2 bytes ? 

Not meaningfully, but strictly speaking, yes, it's a different series of
instructions.

> [...]
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> 
> why only here ? mlx5 has at least 3 other places where we use this
> unbound memcpy .. 

Can you point them out? I've been fixing only the ones I've been able to
find through instrumentation (generally speaking, those with fixed
sizes).

-- 
Kees Cook
