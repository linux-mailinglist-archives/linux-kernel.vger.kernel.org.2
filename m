Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A040B549
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhINQwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhINQwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:52:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD72C061766
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:50:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y17so12836850pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6so9+H9B6dPIilTjmgcr2K/Yl8eZOWVBVGsoCJwBiw=;
        b=gERDkktioufqF+vbtwYcgQ6QgXrCm5cHbppFCz3vX35Zom8hV9h9BZzOk/y2P89y5j
         vjtufEiykiNg4Dv8s6bHZ6rFg0atu5FtqD4I8B3y5Z2dqtHFS+YxBvJdphTD6H6pHRxg
         +ct2iwCH+GbOPoBwOgb72t2aNM8LJhQhGgfGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6so9+H9B6dPIilTjmgcr2K/Yl8eZOWVBVGsoCJwBiw=;
        b=OBmk/r9856OEluOFm2RT9JeEJhikCLhDmglQ7ILApzFbvQoQHizNhlhUJ2POc+WWB9
         rdhhSHQq+pUXHqXnIxlL6yEYhrn6qGBpQ+exp6qptCprslGZIOoZYm/e4i039zS00I9G
         FloL7bzLR2NLj3XEYOsatIHD9y9ZYNo4iTHbLXuE1yJHjQUQ+bRNqppmOv05x2nsNozV
         8nSr8cYpyAZk2giUxwQiz84sOXnugsatoSt/Pz1nZNu/RviUHbtjHfLULw1TKZ9y4UQW
         nYbm4tSXs/+aoeKnZr8iRi2jORsC0doZoySgUcPxYTFg0T4kzONW3ci9ZGbIY/nOdGiz
         V7hw==
X-Gm-Message-State: AOAM5334P5WvuUFgfETryHrZvc81Q1Ur9RvtrskwrKh1tZPLiHC2hxT9
        YrM9BHA1s4ABAcNqzB56x49N/5ZFA3x+8A==
X-Google-Smtp-Source: ABdhPJznbuMgzCMFon27LH5XIM+/RW9oKNGMYjFddGOMgG/9zII/aZ5tpxqztUqBzMNpxAyC++Qllw==
X-Received: by 2002:a63:fb49:: with SMTP id w9mr16133602pgj.156.1631638255346;
        Tue, 14 Sep 2021 09:50:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a10sm11480982pfg.20.2021.09.14.09.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:50:54 -0700 (PDT)
Date:   Tue, 14 Sep 2021 09:50:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] treewide: Remove unnamed static initializations to 0
Message-ID: <202109140938.65A989239@keescook>
References: <20210910225207.3272766-1-keescook@chromium.org>
 <CAHk-=wiyq84MKRd1F4d8SGTcTgdd3ktwPr7_9s8tjgKRx_+2kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyq84MKRd1F4d8SGTcTgdd3ktwPr7_9s8tjgKRx_+2kA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:40:41PM -0700, Linus Torvalds wrote:
> On Fri, Sep 10, 2021 at 3:52 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Since "= { 0 }" and "= { }" have the same meaning ("incomplete
> > initializer") they will both initialize the given variable to zero
> > (modulo padding games).
> >
> > After this change, I can almost build the "allmodconfig" target with
> > GCC 4.9 again.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > With this patch and the following three, I can build with gcc 4.9 again:
> > https://lore.kernel.org/lkml/20210910223332.3224851-1-keescook@chromium.org/
> > https://lore.kernel.org/lkml/20210910223409.3225001-1-keescook@chromium.org/
> > https://lore.kernel.org/lkml/20210910223613.3225685-1-keescook@chromium.org/
> > I look forward to raising our minimum GCC version again! :)
> 
> So this was one of the patches I left in my pending queue, and I don't
> exactly hate it, but given the option to just say "don't use gcc-4.9"
> and applying this big patch, I did the former.

Yeah, I think that's best.

> That said, one of the reasons I didn't like the patch that much is
> that it seems to be a mindless "just search-and-replace everything",
> very much for initializers that didn't complain even with gcc-4.9, and
> that were entirely correct.

I was using Coccinelle to minimize the impact.

> I would _not_ mind a patch that actually fixed only the places where
> it actually _is_ a question of missing braces, and we have an unnamed
> union or something like that.
> 
> So some of the gcc-4.9 warnings certainly looked at least _somewhat_
> reasonable for a compiler that didn't do unnamed unions or structures
> very well.
> 
> And I wouldn't mind replacing those. But this patch seems to then
> change entirely correct code that no reasonable compiler could
> possibly warn about. I wonder if some coccinelle script or other would
> find a much more reasonable subset?

Right -- for example I excluded all 1-dimensional scalar array
initializers. The warning comes from (IIUC) compound types (i.e. a
struct or union within another struct or union).

> With the gcc-4.9 support being dropped, that probably doesn't matter
> any more, of course. But I just wanted to say that I didn't hate the
> patch, but that it seemed to be too much of an automated hammer for
> the problem that could be solved a lot more surgically.

Yup, I'd much rather just leave all this as-is. It's effectively a
20,000 line white-space change, since there should be no actual binary
output difference. When I spot-checked this, it was true, which is what
I was expecting.

> The three remaining patches you point at look interesting, although I
> think that third one looks decidedly odd. Why not add the 'const' in
> the callers instead of removing it from the function? And why don't I
> see those warnings - is this some compiler bug?

Looks like a GCC 4.9 bug, yes. The other two I'll continue to pursue,
since they're general correctness fixes, even if modern GCC deals with
them happily:
> > https://lore.kernel.org/lkml/20210910223332.3224851-1-keescook@chromium.org/
> > https://lore.kernel.org/lkml/20210910223409.3225001-1-keescook@chromium.org/

-Kees

-- 
Kees Cook
