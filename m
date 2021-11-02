Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE4442D37
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhKBLyF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Nov 2021 07:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBLyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:54:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE8C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:51:29 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhsJx-0004RX-3V; Tue, 02 Nov 2021 12:51:17 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhsJv-0049ko-1l; Tue, 02 Nov 2021 12:51:15 +0100
Message-ID: <34481cb056c4bc4dc355571713675f141350e04d.camel@pengutronix.de>
Subject: Re: [PATCH v3 3/8] dt-bindings: reset: Add bindings for SP7021
 reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com
Date:   Tue, 02 Nov 2021 12:51:14 +0100
In-Reply-To: <852e24e942cf40b8240ced4de4ac78acc7694355.1635737544.git.qinjian@cqplus1.com>
References: <cover.1635737544.git.qinjian@cqplus1.com>
         <852e24e942cf40b8240ced4de4ac78acc7694355.1635737544.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-01 at 13:01 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 reset driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/reset/sunplus,reset.yaml         | 40 ++++++++
>  MAINTAINERS                                   |  2 +
>  include/dt-bindings/reset/sp-sp7021.h         | 99 +++++++++++++++++++
>  3 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
>  create mode 100644 include/dt-bindings/reset/sp-sp7021.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/sunplus,reset.yaml b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
> new file mode 100644
> index 000000000..bf55f4ee2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/reset/sunplus,reset.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Sunplus SoC Reset Controller
> +
> +maintainers:
> +  - Qin Jian <qinjian@cqplus1.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-reset # Reset Controller on SP7021 and compatible SoCs
> +      - sunplus,q645-reset # Reset Controller on Q645 and compatible SoCs

The commit message only mentions SP7021. Should Q645 be added later, or
is this patch missing the binding header for Q655?

regards
Philipp
