Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88D53ADD4A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 07:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhFTFyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 01:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFTFyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 01:54:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEF1C061756
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 22:52:36 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x14so20179483ljp.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n+tKlkajW6Vx9drB71r32BwcKUgAEh+DEGbzs80J8ds=;
        b=pkXnugDU5F1cob7L8JUgEowRz8H7YsDeNwBDBNbW/VVH9XWyc7B0kg+JGpxRBrW2uE
         6Yf8F7Fo6+xUeNlD8SyU5V8DmC3hGvTSxWHy1JKgtOlsdE8fcTCGl3X/FaL2VuGnTeg5
         yxYHgzpixsRtt6FUiqUbMcNMbarPSMXbSvQNiqR6Ueup1JwUylKXYvgxItN2RPthcBgN
         HHWGMCsFT5dliGztfuHMu7vsHDqC4UGJId2qlu2huSdF0vGgjVDwWdqDobjnhZ5onKAQ
         CrpncmAsrTNf0Dm9HGEVxeVLBUhkC12OeXZPLd1fDTt8uoTztkcjd9ApFTsdnnawe95L
         y6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n+tKlkajW6Vx9drB71r32BwcKUgAEh+DEGbzs80J8ds=;
        b=MIb5wUCUGPdh1QcoEtj6lu55Xd6FEqxzSjxwoXvGLb8YG4xHGhkznv9CMjLjvC2PGA
         iW1b5Y+YmBeU6VUizKBcbAKyWiMmhiWy0UZ8f+u2z+fNPLm+fQFoYSfIYoIIYZnx+RCd
         DWREzEAwk4HLhNpqa/zx2Ys6fZIm5ooVhpthR9bvArY9Dy/Th5Ms+bk2VDYhHnlar01N
         fsATy3huPNx42X/AuUGZ2F2ru2G8NOkEWI6J4DEF132xMQv0KDIr/IB8Spht+nRSrWnM
         fEMAFj6+jKI9hk/q9g1XXcimzD7FIaNvtodecYGcfO5FWVAb7VPRV3y+PJs2e48B3aiE
         fngg==
X-Gm-Message-State: AOAM531/mTZuv7bHHBA6FnVyRjPVbPE6sK4gUOqQZ2YWk7EVB6+6+2Wr
        xIJoJSOUc0rAWZMBjMqjwAgRptysyM0VALOdW++QEA==
X-Google-Smtp-Source: ABdhPJy0N2FygctnaM1zWFW6o5ILhqXJ2MTiCMg/Gy59u73692l5Q85owxqt1lIwqOvevKqhVm9MDVYH2qq+zl7GwfY=
X-Received: by 2002:a2e:8503:: with SMTP id j3mr16240319lji.322.1624168348979;
 Sat, 19 Jun 2021 22:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210617071027.60278-1-hexin.op@bytedance.com>
 <CAE-0n51T9ZGADCk6LaKJdnQwPvMCawSvjwUP+AF0hFohAFom0A@mail.gmail.com> <87wnqpdco2.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87wnqpdco2.ffs@nanos.tec.linutronix.de>
From:   =?UTF-8?B?5L2V6ZGr?= <hexin.op@bytedance.com>
Date:   Sun, 20 Jun 2021 13:52:18 +0800
Message-ID: <CACKzwj=ZybyemyAJLcV0GOyPE+dQYz8r+tNvv67AaniJJg7tDA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] debugobjects: add missing empty function debug_object_active_state()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2021=E5=B9=B46=E6=9C=8820=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8812:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 18 2021 at 22:03, Stephen Boyd wrote:
> > Quoting Xin He (2021-06-17 00:10:27)
> >> All other functions are defined for when CONFIG_DEBUG_OBJECTS
> >> is not set.
> >>
> >> Signed-off-by: Xin He <hexin.op@bytedance.com>
> >> ---
> >>  include/linux/debugobjects.h | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects=
.h
> >> index 8d2dde23e9fb..af0d73d8d29b 100644
> >> --- a/include/linux/debugobjects.h
> >> +++ b/include/linux/debugobjects.h
> >> @@ -99,6 +99,9 @@ static inline void
> >>  debug_object_free      (void *addr, const struct debug_obj_descr *des=
cr) { }
> >>  static inline void
> >>  debug_object_assert_init(void *addr, const struct debug_obj_descr *de=
scr) { }
> >> +static inline void
> >> +debug_object_active_state(void *addr, const struct debug_obj_descr *d=
escr,
> >> +                         unsigned int expect, unsigned int next) { }
> >
> > I suppose it's a landmine that may go off at some point, but this isn't
> > fixing anything that's broken at the moment, correct?
>
> The two users (RCU/i915) have it guarded with RCU/I915 specific config
> options which depend on CONFIG_DEBUG_OBJECTS.
>
> I have no problem with the patch per se, but it want's a proper use case.
>
> Thanks,
>
>         tglx
>
>
>

Yes, config options ensure that there will be no problems. But when
CONFIG_DEBUG_OBJECTS is not set, we should provide all empty
functions that may be used.

Thanks.
