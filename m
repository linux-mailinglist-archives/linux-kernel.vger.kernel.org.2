Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13740CE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhIOVCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhIOVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:02:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01259C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:00:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i25so9610761lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6051UbgrRMqDxiwjhzZkrwFi5IKkmuXa1gzwXfPNWkw=;
        b=V9NRrB2CS1yeigqK9Ue6Dtwu1U6p2jRsXG+HSc0iLZA6dsDHxkcqMA9s8nU/IAI5du
         TUzkThscVDc4LqTE0D4bNdDMJnI39D4Cvv4pin63v/fGhIgvWapPi8fM1PJ+dzbsjAJn
         4CuWWXQxZz2acwXCDbCtSfNxiAMJys+bcXLvzBz9zQWUxyV+TudQpal5XXhPQa1xysjz
         og8Ri3Hx5q3ohoNhs7msnZO3P3n63Y++vMD+ITHHGxK0DO984wKzDmfp3wcR3WghBEYB
         OUdF15j4QfzV/LVEk63ATcGIgYiomSE3zSd5hdR13ROBBRgE24iAi4MurR5fh9xiVHKa
         CPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6051UbgrRMqDxiwjhzZkrwFi5IKkmuXa1gzwXfPNWkw=;
        b=gB5xbGVfNxnXky0882T3NE6zVrTz80aukIGEAR/F1/eJvdcW0FsudhyB4P9h4MGsVk
         /mIlSrwGeQIC+qrEAbH7MMsjRmGmCQDJI21aKzfap5dImFfxHuD2yH/yJkja8N9YrvIh
         8oDuy0Yeo42zTW1e84GvvzAdYSWIcP0fWiH7ndXW38u7zS6Bv7isPVn4Rp5TjMgS5hnj
         euBUYet4W22c0K+lRIqoFihdgB3OPdpL+RSHDH+rRiNP8YiZQnctwLEsg1HWPm1/7Ubg
         Tu4SiAcl1AH68m5107hGwyVkYI+wfyVh17QUKTJcOPM4NeDGjvmA2WGm5QzqJXPBVAfl
         CuDQ==
X-Gm-Message-State: AOAM5320LMC2RUL9XG99NgtD0sch+0avQ+HEgWpuhJi/xYx2tLDi1GpM
        /L3N3GBHi8GSY2xRaYGmAEhJgChKnjZ/qNUfAZ4=
X-Google-Smtp-Source: ABdhPJzwTh8ZGukPXzZsfLlsL05t09qPNouVPdAoTX8yDhkINktq09DsX8rU+3tF3qfGORyB1CbOY+VDqpFMaB7eJX8=
X-Received: by 2002:ac2:5d49:: with SMTP id w9mr1379832lfd.450.1631739639394;
 Wed, 15 Sep 2021 14:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.3.Ibf9b125434e3806b35f9079f6d8125578d76f138@changeid>
 <CAE-0n51JFM_yYdOsCQyvdMw5xXJ7REcbOJC6qi=6nfiNcdvnWw@mail.gmail.com> <CA+cxXhn-gLt37oyEq3wSh3qf=UkY=H6fY3ahC=gyhKhGwu_dXw@mail.gmail.com>
In-Reply-To: <CA+cxXhn-gLt37oyEq3wSh3qf=UkY=H6fY3ahC=gyhKhGwu_dXw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 15 Sep 2021 18:00:27 -0300
Message-ID: <CAOMZO5B_J29npC+yu2freuwNLjKAmwas7gVaB6qRabAmVWy2KQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Philip Chen <philipchen@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 5:41 PM Philip Chen <philipchen@chromium.org> wrote:

> As regmap_read() should always read 1 byte at a time, should I just do:
> regmap_read(map, PAGE0_SWAUX_RDATA, (unsigned int*)(buf + i))

There is also regmap_bulk_read() if you need to read more data.
