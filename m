Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DA344AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhCVQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhCVQLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:11:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40D1E61974;
        Mon, 22 Mar 2021 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616429475;
        bh=uXWzdJao91erGlT0gjrKYueZuvbCNU6HdOT0WlaF5yM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEnzfShKpZ2/pZOcNP/XY/SJVhKtnYD0qkwdfM9k86Gkx37aPGO69jshLHe4dn9Lg
         J2HxkOUpDIr+SgybbHXxZ/YVlbhc/C6tyZI9vxI5dW4607Ohk4b61TMLVTdaZQ6pos
         wBNMYjhhrqidz/uW9WlAo7fm7f6RGISOFMLu/fKo=
Date:   Mon, 22 Mar 2021 17:11:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] staging: rtl8723bs: remove argument in
 recv_indicatepkts_pkt_loss_cnt
Message-ID: <YFjBoZJBnAqDh+jY@kroah.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
 <fb3d6e0ae858738e3213b60d87e70c2f1697f051.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb3d6e0ae858738e3213b60d87e70c2f1697f051.1616422773.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:31:43PM +0100, Fabio Aiuto wrote:
> remove debug_priv argument so function prototype can be
> easily moved away
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 9ef2408ded57..e2a6afed723c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -1983,13 +1983,13 @@ int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, union rec
>  
>  }
>  
> -void recv_indicatepkts_pkt_loss_cnt(struct debug_priv *pdbgpriv, u64 prev_seq, u64 current_seq);
> -void recv_indicatepkts_pkt_loss_cnt(struct debug_priv *pdbgpriv, u64 prev_seq, u64 current_seq)
> +u64 recv_indicatepkts_pkt_loss_cnt(u64 prev_seq, u64 current_seq);

But you did not drop the function prototype, why keep it?

And shouldn't this be static?

thanks,

greg k-h
