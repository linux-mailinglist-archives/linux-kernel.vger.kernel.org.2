Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4137377898
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 23:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEIVJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 17:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhEIVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 17:09:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6CEC061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 14:08:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e11so4773178ljn.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEUReX21G5VTsk66AMRVB4ZwxsVW0bIo9WW4NuchitU=;
        b=LOwp2B4SstGoCbPt6x0msPL/aLEWhPJ1iETDlaaFGcwh62xXbi1VsWQ9zdBfhBJtz2
         cwPztAFCK56zT+OQKqFs62RzTHBn84W7ZtGbU5ec9YO1FtHUunzFoUve/A1VtpZKCc5Q
         HPKFBzVOs+hZDFjz8xN8NJ1nuEDHGes74KzNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEUReX21G5VTsk66AMRVB4ZwxsVW0bIo9WW4NuchitU=;
        b=fxCSOHSlMR35akPlRA0aHUsnEsKwO+I8ABEXrax9doTzMIfVM4is6pOCnAifKGuR6u
         BRr9LOnVkM3x8FcKWIZ/95CXJZ6BhMc39TbgJFL3AXzMrSfG9CeuQ2QF3mmczZpGoj3E
         WFQIbUzrBACIh7abtaM5vHw7YNZcVQCijV3DR0/cq/vndYUSOjLnyI95HqPxSWN39XeV
         iy1jzHAjwwyD3dTEKFpm7z7Nuuu4wsSEUBolFInBWrQfAIp4HcPaMlLeOHlWwzN8w9uq
         t14w1GX/HySc0UGgRW0b+50ZrO8DOC4Z4FJu+To+sHetUeSJ56XMede/vGOytujgM2aw
         Dnnw==
X-Gm-Message-State: AOAM531cgBbbv9CJ2S4hGxRAhwryT1TPdxfUB3R2qSQ9xzo4/Dd44ytG
        9tZ+vlUU4ehjEtzkKutbieTmtrf++LTWJTHyblE=
X-Google-Smtp-Source: ABdhPJwMhRKkvfOM0SIM37dQxmmoR0q8FL8vPUgO+teP+Enc5B86o8xhL/G14Kvri6Z3RuJ0mYb9Yg==
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr18071507ljj.186.1620594508645;
        Sun, 09 May 2021 14:08:28 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c7sm531532lfr.167.2021.05.09.14.08.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 14:08:28 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id h4so20437934lfv.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 14:08:27 -0700 (PDT)
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr14085253lfr.201.1620594507715;
 Sun, 09 May 2021 14:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twAN82gkzrfc2CGQopjkjEdWtBKMF2DgBOtw+6RsZ++fw@mail.gmail.com>
In-Reply-To: <CAPM=9twAN82gkzrfc2CGQopjkjEdWtBKMF2DgBOtw+6RsZ++fw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 May 2021 14:08:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf+kHeSZbpkZumWcTXUD7ordqTMvPRNL6aQVG1DSBDnQ@mail.gmail.com>
Message-ID: <CAHk-=wgf+kHeSZbpkZumWcTXUD7ordqTMvPRNL6aQVG1DSBDnQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes round two for 5.13-rc1
To:     Dave Airlie <airlied@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 9, 2021 at 11:16 AM Dave Airlie <airlied@gmail.com> wrote:
>
> Bit later than usual, I queued them all up on Friday then promptly
> forgot to write the pull request email. This is mainly amdgpu fixes,
> with some radeon/msm/fbdev and one i915 gvt fix thrown in.

Hmm. Gcc seems ok with this, but clang complains:

   drivers/video/fbdev/core/fbmem.c:736:21: warning: attribute
declaration must precede definition [-Wignored-attributes]
   static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
                       ^

but I noticed it only after I had already pushed out the pull.

I'm actually surprised that gcc accepted that horrid mess: putting
"__maybe_unused" between the "struct" and the struct name is very very
wrong.

I fixed it up after the merge due to not noticing earlier..

Maybe the drm test robots should start testing with clang too?

           Linus
