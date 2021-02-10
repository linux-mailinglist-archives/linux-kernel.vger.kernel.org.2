Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332C9315F26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBJFpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhBJFpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:45:09 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08344C061756
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 21:44:29 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n2so700259iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 21:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxU8IRCGR97Dvk+7yTC7hx+Kq4dL2ppiigmq6snofR0=;
        b=Ul0PbOnIGdeH63m0gJ+cUttf5WrJNBWQwEhcSLnozxqvGCSAltPPWZ8t3U4Lnb4KgP
         yX9jMMv5qoCQWCk/k/iQgyq4P74jQIQFSihpOoVsLnJGfIQiB5uSrAWTC0ac0OK83xHC
         a9eW3CDfMsdSpgsL9atO7fPm9JRXFEioHHq76Wwe8kuUT5bg4xD6SP/mYBgnvKh2XWnO
         G31Wbj3VmQcMNpM++f/5qLd50NxvY6VXz2XcdEfdLnPgWgv4uypAxfL0g9CfGVAXY/P1
         oLG0fidBYW9GERPlTnpltvbSnISXpx4TGl606aQIlxN0JJuvRKujHFVFfWZD+HGPGRm6
         VOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxU8IRCGR97Dvk+7yTC7hx+Kq4dL2ppiigmq6snofR0=;
        b=cEypUHSzk25F06ZHwtlERsK4HR6HPto5rvJg8RXOytLVjuqs+++a7q28Rg0qX60142
         EXKNNTb+3SdJj/RrQfPvGcR0+IdGbmOu9CThiEq1y9t1MT7QarDhhivQotpUJdjIcAF3
         sHhIij9Q0DFjB6Sl17frTSdbSBdLqTthUxNb1GXigtk8qiwowyzQVf45S6/Mw7s7cBFV
         GsrcyAqa1fWQEnTVr7U0f9KSWty095A2nVxPWAxCqk9UXu8foYKPTKAxhTK844+42Lvb
         DSh82antY/VM0Da1Nby2LkAB91MG094qK3BHtDrQisRbpz94NMQkTACn85tSKv3gxH6c
         5dkQ==
X-Gm-Message-State: AOAM533TrghSgD7ftqh5UQs1Edt8vDq5zc6jmA9T2p584PWTydiMU3y1
        VcsbnPGHWD+qj28H+9PliZGHcNq0438ZlnHp+XX5RQ==
X-Google-Smtp-Source: ABdhPJzx+44vbNZxM7chxO5QYuXJDZBMfs5kK6NrvfLTxPoxvDYZlzQL0u/bqd4ZbJZAEndortO67bfdT3O+gtyWlEg=
X-Received: by 2002:a6b:da0f:: with SMTP id x15mr1167410iob.48.1612935868235;
 Tue, 09 Feb 2021 21:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20210210013206.136227-1-dlatypov@google.com> <YCNF4yP1dB97zzwD@mit.edu>
In-Reply-To: <YCNF4yP1dB97zzwD@mit.edu>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 9 Feb 2021 21:44:16 -0800
Message-ID: <CAGS_qxqz0v2pLaJVoHTFsJ7TmDNiYGxpGJ0q0yVHmDrrO9--bg@mail.gmail.com>
Subject: Re: [PATCH] ext4: add .kunitconfig fragment to enable ext4-specific tests
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 6:33 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 09, 2021 at 05:32:06PM -0800, Daniel Latypov wrote:
> >
> > After [2]:
> >   $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
>
> Any chance that in the future this might become:
>
> $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4

I've been in favor of something like that for a while, but haven't
gotten folks to agree on the details.

Using bazel-like syntax for a bit, I'd really like it if we had some
easy way to do
$ kunit test //fs/...  # run all fs tests across all subdirs

But since there's the possibility of having tests w/ incompatible
requirements, I don't know that kunit.py can support it.
(Tbh, I think just concatenating fragments would probably just work
99% of the time so kunit.py could get away with doing that).

So --kunitconfig=<path> is currently a compromise to give us a less
controversial way of providing one-liners for testing a whole
subdirectory.

I don't think there'd be too much opposition for --kunitconfig to
automatically append ".kunitconfig" when passed a directory.
But there might be some, since a reader might think --kunitconfig=dir/
means it's recursing over all subdirs.

>
> Or better yet, syntactic sugar like:
>
> $ ./tools/testing/kunit.py test fs/ext4

The positional argument for run/exec is probably going to be taken by:
https://lore.kernel.org/linux-kselftest/20210206000854.2037923-1-dlatypov@google.com/
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=5d31f71efcb6bce56ca3ab92eed0c8f2dbcc6f9a

So we'd see something like:
$ ./tools/testing/kunit.py run --kunitconfig=fs/ext4 '*inode*'

Or if we set and followed naming conventions:
$ ./tools/testing/kunit.py run --alltests "ext4-*"
(this would take a lot longer to build however...)

Filtering could also let us curate only a few, less granular
.kunitconfig fragments (at the cost of higher build time).
E.g.
$ ./tools/testing/kunit.py run --kunitconfig=fs/ "ext4-*"

>
> would be really nice.
>
>                                                 - Ted
