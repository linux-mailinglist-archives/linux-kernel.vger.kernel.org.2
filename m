Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9F3FF363
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347107AbhIBSqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347098AbhIBSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:46:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C3C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:45:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d16so5379799ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwZd3ZgW1miLdOJZn1d5Cu4tzpdhZoJsS5ineoU+BfA=;
        b=HetNYezZiq683Y3J4WCiM5Hg96SBFY3UyHOYzuOuSeQvMR8LCzkNeJh0vyJBJYQ/5n
         NoOyi5QxmkrtKpk5eIu3xyfZdADSsAf15jLh2zy77AjUnBoTHfGtRXSA5dRzEgXuRLqa
         PR5GWN6MdMa2lxy8oC47IT1jhGkxS7fafnjRGLwMmRnQ39441osMkPcaZY+o9ZHofiW1
         tJ5Qb98RkFMBtJugGA3QmbvfxxpGJJZZ6mG4Q3a6kr70534DNbj1q2nlRQFjUTkhaIbi
         80KdJTTJ0MZ2tzRo0Prhqem4/yMOCQ2SaIX327Td6uBcTIGDnAOcGdijejwMYJ5YM5kC
         HnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwZd3ZgW1miLdOJZn1d5Cu4tzpdhZoJsS5ineoU+BfA=;
        b=GLRG1/j/fAlrBPRPFGFDCik3pq6RJBapooIZv64HyyBtI102uXFGSQe5Bp8Vt0TcS1
         jlpJzIyffEnjnkA5AxHJue+xD4Ue1sUN03OYHwmKcK/FJ+ZH9NKxv0owFCLnRfVJqaru
         VpIw5HJYu2aqgfJhgtcFU8PGHp4rx1bd8fnnyBKUi5HesL3Ut2Db8Xb+C3xsf2x+6NCt
         +6//38xjqji+G3uxEJQwyi8exp58jlQEWP38vyVC2kzONgp9hLatAL2JIp40j+kgdrif
         0tL6M/PUtbWhQ1mJOV76uUD9aoUHgFtl7K5pQt13MGMc1FsQ4Dx8QWX2XcuCtm0GclQX
         zsQQ==
X-Gm-Message-State: AOAM533RmdpKoWo05ImQWKTNg/IydvciJ9Ny/R80nObDEl6lMrnxwotJ
        DnVRLfB94M0dkfa2HzLmEhCfjzcsHBVyM2muywEcgA==
X-Google-Smtp-Source: ABdhPJw0g3ymFSWkh+oHClUrwULi1But/WIxx/bXPQqYwt0nSs3rjWPsrkiQCQfzizMIeMBtaOA2kDQ93XVZpfT1ZAc=
X-Received: by 2002:a2e:b5ae:: with SMTP id f14mr3862704ljn.170.1630608340407;
 Thu, 02 Sep 2021 11:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630581434.git.mchehab+huawei@kernel.org> <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
In-Reply-To: <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 2 Sep 2021 11:45:28 -0700
Message-ID: <CALAqxLXM=qOk3cGru+x0pfddWViRPdoF67w1xNO8gZdWd7G2uw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 4:28 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> As there's no upstream DT bindings for this driver, let's
> update its DT schema, while it is not too late.
>
> While here, add error messages, in order to help discovering
> problems during probing time.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I gave this series a spin on the hikey960 booting in a number of
different usb configurations (usb-c gadget, usb-c host, usb-a host) as
well as switching between them and didn't see any issue or new
regressions.  Admittedly not super rigorous but the usb issues we have
seen in the past usually took a number of days to trip over, so it's
probably as good as I can say now.

Tested-by: John Stultz <john.stultz@linaro.org>

I've also added it to my mainline tracking tree and will let you know
if I run into anything over the next few days.

But one nit on the patch below:

> ---
>  drivers/misc/hisi_hikey_usb.c | 81 +++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
> index 989d7d129469..8be7d28cdd71 100644
> --- a/drivers/misc/hisi_hikey_usb.c
> +++ b/drivers/misc/hisi_hikey_usb.c
> @@ -248,8 +237,8 @@ static int  hisi_hikey_usb_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id id_table_hisi_hikey_usb[] = {
> -       { .compatible = "hisilicon,gpio_hubv1" },
> -       { .compatible = "hisilicon,kirin970_hikey_usbhub" },
> +       { .compatible = "hisilicon,hikey960-usbhub" },
> +       { .compatible = "hisilicon,hikey970-usbhub" },
>         {}

So with the gpio/regulator change on the hikey960 side, there isn't
any more 970 specific logic, so should we unify the compat string?
Also, I personally would rather use something that wasn't so "branded"
to a specific board should a new device use the same approach (which
is why we switched to the gpio_hubv1 naming instead of "hikey960_usb"
that we had earlier).  This is definitely bikeshed territory, and I'm
not picky, but "hisilicon,usbhub_notifierv1" maybe?

thanks
-john
