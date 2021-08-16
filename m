Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8898C3ED46C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhHPNAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhHPNAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:00:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B1C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:59:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bt14so15802498ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5uIXz2XwcikVYRQRK52KMA+VCLoXzka5XfwEtISp/M=;
        b=GJ3L2NH27/dAvkZV6A5+K504tWxrUGqV5s7zAnFXMZjVUO0FDrUnUf3LCxnRWFUd/n
         DhB9xWZKlU6fcaF48eIFxUM5AKeBMug339+Wn7FmshdLI0S5iKsaj1tutyYrAutaBYTc
         J7t74Ji7f/81u3DkVckf0J0EJU5zUjYVxakzO43BEzAE3sBmnyUk21WDnliEQVytacwo
         +l6Ig8L6EwpO1709Zzigmwv7RQ8GcX1eYf1EzsdZY/RnbkzFFzCsS+dTxmTmTy32bFla
         JsJDbUtlSRVOcXYdVY9AUZvTl84VQixATzugsa4QTJK/0K7hqoBazQxavwfDUCHuSrtC
         v99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5uIXz2XwcikVYRQRK52KMA+VCLoXzka5XfwEtISp/M=;
        b=bDhbJQaxGw4iKIme82/y/pI/3R7Iwfept5GYAfeGWIzXtmJOcun2naZ9NdW7CyCWV0
         KxYUfwEEYkR7FDQMBbH6XpjUsNhrJP38cOFfqNMWa+Dffi4HAaz2L9puzTWp7FMOP4HJ
         1zv6xa0eEnBzh59//ISE4ItMGEu19utOKSgltzChChHZIq30SOZNYbkhVYyP71CrclnM
         Cdk9zG6HAE4wqMNSmzZTehHBKIk2UtFp0oYJsdPnyS+GQbOS7GZPF0o++AS6VfjlGNDF
         RVz+C2Y+S29Hz+ullG2b7VLLm5vL+xmLPStpMrt5rJFH8nGn4velAVnEtClZDwicJHEE
         vTXQ==
X-Gm-Message-State: AOAM532DXdRaSLSrF3MHmRQcCGiaY0uifOe7nNHJ01nZRa2IS2xOmVKM
        RvOGt8Caj9qZVPRzvBGFrhg=
X-Google-Smtp-Source: ABdhPJyi4cfLr8DIlO5bhLbKfRk8kxFUUe5CZbOmV6p/pFSTv0v8Klbhj4Bylf3qfAPOJrGKUFqA6g==
X-Received: by 2002:a17:906:6847:: with SMTP id a7mr7525988ejs.288.1629118779976;
        Mon, 16 Aug 2021 05:59:39 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id l16sm3682542eje.67.2021.08.16.05.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:59:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: r8188eu: refactor rtw_is_cckrates_included()
Date:   Mon, 16 Aug 2021 14:59:37 +0200
Message-ID: <22319347.s0ZA6q4zN9@localhost.localdomain>
In-Reply-To: <20210816115430.28264-1-straube.linux@gmail.com>
References: <20210816115430.28264-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 1:54:27 PM CEST Michael Straube wrote:
> Refactor function rtw_is_cckrates_included(). Improves readability
> and slightly reduces object file size.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v1 -> v2
> Refactored to more compact code as suggested by Joe Perches.
> 
>  drivers/staging/r8188eu/core/rtw_ieee80211.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Thanks for redoing the series as suggested by Joe Perches.
This is a perfect case where conciseness and readability don't clash and 
instead the former enhances the latter. 

Nice work, although you chose to not take Joe's suggestion about making a 
helper inline function. That would have been perfect, but I think it is a 
minor issue. So...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Regards,

Fabio

P.S.: If I were you, I'd have provided a cover letter that would have helped 
the readers to immediately understand the purpose of the entire series. I'm 
not sure whether or not the above-mentioned cover is a strict requirement.

> diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c
> b/drivers/staging/r8188eu/core/rtw_ieee80211.c index 0c7231cefdda..
964255a8c778 100644
> --- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
> +++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> @@ -70,14 +70,13 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
> 
>  uint	rtw_is_cckrates_included(u8 *rate)
>  {
> -	u32	i = 0;
> +	u8 r;
> 
> -	while (rate[i] != 0) {
> -		if  ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) 
== 4) ||
> -		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) 
== 22))
> +	while ((r = *rate++ & 0x7f)) {
> +		if (r == 2 || r == 4 || r == 11 || r == 22)
>  			return true;
> -		i++;
>  	}
> +
>  	return false;
>  }




