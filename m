Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E65A36C98E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhD0QiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236367AbhD0QiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:38:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCDB4610FB;
        Tue, 27 Apr 2021 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541440;
        bh=nVDXMbnPRGhv4bH/ASwvKnMCqMIJ0pG0Tk5zgICwIO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uekEIyevwmaMm0h+MTq9OkQ92bJ4Ot183+SQvRf1eM+k/H/q2rpdIAQZLLQR9TLu
         5z85OGhz9LIyN/0fnAFcjbSXB8xwgVB7moJhbLCs+4ZFjnZiGgU2rUCVByqf9oCstI
         jmiYd0P46shvf5zjYe6edm2LLRUZANyq+oslu8EY=
Date:   Tue, 27 Apr 2021 18:37:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 082/190] Revert "rsi: Fix NULL pointer dereference in
 kmalloc"
Message-ID: <YIg9vkwlWw622ZB2@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-83-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-83-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:17PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit d5414c2355b20ea8201156d2e874265f1cb0d775.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/rsi/rsi_91x_mac80211.c | 30 +++++++++------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
> index 16025300cddb..714d4d53236c 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
> @@ -188,27 +188,27 @@ bool rsi_is_cipher_wep(struct rsi_common *common)
>   * @adapter: Pointer to the adapter structure.
>   * @band: Operating band to be set.
>   *
> - * Return: int - 0 on success, negative error on failure.
> + * Return: None.
>   */
> -static int rsi_register_rates_channels(struct rsi_hw *adapter, int band)
> +static void rsi_register_rates_channels(struct rsi_hw *adapter, int band)
>  {
>  	struct ieee80211_supported_band *sbands = &adapter->sbands[band];
>  	void *channels = NULL;
>  
>  	if (band == NL80211_BAND_2GHZ) {
> -		channels = kmemdup(rsi_2ghz_channels, sizeof(rsi_2ghz_channels),
> -				   GFP_KERNEL);
> -		if (!channels)
> -			return -ENOMEM;
> +		channels = kmalloc(sizeof(rsi_2ghz_channels), GFP_KERNEL);
> +		memcpy(channels,
> +		       rsi_2ghz_channels,
> +		       sizeof(rsi_2ghz_channels));
>  		sbands->band = NL80211_BAND_2GHZ;
>  		sbands->n_channels = ARRAY_SIZE(rsi_2ghz_channels);
>  		sbands->bitrates = rsi_rates;
>  		sbands->n_bitrates = ARRAY_SIZE(rsi_rates);
>  	} else {
> -		channels = kmemdup(rsi_5ghz_channels, sizeof(rsi_5ghz_channels),
> -				   GFP_KERNEL);
> -		if (!channels)
> -			return -ENOMEM;
> +		channels = kmalloc(sizeof(rsi_5ghz_channels), GFP_KERNEL);
> +		memcpy(channels,
> +		       rsi_5ghz_channels,
> +		       sizeof(rsi_5ghz_channels));
>  		sbands->band = NL80211_BAND_5GHZ;
>  		sbands->n_channels = ARRAY_SIZE(rsi_5ghz_channels);
>  		sbands->bitrates = &rsi_rates[4];
> @@ -227,7 +227,6 @@ static int rsi_register_rates_channels(struct rsi_hw *adapter, int band)
>  	sbands->ht_cap.mcs.rx_mask[0] = 0xff;
>  	sbands->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
>  	/* sbands->ht_cap.mcs.rx_highest = 0x82; */
> -	return 0;
>  }
>  
>  static int rsi_mac80211_hw_scan_start(struct ieee80211_hw *hw,
> @@ -2067,16 +2066,11 @@ int rsi_mac80211_attach(struct rsi_common *common)
>  	wiphy->available_antennas_rx = 1;
>  	wiphy->available_antennas_tx = 1;
>  
> -	status = rsi_register_rates_channels(adapter, NL80211_BAND_2GHZ);
> -	if (status)
> -		return status;
> +	rsi_register_rates_channels(adapter, NL80211_BAND_2GHZ);
>  	wiphy->bands[NL80211_BAND_2GHZ] =
>  		&adapter->sbands[NL80211_BAND_2GHZ];
>  	if (common->num_supp_bands > 1) {
> -		status = rsi_register_rates_channels(adapter,
> -						     NL80211_BAND_5GHZ);
> -		if (status)
> -			return status;
> +		rsi_register_rates_channels(adapter, NL80211_BAND_5GHZ);
>  		wiphy->bands[NL80211_BAND_5GHZ] =
>  			&adapter->sbands[NL80211_BAND_5GHZ];
>  	}
> -- 
> 2.31.1
> 

This looks correct, will drop the revert.

greg k-h
