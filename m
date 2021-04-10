Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4535AA18
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhDJB7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhDJB7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:59:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF0C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:59:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j7so3600955plx.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=YKekralRjci5bQu/4xmd55reV4SMgAHUOMu01CiJvWw=;
        b=YZjnjaSTQjJ215LLBBT3Z+O2NhkXNtMxVIMIxveK0Ch7okbfFmQaCyluEj3wRTxN9L
         iqZp52H9OFo/2Gtq7BlPscHNU4gOuuagoimZKjbS1yM9DWRkOHh7Ldoqe87jDdKe4qAT
         Z7fthw667CHOGLF/MH8BzMT6Wp/YEC9Jdc31c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=YKekralRjci5bQu/4xmd55reV4SMgAHUOMu01CiJvWw=;
        b=TeXcmvfQTZ52MykAayZYoXskpW1JAn2pRMRRli0uhfduPfD9pcnmsYRRKz4S24TjjD
         1yaDIuxMnOqtZOARm+9skm4LsS/8SerhfnSLKggvKMybxfxhycjHRjkXZVqnHVirfarC
         loqpcC1qgLc3Mp1nMBEe3YD2JGETqhIPGukS5S89nH44d60lifUEzSjtC3G58fZysBPv
         gaRbm9KgplL3q/tOHs7xyeivoUBK31EdOxX6EvFikhDSTEAVp8St+VBJvjWHMFFfvRma
         7UIo8sVztbPtB8ulzrqRr5N71XQnTv3ugoxjmP29blmDYVHq7ig6XREmhnev3opH4qvp
         4sEw==
X-Gm-Message-State: AOAM530h3ZWDmMYJH1upb2NIejQjW8gvI71hMD7qsmIZHjRdimf6hpme
        HSPvgIoKEu+X2n7E1fvf4uQ6wPjbn2AY9g==
X-Google-Smtp-Source: ABdhPJzv4vvp5akVW7dl/nUgSWAuDB6Frjw8pTYDFDn6ENNs3YryeYOb8CRr3eorVsY6vf+g+a/K6Q==
X-Received: by 2002:a17:90a:7896:: with SMTP id x22mr16283044pjk.182.1618019961050;
        Fri, 09 Apr 2021 18:59:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id p2sm3755665pgm.24.2021.04.09.18.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:59:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <159978558757.2295844.13766111546939928492@swboyd.mtv.corp.google.com>
References: <20200909224226.2177401-1-swboyd@chromium.org> <CABXOdTeWfuZHLywMU1d+No-NSZ4uusAgkhs=2hNZGFM-uYz2wA@mail.gmail.com> <c3ba5d92-8bfe-30d7-44f0-c8a3e40d1906@collabora.com> <CABXOdTdsVyae9oHKEMSbXOsi5VWUZhLbKVxeNVedc4redZineQ@mail.gmail.com> <6b546379-d5ce-f0bd-7907-be36f90c15ed@collabora.com> <159978558757.2295844.13766111546939928492@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v2] platform/chrome: Don't populate lightbar device if it isn't there
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@google.com>
Date:   Fri, 09 Apr 2021 18:59:19 -0700
Message-ID: <161801995912.3764895.7559313428958998666@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-09-10 17:53:07)
> Quoting Enric Balletbo i Serra (2020-09-10 08:49:42)
> > On 10/9/20 16:52, Guenter Roeck wrote:
> > > On Thu, Sep 10, 2020 at 7:32 AM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > >> On 10/9/20 16:18, Guenter Roeck wrote:
> > >>> On Wed, Sep 9, 2020 at 3:42 PM Stephen Boyd <swboyd@chromium.org> w=
rote:
> > >>>> @@ -206,6 +209,17 @@ static int ec_device_probe(struct platform_de=
vice *pdev)
> > >>>>                 }
> > >>>>         }
> > >>>>
> > >>>> +       if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
> > >>>> +           !cros_ec_get_lightbar_version(ec, NULL, NULL)) {
> > >>>
> > >>> Any idea why the lightbar code doesn't use cros_ec_check_features()=
 ?
> > >>> There is a definition for EC_FEATURE_LIGHTBAR, but it doesn't seem =
to
> > >>> be used. It would be much more convenient if that feature check cou=
ld
> > >>> be used instead of moving the get_lightbar_version command and its
> > >>> helper function around.
> > >>>
> > >>
> > >> IIRC it was to support a very old device, the Pixel Chromebook (Link=
). This flag
> > >> is not set in this device but has a lightbar, hence we had this 'wei=
rd' way to
> > >> detect the lightbar.
> > >>
> > >=20
> > > If that is the only reason, wouldn't it be better to use something
> > > else (eg dmi_match) to determine if the system in question is a  Pixel
> > > Chromebook (Link) ?
> > >=20
> > >              if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
> > >                  (cros_ec_check_features(ec, EC_FEATURE_LIGHTBAR) ||
> > >                   dmi_match(DMI_PRODUCT_NAME, "Link")) {
> > >=20
> >=20
> > That looks a better solution, indeed. And definetely I'd prefer use the=
 check
> > features way.
> >=20
> > Gwendal, can you confirm that the Pixel Chromebook (Link) is the _only_=
 one
> > affected? This one is the only that comes to my mind but I might miss o=
thers.
> >=20
> > I think that Samus has this flag (I can double check) and this was disc=
ussed
> > with you (long, long time ago :-) )
> >=20
>=20
> Sounds fine by me. I'll wait for Gwendal to inform us.

Anything come of this? I haven't seen any updates.
