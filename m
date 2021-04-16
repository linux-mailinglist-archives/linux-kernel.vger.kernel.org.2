Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA843619CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhDPGZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhDPGZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:25:38 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF414C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 23:25:12 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c123so22994120qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z/a0vQssthNawacQM/DKA0NqIqx/4q8LyjyKHWk53zc=;
        b=hjHk7ksTlfpOJgy21RNs2wSa9lwcSSeTHdXcQvpfMcOvMti7TL8x5NwB8be77zNWnN
         MLcoS76ZXkn48ViQFGegS83T/LgQk4hEBsMUEhy4rkhVlDBt5fV7wCRZ/f7Uzav5v1Ns
         lHmIUoLBQ8BM9Dlsxp1Pocb+pTodafepkKkp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z/a0vQssthNawacQM/DKA0NqIqx/4q8LyjyKHWk53zc=;
        b=PbOI4WQb1ssq6WejQ5AZzl8AyEmKCdMb4O1GMhjicCR/rAHgKvPNy6vsylXVYO2rT5
         Mfi59xsGRgmHf5BToJjV0LDadKDQ/5fLbz8JIYF384uc5d6MXVGheGr3zQYkZrSRqdYS
         Bk21jUK+/4OQZLZGcsaNAWfCf7hdnDg6Q1pZ5u+CgtXUEsnuvdxNsjE27WxSNyVduC0K
         VHknU3vm6D6AjC6P7lqnJpssCdNyleIdp/OmCESLQEzEcdg9KCcoqyH4yHOAnvVuhvjR
         HnFATi7O3u/tQMZzaHluZhZj5bXlS64rxS2ah55hsqX/6LLwbctm6UiRHnBfIb09nTKO
         HdmQ==
X-Gm-Message-State: AOAM5334q1+7fJkzj/WfOzu5ruXrXvy+EoAo/ZOhJ4d30TTmp0uh8qxL
        jZYDIKa+Qqt59VKxozz8RdjOze0mwE5lEU9Jl0QRDA==
X-Google-Smtp-Source: ABdhPJwd4YgvQ5mhRNJ+5opg2ENes2j2o5bTwX98VYt2hC+0sM6cmtJZOcjNGYKT4NbWYwCe/T4xW0CMlvXUZXmBXZQ=
X-Received: by 2002:ae9:eb4d:: with SMTP id b74mr7715382qkg.4.1618554312114;
 Thu, 15 Apr 2021 23:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210415021456.1805797-1-pmalani@chromium.org> <CAFqH_53KBrjeZG5k1npbboLOGcbPv3_8_dTQ-ZsJcUwvKAY1nA@mail.gmail.com>
In-Reply-To: <CAFqH_53KBrjeZG5k1npbboLOGcbPv3_8_dTQ-ZsJcUwvKAY1nA@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 15 Apr 2021 23:25:00 -0700
Message-ID: <CACeCKadCASMrAY4RPn4mZ8L0+nv2BopiRb-S2=Lb4ijWXr-z3w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle hard reset
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for taking a look.

On Thu, Apr 15, 2021 at 10:39 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Prashant,
>
> Thank you for your patch.
>
> Missatge de Prashant Malani <pmalani@chromium.org> del dia dj., 15
> d=E2=80=99abr. 2021 a les 4:15:
> >
> > The Chrome Embedded Controller (EC) generates a hard reset type C event
> > when a USB Power Delivery (PD) hard reset is encountered. Handle this
> > event by unregistering the partner and cable on the associated port and
> > clearing the event flag.
> >
> > Also update the EC command header to include the new event bit. This bi=
t
> > is included in the latest version of the Chrome EC headers[1].
> >
> > [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/hea=
ds/main/include/ec_commands.h
> >
> > Cc: Benson Leung <bleung@chromium.org>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c        | 13 +++++++++++++
> >  include/linux/platform_data/cros_ec_commands.h |  1 +
>
> Could this be a separate patch?

Sure. I'll send a v2 with them split up.
