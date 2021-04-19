Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBD0363C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhDSHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhDSHXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:23:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECEFC061760
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:23:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so32834031wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MwIN+TU+KqrTV8oEDf/hF37W/wlPfyPFBOGXtanMm7A=;
        b=mvKP3FYTQyjhiyXdbsSScTdmxz1JdALtfbp3+iAG13OF6eHuyLflOnEhKZqi7NefnI
         Ka/vu+MRQlQLQ1Wf8/dEGDJ25gGU2a9Ch58/yIKB1ny09smf3tC56NSGVJxWDjaddEs4
         Jtv6Lca8f3LeUYHLqp0B13sEJD2noyBhtVawAlQZHkk0XqI2Y3I6InNVrmlEQL9Jvt0h
         UiPhiEP4s2/GdqC8vmMETym4jlcdSAg2pfw+C/ijAxND3z+bkfIJsA4Y6/MYL8RuniMj
         cCEfJuyRjbQ8oJdvPaiAlSczpYRofo47AY6e21JwaRmJnDLkoT2ICuJLVknjcDEf5JyW
         s4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MwIN+TU+KqrTV8oEDf/hF37W/wlPfyPFBOGXtanMm7A=;
        b=ZWYF0bRTcTpjyq1/OnhY0YssHmeMP5Ig5VFSZMS1GrNOHvucrpGPIG3wMDyGRUe4np
         yiA9Y2DVEViMQsAVQ23LJqWk4yqXFFnF01e4CAN8ZcEpDBwv/RpSsE4vYuAymYXWtfPQ
         qivIbKB2jVhip8CYwNLYtEufsUAtWxnuT5920S9uIy+yHfnkbNsWt4h7m9xJJyh60guc
         +IWLK/nVWgJFGHKcy/I97HfLPkU7hVXmwHlQgaWUGq0Y+8aLdBgT74MCoa5363qb6yRu
         clltDexmcqxi10eLKzUqYWjI29Lkvzc4BYE8rouasNqVxCzJG03/fmeMJbjGmSlk4W8R
         v1FA==
X-Gm-Message-State: AOAM533HXTqHudDIvbTpDzEv8jKwKWGvvulzD53AAqOqBwtdlQz/66yE
        A3ff7uawIGf1uxfziCEZL3gIZQ==
X-Google-Smtp-Source: ABdhPJxU4UayMloZjPVsgjxamNBwWhUQHvtZnZx6PsAQFTcukFY8alah33zSIRsDldU+wQ0gpgaz6A==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr12686252wrg.274.1618816999770;
        Mon, 19 Apr 2021 00:23:19 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a22sm20364077wrc.59.2021.04.19.00.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:23:19 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:23:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
Message-ID: <20210419072317.GB4869@dell>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
 <20210419072229.GA4869@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210419072229.GA4869@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021, Lee Jones wrote:

> On Mon, 19 Apr 2021, ChiYuan Huang wrote:
> 
> > Hi, Linux mfd reviewers:
> >    It's been three weeks not to get any response from you.
> > Is there something wrong about this mfd patch?
> > If yes, please feel free to let me know.
> 
> Couple of things:
> 
> First, if you think a patch had fallen through the gaps, which does
> happen sometimes, it is generally considered acceptable to submit a
> [RESEND] ~2 weeks after the initial submission.  FYI: This was such a
> patch.  It was not on, or had fallen off of my radar for some reason.
> 
> Secondly, we are really late in the release cycle.  -rc8 has just been
> released.  Quite a few maintainers slow down at ~-rc6.  Particularly
> for new drivers.
> 
> No need to resubmit this driver this time.  It is now on my to-review
> list and I will tend to it shortly.
> 
> Thanks for your patience.

Also you are missing a DT review on patch 4.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
