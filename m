Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EA43183F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhJRL6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:58:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26873 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRL6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634558153; x=1666094153;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=scwDj207MIPOMz6QLQAXQ7ECvfgrIrVUQAzYDMTZuxg=;
  b=oUSxKqn4B9+99sU9izemxjJGZUY9/vyJsvSl+A0TDpTMuImwQelpZc2b
   lWE/t8epoBf+LSok5+DQ4MJSTZPtcf1hi6HYI4fZ2GF2ZJf7wmfWHZXo/
   erJ5y23EK9qibhtVFuoBQ+ZWrSpiS3AkeCfypTgdESJeGHWsH5KMBo/iR
   QhKfepZE0uLBc9SshMsWhAsQOSxdcb9pqDEXdHcIBqaEStsIXWFcKLSjf
   cp4WfY42RB/aprCxSFqs2tb2/pzo6aGAQ5pQaGIPjtZf0ny9S7QO/SY3f
   Uzho5DEWKudPbW7Nno7XoFjdZJeezh4fBCQANQDYyIhhdVv+oPXxoKLQw
   A==;
IronPort-SDR: tGBXMkmoyYRHZlZESqgtnQ2Q74cKe722DeHSyLj3hmpwyM0y2lhimqy7Sut0XzCTtvckD6t1m+
 hPG8tQbsrsqNAfCLtr33EZG+StF/YBZmQE4jIu407z1rnZSI0njJAL4uAFCVR/xv7dqsd70xah
 tldc2xt2j1KQBFdL1l20zbVn5ecJdTBOrPueXOF6mxpTxKvNxizhIIULeTyXm/pNBad15hAj/M
 0+2Yrh73yPjKC1IJSM0dUti8I+HxaSKIf0KDQSuMG/cnRV1Z1D5LOzGiZW5teJ42ZxCy6q4uiR
 8KLmFRLKuTU+cwFJ9548HoCq
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="140140509"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2021 04:55:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 04:55:52 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 18 Oct 2021 04:55:50 -0700
Subject: Re: [PATCH v8 2/3] dt-bindings: clock: lan966x: Add LAN966X Clock
 Controller
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Manohar.Puri@microchip.com>
References: <20211008082635.31774-1-kavyasree.kotagiri@microchip.com>
 <20211008082635.31774-3-kavyasree.kotagiri@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <c17e542f-3216-b251-11e4-ade6cc02f055@microchip.com>
Date:   Mon, 18 Oct 2021 13:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211008082635.31774-3-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2021 at 10:26, Kavyasree Kotagiri wrote:
> This adds the DT bindings documentation for lan966x SoC
> generic clock controller.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

If it can speed-up adoption:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> v7 -> v8:
> - No changes.
> 
> v6 -> v7:
> - No changes.
> 
> v5 -> v6:
> - Removed "_clk" in clock-names.
> - Added Reviewed-by.
> 
> v4 -> v5:
> - In v4 dt-bindings, missed adding "clock-names" in required
>    properties and example. So, added them.
> 
> v3 -> v4:
> - Updated "clocks" description.
> - Added "clock-names".
> 
> v2 -> v3:
> - Fixed dt_binding_check errors.
> 
> v1 -> v2:
> - Updated example provided for clk controller DT node.
> 
>   .../bindings/clock/microchip,lan966x-gck.yaml | 57 +++++++++++++++++++
>   1 file changed, 57 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> new file mode 100644
> index 000000000000..fca83bd68e26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/microchip,lan966x-gck.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN966X Generic Clock Controller
> +
> +maintainers:
> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> +
> +description: |
> +  The LAN966X Generic clock controller contains 3 PLLs - cpu_clk,
> +  ddr_clk and sys_clk. This clock controller generates and supplies
> +  clock to various peripherals within the SoC.
> +
> +properties:
> +  compatible:
> +    const: microchip,lan966x-gck
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: CPU clock source
> +      - description: DDR clock source
> +      - description: System clock source
> +
> +  clock-names:
> +    items:
> +      - const: cpu
> +      - const: ddr
> +      - const: sys
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clks: clock-controller@e00c00a8 {
> +        compatible = "microchip,lan966x-gck";
> +        #clock-cells = <1>;
> +        clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
> +        clock-names = "cpu", "ddr", "sys";
> +        reg = <0xe00c00a8 0x38>;
> +    };
> +...
> 


-- 
Nicolas Ferre
