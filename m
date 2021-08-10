Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FFD3E5A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhHJMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbhHJMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:39:50 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F3C061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:39:29 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so5298052ooi.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ww4lecu94JFzIEYqvV9wG7CxGy+w0GGJNoOyQcE+rlc=;
        b=ffiSBfSdQpFtWh7sQOjXNBnszBrgvX6rNORPzYxTX+tvrunJaBXxCrum0ZMT5f9l2k
         zyqH+vsUOSNGCL17xPZRTerBTSJYWxCte6Roaedn0wbufD49iFAARtF040ezK7Zgr3iy
         3h8MgKpfFJ+t2iFewQj98iYZOtPAn8i01ALs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ww4lecu94JFzIEYqvV9wG7CxGy+w0GGJNoOyQcE+rlc=;
        b=MDorbJvU5nBAXASv7ngEWeuz639yTY6JNYTQgufHLRZ7w/DOy/CW1FDoWa1PQQAQHQ
         lqWeTRbQtbUvC0lj29iKEN6Fp7sAJkTWZwaQWTAA8GAIuNxftiHuUrsBC+wlNlk/TaPV
         EmaS/4gg5jOtNLY4/V+/VGn5N8Q+MuTCEsnhcH6zEvx+qxV2mUiRDD3uMCVyRPxdH9eh
         QLwFwW1d81DsTPQKlANGZpwrOanKRGxQ61xrJtRmH9vLsWD4gnEXh4ELV0uEtqD1vzXx
         cz4z0VhmctvN4dqYyM6CcOOyn3KnuMBtM8vn6KOcCvz/SaFrlk/6suTct5Y4QBCwlgcO
         ie0Q==
X-Gm-Message-State: AOAM5325Mz9Ny/KTHfX5Aez5VpJjQxdgGODCujCQcvcDn2CwE50306Kb
        yaV9wVbOwyNYEbEkOHSQbt/a+qYmbkJEEqZJZ+gHNg==
X-Google-Smtp-Source: ABdhPJzkbH9UZquu28KHT62dWS3UnyJcbbKQgX0h6vB//foTcVEs6gPGNyoiQPrtmrJTNpUd49l4Pb/NsVxqVCikPIY=
X-Received: by 2002:a4a:b402:: with SMTP id y2mr16540156oon.89.1628599168467;
 Tue, 10 Aug 2021 05:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210603193242.1ce99344@canb.auug.org.au> <20210708122048.534c1c4d@canb.auug.org.au>
 <20210810192636.625220ae@canb.auug.org.au> <YRJRju/zo5YiF1EB@phenom.ffwll.local>
 <20210810203859.128649fc@canb.auug.org.au> <YRJaD51xR8rQ2ga+@phenom.ffwll.local>
 <20210810210129.03b3fba5@canb.auug.org.au>
In-Reply-To: <20210810210129.03b3fba5@canb.auug.org.au>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 10 Aug 2021 14:39:17 +0200
Message-ID: <CAKMK7uHyUbc5StULAgawYZUtZqyYxfud5CMh3MaGJ5KS0FeXRQ@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 1:01 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Daniel,
>
> On Tue, 10 Aug 2021 12:50:55 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Uh that's not good, I missed that. I'll look into it.
>
> Thanks.

Doc build is taking absolutely forever here, but I think I have the
right patch for you. t-b/ack would be great if you can give it a spin,
I cc'ed you.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
