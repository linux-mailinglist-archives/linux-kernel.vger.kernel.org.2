Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A8420613
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhJDGze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhJDGzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:55:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50154C061745
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 23:53:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pg10so10399938pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MDRfZ7xXIFtmRSvzU6mcij8bUIp/DMbOkHB0+A48Ad0=;
        b=aVv1Kf9yUsOLpaX87dcD5Hin5Rdq499h1qqUIRSr/PAEdjgI+EGm/gMAauojeSMgcQ
         yfX89YvW3HZRf/Ist/jfzY7LERsm1HXeycB1KP6p6hzCRMIbdnIxpFipOwJ5F9B22iMR
         UzzBY353l9qcXYV5gXweu5c/3f5jettCiFESex/14cEifMV4O4W4xbc+E7fHcNUmBrnb
         CMFMbYMJVHFXzFMEbVmRGY0ZekRy8bwArU9eR6rT4+R7YZ6HpVkFqkYgIE46UkyKPwKu
         CZ8dZaZv1ms1/JYvChItjCJt5mEl1HB3d55ZYF9czjQIrxE8QvVPKCumJEWyEH2sNBci
         R/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MDRfZ7xXIFtmRSvzU6mcij8bUIp/DMbOkHB0+A48Ad0=;
        b=XKdx4EZRDxHb4zWNUZLHr0+Slo45zGblZMS/Sz+gZe49qkOS3tl5oa/kCsNLeugpDo
         SiRL6I8I2PwdZ8GSuq3QFD7Z/tam7AJlJ83OUkiL0DYRaojly7QZSyW6pxocYIgrifB5
         H+TtrKLXKL4qjVY/kYxb2DGYI8MLpiCaGEdmkJs++z1x/6iaTZxALGT66ajjh+4Ei86z
         kNXP2xXdE5x0hUAg90dZos5tOdaCh2x2tk7jQ8I6ze+7ohu4KW9OlV9eetjIG45uqFd9
         BQ0ediIHpqvWNrT8dV316p/bBIGBabTCh5KUxAGOuJJleomNGfk+MTLvb6MKjC1YMd5P
         enXA==
X-Gm-Message-State: AOAM532RBmz83R9MSW3HTqM2V9K9ydke6dh8s41P9O9IEvh935Z+9DSj
        lXFtDg8yxgP0PlttSPXUoVfOYw==
X-Google-Smtp-Source: ABdhPJyqxEEbmmpXYWNr/esn1IX5Ja1t4KSBy0rO92HYhf96C/jbB6vvPA9fI+fWpwKi28uTcPNUMw==
X-Received: by 2002:a17:90b:4b4c:: with SMTP id mi12mr6079865pjb.57.1633330423788;
        Sun, 03 Oct 2021 23:53:43 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id o72sm9399259pjo.50.2021.10.03.23.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:53:43 -0700 (PDT)
Date:   Mon, 4 Oct 2021 12:23:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] opp: Fix required-opps phandle array count check
Message-ID: <20211004065341.yuysdtwvbfypazue@vireshk-i7>
References: <1632996548-11647-1-git-send-email-pkondeti@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632996548-11647-1-git-send-email-pkondeti@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-09-21, 15:39, Pavankumar Kondeti wrote:
> The 'required-opps' property is optional. So of_count_phandle_with_args()
> can return -ENOENT when queried for required-opps. Handle this case.
> 
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
>  drivers/opp/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 2a97c65..5437085 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -170,7 +170,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  	}
>  
>  	count = of_count_phandle_with_args(np, "required-opps", NULL);
> -	if (!count)
> +	if (count <= 0)
>  		goto put_np;
>  
>  	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),

Applied. Thanks.

-- 
viresh
