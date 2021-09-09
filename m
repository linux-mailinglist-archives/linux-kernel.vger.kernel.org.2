Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF697405D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbhIITed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbhIITec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:34:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A9BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 12:33:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a15so3808780iot.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2IYAT4zf02RWUNDruz7+0lDEcO/Nb9ZtTNr33lXbog=;
        b=PB5fXArkN11kuDGlOpAY2Uq87Zlrf8VbZJFzYvAFZT5RhsN545UOJp9+uNPzoeyM4e
         xib37Uo5ToG8XyCVLrJOQ4PDCnYiw5xizwwq+G6OOivyUUmST8sQwFsRyMOYc+l6DO7M
         8h86v98MDD+4tMscf29L5z/MJV5FVN/5OoQlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2IYAT4zf02RWUNDruz7+0lDEcO/Nb9ZtTNr33lXbog=;
        b=U7n/Y/dfSwB8mbUEybZoQoTJZZznFJ2guSfno/HfEwQhjMtItZOnyRo/fAtGxLfiKF
         QDe1RcliqTvRRrakH1rqeGyeLCgXxeGmEXYgKxn7v0mhPIWfOLWJBV8SScyvkZ4Xcgvu
         fEYlsNqcfFF8Y6qdTk98l5zQW1qSoIAHUn4Zo3+apJyFpMqWpPItRM0vKi1Ien2Wb3ID
         yAbFUZbZvgxonRHLXRoTTw8PgzBIjYBjW4TC53KD27PDb74ZtniBZpTGhnygb6MWLSq9
         9Vh1KEC+5GiOIhsAS/8sQKIC4ZOG9egVVkKV/4xdlJurwG1s7E4sb44aIxWboLw5QBqn
         dRyg==
X-Gm-Message-State: AOAM531u0y0Xq5ZKfL5XA8rzYp7FDuAqL/7JPI7Muawz42dD7wT3ZsBj
        YxAs3GfEyoj39NuhfTUiraTZ8SFRIQMNEg==
X-Google-Smtp-Source: ABdhPJx/PpGDb6zqX/gPZqbiuNW7ZwjRGwQhmKr0YHV/Nfdu38PCJvIRjkUF4kvGY3efiDRKUzKD2g==
X-Received: by 2002:a02:6d10:: with SMTP id m16mr1360087jac.60.1631216001690;
        Thu, 09 Sep 2021 12:33:21 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id s10sm1384322iom.40.2021.09.09.12.33.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 12:33:20 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id l10so3096837ilh.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:33:20 -0700 (PDT)
X-Received: by 2002:a05:6e02:e02:: with SMTP id a2mr3620736ilk.180.1631215999852;
 Thu, 09 Sep 2021 12:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210901201934.1084250-1-dianders@chromium.org>
 <20210901131531.v3.5.I0a2f75bb822d17ce06f5b147734764eeb0c3e3df@changeid> <YTUPiyOjsUJXN11h@ravnborg.org>
In-Reply-To: <YTUPiyOjsUJXN11h@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Sep 2021 12:33:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VbYcdSqxLHdSaDPh=X0hbW6VWV0mM-iFy3k0J1q+6MWg@mail.gmail.com>
Message-ID: <CAD=FV=VbYcdSqxLHdSaDPh=X0hbW6VWV0mM-iFy3k0J1q+6MWg@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] drm/panel-simple-edp: Split eDP panels out of panel-simple
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Steev Klimaszewski <steev@kali.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 5, 2021 at 11:42 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> > +++ b/drivers/gpu/drm/panel/panel-simple-edp.c
> > @@ -0,0 +1,1298 @@
> > +/*
> > + * Copyright (C) 2013, NVIDIA Corporation.  All rights reserved.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a
> > + * copy of this software and associated documentation files (the "Software"),
> > + * to deal in the Software without restriction, including without limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, sub license,
> > + * and/or sell copies of the Software, and to permit persons to whom the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice (including the
> > + * next paragraph) shall be included in all copies or substantial portions
> > + * of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > + * DEALINGS IN THE SOFTWARE.
> > + */
> Would be nice if you could use the SPDX thingy for the license.

I'm going to leave this alone. I definitely started this driver by
copy-pasting the panel-simple.c file and it still shares a lot of
lines of code with that driver. It feels like that qualifies for the
"substantial portions of the Software" portion which tells me to
retain the license. I also kept Thierry as the author since, again,
it's really a splitting of the existing driver and not the creation of
a new driver. In fact, if I were to assign a new author/license to
panel-edp, one could also make the argument that I should assign a new
author/license to panel-simple. panel-simple got ~50% of the old
panels and panel-edp got the other ~50% of the old panels plus a
search-and-replace of "simple" for "edp" and some code deletion. I
don't think search-and-replace name change nor code deletion is
justification for claiming authorship. ;-)

If Thierry wants to chime in and say that I should put down a
different license for either of the two files, though, I'd be glad to
change it.

-Doug
