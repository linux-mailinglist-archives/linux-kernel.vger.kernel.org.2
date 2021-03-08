Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE03315F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhCHSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:25:14 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3608 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhCHSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615227900; x=1646763900;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xwiUSnP6Ue3KFD8mVvG7vvodfW+fgM8ZOHSDbKV717g=;
  b=sYhALPavfs+XosIFWtY3NX0rC2ucvg3LR1Odpmx3DQC6hItBpCMkq3GJ
   U1NTmUblyLktuJVI3fxSPf7zPQeLd/WfCiRz2Xnly/VtQROO8Y2k/T3sd
   KcNMf3ifUZtzKCpj2ktZNBZBT/iSUiVi6XhPqn2CxXCkmvog6PlBDZoV4
   TM1a5lx+gFmsym93/Frdk+lOzy8sCn78IgQOkkL52A72xRBU+vyG+26RE
   1CSWScpGVzQjx10YTc3oOqHWAxqSWTeZUF4pqjRCSlPZwR5TMOl1JyaTK
   Oug3eOxnS9A9qHDHV/Fqwx4qfkDpuEdVZwv4flVMwLXSKgRF1aIelHLpF
   A==;
IronPort-SDR: 5d9GdlEZOsPA0KZxEnQbSeIFIoTjbdvyDA/iBxsFvV2qx19ymU3J+6+o+htQr4WT4SMLMRW/wP
 gYVfgRJRWQs3MXW3bxB/Q124HEtI8guy9MfqQOH2iAEUZQZpX+cXmeng/83Bm3i88kolbKzQDk
 YVJJCIrzJ41E9O4QQRsc8XzyWxIf5veB1EGs7IN7mmdxaV1Nvrx7M51A8Ycm1pwWntNSmsWtaW
 y0vxp40CpzSzSGs6nxcDD4kDRyvJ8rxRurKjSWqobff+rMMkdNcDZ7vhSPNt2rOyKP1colsdbe
 ncw=
X-IronPort-AV: E=Sophos;i="5.81,233,1610434800"; 
   d="scan'208";a="106384155"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2021 11:25:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 8 Mar 2021 11:25:00 -0700
Received: from [10.171.246.58] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 8 Mar 2021 11:24:58 -0700
Subject: Re: [PATCH 1/2] dt-bindings: mchp-eic: add bindings
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, <maz@kernel.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>
References: <20210302102846.619980-1-claudiu.beznea@microchip.com>
 <20210302102846.619980-2-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <c14db0e2-a3a1-51bc-2363-c96e329bb521@microchip.com>
Date:   Mon, 8 Mar 2021 19:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302102846.619980-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2021 at 11:28, Claudiu Beznea wrote:
> Add DT bindings for Microchip External Interrupt Controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   .../interrupt-controller/mchp,eic.yaml        | 74 +++++++++++++++++++

Nitpicking: use full vendor name in binding file name: microchip,eic.yaml

>   1 file changed, 74 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mchp,eic.yaml
  [..]

Regards,
-- 
Nicolas Ferre
