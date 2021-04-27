Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08836CFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 01:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbhD0Xo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 19:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbhD0Xo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 19:44:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:44:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x19so65904116lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YMIKC4vGdsxVos4+dsOTGyTHqSG6nUUAUOhU3oyN/ps=;
        b=bE/qvBzvsqd13cF2iCpY7hfzDbKrnY6CNusCIOktVq1TlPDP5ySyTrXE4scETMF1Yk
         RZF/mcPHW/b4gjNOkyS0/vu3e8EdOAITFv0Mz4JXtF1+7YGK6vUAavmRL96jW2Dq0OTk
         48M/UC638Q9pU9+j6yatiqAseW9vI30ZWExPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YMIKC4vGdsxVos4+dsOTGyTHqSG6nUUAUOhU3oyN/ps=;
        b=Due7DOGu3CAGlFcAIY92AtDi2Jr8aTxqrV2KW6xbCCvj/E2wb57GTORhCWQcM0kS1G
         aysaQkTFLx/1IzriB9p9q+OHlFeML3nG66/eo1KHrf8unBXuZ92whTwTRJKgTMwm7GrX
         ES0iJPV5RD1XEfBpl1y0m3txbbGFkifUjSMZYdDvCbyrm6YcK25xDGYsGhh/ePMSQwdj
         270RsICidLMneN0drjafdk9uj4kC6R58lev8Gm9OFCVex1I9yWrSNcDIRpkh3+gSUsdJ
         AHRrRRAJJnV0aqyAtOAoNSVpAggqKnwqhERULhWUgrin2de6R5jYqdzn5/s21m50nLLl
         XWTw==
X-Gm-Message-State: AOAM5337K/Byvl+QwN2FmQ6HuaDgQkiI9Si/FhXTVofjBNv3cEkYo999
        evkCRfWap/Zpey0hzBh66XFR614pHSZxzGLU
X-Google-Smtp-Source: ABdhPJz80XeDVVZNJW2+xVatFOxdgibJ1g2It0nibGhxzbomyeyjGfOjKMbTwhq6Ep7JPZhNmMEA8w==
X-Received: by 2002:ac2:5119:: with SMTP id q25mr19054756lfb.82.1619567050835;
        Tue, 27 Apr 2021 16:44:10 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id b29sm284611lfo.247.2021.04.27.16.44.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 16:44:10 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id j10so3122476lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:44:10 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr2737571lfe.41.1619567049911;
 Tue, 27 Apr 2021 16:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyKdGHyiRLDooKrMf=02GtNn8U4YfF4dJtXdabnVAGdXQ@mail.gmail.com>
In-Reply-To: <CAPM=9tyKdGHyiRLDooKrMf=02GtNn8U4YfF4dJtXdabnVAGdXQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 16:43:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOOVBBuQceJ9D9uZrv-QOUWGMQ4aZe2K+2X24o7xA8cg@mail.gmail.com>
Message-ID: <CAHk-=whOOVBBuQceJ9D9uZrv-QOUWGMQ4aZe2K+2X24o7xA8cg@mail.gmail.com>
Subject: New warnings with gcc-11
To:     Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated to Fedora 34 on one of my machines, and it causes a lot
of i915 warnings like

  drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_latenc=
y=E2=80=99:
  drivers/gpu/drm/i915/intel_pm.c:3059:9: note: referencing argument 3
of type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned in=
t *=E2=80=99}
  drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99

and the reason is that gcc now seems to look at the argument array
size more, and notices that

 (a) intel_print_wm_latency() takes a "const u16 wm[8]" argument

but

 (b) most of the arrays passed in tend to look like 'u16 pri_latency[5]'

I think I will make the argument type to intel_print_wm_latency() be
just "const u16 wm[]" for now, just to avoid seeing a ton of silly
warnings.

I'm not sure if there is a better solution (like making all of those
latency arrays be 8 entries in size), so I'm just letting you know
about my change in this area in case anybody has a better idea.

             Linus
