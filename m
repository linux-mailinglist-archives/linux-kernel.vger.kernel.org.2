Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7F341E07A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352966AbhI3SCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352957AbhI3SCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:02:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D58C06176D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:00:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id me3-20020a17090b17c300b0019f44d2e401so3322017pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GvInsCJfgVIdu+bTl+EZcCSDBMnOYdIPFiEnPSEGWq8=;
        b=C+AhbK8OmIghCqB38Es9+sqV5ZiplbGylDANFPGzeGsstzb+vKsJgLrMKcqsXrj+Ls
         E51vKRIr5y+WbmZvxZVTas6LticTYRZPHvE3mTOcmA5do+nsSSV1iTn7ls4F2BlhqLym
         CVjOo2cReN5XP3kuUARBo3Iiap96FHW4NnrJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GvInsCJfgVIdu+bTl+EZcCSDBMnOYdIPFiEnPSEGWq8=;
        b=KcxpydLLBSUXHei9IAQiQIdbAibNXCo4IeG0gL/KOjCG3aDJb9n2sri0Lcv9jSwHmI
         E0s344ZA6uf27LNZCsyez2XBUvLSe4HUjFUKfmes66D8h02CP8nKoox0ctMpSsGUaCN9
         zwXxi1dwP46HpQnwRYnMsM13o+U4UtU65UirBrlQLVAy5FTrteybBwNZ43GvG3tPCs/8
         EzTNG8ch9a5LTUv95nCDvG0onXOP14VKG7hU60+ZkD7H2kZS6EXUzMzT4zegBeQeSctU
         cC+gMNoRTBDMp8OTi3fIlWMpjdZAdhkyn6xV28LLFrqGgTePSBI6YU4laddAhi0/kD6D
         iKXg==
X-Gm-Message-State: AOAM5313NR9y4ECjM93OrC3BMEiR0qarW5nulbUBLC3lHDOt9T6wK58P
        NpQu3igkKoxumSNwfOQzXqlUUA==
X-Google-Smtp-Source: ABdhPJw1x/cuO9mw2pkpxFtvuHlojDjhxrcg02FFcSXPI1A/yf4JspLL4WFzVx/lrn2zgGEudX2AQw==
X-Received: by 2002:a17:902:6ac7:b0:13e:1fec:2bbc with SMTP id i7-20020a1709026ac700b0013e1fec2bbcmr5413917plt.82.1633024851430;
        Thu, 30 Sep 2021 11:00:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k9sm3628222pfi.86.2021.09.30.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:00:50 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:00:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: stm32-mdma: Use struct_size() helper in
 devm_kzalloc()
Message-ID: <202109301100.2BB00DE96A@keescook>
References: <20210929222922.GA357509@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929222922.GA357509@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 05:29:22PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worse scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
