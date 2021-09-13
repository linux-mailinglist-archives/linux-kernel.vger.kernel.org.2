Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF264098C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhIMQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhIMQTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:19:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7241960EE5;
        Mon, 13 Sep 2021 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631549911;
        bh=1QYduAjqko44zZ/U4MXISA30+hpgDfQVIK7iDh1pJFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTezS0NaO1PiYWPqLJuTEBs+5L0sJu+mAaHcj91lCRVC1Tnau9L7q0b9Prh2g3HPB
         yfdSlUyemyuWufbysMg+L8KHLgWIUVmwE+hvorrvFD24wOWbd8JxpYNseyGl3SllEO
         kSB9Mb2mMcbjTfFB/kpklR0JEXYvrJfjHmFx0wNI=
Date:   Mon, 13 Sep 2021 18:18:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove the function
 power_saving_wk_hdl
Message-ID: <YT951VyaUEX8uFpz@kroah.com>
References: <YTub30ZRG3oLbxQW@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTub30ZRG3oLbxQW@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 11:24:39PM +0530, Saurav Girepunje wrote:
> Remove the function power_saving_wk_hdl() as it just calling
> the rtw_ps_processor().Instead of power_saving_wk_hdl() call directly
> rtw_ps_processor().
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index ce73ac7cf973..35e6a943c556 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1669,11 +1669,6 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
>  	return res;
>  }
> 
> -static void power_saving_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
> -{
> -	 rtw_ps_processor(padapter);
> -}
> -
>  #ifdef CONFIG_88EU_P2P
>  u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
>  {
> @@ -1941,7 +1936,7 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
>  		dynamic_chk_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
>  		break;
>  	case POWER_SAVING_CTRL_WK_CID:
> -		power_saving_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
> +		rtw_ps_processor(padapter);
>  		break;
>  	case LPS_CTRL_WK_CID:
>  		lps_ctrl_wk_hdl(padapter, (u8)pdrvextra_cmd->type_size);
> --
> 2.32.0
> 
> 

Also does not apply to my tree.  Please rebase against my staging-next
branch and resend.

thanks,

greg k-h
