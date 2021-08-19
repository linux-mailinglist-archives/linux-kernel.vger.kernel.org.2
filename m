Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6393F1032
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhHSCFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhHSCFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:05:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07ACC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:04:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so374170pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8pSq2ahTDuGoiVpRUZKFPdbsfAusrUrIIUu2Ni7e/s=;
        b=MwyQKUFxuRCfpT7aSdwhgTpvG5iUx1xgrIXYt3rxB7MHSmzkskfDLFcbxeXvm+FoKM
         ocgF37XHI8qFhpJONlkRaoLK7yTqzWaJM4ZwtgzcdPvKbjFItjbiDvIFispOfR9w7nTI
         Ha1VyaEWTKRQrbtabTSg3aiHf++IfgVW6B9UZCAKnxuFLzhbOXcvjVwQWEdMj5/YtvOX
         y21AQozEUgxJl7t8+BKEGuTIIBkxxvKkt1Jb2VjvfIux1gW0lzNyvIK/h3cmdSqbAOvq
         huqmoj0KHFnAis97/PsQ2ysH82VXin9Oc7MN1dD+z0Vtx5WVHd6aiu8JT4ygUwq5szei
         LAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8pSq2ahTDuGoiVpRUZKFPdbsfAusrUrIIUu2Ni7e/s=;
        b=NZFS/LAX/bGHqPmTMYZO8JqQlt/qGFsCmNIr/t5baCddE5Jnyo7/bnR+7tTg0JxfzT
         lIu+OI7f34HkYT/hSxjJtRr+7ZlERctIVggXWNQO/q5+fYFdTEDdkGd/2/BwXFlBnXCB
         aQHfH94EVmPZYZpiZBqiV30cPxRqEgo//0Ed/PlGlo4d7/ZfLY7bKeeN1h/lnhzzdWNz
         l1RSBhXPN8+X9se8bHwh7Ywh20M516/KQ9fsfkgeo3H+Eq7OM/uIDX2NtXTRrALhDTRY
         InX6gwq1lrlgnvNjrkEOcbmOtcty/tbyolSU29+3EdPKvTBHi2TI8DVP3RrStXKyzxRK
         10nw==
X-Gm-Message-State: AOAM5338NSy8U38kH7rIg51CBfsccHrZ5+tVyMOrg58E9ysM7jLefx2i
        d8e99k9ujMNA01L8zDptP8CEht9oGV5zh4mQHvvXgQ==
X-Google-Smtp-Source: ABdhPJwEss61R+YGuKuQ/7eeNweeErVCe+4SBPDaGMiRjtIhpwl7hLMuELKSaujA/O01JKE9PkmjK0uXJc8fTLRHebY=
X-Received: by 2002:a17:902:d48e:b0:12d:7aa5:de2e with SMTP id
 c14-20020a170902d48e00b0012d7aa5de2emr9670291plg.34.1629338684303; Wed, 18
 Aug 2021 19:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210815061034.84309-1-yanghui.def@bytedance.com>
 <20210816175952.3c0d1eee821cd2d9ed7c3879@linux-foundation.org>
 <YRsULowKJtUKJhJ+@casper.infradead.org> <CAMZfGtVNJxTw-TPXHGF0kCwYMQK8hVG6=Z+hE3yuQRZh6ak-mw@mail.gmail.com>
 <YR0iHyBHuYufepWV@casper.infradead.org>
In-Reply-To: <YR0iHyBHuYufepWV@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 19 Aug 2021 10:04:06 +0800
Message-ID: <CAMZfGtUfefDjTw-rSfv=OHQzDWpvAFJtspOrv3+J2hCRFoLBAA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/mempolicy: fix a race between offset_il_node and mpol_rebind_task
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        yanghui <yanghui.def@bytedance.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 11:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Aug 18, 2021 at 10:02:46PM +0800, Muchun Song wrote:
> > On Tue, Aug 17, 2021 at 9:43 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > +   unsigned int target, nnodes;
> > > > >     int i;
> > > > >     int nid;
> > > > > +   /*
> > > > > +    * The barrier will stabilize the nodemask in a register or on
> > > > > +    * the stack so that it will stop changing under the code.
> > > > > +    *
> > > > > +    * Between first_node() and next_node(), pol->nodes could be changed
> > > > > +    * by other threads. So we put pol->nodes in a local stack.
> > > > > +    */
> > > > > +   barrier();
> > >
> > > I think this could be an smp_rmb()?
> >
> > Hi Matthew,
> >
> > I have a question. Why is barrier() not enough?
>
> I think barrier() may be more than is necessary.  We don't need a
> barrier on non-SMP systems (or do we?)  And we only need to order reads,
> not writes.

Here barrier() is just a compiler barrier, which is cheaper than
smp_rmb() which usually equals to memory barrier instruction
plus barrier(). So I think barrier() , which will stabilize the
nodemask in a register or on the stack, is more appropriate here.

Thanks.
