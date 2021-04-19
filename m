Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916DB363C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhDSHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhDSHYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:24:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:24:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so7812711wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5/I7OjlPA23XMnl0fWhyfFcD+/MgnUHTP9oGcEYHgNI=;
        b=C3nDX1FO4/ry5WxQSYLVZoj6oePzIMjyWfTPtvVUYfPHryP+JrdktRBEhPb68Syvr8
         5TD3RfFRflAXjwqMdQ4dix0mGoTxYjoGIB5l/k24emlcBbT8o64h1rSXeJsOIBkLt/Wk
         pNs7GPV6sNRAmCoVMDmrfPfpN7NHar74zQQ/pkwllUy1LA0mmE8eG+9RRsAA7YvZTsJF
         sBQcBFj0HZq5YM53mt79eb4TT0SYn24ruOlJJrg+pv9b9/NpZYT7v0diNuRwRDJ4jq3R
         8diFjwmSXL0/jrefm52TyE99agVDX0IVlLC2UXYfw8EBZnXQw7RDUoEsLDAaUZRffitr
         vX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5/I7OjlPA23XMnl0fWhyfFcD+/MgnUHTP9oGcEYHgNI=;
        b=F0uYz2cotABtWe7zOsx60m4lgex05e03fyVJi651qKe04NPgWOogQ1JhxFK/N9mw8o
         h/YtEUKbuuOcHN5lSzEEadft2kRC2vc7tdWGrrPNeMPDTSuE5yrfXEh3oDFuGRnifftJ
         4pRZVBQUYXnQQ/J+HlBGq/dlclmfZu/++bWvX7QwMI5PUqVeUmyv/nTa8w4svKynHqMV
         v9cx5hhN9MGKroH990/A8qXKl62yM09kbz3R891ZSHK3aiMPQ0yBYTU9h/+EOW9F0XHo
         hgNK5rZJ1SFHMYTCKF6McEw3df4Gj6vCQAtAP6bd6bVhGpeq0Y4P/g4cychvhkmaFVzk
         Qzdg==
X-Gm-Message-State: AOAM533W4xIOfr91lrFaF/KdKf+3s7YDkwPp9Zolkfg3TxyZYEXKqu4Y
        wFdXboBLVx9+e4GmTcdef6cVXQ==
X-Google-Smtp-Source: ABdhPJye4l/i7HK7FwHbnHzpTfHSCGPiuZeatN7ljMUy6e9Tge+FyCdpTNGKhcRomYfbQP9fYFSkkQ==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr20836963wmd.49.1618817046058;
        Mon, 19 Apr 2021 00:24:06 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id b16sm19428764wmb.39.2021.04.19.00.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:24:05 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:24:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
Message-ID: <20210419072403.GC4869@dell>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
 <20210419072229.GA4869@dell>
 <20210419072317.GB4869@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210419072317.GB4869@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021, Lee Jones wrote:

> On Mon, 19 Apr 2021, Lee Jones wrote:
> 
> > On Mon, 19 Apr 2021, ChiYuan Huang wrote:
> > 
> > > Hi, Linux mfd reviewers:
> > >    It's been three weeks not to get any response from you.
> > > Is there something wrong about this mfd patch?
> > > If yes, please feel free to let me know.
> > 
> > Couple of things:
> > 
> > First, if you think a patch had fallen through the gaps, which does
> > happen sometimes, it is generally considered acceptable to submit a
> > [RESEND] ~2 weeks after the initial submission.  FYI: This was such a
> > patch.  It was not on, or had fallen off of my radar for some reason.
> > 
> > Secondly, we are really late in the release cycle.  -rc8 has just been
> > released.  Quite a few maintainers slow down at ~-rc6.  Particularly
> > for new drivers.
> > 
> > No need to resubmit this driver this time.  It is now on my to-review
> > list and I will tend to it shortly.
> > 
> > Thanks for your patience.
> 
> Also you are missing a DT review on patch 4.

... looks like you forgot to Cc them!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
