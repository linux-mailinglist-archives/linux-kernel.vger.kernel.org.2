Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CFC41144C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhITMYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbhITMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:24:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521DDC061760
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:22:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q11so29102270wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tCMyAI4JO6VKkU7AmoNIAzglb9xaZgl9kmlNL3VEvL4=;
        b=JZQ2+zI+W0SL7cwiKWYbsuiuWplyCzFrYondKJhbn30f0ST4w3KQPKCOEdfN2X7qL/
         e4Hf5Vp6LoppSpnYVor+/hGghyQHmG3ZsUR/ZkmnRXReGgnd/kbYeYCMGt1miVcU5f3G
         eNrhTmqpmBt7jczLwm/DagTdp961iGwu1mGwr07e26mO2nxiv9gSoHKsqNmjtJHR0HcX
         hI7cPlwBB2bo6KeAzNOUNVycXeEL2/Q1YCKti0uiy/CKnOWe/u0dsztQYYvqJgGdIRbD
         CvhkmLu1/MZ9EDXANpLWWBXiXKRFLqRL7fo7MybclREbWmfjsU5fKJc/MxS7ek7iq0wc
         7WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tCMyAI4JO6VKkU7AmoNIAzglb9xaZgl9kmlNL3VEvL4=;
        b=QtS/Cfm5A3el8HeHpvbKVFOt2aoXW+y/j6buRZMaf2xF3O8Srg0FMdgH3AOUxDZ5lK
         0k1BiB8pzZhbwT7f+5f/mQjacqjH5xAKpKBLK38w9++Lpf4Zrqe8ieYnUQaW8vOa46AO
         S6pSPva3vY4twy2s5gPb00rggDlWOb0GB0gyEoU/SOKUFoYJToOIiuquHvWwe0chR4WE
         GhSr6cu+DOWp6t0sISICjg2+cx8+9vc2DkGdtFSSp86K/8OpY8nlmu7v22he31/tNvbl
         kVMVLQvoD4IH0+iWnfx6gizmkczbh7YtpBA8ZKhJUHqVb1+OdWgkFP3E493rcM8MjooG
         IE2g==
X-Gm-Message-State: AOAM533T3nOlVb1E6uQgZ9P05htHkdDw0QjNy/uS5bFn8Lz3acI8e3lT
        7psQ4zmxwxnV0Jiu3nn7LamngZQycDJaD4oX
X-Google-Smtp-Source: ABdhPJwghoiUF31ZcV1Our+qvNK3DzJ3CUzQX74ij+vo4OEmaDXRO6ym4AzRjtnXIVr8AS5Bn9Zzhw==
X-Received: by 2002:a05:600c:17d1:: with SMTP id y17mr29272700wmo.135.1632140561722;
        Mon, 20 Sep 2021 05:22:41 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:aa8a:ef22:59c5:1bf3? ([2001:861:44c0:66c0:aa8a:ef22:59c5:1bf3])
        by smtp.gmail.com with ESMTPSA id a72sm19889422wme.5.2021.09.20.05.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:22:41 -0700 (PDT)
Subject: Re: [PATCH 2/9] firmware: meson: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
 <20210920090522.23784-3-wsa+renesas@sang-engineering.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ad855cb8-0ed4-4e42-7434-2073855249fa@baylibre.com>
Date:   Mon, 20 Sep 2021 14:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920090522.23784-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 11:05, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/firmware/meson/meson_sm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 77aa5c6398aa..714016e3aab3 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -240,12 +240,11 @@ EXPORT_SYMBOL_GPL(meson_sm_get);
>  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
>  	struct meson_sm_firmware *fw;
>  	uint8_t *id_buf;
>  	int ret;
>  
> -	fw = platform_get_drvdata(pdev);
> +	fw = dev_get_drvdata(dev);
>  
>  	id_buf = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
>  	if (!id_buf)
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
