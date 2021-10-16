Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8543017F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbhJPJcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhJPJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:32:04 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE800C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:29:56 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbg0j-0002zW-EL; Sat, 16 Oct 2021 11:29:49 +0200
Date:   Sat, 16 Oct 2021 11:29:49 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] staging: r8188eu: remove empty functions from odm.c
Message-ID: <20211016092949.7746u74o2f5lgyzo@viti.kaiser.cx>
References: <20211015163507.9091-1-straube.linux@gmail.com>
 <20211015163507.9091-2-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015163507.9091-2-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> Remove empty functions from odm.c.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/odm.c             | 32 -------------------
>  drivers/staging/r8188eu/hal/odm_HWConfig.c    |  7 +---
>  drivers/staging/r8188eu/include/odm.h         |  7 ----
>  drivers/staging/r8188eu/include/odm_precomp.h |  2 --
>  4 files changed, 1 insertion(+), 47 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 2178ffe41bb3..627213392795 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -196,13 +196,9 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
>  	    (pDM_Odm->AntDivType == CGCS_RX_HW_ANTDIV)	||
>  	    (pDM_Odm->AntDivType == CG_TRX_SMART_ANTDIV))
>  		odm_HwAntDiv(pDM_Odm);
> -	else if (pDM_Odm->AntDivType == CGCS_RX_SW_ANTDIV)
> -		odm_SwAntDivChkAntSwitch(pDM_Odm, SWAW_STEP_PEAK);

This was the last user of SWAW_STEP_PEAK. The define can be removed now
(maybe in a follow-up patch).

Acked-by: Martin Kaiser <martin@kaiser.cx>
