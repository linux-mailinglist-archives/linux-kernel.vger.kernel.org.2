Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A26434F87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhJTQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:01:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:58:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso11347345wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=H+gRH76GjJMcJJIvfbmq+wi06oWXJKKHW0RhCwTVPXc=;
        b=acn3qGxC3Mo9OmYRVDxgMTw+Z+TBUD6x84AEdFNyPqLztx7gioUami8NTv0w9xjMFR
         tJd/v+bQWD1p4VfsOkRrUcNgiFoCADs7snjxYBJo1h+w2mx6CS4R3eAJfFQaqzH23Vfu
         HkUbNlCeAXFz4ISUkwMgkKzSgVJML3zY98LC7dd5sRg57p3w6kfYZb4J/QFrH4j6zqE5
         XnVfCHI96R9CnA6EoxonGNuls2LZz0k6ZCKYZL85rt4XzkPKlMZ29ErC8Lc2ZmJG3vPT
         WVsj58bFXRjxv2hNAX+i0DCL0713wr2R1IimFullnDf56M7szIdwtQTSEFevZsseLLv0
         f1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H+gRH76GjJMcJJIvfbmq+wi06oWXJKKHW0RhCwTVPXc=;
        b=iACTJmZeFq+2dWYjoP9XdE9NHXXdyIXXtgbYKA7Pd0E0S71SGBDkXfyN1Mx1pu3D52
         oRTUr1slDwzJ/odOF6dvjzEv5p2+CQepSMuUscrbeF+WvyONtECgV0Wf4SPLTQz2EOO1
         AbJ8949r/g2t7972KtKcsP5Bvy44B9l6jFGVSp6ID29XLC48j6vfjbivkm885o12xUi3
         W1YfyaBx+4vvFyQnqrcQOlBZhN/VAaeOb2K8wwOG/xiEWrM99saM78QMibIXJYEeWdvg
         QgA+IdjUrgm4gaCv2GGPh9+iW7mCRHdpD+cn34GhyYOqyOqyuen5sfRz5uOTT61ZItuA
         0iFQ==
X-Gm-Message-State: AOAM5313MEZOOF9AAmb9cUfBG1tIhGi1r4U8gh/9eG8NN/2PMED/wMpN
        1nyPGuuK6UP9lhVlOxI2bYk7nIKRbIfvAw==
X-Google-Smtp-Source: ABdhPJzu2kHxVdJL7wFokGtw+2Z4vFuRFipGsrFdgD1Ln0YPGyMZzRUU/Iy9xzrkN+HPUmSA6Nnt/g==
X-Received: by 2002:adf:de0e:: with SMTP id b14mr15713wrm.271.1634745538412;
        Wed, 20 Oct 2021 08:58:58 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id l2sm6038888wmi.1.2021.10.20.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 08:58:57 -0700 (PDT)
Date:   Wed, 20 Oct 2021 16:58:56 +0100
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
Message-ID: <YXA8wBzhB/Dauu7v@google.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com>
 <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <CAL_JsqLUkxKOMSWLzTK14h3EyBCsO2dfq3=MxOSvv1ZK0_H=ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLUkxKOMSWLzTK14h3EyBCsO2dfq3=MxOSvv1ZK0_H=ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021, Rob Herring wrote:

> On Mon, Oct 11, 2021 at 9:11 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Thu, 23 Sep 2021, Chunyan Zhang wrote:
> > >
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > Add bindings for Unisoc system global register which provide register map
> > > > for clocks.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> > > >  1 file changed, 68 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> > >
> > > Unapplied v3 and applied this (v4) instead, thanks.
> >
> > What about the clock binding this depends on:
> >
> > Unknown file referenced: [Errno 2] No such file or directory:
> > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > xargs: dt-doc-validate: exited with status 255; aborting
> > make[1]: *** Deleting file
> > 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> > Unknown file referenced: [Errno 2] No such file or directory:
> > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > make[1]: *** [scripts/Makefile.lib:385:
> > Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
> > Error 255
> >
> >
> > Once again, all the components of MFD bindings need to be applied together.
> 
> It seems that Stephen still has comments and there's a new check that
> causes the clock schema to fail, so this should be dropped or
> reverted.

Dropped.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
