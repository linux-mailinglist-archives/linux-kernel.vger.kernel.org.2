Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87972376857
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhEGPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbhEGPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:54:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E977C061763
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 08:53:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so9775375wry.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=+4MhKiSAOaBSZ2e0f0C2//SWOf3tWAfCHwzMX/Loq+w=;
        b=dDC2ioa2p/PZMfhFE5RAjzJ/Z8CbnKiBAnKP5ZsR0acBSds+HRP1yH5rT3wrYFDV/I
         WadI+EeardjX9muzbLT8HAadUI8AWPemeh7hV6KhPbEK6Q6lflc1HDyEUhe3nXl/HAJx
         3yu35zTHp6SFgGvo42ByLYBvoO+wrbxxRtjVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+4MhKiSAOaBSZ2e0f0C2//SWOf3tWAfCHwzMX/Loq+w=;
        b=Ym8Y0ABCfrvDos1D4xS4E9d6uViYoOjEATfBQv54/WEKIOc1LCxjYnl6Ad+9R+/Pjn
         Ze46ZxLi76Mvwuy0usXKju3oJnQ+2FKV9XO1+gLOzp6wdcpn4bM1V7eBoAQd9l0DrmXz
         tfbbTLRAQ/hefNTOqtbWEXXfp6AbYug19sjXpeABtBYpX0GU/k/6ZLtLczHZvlYioK7Q
         4IfljpE/cXw/encTFxW8888ERFYQXDq7QdJe3VSBP/txMH/VeXvTkMxdZc4Hc5FTmbnt
         K+7iJTzT0TADnDeCbQ6HDZJ0jnTk9CKQVrDVQ5SEqINCj0ADfLsdk4/hqRi2Z9tR5G76
         hplA==
X-Gm-Message-State: AOAM530Kq7L7GrN+lPM6eIONki31n2Ef8dOHZfiZ95/3mCDO+dz+pj63
        Gtgqm/i+/dvYNnhRuPSqAE4K0w==
X-Google-Smtp-Source: ABdhPJzKCAJlfwDJjk5ry2+hiC8NsolPvCLFCMBs9dPYdX3bt1HsmTI6/Mti8w3xLs2d6fn0jOXVdg==
X-Received: by 2002:adf:df04:: with SMTP id y4mr13161189wrl.358.1620402833158;
        Fri, 07 May 2021 08:53:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g13sm8645777wrd.41.2021.05.07.08.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 08:53:52 -0700 (PDT)
Date:   Fri, 7 May 2021 17:53:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PULL] topic/iomem-mmap-vs-gup
Message-ID: <YJVijmznt1xnsCxc@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
References: <YJBHiRiCGzojk25U@phenom.ffwll.local>
 <CAHk-=wiwgOPQ+4Eaf0GD5P_GveE6vUHsKxAT=pMsjk1v_kh4ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwgOPQ+4Eaf0GD5P_GveE6vUHsKxAT=pMsjk1v_kh4ig@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 03:30:45PM -0700, Linus Torvalds wrote:
> [ You had a really odd Reply-to on this one ]
> 
> On Mon, May 3, 2021 at 12:15 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > Anyway here's a small pull for you to ponder, now that the big ones are
> > all through.
> 
> Well, _now_ I'm all caught up. Knock wood. Anyway, time to look at it:
> 
> > Follow-up to my pull from last merge window: kvm and vfio lost their
> > very unsafe use of follow_pfn, this appropriately marks up the very
> > last user for some userptr-as-buffer use-cases in media. There was
> > some resistance to outright removing it, maybe we can do this in a few
> > releases.
> 
> Hmm. So this looks mostly ok to me, although I think the change to the
> nommu case is pretty ridiculous.
> 
> On nommu, unsafe_follow_pfn() should just be a wrapper around
> follow_pfn(). There's no races when you can't remap anything. No?
> 
> Do the two media cases even work on nommu?

So personally I think the entire thing should just be thrown out, it's all
levels of scary and we have zero-copy buffer sharing done properly with
dma-buf since years in v4l.

Iirc I've had that in some early versions of all this, but got nacked by
some, supported by others from media as something that needs to go away.
This here is now the next best thing as a fishing expedition to figure out
whether there's actually anyone left who cares or not.

That's also why the nommu case has the same checks, even though it's all
fine there.

Hopefully the answer is "no users" and then we could remove this in a year
or two.

> Finally - did you intend fo this to be a real pull request? Because
> the email read to me like "think about this and tell me what you
> think" rather than "please pull"..
> 
> And I have now fulfilled that "think about and tell me" part ;)

Ah yes I rushed this a bit between appreciating some local fires here at
work and left out the instructions :-)

Please pull or tell me whether you want the outright removal (like
Christoph Hellwig also wants).

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
