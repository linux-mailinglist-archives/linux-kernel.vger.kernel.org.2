Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1414058B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhIIOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353474AbhIIOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:14:05 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF87CC0E9FBC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 05:24:48 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mOJ6f-0005nk-Q1; Thu, 09 Sep 2021 14:24:41 +0200
Date:   Thu, 9 Sep 2021 14:24:41 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused macro READ_AND_CONFIG_TC
Message-ID: <20210909122441.cawtj7sivoey4k6k@viti.kaiser.cx>
References: <20210909110517.15243-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909110517.15243-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The macro READ_AND_CONFIG_TC is not used, remove it.
> Found with GCC -Wunused-macros.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/odm_HWConfig.c | 1 -
>  1 file changed, 1 deletion(-)

> diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
> index ada22a526fee..058d04f6aa58 100644
> --- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
> +++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
> @@ -6,7 +6,6 @@
>  #define READ_AND_CONFIG     READ_AND_CONFIG_MP

>  #define READ_AND_CONFIG_MP(ic, txt) (ODM_ReadAndConfig##txt##ic(dm_odm))
> -#define READ_AND_CONFIG_TC(ic, txt) (ODM_ReadAndConfig_TC##txt##ic(dm_odm))

>  static u8 odm_QueryRxPwrPercentage(s8 AntPower)
>  {
> -- 
> 2.33.0

looks good and compiles for me

Acked-by: Martin Kaiser <martin@kaiser.cx>
