Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA7736CA95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhD0RtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236172AbhD0RtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:49:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B895F613B2;
        Tue, 27 Apr 2021 17:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619545713;
        bh=ansZ9TWX7BHKjttOfw8Gt7pEIO4Xv4GvtqculRF+tY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LF4TA0JZgZzony/LBEc9sme0p4WBsEWauZ5hVcRJeFiTS4a9foGWNNpfpPPLkxmRo
         tNxvgyu9UToS9FFcoE3vXcbTsDGpsMCxtj1El3B4Jk6i2lccU4HDwN8xryn/wegbOk
         6Rvvq4j1Mv1s+I63NAt269Sl5S0oPJH8Lu3XY0sY=
Date:   Tue, 27 Apr 2021 19:48:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 154/190] Revert "ath6kl: return error code in
 ath6kl_wmi_set_roam_lrssi_cmd()"
Message-ID: <YIhObhA4WpaNAJR7@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-155-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-155-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:29PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit fc6a6521556c8250e356ddc6a3f2391aa62dc976.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/ath/ath6kl/wmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
> index b137e7f34397..aca9732ec1ee 100644
> --- a/drivers/net/wireless/ath/ath6kl/wmi.c
> +++ b/drivers/net/wireless/ath/ath6kl/wmi.c
> @@ -776,8 +776,10 @@ int ath6kl_wmi_set_roam_lrssi_cmd(struct wmi *wmi, u8 lrssi)
>  	cmd->info.params.roam_rssi_floor = DEF_LRSSI_ROAM_FLOOR;
>  	cmd->roam_ctrl = WMI_SET_LRSSI_SCAN_PARAMS;
>  
> -	return ath6kl_wmi_cmd_send(wmi, 0, skb, WMI_SET_ROAM_CTRL_CMDID,
> +	ath6kl_wmi_cmd_send(wmi, 0, skb, WMI_SET_ROAM_CTRL_CMDID,
>  			    NO_SYNC_WMIFLAG);
> +
> +	return 0;
>  }
>  
>  int ath6kl_wmi_force_roam_cmd(struct wmi *wmi, const u8 *bssid)
> -- 
> 2.31.1
> 

This change does NOTHING as the caller to this function does not even
look at the return value of the call.  So the "claim" that this fixed an
an issue is not true.  I will keep this revert and fix it up properly by
propagating the error up the stack correctly.

thanks,

greg k-h
