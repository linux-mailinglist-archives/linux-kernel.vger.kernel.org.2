Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC33DAAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhG2SEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:04:54 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34739 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhG2SEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:04:52 -0400
Received: by mail-io1-f43.google.com with SMTP id y200so8294387iof.1;
        Thu, 29 Jul 2021 11:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6I72gG1P0zApF6OrBauN3t2s02ZMxrn9uRt36/myoU8=;
        b=gI3/8Jy2Ek5ET7iezglpykOR/2iLQJuOf3GHX/LIDapX2/6ToY/uDjgbfAILO869IP
         kIoC9CA7beOdAFsdA5AmhE5AK+k2YMj3umPf0Vi/yiB7lQirYZ3+Ew3q2ZGhqFfy1VZ+
         NBJVz84F4SJU4TlHoXhvXRcVzDrCzknkkATXo4Xy0AsskTNX76M28v38fViLqf9G39Hg
         ukokdikfRyX7o+0sdAYLfU111X4ARX/2yluXkv3lH4Au+QXLOfunYSifBq/MisL46tU+
         dxmGAOQ5HqH9A/YaqZXZf8xEs5GIWbj3//b6Y7bjH58NK2gbTx1Zx+zR+MObcMaPRJWa
         JvPA==
X-Gm-Message-State: AOAM532Rqe9g5yXAtmvkm3/32qqcg18zEi0++RX57kbxh96qm38YuCjn
        lT6RTWWAOy/Uq21rL3u9Yw==
X-Google-Smtp-Source: ABdhPJynyCEMw2cCV4h4Sb+MFG+vlrFFDi3qP/W/SWJv/LFCBBADKJbn3FJ6uxrHU8xwoCmWRjyfkQ==
X-Received: by 2002:a05:6638:1356:: with SMTP id u22mr5526794jad.39.1627581888099;
        Thu, 29 Jul 2021 11:04:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z12sm2206498ilq.73.2021.07.29.11.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:04:47 -0700 (PDT)
Received: (nullmailer pid 605567 invoked by uid 1000);
        Thu, 29 Jul 2021 18:04:46 -0000
Date:   Thu, 29 Jul 2021 12:04:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com
Subject: Re: [PATCH] dt-bindings: power: reset: convert Xilinx Zynq MPSoC
 bindings to YAML
Message-ID: <YQLtvsM94bwiHzFl@robh.at.kernel.org>
References: <20210715095627.228176-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715095627.228176-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 18:56:27 +0900, Nobuhiro Iwamatsu wrote:
> Convert power managemnet for Xilinx Zynq MPSoC bindings documentation to
> YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../power/reset/xlnx,zynqmp-power.txt         | 61 --------------
>  .../power/reset/xlnx,zynqmp-power.yaml        | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
> 

Applied, thanks!
