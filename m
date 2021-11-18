Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B698D45519E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhKRAXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241908AbhKRAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:23:15 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E2AC061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:20:16 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso7753556otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M0lPrjkFAQi9yAuD247gmWMnlc9AcuTM1Wt78OCqYfw=;
        b=j6BniyX3Oo96+gCG1T8XVO4vb+cRG3AV8WsZJxqRe5W8tos8y9Qa9koyvk8afWuCXP
         SmRa9h+yfg4wfHsq+EU8FijPpu10hNC9Mm+kAFbvVp3LQomouvlcZgQDGoshipzGjTrs
         Kf3WI0HnIBZ+3ElMUv5bL+E9oPt2rE177ZBIEcygqtwGOXIyP77geu+qLDLQtA59XrPo
         aMFK5nZn2SxxoHMzGVgsltFu61e1yleM00haBBCt9H50zc7fENt4TvyNvXFXX8/ggLgI
         XnIZ8KXi8wwa9P9Dts0xaymsM1McJJ3lJUfEMT7fU3HdKrQnt6nl3vlbSscMh+pIy0Il
         iTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0lPrjkFAQi9yAuD247gmWMnlc9AcuTM1Wt78OCqYfw=;
        b=5p7V7FHM/nTUfXq446RD/BVAWAW7oGBAHEtD236VHn73sxIDezWQZszOZX4tZE4AvC
         lNWQsev2yyloBIfnTSIRBp5dwdxzI6dh2yb1zHPHzzTl8oPFtwiZbJYGs1zsFfVkkllA
         K9vogSaT8GtsImFZGxJRbIfROzu+1gBm8GHcU7Kna4ab9w0eYoQ27dBJGDan75ixHLGF
         RK1dZcM3a4f8r27UCNth4JFrW+ObEKa6t/jDlm4033AIB2YRnBmqQwUbeImfZCKpyxbw
         tz5vpoL5Opqrep2UtEX4KIqIl7xSyxEnYAhHyNHN8CCqdddRYO+WqgtwBSNQ/dGM4PKo
         OdKw==
X-Gm-Message-State: AOAM533KBQvOsH16e7oAGtgVmAoPjKCQvLeuyXUzN51ejZPu65sJoVlm
        0Yrqrry3pl04V8KYu1HyICLgaQ==
X-Google-Smtp-Source: ABdhPJyGtuksU3qgXfZsVyj0QLwFX93L8GsiWUJDqLqj216Zn6Mt6Ymn+5ao5OPpfnt/2+JrpQNzpA==
X-Received: by 2002:a9d:60c:: with SMTP id 12mr16905133otn.94.1637194815279;
        Wed, 17 Nov 2021 16:20:15 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q10sm335476oiw.17.2021.11.17.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 16:20:14 -0800 (PST)
Date:   Wed, 17 Nov 2021 18:20:10 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] phy: qualcomm: usb-hsic: Fix the kernel-doc warn
Message-ID: <YZWcOrykR+1i+4rx@yoga>
References: <20211116103951.34482-1-vkoul@kernel.org>
 <20211116103951.34482-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116103951.34482-4-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16 Nov 04:39 CST 2021, Vinod Koul wrote:

> The comment is not kernel-doc one and starts with /**, so fix that.
> 
> drivers/phy/qualcomm/phy-qcom-usb-hsic.c:3: warning:
> This comment starts with '/**', but isn't a kernel-doc comment.
> Refer Documentation/doc-guide/kernel-doc.rst

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-usb-hsic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hsic.c b/drivers/phy/qualcomm/phy-qcom-usb-hsic.c
> index 04d18d52f700..716a77748ed8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-usb-hsic.c
> +++ b/drivers/phy/qualcomm/phy-qcom-usb-hsic.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2016 Linaro Ltd
>   */
>  #include <linux/module.h>
> -- 
> 2.31.1
> 
