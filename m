Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3910429F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhJLIQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhJLIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:16:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B32DC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:14:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t2so64272600wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IlFsz1aPNhFHCtd5uM11smI1zJs2IUYy1FrQb3N1O24=;
        b=iiC7I1lBqyCgLWkN9DTbFfd5ULPoFeXn4vFIy2Q7oaGfE5dZ30rRTyrpF0Hik2PWYn
         5GWWG0ZZILpRxLBxhPHduMeJ02AAqiORauDCNbBN/B2drY3DY/spEqbp0DBOYoWC2XPd
         f602aKbkUCddQ8LxqdfQbXwSyZJiGSJfn53R3e88EGiRWW3IRRd6UQ9S9bAtXUbfomIO
         0wiep9R8/36xVkjxtK0co9tjO55H3Q9xztufLJSgti9IFvNLOJVIXV+8a5XLLjirN7ed
         5UIimlweMCgkFAaHf5lyDGZu5yeIiBMD0dbMfv/m1JvifH64R0gg20VwcmAQjzAnwDBp
         YsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IlFsz1aPNhFHCtd5uM11smI1zJs2IUYy1FrQb3N1O24=;
        b=4mgpHtc7ONrGZgKXitbFNHPM2YxDY2pII/62A6s6vfuqa/Dxr+acShyNw37dMFclii
         fwSywfEie6aw9J7YqTjLdpChTG9whBK6QrYR6bDsxrzQE0Rj5misg0JPSXzxrJbYMhEf
         41pfsfzoTJc1ogTOz9UF901d6vj7d/XiY1Ir70wHmBOX0ZYW5F7iahk9qaj7Dd1TpHyJ
         PXolvEY0gJQLEzm9yS2jKXB1Fci0SGYm7BL++kIxzu6xi5nVPI9ver+XPUaGRvvpLRKY
         HJWzrQzv/6T5AXAk1+Pq7EIIVU9te8GSw8PEwF2WQcZGu/z7Eo9Ysb706TIh/adfSESP
         L2hw==
X-Gm-Message-State: AOAM530osu6Tm/6zIkFWhr0U9cwksr+StLFRE1yiOIN2dQdHDoUCCYYo
        TDHIVib7VxcxyrHgtsAByuw9UA==
X-Google-Smtp-Source: ABdhPJztpqCZWXa1dPpkEFh4twW2SCqLnRyzS5PquHtUfcUrJfPL6qNY1rZIvFhPX2NxaGQkv43a6Q==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr9304746wrw.86.1634026450644;
        Tue, 12 Oct 2021 01:14:10 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id z2sm8906237wrh.44.2021.10.12.01.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 01:14:10 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:14:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YWVD0RXHVLxuXEIN@google.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com>
 <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021, Rob Herring wrote:

> On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 23 Sep 2021, Chunyan Zhang wrote:
> >
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > Add bindings for Unisoc system global register which provide register map
> > > for clocks.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> > >  1 file changed, 68 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> >
> > Unapplied v3 and applied this (v4) instead, thanks.
> 
> What about the clock binding this depends on:
> 
> Unknown file referenced: [Errno 2] No such file or directory:
> '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> xargs: dt-doc-validate: exited with status 255; aborting
> make[1]: *** Deleting file
> 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> Unknown file referenced: [Errno 2] No such file or directory:
> '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> make[1]: *** [scripts/Makefile.lib:385:
> Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
> Error 255
> 
> 
> Once again, all the components of MFD bindings need to be applied together.

I can't apply what is not sent to me.

This patch came in on its own.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
