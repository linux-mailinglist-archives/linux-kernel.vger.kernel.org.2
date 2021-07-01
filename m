Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AFC3B983C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhGAVhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhGAVhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:37:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9FC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 14:34:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b2so12810655ejg.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPm2mNfDFAFz6LZYHsop45CBgdHBv6hIIQ/VkHD6NKA=;
        b=HvTjCzluEHCx88k64sQ1uGioAhhF0RaQdU2TKB3xXaeeJ5jaQe1vkBMflOMt0RMTxj
         iUISIublp8cNy2n9ZdkE02AYBeYCS1djQFxZvV2JGCHLdd66U9E93k7aFXQjQqUha4P3
         gRpV2RfUVWOWwQM5VAi6Iu2tuUxgsZtntXjHLJShIQOabUWw5/yhZM1Hznq5fkfwfPTZ
         d4U5x2mx1wgy1/l9DweE/vR+RveLBfEcovXEnJY8gbgzymFvtwmSmPVP3Rez8GQQcZeO
         PrNXkGm5v0mrRayTQyy39K48MnsXAF9RU2041qhATMIe45TwPkFjClaj2ONRwj87cH9L
         cDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPm2mNfDFAFz6LZYHsop45CBgdHBv6hIIQ/VkHD6NKA=;
        b=YwkgzuKdKa1Pvbmk7qwtKwjOAXCuOffNAWJeZ25ygH+ARJR1kZAyfPWknkzsM4oCGG
         RyD1b+USX1YTXW3xx43vX8vFO+VLWmSwnmgp0BvP/6wgEUupMaN6h/DqZuYsi+QXoIV5
         bBhHovDwjJQHKqe7ZbpJ0/ak20Yfs4vVYUjQPyTgaMxg+ZT71mFQVrYPeX+kvfHZlrUV
         j8IhAhJZyV4ag4sXCw64g6QcT34flya9Y1n9ROqVJ1LOzWChNGYTNJnIRUmLCE9wmoVA
         BFgXDGFeivDZr3AC/jke0W762vpS0TqwRv0SSRzDc0GbD99hCmEYxvWp4drQQli8toY4
         Z6TQ==
X-Gm-Message-State: AOAM532qXM57wco6kPsT53jPGnBloFsWQGwmu8DRSYGItuXqgEiW3cwK
        ztJow50jGwQM3Y2IvV+/6fbstZtoH0RKW4MVNC0=
X-Google-Smtp-Source: ABdhPJyZ3ThStcILU2DEuZlK8i1r5iDZm7d/h/AfGai6wlTFHJI9KAhQtrkXuxM3Ic6DSOSfkN1YPmywHBMsDeqD97Y=
X-Received: by 2002:a17:906:36d5:: with SMTP id b21mr2013027ejc.258.1625175287929;
 Thu, 01 Jul 2021 14:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210618052800.89007-1-jjcao20@fudan.edu.cn>
In-Reply-To: <20210618052800.89007-1-jjcao20@fudan.edu.cn>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 1 Jul 2021 23:34:37 +0200
Message-ID: <CAFBinCCGpbCNOcbgCZcLa1O8mJd0wgLtt4_sAMvwQW4xOxkuWg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/meson: fix potential NULL pointer exception in meson_drv_unbind()
To:     Jiajun Cao <jjcao20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all: thanks for your patch and sorry for being late with my
review question.

On Fri, Jun 18, 2021 at 7:28 AM Jiajun Cao <jjcao20@fudan.edu.cn> wrote:
>
> Fix a potential NULL pointer exception when meson_drv_unbind()
> attempts to operate on the driver_data priv which may be NULL.
> Add a null pointer check on the priv struct to avoid the NULL
> pointer dereference after calling dev_get_drvdata(), just like
> the null pointer checks done on the struct priv in the function
> meson_drv_shutdown(), meson_drv_pm_suspend() and meson_drv_pm_resume().
I am trying to review Amlogic Meson related patches in the DRM
subsystem so I can help Neil with this.
However, I am still new to this so please help me educate on this topic.

[...]
>  static void meson_drv_unbind(struct device *dev)
>  {
>         struct meson_drm *priv = dev_get_drvdata(dev);
> -       struct drm_device *drm = priv->drm;
> +       struct drm_device *drm;
> +
> +       if (!priv)
> +               return;
My understanding of the component framework is that meson_drv_unbind()
is only called if previously meson_drv_bind() was called (and did not
return any error).
This is different from meson_drv_shutdown() (for example) because that
can be called if meson_drv_probe() returns 0 (success) in case the
"count" variable was 0 (then the probe function does nothing).

As I mentioned before: I am still learning about the DRM subsystem in
the Linux kernel.
So it would be great if you could help me understand for which
scenarios this newly added if-condition is needed.


Thank you!
Best regards,
Martin
