Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0B4301A9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhJPJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbhJPJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:46:05 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C828C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:43:56 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbgEJ-00039Y-L9; Sat, 16 Oct 2021 11:43:51 +0200
Date:   Sat, 16 Oct 2021 11:43:51 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] staging: r8188eu: remove ODM_AntselStatistics_88C()
Message-ID: <20211016094351.ntxyhsycadtz5yv3@viti.kaiser.cx>
References: <20211015163507.9091-1-straube.linux@gmail.com>
 <20211015163507.9091-5-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015163507.9091-5-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> Function ODM_AntselStatistics_88C() is not used, remove it.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/odm.c     | 21 ---------------------
>  drivers/staging/r8188eu/include/odm.h |  3 ---
>  2 files changed, 24 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 28bd6f36cddd..d3d13164ca8f 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -1016,27 +1016,6 @@ void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
>  	ODM_AntennaDiversityInit_88E(pDM_Odm);
>  }

> -void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId, u32 PWDBAll, bool isCCKrate)
> -{
> -	struct sw_ant_switch *pDM_SWAT_Table = &pDM_Odm->DM_SWAT_Table;
> -
> -	if (pDM_SWAT_Table->antsel == 1) {
> -		if (isCCKrate) {
> -			pDM_SWAT_Table->CCK_Ant1_Cnt[MacId]++;
> -		} else {
> -			pDM_SWAT_Table->OFDM_Ant1_Cnt[MacId]++;
> -			pDM_SWAT_Table->RSSI_Ant1_Sum[MacId] += PWDBAll;
> -		}
> -	} else {
> -		if (isCCKrate) {
> -			pDM_SWAT_Table->CCK_Ant2_Cnt[MacId]++;
> -		} else {
> -			pDM_SWAT_Table->OFDM_Ant2_Cnt[MacId]++;
> -			pDM_SWAT_Table->RSSI_Ant2_Sum[MacId] += PWDBAll;
> -		}
> -	}
> -}
> -

Yet again, that seems to make a bunch of variables unused.
I guess that antsel, CCK_Ant1_Cnt, OFDM_Ant1_Cnt, RSSI_Ant1_Sum and their
Ant2 versions can be removed (haven't tried it yet, though).

I'm really curious to see what's left when we're done with all these
removals...

Best regards,
Martin
