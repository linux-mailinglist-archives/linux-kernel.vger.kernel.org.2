Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6684147D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhIVLfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbhIVLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:35:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED57C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:34:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mT0W3-0005u6-Db; Wed, 22 Sep 2021 13:34:19 +0200
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-2-qiangqing.zhang@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <6d91d833-08cc-7ce2-4fe5-3d843a8b31ae@pengutronix.de>
Date:   Wed, 22 Sep 2021 13:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908100257.17833-2-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.09.21 12:02, Joakim Zhang wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Some of the nvmem providers encode data for certain type of nvmem cell,
> example mac-address is stored in ascii or with delimiter or in reverse order.
> 
> This is much specific to vendor, so having a cell-type would allow nvmem
> provider drivers to post-process this before using it.

I don't agree with this assessment. Users of the OCOTP so far
used this specific encoding. Bootloaders decode the OCOTP this way, but this
encoding isn't really an inherent attribute of the OCOTP. A new NXP SoC
with a different OTP IP will likely use the same format. Users may even
use the same format on an EEPROM to populate a second off-SoC interface, .. etc.

I'd thus prefer to not make this specific to the OCOTP as all:

  * #define NVMEM_CELL_ENCODING_MAC_ADDRESS_IMX	/* ... */

  * cell-type = <NVMEM_CELL_ENCODING_MAC_ADDRESS_IMX>;

  * and then the decoder is placed into some generic location, e.g.
   drivers/nvmem/encodings.c for Linux

That way, we can reuse this and future encodings across nvmem providers.
It's also more extendable: e.g. big endian fields on EEPROMs. Just stick
the cell-type in, document it in the binding and drivers supporting it
will interpret bytes appropriately.

It's still a good idea to record the type as well as the encoding,
e.g. split the 32 bit encoding constant into two 16-bit values.
One is an enum of possible types (unknown, mac_address, IP address ... etc.)
and one is an enum of the available encodings.

What do you think?

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 +++++++++++
>  include/dt-bindings/nvmem/nvmem.h                  |  8 ++++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/nvmem/nvmem.h
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index b8dc3d2b6e92..8cf6c7e72b0a 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -60,6 +60,11 @@ patternProperties:
>              - minimum: 1
>                description:
>                  Size in bit within the address range specified by reg.
> +      cell-type:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maxItems: 1
> +        description:
> +          Type of nvmem, Use defines in dt-bindings/nvmem/nvmem.h.
>  
>      required:
>        - reg
> @@ -69,6 +74,7 @@ additionalProperties: true
>  examples:
>    - |
>        #include <dt-bindings/gpio/gpio.h>
> +      #include <dt-bindings/nvmem/nvmem.h>
>  
>        qfprom: eeprom@700000 {
>            #address-cells = <1>;
> @@ -98,6 +104,11 @@ examples:
>                reg = <0xc 0x1>;
>                bits = <2 3>;
>            };
> +
> +          mac_addr: mac-addr@90{
> +              reg = <0x90 0x6>;
> +              cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
> +          };
>        };
>  
>  ...
> diff --git a/include/dt-bindings/nvmem/nvmem.h b/include/dt-bindings/nvmem/nvmem.h
> new file mode 100644
> index 000000000000..eed0478f6bfd
> --- /dev/null
> +++ b/include/dt-bindings/nvmem/nvmem.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DT_NVMMEM_H
> +#define __DT_NVMMEM_H
> +
> +#define NVMEM_CELL_TYPE_UNKNOWN		0
> +#define NVMEM_CELL_TYPE_MAC_ADDRESS	1
> +
> +#endif /* __DT_NVMMEM_H */
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
