Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474123FA61A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhH1N4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhH1N4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 09:56:03 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D757C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 06:55:13 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mJynS-0006qF-JY; Sat, 28 Aug 2021 15:54:58 +0200
Date:   Sat, 28 Aug 2021 15:54:58 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        jing.yangyang@zte.com.cn, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove unused static variable
Message-ID: <20210828135458.sx443eayxi7bahsv@viti.kaiser.cx>
References: <YSoz5Qip12K899SN@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSoz5Qip12K899SN@user>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Saurav Girepunje (saurav.girepunje@gmail.com):

> Remove unused static variable rtw_enusbss from os_intfs.c file.

> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/os_intfs.c | 2 --
>  1 file changed, 2 deletions(-)

> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 8d0158f4a45d..c3ac0ae153f8 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -85,7 +85,6 @@ static int rtw_AcceptAddbaReq = true;/*  0:Reject AP's Add BA req, 1:Accept AP's
>  static int rtw_antdiv_cfg = 2; /*  0:OFF , 1:ON, 2:decide by Efuse config */
>  static int rtw_antdiv_type; /* 0:decide by efuse  1: for 88EE, 1Tx and 1RxCG are diversity.(2 Ant with SPDT), 2:  for 88EE, 1Tx and 2Rx are diversity.(2 Ant, Tx and RxCG are both on aux port, RxCS is on main port), 3: for 88EE, 1Tx and 1RxCG are fixed.(1Ant, Tx and RxCG are both on aux port) */

> -static int rtw_enusbss;/* 0:disable, 1:enable */

>  static int rtw_hwpdn_mode = 2;/* 0:disable, 1:enable, 2: by EFUSE config */

> @@ -133,7 +132,6 @@ module_param(rtw_low_power, int, 0644);
>  module_param(rtw_wifi_spec, int, 0644);
>  module_param(rtw_antdiv_cfg, int, 0644);
>  module_param(rtw_antdiv_type, int, 0644);
> -module_param(rtw_enusbss, int, 0644);
>  module_param(rtw_hwpdn_mode, int, 0644);
>  module_param(rtw_hwpwrp_detect, int, 0644);
>  module_param(rtw_hw_wps_pbc, int, 0644);
> --
> 2.32.0

Looks ok to me, thanks.

Acked-by: Martin Kaiser <martin@kaiser.cx>
