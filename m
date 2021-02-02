Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4159C30C3B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhBBP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhBBPYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:24:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE16C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 07:23:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o10so2142948wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 07:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PBOv4oa0xyBSu7Av2IkfR/vnH44GMIHIBZqxC79Sm/Y=;
        b=DS825I+YcxBaWeWEl+ZNWlwgUUIR8iQmQPkY4QFjW+uga7eCjkKj/KLKeVvYlbT342
         XZW5+2Ar3ZP7nqC+R9oJZP8ayAuB43dHLEmwnU4GvZ9vZ1Wr26KIXGNKp38uQSy6K9Tt
         lMA+CYFhvJPF2cC1gm5jEgIe+iEoWYF68Djqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PBOv4oa0xyBSu7Av2IkfR/vnH44GMIHIBZqxC79Sm/Y=;
        b=JqJHEMUus8vMrskxC9uvuo+G3NT2o3Why8dwrE0qv3Amn4IsW7v0kuzKSvXZhBoa6I
         KfLet5tHBmGC6mxFuopABZsiU/K/fjCHITszwpaxoPp3zK/IqFvLzcVHEPX1+nmBcaAo
         FdUvykQzTTaMpsAP9bS0qss0zwrIPNRei81FvYaFNN8HI/mJQT/rBrw1QB0uqY7hyInt
         mgJ6AipjRFBi60jfxz16c9+A5GURDqF9gyKFORUZo7GlRBiYdPiLzyy4zfJtIVz+7J2P
         HWEmCaZiadhs8kbxXhUgJm+CxB4oY7BMAizlzxCVzQEN0nWpKAgyHsDko7AL9P6nNvAF
         b3uA==
X-Gm-Message-State: AOAM5313W3aPAGSfdwqzv3wd4dA5zimo+8si8WBeu2Av9Kv9x5pgl40V
        4sZI9a+7qGT+USwwzjBb576zSg==
X-Google-Smtp-Source: ABdhPJwc4Iu2brOpfruPVn+eCfb6X4r3qeK2Ze160BwejVhNYW1tKRv6W4xHtSFBHQEAxujvrMfubQ==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr4176491wma.29.1612279433428;
        Tue, 02 Feb 2021 07:23:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f6sm3373520wmq.33.2021.02.02.07.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 07:23:52 -0800 (PST)
Date:   Tue, 2 Feb 2021 16:23:50 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
Message-ID: <YBluhm2WV2rmWfja@phenom.ffwll.local>
Mail-Followup-To: Phillip Susi <phill@thesusis.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20200916205434.GA10389@duo.ucw.cz>
 <87czyf5jjp.fsf@vps.thesusis.net>
 <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
 <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com>
 <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com>
 <87k0s4ai33.fsf@vps.thesusis.net>
 <YBlfKgQ1laQLFqpW@phenom.ffwll.local>
 <87wnvqts9g.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnvqts9g.fsf@vps.thesusis.net>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 10:13:14AM -0500, Phillip Susi wrote:
> 
> Daniel Vetter writes:
> 
> > Just a quick comment on this: Since most framebuffers are write-combining,
> > and reads from that tend to be ~3 orders of magnitude slower than writes
> > (at least on the pile of machines I looked at here, there's big
> > differences, and some special streaming cpu instructions to make the
> > reading side not so slow).
> >
> > So scrolling by copying tends to be significantly slower than just
> > redrawing everything.
> 
> I know this was the case years ago with AGP as iirc, it doubled ( 4x, 8x
> ) the PCI clock rate but only for writes wasn't it?  I thought this was
> no longer an issue with PCIe, but if it is, then I guess I'll go ahead
> with cleaning up the dead code and having it re-render with the larger
> text buffer.

Still the same with PCIe, probably gotten worse since uncached reads are
still as slow, but write-combined writes have gotten much faster even.
There's work going on to have a coherent link to gpus which would allow
fully cached reads and writes, early with nvlink and now as a standard
with CXL (https://en.wikipedia.org/wiki/Compute_Express_Link)

But that's aimed at big compute jobs for servers, not really for display.

Also some on-die gpus have become fully coherent, but again only for
render/compute buffers, not for the display framebuffer.

So all together 0 signs this is changing going forward, reading from
framebuffers is slow.

Ok there's some exceptions: For manual update buffers (defio for fbdev
drivers, drm also supports this with an entire set of helpers) the
framebuffer used by the cpu is sometimes (but very often still not)
cached. Imo not worth optimizing for, since for the drivers where it is
cached they either have no blitter, or it's really tiny panels behind spi
links and similar, so not going to be fast anyway.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
