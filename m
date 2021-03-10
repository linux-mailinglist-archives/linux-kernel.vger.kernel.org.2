Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A32B334677
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhCJSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbhCJSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:18:04 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C62FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:18:03 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id q14so26817981ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpDjOQGipxtGbHX94JXlEbC0IXpbBiAbS1kNdu4N3C8=;
        b=gx9b+KA2koGPmvkgL2m+rd2/PB54L2OtDKvxEd7eW9un+X+Mn6Px+LOwYAv70n7w6n
         WbeM9g1TVd4iY1igv/miJQLC/40aLe5QQqJ54JWwfs5mSciLWENnujwQy6yZDrdSs5CJ
         2qTkjb7pgUwpY7n+RWuZ4bd1OXx0iR51vEzY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpDjOQGipxtGbHX94JXlEbC0IXpbBiAbS1kNdu4N3C8=;
        b=X+HMkcHikiCQa7Z24RZ0/1I2kMeu+IL5/hn4dxe8fsqr1Yc6aDTiu/4r+G9hUua5Um
         lZ3VssnEAI502usFWpyN2DK4JkBUQVAllpP4j8OgESe3NNgE1GFgI6p/OLPw1h326PPP
         XlgIDU0QCPhxg8EPoTyrj7VJ1FgrxqYbweoSIEkxo1iKaHLKcSRlKMSVpKO8I1R84XuX
         SPFE1p0dOCQfpgDeqYMk3RIfg9TF/lvkJ6Fg6EQPaRdsxznjymtEqIM86WBsFrkC7qbi
         vzWwdl5k9XNaXb3XauEzUru0VGpF3K2YRBxXV8jzDp19EyctbWV14CI5p53uha1rUgHJ
         WSsg==
X-Gm-Message-State: AOAM530dmcEPR/vqqIKoablTIcwXtaaj2SLUOsYcOleCZRwqczCoEV5c
        c/NmA5KqdQ8GyHBDQQ55TM50dpfE2CEVHQ==
X-Google-Smtp-Source: ABdhPJyItBk3n5yoWIC9kp3gqHPAEI+837Jxueoxv2UqMsdBZ1p7WDOAG3/fmmJcFIaQCmUjpOtD5g==
X-Received: by 2002:a2e:9195:: with SMTP id f21mr2427901ljg.160.1615400281276;
        Wed, 10 Mar 2021 10:18:01 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g9sm13906lfc.258.2021.03.10.10.17.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 10:18:00 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 18so35084960lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:17:59 -0800 (PST)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr2668448lfu.41.1615400279498;
 Wed, 10 Mar 2021 10:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20210301080404.GF12822@xsang-OptiPlex-9020> <CAHk-=wh+RFzJqa51aO2zgGFhgV7=WjTs82B2wFfCMEHPs4B49g@mail.gmail.com>
 <alpine.DEB.2.22.394.2103100757530.128125@gentwo.de>
In-Reply-To: <alpine.DEB.2.22.394.2103100757530.128125@gentwo.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Mar 2021 10:17:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJCPchWozS0-4gF8zJ+9SfRv3h7jCSmivr+fs+eJJuZA@mail.gmail.com>
Message-ID: <CAHk-=whJCPchWozS0-4gF8zJ+9SfRv3h7jCSmivr+fs+eJJuZA@mail.gmail.com>
Subject: Re: [mm, slub] 8ff60eb052: stress-ng.rawpkt.ops_per_sec -47.9% regression
To:     Christoph Lameter <cl@gentwo.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jann Horn <jannh@google.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 10:59 PM Christoph Lameter <cl@gentwo.de> wrote:
>
> >
> > it really looks like this might well have been very intentional
> > indeed. Or at least very beneficial for _some_ loads.
>
> Yes the thought was that adding an additional page when contention is
> there on the page objects will increase possible concurrency while
> avoiding locks and increase the ability to allocate / free concurrently
> from a multitude of objects.

I wonder if we might have a "try twice before failing" middle ground,
rather than break out on the very first cmpxchg failure (or continue
forever).

Yes, yes, it claims a "Fixes:", but the commit it claims to fix really
does explicitly _mention_ avoiding the loop in the commit message, and
this kernel test robot report very much implies that that original
commit was right, and the "fix" is wrong.

Jann - if you had other loads that showed problems, that would be
worth documenting.

And as mentioned, maybe having a _limited_ retry, rather than a
"continue for as long as there is contention" that clearly regresses
on this (perhaps odd) load?

But for now, I think the thing to do is revert.

         Linus
