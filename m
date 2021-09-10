Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30544064E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhIJBH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbhIJAmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:42:02 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7752C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 17:40:52 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id s25so117064vsa.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 17:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u99A3nTsEcjLLtFLYfw0zQdAAXoFdW/AuvMLvdfo3s4=;
        b=TW7VBVq6dK6hsRFpDVJJBgboDluU3a+UwpCW4hBgVvH8sOBE5QfR/PI5spsa0KR+tR
         xRsSXywROggbTW7FX9pv8vo6R/cO5JMcm5lJp3ZriRuTnOwD85QLKGbxFvYSu+EqDRAp
         cg7sGGMsrbZI6VyOKbIgE7SSi2A5ArNHO9bfoWx4bU0+bknhS4FitHbJlyABXOxKDuTD
         LoObBJ0IdP+DiLyAdmvGEH5BjnzH44OtT6fjZUOFs8uAXjp0DfGktG0bWwOGobDzUozz
         /boUVhlxqmxwen9I0ktEp1cZvN6szGSfSjrO71UHDMT0fZU798j5PqCjg8QxnpTLU2zn
         rVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u99A3nTsEcjLLtFLYfw0zQdAAXoFdW/AuvMLvdfo3s4=;
        b=SUzBmeJCTDHsK4vvy9CBVjhEg9NoKhfY9qsUHJDjxKqSA9jylYp44Li9uQHvS6jOCe
         esl9Dya9Z3BeNoV+1fZbftwNC8FCqt3ctD1BsQBqzz+SIbbxme+mz7Ym6dHRdFQJKtR1
         nHKwXFS4m7uNo4CtAUo4mHJkp5ehgq5rYLtNWm8x4rp9wIMAnhDjsHq8Nna2JEqf+GEF
         kN7YiN66zXPZM44tqICFUS3k4x3+YEYqfK+J0ZzTigQqu8A5DWNnejGJxQktg9bkg1+A
         SOx7Sj5Q7C3VRdX6B/eNrV2POrTUHEMXGQmw4pJhcz3aGYuEUJ+HEOxDidiC5ZN3/VBz
         sfIQ==
X-Gm-Message-State: AOAM533Ui+TY3Eop4fs2O2rOCBgz7g5t4MLt975C0QVN4tBNSA6diZOD
        HQ8EBli17qFHz03v9uZFprSR5FzJYXr+88ledMqA
X-Google-Smtp-Source: ABdhPJwkaBrAuiHABMu8IcTdvxJeg1KK4aP27a3qLiVaj8iQxGCaBhVotOsv0c4stecCCk4+BPxRMpAgcT494uzIS7o=
X-Received: by 2002:a67:6245:: with SMTP id w66mr4292730vsb.34.1631234451815;
 Thu, 09 Sep 2021 17:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <f58c6a58-86a6-1b37-7cec-6a9d801189ed@gmail.com>
In-Reply-To: <f58c6a58-86a6-1b37-7cec-6a9d801189ed@gmail.com>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Fri, 10 Sep 2021 09:40:25 +0900
Message-ID: <CABMQnVJ8z6Tcbee6rv2vCR48ZDesC9f_ZnH6gx7rFONYT8iTpg@mail.gmail.com>
Subject: Re: [PATCH] rtc: rx8010: select REGMAP_I2C
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2021=E5=B9=B48=E6=9C=8830=E6=97=A5(=E6=9C=88) 12:56 Yu-Tung Chang <mtwget@g=
mail.com>:
>
> From 45801967ad80578161485937a0833b27b90210f9 Mon Sep 17 00:00:00 2001
> From: Yu-Tung Chang <mtwget@gmail.com>
> Date: Mon, 30 Aug 2021 10:59:17 +0800
> Subject: [PATCH] rtc: rx8010: select REGMAP_I2C
>
> The rtc-rx8010 uses the I2C regmap but doesn't select it in Kconfig so
> depending on the configuration the build may fail. Fix it.
>
> Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
> ---
>  drivers/rtc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 12153d5801ce..f7bf87097a9f 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -624,6 +624,7 @@ config RTC_DRV_FM3130
>
>  config RTC_DRV_RX8010
>         tristate "Epson RX8010SJ"
> +       select REGMAP_I2C
>         help
>           If you say yes here you get support for the Epson RX8010SJ RTC
>           chip.
> --
> 2.33.0

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 40AD1FA6
