Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6CD36CAB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbhD0SAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0SAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:00:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6F5561006;
        Tue, 27 Apr 2021 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619546374;
        bh=ajsOUMfry1UiEECypelFixv0Nl4LfhyvaOwekeZGRXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvXF0eQKYfGpvUGMEBRsvjJy4r5pqh9dxYdY+nQFRu9vaJs37iA6ZqJW0yoN1UYN0
         XCt6E41OLmXiKh3S67kq7gMi13WWlg9k9SO51OhH+LlAAyrtGQrB4kDbdzcRy1If7c
         ZkRppD6WXi6lDxcHpCqvi1mFtqFDod7joTmemCmI=
Date:   Tue, 27 Apr 2021 19:59:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 083/190] Revert "net: cw1200: fix a NULL pointer
 dereference"
Message-ID: <YIhRA6oMozsepir4@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-84-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-84-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:18PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 0ed2a005347400500a39ea7c7318f1fea57fb3ca.
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
>  drivers/net/wireless/st/cw1200/main.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/st/cw1200/main.c b/drivers/net/wireless/st/cw1200/main.c
> index 326b1cc1d2bc..015dd202e758 100644
> --- a/drivers/net/wireless/st/cw1200/main.c
> +++ b/drivers/net/wireless/st/cw1200/main.c
> @@ -342,11 +342,6 @@ static struct ieee80211_hw *cw1200_init_common(const u8 *macaddr,
>  	mutex_init(&priv->wsm_cmd_mux);
>  	mutex_init(&priv->conf_mutex);
>  	priv->workqueue = create_singlethread_workqueue("cw1200_wq");
> -	if (!priv->workqueue) {
> -		ieee80211_free_hw(hw);
> -		return NULL;
> -	}
> -
>  	sema_init(&priv->scan.lock, 1);
>  	INIT_WORK(&priv->scan.work, cw1200_scan_work);
>  	INIT_DELAYED_WORK(&priv->scan.probe_work, cw1200_probe_work);
> -- 
> 2.31.1
> 

The original here looks correct, dropping this revert.

greg k-h
