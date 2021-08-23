Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6791B3F4D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhHWPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhHWPTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629731907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UQPHdxCvb0Ewfa1Oz5Y/LDOGEQHYeTGsDvKMf5nPfA=;
        b=chuTmSGFF+WiTnjZ8/mDZM7eOFL6S9CSHvXDcoLgXnOdpYA9Ire+joPbV3Oj9QeezDf1Ij
        LpCrU0YTBMHdwWXRn2UivHFcNQEnqrq8SKvQXWf55UXdlADl9l5q8ySNR59Khe4uxQpBu6
        FiDJz7yvKce3MV3JEUaQ8rN2Hb5BTXo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-LpOUaa7rOkOU2Rhlht9fXw-1; Mon, 23 Aug 2021 11:18:25 -0400
X-MC-Unique: LpOUaa7rOkOU2Rhlht9fXw-1
Received: by mail-wr1-f71.google.com with SMTP id h15-20020adff18f000000b001574654fbc2so1722716wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 08:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UQPHdxCvb0Ewfa1Oz5Y/LDOGEQHYeTGsDvKMf5nPfA=;
        b=ocYOfhuiYnhLaIZpV0S5apjUolhRtPRslM7wEZA41nLkBc+u7QqHykRJB3+UpCUPLt
         qWZIcEzTfO9KuBaqq1CQbMfqKe6brkXk3ZPx+oIESaq3g/kbSFXe0YbatXMQPxLCmILZ
         GsImNjCpdbO0En0f51VjYA3gmpN0eW+gUVfm6COGlccliIohAIeYvgwOaEZXc3Qmi+kd
         32+lucBijOGgEUaQNRWBZ5x0amn62mdGPPiLPSUsZHQrdELCbQCpforgI5AkbzuaYIcw
         yvijrODGeRGEGuW+Y7fHM4pyJqRs79vZ1nO1+zyN8TSKk3vHhg7h+afTo9cvlWdUsV/I
         CqoQ==
X-Gm-Message-State: AOAM532svEyLA6y9tXHo5k/TMCiImQNnYRF/pJfFRMKgQcL/yd7PuPKr
        WB+YJZs1Xq7+2zWGXoyPecLo1xwfdRa1yVLtsFqm9f1hpy5MTJk6FVtFJk4xeuhFpsSPlU/Awzf
        oDwZvAEAe1nJj3GptkyOkK9jKJvOhW5AnonNv8wWe
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr6615039wrb.329.1629731904222;
        Mon, 23 Aug 2021 08:18:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP18KupeQocqPi7pOs/GkS6DYQwd2BMjtkeQW4SttZsY2aCuhDw4kt4ORRQF7kvquqp7Y+qyQBLWafEIaQ/7o=
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr6615019wrb.329.1629731904039;
 Mon, 23 Aug 2021 08:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210819194102.1491495-1-agruenba@redhat.com> <20210819194102.1491495-11-agruenba@redhat.com>
 <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
 <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com> <CAHc6FU7EMOEU7C5ryu5pMMx1v+8CTAOMyGdf=wfaw8=TTA_btQ@mail.gmail.com>
 <8e2ab23b93c96248b7c253dc3ea2007f5244adee.camel@redhat.com>
In-Reply-To: <8e2ab23b93c96248b7c253dc3ea2007f5244adee.camel@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 23 Aug 2021 17:18:12 +0200
Message-ID: <CAHc6FU5uHJSXD+CQk3W9BfZmnBCd+fqHt4Bd+=uVH18rnYCPLg@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 10:14 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
> On Fri, 2021-08-20 at 17:22 +0200, Andreas Gruenbacher wrote:
> > On Fri, Aug 20, 2021 at 3:11 PM Bob Peterson <rpeterso@redhat.com>
> > wrote:
> > >
> [snip]
> > >
> > > You can almost think of this as a performance enhancement. This
> > > concept
> > > allows a process to hold a glock for much longer periods of time,
> > > at a
> > > lower priority, for example, when gfs2_file_read_iter needs to hold
> > > the
> > > glock for very long-running iterative reads.
> >
> > Consider a process that allocates a somewhat large buffer and reads
> > into it in chunks that are not page aligned. The buffer initially
> > won't be faulted in, so we fault in the first chunk and write into
> > it.
> > Then, when reading the second chunk, we find that the first page of
> > the second chunk is already present. We fill it, set the
> > HIF_MAY_DEMOTE flag, fault in more pages, and clear the
> > HIF_MAY_DEMOTE
> > flag. If we then still have the glock (which is very likely), we
> > resume the read. Otherwise, we return a short result.
> >
> > Thanks,
> > Andreas
> >
>
> If the goal here is just to allow the glock to be held for a longer
> period of time, but with occasional interruptions to prevent
> starvation, then we have a potential model for this. There is
> cond_resched_lock() which does this for spin locks.

This isn't an appropriate model for what I'm trying to achieve here.
In the cond_resched case, we know at the time of the cond_resched call
whether or not we want to schedule. If we do, we want to drop the spin
lock, schedule, and then re-acquire the spin lock. In the case we're
looking at here, we want to fault in user pages. There is no way of
knowing beforehand if the glock we're currently holding will have to
be dropped to achieve that. In fact, it will almost never have to be
dropped. But if it does, we need to drop it straight away to allow the
conflicting locking request to succeed.

Have a look at how the patch queue uses gfs2_holder_allow_demote() and
gfs2_holder_disallow_demote():

https://listman.redhat.com/archives/cluster-devel/2021-August/msg00128.html
https://listman.redhat.com/archives/cluster-devel/2021-August/msg00134.html

Thanks,
Andreas

