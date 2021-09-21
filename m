Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696214132BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhIULnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:43:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45658 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbhIULnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:43:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5D9E91F41E17
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Fix check_features ret
 val
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20210916014632.2662612-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f6860aa6-b541-b03d-da8d-333661a8322f@collabora.com>
Date:   Tue, 21 Sep 2021 13:42:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210916014632.2662612-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the patch. Just one comment below ...

On 16/9/21 3:46, Prashant Malani wrote:
> The kerneldoc for cros_ec_check_features() states that it returns 1 or 0
> depedending on whether a feature is supported or not, but it instead
> returns a negative error number in one case, and a non-1 bitmask in
> other cases.
> 
> Since all call-sites only check for a 1 or 0 return value, update
> the function to return boolean values.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c     | 12 +++++++-----
>  include/linux/platform_data/cros_ec_proto.h |  2 +-
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index a7404d69b2d3..a34cf58c5ef7 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -808,9 +808,9 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
>   *
>   * Call this function to test whether the ChromeOS EC supports a feature.
>   *
> - * Return: 1 if supported, 0 if not
> + * Return: true if supported, false if not (or if an error was encountered).
>   */
> -int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> +bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  {
>  	struct cros_ec_command *msg;
>  	int ret;
> @@ -818,8 +818,10 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  	if (ec->features[0] == -1U && ec->features[1] == -1U) {
>  		/* features bitmap not read yet */
>  		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> -		if (!msg)
> -			return -ENOMEM;
> +		if (!msg) {
> +			dev_err(ec->dev, "failed to allocate memory to get EC features\n");

In case of failure you will be noticed by the allocator, prints after
[k|v][m|z|c]alloc() functions are not needed, so I think you can just return
false here.

Other than that the patch looks good to me.

Thanks,
  Enric

> +			return false;
> +		}
>  
>  		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
>  		msg->insize = sizeof(ec->features);
> @@ -839,7 +841,7 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  		kfree(msg);
>  	}
>  
> -	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> +	return !!(ec->features[feature / 32] & EC_FEATURE_MASK_0(feature));
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_check_features);
>  
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 02599687770c..55844ece0b32 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -227,7 +227,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
>  
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>  
> -int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
> +bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>  
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
>  
> 
