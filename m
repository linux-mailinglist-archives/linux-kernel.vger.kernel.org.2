Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F2457048
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhKSOJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbhKSOJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:09:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5370DC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:06:50 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id t26so43749397lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/p7LzZgnhIc3Hls3ppZXC5lo3Y6+VGNPzWmpnyjNbY=;
        b=Jz8TGdTQquyFyf7C8JZDfWYklF6AStjiEpGw0cJd3w5dAyax7bQJvG17dDAF8o8uWK
         L2l5naPSPIawPn67w3c3BUC9+Ne7oti9IiNurfl3z16wRToYL22Q1gckYIspO8fahDJu
         FZWRgCvi6pbdJmlwOgQOyPrzXoBQgVy/8Vws1E2bsdArcgZW3dzblXP9jnXoTJoGDdCT
         OJxgef3sV7RN5qnCC6uHIL+0bcpHufTelEEDt/2qDSKQO+4CMd1IvpO864bSNldt7iFV
         F2XqqUDpoAzPpfui2Mp8HsLQQBREneywnDc7F2kGjx87Vxz9906o0IkS7vO/yg5pLfVT
         d/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/p7LzZgnhIc3Hls3ppZXC5lo3Y6+VGNPzWmpnyjNbY=;
        b=Bq7x1Prkk3niE7jNxrraLGCNGZ90UeqaWsVLtrxiXFjwlpwOgzsYrj6vh+IrVhKCVz
         VEGIZI2RnCrHV5Io2IlEJ/BuQe2eQRO4HN8q7tjtJSGsO8dO1Fb8dEpC4mLJ62BQdJ6+
         +/DHkqzu36GNyfD7QAzbkCrbqGHASEobcguZbXnGX/wBcDgdOWwkWXGMb2kkPVItGTwi
         zDOx9CkGK+JeMOKAmn5Mt4QRUElhmBNwSLT+AYktRC/Uc03G1dJB6MDyI+BAAo0v/A16
         dwV84doghz/SY7eup4iXEdGkzYHTqYjFAxuKVDHfgz+c9A+ooVoitC09iiyNyoFGOrf1
         h4+w==
X-Gm-Message-State: AOAM532Ql0ngbJf79I34hJDhCSLMldFQpyaCRBU9XWPcob7WoEpCd+2G
        4aENqhPccNgXnBKG0LW6XD6phN8FqjuZpQIyh0J9z01jfioh1g==
X-Google-Smtp-Source: ABdhPJxyfsCECkBAJmpBN2ThSM9Ag+16VJM/mGeASZ5VdhV4tLZyVRXlEKeqFuNQpWIH0BvA5HbyjS4F5zUUUdJKRHI=
X-Received: by 2002:a05:6512:10c4:: with SMTP id k4mr13787353lfg.373.1637330807775;
 Fri, 19 Nov 2021 06:06:47 -0800 (PST)
MIME-Version: 1.0
References: <22161945.a8.17d061e089f.Coremail.sensor1010@163.com>
 <20211112150036.6lhhoak4uk5hhgqt@pengutronix.de> <3b92f2f6.791c.17d3839dd51.Coremail.sensor1010@163.com>
In-Reply-To: <3b92f2f6.791c.17d3839dd51.Coremail.sensor1010@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Nov 2021 15:06:11 +0100
Message-ID: <CAPDyKFq0Kn28SfE15WyHR_HrCT1PDoDiqNFBu-qEUoNQYxjzRw@mail.gmail.com>
Subject: Re: Re: drivers/mmc/cor/bus: Delete redundant match function
To:     lizhe <sensor1010@163.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>, pali@kernel.org,
        TheSven73@gmail.com, lznuaa@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 at 13:45, lizhe <sensor1010@163.com> wrote:
>
>
> HI :
>         Does this patch need to be changed? If  need to modify something,=
 please let me know and I will fix it soon
>
>                                                                          =
                                                                           =
                       Thanks
>                                                                          =
                                                                           =
                        lizhe

Hi Lizhe,

Please read Documentation/process/submitting-patches.rst carefully. It
guides you through the process of how to submit a patch.

For example, you need to use "git send-email" and we only use plain text em=
ails.

Kind regards
Uffe

>
>
>
>
>
>
> At 2021-11-12 23:00:36, "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutro=
nix.de> wrote:
> >On Wed, Nov 10, 2021 at 03:12:51AM +0800, =E6=9D=8E=E5=93=B2 wrote:
> >> HI=EF=BC=9A
> >>      I failed to send kernel patch mail with git sendmail,
> >>     could  you help me take a look at the submitted patch?
> >>     the attachment is a patch file,
> >>     For convenience, I put the content of the patch in the body of the=
 email
> >>
> >>
> >>                                                                       =
                      thanks.
> >>                                                                       =
                      lizhe
> >> patch :
> >> |
> >> From 40577316f4dbcf35061a14f27f7a777c2f4199a1 Mon Sep 17 00:00:00 2001
> >> From: lizhe <sensor1010@163.com>
> >> Date: Tue, 9 Nov 2021 10:13:43 -0800
> >> Subject: [PATCH] drivers/mmc/cor/bus: Delete redundant match function
> >>
> >>
> >> When the device and the driver are matching,
> >> if the device or the bus to which the device driver belongs
> >> does not provide a match function,
> >> then the device and the driver are matched by default.
> >> function 'driver_match_device' illustrates this mechanism.
> >> Because the return value of mmc_bus_match is 1,
> >> even if this function is not provided,
> >> the function 'driver_match_device' returns 1,
> >> so function 'mmc_bus_match' is redundant.
> >>
> >>
> >> Signed-off-by: lizhe <sensor1010@163.com>
> >
> >Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >
> >Apart from how the patch is put in the mail, a maintainer responsible
> >for picking patches up in this area will probably refuse because the
> >name in the From line of your mail doesn't match the name used in the
> >Signed-off-by: line.
> >
> >Best regards
> >Uwe
> >
> >--
> >Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig      =
      |
> >Industrial Linux Solutions                 | https://www.pengutronix.de/=
 |
>
>
>
>
