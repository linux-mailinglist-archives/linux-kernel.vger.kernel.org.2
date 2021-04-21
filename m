Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0930A3670DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244572AbhDURET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244592AbhDUREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:04:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:03:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m12so9757995pgr.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1qqg5JsS9oq/8h7Zs6Mu/mei19Ti6bAmfD5fULLF4bo=;
        b=d0wqTZdzwxRw9cTHUUvBJvX+tVmrd5i6gRNi4rkBXxrj8VYQEQ+d1u5amZs0vykbVw
         sR9Lh7O2RAgpYLVXhDavKjEXceXYh4UglH8rMp03VAd7EbRt6V2laef9Q9JuXSh+nR2C
         RdaGIWqLNo77FLHUeRQpYDUQr2t9kkZasTsrORrRUhrvUrDQx0jf2A4+cyTE3QmPWKRH
         l80Rcc/Mfts7R3KUwon9OJD0lK9aKneswcLzqKcAHaVD/T01xg1g0PIPcXMAz1Uuq4gA
         SmLsfN1b7sYO7ilEFPYNDNMGcZvOy6OkkzGfMb7yFEtVuCWWPFvzaB9SuI2sD2VlnU7b
         XYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1qqg5JsS9oq/8h7Zs6Mu/mei19Ti6bAmfD5fULLF4bo=;
        b=UxVNOepQ59kbchUYdeG7aQ3071c3JHMSfDoPcy94AQelzkkcotpEUK/DuOfGuz/QLp
         xIJ1pXtJiSX3MtrMzdvwArtzDBmmBH2yfg9quZE1G5b0Nh8SL9S/ptNV41FJOdFMlkwd
         aVl7qSgURzOoGl9f8HtBLeowjUfReAdvdarZkRYDP+hIm+lEh+bVKv5stRk7NwA0ZSvJ
         JJuglOTh4ZTsIXAQpHM+oWfk4+hD5q93qCU3QhWGONYjuOSQadDph4gP7ZbBQVfxVA31
         iLl46EmLeUPrM747+tVhpq6Hhr5d1qDfGnAPW6Fanz0xE8zWItpvBUHgkwapJ+HkTcaL
         JpBA==
X-Gm-Message-State: AOAM533cojXEGeX8NQvnl+I7P/NQm4B5uZnyOWGhAW56MfyOpR8hoqH0
        b79cY4KMEzZrz6VFfX7pMm0=
X-Google-Smtp-Source: ABdhPJypFXyyofjvgT9jDkBVlH2vQ5rgil6IngxHJ9XLgsksmgMy/JyFvmsKEvoogOt20OVeqQYrDw==
X-Received: by 2002:a63:c60a:: with SMTP id w10mr22352907pgg.421.1619024616990;
        Wed, 21 Apr 2021 10:03:36 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:684d:4367:6ee3:8019])
        by smtp.gmail.com with ESMTPSA id e9sm18836pgk.69.2021.04.21.10.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:03:35 -0700 (PDT)
Date:   Wed, 21 Apr 2021 10:03:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 157/190] Revert "Input: ad7879 - add check for read
 errors in interrupt"
Message-ID: <YIBa5X+5g/qNL+N8@google.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-158-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-158-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Apr 21, 2021 at 03:00:32PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit e85bb0beb6498c0dffe18a2f1f16d575bc175c32.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.

This one looks really OK to me and does not have to be reverted (unless
Aditya will come clean and show the error introduced?).

> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/input/touchscreen/ad7879.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index e850853328f1..8c4f3c193550 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -245,14 +245,11 @@ static void ad7879_timer(struct timer_list *t)
>  static irqreturn_t ad7879_irq(int irq, void *handle)
>  {
>  	struct ad7879 *ts = handle;
> -	int error;
>  
> -	error = regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
> -				 ts->conversion_data, AD7879_NR_SENSE);
> -	if (error)
> -		dev_err_ratelimited(ts->dev, "failed to read %#02x: %d\n",
> -				    AD7879_REG_XPLUS, error);
> -	else if (!ad7879_report(ts))
> +	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
> +			 ts->conversion_data, AD7879_NR_SENSE);
> +
> +	if (!ad7879_report(ts))
>  		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
>  
>  	return IRQ_HANDLED;
> -- 
> 2.31.1
> 

Thanks.

-- 
Dmitry
