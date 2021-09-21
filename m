Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29A3413AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhIUT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhIUT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:29:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E69C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:28:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c21so776691edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gRmMl3ATKMwqytANP/bGvh926ut0U/W4MmekIp4BdU=;
        b=a11YL0Ng5emaJ3g6CV3iyFHFoD9QHsGNitdmgIaEuUGCpK6F36173WgPa6n1cP/pdA
         H47OX35q9mlJQPqNPxk7l2ZADJpYCwfJaLdMFqPUWfsSIj4fo0yi8dY7SebN6jnpUogP
         gPJSkuugJej9CV/vUe3x2HAibgjkzDOVPdbcoPVfwGeBePWdaioKr8oZA0nhzqAzPm79
         IPn3tN9Z0mgcWwkqaGGm6PGqfxGu8LU3548fgymWKO+b2IXwj6LaAGuAGeEzSK9e+XFH
         9W6AJTheq9Z1h/Z1a9MXYrGzKgB6hSkEC6phKJyBEp+g7pCDu9fdRDqYzFJUsD8buCM4
         kBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gRmMl3ATKMwqytANP/bGvh926ut0U/W4MmekIp4BdU=;
        b=YFFci3zxD6QZn8fQLWd18GHo45lxLTEWeTOy5hY/+F20nntnnnKdK37F3fMEpb+oxn
         9kqpUJfKmMn2g2wumvdPCIbXImhowqMp7Xvr449QWsWjQBE/4FS0ET+7uW7V9/pkZ2+B
         giXDZNjq/MgQQgrUMwZyWSJCINwAPhEpOVfmTfVG+3laSDwNi6MW7OgwOxcpcgznaLVb
         OX7DMrayHnH4+sv0Hg5j2f12X4kVTnXh241Hbosn8iZeXUle2qgT07b36lfKFQJdIR/A
         X1lYXHbaXj2mdcogHJDf+PQLoDI5M2Jvpds5QdHcH8l98vf6eQmKPoLDABO6WtwsPMzr
         SkXw==
X-Gm-Message-State: AOAM531DK6VKC84CJaBOtCj0ssGeuELa4pa4nx3b32LoT6S6t3ZD9bEX
        AfQ3w0pV/VefG0hdKXb122QcPZ1SeHwoE08zZu8=
X-Google-Smtp-Source: ABdhPJwH5FKh4ezoVaP46HatD6aNGuB1kNtTvLNwYTxxWCb//BZ3ATo7gO+0oKXqSq0bXcWKgU/Z7ccqa/6+JyTbH7g=
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr35812674ejb.408.1632252497689;
 Tue, 21 Sep 2021 12:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210920203735.675-1-linux.amoon@gmail.com> <CAFBinCB682kFB47=K5-Pod5cbrnNTtKdAj3i8PHrxj8VxOH8FA@mail.gmail.com>
 <CANAwSgRtZoAmMO-WtRBX4W4pTkmzJKH1zc=6-99Py-d_4cOR0w@mail.gmail.com>
In-Reply-To: <CANAwSgRtZoAmMO-WtRBX4W4pTkmzJKH1zc=6-99Py-d_4cOR0w@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 Sep 2021 21:28:06 +0200
Message-ID: <CAFBinCBXv7YVHy7SECrmTwTM+9zwU3KSF6U613fjoi+JQRdOnA@mail.gmail.com>
Subject: Re: [PATCHv2] regulator: pwm-regulator: Make use of the helper
 function dev_err_probe()
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Sep 21, 2021 at 9:21 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > -                       dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> > > -               return ret;
> > > +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pwm),
> > > +                                    "Failed to register regulator %s\n",
> > The message here should still be similar to the original one since the
> > actual problem is that we could not get a reference to the PWM
> > controller. At this point we are not trying to register the
> > pwm-regulator yet.
> >
>
> Yep, Typo I mixed up the logs completely.
> it should be  "Failed to get PWM, deferring probe"
I think it should only be "Failed to get PWM" only - without "deferring probe".
If the PWM is missing in .dts (which is not valid but might happen for
someone who's creating a new .dts) then the "deferring probe" part is
not correct as the error code is not -EPROBE_DEFER (it may be -ENOENT
instead - or similar).


Best regards,
Martin
