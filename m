Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC98731990D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhBLEUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhBLEUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:20:16 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95040C061574;
        Thu, 11 Feb 2021 20:19:36 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id v193so8684486oie.8;
        Thu, 11 Feb 2021 20:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9uN/GgFQIhfPedUJ/Rbraz6Zu8z9JxT52WzP6m5Alr8=;
        b=gN7wTSXRIWDm29Rwsn9AzBpFY0JkEi+NLGsfkFTdj2Bubog2etw+eC1y1ArwQmE/Nz
         x9P6aa6xA+ZFdQ4Pnlk1fytCdvylRykoZ10Q7TOslWUEeNWOpBmnADSaKbt8SpwoPp0R
         BHLRJ4nhfKlGiL+uMWtzInmb0IV93pM1giSrcDMWy/lW4Lt0qsuts0BMw058ZophIGs8
         uxdn2f4NfrpRszrK/LJfpDewNZ3+8Y64XsfujXYY6L8xhSQGEhVoiEQ16LlS1QURtD4w
         mASZmO+e4POYMjkU9T1NViX3PHbzNjqCZ52NBw8xy4u7hW5APqVc8c5IC+idC55TYvFA
         620w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uN/GgFQIhfPedUJ/Rbraz6Zu8z9JxT52WzP6m5Alr8=;
        b=LCoj4kyMxdiMkeVPEbptzr9c9iK7lpPnt5BEnG+1EqyivUnnDZQLNgEVzlIJOdkzhZ
         niY+xALEJ8HoMOg921TenNTc/HpCfo0RLMenP62KKLAmcM7ugmgpyxPtbRmx+BR1KU+X
         XCQ6ambDy/5U1CWwN+yAFYzFjQGNfGSX064v5zhmQiJv45ayry5/gCAH957Dnq8dW9Zu
         Le2MbFrgA0Jx3E7Kx5Yh4Fqnl3eCrlg+rKfP6kVYPYerfFdOlbXzBtgbibe5UypM0PTa
         LkxRAd1Hd6vsyAhcbOg9578vGGMZDzBl4o3gRlQSmLbuysJ35JMZx8ZFincWkbSh253N
         /b5Q==
X-Gm-Message-State: AOAM530dM/bqAEQtnoZLaS0dCOhmG8dZ1aOTtCPOSozkdiNTZmIctUmj
        KnC0cRQ/l0MHwvL6bm98BII=
X-Google-Smtp-Source: ABdhPJxdxhhbHGa/P849VbwA2HGOq8tQ6IHswRPYcalc0ICvbzEIuEnQQ9g2K4fzEUhcdx0VYuhV0g==
X-Received: by 2002:aca:c545:: with SMTP id v66mr687179oif.116.1613103576071;
        Thu, 11 Feb 2021 20:19:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k32sm1468851otc.74.2021.02.11.20.19.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:19:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:19:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 5/7] usb: typec: displayport: Fill the negotiated SVDM
 Version in the header
Message-ID: <20210212041934.GE103223@roeck-us.net>
References: <20210205033415.3320439-1-kyletso@google.com>
 <20210205033415.3320439-6-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205033415.3320439-6-kyletso@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:34:13AM +0800, Kyle Tso wrote:
> VDM header now requires SVDM Version. Get it from typec_partner.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v5:
> - follow the changes of "usb: typec: Manage SVDM version"
> 
>  drivers/usb/typec/altmodes/displayport.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 0abc3121238f..b7f094435b00 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -15,8 +15,8 @@
>  #include <linux/usb/typec_dp.h>
>  #include "displayport.h"
>  
> -#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, SVDM_VER_1_0, cmd) | \
> -					 VDO_OPOS(USB_TYPEC_DP_MODE))
> +#define DP_HEADER(_dp, ver, cmd)	(VDO((_dp)->alt->svid, 1, ver, cmd)	\
> +					 | VDO_OPOS(USB_TYPEC_DP_MODE))
>  
>  enum {
>  	DP_CONF_USB,
> @@ -156,9 +156,14 @@ static int dp_altmode_configured(struct dp_altmode *dp)
>  
>  static int dp_altmode_configure_vdm(struct dp_altmode *dp, u32 conf)
>  {
> -	u32 header = DP_HEADER(dp, DP_CMD_CONFIGURE);
> +	int svdm_version = typec_altmode_get_svdm_version(dp->alt);
> +	u32 header;
>  	int ret;
>  
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	header = DP_HEADER(dp, svdm_version, DP_CMD_CONFIGURE);
>  	ret = typec_altmode_notify(dp->alt, TYPEC_STATE_SAFE, &dp->data);
>  	if (ret) {
>  		dev_err(&dp->alt->dev,
> @@ -181,6 +186,7 @@ static int dp_altmode_configure_vdm(struct dp_altmode *dp, u32 conf)
>  static void dp_altmode_work(struct work_struct *work)
>  {
>  	struct dp_altmode *dp = container_of(work, struct dp_altmode, work);
> +	int svdm_version;
>  	u32 header;
>  	u32 vdo;
>  	int ret;
> @@ -194,7 +200,10 @@ static void dp_altmode_work(struct work_struct *work)
>  			dev_err(&dp->alt->dev, "failed to enter mode\n");
>  		break;
>  	case DP_STATE_UPDATE:
> -		header = DP_HEADER(dp, DP_CMD_STATUS_UPDATE);
> +		svdm_version = typec_altmode_get_svdm_version(dp->alt);
> +		if (svdm_version < 0)
> +			break;
> +		header = DP_HEADER(dp, svdm_version, DP_CMD_STATUS_UPDATE);
>  		vdo = 1;
>  		ret = typec_altmode_vdm(dp->alt, header, &vdo, 2);
>  		if (ret)
> -- 
> 2.30.0.365.g02bc693789-goog
> 
