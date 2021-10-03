Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8114F42011E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJCJud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhJCJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 05:50:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1BC0613EC;
        Sun,  3 Oct 2021 02:48:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so52384356edv.12;
        Sun, 03 Oct 2021 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOLGt+yfCVBdYhsG5pGUWfu5DrI22+00GHKhfNjMQrA=;
        b=CKncsyOLbLtTMzH4mmIWk4HWCp/yO1NuIXbMX+pd0jkbQH+/tnwX0+TDuTdLsKQlUz
         VEIJGf9NEjobZpA1RWWg3TTeNcC0ITG+G19BVH0w655d/lGuiVaMIYtezitDkHbnO616
         P/Cb7KiyuxeWS/pSGmvE/ajhY2RJ/XHyKRQo39o6eIzY463WGaZEn13en372PbKii1se
         Oyi5HpoPXaCSlu6L7PgiEOGlQEghNMSsLwddLDbPP64X1iMtYX9RY/83sG5AGdhC8tKT
         xWtc+KaApdAlxyg0vOM6DY1NmFt3yu2ovAVxIR2zpfOcl3pWgs8dlSacq6yn1l5a0PsJ
         nw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOLGt+yfCVBdYhsG5pGUWfu5DrI22+00GHKhfNjMQrA=;
        b=4BqF43MWzIusya1R6VtcDZJC4D/atfcne/m6grYjxeBJWLtoOQ/Ao9Xlyk/R6KPmjc
         AKGEfaJtz8OiWk0E3iDpoGt4usmAs63QMvp1GsbNznWzQ8wfohzyhJ0gYOw2MHdozcYU
         padkBpg9FWg85MZCGMAlyIW/+dMBIgo/QHYwrgxxH+QRGDp4WxJ5h9iZ7o2mzT0hnPsr
         IzyYY8PilhHVZYgvhBA2YjoM8tJVBREN2jWP1Bcc0k752CgirJ5OgNrmcvSvADJopQu1
         OazNWSqwoff28YLrMESTA5w70hCzByZTZEi3U/WfDRtNJa/CJEb1TlmwLnewqNSexNEA
         RPKQ==
X-Gm-Message-State: AOAM5337fwjRVoaFjv5eSkoyc+fSW2EB4p5VOvDe4qEucS7KTZDemAMT
        WdKKVXq/RsJ0IKjv5SfMBZCDO3Kl9W1TbVn9EDc=
X-Google-Smtp-Source: ABdhPJzzfa44i+Oga90yALlJfZFS8kITln5E3P5lrdyQ4oelHOwIUgNvYPwGnL+iyEVLqu+ASSHj2V3TKL6v7QIWv8Q=
X-Received: by 2002:a17:906:1707:: with SMTP id c7mr8983616eje.377.1633254522888;
 Sun, 03 Oct 2021 02:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com> <20211002210857.709956-2-pauk.denis@gmail.com>
In-Reply-To: <20211002210857.709956-2-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Oct 2021 12:48:06 +0300
Message-ID: <CAHp75VcKQr22xQLN7OizG_Vu42UiDYbmNb9N6EUxkG7Dm0pa+w@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (nct6775) Add additional ASUS motherboards.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 12:10 AM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Add support:
> * PRIME B360-PLUS
> * PRIME X570-PRO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX B550-I GAMING
> * ROG STRIX X570-F GAMING
> * ROG STRIX Z390-E GAMING
> * TUF GAMING B550-PRO
> * TUF GAMING Z490-PLUS
> * TUF GAMING Z490-PLUS (WI-FI)

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Tested-by: matt-testalltheway <sefoci9222@rerunway.com>
> Tested-by: Kamil Dudka <kdudka@redhat.com>
> Tested-by: Robert Swiecki <robert@swiecki.net>
> Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
> Tested-by: Igor <igor@svelig.com>
> Tested-by: Tor Vic <torvic9@mailbox.org>
> Tested-by: Poezevara <nephartyz@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/nct6775.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index aa58ead0ad43..8eaf86ea2433 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -4986,20 +4986,29 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>  static struct platform_device *pdev[2];
>
>  static const char * const asus_wmi_boards[] = {
> +       "PRIME B360-PLUS",
>         "PRIME B460-PLUS",
> +       "PRIME X570-PRO",
>         "ROG CROSSHAIR VIII DARK HERO",
> +       "ROG CROSSHAIR VIII FORMULA",
>         "ROG CROSSHAIR VIII HERO",
>         "ROG CROSSHAIR VIII IMPACT",
>         "ROG STRIX B550-E GAMING",
>         "ROG STRIX B550-F GAMING",
>         "ROG STRIX B550-F GAMING (WI-FI)",
> +       "ROG STRIX B550-I GAMING",
> +       "ROG STRIX X570-F GAMING",
> +       "ROG STRIX Z390-E GAMING",
>         "ROG STRIX Z490-I GAMING",
>         "TUF GAMING B550M-PLUS",
>         "TUF GAMING B550M-PLUS (WI-FI)",
>         "TUF GAMING B550-PLUS",
> +       "TUF GAMING B550-PRO",
>         "TUF GAMING X570-PLUS",
>         "TUF GAMING X570-PLUS (WI-FI)",
>         "TUF GAMING X570-PRO (WI-FI)",
> +       "TUF GAMING Z490-PLUS",
> +       "TUF GAMING Z490-PLUS (WI-FI)",
>  };
>
>  static int __init sensors_nct6775_init(void)
> --
> 2.33.0
>


-- 
With Best Regards,
Andy Shevchenko
