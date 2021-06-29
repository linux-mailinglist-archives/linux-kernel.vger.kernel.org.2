Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A23B6D22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhF2DuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhF2Dt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:49:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7DEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 20:47:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t17so36867198lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 20:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAkvrvf9vGodn3/SdXI/Z/HezeeoY0M2aYPCWRA/0sw=;
        b=FmHwzUVnPSfz54gaaoFrV1I0m/OZYcDkto7MvfD87BMJlg2wfd6ksfLDQbgEpoWnMe
         GAzSOezqUJyyT5jjyC+szrJQMOrt+WSEMBY7k37vOZp5Td1xrgjvF0meno42vsEqDRBl
         FOMVPDRn63bn/bCTzLCUFsYJJWTGc/rswSo/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAkvrvf9vGodn3/SdXI/Z/HezeeoY0M2aYPCWRA/0sw=;
        b=kqmlZ5PEkhgnm920Z2bcW1tkteoW7L4rPenCkmbJlzLNYtE/2AVVIt/HpZ+RX+5s3P
         VDeGu+AKVpYZEF/GUJ3HFtYvkd9pdBgbrCc6rbHohjNvbzKTAmOKMiLx29uMxuN6zG9T
         0M40mcbzxdLMCzXahdCtJPCg7Cdla2PIdEbdp9AC/1vihCbME86mnjOg9J1P+NkUFAqE
         nWO4ibokUrrEu1CIjJvfj8vRsEjDJKhRBSDh/kVMBRRwi9HgfE+6Mr/R9w6pyIVoX7EF
         737TuJKnadAzMIXUmlOoJi5zRCIIKM9CBPkfRYkRSCu4bWvehlX1K0UTq7K2RZq3RRHr
         IkxA==
X-Gm-Message-State: AOAM530nTzvROFGc/bc6jdRL6Ewpv0J0L7cEjyPLrAl/NNyglSjIE4zH
        ueZNZjvAJHtHa0JxVE93eYEG38u0VCIOaPnVVPI=
X-Google-Smtp-Source: ABdhPJz/QNKO7goDyu0v+1cf0G7sOQM9O0rqxbBiC2hEYzumzWrq1qO9k0dlT+99hmrWGhJRTfnJWA==
X-Received: by 2002:ac2:545b:: with SMTP id d27mr22202688lfn.320.1624938448507;
        Mon, 28 Jun 2021 20:47:28 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id h5sm1338749lfk.164.2021.06.28.20.47.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 20:47:28 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id c11so29022477ljd.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 20:47:28 -0700 (PDT)
X-Received: by 2002:a2e:b553:: with SMTP id a19mr2124829ljn.507.1624938447840;
 Mon, 28 Jun 2021 20:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <87fsx1vcr9.fsf@disp2133>
In-Reply-To: <87fsx1vcr9.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 20:47:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1z-NKxedgZvSS37iH=EKE47PkL=+BYccAUtsuB1sySQ@mail.gmail.com>
Message-ID: <CAHk-=wj1z-NKxedgZvSS37iH=EKE47PkL=+BYccAUtsuB1sySQ@mail.gmail.com>
Subject: Re: [GIT PULL] ucounts: Count rlimits in each user namespace
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 3:35 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This is the work mainly by Alexey Gladkov to limit rlimits to the
> rlimits of the user that created a user namespace, and to allow users to
> have stricter limits on the resources created within a user namespace.

I guess all the performance issues got sorted, since I haven't seen
any reports from the test robots.

I do end up with two questions, mainly because of looking at the
result of the conflict resolution.

In particular, in __sigqueue_alloc(), two oddities..

Why the "sigpending < LONG_MAX" test in that

        if (override_rlimit || (sigpending < LONG_MAX && sigpending <=
task_rlimit(t, RLIMIT_SIGPENDING))) {

thing?

And why test for "ucounts" being non-NULL in

                if (ucounts && dec_rlimit_ucounts(ucounts,
UCOUNT_RLIMIT_SIGPENDING, 1))
                        put_ucounts(ucounts);

when afaik both of those should be happy with a NULL 'ucounts' pointer
(if it was NULL, we certainly already used it for the reverse
operations for get_ucounts() and inc_rlimit_ucounts()..)

Hmm?

And somebody should verify that I didn't screw anything up in my merge
resolution. It all looked very straightforward, but mistakes happen..

                   Linus
