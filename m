Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7B453330
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbhKPNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbhKPNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:51:42 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:48:45 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id j28so20471573ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyJRlMxgypQBawfO4MnRS1PrXxf8qwrkwJ8sbBjmvxk=;
        b=lg0VpO4WpsNGVhi3US+Plu18x9ELXYeY/a+Gjmh0KE4uiGdDc7bj2BYS9BGh+I630d
         GMcPDsZ4XGe+oH+T4P+XCzlnxZ40KTegUHoFh0/90TAO4KxsiJluUahYvO5rKRhBy37s
         F6TSvniydNG5hRtcIIiCbQD11XzpNsvSHZJQgd0b9IY61tcJuyVr+npNhcyuUmJeMVvO
         wTsOy01pU4VeJVZ8weWZNixl21BVRy/9vTI+mFuUDJQdZrkjnGemJMv2GzwreJXuna6t
         pJbFJJqfhinEeJG/mlGReTSOz5XuTZYzV62JOVCY3+39TRm/rIBZF9aatwTJVpbLhXpq
         qUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyJRlMxgypQBawfO4MnRS1PrXxf8qwrkwJ8sbBjmvxk=;
        b=tNnTv1QHC9L9lmIcK6LL/Fp33wA0LC8aFO0cFpfuxnfJZejVAXhVYc7Jxa/NYrD9zC
         x9Y92ZTMYRYrBLT8mJJmLCAwTEK0vum/WdC8kOO3M7guVptTlP06OCjV569aoIIAYcNU
         yG1+X/bStUUjZYDWwLY8jTBgGogwwT17XlxvPz26Igi6ok0R5UxPrFpGvvm0XT+CfEHZ
         mpy3ReZ6METVSq60DDIB9r2Tj2Ivhn4ostYPfTl5dMwfFjhb3q3kIyEXaQ8N+D+sksRI
         Cpl1mD0QVdVmiw/sq3F5H/fZiRDEpP+6v70KTT9ggNwCC0WF5VndMqiX2s7KoS8v4zls
         0dYw==
X-Gm-Message-State: AOAM530Ojcji/qrVZGNXxRDPQ14WmT8B9itBD/r0AnK949d8woDylw18
        f2vm6ZEso3nkL0Lxe5HNNmNDa64pvp9gxFdon8g=
X-Google-Smtp-Source: ABdhPJzRrtLamaODkh+2FsFy4cqn8oy2+eiI0fQP9p4+Jt0x159EfGFkEEPONDhaRlnd0rhiICW2y3Ud55AKzr0TZ20=
X-Received: by 2002:a92:cd8b:: with SMTP id r11mr4522430ilb.320.1637070524621;
 Tue, 16 Nov 2021 05:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20211116011451.896714-1-zmanji@gmail.com> <6d2d9c4a-3f05-1d51-42dc-b1ebbb4aefe1@gmail.com>
In-Reply-To: <6d2d9c4a-3f05-1d51-42dc-b1ebbb4aefe1@gmail.com>
From:   Zameer Manji <zmanji@gmail.com>
Date:   Tue, 16 Nov 2021 08:48:19 -0500
Message-ID: <CABtXzjSPNxe-n9QTujMB7=CmhqPFp8V2e86BXmoErWm+6c5coA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove unused defines in wifi.h
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:56 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 11/16/21 04:14, Zameer Manji wrote:
> > None of these defines in wifi.h are used so they
> > can be safely removed.
> >
> > Signed-off-by: Zameer Manji <zmanji@gmail.com>
> > ---
> >   drivers/staging/r8188eu/include/wifi.h | 57 --------------------------
> >   1 file changed, 57 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> > index 193a557f0f47..7cbc7015e90f 100644
> > --- a/drivers/staging/r8188eu/include/wifi.h
> > +++ b/drivers/staging/r8188eu/include/wifi.h
> > @@ -13,32 +13,9 @@
> >   #define BIT(x)      (1 << (x))
>
> What about BIT() macro? It's already defined in include/vdso/bits.h and
> can be included via include/bits.h.
>
> Most likely linux/ieee80211.h contains bits.h. Haven't checked yet, but
> anyway redefining kernel macros is not good approach and BIT() can be
> also removed.

This is a good observation, but the objective of my patch is to remove
unused defines so it will be easier to do the work that you mention. wifi.h
and ieee80211.h redefine a few kernel provided values, and I intend to
follow up by addressing all of them in one go.

Would you be willing to ack this patch as is?



-- 
Zameer Manji
