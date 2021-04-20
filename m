Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E687A3655D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhDTKBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhDTKBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:01:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3637EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 03:00:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5C1351F426F0
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec: Add Type C hard reset
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
References: <20210416182739.2938473-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <172e5982-5544-7170-4c88-95e196e28fac@collabora.com>
Date:   Tue, 20 Apr 2021 12:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210416182739.2938473-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 16/4/21 20:27, Prashant Malani wrote:
> Update the EC command header to include the new event bit. This bit
> is included in the latest version of the Chrome EC headers[1].
> 
> [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h
> 
> Change-Id: I52a36e725d945665814d4e59ddd1e76a3692db9f

Please remember to remove the ChromeOS specific tags and add properly the Signed-off

Thanks,
 Enric

> ---
> v2 is the first version the patch was introduced.
> 
>  include/linux/platform_data/cros_ec_commands.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 5ff8597ceabd..9156078c6fc6 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -5678,6 +5678,7 @@ enum tcpc_cc_polarity {
>  
>  #define PD_STATUS_EVENT_SOP_DISC_DONE		BIT(0)
>  #define PD_STATUS_EVENT_SOP_PRIME_DISC_DONE	BIT(1)
> +#define PD_STATUS_EVENT_HARD_RESET		BIT(2)
>  
>  struct ec_params_typec_status {
>  	uint8_t port;
> 
