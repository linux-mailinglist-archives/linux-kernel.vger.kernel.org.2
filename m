Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40739A54C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFCQIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:08:21 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:36436 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFCQIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:08:20 -0400
Received: by mail-qk1-f172.google.com with SMTP id i68so2859255qke.3;
        Thu, 03 Jun 2021 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=txSLEZ3LWB2jIP8GzWe1AjRD5to95FBD5hpn/LCQK04=;
        b=lMpo58oFV+3bVYwWPZXQTPuHacJ2CaLzBoX2pmwRFphRqO1bJ+tV/2TwZXegjqpjGs
         fQv31J+fuiTBtUkwo7odXhBXHljfhbcwDX2i3f0Ff9R9s8ljeUHP+OLxfAcT/Vq4z7xM
         Di6eX7KjunGFxGymiwMMYUy7j/qMVi7e561n8E+G9CXZbVJZKes9G7dYwYqWAPxa++q9
         g6sxZqY39AD28CU7HytMAAKP2tUaA/4OUSSsA3dnYL0/HlNVngoMDimcvCWWCz5+RXkf
         cXZHCD2w6w+/2jWYZxflIGbxiitt52SzycKMZ7ew/bBNAGBntVDK0sCWPmsQ7slHNdnF
         NHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=txSLEZ3LWB2jIP8GzWe1AjRD5to95FBD5hpn/LCQK04=;
        b=gzDmv9FGzcWRiSTMlZ9kZV/rSCj/CSK6htPh29uysgjT4wk8TQzhuzLAMC0Te1yBhN
         qm2oT9FY+pWaD4CS75/a/LlX4br60+mfvgDbw++iy2nvCcH0ULBC4+dkbT1TE1Ph6OuB
         rciZppN0fEas5EfjZ0718cp4OqaQxR8OtZ78aKNP9tbfQEUtk4gHJafw2ERIuXpF7LD1
         Sppz+LSErxM6z1Bu9w9UHs5B/ZfWsA+X702fm3SR4aGWskYdLidWYc6AE4hBdhjGFHOu
         MAygb4RQP7B8/jXwTXtIxzijQh7aQRgUrbQuJC55MRo96uH7ulkKa+rErMW8Z2h4I+44
         CJDA==
X-Gm-Message-State: AOAM530CV7ilHETqcYlL7eihBZJ9ymbLwRNhF6fLrGPTDDeXdU1aBR31
        44xPd6jq2MyadqL187Vc8+o=
X-Google-Smtp-Source: ABdhPJynoj110y+9+Crljj9njKr3b1ZU9CD/Z/ZLxgtU2qlpMHYz9uH7a+TJR7qulR48UfyV9T1Ijg==
X-Received: by 2002:a05:620a:14b5:: with SMTP id x21mr330423qkj.336.1622736335423;
        Thu, 03 Jun 2021 09:05:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3sm374231qth.87.2021.06.03.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 09:05:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Jun 2021 09:05:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: fix suspend behavior
Message-ID: <20210603160533.GA3952041@roeck-us.net>
References: <YLjCJiVtu5zgTabI@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLjCJiVtu5zgTabI@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 11:51:02AM +0000, Wilken Gottwalt wrote:
> During standby some PSUs turn off the microcontroller. A re-init is
> required during resume or the microcontroller stays unresponsive.
> 
> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
>   - corrected fixes commit
> ---
>  drivers/hwmon/corsair-psu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 02298b86b57b..731d5117f9f1 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -771,6 +771,16 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report *repo
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int corsairpsu_resume(struct hid_device *hdev)
> +{
> +	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
> +
> +	/* some PSUs turn off the microcontroller during standby, so a reinit is required */
> +	return corsairpsu_init(priv);
> +}
> +#endif
> +
>  static const struct hid_device_id corsairpsu_idtable[] = {
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> @@ -793,6 +803,10 @@ static struct hid_driver corsairpsu_driver = {
>  	.probe		= corsairpsu_probe,
>  	.remove		= corsairpsu_remove,
>  	.raw_event	= corsairpsu_raw_event,
> +#ifdef CONFIG_PM
> +	.resume		= corsairpsu_resume,
> +	.reset_resume	= corsairpsu_resume,
> +#endif
>  };
>  module_hid_driver(corsairpsu_driver);
>  
