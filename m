Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A7A38783E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhERMBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhERMBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:01:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2351FC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w12so3055917edx.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+wvJ54BU7HaSAbDHZZnLTmKsrugDkKfADEFCDdDLU/g=;
        b=mtOD9U2P99BgcuWsxPUDFrQEzL0pBowgdqLXaBvKYyABsXslVn+qe/fvtJwkSrHoFm
         LInALbTUXbNuGMYnjiC0TzXqJ30QAMUkUXfz2duNpNSs4McPoOwIFKF3xeWvh57CaQIb
         zybI27mYxT2jkEG85Af0TUMuz3ucp/T1kF+PtMhUAAVtPJAwcmYszmQvA7Ol5CjkAe5p
         5O76t091zLvqSwLbcXG57kMBaqOjOum5Cqg5/oA79tqjm5+xikJr9IjbKD/86wXGlhmK
         VYffWtzVN/aFBePSStrU2JjqyPpVW3ima0WXGj8YGb+WXIUXKvUeK73GhMBjQIC/BXxv
         jSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+wvJ54BU7HaSAbDHZZnLTmKsrugDkKfADEFCDdDLU/g=;
        b=aMdWOjY3HaBTXgEa7ZfpDvrZqAoYwXVRT6YjrKMq+HPMT90rndy7HNjahkwXMF7cbz
         vnrjU/fMwZaKJHwficdy9jVmvFTI8cSfwS4adjHjpBZbHhQ3wlUHCfIB8Bti69C6okXb
         rTn7PkjFhJnti0cYaKeWczbJKpGhMEF9NYE42zmMSSqurv8m8xaRpGIpSunTFI5nJrCL
         NZFeJsm1t4V/L5bHz9nAbxCAD08doCzHc3YoB7YvphawNc2E4xEDfN9WOf+bJCce8+4w
         jj30OgnN9Lm1EWSbaWOW3E5vpxtQc2VHkOdiowUNBOz4BSeyqeRr8GiEibOVMs7Zl/1V
         /n4A==
X-Gm-Message-State: AOAM533lcjXkP36iUjD+ubUiSoUJSwKfwfrD56SrImOxFg+4yCbVDvsM
        a6xmpSlQwnmCYz0LXLfqQ/0=
X-Google-Smtp-Source: ABdhPJzpFvji9svJQtES6aQiuYBDhl0vur2iSXsIGdRJYnqtAdmLA3sfoMN6ZtQeY9qDTTT9cWuY0g==
X-Received: by 2002:a05:6402:13c3:: with SMTP id a3mr6723638edx.18.1621339229933;
        Tue, 18 May 2021 05:00:29 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:bee0:f4e2:68f9:3d11])
        by smtp.gmail.com with ESMTPSA id r25sm12786575edv.78.2021.05.18.05.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:00:29 -0700 (PDT)
Message-ID: <d4b936d1de6a1ad6d43fe9070ab5c712851eec52.camel@googlemail.com>
Subject: Re: [PATCH v2 2/2] regulator: fan53880: Convert to use .probe_new
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Date:   Tue, 18 May 2021 14:00:28 +0200
In-Reply-To: <20210517105325.1227393-2-axel.lin@ingics.com>
References: <20210517105325.1227393-1-axel.lin@ingics.com>
         <20210517105325.1227393-2-axel.lin@ingics.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-17 at 18:53 +0800, Axel Lin wrote:
> Use the new .probe_new for fan53880.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Christoph Fritz <chf.fritz@googlemail.com>

> ---
> v2: no change
>  drivers/regulator/fan53880.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
> index 1684faf82ed2..f3268b4d5066 100644
> --- a/drivers/regulator/fan53880.c
> +++ b/drivers/regulator/fan53880.c
> @@ -114,8 +114,7 @@ static const struct regmap_config fan53880_regmap = {
>  	.max_register = FAN53880_ENABLE_BOOST,
>  };
>  
> -static int fan53880_i2c_probe(struct i2c_client *i2c,
> -			     const struct i2c_device_id *id)
> +static int fan53880_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct regulator_config config = { };
>  	struct regulator_dev *rdev;
> @@ -177,7 +176,7 @@ static struct i2c_driver fan53880_regulator_driver =
> {
>  		.name = "fan53880",
>  		.of_match_table	= of_match_ptr(fan53880_dt_ids),
>  	},
> -	.probe = fan53880_i2c_probe,
> +	.probe_new = fan53880_i2c_probe,
>  	.id_table = fan53880_i2c_id,
>  };
>  module_i2c_driver(fan53880_regulator_driver);


