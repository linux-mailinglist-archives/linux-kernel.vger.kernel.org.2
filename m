Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D203113E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhBEVtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhBEVtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:49:08 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17409C061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 13:48:28 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k25so6224365otb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 13:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Myi+FPtqdhmCRGtvUQRPlV0jT+RrPtESC3AjeVRvbg=;
        b=eC9kB4a0zNfmjxF2GTa7/iPip18RksRG3N5wWZ5SO1JQZe9K/wF4qqPray7ex919OI
         t+tp9kXmieLVbXRxK2+JkQQDfBQ7qrCcDPjv892pP0Pm9Opne2wsFWOgNQ9fiIbaKohg
         74D35sOMSr9T35Hijh1VZY9iv0qSmYcBVjy6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Myi+FPtqdhmCRGtvUQRPlV0jT+RrPtESC3AjeVRvbg=;
        b=JXbWDxG3johkzIVF1tP4Tty2NzzlyInUu8rFiPObT420NybzBKLH3ceuzKuqkCqDU4
         G686n5EupR0yAnPxn0yASaua/u/3I/h80Do8ScGAfnmAg4Z6+mJ+mRaSXFUM+FlEZwX1
         FZtRWQrlNfKskLmKhRbSlQ0OFhMR35WNE0IAQNK2fnJx0Qj+Y+RSuFhZY5cJYCaHIRk2
         X0XTL47oQg2rRzQBofrGQp6Btv9/2TfcADGM4Evr0f8kXYDnfakdxtfGWY9MdE0ErN5Q
         J+zj15SbtYjntZDS2KaPHbcC2qFGWkwKWedwLcH3E5kJA2BXEjuxyRLJS9jMFynyBeNB
         LeeQ==
X-Gm-Message-State: AOAM533n3AUjVDiFb3vcqSIlM9PlhpKrbZK63P8bDUF6JQ3lo9fEdr2O
        GJJDTmkW4HAhXLyOH2+EufWOJqYx1IVaujFg00DF5GMNq+Tx+g==
X-Google-Smtp-Source: ABdhPJzO4wsgNsPeCXBIM+TjlTPuvZslxQG5o19ZlJ38I+bykaN07telVVm1okiylG5taJfGzcXqFg1phGT31X4akVA=
X-Received: by 2002:a9d:b85:: with SMTP id 5mr4982641oth.281.1612561707504;
 Fri, 05 Feb 2021 13:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20210205163752.11932-1-chris@chris-wilson.co.uk>
 <20210205210610.29837-1-chris@chris-wilson.co.uk> <161255976138.12021.9385501710085642237@build.alporthouse.com>
 <202102051319.E5D8B4528D@keescook> <161256053234.12021.17815864250035077266@build.alporthouse.com>
In-Reply-To: <161256053234.12021.17815864250035077266@build.alporthouse.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 5 Feb 2021 22:48:16 +0100
Message-ID: <CAKMK7uHmG-WaYrLyHfcbJJ_LhKA2dOdvBAYKaAyD-s6W0TgRjg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel: Expose SYS_kcmp by default
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 10:28 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Kees Cook (2021-02-05 21:20:33)
> > On Fri, Feb 05, 2021 at 09:16:01PM +0000, Chris Wilson wrote:
> > > The subject should of course be changed, as it is no longer being
> > > enabled by default.
> >
> > "default n" is redundant.
>
> I thought being explicit would be preferred. There are a few other
> default n, so at least it's not the odd-one-out!
>
> > I thought Daniel said CONFIG_DRM needed to
> > "select" it too, though?
>
> Yes. We will need to select it for any DRM driver so that the Vulkan/GL
> stacks can rely on having SYS_kcmp. That deserves to be handled and
> explain within drm/Kconfig, and as they are already shipping with calls
> to SYS_kcmp we may have to ask for a stable backport.

Oh I dreamed and thought it's part of this patch already. So v3 with
matching subject to enabled it for drm?
-Daniel

>
> > Otherwise, yeah, this looks good. Was the
> > export due to the 0-day bot failure reports?
>
> Yes.
> -Chris



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
