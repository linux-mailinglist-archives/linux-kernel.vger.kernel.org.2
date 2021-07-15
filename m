Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44EA3C9933
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhGOG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:57:41 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:44644 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhGOG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:57:41 -0400
Received: by mail-vk1-f175.google.com with SMTP id s74so1066825vka.11;
        Wed, 14 Jul 2021 23:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTwyBQY31SR0k9D6ud/qHazq+KVSjgeC457BWvTVmiM=;
        b=Oo378yNP9ynS3pY2feOGPtF7AswYcrwi85ucqMny0fgQEdMfLkpTbVUQGee33sUUEC
         EIfc9d24ATuRYOZqJzrAfcjZjY0trhLnGpL5Fao1iivahIdul8KcobwIKjlBU7STzFK9
         cOMvb/bxpu2fg2OQl2cmAxiSp4xHzlFY9MTMTFKP5wrgtnQmeHOivyy2XXEjc5pppvc+
         NxYcYJXeGVL8KRqruCJp6lvrRYB1IDcAKSvkrXZGlL/jsDxO3CZV7ysNLoXLt2ooYAsv
         AdAMQ/adoCGi2HDkJghRqveGXTWImfOKD8jIJq5niMAjJOMessV30S6tN46be/KWTVUu
         MSNQ==
X-Gm-Message-State: AOAM5302gGzMmOxQonohirC3jVbygbJUwzemjQRzS9YVUj5XzwHcB7Z6
        /Rkre7Ac/pICYt6IdjoaIZONHaJ8VXqX3ObccDk=
X-Google-Smtp-Source: ABdhPJwpwUUWe4BFauukF4jBR4wGnmFd1K5ch7H5PTp1oLbLQs8rxa4S50A9H18uIxoc8/R0vmbeR/Pfefns8mnnR08=
X-Received: by 2002:a05:6122:a12:: with SMTP id 18mr3950937vkn.1.1626332088002;
 Wed, 14 Jul 2021 23:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210714145804.2530727-1-geert@linux-m68k.org> <YO8CT+Hcw1wfhnH5@ravnborg.org>
In-Reply-To: <YO8CT+Hcw1wfhnH5@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Jul 2021 08:54:36 +0200
Message-ID: <CAMuHMdVjXhTE2x8mRrinmh9CCrdXQr+BYPfP-peaZ4AsLwsaaA@mail.gmail.com>
Subject: Re: [PATCH resend 0/5] video: fbdev: ssd1307fb: Optimizations and improvements
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Wed, Jul 14, 2021 at 5:27 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jul 14, 2021 at 04:57:59PM +0200, Geert Uytterhoeven wrote:
> > This patch series optimizes console operations on ssd1307fb, after the
> > customary fixes and cleanups.
>
> What is required to to have a drm driver that could do the same?

Add monochrome support to DRM?

> Note: I will take a look at the patches a bit later.

TIA!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
