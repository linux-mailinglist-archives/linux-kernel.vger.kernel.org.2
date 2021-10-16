Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0CA4301B5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbhJPKBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhJPKBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:01:36 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A25C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:59:28 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbgTK-0003KE-RK; Sat, 16 Oct 2021 11:59:22 +0200
Date:   Sat, 16 Oct 2021 11:59:22 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: Remove redundant 'if' statement
Message-ID: <20211016095922.4jf7nkwycgkfectz@viti.kaiser.cx>
References: <20211016091042.19614-1-fmdefrancesco@gmail.com>
 <20211016091042.19614-4-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016091042.19614-4-fmdefrancesco@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Fabio M. De Francesco (fmdefrancesco@gmail.com):

> Remove a redundant 'if' statement.

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 6 ------
>  1 file changed, 6 deletions(-)

> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 2900c31d8ec9..2263e35b45cb 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -255,12 +255,6 @@ int rtw_cmd_thread(void *context)
>  		if (wait_for_completion_killable(&pcmdpriv->enqueue_cmd))
>  			break;

> -		if (padapter->bDriverStopped ||
> -		    padapter->bSurpriseRemoved) {
> -			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
> -				__func__, padapter->bDriverStopped, padapter->bSurpriseRemoved, __LINE__);
> -			break;
> -		}
>  _next:
>  		if (padapter->bDriverStopped ||
>  		    padapter->bSurpriseRemoved) {
> -- 
> 2.33.0

Acked-by: Martin Kaiser <martin@kaiser.cx>
