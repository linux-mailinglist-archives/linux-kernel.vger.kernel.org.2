Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF89364E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 01:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhDSX3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 19:29:34 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:42952 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhDSX3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:29:32 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 13JNSKma008066; Tue, 20 Apr 2021 08:28:20 +0900
X-Iguazu-Qid: 34tre4erL1uXq8Lo6m
X-Iguazu-QSIG: v=2; s=0; t=1618874900; q=34tre4erL1uXq8Lo6m; m=EC0wCzbTh/qdnd5+DAtK9Y6Bek2gq4A5/QgKBXv6o1E=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 13JNSIgK023852
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Apr 2021 08:28:18 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1C0A91000A3;
        Tue, 20 Apr 2021 08:28:18 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 13JNSHw1015773;
        Tue, 20 Apr 2021 08:28:17 +0900
Date:   Tue, 20 Apr 2021 08:28:00 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI
 ARCHITECTURE
X-TSB-HOP: ON
Message-ID: <20210419232800.cbcyjlyrqywkrqdt@toshiba.co.jp>
References: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
 <20210419092609.3692-2-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419092609.3692-2-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your patch.

On Mon, Apr 19, 2021 at 11:26:07AM +0200, Lukas Bulwahn wrote:
> Commit 836863a08c99 ("MAINTAINERS: Add information for Toshiba Visconti ARM
> SoCs") refers to the non-existing file toshiba,tmpv7700-pinctrl.yaml in
> ./Documentation/devicetree/bindings/pinctrl/. Commit 1825c1fe0057
> ("pinctrl: Add DT bindings for Toshiba Visconti TMPV7700 SoC") originating
> from the same patch series however adds the file
> toshiba,visconti-pinctrl.yaml in that directory instead.
> 
> So, refer to toshiba,visconti-pinctrl.yaml in the ARM/TOSHIBA VISCONTI
> ARCHITECTURE section instead.
> 

Could you add  Fixes: tag?

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c54b8e4520d1..d31c8058b17f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2669,7 +2669,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
>  F:	Documentation/devicetree/bindings/arm/toshiba.yaml
>  F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
>  F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
> -F:	Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
> +F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
>  F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
>  F:	arch/arm64/boot/dts/toshiba/
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
> -- 
> 2.17.1
> 
> 
