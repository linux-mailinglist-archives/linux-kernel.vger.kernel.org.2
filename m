Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B904395C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhJYMQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJYMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:16:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D4C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:14:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q16so8926855ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9EdUhOEz6LCHy9Q4PpzvVDj9adp0XAbP/V+787pVMF0=;
        b=o+dWeZI/z6lqMSLsbil6YIyE1jqJSEN4+lcUSDasiWYLtPgepVuV9yRFGul/S+IZjd
         gDbGpaNe3bqNbRWJhQ8uzBY4CiicZs1uR5BS3+MoUCDorm+8eG2KGfZD1N4QFQhEcKYw
         xy7gxDmYOZRBm6yhyTEiLwdcWRAlH9ewRtC0Drmg6f6HGWdLbLyhETNKBPdWq8uo1CSV
         cbAWIYtOWs8A+jmLxHgpOUrmw4sE93EPz2L+YLH6FIq17e7sB4yGDacegypyYqkVZsfc
         +nFJF2hSn2fSDbNW7rTDUeK7o2Z6gvK87WT6kkz+wB0G7qLv3XjLyhikq5itsQnyPrpo
         L0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9EdUhOEz6LCHy9Q4PpzvVDj9adp0XAbP/V+787pVMF0=;
        b=PSYMKIwUr3scPO7Y9FPtx36wknhyGRvhZSJnRy5WtxZhmKZY5zG7F65nu0Jk5F38sD
         9eTV755vWmTswq5T68FpGL6aW3Hw0FYWxvmVIWtjl0ioLwSFvjcL8encUkVJ/GO8W3KJ
         aLqU1JJQZftUnMkmxhoxFAZOWvOJEm1j4EMAQ57Rf7E38ejAXFpY0MJC79eEAq2swcNh
         YxUmRmcghrMYY4Yhx/NxhX9p9SlWlVXY9KbGnziZAdmHWV7Nwqfj1s5FH1rYOlZFBXFS
         7CssS1w7F+CYpDWK9j/SBKCbJJyTSqWFt+HNs8keIcAzlmRRAzpcWL9ungqJ2/zp8z/m
         Rz+g==
X-Gm-Message-State: AOAM532u21MgyeH51gt1jjZ0hcinEC3M5RXji7YQrk5fHYArM0Lu/jJ8
        lpKq1ALmRBSW9TK1blsAT2n328u3TJesWPBHzVwUgA==
X-Google-Smtp-Source: ABdhPJxMcBXf08mQujD6/q+CS6va26l4F0UMxyQLEYHppTQUj1YDoHEdo/Gg27zgpNe8o6sYV7ePnDmBYzD5E0mpwE8=
X-Received: by 2002:a05:651c:2328:: with SMTP id bi40mr18700746ljb.121.1635164041366;
 Mon, 25 Oct 2021 05:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211010124628.17691-1-gregkh@linuxfoundation.org>
 <YXaIx0g/kHEnq8ZN@kroah.com> <7328189c-0567-847e-17e9-e2ed4f3a78f4@amd.com>
In-Reply-To: <7328189c-0567-847e-17e9-e2ed4f3a78f4@amd.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Mon, 25 Oct 2021 17:43:49 +0530
Message-ID: <CAO_48GE9C_eOK84iYwvNjkGQRcFQQ8Hn-z70ndOhmF1gbmd5BQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: move dma-buf symbols into the DMA_BUF module namespace
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 25 Oct 2021 at 16:29, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 25.10.21 um 12:36 schrieb Greg Kroah-Hartman:
> > On Sun, Oct 10, 2021 at 02:46:28PM +0200, Greg Kroah-Hartman wrote:
> >> In order to better track where in the kernel the dma-buf code is used,
> >> put the symbols in the namespace DMA_BUF and modify all users of the
> >> symbols to properly import the namespace to not break the build at the
> >> same time.
> >>
> >> Now the output of modinfo shows the use of these symbols, making it
> >> easier to watch for users over time:
> >>
> >> $ modinfo drivers/misc/fastrpc.ko | grep import
> >> import_ns:      DMA_BUF
> >>
> >> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> >> Cc: David Airlie <airlied@linux.ie>
> >> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> Cc: Maxime Ripard <mripard@kernel.org>
> >> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> >> Cc: dri-devel@lists.freedesktop.org
> >> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> >> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> >> v2: added lots of acks
> >>      added 2 more drivers that needed the change, as found by Arnd
> > Ping?  Any ideas on what needs to happen to get this into the tree?
> >
> > Or can I take it through my char-misc tree?  I seem to have a bunch of
> > acks on it by the respective maintainers...
>
> I could push that upstream through the drm-misc-next tree if you like,
> but honestly char-misc sounds like the better approach since this
> touches a lot of drivers outside of drm as well.

I agree with Christian here - char-misc might be a better way for this.

>
>
> Thanks,
> Christian.
>
> >
> > thanks,
> >
> > greg k-h
>

Best,
Sumit.
