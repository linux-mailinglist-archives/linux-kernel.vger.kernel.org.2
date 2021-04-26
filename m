Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9636AA46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 03:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhDZBW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 21:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhDZBWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:22:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA0A961139;
        Mon, 26 Apr 2021 01:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619400104;
        bh=jknGm2zHjukb35gDDsR8FM1t9ewdehkMYjtUN18Zsx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eY4T5FrYK9qq250q6M9NkEZQpSJTPUJfnNsb8xMEB5dmAOqrFyfDifX8jj+r6900L
         PLcyLVe1LizJYhDrDFFkYnplMNlFWcji4HYYIJ6Wi+bA3fg0dJhpdYQo2+J5KAyMB1
         loWbfHJTghQNnFYJoRtVnSA/MxhpUONN3VUlwWx87iChnUbrrfsD/pXrATHWeDZrG0
         bk4wJZqFc/9cUnzTnMjh74OYevXQVsuzpl57HjTYg2X27AvfouzFNS01/GvfDFFsZv
         +nNt6hg3vUP/0ehakyi0X80GF1GRrPVaCoowGeBGjLGgJNTdOhmOOpXw4xwGvmpAHC
         eBH5yim2CTQzA==
Date:   Mon, 26 Apr 2021 09:21:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] dt-bindings: usb: dwc3-imx8mp: Use the correct name
 for child node "snps,dwc3"
Message-ID: <20210426012138.GA27585@dragon>
References: <20210329072714.2135-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329072714.2135-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:27:12PM +0800, Zhen Lei wrote:
> File snps,dwc3.yaml describes the schema of Synopsys DesignWare USB3
> Controller, it directly or indirectly contains "$ref: usb.yaml". So the
> node name of "snps,dwc3" must start with "usb". Otherwise, the following
> warning will be displayed:
> 
> Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.example.dt.yaml: \
> dwc3@38100000: $nodename:0: 'dwc3@38100000' does not match '^usb(@.*)?'
>         From schema: Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> 
> 
> Zhen Lei (2):
>   dt-bindings: usb: dwc3-imx8mp: Use the correct name for child node
>     "snps,dwc3"
>   arm64: dts: imx8mp: Use the correct name for child node "snps,dwc3"

Applied both, thanks.
