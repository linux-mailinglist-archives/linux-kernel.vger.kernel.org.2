Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E58307193
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhA1IdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhA1Icw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:32:52 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60663C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:32:12 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d13so2941351plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=eSzw6mIxV1anumYEd5uTi6KNUqQBP7nI7s0j+BuQJKM=;
        b=Xk/UPOnjeUnDhjv4/G9R96IxcGex62ZM0aCmu6+KBcioI0KyRor9FkSLKehNdI1fhD
         MPvKBo8uIUHfnD3cMUyTC1CexCpIB1qD9nMns3IAip6axI7anNm0AISMaZRtu4byPS7n
         9MPo01d6pUjclwZOZ4Gzrntxl2HSWvkPMAIic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=eSzw6mIxV1anumYEd5uTi6KNUqQBP7nI7s0j+BuQJKM=;
        b=ZRc9y8XX30fjh+Zw+mSqmQquf/uqw+IjEO8kaUaFZd+++gYxQ4JuAmX/wxBwGh3Lgf
         JDACWOIAPE/UWP4k0BkpUkp4A/fYIHOMBPVyPLQyz+QKrqvO8QpJVqmwdoUa5N6wiB+X
         W5V12FkFOmpgQ8phJFgEcAJcC+DhjJ95pijn8wm220Gc6evtiY8zIMHceD6TKlqGF1R0
         FfrdNNgSmp2q0dWvRJZZa41yJEg+VK/f9A2HmJeIVrQ2b3bglh+kXez4MstIqUFtfz8K
         L3c5QOw2ya6BxKypdysAzshF1JzvDVyw3FmgTGFJybCnZzcW35PYkuS6gXlK4rp5cVyq
         Xgzw==
X-Gm-Message-State: AOAM531ffV8ju4ivyjiyDZe+0xaPppIb9WHlaWpbo3+w2BBQpzW6yMOG
        cZBhKJqIw2ddOUzgEo5PAkRYlw==
X-Google-Smtp-Source: ABdhPJwH9nc456YfHiJi2fnjqoiqcknCnXg4pOIY/9aaJ3LiJMef/3JDr9YjePbZZ+V+EStvxdYQUg==
X-Received: by 2002:a17:90a:ba02:: with SMTP id s2mr10330216pjr.53.1611822731937;
        Thu, 28 Jan 2021 00:32:11 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:304c:5453:303a:8268])
        by smtp.gmail.com with ESMTPSA id w14sm4263307pjl.38.2021.01.28.00.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:32:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUE2uuf-7h2Zjvb7bVqPb+=KSMKfAV-vopey1XwP0U+AGRZAA@mail.gmail.com>
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-4-swboyd@chromium.org> <20210124173820.4528b9c9@archlinux> <CAPUE2uuQsa7=pjw+D=r0QtLGTd1kQa7X6VBVa73=gx47Vf7KDA@mail.gmail.com> <161160076017.76967.4467861058817044169@swboyd.mtv.corp.google.com> <CAPUE2uu555NT1=u=1Nb8WExT7RvK8mj5kBiDfGymHiAmoj2WCg@mail.gmail.com> <161161826068.76967.15170332425672601158@swboyd.mtv.corp.google.com> <CAPUE2uuf-7h2Zjvb7bVqPb+=KSMKfAV-vopey1XwP0U+AGRZAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 28 Jan 2021 00:32:09 -0800
Message-ID: <161182272981.76967.6597234301739813412@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gwendal Grignou (2021-01-26 12:59:50)
> On Mon, Jan 25, 2021 at 3:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > instead of having to do
> > an offset after the fact. For now I'll use ec_dev->last_event_time
> > because this is only used on chromeos and that should work until
> > userspace is changed, but in the future I think we'll need to have a way
> > for this IIO device to be notified when the clock base changes in
> > iio_device_set_clock() and then have this driver call into cros_ec to
> > request that such a timestamp be made when this event is seen. Or even
> > better have a way to request that cros_ec timestamp the event itself on
> > the EC side, but I don't know if that's possible.
> One way would be use the EC sensor stack that collect such timestamp,
> but that would be more firmware changes.
>=20
> On second thought, to keep it simple and consistent with other IIO
> drivers, I suggest to keep using iio_get_time_ns() when the sensor
> clock is not CLOCK_BOOTTIME, ec_dev->last_event_time when it is.

Ok I will make that change and send v3.
