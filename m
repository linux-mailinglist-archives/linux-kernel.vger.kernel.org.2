Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73773FA18D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhH0Wgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhH0Wgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:36:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD00C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:36:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z2so17458658lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WVVH9tPnPAEwCiy7b+h6cy2lK7RVxZQc0+q/RmNQO0=;
        b=w+XxRhljzWKRhihK4B69S/2fTaOrvR0DPx8n5kFl9Lb1xho82Q50J3Pz5FClh5mlNJ
         pBh3/2nxRCEH06/WAdSImiLR75j5eXTY/d/EgYcm+DL+as8La7kPxssFTuBJo2xzR15I
         SIo6dFJRzkudWfMJzE8AfEdQKSG4MFHKJVwsyoebzU0Dkt9AwiioUW71knv/QYjORR33
         hAz/lOv5I31jsAHpRkAPU+IqTiD34ifVqzgxpkP1azbtUZ96vjjX0wERP1kokLyRgzfK
         azS2lOq641kfBG+sFhYSRCkmDqrzf9QO4zi0Pc0UUisbfmYF1XhfF1nJNNb+A8Yr3LHr
         zY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WVVH9tPnPAEwCiy7b+h6cy2lK7RVxZQc0+q/RmNQO0=;
        b=ediYMzRaEg0Bs7OSXAmVjPR87HhN5NwUikS32ZYFj5CwUXDxzkuY+ismjD/jQJfxEl
         qw2vME7sTqhmg5tUa+nlWBC68Casy7N77rApDrb0f1rCtbox5kYLgjnQtj2FuAd6Npy/
         FKz2cruEodd1Nfi1D5UFGKXZj3Fbrx/zHkIXgjeQZHZEc1UdObDmIuxZQcMz2DAFtPmU
         KIu/KuFNripEvpSHkexEDEezMJvAXIU3ekFboaIeW9/XQ+skbBxnrTs21In+uEYkRoNT
         axzn6YJProelZyDixG+i/oOguIThkbq4eU113UEryFQE3ejBx/JVNnegpbSIM1dwtIqT
         4dLA==
X-Gm-Message-State: AOAM531R50izfYekBR6KttPzjx9PATYf5FESJ09vu6tA9APS1jCQuefR
        ef8fT9vtMvrjUbqIqCOsRRD+fXvvc6c/OnjemyU9QA==
X-Google-Smtp-Source: ABdhPJzzjnsODBHOPULhcJ0PXZ1ACw5fiKNxLGylWRuALwEEPh15NutVUU3/OqwWJh6P696sYRI1UQQg7QjcjirQVEM=
X-Received: by 2002:a19:c107:: with SMTP id r7mr8336002lff.29.1630103762773;
 Fri, 27 Aug 2021 15:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210823112204.243255-1-aardelean@deviqon.com> <20210823112204.243255-6-aardelean@deviqon.com>
In-Reply-To: <20210823112204.243255-6-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Aug 2021 00:35:51 +0200
Message-ID: <CACRpkdZF92yNO4ypk-Ue8+ygGo8UvQaJ_vs=qzAOXOShEO=QyQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] iio: st_sensors: remove reference to parent device
 object on st_sensor_data
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 1:22 PM Alexandru Ardelean
<aardelean@deviqon.com> wrote:

> The idea behind it, is that all devm_ calls in ST sensors are bound to the
> parent device object.
>
> However, the reference to that object is kept on both the st_sensor_data
> struct and the IIO object parent (indio_dev->dev.parent).
>
> This change only adds a bit consistency and uses the reference stored on
> indio_dev->dev.parent, to enforce the assumption that all ST sensors' devm_
> calls are bound to the same reference as the one store on st_sensor_data.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
