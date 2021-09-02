Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90D23FF079
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbhIBPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbhIBPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:49:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1F5C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 08:48:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f18so5257713lfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wsPeIhzYXabpZGJAWeTrSQOBVTFZSeI6/V+A/PKS+M=;
        b=ERUiyJetgJfhv6CSzrx6t3BC3sUidOHQEL/eDPlppAa2ihMq3Wb2UVSXXDUuPuaU1A
         4/XvqW5lS+oI+M7I2xMssmbTqkpxCPxhR1wO2lWfQBg4oc+w/Mm4258ukKLi75PZRBLY
         Wn2b943/0K9fY7TmwJ8wE1L+ipYVBjxFcZqsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wsPeIhzYXabpZGJAWeTrSQOBVTFZSeI6/V+A/PKS+M=;
        b=eAm7NmOR9yqcE90vpLMdVQXgOuBynr1oiiDQedggNPuTG+gqCpj5b/cKHgQC2b2Uec
         eByE9j5ZnuQ0TXvygQjt+O8tUpW/L4dkSFhJXVRy5b9rJvtwNi8DYV+8XAJi3edw+eEY
         L0bMqPUrGXjC5/c7CR8N391DVO1JfdZ3CSOy30H3chDwQpH3KJcB7swPYi7hxHIbYhQE
         uDmBrzkJ9+EFXUmf3hlSbvjoqrKOF0X9Ik7OFQmfWwL+3xsbR1Nt3ZlDcSgpQodPFWTI
         oqdUw2AhP6VI9Pw9XaTr3++gfVzxF6bIwL5vntEJZi8zOsbulXEEJePJW3JDtCAdPu9r
         nTMA==
X-Gm-Message-State: AOAM530Bh2ISmPZw2XuSUtGDNcVpJpfHxxUXatS3Sz01olgL6ySexwPx
        D3D18Aex57zr8D8y+GpmU3g5LqY0telgs1UT
X-Google-Smtp-Source: ABdhPJw/G7WLH/XcsJsz+vD2Gsw39K+/aykU7/bH+M2zA9CdT+4rqgEbf61BEYAuf9rcH1CxsvUxdw==
X-Received: by 2002:a05:6512:1289:: with SMTP id u9mr3192007lfs.296.1630597680799;
        Thu, 02 Sep 2021 08:48:00 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x34sm231041lfa.265.2021.09.02.08.47.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 08:47:59 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id t12so5120314lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:47:58 -0700 (PDT)
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr3148224lfu.253.1630597678499;
 Thu, 02 Sep 2021 08:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210831211847.GC9959@magnolia>
In-Reply-To: <20210831211847.GC9959@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 08:47:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
Message-ID: <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.15
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 2:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> As for new features: we now batch inode inactivations in percpu
> background threads, which sharply decreases frontend thread wait time
> when performing file deletions and should improve overall directory tree
> deletion times.

So no complaints on this one, but I do have a reaction: we have a lot
of these random CPU hotplug events, and XFS now added another one.

I don't see that as a problem, but just the _randomness_ of these
callbacks makes me go "hmm". And that "enum cpuhp_state" thing isn't
exactly a thing of beauty, and just makes me think there's something
nasty going on.

For the new xfs usage, I really get the feeling that it's not that XFS
actually cares about the CPU states, but that this is literally tied
to just having percpu state allocated and active, and that maybe it
would be sensible to have something more specific to that kind of use.

We have other things that are very similar in nature - like the page
allocator percpu caches etc, which for very similar reasons want cpu
dead/online notification.

I'm only throwing this out as a reaction to this - I'm not sure
another interface would be good or worthwhile, but that "enum
cpuhp_state" is ugly enough that I thought I'd rope in Thomas for CPU
hotplug, and the percpu memory allocation people for comments.

IOW, just _maybe_ we would want to have some kind of callback model
for "percpu_alloc()" and it being explicitly about allocations
becoming available or going away, rather than about CPU state.

Comments?

> Lastly, with this release, two new features have graduated to supported
> status: inode btree counters (for faster mounts), and support for dates
> beyond Y2038.

Oh, I had thought Y2038 was already a non-issue for xfs. Silly me.

              Linus
