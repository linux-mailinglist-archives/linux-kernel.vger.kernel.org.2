Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185FB39E4F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhFGRJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhFGRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:09:27 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E39C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 10:07:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so17422621otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vmc21GFO17uaFIYIEI6ngL7qf7K+9zFe/VHNqdjyLTk=;
        b=Sw3lO1CuIlIW8p7F9X3EIJWbHqckmdlxzrp7zumdiztpcK0kS+1dg7doroe67j7AiX
         6ISqph79TFZjX9hMy/r/UF0kMeh+9gTRwhS6SEVotj3vIXHu9xL9KDu9UuiK20DXefxL
         8T3IDs+fg77gOa1QGIfGtyYVVNonxe2aZ5rrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vmc21GFO17uaFIYIEI6ngL7qf7K+9zFe/VHNqdjyLTk=;
        b=JHChNhYOdzrhntGBM0/9Pyf9hzWCUepMD0jznSxdoAVU5JMVFI1BETb+m7hNFswcHI
         zBHgmZRdBoP6/e5l2SfqZTUd/RNFV7euGieFxi4y5SZAH9LTaw077lsg90Wm7W8UaFRP
         zPLocwm0MjSZF2/TIywi9dKHtv19blsGezpu4ICktnaOXlv9ImrLNyQrsOT0638wSMDP
         89DPrt7n3HVmUpmqaVkPiHLV+sWVqdRKoEQI46roDPKdCZA+JQM/inFynmimW4WW/FNQ
         RyhVr8NLPkpnOCGK9JfWKjug0q7RaGc5EC2NVdKORTeE+A7KhhPYXoyGM+DK0FC9gRQZ
         LviA==
X-Gm-Message-State: AOAM532L58KaoqtXWyIBNmFEqlPyb1FnoYru4A3A0QhIfAfLkSLaDnvt
        gB/NC25hQAGQOk86wlqGZki+q3eHOTl4Iw==
X-Google-Smtp-Source: ABdhPJwJSsVFawWaQiW133V0oIHLBacLJpSRGPzdBNsbUDOp0GbIhQ4m3Z+ZVwQKwG8xzfaIWgyUwA==
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr12374013otr.330.1623085655543;
        Mon, 07 Jun 2021 10:07:35 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id j3sm218958oii.46.2021.06.07.10.07.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 10:07:35 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so17456860otg.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:07:35 -0700 (PDT)
X-Received: by 2002:a25:ab4b:: with SMTP id u69mr25982035ybi.276.1623085644485;
 Mon, 07 Jun 2021 10:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210525000159.3384921-1-dianders@chromium.org>
 <20210524165920.v8.8.If89144992cb9d900f8c91a8d1817dbe00f543720@changeid> <YLxRyC9eNlg+Uex3@builder.lan>
In-Reply-To: <YLxRyC9eNlg+Uex3@builder.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Jun 2021 10:07:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZkzKG6EJFAU9jCjb-twChzCH+JtcL5a9VyO5dxSdOwA@mail.gmail.com>
Message-ID: <CAD=FV=UZkzKG6EJFAU9jCjb-twChzCH+JtcL5a9VyO5dxSdOwA@mail.gmail.com>
Subject: Re: [PATCH v8 08/11] drm/bridge: ti-sn65dsi86: Promote the AUX
 channel to its own sub-dev
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linus W <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 5, 2021 at 9:40 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> > +     /*
> > +      * We couldn't do this pre-probe because it would confuse pinctrl.
> > +      * It would have tried to grab the same pins that the main device had.
> > +      * Set it now so that we can put the proper (sub) device in the aux
> > +      * structure and it will have the right node.
> > +      */
> > +     adev->dev.of_node = pdata->dev->of_node;
>
> I suspect the refcount of the of_node will be wrong here and upon
> removing the aux device things will be off...
>
> Instead, I think you're looking for device_set_of_node_from_dev(), which
> also sets of_node_reused, which in turn causes pinctrl_bind_pins() to be
> skipped - i.e. it seems to deal with the problem your comment describes.

You rock! This is exactly what I wanted. I wish I had thought to look
for it--I somehow just assumed that this wasn't already a solved
problem.

-Doug
