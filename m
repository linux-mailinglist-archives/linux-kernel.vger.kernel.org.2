Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3044D3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhKKJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhKKJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:17:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBABC061766;
        Thu, 11 Nov 2021 01:14:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z21so21536507edb.5;
        Thu, 11 Nov 2021 01:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OVKpBIcZdDNwTBwBpFvLGgM+7/0ex/GiW+ZCJo7GxA=;
        b=oTgMs/UR9WFlnJYw85CRg7h5OSZRkyVCWhvHaOB59iUx8RgPWZ6lQgSU8bhQtropze
         CIOw2HL7muqGwsKPSHduO6OmlKc+c7qpdxoi86e18xnayxluAIjGMvLr+fjWJxof53Gi
         HcS0ZZugT6RA1/jGkjIz2tyCTSMJ1US27zLIVMDeTY1JACQc34q7iguGTkEHqT5AiWDY
         +RWN3pX1iRcNkcJLdmtYRnMKSSUz0+0fwWfnuGsb3bgDV98bpMpWyXDQyypm+Ds83TVs
         S8WJwQoH2UTfyaHbhUQE4sqfNt5QH7cifxm/T2k2AHisbpPsznK1WCXLV/MGQee+4Slv
         tV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OVKpBIcZdDNwTBwBpFvLGgM+7/0ex/GiW+ZCJo7GxA=;
        b=JdGURXayH6XDUJbdrmeXFJOSbz6K87htHld9BXNdDhCz3zaxShtylK2wk2EACQbZOc
         4omP7weoB+xfVEeZ0B3kLrNaktEm83laVaAQp/3Liqe4chW4iLEAjYwUO9UZCp56h2hi
         rl9loNoCA4NStt8Lc96OmSVCsEXhHNeqixmYDIoriP+T/pzL9EFt353Hno3wo6QyxALV
         dvzW3hkj7ApS9zzsBIN+Id2aFK1B1nUOK3XSrGgNmzHbSNSo7tg64TJ91l5TNiSxDWOT
         oFTmirx5LHDqo+OTGV15lqObUJ8G03G2+dFVKK8mvmzOe7pTRJXpgXEmHOSQAIQgjfSw
         +Exw==
X-Gm-Message-State: AOAM531sjLYRoLT4Zk58mErVZ1xRvRqEgPj/hzs+QIZUawaoiY+mwgA/
        pLOOEbHwlqj6O23+IZReSamgjIvNMwZQIhoVD+0=
X-Google-Smtp-Source: ABdhPJxnRaUzjJ7TpRP1waNVkwD2VHVrVr45CFp25MOPz5+UYotVlT+wmUuh2Pw5vmPTCJi8qccKTrNZo+JmKOa2GEs=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr7341955ejd.425.1636622095123;
 Thu, 11 Nov 2021 01:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20211111025339.27520-1-zev@bewilderbeest.net>
In-Reply-To: <20211111025339.27520-1-zev@bewilderbeest.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 11:14:18 +0200
Message-ID: <CAHp75Ve16gLhaZOuUC19c3OrEcq73ZP5MErvtJ7O-G=astjEPQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (nct6775) mask out bank number in nct6775_wmi_read_value()
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 4:53 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> The first call to nct6775_asuswmi_read() in nct6775_wmi_read_value()
> had been passing the full bank+register number instead of just the
> lower 8 bits.

>  It didn't end up actually causing problems because the
> second argument of that function is a u8 anyway,

It contradicts the existence of the Fixes tag below. What do you fix then?

> but it seems
> preferable to be explicit about it at the call site (and consistent
> with the rest of the code).

Yeah, in the current state it makes sense.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Later one may refactor this to drop that tons of ' & 0xff':s.

> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Fixes: 3fbbfc27f955 ("hwmon: (nct6775) Support access via Asus WMI")
> ---
>  drivers/hwmon/nct6775.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 93dca471972e..57ce8633a725 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -1527,7 +1527,7 @@ static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16 reg)
>
>         nct6775_wmi_set_bank(data, reg);
>
> -       err = nct6775_asuswmi_read(data->bank, reg, &tmp);
> +       err = nct6775_asuswmi_read(data->bank, reg & 0xff, &tmp);
>         if (err)
>                 return 0;

> 2.33.1
>


-- 
With Best Regards,
Andy Shevchenko
