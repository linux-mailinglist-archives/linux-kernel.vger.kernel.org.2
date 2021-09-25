Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28E04183A4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhIYRfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhIYRfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:35:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782B8C061575
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 10:33:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b26so1060241edt.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkBWlplztzPYq7xEWUT333cO8AXxvEK462eV+xY6d3Q=;
        b=CmboLcZVzqLZ65pb77dGE9Tb+zbVPpRadSvxK+GRWbZ0/PMacdJT4C7khWZgMHDu3u
         SXZaIJ4/TuZJqyc3/nqA4JgSQVT9lmUKDqhh7WmnB2v87/FKi8hFYvL0ZAfKJOXHmcpi
         FzgRz8SGJEqBXnBylB7zICXbT67RqdjT7Zysr1wDhxzKOaEiKU1mPeFlQf8G59TWhhgB
         lDcZbS2Ty/cDYSfNEwSK6JS5V/I5lOpmpYnRCSDJSqVlu6qfPaqX5PydiG/gLV7zptvb
         ihFIpmYUpM7yzg4wIHkx+2IKiqJj25xJW5Illgh0Ad27FraOeJg3NTtMTjH3nV970yvC
         QNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkBWlplztzPYq7xEWUT333cO8AXxvEK462eV+xY6d3Q=;
        b=7Ob/cgjRu3jjEmsadcaYfiQyWf0ACR984ohKPRQHwjU56Od4CeDXKZsnlqm6ZVfMfO
         rIN3VpZzbtFMqJLBavVov+g0zGf0ZDTeJ8aI9MZKC1bic0lfBDmGx4jV0IFVuNSsPMa2
         bZb4nN0NLgYxKChF+C02CQqsXxCoGpn4oExmKbox7PasKGSa1n6YQGjRFiP76YKQfIeW
         RjFBDQ4ZkgrCsiElKdk7VFvonCRNunePkP8xnSMOXDg6VWoNHwbdOCYMW6viO/YXJa6X
         nsYrUMmharbU926qv+VhojekUTV7tHcAY/cBwmYPfGZTNY7ect+zt7n+h2yr80WkKi/q
         kuKA==
X-Gm-Message-State: AOAM531RsUaOFI4IFragxiQhCrXCUcADX7Gqu6NOQOJKZDAz3hcCyF9q
        bNa+ylLrTa7L3hLaiyA7FhxUijKPB7UkZS7I56g=
X-Google-Smtp-Source: ABdhPJwOhEN6jApVHtjpdjUknol4tn6WsTkxJF1T8o4ZP0cQAq1EKvHzYz9l2WQJqByLtAKc5JzZ6q/quRN7eOG9VCc=
X-Received: by 2002:a17:906:b10d:: with SMTP id u13mr18123747ejy.135.1632591236112;
 Sat, 25 Sep 2021 10:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210921212732.1334-1-linux.amoon@gmail.com> <CAFBinCBHDTCkBBxP9u-Qh_k6ZSswJ_5XDL9oq2CSEkWG23dXfw@mail.gmail.com>
In-Reply-To: <CAFBinCBHDTCkBBxP9u-Qh_k6ZSswJ_5XDL9oq2CSEkWG23dXfw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 25 Sep 2021 23:03:43 +0530
Message-ID: <CANAwSgQaw=1VAwQaW5PnE=5LxK1M9COCPiwTVi+iN=2D_y10fA@mail.gmail.com>
Subject: Re: [PATCHv3] regulator: pwm-regulator: Make use of the helper
 function dev_err_probe()
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Sat, 25 Sept 2021 at 22:42, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Sep 21, 2021 at 11:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > @@ -353,13 +353,8 @@ static int pwm_regulator_probe(struct platform_device *pdev)
> >
> >         drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
> >         if (IS_ERR(drvdata->pwm)) {
> > -               ret = PTR_ERR(drvdata->pwm);
> > -               if (ret == -EPROBE_DEFER)
> > -                       dev_dbg(&pdev->dev,
> > -                               "Failed to get PWM, deferring probe\n");
> > -               else
> > -                       dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> > -               return ret;
> > +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pwm),
> > +                                    "Failed to get PWM\n");
> >         }
> From functional perspective you're patch is looking good now.
> I just noticed that the coding-style in the pwm-regulator driver is
> not not use any curly brackets for the if block when there's only one
> statement
>
> with the curly brackets removed (and if there are no other changes to
> this patch) then you can add my:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
Thanks, I will update the patch in the next version.
>
> Best regards,
> Martin

Thanks
-Anand
