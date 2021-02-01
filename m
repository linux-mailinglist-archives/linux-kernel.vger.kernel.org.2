Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1E30A9E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBAOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhBAOeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:34:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B4EC0613D6;
        Mon,  1 Feb 2021 06:33:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AA4531F44612
Subject: Re: [PATCH 6/6] platform/chrome: cros_ec_typec: Set opmode to PD on
 SOP connected
To:     Benson Leung <bleung@chromium.org>,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@google.com
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-7-bleung@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f2d01f56-b138-90b2-1983-7faafb973637@collabora.com>
Date:   Mon, 1 Feb 2021 15:33:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129061406.2680146-7-bleung@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

On 29/1/21 7:14, Benson Leung wrote:
> When SOP Discovery is done, set the opmode to PD if status indicates
> SOP is connected.
> 
> SOP connected indicates a PD contract is in place, and is a solid
> indication we have transitioned to PD power negotiation, either as
> source or sink.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 6bc6fafd54a4..a7778258d0a0 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -900,6 +900,9 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
>  		else
>  			typec->ports[port_num]->sop_disc_done = true;
> +
> +		if (resp.sop_connected)
> +			typec_set_pwr_opmode(typec->ports[port_num]->port, TYPEC_PWR_MODE_PD);
>  	}
>  
>  	if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
> 
