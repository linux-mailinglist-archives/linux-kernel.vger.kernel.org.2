Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A5312D62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhBHJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhBHJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:20:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BA3C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 01:19:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z6so16132249wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 01:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ifbwqlW6r1eBbhVvf2MwLi1iLAcanVvLt9JE2wEA24=;
        b=uESUAk4eT0d1vv0KIxq/H0D/cjeCJ4m9ZXv0hvBbC0t+D1v1CzES8XPcV6KAAVQmDI
         4gv9FTHbyAHUFW8XdFVYq5AVmB4DVLIMcsyJ4ZDS6Fp7qi0dxVKYOrNK81WVXoQQjDju
         xRLwHwhe4xMJ8LjzUYWPmy+RVrPuKzJV1oggj3nuURkbLXfbQZWu6n8icdSr8rgM0lf3
         kSVuv4hyQFzN7q8dk852vwE/9dbLCtqT+QvSy5S5B9kAgQeE0mYE8gKdLRnneFaqtdFF
         iH7VF60Xo70zvBL270zxB6jOebKkD//lwQV8T5Rqm2r2/KPmn3dKslgIp0mr0xnN/Jfc
         p3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5ifbwqlW6r1eBbhVvf2MwLi1iLAcanVvLt9JE2wEA24=;
        b=mVdnL27Nqr5l95Y+8Ma9OSZvQtNmlJeh4pF5lT1gqrikI0hJzqKLUDs+GcrlT+zWpw
         5z2sLAbT4uR7enDY8MNpV+EfrUCBJ6K07d8+QqUac9LZgPqFnoTMCK19nMxCr2NQ9pPA
         0+CrUXxL2OMaCdWfXPiHnR/xm/wg7R1B7v1y3vcVOo6qVQMWl9fWsu4zmJ1FKBjWQIxN
         C86jwP0blOBvk1xvS7MFDKKAolABE4awfUfG8FnONdWJfUsnR4lkconHz2dJbZT70jv7
         bFu7vLiLrq06MSmE2NKSWzEQXvDqMPebG+FpB1bhIifGWuW4F3+kmPlNByT6tmJ7qF8p
         gmEA==
X-Gm-Message-State: AOAM533R2vFqRQcHn0PqQARD7hol1dYxQJGxaHzukbRZvUl8FB+NqO2c
        qCDSS8I06BtSb5ukwKiUqa7R9uEz5cg6gg==
X-Google-Smtp-Source: ABdhPJzGtOKWqBiLxCMstlxwq6R8WJksTjciEvaWakv1RcfCLsLu9eJkJvlV6ZiFAPCFg9AN/oHcvA==
X-Received: by 2002:a5d:5611:: with SMTP id l17mr19463034wrv.2.1612775987048;
        Mon, 08 Feb 2021 01:19:47 -0800 (PST)
Received: from [192.168.1.10] ([88.164.51.138])
        by smtp.gmail.com with ESMTPSA id d3sm31114822wrp.79.2021.02.08.01.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 01:19:46 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/bridge: dw-hdmi: Add DT binding to disable
 hotplug detect
To:     Mykyta Poturai <ddone@aruko.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210131095537.962292-1-ddone@aruko.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 mQENBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAG0KE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT6JATsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIW5AQ0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAYkBHwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8guQINBFYnf6QBEADQ+wBYa+X2n/xIQz/RUoGHf84Jm+yTqRT43t7sO48/cBW9vAn9
 GNwnJ3HRJWKATW0ZXrCr40ES/JqM1fUTfiFDB3VMdWpEfwOAT1zXS+0rX8yljgsWR1UvqyEP
 3xN0M/40Zk+rdmZKaZS8VQaXbveaiWMEmY7sBV3QvgOzB7UF2It1HwoCon5Y+PvyE3CguhBd
 9iq5iEampkMIkbA3FFCpQFI5Ai3BywkLzbA3ZtnMXR8Qt9gFZtyXvFQrB+/6hDzEPnBGZOOx
 zkd/iIX59SxBuS38LMlhPPycbFNmtauOC0DNpXCv9ACgC9tFw3exER/xQgSpDVc4vrL2Cacr
 wmQp1k9E0W+9pk/l8S1jcHx03hgCxPtQLOIyEu9iIJb27TjcXNjiInd7Uea195NldIrndD+x
 58/yU3X70qVY+eWbqzpdlwF1KRm6uV0ZOQhEhbi0FfKKgsYFgBIBchGqSOBsCbL35f9hK/JC
 6LnGDtSHeJs+jd9/qJj4WqF3x8i0sncQ/gszSajdhnWrxraG3b7/9ldMLpKo/OoihfLaCxtv
 xYmtw8TGhlMaiOxjDrohmY1z7f3rf6njskoIXUO0nabun1nPAiV1dpjleg60s3OmVQeEpr3a
 K7gR1ljkemJzM9NUoRROPaT7nMlNYQL+IwuthJd6XQqwzp1jRTGG26J97wARAQABiQM+BBgB
 AgAJBQJWJ3+kAhsCAikJEBaat7Gkz/iuwV0gBBkBAgAGBQJWJ3+kAAoJEHfc29rIyEnRk6MQ
 AJDo0nxsadLpYB26FALZsWlN74rnFXth5dQVQ7SkipmyFWZhFL8fQ9OiIoxWhM6rSg9+C1w+
 n45eByMg2b8H3mmQmyWztdI95OxSREKwbaXVapCcZnv52JRjlc3DoiiHqTZML5x1Z7lQ1T3F
 8o9sKrbFO1WQw1+Nc91+MU0MGN0jtfZ0Tvn/ouEZrSXCE4K3oDGtj3AdC764yZVq6CPigCgs
 6Ex80k6QlzCdVP3RKsnPO2xQXXPgyJPJlpD8bHHHW7OLfoR9DaBNympfcbQJeekQrTvyoASw
 EOTPKE6CVWrcQIztUp0WFTdRGgMK0cZB3Xfe6sOp24PQTHAKGtjTHNP/THomkH24Fum9K3iM
 /4Wh4V2eqGEgpdeSp5K+LdaNyNgaqzMOtt4HYk86LYLSHfFXywdlbGrY9+TqiJ+ZVW4trmui
 NIJCOku8SYansq34QzYM0x3UFRwff+45zNBEVzctSnremg1mVgrzOfXU8rt+4N1b2MxorPF8
 619aCwVP7U16qNSBaqiAJr4e5SNEnoAq18+1Gp8QsFG0ARY8xp+qaKBByWES7lRi3QbqAKZf
 yOHS6gmYo9gBmuAhc65/VtHMJtxwjpUeN4Bcs9HUpDMDVHdfeRa73wM+wY5potfQ5zkSp0Jp
 bxnv/cRBH6+c43stTffprd//4Hgz+nJcCgZKtCYIAPkUxABC85ID2CidzbraErVACmRoizhT
 KR2OiqSLW2x4xdmSiFNcIWkWJB6Qdri0Fzs2dHe8etD1HYaht1ZhZ810s7QOL7JwypO8dscN
 KTEkyoTGn6cWj0CX+PeP4xp8AR8ot4d0BhtUY34UPzjE1/xyrQFAdnLd0PP4wXxdIUuRs0+n
 WLY9Aou/vC1LAdlaGsoTVzJ2gX4fkKQIWhX0WVk41BSFeDKQ3RQ2pnuzwedLO94Bf6X0G48O
 VsbXrP9BZ6snXyHfebPnno/te5XRqZTL9aJOytB/1iUna+1MAwBxGFPvqeEUUyT+gx1l3Acl
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <6b8c11e3-655d-9bd3-c8dd-8b2b0ea71954@baylibre.com>
Date:   Mon, 8 Feb 2021 10:19:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210131095537.962292-1-ddone@aruko.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2021 10:55, Mykyta Poturai wrote:
> Add "disable-hpd" boolean binding for the device tree. When this option
> is turned on HPD-related IRQ is disabled and it is assumed that the HDMI
> connector is connected all the time. This may be useful in systems where
> it is impossible or undesirable to connect the HPD pin, or the
> connection is broken.

DRM mode forcing exists for this reason.

You can even force an EDID to have a fixed mode.

Neil

> 
> Signed-off-by: Mykyta Poturai <ddone@aruko.org>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 0c79a9ba48bb..4ca0ac130beb 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -194,6 +194,7 @@ struct dw_hdmi {
>  	unsigned int audio_cts;
>  	unsigned int audio_n;
>  	bool audio_enable;
> +	bool disable_hpd;
>  
>  	unsigned int reg_shift;
>  	struct regmap *regm;
> @@ -1559,7 +1560,7 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
>  enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
>  					       void *data)
>  {
> -	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
> +	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD || hdmi->disable_hpd ?
>  		connector_status_connected : connector_status_disconnected;
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_read_hpd);
> @@ -1585,6 +1586,10 @@ void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
>  	 * Configure the PHY RX SENSE and HPD interrupts polarities and clear
>  	 * any pending interrupt.
>  	 */
> +
> +	if (hdmi->disable_hpd)
> +		return;
> +
>  	hdmi_writeb(hdmi, HDMI_PHY_HPD | HDMI_PHY_RX_SENSE, HDMI_PHY_POL0);
>  	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
>  		    HDMI_IH_PHY_STAT0);
> @@ -3212,6 +3217,10 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  	mutex_init(&hdmi->cec_notifier_mutex);
>  	spin_lock_init(&hdmi->audio_lock);
>  
> +	if (of_property_read_bool(np, "disable-hpd")) {
> +		dev_info(hdmi->dev, "Disabling HPD\n");
> +		hdmi->disable_hpd = true;
> +	}
>  	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
>  	if (ddc_node) {
>  		hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);
> 

