Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A96418780
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhIZIki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 04:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhIZIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 04:40:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0525C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 01:39:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bx4so55353032edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FqZLHp6P5onDVzAVu1pnrTbH+41zot6j1xPu0nqk/aU=;
        b=qWszrahJmuxMdIv6Am1sSQgwKsHLYjmvSrd5tXh/U0y60WoCkaERe35A/GKooWTJ1a
         Fuo8wTKYwLAP80zpydWOx67sz0a3dv/LLAKd3GzOdm2qWjkjyX6mu0UfG0/H+krouamT
         ihGCjXPm9oZJ0Chr/ABaftLl+oqyJrRJTsKbwcDYG4qu5qniiQAvxNDueMiY3PyoL8UY
         mWYXUGYtqrNmKwabrmka0d7Jo3a6v7g+1mACK/8bAMjyg7Cfj6/uvD2S9vIVgPQBDxMz
         i42YNB1xx1gcFSa4SvPtWMvZ6nMylHbQdoNADG8eSkMWesmd5dViwFNlVc7YWOUvn0iT
         xbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FqZLHp6P5onDVzAVu1pnrTbH+41zot6j1xPu0nqk/aU=;
        b=uxEOKLyeB5kOmSAMNYY/Sq79OQglcLd2OL8MsapQcAkNR+3srZk1Y571OFr84EFT34
         AoWB+0GTPPA1rxYDPjZUUZyz1oXCv92W/v16A5LiHdN7SXEWq/FFFhTLxhG2S1Eu42eL
         a5J8u5tfp8LgWRLUxn5/jhbvzN/xaotM+hHOiox34R+LRf7LtBaZCZphJwKtgH7x0OgJ
         rHEPiFDrteuhfpt88wGBGxolpEal5LoYXTes4qnNcFeUsfHxUW0MdkbPMhBkgkrydzw2
         3PRtLSzYjouzzefbFNSouYx3SmTXMrch66wbpJqYxpA/ZS2uuYK35750CAtzTD9GKA/S
         tEBA==
X-Gm-Message-State: AOAM533CZauN4v+aZMapB12RxkNL0zhOaW/LVAw8Q5f2ye73hxhedFz8
        MSEdibm/q9UWthaaHKAT0mw=
X-Google-Smtp-Source: ABdhPJzOKRUq/oNsXGrP3Z2Ivtj4lQMcgm0FHDN+WVD9K0bUezqU67bKccsmQYofOU7HCWpX7VmJ/Q==
X-Received: by 2002:a17:906:1fc1:: with SMTP id e1mr20069380ejt.515.1632645540166;
        Sun, 26 Sep 2021 01:39:00 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-30-160.pool212171.interbusiness.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id dm8sm8502204edb.90.2021.09.26.01.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 01:38:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Estner <michaelestner@web.de>
Cc:     michaelestner@web.de, Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avoid crashing the kernel
Date:   Sun, 26 Sep 2021 10:38:57 +0200
Message-ID: <7598246.TGqz6ispmn@localhost.localdomain>
In-Reply-To: <20210925200433.8329-1-michaelestner@web.de>
References: <20210925200433.8329-1-michaelestner@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 25, 2021 10:04:30 PM CEST Michael Estner wrote:
> To avoid chrashing the kernel I use WARN_ON instead.

"[] I use WARN_ON instead". Instead of what? 

Changelogs must be self-contained. I had to look at the diff to complete that 
sentence in my mind.

Please don't ask reviewers to go back and forth commit messages and code in 
order to get the whole picture.

However, my suggestion is only about the formal aspects of proper patch 
construction. The actual top priority is to properly solve this problem using 
the tips provided by Greg K-H with his review.
Thanks,

Fabio

P.S.: "chrashing" => "crashing".

> 
> Signed-off-by: Michael Estner <michaelestner@web.de>
> ---
>  drivers/staging/most/i2c/i2c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/
i2c.c
> index 7042f10887bb..e1edd892f9fd 100644
> --- a/drivers/staging/most/i2c/i2c.c
> +++ b/drivers/staging/most/i2c/i2c.c
> @@ -68,7 +68,7 @@ static int configure_channel(struct most_interface 
*most_iface,
>  	struct hdm_i2c *dev = to_hdm(most_iface);
>  	unsigned int delay, pr;
> 
> -	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
> +	WARN_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);



