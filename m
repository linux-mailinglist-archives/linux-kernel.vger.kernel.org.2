Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35A13234A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhBXAa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhBWXug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:50:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60BC06178B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:46:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d2so54440pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=52s7FW08R7DpqhS4R5cEv7/zvsq+dgo8h5Fd0aF2pR4=;
        b=SOUsRUyNfCjLX/Q4pA1+0lP4JflTe6dcOb0/7AhlReHCaUxrxANZ+YbVB/cy4oDCGt
         amdIA8YxvMkGNL2U8ylru3OhtG333qORhuM3XdlIEJZMSZeY4q+yCkhPhmZUIiELsghZ
         VaBVdMbRY5p45sGmBBoetRr149PlqnlZSb2Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=52s7FW08R7DpqhS4R5cEv7/zvsq+dgo8h5Fd0aF2pR4=;
        b=O/kwS1oQ4TH92R8o2sgUH4/uqpFzBKhkbVVtP4ImoU/UXwWJ1+VLQZSF8G8ZX9zXEy
         GKTrJHvuaB1bxfY+nlx1I/84/PeO8Qd0A8YZMG0A+MJGb+/Ok/0i1OxML4dPpQELR2rF
         jSb4EWlWISCLAOXXLMPa02Xb3GBzJ4bTZTNkb9pfkyz2z2912nUO+qXpr3yH3P19rNpv
         0rtJQvzzMJE7TYioVX5inWpPzoyaXl+SmuGJiIt208fskUL4UYIRH89y4VnZyw5v+yvV
         uI6nGHhTL6NV1CEADXJ/S8XvSKXk6l7qTvdePn4SSJCOO0dOyzO2rM60R3cIWdDGV25w
         dJuw==
X-Gm-Message-State: AOAM530NiolU9jZFYLneiU4LnjBeZQEce73x4fUcJSp6he1LF1+Dwy/H
        RHZoFxLQ9Gzk2SXu6yg9InOm0OIBeGi8Hg==
X-Google-Smtp-Source: ABdhPJwqv7dZS2tb3vob9nDjWJkwsqCWe2hGTUusox+ePNkpJW3EK2UT88TbZP6C/wn00N72RXygew==
X-Received: by 2002:a17:90a:c698:: with SMTP id n24mr1187456pjt.81.1614123993073;
        Tue, 23 Feb 2021 15:46:33 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id f2sm309168pfk.63.2021.02.23.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:46:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c7fd9642-7dcb-42bc-18e9-6fd86d8f5be8@codeaurora.org>
References: <20210223214539.1336155-1-swboyd@chromium.org> <20210223214539.1336155-4-swboyd@chromium.org> <c7fd9642-7dcb-42bc-18e9-6fd86d8f5be8@codeaurora.org>
Subject: Re: [PATCH 3/6] firmware: qcom_scm: Workaround lack of "is available" call on SC7180
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Date:   Tue, 23 Feb 2021 15:46:30 -0800
Message-ID: <161412399088.1254594.11162340495979939098@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2021-02-23 15:38:38)
> On 2/23/2021 2:45 PM, Stephen Boyd wrote:
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 21e07a464bd9..9ac84b5d6ce0 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -144,6 +145,18 @@ static enum qcom_scm_convention __get_convention(v=
oid)
> >       if (!ret && res.result[0] =3D=3D 1)
> >               goto found;
> >  =20
> > +     /*
> > +      * Some SC7180 firmwares didn't implement the
> > +      * QCOM_SCM_INFO_IS_CALL_AVAIL call, so we fallback to forcing AR=
M_64
> > +      * calling conventions on these firmwares. Luckily we don't make =
any
> > +      * early calls into the firmware on these SoCs so the device poin=
ter
> > +      * will be valid here to check if the compatible matches.
> > +      */
> > +     if (of_device_is_compatible(__scm ? __scm->dev->of_node : NULL, "=
qcom,scm-sc7180")) {
> > +             forced =3D true;
> > +             goto found;
> > +     }
>=20
> All SC7180 targets run DT?  None have ACPI?
>=20

Yes, as far as I know all sc7180 boards are using DT. If they aren't,
then presumably they implemented this QCOM_SCM_INFO_IS_CALL_AVAIL call
so this check is still fine.
