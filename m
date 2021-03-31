Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E695B35084A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhCaUg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:36:29 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37547 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236514AbhCaUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:36:22 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0e7n4K3lt3cyUy4jZdcelwqjBepyeYIsi2QD?=
 =?us-ascii?q?101hICF9WsaTm9my2NES0hHpgDgcMUtQ+uyoEq+GXH/a6NpR6Y4eIb+tUGDdyQ?=
 =?us-ascii?q?mVBatl6pbvxCClJj3m+odmpMFdWoV3FdGYNzlHpOng5g3QKbsd6f2m1IztuuvE?=
 =?us-ascii?q?1XdqSmhRGthdxiN0EBySHEEzZCQuP/oEPaGR7MZGuDasEE5/Bq/QOlA+Q+PBq9?=
 =?us-ascii?q?fX/aiLXTc6BgUq4ATLrTSk5K+SKXal9yoeSD9GzPMe93HEmWXCiZmLgrWe8Fv8?=
 =?us-ascii?q?33WWx4lKkNHho+EzYfCku4wwEHHQrSqGIK5mQKaPuTgppvrH0idPrPDc5xE6P8?=
 =?us-ascii?q?py7HvNfma65Rv1sjOQtwoT1w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,293,1610406000"; 
   d="scan'208";a="500983645"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 22:36:21 +0200
Date:   Wed, 31 Mar 2021 22:36:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
cc:     hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: greybus: arche-platform:
 Fix ending '(' warnings
In-Reply-To: <20210331202445.108678-1-martinsdecarvalhobeatriz@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103312235040.3008@hadrien>
References: <20210331202445.108678-1-martinsdecarvalhobeatriz@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Mar 2021, Beatriz Martins de Carvalho wrote:

> Fix checkpatch check "CHECK: Lines should not end with a '('"
> in arche-platform.c:80 and arche-platform.c:184.

Please try to express what you have done and why, without using the word
Fix.  "Fix" doesn't explain what you have done.  It just says that you
have done something that you consider has made the code better.  But the
person receiving the message may have something else in mind.

julia

>
> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> ---
>  drivers/staging/greybus/arche-platform.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index eebf0deb39f5..e374dfc0c92f 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -77,9 +77,8 @@ static void arche_platform_set_state(struct arche_platform_drvdata *arche_pdata,
>  }
>
>  /* Requires arche_pdata->wake_lock is held by calling context */
> -static void arche_platform_set_wake_detect_state(
> -				struct arche_platform_drvdata *arche_pdata,
> -				enum svc_wakedetect_state state)
> +static void arche_platform_set_wake_detect_state(struct arche_platform_drvdata *arche_pdata,
> +						 enum svc_wakedetect_state state)
>  {
>  	arche_pdata->wake_detect_state = state;
>  }
> @@ -181,9 +180,8 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  						WD_STATE_COLDBOOT_START) {
>  					arche_platform_set_wake_detect_state(arche_pdata,
>  									     WD_STATE_COLDBOOT_TRIG);
> -					spin_unlock_irqrestore(
> -						&arche_pdata->wake_lock,
> -						flags);
> +					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> +							       flags);
>  					return IRQ_WAKE_THREAD;
>  				}
>  			}
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20210331202445.108678-1-martinsdecarvalhobeatriz%40gmail.com.
>
