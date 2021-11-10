Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABAB44C515
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhKJQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhKJQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:37:35 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B8C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 08:34:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f8so13062981edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7ZipcyAMf+xy36NA8v+/8GugYRNsmRJnapkEJJAuo8=;
        b=AN7ihFhjpK99DwvsrHZTWnVZFdr0KauEAy4C642JZMx6uWHHaTpAnWvASF2sWaL+LZ
         j1X+B2UIM2KAcBTsufog1zwVYcsaa+A9+q37yuSGu4rq5L7cKdE+ob6GQ1j2mO9D6A32
         eh6FwiG2BMPQNPu35fyKS3uzX4J86FTN8fXGxtLg+YmcFrQlT/waHDfkc9lg68UNWXh8
         rALqoQfebjEjWhRnnNQN9Cwg+f9R0I0F9dm0B058Yb3PMBJYpJx78Kq+2sZfd2I/fT7F
         WiwuK+Ctp5LTvJtor0aeVrank2VNyEwYT0Ed3LDRKOZ9z9UyQIIgsWeWRp1oFnQa2xF3
         FfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7ZipcyAMf+xy36NA8v+/8GugYRNsmRJnapkEJJAuo8=;
        b=bnWmYbNe8AVqTZB6OqB7BtQSTxYs7FSwGHouSovnCRlLis2eYtkyJitDxUttpTraVr
         eclU0zT7NUFrP657w09KbaKmGwBYg9GdBqnB+kLT1W5ibpjm3yFSVyP6wcXR62Wgg773
         fFeS/88/GrGRA+iEBLdhBbde1v5DrHKZvbzUtExNk1dSE26xfIw4c6mzaMvZfdeLmp0Z
         2efz11/q67Hi92+Vm5uM6l3PnOrziRo3y6VL4RtTDS3dcS0/ZSzsYOlrwRgt28p0/NBa
         XkggtQEp+k6paZ6tTY2DjNk8xm5HymVmYXyFKnXL3Ga69IZ3cvFsHo0VzfaD5p3evtG/
         sIEg==
X-Gm-Message-State: AOAM5339PTgL3hy8qPpVJS+GUIvGdRQgTFMYS7ZMR2jZBBV5B6UkTGHm
        U9peMzW67N4vKh97do0sh8DX1flS38iVpJllfw8=
X-Google-Smtp-Source: ABdhPJzOHrBedyTIQreQOvJURrRSadZrgp6g9ZNWyLgzfFiP7g+ZM7OmyCuFRXfjmY15E/YjBMXy0o8IAWhUa8SQ8rY=
X-Received: by 2002:a50:9ee3:: with SMTP id a90mr331711edf.224.1636562086367;
 Wed, 10 Nov 2021 08:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20211110102423.54282-1-andriy.shevchenko@linux.intel.com> <887a15cb-3a3b-4ba2-aa0f-a241e70a19fa@suse.de>
In-Reply-To: <887a15cb-3a3b-4ba2-aa0f-a241e70a19fa@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Nov 2021 18:34:01 +0200
Message-ID: <CAHp75VdY57xQBLN8vT3RdagQx=4kLx69qAyuzLwqTvNGC2xUbQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm: Replace kernel.h with the necessary inclusions
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 3:55 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 10.11.21 um 11:24 schrieb Andy Shevchenko:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> >
> > Replace kernel.h inclusion with the list of what is really being used.

...

> > +#include <linux/container_of.h>
>
> I built this patch on a recent drm-misc-next, but there's no
> linux/container_of.h

Thank you for trying. It's in the upstream, whenever drm-misc-next
switches to newer/newest upstream it will be there. I assume it will
happen after v5.16-rc1?

-- 
With Best Regards,
Andy Shevchenko
