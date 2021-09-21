Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6116F412EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhIUG3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhIUG3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:29:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA235C061575
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:28:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C629F1F430C8
Subject: Re: [PATCH] MAINTAINERS: Add Prashant's maintainership of cros_ec
 drivers
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com, mricon@kernel.org, pmalani@chromium.org
References: <20210920205402.3818320-1-bleung@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <49378918-f31c-2789-4ae0-164b2b2bf9f7@collabora.com>
Date:   Tue, 21 Sep 2021 08:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210920205402.3818320-1-bleung@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

This LGTM

On 20/9/21 22:54, Benson Leung wrote:
> Prashant maintains the cros_usbpd_notify driver as well as
> the cros_ec_type_c driver.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eeb4c70b3d5b..16573a2d2fe3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4429,6 +4429,17 @@ F:	drivers/power/supply/cros_usbpd-charger.c
>  N:	cros_ec
>  N:	cros-ec
>  
> +CHROMEOS EC USB TYPE-C DRIVER
> +M:	Prashant Malani <pmalani@chromium.org>
> +S:	Maintained
> +F:	drivers/platform/chrome/cros_ec_typec.c
> +
> +CHROMEOS EC USB PD NOTIFY DRIVER
> +M:	Prashant Malani <pmalani@chromium.org>
> +S:	Maintained
> +F:	drivers/platform/chrome/cros_usbpd_notify.c
> +F:	include/linux/platform_data/cros_usbpd_notify.h
> +
>  CHRONTEL CH7322 CEC DRIVER
>  M:	Jeff Chase <jnchase@google.com>
>  L:	linux-media@vger.kernel.org
> 
