Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ACC3DDD91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhHBQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhHBQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:24:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7553C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 09:24:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f22so17108346qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PABonhkfz0MvRGA6imtUnPyjypKDIpW3LfF+TjLeY4o=;
        b=abqfi6gzVw+ynFGoz0A5rBsxqK7BLlHO4rmdg6nFQDPOxt1wwq12n3BaH9if/ZXaOn
         fYBfeuWw6VKmuxNwo13braCXtqReoz3+AR/o0ROfzVlpmzUbY5rAjA98AezOF7T5biLR
         8Geu2xgl59mAwBEQQmdLzPWofp+8tv1cXKB8pbjhWgHG1USo3sD/vDSuS32yWER7r3Qj
         9TYb0uNWFAm7UoMPqBtQVDJi3hDWqI2Xa2T501rI8fR7sLTB42NjdldQPfhSV+wdln68
         XgY1O0AGD94GK3KC9V2pfdQqV0j2lptAmzeLblBEIfuwNOuVp+9skRad2c4iTGTQVbUY
         xSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PABonhkfz0MvRGA6imtUnPyjypKDIpW3LfF+TjLeY4o=;
        b=Uajb3PnoIGOoTUQomCz42Bl22UcYYdHfoPtb1/PP8bboD1GWUJw4lPl+O0nQBqp7i8
         sjCXKG+RxnfxAuzd79kB/1eUJSXHC0m/Kx1cPSGcjejkJt1Sg0cSpAWEwmM5eHvIh8TT
         4FRXX+3qGDYZxuLxKx/lR9eY8epzkvtM2ggMhx34nnZ5H2dnFtpWRoxB5rTrMwKZ4CFt
         9j+rfzBSBXO8W76erlYfKQ4O1N3XYqPopsdm+MI2VvxduKkTo0fJobxHbGLr3KZigmQf
         Xxb/tmH97Mr69Gkj1/vt+ReBMKs7aI61ZzV0CkhVRi56Yto4MGPrH6DQWduhrsbsH+GL
         TJhQ==
X-Gm-Message-State: AOAM531T0R0kvcV/2xTIi/jAjevz/dRvKN6CnUCfqhUN8v9+7gTL97Ez
        HkjgFdNNqMjYTEc9+ucTH8yrUrKBcyD7/7m23b0=
X-Google-Smtp-Source: ABdhPJxSICDT7QAUlLZoant5eoxfyRFLmIvUQ/yn35oDDIe5fQ6jBLfy0/FXQELa3F92AS84FaoFLpUf/W6p/DuJ2FI=
X-Received: by 2002:a37:64d:: with SMTP id 74mr16630354qkg.407.1627921470080;
 Mon, 02 Aug 2021 09:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210731214211.657280-1-jim.cromie@gmail.com> <20210731214211.657280-4-jim.cromie@gmail.com>
In-Reply-To: <20210731214211.657280-4-jim.cromie@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 2 Aug 2021 17:24:18 +0100
Message-ID: <CACvgo509FWgNcBP9SPyuZV0Wey9sApmgB2Xa_+LJ4r91Cgqhgg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v4 3/7] dyndbg: add dyndbg-bitmap definer and callbacks
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On Sat, 31 Jul 2021 at 22:42, Jim Cromie <jim.cromie@gmail.com> wrote:

> +struct dyndbg_bitdesc {
> +       /* bitpos is inferred from index in containing array */
> +       char *prefix;
> +       char *help;
AFAICT these two should also be constant, right?


> +int param_set_dyndbg(const char *instr, const struct kernel_param *kp)
> +{
> +       unsigned int val;
> +       unsigned long changes, result;
> +       int rc, chgct = 0, totct = 0, bitpos, bitsmax;
> +       char query[OUR_QUERY_SIZE];
> +       struct dyndbg_bitdesc *bitmap = (struct dyndbg_bitdesc *) kp->data;
> +
> +       // pr_info("set_dyndbg: instr: %s curr: %d\n", instr, *kp->arg);
Left-over debug code, here and below?

-Emil
