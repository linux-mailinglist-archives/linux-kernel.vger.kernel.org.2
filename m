Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E0307C08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhA1RQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhA1ROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:14:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3334C061786
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:13:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u4so4696825pjn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=RTCwQ6idBvNf4uzhJTxOr5uDgE8WbwtuLbYvkB+sTzs=;
        b=U/8OY+KI1ZGc6TX2w1Oh3N+HXRWoDT83AfiQM5PIeoPpITDSHwYpm6goWCcHlPyyvZ
         b+XT3MFxs6tj6zQ1ikZXib49Lyco4SxWJ0yR4OjlUUwQHipdpKlX7h3XE08LoMN2YKGv
         YoydgyGEW4Nyk76lqcZ5bNN35XCOaXrALMli8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=RTCwQ6idBvNf4uzhJTxOr5uDgE8WbwtuLbYvkB+sTzs=;
        b=etmAwFGvS9WwjBWZYnPsA3ibUxFQqAxnkVg1pR49FSPEbQY4GuSNkTu7v0eRNOTH+F
         S6KV5YL8qpq00EEkXaAzBaRPLVMMRBDsE+Od0JwCgsoNYHR2VMYMFZCDCyhKQleGTM9a
         5+WjjfcafrnHGP9QXgMLTYc8k5Oec0Jx6gpTkqfJVCZmr4TfrUHtKFGOgcbrlPMySQLH
         RLoUStTzJ6zBPV5sGTuDTWRK7T7RNvKRC3cmAaQ6zV0WWUy85In8wF9xkDu0wLknD3AI
         mdi4VGxbioQS2Dci6MFrSp2e1BlWkhmnbWtkaS3tfFO/6Z855dyzYi+tWQZkuZWhmAPD
         erYQ==
X-Gm-Message-State: AOAM532SnOu8U2VOQqSJYrFb7zKkTpoMkFXMt7jb9RU0lK0NhQmhuir7
        9UikLNm+h5QLForCjdwDXzUgYw==
X-Google-Smtp-Source: ABdhPJx1nO/yZUgqARr1Kfsf0gI7HtzTqT/4LdCVbwlBM/QROCCzKAhRYnNZ4dAvYndjKpdiupz5xg==
X-Received: by 2002:a17:90b:949:: with SMTP id dw9mr400132pjb.20.1611854014610;
        Thu, 28 Jan 2021 09:13:34 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:304c:5453:303a:8268])
        by smtp.gmail.com with ESMTPSA id y12sm6429514pfp.166.2021.01.28.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:13:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFqH_517Wf42Y4-d+3cgbGh-XC4ujzNnQUaX2kMkF1nJ=v7FuA@mail.gmail.com>
References: <20210128084011.3270281-1-swboyd@chromium.org> <20210128084011.3270281-4-swboyd@chromium.org> <CAFqH_517Wf42Y4-d+3cgbGh-XC4ujzNnQUaX2kMkF1nJ=v7FuA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Jan 2021 09:13:32 -0800
Message-ID: <161185401247.76967.894387173080815413@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enric Balletbo Serra (2021-01-28 01:58:48)
> Missatge de Stephen Boyd <swboyd@chromium.org> del dia dj., 28 de gen.
> 2021 a les 9:48:
> > diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/i=
io/proximity/cros_ec_mkbp_proximity.c
> > new file mode 100644
> > index 000000000000..c8f33cf11b42
> > --- /dev/null
> > +++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> > @@ -0,0 +1,245 @@
> > +       data->notifier.notifier_call =3D cros_ec_mkbp_proximity_notify;
> > +       ret =3D blocking_notifier_chain_register(&ec->event_notifier,
> > +                                              &data->notifier);
> > +       if (ret)
> > +               dev_err(dev, "cannot register notifier: %d\n", ret);
> > +
> > +       return ret;
>=20
> blocking_notifier_chain_register always return 0, so the error path
> will never happen, you can simplify this a bit with directly:
>=20
> return blocking_notifier_chain_register(&ec->event_notifier, &data->notif=
ier);
>=20
> Other than this minor nit
>=20
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>=20

Cool thanks! I've rolled it into a v4 but I'll wait a day or so for any
more comments before sending again.
