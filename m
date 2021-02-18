Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACED31EB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhBRPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:14:07 -0500
Received: from smtp107.iad3a.emailsrvr.com ([173.203.187.107]:55318 "EHLO
        smtp107.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232420AbhBRM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1613643185;
        bh=m8t/XvYW9G95yu9XimEdQKxasSEtsFIC/kxyuxGznXQ=;
        h=Subject:To:From:Date:From;
        b=yA6Z0QaT4Ycd/kgyfT6p/CRzVhqj+XQlFw/KcCy8Rv4VEoufamI5JAaBYjYlShTd+
         m3WGGaCUINsdB/RxQN8mR3sGCBtdqyFrL//CM178XYRYvSZPLfRNYxMi3ixwbZ9auN
         GIfQl1dRBA+9+DyeKv2livU6AHcScfGGC6qBEMFI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1613643185;
        bh=m8t/XvYW9G95yu9XimEdQKxasSEtsFIC/kxyuxGznXQ=;
        h=Subject:To:From:Date:From;
        b=EaDRJM9YUnPRxXAlMwcJ+Q/sy4Z6YrgcX+hS6Va3bRlf8DGNKiQwJnpHne+0VxRx8
         JhcKzWlIXGnvif/45YEpqcLM+4rsmvbXxkAuvjWHuyKaXVHZ1JNCXuLufgFxwlaZ+B
         m9MLRLgx4R/Cc7zKtZes/7kUYWcUg9sjCp+YTTdo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp22.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id F1CB8195C;
        Thu, 18 Feb 2021 05:13:04 -0500 (EST)
Subject: Re: [PATCH] drivers: staging: comedi: Fixed side effects from macro
 definition.
To:     chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ethan Edwards <ethancarteredwards@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210217142008.29699-1-chakravarthikulkarni2021@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <3c1ddf91-da6c-5620-61e7-1ec453b2aa93@mev.co.uk>
Date:   Thu, 18 Feb 2021 10:13:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210217142008.29699-1-chakravarthikulkarni2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: d7105027-4594-4034-967a-e94a4fffd174-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2021 14:20, chakravarthikulkarni wrote:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
> ---
>   drivers/staging/comedi/comedi.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
> index b5d00a006dbb..b2af6a88d389 100644
> --- a/drivers/staging/comedi/comedi.h
> +++ b/drivers/staging/comedi/comedi.h
> @@ -1103,9 +1103,12 @@ enum ni_common_signal_names {
>   
>   /* *** END GLOBALLY-NAMED NI TERMINALS/SIGNALS *** */
>   
> -#define NI_USUAL_PFI_SELECT(x)	(((x) < 10) ? (0x1 + (x)) : (0xb + (x)))
> -#define NI_USUAL_RTSI_SELECT(x)	(((x) < 7) ? (0xb + (x)) : 0x1b)
> -
> +#define NI_USUAL_PFI_SELECT(x) \
> +	({ typeof(x) _x = x; \
> +	 (((_x) < 10) ? (0x1 + (_x)) : (0xb + (_x))); })
> +#define NI_USUAL_RTSI_SELECT(x)	\
> +	({ typeof(x) _x = x; \
> +	 (((_x) < 7) ? (0xb + (_x)) : 0x1b); })
>   /*
>    * mode bits for NI general-purpose counters, set with
>    * INSN_CONFIG_SET_COUNTER_MODE
> 

I'd rather not do that because this is intended to be a userspace 
header.  This change adds GCC extensions and prohibits the use of the 
macros in constant expressions.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
