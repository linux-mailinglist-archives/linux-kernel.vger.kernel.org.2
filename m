Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D01337902
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhCKQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbhCKQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:16:05 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFA2C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:16:05 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 184so2862075ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfYyTSB6sN53w9Rpv4MYqNBv1FPOEZ0SmWjIhTyeJxs=;
        b=w7gbpWGeeJ+LlzySG7BIYUktxr5ZW6HHVY4+kDsfrOjR8+uCX7UfS12tge1fIba7bN
         siJe30TAnw+/h3qtte6NL8++/XN56VXtXOlGG2vrWXs32XJku7afWUNsnk0tLSZgaoRP
         qIZ/4GmtZ1i9oNXcd8zXNQVIY3z/cXgu/HYe6RiK/HznG1JHC1RnGEO26o+3Kc7Gu24t
         mDKnOJnUQbaI2aW18KnCx1bzYgbMjT0hOd0+44R+gc8vZc2nH65LvMln58GGsQgDMGjl
         svz66W78wmfOTwVlEZMQmHrfQk2qoRs3WoDHpHpgjVjwpj29LtQx6vil16mwBYI1Xq9f
         qtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfYyTSB6sN53w9Rpv4MYqNBv1FPOEZ0SmWjIhTyeJxs=;
        b=b1mo/c207NHo878hE5R6UYejVXBJOoBo4N6sZB4+DTYq1lRkYrIar9AOMmBMMNSvLE
         BDWrxtdOF2KsZ8rd3+FcmDjwfXLQE3SUB21DOF/2eisvqZa0WyXl8VN8GrONX9NnE1vM
         wltllH8Oy5tZ+wh6wMU6g98bZZvSEEZtoNvK5jOD94q16Ec/MTWL3v32M+ilXxfZntfK
         NDZiAvHm7REdxa90vDO0iIb41uXJeqnjKonXJV4jkW0U/LycRC4mYMTSRDM8ftg86zQh
         Z5NhrIicTfb+nGVTDyBgULbdcYqK0pA1Ed+9NrlHv0L1wWnRwLzUJ93qZIhfK1FmPmcP
         g2xQ==
X-Gm-Message-State: AOAM53289TiV8jkC6YyKGoW4t5/Wd22UMmvxn+pFHryYfBQvvWzLZEal
        WVIKhwttLkoULy4hu7cR8fJrvOSU2ETOk2klOZ5BwQ==
X-Google-Smtp-Source: ABdhPJxjSHy1zm8V6vPLxd2/BZt39BMm+ldl/7gvjdw+kLTDN0YCYgFmd4U2bedbP56ygtsRdV6mIHbZc0eUiDGxSiE=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr5292190ljc.368.1615479363631;
 Thu, 11 Mar 2021 08:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org>
In-Reply-To: <20210115224420.1635017-1-dianders@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 17:15:52 +0100
Message-ID: <CACRpkdY0h0kEE_63y7wyc=0etTe0Bfn+EmWpfQSe7g2KcfTvhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/panel-simple: Patches for N116BCA-EA1
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:44 PM Douglas Anderson <dianders@chromium.org> wrote:

> This series is to get the N116BCA-EA1 panel working. Most of the
> patches are simple, but on hardware I have in front of me the panel
> sometimes doesn't come up. I'm still working with the hardware
> manufacturer to get to the bottom of it, but I've got it working with
> retries. Adding the retries doesn't seem like an insane thing to do
> and makes some of the error handling more robust, so I've gone ahead
> and included those patches here. Hopefully they look OK.
>
> Changes in v2:

This v2 version applied to drm-misc-next.

Yours,
Linus Walleij
