Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B1402D81
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbhIGRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345398AbhIGRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:11:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650AC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:10:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c8so20887754lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+GlpUmGC3s0m862BFnaEghUBDcmr0hsoDqEpHfudes=;
        b=ZrpTD11YcoTzlnxV9wbY07amfLrzROABaXwapPT/EEW1bkKcXuC/n8hMUS1To0EImi
         DPnKnhPDFJMiXLp6aEjyyVpW8E7s3FPi0evoO0M+tFEFfJy19SP9BS7fxujNluGVqvaR
         KofKwxkpnp3XGnzZgyHrIyRK5eh2/qXYrkUjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+GlpUmGC3s0m862BFnaEghUBDcmr0hsoDqEpHfudes=;
        b=Y8agEkZIXp6ftubAzNJ0KuQHD/UfDOkPzPdoMVxuz47X6o2XAlBqhXzHQIcY1bBK49
         dYVCPu5mpTrMjFSSNqvijRssuP8sVY39HymwwjwOE1q/doOBXZR2R9W1GtGPaQ89dddH
         mV6hYbqi0NJQUXlLuSVvVdHZEE4gjUHGhtyuCk8u/v7X44EKK5CtRJ2Vuwv0j4q7q0Q3
         sRwVpy3KYwezFBoyCCVoujPS8UXMjFY5lldYxKzDm3iCceoLeARhCVA3PyKpyiepDIJJ
         yQZmkwKDYxhgQGZ/pLSF/CQCuNmDzk+sgWrFzEObziTUrUx1DAoi4zloamtsQIflE47j
         70jQ==
X-Gm-Message-State: AOAM530qzGoj85/cPRsAw5KG6WxF7bu5gQSrVzRUFt8Y0kmcruRLvE3q
        tXF29t6Zhn7tLCigFD8gHBDNthSW07qANLM0G0k=
X-Google-Smtp-Source: ABdhPJxYKZ4/4if81ZOGoo6AyUwEA2q6JHBJpQkvCf+q9FzdQLzmrwdNslVriIoUHayEXJGkIIqJTQ==
X-Received: by 2002:a05:6512:1326:: with SMTP id x38mr13508989lfu.591.1631034627878;
        Tue, 07 Sep 2021 10:10:27 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m5sm1497513ljg.55.2021.09.07.10.10.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:10:27 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id d16so17700643ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:10:26 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr15231271ljp.494.1631034626531;
 Tue, 07 Sep 2021 10:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
In-Reply-To: <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 10:10:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
Message-ID: <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 2:11 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:452:13: error: stack frame size (1800) exceeds limit (1280) in function 'dcn_bw_calc_rq_dlg_ttu' [-Werror,-Wframe-larger-than]
> > x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:1657:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml21_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
> > x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:1831:6: error: stack frame size (1352) exceeds limit (1280) in function 'dml30_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
> > x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1676:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml31_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
> > x86_64-alpine.log:drivers/vhost/scsi.c:1831:12: error: stack frame size (1320) exceeds limit (1280) in function 'vhost_scsi_release' [-Werror,-Wframe-larger-than]
> >
> > Another instance where distros lower CONFIG_FRAME_WARN below the 2048
> > default. Again, none look particularly scary but should still probably
> > be dealt with.
>
> I would argue that they are still scary and should be addressed in the
> code, it's just that we don't see them on build bots that use the 2048 byte default.

No, they are scary for another reason entirely: clang is clearly doing
a *HORRIBLE* job with stack usage.

To take that dml30_rq_dlg_get_dlg_reg() function as an example: yes,
it has a few structures on the stack, but gcc allocates 512-720 bytes
of stack space depending on my config.

Not 1280 bytes.

So it's not even *close* to the 1024 byte limit with gcc, much less the 2kB one.

I don't know why clang basically decides to use almost double the
stack space. Maybe it's some other config option that does it, I tried
a fairly normal one and a "almost everythign enabled" one, and
couldn't get close to the reported stack frame size with gcc.

Just to try to make things as close as possible, I tried with the
exact same normal non-debug config (apart from obvious
compiler-dependent things), and picked that dml30_rq_dlg_get_dlg_reg()
function to look at (for no real reason other than that the stack
frame was biggest above.

Gcc did a 720-byte stack frame for that case. Not great, but whatever.

clang did a 1136-byte stack frame for the same thing.

Do I know why? No. I do note that that code is disgusting.

It's passing one of those structs around by value, for example. That's
a 72-byte structure that is copied on the stack due to stupid calling
conventions. Maybe clang generates a few extra temporaries for it as
part of the function call stack setup? Who knows..

                 Linus
