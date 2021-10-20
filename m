Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501344343C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 05:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJTDUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 23:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTDUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 23:20:16 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70176C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 20:18:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id b12so1884942qtq.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 20:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iJYDVLjsvklhkB8c9DS9a2c0Jh+LbYNPXRZM+lUHyU=;
        b=dlknk3fvHcefbDwA7M7vdCrCxkeLeNWx6O+1vztgPe7LjMcpUWKOopTdVBv7hrfaR9
         1ZC3hB6rb0/edHB7evPnZM8kRP+4u9PqwGx0Yl5AjxDb1Vk7FQCw4r/cTI6I4d8xj+Yz
         dBH6gjgYRJO99GlFZC5l9L5CTCnjUrQl3cm98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iJYDVLjsvklhkB8c9DS9a2c0Jh+LbYNPXRZM+lUHyU=;
        b=3dun4hUPVI6V2iCFevHxr91dzHEawbrD5xWfkOPeMLkRw3i87XwzRjZN7CT1/brsz4
         pdocnX0ODK/ryCT5EIEccS0CAKIhuWx+Rvi6aAJcnbLd/kLgv3Mv23HrZA/I3DlSiF+m
         TwXVzbwzeWcp1jTh7lPWnSwarWKBbyZNS9uIgJcKHa0ndpMVtXsYU3KAoT/04YknkVOe
         7BQ1LvwDoRbFjijrFiw+679D42oYnI8+HCHZRXsXEaZdZddDzBFcZcv3STSs3STuI9r9
         Mdh3zjbmc9CQQrnve7I50guzCRxan4PiPS5r/YWqdAdDDeQRHK6etKHPKrncXo913kSu
         1Ldw==
X-Gm-Message-State: AOAM530xpUGThBVRmMbhBUZUP0PyjumAlUUAewaIDK5bwSY3W1uHT+B4
        6eBA0QqEJB94h6RI9BJ8nCFoH36MTCuOLQ==
X-Google-Smtp-Source: ABdhPJybvFZrUFtDF0w1XY5s2Wki3pKUHCQE6xLvLaPle4E0yB4YF3OKXD6Vx50pW2oru7fgeswk8g==
X-Received: by 2002:ac8:138b:: with SMTP id h11mr4195403qtj.80.1634699881189;
        Tue, 19 Oct 2021 20:18:01 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id m14sm431501qtq.74.2021.10.19.20.18.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 20:18:00 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id n65so8755454ybb.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 20:18:00 -0700 (PDT)
X-Received: by 2002:a25:2d65:: with SMTP id s37mr43305821ybe.511.1634699879553;
 Tue, 19 Oct 2021 20:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211019175932.1.I96669f75475cbb0ae1749940217876aa8991b703@changeid>
In-Reply-To: <20211019175932.1.I96669f75475cbb0ae1749940217876aa8991b703@changeid>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Tue, 19 Oct 2021 23:17:22 -0400
X-Gmail-Original-Message-ID: <CAOw6vbJKayd=qeZ2yU+AnT06K4nop45AP2bjdPDLNZOTwaxbHQ@mail.gmail.com>
Message-ID: <CAOw6vbJKayd=qeZ2yU+AnT06K4nop45AP2bjdPDLNZOTwaxbHQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Fixup drm-misc website link
To:     Brian Norris <briannorris@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 9:00 PM Brian Norris <briannorris@chromium.org> wrote:
>
> https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html gives
> HTTP 404, and https://drm.pages.freedesktop.org/maintainer-tools/
> redirects to freedesktop.org now.
>
> Let's save people the pain of figuring that out.
>

Nice catch!

Reviewed-by: Sean Paul <seanpaul@chromium.org>

(fwiw)

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 100d7f93a15b..811d8d3e35fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6158,7 +6158,7 @@ M:        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>  M:     Maxime Ripard <mripard@kernel.org>
>  M:     Thomas Zimmermann <tzimmermann@suse.de>
>  S:     Maintained
> -W:     https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
> +W:     https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
>  T:     git git://anongit.freedesktop.org/drm/drm-misc
>  F:     Documentation/gpu/
>  F:     drivers/gpu/drm/*
> --
> 2.33.0.1079.g6e70778dc9-goog
>
