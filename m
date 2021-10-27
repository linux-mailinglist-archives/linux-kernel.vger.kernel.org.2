Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461EA43D690
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhJ0Wau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhJ0Wap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:30:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC0C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:28:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d3so6621295wrh.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=71spJIGnFrqrdouSR+SowZM1rGrDszQ6QivBGBVwrxM=;
        b=CTUPmzxFh7u7RgDqN9z2hrXSUAzMpZ6XCCvEeMXFpPcSv0lDRI0BQ3nj28WN0yuQRu
         GaGFINjc/VD24q9cDUiGeC/cSJsAQ8HTSog1jaDuSD7RcxX6yDsQxvaMmTGZYjAffhcs
         U9FiUYlL16euw8FAT0quJUzEkoTvec8rQlobr+5LY+euyXSCmXuNekCTtgzZSLbt10RF
         cYIUH/daPyfEQLth/bFvuvCR/Re+aVNEt776fhMIrgqP+GW7y8v4mJPzLRDO7Wcymper
         YfWjUdDNsiKM9V5LFXkBti3NoQHs3TIRJYxeK/m/ARe2znjSjhqU0lScULJgLJY3JySL
         5KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=71spJIGnFrqrdouSR+SowZM1rGrDszQ6QivBGBVwrxM=;
        b=R+do/gMjuYlTZrVyZJxy+c5KBJi9JJ6qdlsoZkWm95NtuxyxJ6C7UjswyBm/rYOmEU
         uQETtHTg+QRCF0beuPfIuEF85YSQIomCmn7GeOEYkGBSBDUYcHtfidbdsJnLb8pcL9AX
         hJUV/uaWxfUKeLACSW/kjQQZBQI6pTN9tjIwdtBKfxstha1qler0kuWIcSU5RWREw/wH
         bF2JXxL+bdU9PsxobEfNH6bPPV0eZePqT0J5cKJ/p2l6Nogc5b90tHTB/+VhCf3ySdht
         u5LNO37oIlUcKJ/0Q2B0BEVY+eNKs3pIMGrNME/bmhHmyRwXQ1nZTzWPOEjLNlFmFfBI
         BuXw==
X-Gm-Message-State: AOAM533zJIRKzwsdKeGiN2KlQ6XcP7z45kCjP00naIrdhYQICx35SzPT
        sm0qslx5EGkS4rZij0HzKCsLZQ==
X-Google-Smtp-Source: ABdhPJyznMWKCylYXdBIPG4173zMZXiUWU+5cGReOY4rcfhKfnB9UIDX8nm/66H3Uau5uvpXFGpTBg==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr591890wrn.4.1635373697424;
        Wed, 27 Oct 2021 15:28:17 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q1sm916689wmj.20.2021.10.27.15.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 15:28:16 -0700 (PDT)
Message-ID: <9a933103-afbc-3278-3d2e-ade77b0e4b09@linaro.org>
Date:   Wed, 27 Oct 2021 23:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 3/3] wcn36xx: ensure pairing of init_scan/finish_scan
 and start_scan/end_scan
Content-Language: en-US
To:     Benjamin Li <benl@squareup.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Joseph Gates <jgates@squareup.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eugene Krasnikov <k.eugene.e@gmail.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211027170306.555535-1-benl@squareup.com>
 <20211027170306.555535-4-benl@squareup.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20211027170306.555535-4-benl@squareup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2021 18:03, Benjamin Li wrote:
> An SMD capture from the downstream prima driver on WCN3680B shows the
> following command sequence for connected scans:
> 
> - init_scan_req
>      - start_scan_req, channel 1
>      - end_scan_req, channel 1
>      - start_scan_req, channel 2
>      - ...
>      - end_scan_req, channel 3
> - finish_scan_req
> - init_scan_req
>      - start_scan_req, channel 4
>      - ...
>      - end_scan_req, channel 6
> - finish_scan_req
> - ...
>      - end_scan_req, channel 165
> - finish_scan_req
> 
> Upstream currently never calls wcn36xx_smd_end_scan, and in some cases[1]
> still sends finish_scan_req twice in a row or before init_scan_req. A
> typical connected scan looks like this:
> 
> - init_scan_req
>      - start_scan_req, channel 1
> - finish_scan_req
> - init_scan_req
>      - start_scan_req, channel 2
> - ...
>      - start_scan_req, channel 165
> - finish_scan_req
> - finish_scan_req
> 
> This patch cleans up scanning so that init/finish and start/end are always
> paired together and correctly nested.
> 
> - init_scan_req
>      - start_scan_req, channel 1
>      - end_scan_req, channel 1
> - finish_scan_req
> - init_scan_req
>      - start_scan_req, channel 2
>      - end_scan_req, channel 2
> - ...
>      - start_scan_req, channel 165
>      - end_scan_req, channel 165
> - finish_scan_req
> 
> Note that upstream will not do batching of 3 active-probe scans before
> returning to the operating channel, and this patch does not change that.
> To match downstream in this aspect, adjust IEEE80211_PROBE_DELAY and/or
> the 125ms max off-channel time in ieee80211_scan_state_decision.
> 
> [1]: commit d195d7aac09b ("wcn36xx: Ensure finish scan is not requested
> before start scan") addressed one case of finish_scan_req being sent
> without a preceding init_scan_req (the case of the operating channel
> coinciding with the first scan channel); two other cases are:
> 1) if SW scan is started and aborted immediately, without scanning any
>     channels, we send a finish_scan_req without ever sending init_scan_req,
>     and
> 2) as SW scan logic always returns us to the operating channel before
>     calling wcn36xx_sw_scan_complete, finish_scan_req is always sent twice
>     at the end of a SW scan
> 
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
> Signed-off-by: Benjamin Li <benl@squareup.com>
> ---
>   drivers/net/wireless/ath/wcn36xx/main.c    | 34 +++++++++++++++++-----
>   drivers/net/wireless/ath/wcn36xx/smd.c     |  4 +++
>   drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
>   3 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 18383d0fc0933..37b4016f020c9 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -400,6 +400,7 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
>   static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
>   {
>   	struct wcn36xx *wcn = hw->priv;
> +	int ret;
>   
>   	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac config changed 0x%08x\n", changed);
>   
> @@ -415,17 +416,31 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
>   			 * want to receive/transmit regular data packets, then
>   			 * simply stop the scan session and exit PS mode.
>   			 */
> -			wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
> -						wcn->sw_scan_vif);
> -			wcn->sw_scan_channel = 0;
> +			if (wcn->sw_scan_channel)
> +				wcn36xx_smd_end_scan(wcn, wcn->sw_scan_channel);
> +			if (wcn->sw_scan_init) {
> +				wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
> +							wcn->sw_scan_vif);
> +			}
>   		} else if (wcn->sw_scan) {
>   			/* A scan is ongoing, do not change the operating
>   			 * channel, but start a scan session on the channel.
>   			 */
> -			wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
> -					      wcn->sw_scan_vif);
> +			if (wcn->sw_scan_channel)
> +				wcn36xx_smd_end_scan(wcn, wcn->sw_scan_channel);
> +			if (!wcn->sw_scan_init) {
> +				/* This can fail if we are unable to notify the
> +				 * operating channel.
> +				 */
> +				ret = wcn36xx_smd_init_scan(wcn,
> +							    HAL_SYS_MODE_SCAN,
> +							    wcn->sw_scan_vif);
> +				if (ret) {
> +					mutex_unlock(&wcn->conf_mutex);
> +					return -EIO;
> +				}
> +			}
>   			wcn36xx_smd_start_scan(wcn, ch);
> -			wcn->sw_scan_channel = ch;
>   		} else {
>   			wcn36xx_change_opchannel(wcn, ch);
>   		}
> @@ -723,7 +738,12 @@ static void wcn36xx_sw_scan_complete(struct ieee80211_hw *hw,
>   	wcn36xx_dbg(WCN36XX_DBG_MAC, "sw_scan_complete");
>   
>   	/* ensure that any scan session is finished */
> -	wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN, wcn->sw_scan_vif);
> +	if (wcn->sw_scan_channel)
> +		wcn36xx_smd_end_scan(wcn, wcn->sw_scan_channel);
> +	if (wcn->sw_scan_init) {
> +		wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
> +					wcn->sw_scan_vif);
> +	}
>   	wcn->sw_scan = false;
>   	wcn->sw_scan_opchannel = 0;
>   }
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index 3cecc8f9c9647..830341be72673 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -721,6 +721,7 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
>   		wcn36xx_err("hal_init_scan response failed err=%d\n", ret);
>   		goto out;
>   	}
> +	wcn->sw_scan_init = true;
>   out:
>   	mutex_unlock(&wcn->hal_mutex);
>   	return ret;
> @@ -751,6 +752,7 @@ int wcn36xx_smd_start_scan(struct wcn36xx *wcn, u8 scan_channel)
>   		wcn36xx_err("hal_start_scan response failed err=%d\n", ret);
>   		goto out;
>   	}
> +	wcn->sw_scan_channel = scan_channel;
>   out:
>   	mutex_unlock(&wcn->hal_mutex);
>   	return ret;
> @@ -781,6 +783,7 @@ int wcn36xx_smd_end_scan(struct wcn36xx *wcn, u8 scan_channel)
>   		wcn36xx_err("hal_end_scan response failed err=%d\n", ret);
>   		goto out;
>   	}
> +	wcn->sw_scan_channel = 0;
>   out:
>   	mutex_unlock(&wcn->hal_mutex);
>   	return ret;
> @@ -822,6 +825,7 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
>   		wcn36xx_err("hal_finish_scan response failed err=%d\n", ret);
>   		goto out;
>   	}
> +	wcn->sw_scan_init = false;
>   out:
>   	mutex_unlock(&wcn->hal_mutex);
>   	return ret;
> diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> index 1c8d918137da2..fbd0558c2c196 100644
> --- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> +++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> @@ -248,6 +248,7 @@ struct wcn36xx {
>   	struct cfg80211_scan_request *scan_req;
>   	bool			sw_scan;
>   	u8			sw_scan_opchannel;
> +	bool			sw_scan_init;
>   	u8			sw_scan_channel;
>   	struct ieee80211_vif	*sw_scan_vif;
>   	struct mutex		scan_lock;
> 

LGTM

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
