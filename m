Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BDD37F26A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhEMEuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 00:50:08 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:33110 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230362AbhEMEtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 00:49:51 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9CEC4BA02;
        Thu, 13 May 2021 04:48:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 1CAF7315D73;
        Thu, 13 May 2021 04:48:39 +0000 (UTC)
Message-ID: <f2e616645f311ccaf6e0acb996f8c4360a0480ec.camel@perches.com>
Subject: Re: [PATCH] watchdog: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
From:   Joe Perches <joe@perches.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        wim@linux-watchdog.org, linux@roeck-us.net, joel@jms.id.au,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     andrew@aj.id.au, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Date:   Wed, 12 May 2021 21:48:37 -0700
In-Reply-To: <20210511061812.480172-1-juergh@canonical.com>
References: <20210511061812.480172-1-juergh@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.04
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1CAF7315D73
X-Stat-Signature: 6kzj9cfeptqsg315pdhjnu5ex5kpbywt
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/YmSWARqT1SSQJOYqo5pk6qOvYyh48NP4=
X-HE-Tag: 1620881318-714369
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-11 at 08:18 +0200, Juerg Haefliger wrote:
> Convert sprintf() in sysfs "show" functions to sysfs_emit() and
> sysfs_emit_at() in order to check for buffer overruns in sysfs outputs.
[]
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
[]
> @@ -445,8 +445,9 @@ static ssize_t ziirave_wdt_sysfs_show_firm(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> 
> -	ret = sprintf(buf, ZIIRAVE_FW_VERSION_FMT, w_priv->firmware_rev.major,
> -		      w_priv->firmware_rev.minor);
> +	ret = sysfs_emit(buf, ZIIRAVE_FW_VERSION_FMT,
> +			 w_priv->firmware_rev.major,
> +			 w_priv->firmware_rev.minor);
>  
> 
>  	mutex_unlock(&w_priv->sysfs_mutex);
>  
> 
> @@ -468,8 +469,9 @@ static ssize_t ziirave_wdt_sysfs_show_boot(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> 
> -	ret = sprintf(buf, ZIIRAVE_BL_VERSION_FMT, w_priv->bootloader_rev.major,
> -		      w_priv->bootloader_rev.minor);
> +	ret = sysfs_emit(buf, ZIIRAVE_BL_VERSION_FMT,
> +			 w_priv->bootloader_rev.major,
> +			 w_priv->bootloader_rev.minor);
>  
> 
>  	mutex_unlock(&w_priv->sysfs_mutex);
>  
> 
> @@ -491,7 +493,7 @@ static ssize_t ziirave_wdt_sysfs_show_reason(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> 
> -	ret = sprintf(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
> +	ret = sysfs_emit(buf, "%s", ziirave_reasons[w_priv->reset_reason]);

All of these formats should probably end with a newline
and the ZIIRAVE_<FOO>_VERSION_FMT defines are to me unnecessary.

