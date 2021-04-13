Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE9D35E422
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbhDMQha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:37:30 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:38776 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346297AbhDMQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:37:25 -0400
Received: by mail-oi1-f178.google.com with SMTP id b3so2813980oie.5;
        Tue, 13 Apr 2021 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l/gtMIE5aDSizPojDSpaMRMi6Yn99u3auh6+rCvsUmc=;
        b=OQyGyidP9XO8oP6P2lynOf0eY8j9Gx3tfzmCHBADsEdo9oG8oVNrxjfZdpqQhTKtB3
         dLvwUm5+iQ4iiP1uTw8oIKNmc4w2bcFIP+OLOZ9+vkZOtO5mcIE/uJ7aN6CqGFswC7OX
         oVsVuGbZKqEbHl6ODSkBsQmLbJ2Mc6xp+jjK3O7TchlyBCI2Dl0w4tfHi+XBuVQs5M1w
         uaNPsyXBqrPChSdYYif+7+ZCJ5e+vn7bEnOmDxZSUjAYQBaGHI62QOSHlEx5+nLxEAGy
         Bh0F62n8fAZizP6loiaGcUCt/WXho83XXHZi4QbhTxy+vS3QOCqegpPbWa1BhlWbfWnM
         VvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l/gtMIE5aDSizPojDSpaMRMi6Yn99u3auh6+rCvsUmc=;
        b=lt5dOeQ4V1L02jSXYnzP3XMRQB4GYCzp7ipfS9IokUMFdw5DCayelz85kxLr9C3fvP
         CLJ+khpOL7DMnqJZU0tj1CcReJSoK4hvXGQgQIzNuWRViySJodj+AeOX+l3F0cRzpJAk
         0pMV/FUiL/N+aU+9aMsRhkyA55Dg3Q2S02//36ej4ZBgKzbsz/fG1A8IY8tBgXmtSbFK
         Y6LY6hhffwC6s04V11JfyprUp5Iz/kvYVTQZ0cslylhRjA3lk5zCl/A+QLM5JTZ6+R0F
         2mxhuU8PSOcLnEloXzE9pMRk90bk+A/H+0zU5G7C0SKqgkHqF9d+7TrVjysy45Z/oGFB
         we4Q==
X-Gm-Message-State: AOAM5315gFvNSbHE0e2w8/AVQtDLeWRskRV4GJ/ogb9bh/8PBGVay4d3
        V4+/WbrYXvf/ZrP5jaggbQVtAc2b8+U=
X-Google-Smtp-Source: ABdhPJzyC1BeNd9Xj9nXxzy06KnTonvIwh6w57JmiafSfsegT35ymWEDfAp05khFuf0f6FDm6WDOXg==
X-Received: by 2002:a05:6808:f8c:: with SMTP id o12mr563254oiw.137.1618331762234;
        Tue, 13 Apr 2021 09:36:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j26sm232604ooe.32.2021.04.13.09.36.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Apr 2021 09:36:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Apr 2021 09:35:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6683) remove useless function
Message-ID: <20210413163559.GA91705@roeck-us.net>
References: <1618293770-55307-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618293770-55307-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:02:50PM +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> drivers/hwmon/nct6683.c:491:19: warning: unused function 'in_to_reg'
> [-Wunused-function].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6683.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
> index a23047a..b886cf0 100644
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -488,17 +488,6 @@ static inline long in_from_reg(u16 reg, u8 src)
>  	return reg * scale;
>  }
>  
> -static inline u16 in_to_reg(u32 val, u8 src)
> -{
> -	int scale = 16;
> -
> -	if (src == MON_SRC_VCC || src == MON_SRC_VSB || src == MON_SRC_AVSB ||
> -	    src == MON_SRC_VBAT)
> -		scale <<= 1;
> -
> -	return clamp_val(DIV_ROUND_CLOSEST(val, scale), 0, 127);
> -}
> -
>  static u16 nct6683_read(struct nct6683_data *data, u16 reg)
>  {
>  	int res;
