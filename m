Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66773E7BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbhHJPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbhHJPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:14:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B86C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:14:25 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mDTSM-0006LX-OJ; Tue, 10 Aug 2021 17:14:18 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mDTSM-0006Ld-5d; Tue, 10 Aug 2021 17:14:18 +0200
Message-ID: <17daf0f387dff8145559df6a983b0a222c100514.camel@pengutronix.de>
Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
 property
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Date:   Tue, 10 Aug 2021 17:14:17 +0200
In-Reply-To: <20210810073510.18218-2-qiangqing.zhang@nxp.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
         <20210810073510.18218-2-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-10 at 15:35 +0800, Joakim Zhang wrote:
> Introduce "reverse-data" property for nvmem provider to reverse buffer.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index b8dc3d2b6e92..bc745083fc64 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -61,6 +61,11 @@ patternProperties:
>                description:
>                  Size in bit within the address range specified by reg.
>  
> +      reverse-data:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Reverse the data that read from the storage device.

I'd prefer if it was more explicit that the *bytes* will be reversed. Otherwise
a reader might think that this is reversing on the *bit* level.

Jan

> +
>      required:
>        - reg
>  

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

