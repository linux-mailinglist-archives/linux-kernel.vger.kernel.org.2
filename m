Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA2413E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 02:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhIVA0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 20:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhIVA0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 20:26:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:24:52 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso979449otr.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=LoJE11wHmqt1nX2FPOVtgACQFiswcqUt0WgjAJ5CbbE=;
        b=K990CqCVLUnVh7CAt4m/Bv6bAFLRjv1xOEWl6leV2W5NqYDn/EGTx9nAHwn7COn0z6
         116CcjDaDaphgRz3hkE2w1pq/ifOIF0PVtatoH9eGC5gG7Jg5gKDFxF3y9Apg7QIWUsD
         Y/wSjvdJP5uc7QVAXfPeAOlYxYBsMBRZ1U2KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=LoJE11wHmqt1nX2FPOVtgACQFiswcqUt0WgjAJ5CbbE=;
        b=VKyjfSMzJKchyPi8MidWtQgR7cGneIAu8djK/IJ1ZYcmRb3VhxojjSLcptEIGYxMDl
         CYVRrRmIApmt+G7MgFgRg8zSoJb2sWxs5C0Wm3HmEUikQrg1Mtso+zvvyYs8U9jI8PHq
         xqMzz0Z5NVzkT4Ug3RvibkRbMQUtUJHcNRLcMAsr74P8ou6HLlj076vTAxT+suTEOTeb
         f5cnEdZhIypEB3y0j99NRQCkpZJEyKXzTJzEJRcAOLLtWKblV35MeKC8ZWlzuOcEuMXW
         RMbI0I1XtKIN9XVjqbk0marx7V7x65YYJniFLaR2C/FRuu6EPCGIBJmfPqlliGRkTEvG
         0qHQ==
X-Gm-Message-State: AOAM532wrp/0JkNt4FPrdTujpJdwycx15BIgxRt79Rsa7JJq7krbVAea
        c3zyKoV5ki2RrKQ5mb+ooy6XM2pLuWv8BzQCVQEgYAXkEKY=
X-Google-Smtp-Source: ABdhPJweHEttDkxTJ6EzvLg6rBvD920u8NzeaKnCUYKjO2wfHXPsWSNZixV3jw8VmUGTDMmO+ONaqY8esGhoZi1uLzg=
X-Received: by 2002:a05:6830:708:: with SMTP id y8mr8045538ots.77.1632270292281;
 Tue, 21 Sep 2021 17:24:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Sep 2021 17:24:51 -0700
MIME-Version: 1.0
In-Reply-To: <20210921110556.v6.2.I1d6ea362dc76efa77cca2b46253d31b7651eaf17@changeid>
References: <20210921110556.v6.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
 <20210921110556.v6.2.I1d6ea362dc76efa77cca2b46253d31b7651eaf17@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 21 Sep 2021 17:24:51 -0700
Message-ID: <CAE-0n51+kYSsgNtqMk=9cicUDW0bM6DYfgvWLpdpbacXQjDDFg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm/bridge: parade-ps8640: Add support for AUX channel
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

Quoting Philip Chen (2021-09-21 11:06:17)
> Implement the first version of AUX support, which will be useful as
> we expand the driver to support varied use cases.
>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
