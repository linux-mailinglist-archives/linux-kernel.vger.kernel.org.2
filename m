Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D883442BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:51:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14ACC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 03:48:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s13so25423305wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tjHxLBOlGFUwoythfcIXHJVOGhDQe/iG25qk3veKCD4=;
        b=EEc+JD0XsC3VGqaE5qXWCYRjO0yRs45+ECxfmZj30mu7VgkRVswKwYTRXJ/xEiy9Gh
         IAvAA3t6agxJVcyExDLUKJkCJ1AJqYBdyfJTHPCVSEEAvcJNLDofKOqfAC1vVfsBR9+L
         Nb9aIH/CGiNYjw9Ocjm5wWev+T2MR9H3dPwUBi94TMeoQgliZhZBmLmEZtJY/rnmgW4C
         /IL/nE8bOImJIQ5lToAcCPMNiwNRqfs9/WJZpwwqTQ4HRLPZyLV45dLwJICz7+tSEPyU
         Oa1tpjG+fA6Vl0JK61sCyL8qYoqT3r9vmz9ivGUI1J3tQ4WeOrAVapyMr0x2drczjr83
         ZgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tjHxLBOlGFUwoythfcIXHJVOGhDQe/iG25qk3veKCD4=;
        b=ktjfWIFd/9hM6dbLxpzOfRSroQsJy9PsA8tRG69j+N6KKq00RSOh8qf4J3/Bu4h9GG
         26867Vt2ycz1REAwjQ1smmySHotlboAnhM0eOk5Peu3tOniSVZRZz6Sd3ADGnoM0O3oY
         kDo/1BgWp6mXfhxN2WjOvPPLrkTQTXtCrsbsHvFvem3OxDKe+ncUFDdX8+2wc097NCqH
         03mxUEXlFwlATrqWh/9NoQTjDRaNHxMlm3Gc9PTf1XJiiOJVuSGtEw6QrsM2uf15Dmn8
         WBrOinqlw5aAxoH2l7cae6z/vcN3msmzMvv+DdEH+8EMA3tCRc52nvLEs68PyFlkhWFX
         2saw==
X-Gm-Message-State: AOAM5339fKYGkvYXgzBtLHeXZtY95fBpNsms/7zXwrgpbdrqQBLWMLGg
        ZjVKmoJiP0djA5slOrnHrsQoyA==
X-Google-Smtp-Source: ABdhPJwtEHbUMbCeAtw4rOoML0SGRNYL06mu4CwNHUGVkq5Lh6683+bJXm65Bxh2NAa0r1vRiPW9oQ==
X-Received: by 2002:adf:f708:: with SMTP id r8mr39888329wrp.198.1635850130255;
        Tue, 02 Nov 2021 03:48:50 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id f81sm2289827wmf.22.2021.11.02.03.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 03:48:49 -0700 (PDT)
Date:   Tue, 2 Nov 2021 10:48:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        marcel.ziswiler@toradex.com,
        Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: stmpe: Support disabling sub-functions
Message-ID: <YYEXj3bzOB4g1x9N@google.com>
References: <20211027082155.206449-1-francesco.dolcini@toradex.com>
 <20211101094844.GA4549@francesco-nb.int.toradex.com>
 <YX/Z47ztw8d4uMuQ@google.com>
 <20211102082147.GA5168@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102082147.GA5168@francesco-nb.int.toradex.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Francesco Dolcini wrote:

> On Mon, Nov 01, 2021 at 12:13:23PM +0000, Lee Jones wrote:
> > On Mon, 01 Nov 2021, Francesco Dolcini wrote:
> > > Hello Lee,
> > > any chance you could take this one line patch for this merge window?
> > 
> > For a patch sent 0.5 weeks before the merge-window?  Nope. :)
> 
> Hello Lee,
> no problem, I thought it was that trivial to not create any worries.
> I'll resend it in a while unless you take it before.

I like *all* patches to have a soak in -next.

You don't need to resend it.  I'll apply it in due course.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
