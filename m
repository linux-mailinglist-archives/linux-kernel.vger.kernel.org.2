Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660EA434767
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:56:38 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:14067 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhJTI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:56:37 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AG0BvIa2ZOUpDxLLfve4VbAqjBLEkLtp133Aq?=
 =?us-ascii?q?2lEZdPUzSL37qynOpoV56faQsl0ssR4b9OxoVJPufZq+z/5ICOsqXItKNTOO0A?=
 =?us-ascii?q?GVxepZg7cKrQeNJwTOssZAyKZtdLV/AtXsAVU/rcuS2njcL+od?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="534925257"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 10:54:22 +0200
Date:   Wed, 20 Oct 2021 10:54:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: vt6655: Rename `by_preamble_type`
 parameter
In-Reply-To: <20211020084033.414994-1-karolinadrobnik@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110201051300.2930@hadrien>
References: <20211020084033.414994-1-karolinadrobnik@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Oct 2021, Karolina Drobnik wrote:

> Drop `by` prefix in the first parameter of `bb_get_frame_time` function.
> As the original argument, `byPreambleType`, was renamed to `preamble_type`,
> the parameter referring to it is now renamed to match the new naming
> convention.
> Update `bb_get_frame_time` comment to reflect that change.
>
> This patch is a follow-up work to this commit:
>     Commit 548b6d7ebfa4 ("staging: vt6655: Rename byPreambleType field")

This is not going to be practical.  If the previous patch is accepted,
then this it not needed.  If the previous patch is not yet accepted, then
there needs to be a vn+1 putting the patches together into a series.

> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c | 6 +++---
>  drivers/staging/vt6655/baseband.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> index 5efca92f1f18..8f9177db6663 100644
> --- a/drivers/staging/vt6655/baseband.c
> +++ b/drivers/staging/vt6655/baseband.c
> @@ -1691,7 +1691,7 @@ static const unsigned short awc_frame_time[MAX_RATE] = {
>   *
>   * Parameters:
>   *  In:
> - *      by_preamble_type  - Preamble Type
> + *      preamble_type     - Preamble Type
>   *      by_pkt_type        - PK_TYPE_11A, PK_TYPE_11B, PK_TYPE_11GB, PK_TYPE_11GA

In the realm of small cleanups to this driver, the extra space in front of
the - above is a bit annoying.

>   *      cb_frame_length   - Baseband Type
>   *      tx_rate           - Tx Rate
> @@ -1700,7 +1700,7 @@ static const unsigned short awc_frame_time[MAX_RATE] = {
>   * Return Value: FrameTime
>   *
>   */
> -unsigned int bb_get_frame_time(unsigned char by_preamble_type,
> +unsigned int bb_get_frame_time(unsigned char preamble_type,
>  			       unsigned char by_pkt_type,
>  			       unsigned int cb_frame_length,
>  			       unsigned short tx_rate)
> @@ -1717,7 +1717,7 @@ unsigned int bb_get_frame_time(unsigned char by_preamble_type,
>  	rate = (unsigned int)awc_frame_time[rate_idx];
>
>  	if (rate_idx <= 3) {		    /* CCK mode */
> -		if (by_preamble_type == 1) /* Short */
> +		if (preamble_type == 1) /* Short */

I hope you will get around to replacing the 1 by the appropriate constant
and removing the "Short" comment.

julia

>  			preamble = 96;
>  		else
>  			preamble = 192;
> diff --git a/drivers/staging/vt6655/baseband.h b/drivers/staging/vt6655/baseband.h
> index 0a30afaa7cc3..15b2802ed727 100644
> --- a/drivers/staging/vt6655/baseband.h
> +++ b/drivers/staging/vt6655/baseband.h
> @@ -44,7 +44,7 @@
>  #define TOP_RATE_2M         0x00200000
>  #define TOP_RATE_1M         0x00100000
>
> -unsigned int bb_get_frame_time(unsigned char by_preamble_type,
> +unsigned int bb_get_frame_time(unsigned char preamble_type,
>  			       unsigned char by_pkt_type,
>  			       unsigned int cb_frame_length,
>  			       unsigned short w_rate);
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20211020084033.414994-1-karolinadrobnik%40gmail.com.
>
