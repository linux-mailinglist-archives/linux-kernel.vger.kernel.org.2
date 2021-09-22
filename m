Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7182F413E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 02:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhIVA0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 20:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhIVAZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 20:25:59 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734ECC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:24:30 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id a3so1826806oid.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Hf6Vp80+wIn/KQ49ssxtpe6J0FEpDcx3iJaae+hOiS4=;
        b=MR5A5PaM8kTVWrRY5xBSFlPjfMBjW6eAbL3P9GdXpswPZNYKj9wqCll697/9rVEhBv
         7Xf9idcgBtPmWxERSix4BsI/dZMRCGek9p+/PixgZeSNTSFzaUI4tN1ohK5r1MV7STc/
         Hq4I5Ej4ROOJBGi3UK3DHEhzOPQXAS+NbK6ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Hf6Vp80+wIn/KQ49ssxtpe6J0FEpDcx3iJaae+hOiS4=;
        b=l2jeNA+Nms93lQ+6Up43s963QFApC+9a4QhBYWvaNbH7kQhJg6iOKsUHvQ+lzP6U25
         527lKPlqdGVolGsCQJnUCOJmsKbVFRStRPP/Ypeh+UG24JMWdbz7ov8icv7wUZfTO50z
         tcKsiTTo17NCcgQSM5C8G1aOqCR0iciRa8zaFTmQleEJ8kRJlb/OE9eoQN9uYMfbDlhg
         2wnsYie51WmkBCQLvj96lkmVncJXEGKNY5edIbHqSju05hUc9rmeo4wwbh7urGd9EPNH
         j5ChYHG7wyVRg8IiqYfAl0PqFuGpjX+d+33XtGIFhUILFltkVERUsnRLaTndq/MfYFf2
         KsTg==
X-Gm-Message-State: AOAM530sFxpVrEHSPC7S55McjwYSLnRweLNmwgO1wGJ+OpfWNF/NuXFv
        DXyJOs43SZqkJGuePFWcHK+Ezh3ouU8vPjoKXUJdR+xae+E=
X-Google-Smtp-Source: ABdhPJy+7x+o01xSRcYL1tP3gc/HLpDYlxHmu9rG3Eq6t1GkJCp7L77UDYrdDQYJ9J3mh6xNGheKnMg3238u+Tv1eHE=
X-Received: by 2002:aca:3110:: with SMTP id x16mr5889098oix.64.1632270269763;
 Tue, 21 Sep 2021 17:24:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Sep 2021 17:24:29 -0700
MIME-Version: 1.0
In-Reply-To: <20210921110556.v6.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
References: <20210921110556.v6.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 21 Sep 2021 17:24:29 -0700
Message-ID: <CAE-0n53A6VOqnCakvHJ+AwiHcZRnkZ+XAhCgXOZce53SDr-B6g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] drm/bridge: parade-ps8640: Use regmap APIs
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-09-21 11:06:16)
> Replace the direct i2c access (i2c_smbus_* functions) with regmap APIs,
> which will simplify the future update on ps8640 driver.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
