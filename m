Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737CD41837E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhIYROQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhIYROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:14:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A82C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 10:12:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx4so49444497edb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2Pi8COsNP5j3xicpNqyAkP38kTOsAGtljrPGwc062o=;
        b=o+oJT3fF0AEB9OKGo6g5os3TYNi0Fc3o+4CpZLhGnF33Z1DtYwYxPn7bYahdgfs8ib
         I8VtKUoHrpgBM8iqFwarOeVE753VJV+bUM9/nb8TFUszJRi5Qs3jGkMuT/H1Cu0DBxOX
         FnzSgzZ53Ui5W0w0fZJZJeG89LTc8AtjYcdfP8jL0DURBGflkrnX5IKp7y69mxaVD9CE
         mMOcI2wX/L/5XRKMrofhs1rmy0bF2NqHpNxr+f3yl50/Z4qoB92VrTHWguHAxFtwagfS
         aULgt2tAx74cLTTHLYknm6B6QcRZgu5tT1dC7HhUBJeEiNlGlk8EVqcVR96Y203iYpA4
         /WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2Pi8COsNP5j3xicpNqyAkP38kTOsAGtljrPGwc062o=;
        b=EieeAJLYuD4ZKWm6Jju8lp3LAACzu3cP/4vww0PnN/xKZhNKUFXcBKt6ujk6jqHZvr
         fmGBSdkd7egCWI8eW4jR+SCENBrPMeZKeM4VvgRTsQAfaT0XXb1/U+ATx2A1mKtWOrjI
         eThBwRlHEJQz0cNsNwChEimtzRBrKWQDxUNAob0de30nmVW674Lj2OrSYcWFi7DGs0lL
         FqZIXb2Q2PKrj4PDVqrRd/6zhcf74/oXBOYydxKD+rXacQik4okSPb5Pycp9zkYdyAzy
         KsDHMGOYfwWFGdzZhfHu0JcvvRbArSRmUnf7WMA8y+TBn7bYf2vEM87GslPUUlr92HTn
         6rpw==
X-Gm-Message-State: AOAM530IBSk72AxTXu7p/uqG/OZzTj83ngXiH6LAvYgthhUkQQ9/RoH7
        YVt662iYtjFm4IVtegluXhJmF/4pIblknBcQ/NM=
X-Google-Smtp-Source: ABdhPJzlcsciwb7JqAbDVej57aLkRZB7MjukkQMT/AwahCR/3dvzEfdcqENQONyFJ/Q4Ezv0c5xpwc8+ChZMFPVOMwI=
X-Received: by 2002:a50:c31c:: with SMTP id a28mr12922973edb.384.1632589959392;
 Sat, 25 Sep 2021 10:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210921212732.1334-1-linux.amoon@gmail.com>
In-Reply-To: <20210921212732.1334-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 25 Sep 2021 19:12:28 +0200
Message-ID: <CAFBinCBHDTCkBBxP9u-Qh_k6ZSswJ_5XDL9oq2CSEkWG23dXfw@mail.gmail.com>
Subject: Re: [PATCHv3] regulator: pwm-regulator: Make use of the helper
 function dev_err_probe()
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Sep 21, 2021 at 11:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> @@ -353,13 +353,8 @@ static int pwm_regulator_probe(struct platform_device *pdev)
>
>         drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
>         if (IS_ERR(drvdata->pwm)) {
> -               ret = PTR_ERR(drvdata->pwm);
> -               if (ret == -EPROBE_DEFER)
> -                       dev_dbg(&pdev->dev,
> -                               "Failed to get PWM, deferring probe\n");
> -               else
> -                       dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> -               return ret;
> +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pwm),
> +                                    "Failed to get PWM\n");
>         }
From functional perspective you're patch is looking good now.
I just noticed that the coding-style in the pwm-regulator driver is
not not use any curly brackets for the if block when there's only one
statement

with the curly brackets removed (and if there are no other changes to
this patch) then you can add my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
