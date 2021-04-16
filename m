Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F91361E08
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbhDPKh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234899AbhDPKhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:37:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65CE86115B;
        Fri, 16 Apr 2021 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618569451;
        bh=2NmNjtA3l2od/uJIV8xyDAELe5Bj6tvlex9wTBoBoR4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O7oCcMRIl2UeQO1cBvETVEe8Qjw9gg0PjP310tIj8NmYZWeaxirFT1Qgco11sAQLf
         C9uQ4f/KBQJ0cjmoVRGXY1wkQwwU+27a8bZnINIX9mnsQjmP5ShCI+yBdB+ro8azYU
         q+gw11anV4KoOWYmD7z8mc4hKz7E3hq5LDFwAgR7Bt/eUZZP4MzHkzeJ6gFLqUNSnS
         eqghaBpBJmeIfN1PHENpL2mGH72Y3iekyDwbVXk8sS8F0uetZer8wR3r8Fu2MG1459
         5RtYojoPQ1O1haqLfZMe6pCopFXmz+wPZfZG+soxdWxdKMltlL8T7JbrtsGqfEMjOl
         yIuzL3PBxSNfA==
Subject: Re: [PATCH 0/4] dt-bindings: soc/arm: Convert pending ti,sci*
 bindings to json format
To:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210416063721.20538-1-nm@ti.com>
From:   Tero Kristo <kristo@kernel.org>
Message-ID: <56388707-c8d3-ebdf-77a2-c5a983856b4d@kernel.org>
Date:   Fri, 16 Apr 2021 13:37:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416063721.20538-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 09:37, Nishanth Menon wrote:
> Hi,
> 
> I understand that the following series belong to various maintainers,
> but, it is a bit better reviewed as a single series for
> cohesiveness.
> 
> There are also dts fixups that this series exposes, which is good, but
> I chose to hold them back for now pending binding review at least. The
> complete series is available in [1] if folks are curious.
> 
> Nishanth Menon (4):
>    dt-bindings: reset: Convert ti,sci-reset to json schema
>    dt-bindings: clock: Convert ti,sci-clk to json schema
>    dt-bindings: soc: ti: Convert ti,sci-pm-domain to json schema
>    dt-bindings: arm: keystone: Convert ti,sci to json schema

For the whole series:

Reviewed-by: Tero Kristo <kristo@kernel.org>

> 
>   .../bindings/arm/keystone/ti,sci.txt          |  86 ------------
>   .../bindings/arm/keystone/ti,sci.yaml         | 129 ++++++++++++++++++
>   .../devicetree/bindings/clock/ti,sci-clk.txt  |  36 -----
>   .../devicetree/bindings/clock/ti,sci-clk.yaml |  52 +++++++
>   .../bindings/reset/ti,sci-reset.txt           |  62 ---------
>   .../bindings/reset/ti,sci-reset.yaml          |  51 +++++++
>   .../bindings/soc/ti/sci-pm-domain.txt         |  65 ---------
>   .../bindings/soc/ti/sci-pm-domain.yaml        |  59 ++++++++
>   8 files changed, 291 insertions(+), 249 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>   delete mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>   create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
>   delete mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
>   create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
>   delete mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>   create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
> 
> [1] https://github.com/nmenon/linux-2.6-playground/commits/yaml/tisci
> 
> Regards,
> Nishanth Menon
> 

