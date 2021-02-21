Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB5320A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBUNGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhBUNGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:06:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E155D60238;
        Sun, 21 Feb 2021 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613912752;
        bh=6MArVc78lof4Goy/3AP1erD3HDYrDJ0RUeIzBlh0BR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fo/rGO3C9cdBKF63QHhJP8Ubf6EtOJ4pUJ2qvyvNp8NNUp1JC0/ruLKviBnpFFj+f
         IZmvU4VA67sFZBN4+NaHm5uHTBn2j8vanbLyCg+xcErw5ZtPF2Wpuqg2Aacpfj55E6
         C24Y5x7zgMbjuAQQ4Vy5pjl88Xtc2JzrBB8FotWE=
Date:   Sun, 21 Feb 2021 14:05:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amrit Khera <amritkhera98@gmail.com>
Cc:     lee.jones@linaro.org, arnd@arndb.de, kuba@kernel.org,
        mail@anirudhrb.com, ayush@disroot.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax: Fix block comment style issue in stack.c
Message-ID: <YDJarRhaoA/WFIyd@kroah.com>
References: <20210219202524.14642-1-amritkhera98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219202524.14642-1-amritkhera98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 01:55:25AM +0530, Amrit Khera wrote:
> This change fixes a checkpatch warning for "Block comments
> use * on subsequent lines".
> 
> Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
> ---
>  drivers/staging/wimax/stack.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/wimax/stack.c b/drivers/staging/wimax/stack.c
> index ace24a6dfd2d..781426000015 100644
> --- a/drivers/staging/wimax/stack.c
> +++ b/drivers/staging/wimax/stack.c
> @@ -62,11 +62,12 @@ MODULE_PARM_DESC(debug,
>   * close to where the data is generated.
>   */
>  /*
> -static const struct nla_policy wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
> -	[WIMAX_GNL_STCH_STATE_OLD] = { .type = NLA_U8 },
> -	[WIMAX_GNL_STCH_STATE_NEW] = { .type = NLA_U8 },
> -};
> -*/
> + * static const struct nla_policy
> + * wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
> + *	[WIMAX_GNL_STCH_STATE_OLD] = { .type = NLA_U8 },
> + *	[WIMAX_GNL_STCH_STATE_NEW] = { .type = NLA_U8 },
> + * };
> + */

Why not just remove this variable entirely?  It's obviously not needed,
so just delete the thing.

thanks,

greg k-h
