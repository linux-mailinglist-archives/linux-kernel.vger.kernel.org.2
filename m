Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F6443DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhKCIA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:00:57 -0400
Received: from phobos.denx.de ([85.214.62.61]:34814 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhKCIAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:00:54 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E317182DB4;
        Wed,  3 Nov 2021 08:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1635926297;
        bh=oa/Uxsv/XQV6SQzir5MDA0SRJostU11TptI67xLy7ek=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jIrSCETGj5Q3CQhhP3MphPGYcaagsGce28X3kpnlsD4uH9c55ZbJqBOx+LcNJp4ty
         5lD9ykFniYEVG2ZsAM1MhbMKw5yTiEQMfdfX/AN9bMcTo/a6UqneCFB6bbwrVhWRmA
         QzB0jB7tEUqjhduEEgB1j22xLABLRoxNbX/JyIOo4VeXCWFsIhHrQBtG/n0jH3MTRh
         5D8lQlRQ1q8zwyUWP95qpG+H/f0a9QL8mxkbQQ+63/xq3AxNUwHc23ChL3RWEvsNV7
         C3pp3F7/7olaLwPHezeROyWBop8c7oeNvIt7s66o10PVzNdIyTRwTrv0r+j7UxO6+9
         jcg9qYMbfyCmw==
Subject: Re: [PATCH] drm: mxsfb: Check NULL pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, stefan@agner.ch,
        airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1635925699-3414834-1-git-send-email-jiasheng@iscas.ac.cn>
From:   Marek Vasut <marex@denx.de>
Message-ID: <579998fc-12ee-fb23-afe5-f0ef70807a3c@denx.de>
Date:   Wed, 3 Nov 2021 08:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1635925699-3414834-1-git-send-email-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 8:48 AM, Jiasheng Jiang wrote:
> As we see in the drm_connector_list_iter_next(), it could return
> NULL. In order to avoid the use of the NULL pointer, it may be
> better to check the return value.
> 
> Fixes: c42001e ("drm: mxsfb: Use drm_panel_bridge")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/gpu/drm/mxsfb/mxsfb_drv.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 6da9355..b875c11 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -145,6 +145,8 @@ static int mxsfb_attach_bridge(struct mxsfb_drm_private *mxsfb)
>   	 */
>   	drm_connector_list_iter_begin(drm, &iter);
>   	mxsfb->connector = drm_connector_list_iter_next(&iter);
> +	if (!mxsfb->connector)
> +		return 1;

In which case does this happen failure happen ?
What is the test case ?
