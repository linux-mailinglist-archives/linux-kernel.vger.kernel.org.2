Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF33DEA82
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhHCKKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhHCKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:10:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2105C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:09:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2B7751F42DA0
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Use existing feature
 check
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20210802184711.3872372-1-pmalani@chromium.org>
 <20210802184711.3872372-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <81610a2b-aa3f-f8d7-5214-e59a7ce839d6@collabora.com>
Date:   Tue, 3 Aug 2021 12:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802184711.3872372-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for your patch.

On 2/8/21 20:47, Prashant Malani wrote:
> Replace the cros_typec_feature_supported() function with the
> pre-existing cros_ec_check_features() function which does the same
> thing.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 33 +++++++++----------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 27c068c4c38d..f96af8aa31b5 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1054,24 +1054,6 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>  	return 0;
>  }
>  
> -/* Check the EC feature flags to see if TYPEC_* features are supported. */
> -static int cros_typec_feature_supported(struct cros_typec_data *typec, enum ec_feature_code feature)
> -{
> -	struct ec_response_get_features resp = {};
> -	int ret;
> -
> -	ret = cros_typec_ec_command(typec, 0, EC_CMD_GET_FEATURES, NULL, 0,
> -				    &resp, sizeof(resp));
> -	if (ret < 0) {
> -		dev_warn(typec->dev,
> -			 "Failed to get features, assuming typec feature=%d unsupported.\n",
> -			 feature);
> -		return 0;
> -	}
> -
> -	return resp.flags[feature / 32] & EC_FEATURE_MASK_1(feature);
> -}
> -
>  static void cros_typec_port_work(struct work_struct *work)
>  {
>  	struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
> @@ -1113,6 +1095,7 @@ MODULE_DEVICE_TABLE(of, cros_typec_of_match);
>  
>  static int cros_typec_probe(struct platform_device *pdev)
>  {
> +	struct cros_ec_dev *ec_dev = NULL;
>  	struct device *dev = &pdev->dev;
>  	struct cros_typec_data *typec;
>  	struct ec_response_usb_pd_ports resp;
> @@ -1132,10 +1115,16 @@ static int cros_typec_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	typec->typec_cmd_supported = !!cros_typec_feature_supported(typec,
> -					EC_FEATURE_TYPEC_CMD);
> -	typec->needs_mux_ack = !!cros_typec_feature_supported(typec,
> -					EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
> +	if (typec->ec->ec)

Is this check really needed. Can typec->ec->ec be NULL at this point?

> +		ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
> +
> +	if (ec_dev) {

and this?

> +		typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
> +		typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
> +							EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
> +	} else {

and this?

> +		dev_warn(dev, "Invalid cros_ec_dev pointer; feature flags not checked.\n");

Can't just be

		typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev,
EC_FEATURE_TYPEC_CMD);
		typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);

Thanks,
 Enric

> +	}
>  
>  	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
>  				    &resp, sizeof(resp));
> 
