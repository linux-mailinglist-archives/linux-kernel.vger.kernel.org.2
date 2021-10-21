Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64FD4360B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhJULuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhJULuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:50:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD921C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:47:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so580939wrc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yBNHXGhEhbZK9RhqGx3nsWnlm7UlQUKLFmDxMWFI5UY=;
        b=bl2uLbPQUpuHGv4zy6LiqDvLjNFQBkpIMepHiGg3sWKGkaWY8LQO9hvtLlZZnrzc3I
         VIRckpn3xAw1bexg1E/DB/5fe/eAEIjAlDFvXq6InHqWhhcWuEOR7NJXIcTamWT/Zj4C
         5hd6ATD2R1rkcjdmoCEqkWGGz1doci9FtZxdPWPtU1jg1/R3CFN3w9BrJ1jM5HT+ROeC
         F7tQ8VuGpgCBfQCOZlErx1GFMxiE7I4Rpe7FkOEwx9VXZr6OQeTjlPlEq4UeysT3GsEz
         9eze1geDEfXw4/FjpG92oZvFes01FTKH2tD+Bz1gxVbuqa2qBb1/CBbQfBkeoRg0WkFL
         Fe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yBNHXGhEhbZK9RhqGx3nsWnlm7UlQUKLFmDxMWFI5UY=;
        b=vtRUFLPfFEaoR1jkAUE8U1TlpXnCL1NY2eG0SVFlNup8nneXdU6I7J80uUpkAkPl3e
         gZVJAOJgxLVi2H3TpSr2S/xY4M18tgkTLAmuBFc0YYGwAHWdjmuZCSpmPRZYfSHRX0Br
         nMpgw3GX/8jB+jzDgGGQ7EmgEqmV9F4K+WtUtO8EEvp/DY4S6Oy0cvd8wyMjrm4xzA1i
         nKIbadl3hfblwRt9v9eIWJsUt+i4oHQSfTYe4Cz1F9o++biIh2VLSu0Fbz9ek8Vm9Alt
         DnyfALqkYzTFBQDW9EsW2J/T6Xykq11KlRPELH5di/fcs03sDZ+Of8wgI938h1oURoO/
         EPjw==
X-Gm-Message-State: AOAM530goi1c225lFHALQLXkzjOIccLIszrsLCHK1Is5+bEHR3/pXEha
        9qImfmzm2NkoK3afYlrk71WRSg==
X-Google-Smtp-Source: ABdhPJxx0R+vs47hNv6vdLE3QmnjXyaLLPKRDSZGc9IS45STqa4yVBgZtFkZS2v0DcZyNcYqTW41RA==
X-Received: by 2002:adf:d222:: with SMTP id k2mr6975449wrh.54.1634816874266;
        Thu, 21 Oct 2021 04:47:54 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id z1sm4579839wrt.94.2021.10.21.04.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:47:53 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:47:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mfd/regulator: dt-bindings: max77686: convert to
 dtschema
Message-ID: <YXFTaCETelkSOeu+@google.com>
References: <20211008123552.191384-1-krzysztof.kozlowski@canonical.com>
 <YXE65SBhGFHP54L6@google.com>
 <85c56cfb-64d9-a840-c2e4-eea47461188d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85c56cfb-64d9-a840-c2e4-eea47461188d@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021, Krzysztof Kozlowski wrote:

> On 21/10/2021 12:03, Lee Jones wrote:
> > On Fri, 08 Oct 2021, Krzysztof Kozlowski wrote:
> > 
> >> Hi,
> >>
> >> Convert Maxim MAX77686 bindings to dtschema.  The MFD patch (2/2)
> >> depends on regulator, so this should go via one tree, for example MFD or DT.
> >>
> >> Changes since v1:
> >> =================
> >> See individual patches.
> >>
> >> Clock bindings
> >> ==============
> >> Existing Documentation/devicetree/bindings/clock/maxim,max77686.txt are
> >> left untouched. The file is still used/referenced by other Maxim
> >> devices: MAX77620 and MAX77802.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >> Krzysztof Kozlowski (2):
> >>   regulator: dt-bindings: maxim,max77686: convert to dtschema
> >>   dt-bindings: mfd: maxim,max77686: convert to dtschema
> >>
> >>  .../devicetree/bindings/mfd/max77686.txt      |  26 ----
> >>  .../bindings/mfd/maxim,max77686.yaml          | 132 ++++++++++++++++++
> >>  .../bindings/regulator/max77686.txt           |  71 ----------
> >>  .../bindings/regulator/maxim,max77686.yaml    |  83 +++++++++++
> >>  MAINTAINERS                                   |   2 +-
> >>  5 files changed, 216 insertions(+), 98 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
> >>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
> >>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
> > 
> > Does this need a PR too?
> 
> No, I hope not. The regulator patch was acked by Mark and Rob, so you
> can freely take both of these. I am not aware of any conflicts or other
> dependencies.

Acks do sometimes need PRs to be reciprocated.  Just need to make sure.

Mark, do you need a PR if I take this in via MFD?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
