Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A590359411
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhDIEjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:39:49 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:60014 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229846AbhDIEjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:39:47 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A1F3A18221879;
        Fri,  9 Apr 2021 04:39:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 3C37B268E45;
        Fri,  9 Apr 2021 04:39:33 +0000 (UTC)
Message-ID: <b66def9aa9bd7a8984dc00d277d2dfb118f6d477.camel@perches.com>
Subject: Re: [PATCH v5 2/6] w1: ds2438: fixed if brackets coding style issue
From:   Joe Perches <joe@perches.com>
To:     Luiz Sampaio <sampaio.ime@gmail.com>, zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Thu, 08 Apr 2021 21:39:31 -0700
In-Reply-To: <20210409030942.441830-3-sampaio.ime@gmail.com>
References: <20210405105009.420924-1-sampaio.ime@gmail.com>
         <20210409030942.441830-1-sampaio.ime@gmail.com>
         <20210409030942.441830-3-sampaio.ime@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3C37B268E45
X-Spam-Status: No, score=1.60
X-Stat-Signature: nud8sg9bh3879zaw4tr8y6xixwbmfho7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/uwvjTT8jKiCt33j8es/sxZ2crVzP6XXQ=
X-HE-Tag: 1617943173-62169
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-09 at 00:09 -0300, Luiz Sampaio wrote:
> Since there is only one statement inside the if clause, no brackets are
> required.
> 
> Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
> ---
>  drivers/w1/slaves/w1_ds2438.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
> index 148921fb9702..56e53a748059 100644
> --- a/drivers/w1/slaves/w1_ds2438.c
> +++ b/drivers/w1/slaves/w1_ds2438.c
> @@ -287,9 +287,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
>  	if (!buf)
>  		return -EINVAL;
>  
> 
> -	if (w1_ds2438_get_current(sl, &voltage) == 0) {
> +	if (w1_ds2438_get_current(sl, &voltage) == 0)
>  		ret = snprintf(buf, count, "%i\n", voltage);
> -	} else
> +	else
>  		ret = -EIO;
>  
> 
>  	return ret;
> @@ -338,9 +338,9 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
>  	if (!buf)
>  		return -EINVAL;
>  
> 
> -	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
> +	if (w1_ds2438_get_temperature(sl, &temp) == 0)
>  		ret = snprintf(buf, count, "%i\n", temp);
> -	} else
> +	else
>  		ret = -EIO;
>  
> 
>  	return ret;
> @@ -359,9 +359,9 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
>  	if (!buf)
>  		return -EINVAL;
>  
> 
> -	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
> +	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0)
>  		ret = snprintf(buf, count, "%u\n", voltage);
> -	} else
> +	else
>  		ret = -EIO;
>  
> 
>  	return ret;
> @@ -380,9 +380,9 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
>  	if (!buf)
>  		return -EINVAL;
>  
> 
> -	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
> +	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0)
>  		ret = snprintf(buf, count, "%u\n", voltage);
> -	} else
> +	else
>  		ret = -EIO;
>  
> 
>  	return ret;


