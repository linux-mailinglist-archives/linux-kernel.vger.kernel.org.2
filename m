Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248183F6CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhHYBPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhHYBPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:15:18 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD438C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 18:14:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a93so44737290ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 18:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xYzcBCCmqFiTA/FsQcTLjxPn/gb6rPm3HzeOt3QB58=;
        b=b0RJwIVXYJJ3Bv1Z5rszRIcOw74vlJF0Wig0BFYl3I88/PQxWB7jI+8Hs1UAwu4dj1
         oC96iX2zqtnHx9KVZLJ7QKPA/i8vG1ZjbjU4ei4ffHOK7/Uc4OGOpZdH9jJrJmQoRJoT
         rRw3IwbGsQWJxJtv2tZ4QMDwodplNiNPzAkbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xYzcBCCmqFiTA/FsQcTLjxPn/gb6rPm3HzeOt3QB58=;
        b=NZptvttiNZsFQEtEz0MpfVHJ2w2XA8E21vpj+baaZgs0r8yNZHlzzl0szX6Hufv1ra
         LhHC6CjUXVMHi71NHqIHmN1D4R+go15D+Qkz9ZjbGh67tRqzZvZ8X0nibZZqiCzf2wkm
         eI0c/d9tj6IZK6MHAajUJh9tFZlbE7wOruPILtkns0k7l9bQU+Uf94M2lnI/HqCD1Gjp
         bA+e2u/zIUnBbb2+41lbLHz/e71RrssKDHN6EaOSq8aepqyEFBkzPfP6nfSUVlMxlSoY
         KG+lPQqPqwx4bCasmS7UhVWKKDVwVPbU5ZdzBpBlS9NXMIyHUlGYjUPRGELkt5wpeywR
         UOZw==
X-Gm-Message-State: AOAM532miTmaLxwFKp0SWJocUwB+rFAKV6LzAMiGcIAB/V8qOOEZHwTp
        1Bg0KGYNA+1ebw/JYNPgBdqIXLE/0DKt460mAnN1gw==
X-Google-Smtp-Source: ABdhPJxnaKJtrPb6TMYZjsr0sNxWhPt4q+sfc95cVL2VggioIFmQtjcvwnULfLpT7vXgph++v64vZ1flb+5uuuvkCwk=
X-Received: by 2002:a25:21c5:: with SMTP id h188mr52216373ybh.23.1629854071534;
 Tue, 24 Aug 2021 18:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210820162201.1.I8ead7431357409f2526e5739ec5bc3ddfd242243@changeid>
 <CAD=FV=W56FsUOzrRQ7Y5F4g7yBSXr-KJ45t32ghGSsNtFsNUMg@mail.gmail.com>
In-Reply-To: <CAD=FV=W56FsUOzrRQ7Y5F4g7yBSXr-KJ45t32ghGSsNtFsNUMg@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Tue, 24 Aug 2021 18:14:20 -0700
Message-ID: <CA+cxXhmugPkSNoXCrVTJdY9rq-vMP3AXrCKFxdMT9yhPVQhPaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Reorg the macros
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Philip Chen <philipchen@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 24, 2021 at 3:37 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Aug 20, 2021 at 4:22 PM Philip Chen <philipchen@chromium.org> wrote:
> >
> > From: Philip Chen <philipchen@chromium.org>
> >
> > Reorg the macros as follows:
> > (1) Group the registers on the same page together.
> > (2) Group the register and its bit operation together while indenting
> > the macros of the bit operation with one space.
> >
> > Also fix a misnomer for the number of mipi data lanes.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > Signed-off-by: Philip Chen <philipchen@google.com>
> > ---
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
>
> This seems fine to me other than the slightly mixed up Signed-off-by
> lines. I think that the git config from wherever you ran "git
> send-email" had your @google.com address even if you authored the
> patch with your @chomium.org address. Once that's fixed then I'm happy
> to add my Reviewed-by and (unless someone objects) I'll plan to apply
> this patch to drm-misc-next.

Thank you.
I just posted v2 with the double sign-off lines fixed.
PTAL.

>
> -Doug
