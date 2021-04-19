Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19992364EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhDSXk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 19:40:57 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:36098 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbhDSXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:40:56 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 13JNdlVM005625; Tue, 20 Apr 2021 08:39:47 +0900
X-Iguazu-Qid: 2wHHhVLfD68WbBSrrf
X-Iguazu-QSIG: v=2; s=0; t=1618875586; q=2wHHhVLfD68WbBSrrf; m=OpTumAytCPng2rPIF8zru+UG0PLMCzlcfWIBcmKYL68=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 13JNdivT005802
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Apr 2021 08:39:44 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1E4FB1000B0;
        Tue, 20 Apr 2021 08:39:44 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 13JNdhoP024180;
        Tue, 20 Apr 2021 08:39:43 +0900
Date:   Tue, 20 Apr 2021 08:39:07 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB
 GPIO HUB DRIVER
X-TSB-HOP: ON
Message-ID: <20210419233907.qaxgwlggm35fyklz@toshiba.co.jp>
References: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
 <20210419092609.3692-3-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419092609.3692-3-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 19, 2021 at 11:26:08AM +0200, Lukas Bulwahn wrote:
> Commit 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB
> gpio hub on Hikey960") refers to the non-existing file
> ./Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml, but this
> commit's patch series does not add any related devicetree binding in misc.
> 
> So, just drop this file reference in HIKEY960 ONBOARD USB GPIO HUB DRIVER.
> 

Could you add Fixes: tag ?
Please also add this to patch: "MAINTAINERS: rectify entry for INTEL KEEM BAY
DRM DRIVER".

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d31c8058b17f..4f152717365c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8239,7 +8239,6 @@ M:	John Stultz <john.stultz@linaro.org>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/misc/hisi_hikey_usb.c
> -F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
>  
>  HISILICON PMU DRIVER
>  M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
> -- 
> 2.17.1
> 
> 

Best regards,
  Nobuhiro
