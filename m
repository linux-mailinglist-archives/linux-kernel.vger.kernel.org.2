Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A551539B9C8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFDNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFDNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:25:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3CC061761
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 06:23:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so1338751wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+sT4YYKrQb2O5xI5wztXIAWtyacTFced2VFE4TLIp60=;
        b=ySiUwhYzsJGSzp36XB999q1MbEQ96sQpPPHULrfsaUm/LbNGHvntoy9xwDR6LnPxFI
         aaQlYLo5tfvAVdcsrADn6mrXtmvuH1RhsIXzPpuVQ81Y34PPKUUMjxj491nxsKp/pcy8
         NrdQ6Syy/jwbcbdTdrCoZFjqcj61qpvaKhtZFcOd9wi2sOL+LpwY+SoXdtHyRliKS44L
         RjqSzzMX2GPQsCTYaH1uxRBoEDqGbHUXXwHtHcYyrEcCdA+oykyyoGlhXr5lyk2A2Hvj
         MrW+27uUG7L6hy2QSqWEG7VTQqSUi61G9XuX7+Dbr1sw5YISsiT7dD7FWd0pe/T9dEqw
         7y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+sT4YYKrQb2O5xI5wztXIAWtyacTFced2VFE4TLIp60=;
        b=qTWc0WY5UT9CydKYRjn6s80z5AKxyhfTLNV0OFttHa9l6FKob5eyaVl6+G7qXXdrDE
         nCm5irWNIc9islBnTp8TO/5NrwSoNmWuy+xNNmn3DqbtmwU/X1hD3Zgjmo5rInUQJsbY
         VONhFRK+xAlzu8Yp63fkBDHtS7l8AyJQf1dG56eraToLoVrpDKYw3mzqosM863RUWUnZ
         fstCQg2mTfxTp71qeQKKpu1xET4f5TMdx3Oz+uvzJ6c3BLhJAxnaZqiFh1tGPSXSzk2A
         Hsmsa21KjYOr1lOCF1zfGebaR3hv3unPamPCqdnbDDHX5r2o2mAJCoSHivsh847iwqee
         o3lQ==
X-Gm-Message-State: AOAM531ld1g3u01uBmuOgJLE95NP7laBb9DD9vKEiuOi/n/z2a7I7m8+
        F/nFs+Oa2WXU1sXiK6OSyv3nYBQfHfRVWA==
X-Google-Smtp-Source: ABdhPJyIXvaJGxAIuz9G9hqzr6MEeZebOlfx+GRaCsLAzvjVFcJ2FSSUkUHrMgXxV8y2OfWOc6gC0w==
X-Received: by 2002:a1c:2805:: with SMTP id o5mr3625525wmo.103.1622813018831;
        Fri, 04 Jun 2021 06:23:38 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm5752457wmq.1.2021.06.04.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:23:38 -0700 (PDT)
Date:   Fri, 4 Jun 2021 14:23:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wendell Lin <wendell.lin@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ARM/Mediatek SoC support <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH 1/1] clk: Export clk_register_composite
Message-ID: <20210604132335.GK2435141@dell>
References: <1595493126-21611-1-git-send-email-wendell.lin@mediatek.com>
 <1597052186.27843.1.camel@mtkswgap22>
 <CAF2Aj3hZB08d8x6XOqsP4m5fv76fWH48U95j8ugLt-YWFJ-kkA@mail.gmail.com>
 <162276982204.1835121.10976600065855289763@swboyd.mtv.corp.google.com>
 <20210604082427.GE2435141@dell>
 <20210604082524.GF2435141@dell>
 <1622802121.26830.22.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1622802121.26830.22.camel@mtkswgap22>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021, Wendell Lin wrote:

> On Fri, 2021-06-04 at 09:25 +0100, Lee Jones wrote:
> > On Fri, 04 Jun 2021, Lee Jones wrote:
> > 
> > > On Thu, 03 Jun 2021, Stephen Boyd wrote:
> > > 
> > > > Quoting Lee Jones (2021-05-20 09:07:42)
> > > > > On Mon, 10 Aug 2020 at 10:36, Wendell Lin <wendell.lin@mediatek.com> wrote:
> > > > > 
> > > > >     Hi Matthias and all,
> > > > > 
> > > > >     Gentle ping on this patch.
> > > > > 
> > > > > 
> > > > > What about a not-so-gentle ping on this patch?  Grrrr... :)
> > > > > 
> > > > > FYI, this is still required by more than one source.
> > > > > 
> > > > > Please help get this out of all of the vendor trees please.
> > > > > 
> > > > 
> > > > Is there an in-kernel user?
> > > 
> > > How can there be?  It's not exported yet. :)
> > > 
> > > However there shouldn't be any barriers for vendors represented in
> > > Mainline to build their drivers as modules if they so wish.  If/when
> > > they do, this will need to be exported.
> > 
> > Wendell Lin, is this what you wish to do with the in-kernel MediaTek
> > driver?
> > 
> This is because Mediatek clock driver would be built as kernel module,
> so clk_register_composite() used should be exported, then we could use
> it. 
> 
> Please refer:
> [PATCH 2/2] clk: mediatek: Add EXPORT_SYMBOL for kernel module support 
> https://lkml.org/lkml/2020/7/1/124
> +EXPORT_SYMBOL(mtk_clk_register_composites);
> 
> clk_register_composite() is used by Mediatek clk kernel module.
> From export symbol: mtk_clk_register_composites. 

Perfect.  Thanks for the clarification.

Anything else you need from us Stephen?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
