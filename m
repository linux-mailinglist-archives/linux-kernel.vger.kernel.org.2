Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04F36A6BC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhDYKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhDYKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 06:41:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70814C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 03:40:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n10so16269315plc.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsl3b2VaWWjqUhBQn9UZvRtMk9N8rB5xjUtLj4O+9zs=;
        b=IbBMniggUXZEvuTYpYEBMfvLRh4mpiisKnmiw/0bGoDWR7ibqD/rym4K1F5ClRhI0Y
         4YckVzJCTvrOzWMqdznRBZzl/1L5EimzCF8ukmY6jUDrdl0dqjWxjbnn03wlg2uToOBk
         bnbt1zUFYP5kLXsXWqFcearh+PIbg8L47eALDVW8hCGs21Q5KcNkzBTlZFU+kg33HcsX
         JM5cxccNsknI3xkJ/SdOsrAeUcynOtOKTG7am8MpczjJyy8CCSg0wz1Gj2GAWzwYpLCc
         paUYi3o9Uk8pJ/XLuK9shXi7GcbhOzUDDz12o2/fBtfYmXAUbg/4zMXEQIkPajTrzYWT
         XhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsl3b2VaWWjqUhBQn9UZvRtMk9N8rB5xjUtLj4O+9zs=;
        b=TR3n2v5TlRb9Zp+RWA1Y6+WCuATEfUiL4hI8xOaiVkfzdusVanNO3KsxhZ5UL6mG9M
         SBmzjCDmLgDZouf4grUXZgTpEf9RHDJs3WB4iU+Mi4031ZPRXCxK9VdvPV2rqKZxrtho
         2WBfpMKvvvjFgIO0naP2NkdulzH4B+bUsxfHlzmZ3ry+3t7ejay2ZuD5wfPyWz1F/bKf
         7SxSvTrQkd0Xxb7qjLX8ToswOr2zXRFpe7wHCirfBLHJzV6Tg1g3516lBUAS5YG/EX5Z
         vY11xVJ4rIQTFZamKJpwwcl5eUEYPcvR/F4QnKHAc7oxs7ck7wrDp6ja8Kvv2QbQrb3a
         BquQ==
X-Gm-Message-State: AOAM533YzzW62Et1ZzP6Fun1BuJ+1rWJy3Afraudf+eNWbc3h+NWfnc+
        D350XMYJ7AYpqNFQJaszILEy5EWdHthd6+8/i8apN43NawN6VQ==
X-Google-Smtp-Source: ABdhPJy/dm9agEumGI878/Tiw9CQAwYoLydksqvCEQ0FrYrLdqZX2ZGcG5efbbH7Z0F0BGyUJv+gHZ7bSwT28Cv19rY=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr16689677pjr.181.1619347248901;
 Sun, 25 Apr 2021 03:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210424174138.175889-1-ftoth@exalondelft.nl>
In-Reply-To: <20210424174138.175889-1-ftoth@exalondelft.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 25 Apr 2021 13:40:32 +0300
Message-ID: <CAHp75VefKAcohOF=cuJ9A_tjZZLuvHcDB2xmTUCrA-xHaWm0oA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] extcon-intel-mrfld: initialize mrfld_extcon status
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 8:58 PM Ferry Toth <ftoth@exalondelft.nl> wrote:
>
> extcon driver for Basin Cove PMIC shadows the switch status used for dwc3
> DRD to detect a change in the switch position. This change initializes the
> status at probe time.

Thanks for catching and fixing this issue!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 492929c54791 ("extcon: mrfld: Introduce extcon driver for Basin Cove PMIC")
> ---
>  drivers/extcon/extcon-intel-mrfld.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
> index f47016fb28a8..cd1a5f230077 100644
> --- a/drivers/extcon/extcon-intel-mrfld.c
> +++ b/drivers/extcon/extcon-intel-mrfld.c
> @@ -197,6 +197,7 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
>         struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
>         struct regmap *regmap = pmic->regmap;
>         struct mrfld_extcon_data *data;
> +       unsigned int status;
>         unsigned int id;
>         int irq, ret;
>
> @@ -244,6 +245,14 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
>         /* Get initial state */
>         mrfld_extcon_role_detect(data);
>
> +       /*
> +        * Cached status value is used for cable detection, see comments
> +        * in mrfld_extcon_cable_detect(), we need to sync cached value
> +        * with a real state of the hardware.
> +        */
> +       regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
> +       data->status = status;
> +
>         mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
>         mrfld_extcon_clear(data, BCOVE_MCHGRIRQ1, BCOVE_CHGRIRQ_ALL);
>
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
