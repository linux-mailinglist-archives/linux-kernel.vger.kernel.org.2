Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC9036ED53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbhD2P0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:26:07 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38764 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhD2P0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:26:06 -0400
Received: by mail-ot1-f51.google.com with SMTP id v23-20020a9d60570000b02902a53bac99a3so6926691otj.5;
        Thu, 29 Apr 2021 08:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TEtZap6joVLh76QxhB4cvIO7b+XRriZfSItFMXMeJ/0=;
        b=sNlzKrzJKoFtXTqu4gRtMnGSwk7CmqOo155b7xJ7RtH/IPY5OqbF78uX8a3FLYg/dd
         rNSPMPl6YKhjFuCAFTEYdgkMfaROH2gO5IPapHcCYtcGTOG+O7UdQlzhShUurGF2iXYv
         0dBPADJr0qHKEPVnIXvHlg4FLzmegjjsCBFiMMdjwqqKlxqrX+6EuZn6ODtwrFhiwUFJ
         GU42H77jbrGLGVYyKyd7YIHq+kdSc3Lrjd9PPrMUmzkUcnvFxJq32jECANvWdbzSkPtL
         VAfh6uyMGxRJa072ElOMQNrVcjYkT1aKFMli4Qaf3jgmoH5pxN2niomhTj5IWlAaKcFg
         RIow==
X-Gm-Message-State: AOAM531zl+f8szbyn7AkWyrXsNMjKaduRtyekz1jQnD+fYLPWv0Mo7QS
        wRLYeLQPzp732ROeaeqFzRH4c4fFtg==
X-Google-Smtp-Source: ABdhPJxKxmvGnHbo/R1tnb+S8hE1xY00taMUBG5koZc4JKmNQnelIvxNdBi8XyLp2vCMmFvdki12TQ==
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr13507755otn.88.1619709917856;
        Thu, 29 Apr 2021 08:25:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t84sm53454oih.35.2021.04.29.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:25:17 -0700 (PDT)
Received: (nullmailer pid 1303434 invoked by uid 1000);
        Thu, 29 Apr 2021 15:25:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, agx@sigxcpu.org, ping.bai@nxp.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        andrew.smirnov@gmail.com, linux-arm-kernel@lists.infradead.org,
        marex@denx.de, abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>,
        frieder.schrempf@kontron.de, festevam@gmail.com,
        l.stach@pengutronix.de, p.zabel@pengutronix.de,
        s.hauer@pengutronix.de, aford173@gmail.com, linux-imx@nxp.com
In-Reply-To: <20210429073331.21204-3-peng.fan@oss.nxp.com>
References: <20210429073331.21204-1-peng.fan@oss.nxp.com> <20210429073331.21204-3-peng.fan@oss.nxp.com>
Subject: Re: [PATCH 2/4] Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
Date:   Thu, 29 Apr 2021 10:25:15 -0500
Message-Id: <1619709915.248803.1303433.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 15:33:29 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Document the i.MX BLK_CTL with its devicetree properties.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.example.dt.yaml:0:0: /example-0/blk-ctl@32e28000: failed to match any schema with compatible: ['fsl,imx8mm-dispmix-blk-ctl', 'syscon']

See https://patchwork.ozlabs.org/patch/1471527

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

