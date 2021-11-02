Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3101D4425FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhKBDWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhKBDWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:22:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B15C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 20:19:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so28225520otg.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mP0iUWFx62fiXXe3MsF+0AGzL9NGYQHX3AhW02hM5CQ=;
        b=HyJL0kiVhRfIRR+S5XXs0gkb8JaTF10my+YOr5H0MtgAW6y0y3fgGvUIlzGQvFX/+8
         MAUu9TtGxeOElAes+QNYmeeNPsSFwxs/kiiun9j51CmS1w+lbDsleutCK96aCAJR1sqy
         Mm5KcZPU0ZYRcW98q0zTWmZif1oJ1s8tZasDq11DbVe4I7E9PC8AD8X37+xY7uUFm+gm
         I6HZKtKR10Z4nN9WBVxm2WUIGLZnoihUKXQ3GdaUuR1ePUkNwBgBvKK2MMJOYWkFzAW8
         GkS+blYhOFGBvgUrDqWa2A7rxcM2X2AD/rGeeiIUAJUvFmGuwja8jbwFbzZl1Xfp88vc
         dnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mP0iUWFx62fiXXe3MsF+0AGzL9NGYQHX3AhW02hM5CQ=;
        b=c0CR6M+kdIgvroeprj2X9lEiPvoXuc8d0EcK0NVnCj5yEfmwfx30XCdNS0FitagV5a
         OmWgdHtMe/AVeSuAbLqDovXab2HEm7AMsITa2o6Lq92sbRf3NEg397/lXSUn0TOKOuXI
         RPlEfMhWSR4d0qXOrz68D9gsW5cMFghR5vIIGIIECkqTfsulF8mpAhwYvN7dVrT2hxW4
         rRlPldNbWFPbGcBvJKfF3kVL1RUbnYeT/7II4dQH28fpxd/afgcyNnTScQ92Z9+za/XA
         kzwdTuc3s6S3CS5GBmbQVeM39M2n71h9mlVPksCJuQYZTSuMaufFI5F6/ClGayb7mWv9
         JK4w==
X-Gm-Message-State: AOAM530ouyHeEnsUlngcia5pZyYhGCNp/0kgyqNlgag6w6oFLpS2aY2w
        AhieRouGZ9VwebZN+OQ8/b8=
X-Google-Smtp-Source: ABdhPJy5O64NxW7nPZ8yjcJjmzSi9to+/oIt19Cw+7Dkjz22oCusCO6HZ8EsnVhrUmy+DMOnBPn8Ww==
X-Received: by 2002:a9d:57c9:: with SMTP id q9mr24581201oti.281.1635823175837;
        Mon, 01 Nov 2021 20:19:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d24sm2097893otq.5.2021.11.01.20.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 20:19:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 1 Nov 2021 20:19:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15
Message-ID: <20211102031931.GA437868@roeck-us.net>
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
 <20211101002346.GA304515@roeck-us.net>
 <CAMuHMdWBgGvt8q9suk6tysgga7sJ4v74eJHHO=ifg2Rc3S9A9Q@mail.gmail.com>
 <89a3686d-1ef6-4677-5d9f-f5e15a77c50e@roeck-us.net>
 <CAHk-=wiZgzKMw7AkahZH-iCxJLAadS_nrzVJiCqrsFWfg7n_Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZgzKMw7AkahZH-iCxJLAadS_nrzVJiCqrsFWfg7n_Xw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 06:44:39PM -0700, Linus Torvalds wrote:
> On Mon, Nov 1, 2021 at 6:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Replacing "strlen(UTS_RELEASE)" with "sizeof(UTS_RELEASE) - 1" seems to do
> > the trick, at least with gcc 11.2 and v5.15. I just wonder if that would be
> > acceptable. Any idea ?
> 
> Looks sane to me.
> 
> I don't understand why gcc complains about that thing in the first
> place, much less why it only happens on m68k, but whatever...
> 
> The other - and perhaps better - option would be to just uninline
> memcpy_and_pad() entirely, move it to lib/string.c, and only have the
> declaration in <linux/string.h>.
> 
> Because the only reason to have it as an inline function is when the
> compiler can statically optimize a call site: but it's really not a
> performance-critical function to begin with, and clearly the compiler
> instead just *breaks* rather than optimize that call-site.
> 
Excellent suggestion. I'll submit a patch to do just that.

Thanks,
Guenter
