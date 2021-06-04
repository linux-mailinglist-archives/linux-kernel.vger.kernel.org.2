Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB3639B5B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFDJSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:18:02 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:53059 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:18:02 -0400
Received: by mail-wm1-f50.google.com with SMTP id f17so4944914wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0iAE1eXsi7Ags0kCh2NQ+Xw4BO7hibZ8156NIUiiC9Y=;
        b=jXU7UgrylnRUSGeCbfj1NxKE31gatksb608K/jN+nlg9LYwbeaeTZoAwcju45NWPNL
         Dll+M8tntKovKq1yobA2cANrzCfOGfHj9DvwCTVs43XpI723jBuZkYsrqBolUZlPSvA4
         1LH0u8TTFb6ZSwQUY/IReeDHz11/L/zgeWokY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0iAE1eXsi7Ags0kCh2NQ+Xw4BO7hibZ8156NIUiiC9Y=;
        b=rv0ZDPQQ2HoLFKuzcwGvXY1J3DIkuav3UzyubW6807c3dD2LacB7fLJ+7X2vqdmPKu
         2HKjYkxt0o5/CqCURBMjXQEIwVo/O7nJNSjd6BCxZDqJcdktgQph1bl22wMSOq+odxgX
         Rtp50ANQVAxFLc86tVFew1OOjYJPu2cyvkfgqs8b/zhNGmw5Jam8vel5hQQ/Ers1tbt6
         1eHDHApZxxhW9rTmq0EYw95nAmerobILtJFqhUZ3/vRgLFQYr4lKDgGW0vZwWioaP1Sa
         69WqNV91ZgDmTRy3RJCJDSFjmIZAyOMBLBvOcg3lLbU/iNCfJ9BtBCmCYhCnC1JRpNmz
         todg==
X-Gm-Message-State: AOAM532VnQ+tql2/uCE/wzm/5OxB3ao/g5c+Q6AXSXemnqiaqwu234s8
        hIz/LlJtVL4gmf7dqf3kPQnJymUHL4d8DA==
X-Google-Smtp-Source: ABdhPJyTtG/bEVOcLkvg2qjVHIyuSghlJN1mBim4VUqjG8axFLCZdSqoqLk9+jMvv7gN3CG7HSk3Bg==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr2640565wmi.117.1622798115481;
        Fri, 04 Jun 2021 02:15:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o17sm5681880wrp.47.2021.06.04.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:15:15 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:15:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/pl111: Actually fix CONFIG_VEXPRESS_CONFIG depends
Message-ID: <YLnvIYKduzv56YAA@phenom.ffwll.local>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>
References: <20210604014055.4060521-1-keescook@chromium.org>
 <CACRpkdZEQ+C7tSppcJ83Go70CaBLe4XYKBqYqJfZWAYq-H2+wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZEQ+C7tSppcJ83Go70CaBLe4XYKBqYqJfZWAYq-H2+wA@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 09:44:59AM +0200, Linus Walleij wrote:
> On Fri, Jun 4, 2021 at 3:41 AM Kees Cook <keescook@chromium.org> wrote:
> 
> > VEXPRESS_CONFIG needs to either be missing, built-in, or modular when
> > pl111 is modular. Update the Kconfig to reflect the need.
> >
> > Fixes: 4dc7c97d04dc ("drm/pl111: depend on CONFIG_VEXPRESS_CONFIG")
> 
> Yeah that doesn't work, thanks for fixing this!
> 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> > -       depends on VEXPRESS_CONFIG
> > +       depends on ARM || ARM64 || COMPILE_TEST
> > +       depends on VEXPRESS_CONFIG || VEXPRESS_CONFIG=n
> 
> That's the right solution,
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Since I screwed up already, care to also push this to drm-misc-next?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
