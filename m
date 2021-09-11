Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499EC407A97
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 00:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhIKWCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 18:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKWCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 18:02:45 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F84C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 15:01:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s12so9685769ljg.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVJ++gcLyqeb6D8u1bo0Qp2kTZx0cgjBEYii9V19c2g=;
        b=LLoNF6oh8l3EZwSYDeoHHad+NI8KQodeBADF5xTQPYQy8DfffT6/oL+SAksiZVHb5+
         q7GML4URU9mehf3zntJZ23AkN/TV1AUFum60PC0RF5KNdJx2mQE4YKpZQ0ayOhWHPfKB
         xNonKr7pi7T7RpKSX5hWNYhSSkD/lXVv/43vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVJ++gcLyqeb6D8u1bo0Qp2kTZx0cgjBEYii9V19c2g=;
        b=FJQIyz5PSwjX2c2BY+LW0Nk64ddbSk/2va5uD4yHJwHxy+v/3S+5S/dVsDEf44/rvn
         fyg9aSK61Z9wGoGEX2OsppsBeMMZHvpb/77B/G/vXO1xyiy5V+7eJ9hU8DEoGf1hy7Cp
         mUbjIEDWv4UhG7p4ptOP2FV0UhaggWYMANdMKXDlPgwZwt3luycvhR2xRNt/NIhc7sni
         WvBr0aD2U7ya3KrAU5TzGXRZWKf3Y1DNvGOHL58VLWty3wSoMHYXWE4Wn6olYbm6zcU9
         Bd98pm/mEv5vcCiR3ctWxWwrJxBckTwrCaf9wckfMfR08OdHbqz2MKytoYIkwal+YvTZ
         KLYw==
X-Gm-Message-State: AOAM533YuNh8wwTMJciU1sZ1hno5Em/QLk1jfh0O1aWBkr1N6vD7oYoa
        4Jz3+JfpQXuuf4IjHtUKhl3SIKRZe+UgL48g
X-Google-Smtp-Source: ABdhPJwTn1dtAqgXoaZ8V0HhsvU6OOxsfHsUhwFu9oQOPRK8NwOsh/KQNtOzHZXCkUizo2TVMAP/Xw==
X-Received: by 2002:a2e:4a19:: with SMTP id x25mr3670956lja.235.1631397690331;
        Sat, 11 Sep 2021 15:01:30 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id z25sm342584lfh.200.2021.09.11.15.01.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 15:01:30 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l18so9598224lji.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 15:01:30 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr3487995lfb.141.1631397388084;
 Sat, 11 Sep 2021 14:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210909095608-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210909095608-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Sep 2021 14:56:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcXzshPVvVgGDqa9Y9Sde6RsUvj9jvx0htBqPuaTGX4Q@mail.gmail.com>
Message-ID: <CAHk-=wgcXzshPVvVgGDqa9Y9Sde6RsUvj9jvx0htBqPuaTGX4Q@mail.gmail.com>
Subject: Re: [GIT PULL] virtio,vdpa,vhost: features, fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arseny.krasnov@kaspersky.com, caihuoqing@baidu.com,
        elic@nvidia.com, Jason Wang <jasowang@redhat.com>,
        lingshan.zhu@intel.com, mgurtovoy@nvidia.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        xianting.tian@linux.alibaba.com, xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 6:56 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> NB: when merging this with
> b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
> from Linus' tree, replace eventfd_signal_count with
> eventfd_signal_allowed, and drop the export of eventfd_wake_count from
> ("eventfd: Export eventfd_wake_count to modules").

What? No. That can't be right.

Do you mean "replace eventfd_signal_count with !eventfd_signal_allowed()"?

Because if I read the logic correctly, the issue is that
'vduse_vq_kick()' will call eventfd_signal().

Which it must not do it eventfd_signal_allowed() returns false.

So if eventfd_signal_allowed() is _not_ set, the code needs to defer
it to the workqueue.

No?

Side note: I was _this_ close to just not pulling this. The commits
were all from after the merge window opened, and I got this pull
request in the latter half of the second week of the merge window.

Your "explanations"  for this pull are also not any language I
recognize, or even remotely human-readable.

WTF does "vduse driver supporting blk" mean, and how is that supposed
to explain anything at all?

That is NOT how these things are supposed to work. AT ALL.

So you are hereby put on notice: next time I get this kind of
half-arsed garbage pull request, I won't spend the energy on trying to
figure out what is actually going on. I will just throw it in the
trash.

Because honestly, that's where this pull request belonged.

              Linus
