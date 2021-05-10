Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FC7379296
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhEJPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbhEJPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:24:45 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A647C04687F;
        Mon, 10 May 2021 08:01:41 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so4526956otq.7;
        Mon, 10 May 2021 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+2vJm0+t7a31PRFDHcfIF7VP311NP3+Ym/QwjWCm2Yc=;
        b=WpmMliAvlu+3qwJXqQ+vwXQX9vjB+lP8ZzF4PnqY3k4Fk8Gdr3Y4mERemHM88NN8Qp
         /z3c9ERU/j0aQbHKaIFE0sEkA3tUoLqzyyY26sHl56b2xIE9R6LUDSfEQ2pw5hT7FWuM
         LyBDulY85NzPgLRadN8spjCWJzQbWm++cHYBaMgGZ1sDQ3o5XGXoxBmfQWTpz3R8yi5G
         c555bVlVf86RD99rs2kK0wi8hm7GfoorFo6kc0ryC/BTcAFPTLnUxb7qkV0vIFBqQcI6
         Mg2dQydvckh4U2yeLyC/5xMPYhZJmkpWKJ+JPNgPXT7Wcy28FfXRgTqHJ83kdXc5FXUx
         znUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+2vJm0+t7a31PRFDHcfIF7VP311NP3+Ym/QwjWCm2Yc=;
        b=ZfE4q3t7WaTfMl5uuLGVT9ASERi8hP9r+NAL5zCYHLqJbgISjKQHwT4EP03NlxQQL3
         VRoOdpSXw7RDklRQP29NMDHPaZn8nvnf42v/n7DCzmMlJk0jdZCUKc23wotnKIuk2NP+
         lkncDwtP/aJpBlA3Dt17YS2SKzagqqZOEpokp92WVNwmRMGz/tBTnE1ZONX16ECqL7xo
         DDY/18EwZG4QOKs56Ing4Rm7F+JCDaBeJ9T+fCxi92InNGwDFUKcFxBTOaLNgiAKtN9u
         o+wfnx2ARXfAb7zRlmeM2AyEE28k9HP6UTEuivnxjNOmONia7B9fgqN330SzlUa4xCs/
         eT6w==
X-Gm-Message-State: AOAM531jUl0R7g2xjp+RpzJmNA8izsb3dJxScxGPC1dLZbgXSG3TP+/g
        /EznnUZqIDpRoOmKuQt7UHmcJcdS2ak=
X-Google-Smtp-Source: ABdhPJyIzNcAy+uot31+3fo7smy7kko27PTAIR79dFdQbydMhoWXuh4SqQD6rPDn1/Og7h52e22HZA==
X-Received: by 2002:a9d:4046:: with SMTP id o6mr8972647oti.189.1620658900620;
        Mon, 10 May 2021 08:01:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k21sm797344otr.3.2021.05.10.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:01:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 May 2021 08:01:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrej Picej <andpicej@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (lm70) Use SPI_MODE_X_MASK
Message-ID: <20210510150139.GA1960244@roeck-us.net>
References: <20210510141331.56736-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510141331.56736-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:13:31PM +0300, Andy Shevchenko wrote:
> Use SPI_MODE_X_MASK instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/lm70.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index 40eab3349904..cdf23a59a203 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -184,7 +184,7 @@ static int lm70_probe(struct spi_device *spi)
>  
>  
>  	/* signaling is SPI_MODE_0 */
> -	if (spi->mode & (SPI_CPOL | SPI_CPHA))
> +	if ((spi->mode & SPI_MODE_X_MASK) != SPI_MODE_0)
>  		return -EINVAL;
>  
>  	/* NOTE:  we assume 8-bit words, and convert to 16 bits manually */
