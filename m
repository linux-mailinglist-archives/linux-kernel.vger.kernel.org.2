Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F15410903
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 03:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhISBF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 21:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbhISBFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 21:05:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D91C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 18:03:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso12664265pji.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 18:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nUbK1w3vfeG6r13aeQ85yxlK74aSmPTui84TnSezG5Y=;
        b=Slih2eOmcDjK/WcrC4+JD/Jw674JZQHnrtA2F9fmWTGvdeLYwKnk4oPIZR0+o+d5nt
         4OmqXoJqwY7Crf+2I9vFkPJvmfRWCAngkbHVHDU1kbNFcUXEbpuZTEH1eVNO3SPwHhUx
         OMaahnax/xb52yRnpq77dOX46zrd+aBa/9NHt5zNKjb8i7JfQ/6/QGsv+OMjsFGsBP6q
         52VsfwlYxjk2mKMvmIUZzMfgxf8LU/9EVEblOg/bsulE/Wd+EfCsP9scRa0uwzjolCHe
         PMdYneK8JTqVWAe+9Q415dx39SFFt43D1JzxqwbbzbQW3gREccnT/kVWphEOt2wv3hA5
         +kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nUbK1w3vfeG6r13aeQ85yxlK74aSmPTui84TnSezG5Y=;
        b=FPb8wp3a/MSTP1ECALF/p4NO7o+xzqbTW6/GdjVj148tMCELIKzlRkCePRLQdG2Axz
         1lrIuBIdjXKxVUcd8Et62clH7fzxOFsaYeyl968lHOzsUackNG2XICR0c1XZSJQpka8H
         iuT0uvViiDd3LceVIsmwSkrvT6UohLX80bnKdgoaSBi/gmd/+7yzRe2DvoaYkT3gcgfK
         /T8QhzQ6kK96JYGyXUTZpjo49GMcTHLRe3jmGQp1Zxcgxh81QHcd9AFjL9sWPfV0hOSV
         HG80aZgjgBHapuB5zBn4hPI/UxebWFW3aqnz7yvgGkZB3n2GvZaYvXcT67j6wOuASE+o
         RgTw==
X-Gm-Message-State: AOAM5319ceLKQctLv3cTWgFIVlp9AXnQOB0tZPaEz0AApfoqPOB1TwXQ
        9MsRXaM6NQwhvBpehL4G8YstcQ==
X-Google-Smtp-Source: ABdhPJw+uTDB4aYYZa2fyNkYfVPMVVX/PoU6vtmrY+uxUVK9g+ce6TI5f7MpOppcvEkYJch9vHBnOg==
X-Received: by 2002:a17:902:e88d:b0:13b:67d5:2c34 with SMTP id w13-20020a170902e88d00b0013b67d52c34mr16360436plg.66.1632013438658;
        Sat, 18 Sep 2021 18:03:58 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id a10sm1451409pgd.91.2021.09.18.18.03.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Sep 2021 18:03:58 -0700 (PDT)
Date:   Sun, 19 Sep 2021 09:03:51 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add QCM2290 Global Clock Controller driver
Message-ID: <20210919010351.GA9901@dragon>
References: <20210917031638.27679-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917031638.27679-1-shawn.guo@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:16:36AM +0800, Shawn Guo wrote:
> The series adds QCM2290 Global Clock Controller driver support.
> 
> Changes for v2:
> - Drop unused gcc_parent_map and gcc_parents to avoid clang
>   unused-const-variable warnings.

Hi Stephen,

Please disregard this version.  I will post v3 to include GDSCs.

Shawn

> 
> Shawn Guo (2):
>   dt-bindings: clk: qcom: Add QCM2290 Global Clock Controller bindings
>   clk: qcom: Add Global Clock Controller driver for QCM2290
> 
>  .../bindings/clock/qcom,gcc-qcm2290.yaml      |   72 +
>  drivers/clk/qcom/Kconfig                      |    7 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/gcc-qcm2290.c                | 2965 +++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-qcm2290.h  |  178 +
>  5 files changed, 3223 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml
>  create mode 100644 drivers/clk/qcom/gcc-qcm2290.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qcm2290.h
> 
> -- 
> 2.17.1
> 
