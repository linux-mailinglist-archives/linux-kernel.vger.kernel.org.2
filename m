Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089BB352E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhDBRm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:42:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45938 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234361AbhDBRmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:42:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 83FD0201F7D;
        Fri,  2 Apr 2021 19:42:28 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 76455201F7A;
        Fri,  2 Apr 2021 19:42:28 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 61B202030E;
        Fri,  2 Apr 2021 19:42:28 +0200 (CEST)
Date:   Fri, 2 Apr 2021 20:42:28 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        peng.fan@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add imx8m power domain driver
Message-ID: <20210402174228.wjl6paul5hxu7dnx@fsr-ub1664-175>
References: <20210402164506.520121-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402164506.520121-1-adrien.grassein@gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-02 18:45:04, Adrien Grassein wrote:
> Hi,
> 
> this patch et aims to add the support of the i.MX 8 Power Domain driver.
> Some devices (like usbotg2) can't work without this patch as their
> attached power domain are down.
> 
> The original drivr was taken from le imx kernel and aapted to fit with
> the actual mainline (minor fixes).
> 
> Thanks,
> 

Big NACK for the whole series.

This approach has already been rejected upstream.

Plus, you changed the original author, this work was originally done by Jacky Bai.

> Adrien Grassein (2):
>   dt-bindings: power: Add documentation for imx8m power domain driver
>   soc: imx: add Power Domain driver for i.MX8M(M|N|P)
> 
>  .../bindings/power/fsl,imx-power-domain.yaml  |  89 +++++++
>  MAINTAINERS                                   |  10 +
>  drivers/soc/imx/Kconfig                       |   7 +
>  drivers/soc/imx/Makefile                      |   1 +
>  drivers/soc/imx/imx8m_pm_domains.c            | 233 ++++++++++++++++++
>  include/dt-bindings/power/imx8mm-power.h      |  21 ++
>  include/dt-bindings/power/imx8mn-power.h      |  15 ++
>  include/dt-bindings/power/imx8mp-power.h      |  28 +++
>  include/soc/imx/imx_sip.h                     |  12 +
>  9 files changed, 416 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-power-domain.yaml
>  create mode 100644 drivers/soc/imx/imx8m_pm_domains.c
>  create mode 100644 include/dt-bindings/power/imx8mm-power.h
>  create mode 100644 include/dt-bindings/power/imx8mn-power.h
>  create mode 100644 include/dt-bindings/power/imx8mp-power.h
>  create mode 100644 include/soc/imx/imx_sip.h
> 
> -- 
> 2.25.1
> 
