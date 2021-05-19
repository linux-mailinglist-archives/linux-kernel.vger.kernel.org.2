Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4305C3895E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhESS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:56:45 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38870 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhESS4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:56:44 -0400
Received: by mail-oi1-f177.google.com with SMTP id z3so14056753oib.5;
        Wed, 19 May 2021 11:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DfJwaFSSdfu0thZ2Cn3t+uJakI2Lyxq/EcGAu8YcPsg=;
        b=N+A6iotzQOXhkkQBZbcO7vaDP2ul8oqS98ncUWmazgL4aiAqqDTECd43FS9NeWip7s
         ek9WD7e4pKznwFhaj53js5xssXs+zhvOJQMqkKo+iR+AZ9yBDcKk+0DnstOWgxx2OQ3T
         K7HiRAQm6oIEoHWOjBex6PQ77yjZEH5rNYDmrkoWxAq1mJS0rlAWKNf+y5l2WNKaBe+W
         bcm3wFpYMJBTuVymT17uqObEJ6Q7ISTSwP1sPXF0eJmb76AWCL/YSYTlF8k39Ubs+R+0
         iAmWFXcWbENODsQRpdBHWsRX/5olByBaU0RV9F3itnCRLgnNvnUCcC3vx3ovoP2/kxD2
         ipMQ==
X-Gm-Message-State: AOAM533xSfhcTGUto5zpUwmhOqcWlbLqGjidImpT/wVCjESrEX5gAjlp
        0EDNaVfXHbGn7vHLaTq8Og==
X-Google-Smtp-Source: ABdhPJzoGCN0N40Nhaq9Ddug/dAwXluP1+HZQcWkRFpkBk/o4g6/sSDkr4/qhIyZP2IC3dnt/zTsSA==
X-Received: by 2002:aca:1015:: with SMTP id 21mr495980oiq.92.1621450524171;
        Wed, 19 May 2021 11:55:24 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s17sm46433oog.31.2021.05.19.11.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 11:55:23 -0700 (PDT)
Received: (nullmailer pid 3449813 invoked by uid 1000);
        Wed, 19 May 2021 18:55:21 -0000
Date:   Wed, 19 May 2021 13:55:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, timur@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        nicoleotsuka@gmail.com, kernel@pengutronix.de, lgirdwood@gmail.com,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        tiwai@suse.com, shawnguo@kernel.org, devicetree@vger.kernel.org,
        festevam@gmail.com
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: imx-card: Add binding doc for
 imx sound card
Message-ID: <20210519185521.GA3449751@robh.at.kernel.org>
References: <1621247488-21412-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621247488-21412-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 18:31:27 +0800, Shengjiu Wang wrote:
> Imx-card is a new added machine driver for supporting
> ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms. But these
> DAC/ADCs are not only supported codecs. This machine driver is
> designed to be a more common machine driver for i.MX platform,
> it can support widely cpu dai interface and codec dai interface.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v3:
> - use a generic compatible string as Rob's comments.
> - change the file name
> 
> changes in v2:
> - update doc accoring to Rob's comment, use the common porperties.
> 
>  .../bindings/sound/imx-audio-card.yaml        | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-card.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
