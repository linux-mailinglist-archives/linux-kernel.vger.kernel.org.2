Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C30368555
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbhDVQ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhDVQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:57:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A4C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:56:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q10so33247387pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UFzFQdhQTmHz4oQ6RfQH6JCaTrTMSe+EImX4uIUHN0E=;
        b=hfMHlb2tAGDCpRp6rUYXum4xsxawk5eNNnqK1TYeijET5DpgcH8OASPwJJs60T9Z5N
         U36ExbgMboXgJjUyEd3dq5YyXMtrcP5FYro0Jd21YD98kgg9rPymMQSxVcu8/63ijAvt
         SP0ZUUzhoZfY3IpcbkA5tYVLJYPpuMhErt9yH3L8gwWItgxbBjHfy/zaHXkAeSDm32XQ
         WQWg8L4IBpUZWqMYHi0pMkZR68EhaducU3c9g0bbnNr+y0RA3wDbsLil5NZq4yK0n1M5
         o0JyqOHTikRZPcbtwcJ5vwp4yuIsoOo3DkQTHq4OEKU6+8tevPJQmQxANyQ6cCDp+qfa
         Yhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UFzFQdhQTmHz4oQ6RfQH6JCaTrTMSe+EImX4uIUHN0E=;
        b=bfIDwRZ1Kuf99psXaJpIkysjzxovmnvV59l3Td3NqshCDw0yQ9Hc7oVWfjhhy2oQ/0
         a6KhqJykPobtuYU5lna4v042LF6u7e9ZwXE94BGztO4k7Iy/OlT28X88YnNh5Ag3oky0
         J0fSnC6FKU4fb69XwydGMCJhfp98jouiT29GYEexS03vlChg8tujaTnYjBQjTgESmGoL
         V0vG9m+kzUjqud+omz3IdRIc5lVAhBUi+HBg+KkBapzr1McNGaRoSu1Z45TxMcz6mrBZ
         toC3fzyYfQdQjH2HIxFM/fFmRFRDLpDSXXgerRqXbCeFfxJwkryZpMRM7I4Iwj0f2MZ2
         Trpg==
X-Gm-Message-State: AOAM533M3Bz8lEREM8Ii30S3Zeicx9D30trdPESGf0cClBFOMAdJbjDP
        0q5BdueAiN2eItCGkgbOIah2EA==
X-Google-Smtp-Source: ABdhPJzxbKxbKh/MjTGRzoDqVZhktXmS/i9dIyByKzAYVlIEO8VJzYPR/7OK8Sjx6LwUs25y/alAHQ==
X-Received: by 2002:aa7:8608:0:b029:258:838a:23bb with SMTP id p8-20020aa786080000b0290258838a23bbmr4107118pfn.37.1619110597162;
        Thu, 22 Apr 2021 09:56:37 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u25sm2543788pgk.34.2021.04.22.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:56:36 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:56:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 0/8] remoteproc: imx_rproc: support i.MX7ULP/8MN/8MP
Message-ID: <20210422165634.GD1256950@xps15>
References: <1618971622-30539-1-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618971622-30539-1-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:20:14AM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V5:
>  Add R-b tag
>  Move the change in detect mode of patch 5 to patch 7 Per Mathieu's
>  comments
> 
> V4:
>  Typo fix
>  patch 4: take state as a check condition
>  patch 5: move regmap lookup/attach to imx_rproc_detect_mode
>  patch 6: add imx_rproc_clk_enable for optional clk
>  patch 8: use switch/case in imx_rproc_detect_mode
> V3:
>  Add A-b tag for Patch 1/2
>  Fix the checkpatch warning for Patch 6,8
> 
> V2:
>  Patch 1/8, use fsl as vendor, typo fix
>  Because patchset [1] has v2 version, patch 5,6,7,8 are adapted that
>  change.
> 
> This patchset is to support i.MX7ULP/8MN/8MP, also includes a patch to
> parse fsl,auto-boot
> 

One of the request I had from the last revision was to explicitly list what
other patchset this work depends on and what branch it is based of, something I
can't find here.

As such I am dropping this set and won't look at another revision before May
22nd.

> Peng Fan (8):
>   dt-bindings: remoteproc: imx_rproc: add fsl,auto-boot property
>   dt-bindings: remoteproc: imx_rproc: add i.MX7ULP support
>   dt-bindings: remoteproc: imx_rproc: support i.MX8MN/P
>   remoteproc: imx_rproc: parse fsl,auto-boot
>   remoteproc: imx_rproc: initial support for mutilple start/stop method
>   remoteproc: imx_rproc: make clk optional
>   remoteproc: imx_rproc: support i.MX7ULP
>   remoteproc: imx_rproc: support i.MX8MN/P
> 
>  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  11 +-
>  drivers/remoteproc/imx_rproc.c                | 196 +++++++++++++++---
>  2 files changed, 173 insertions(+), 34 deletions(-)
> 
> -- 
> 2.30.0
> 
