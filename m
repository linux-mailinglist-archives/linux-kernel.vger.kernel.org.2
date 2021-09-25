Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD494183B5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhIYRnB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Sep 2021 13:43:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhIYRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:42:57 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQNAv-1mGcs50Kvp-00MOeI for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021
 19:41:20 +0200
Received: by mail-wr1-f42.google.com with SMTP id i24so21471957wrc.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 10:41:20 -0700 (PDT)
X-Gm-Message-State: AOAM531Vuqvl8TEJ7F4thtr0n2btjjlgXTvJZ4H69pvEdMYhArc1m+UV
        LeFQ0trss2D41t4JilbMlWuBtBtIyO2BsOkXJv0=
X-Google-Smtp-Source: ABdhPJzD7fF7tq6rLYrEB//7e7yO+zDI+S3dCg1d1r0r2MDWO3yvErGx3x5MkLRhsuk0e3xLvLsqeGf1sDbZc+8mutY=
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr7831419wmj.1.1632591679710;
 Sat, 25 Sep 2021 10:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <YU8oVDFoeD5YYeDT@kroah.com>
In-Reply-To: <YU8oVDFoeD5YYeDT@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Sep 2021 19:41:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3pdVhjv4J4HSB1cvHU7U_P7TV7HCOYmrK==V_MAnT2BQ@mail.gmail.com>
Message-ID: <CAK8P3a3pdVhjv4J4HSB1cvHU7U_P7TV7HCOYmrK==V_MAnT2BQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: move dma-buf symbols into the DMA_BUF module namespace
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:RiAXDwcUwX1xFbrt+c+a6omTPhtbhF3lrrnIyveq+fwC7Lcclpp
 BEixva4cUshApwejf5OnVBG7P7NgP0nOTJx9JGCrEmjqismz31kzu5K0jnTZQolBiZnzDlX
 8JfzXnkvnjmmw6keBTgL5iPGP3vhjMFuuBz8BpS2yOkXi2ArL5Y2V67IEWsAiC3eKdKblFP
 tDFPVavEARpN+I9ZsYgsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OivLiqXJTYU=:83Q3K4MB3YQXC6lObExs18
 qXY3dfIL9/PsX9m6KpR+MGCqpvhguZz9aPUkb/M6Fa+w6OQfP7DuevPlPIEz6fF8GEZigxmgu
 Mrueq39LFWXJbE/H7fmOTJCtb67Yb4etGqDUyLnc3S0o4CYTV2iRd+6FOq+hHmY+hxCYazU8x
 iWYeu6AyfdDfZq88zRRi8eKHX9jZbR7brVINbB+RqfGvgS31nKYhDE0D3pwntOAENjT+U8B8d
 sjpD9y/q59YSzgcz3vafL63JW5tw11HJhgVcsYrf2nn1XGk/hOyk7jGDcvlbM+a3b9c+TwWBO
 WI6rL8cFVSTCOmy86Mj7DF8xPrDKDP7yc6q2eZkCdHi46xQufYb897B8/nqrS5nDLLXVYtO/6
 kVsvyny8vhB74Z95mn05clmqTlTdtjSaDwwcUEL1fYt+5G+4ET1EGGeLPQPmf9QsHav1Q5oQ8
 zckbSIZ6uMAsOJEwTI9x8t0kK0Px43j9fxfXAYwHw9D+oCAAQU9OHuHv2C4N14RnM1bx0R+vn
 jagIEKD85BrO3G+R/jSn0g+CyRn9zoby0958OLsckwsu+mciQ2UD/WJ3JwWXzQ42SiUyEV7bc
 V7eB1cLxw4rIF4hmCzKLYyPZJQ8wMZggobcZWXyjq9aA0mR+mHVFZg4igB/tG9wYvOtfma8jh
 1Oz1pCIylKwQayLWGhnB5G3/UR0XWa3A4FYgvMZ/PprapHn/fAEi540+2Rnzpq01Mthb0xZj6
 6bNQsV5jBOxhSLvvQO+HUsuu5jAyY6r15NrrOF7Fja51HJh4jeu0ouHQ38z+ntDbA8bBjhAj8
 Ld9Xr2QoSOSfT342sKAX4athbb2Vmxvpjh0oT9ys7QyN0GlW5b0opEnVGfu/zC68dKYuACAI+
 3USpQPqdaSskljB7so9Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 3:47 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> In order to better track where in the kernel the dma-buf code is used,
> put the symbols in the namespace DMA_BUF and modify all users of the
> symbols to properly import the namespace to not break the build at the
> same time.
>
> Now the output of modinfo shows the use of these symbols, making it
> easier to watch for users over time:
>
> $ modinfo drivers/misc/fastrpc.ko | grep import
> import_ns:      DMA_BUF
>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> The topic of dma-buf came up in the Maintainer's summit yesterday, and
> one comment was to put the symbols in their own module namespace, to
> make it easier to notice and track who was using them.  This patch does
> so, and finds some "interesting" users of the api already in the tree.
>
> Only test-built on x86 allmodconfig, don't know what other arches will
> pick up, will let 0-day run on it for a bit...

I've added it to my build box doing arm32/arm64/x86 randconfig tests,
if it doesn't report anything by Monday, it's probably good in that regard.

      Arnd
