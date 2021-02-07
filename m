Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC972312485
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 14:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBGNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 08:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 08:12:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D948C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 05:11:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u14so13890214wri.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKECbsWCMXV3jdws0/56aBoSaNa9rnsRvH773f+Ajxs=;
        b=J9mKA6jAoyc+ndFvGXTJbR7opS6yIPhigLhA5yw0KXqdR+KY5kcxzuovEDVQVj7ttE
         Yaj2fuIxchsknU84aXiwgbq1o189RPKd6hS00mG/emXrQDZSm7wXiTMGuuz769SW8Dpd
         r7Yl4MnxeNL8ygHBf0y6iXtwhG5k2jYST8mOdp5PtKQmDfYOYdhYeIr4my62HJDhdUdr
         GDUn3VPScc4ZZeYKaVC+bZn61gMRkIWL551IO/5BGgDpvw/5vnAp0Ixr3BZQ18DIEcF/
         0N6dQ3oSDJx4/hSwiCLolDou/L7WxIKv+MhBy2ov7lv5/GhA4+AxdVMt3SG2uNa/WZ0O
         1e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKECbsWCMXV3jdws0/56aBoSaNa9rnsRvH773f+Ajxs=;
        b=AFhQ84bIUnO9DHE1OkQlRRFVl8qqTWD2vJsq4z+eYBz0hcWLBMWVtSBWbOv5OQbtZM
         xSD4128OMqNdCe+ObJvtTH8HOLSCtUQZgyzdNjBbA+ZxmgA/ZzSN5pIZE1MH5Ha0Bj40
         v0tJRYOahGARRrIANG3kxyNtN77C/cMwh4EYd4ga2HzYaKssgs4ncsKOxb3xI0dlNGMz
         grzJKXPSHEPo9pBb8VDEQ7lNN5f8NnwzMnhEaNLsQgre/LOZd1UUROW1e/ErSHS+JTDn
         ZbgCkVsACgILajblcMgKCfPE7iXmpRYdjidcbRcayG0IsDxKdpgTDif6ksSGP4r2vNkX
         9+6A==
X-Gm-Message-State: AOAM533yy0luez/IH21BbfLq5wqiCbJATtkuOhi0YOvfn8XPv5/1bbnV
        UIg8v6RNpcVPhpSsuSkmimx+tEycikiqn64hxgk=
X-Google-Smtp-Source: ABdhPJyeGR8kZfLzFpYv0bD6bYcy2h0AO7MffReuc+RgGV+SwVun4EOnTj+f6/OPtZPdbP55fN6tAjXbaNICE28lTvc=
X-Received: by 2002:a5d:4b8e:: with SMTP id b14mr14532579wrt.130.1612703503805;
 Sun, 07 Feb 2021 05:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20210127194047.21462-1-christianshewitt@gmail.com>
 <CAKGbVbtaDHmukvfF=sfSmWHVdAYoF6-i4RTzsPQ6zfsjHcGNCw@mail.gmail.com>
 <2c8d2b9e-c1cc-1157-19de-409957ecf9da@arm.com> <CAKGbVbuLRvZaZNfU-pi=7vqJZO2zOHAkrjTo6vs9BKLrV21O8g@mail.gmail.com>
In-Reply-To: <CAKGbVbuLRvZaZNfU-pi=7vqJZO2zOHAkrjTo6vs9BKLrV21O8g@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 7 Feb 2021 21:11:32 +0800
Message-ID: <CAKGbVbu-BJMxpwbC4XoP3rzt_hYtoSVHr1zjA5OXSy8YQmEXag@mail.gmail.com>
Subject: Re: [PATCH v2] drm/lima: add governor data with pre-defined thresholds
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.

Regards,
Qiang

On Tue, Feb 2, 2021 at 9:04 AM Qiang Yu <yuq825@gmail.com> wrote:
>
> OK, I see. Patch is also:
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> Regards,
> Qiang
>
> On Mon, Feb 1, 2021 at 5:59 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> >
> >
> > On 1/30/21 1:57 PM, Qiang Yu wrote:
> > > This patch gets minor improvement on glmark2 (160->162).
> >
> > It has bigger impact when the load is changing and the frequency
> > is stuck to min w/o this patch.
> >
> > >
> > > Seems there's no way for user to change this value, do we?
> > > Or there's work pending to expose it to sysfs?
> >
> > True there is no user sysfs. I've proposed a patch to export these via
> > sysfs. Chanwoo is going to work on it. When it will land mainline, it's
> > probably a few months. So for now, the fix makes sense.
> >
> > Regards,
> > Lukasz
> >
