Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC33E7E04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhHJRJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhHJRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:09:21 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC39C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:08:59 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c130so14860455qkg.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pyGxHM3Db6wdEf4fFVUCvmJxKhUYcX8PsFY2j/RdRgc=;
        b=LUDerkzpVSYP8Fhzgbpn5Z9MnxmvtH2NiT8k1As1nYOjYQR6LgZmmThERO5hKeQfGT
         qefIqtgHmiGQQcEhnPoagNLA0sr+Mwm6G8MwR8dt4e98ngFr8i0DcL+GxogwuXkOP4Km
         g3+SSSIYr2QLmjoplBndnlVR9bq8rWnFLp98Jv0gSCK8wr2K2Xeq7EnNEW9t7Pv/9h35
         8Xdskh3JoJaIkFXjCpRCjOvn9YzetEA5NEmNzpMNYjMv9sPTBFu2kBT3rEQydq9qyHVY
         JO/JOnoX2fXDOH2b4o1/CXphlb4ewteInSs449dqfHO8wnMgnPdodq+yUAOeSKz73I7z
         EpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pyGxHM3Db6wdEf4fFVUCvmJxKhUYcX8PsFY2j/RdRgc=;
        b=OuGMvVXU22e+vJRPB4hJVEjXMtm7v6aXia10Bisp+Dx2LEDIrbDiWAos8dlalKG8xK
         a/WGv8gZD3noHf5x+wfGPTaO++CrknRoET7fyUn0vMy2ChEl56i+DYcqpfyqdV5W94fJ
         hkKe0CodETEM7bRc7IkFCggMaPCPaaE/Cj0BkaktqpXcvXt72e2n6LhAXaLYzx3J/8Wm
         OYXVIOqZyxJwMLGlkHLGLIANzRfp9tCcK0ay5YMFBFAEhe7R0EcTJw+KR11SFhRWFS4L
         p2qZxrPGwSqSNjXC5dVu4QWkX8J3/Q71tqW4gCjfAojMs8m+FkUDzshqqzOC25mTTqej
         PQZA==
X-Gm-Message-State: AOAM533GU5r+RcIuIx/ZvCUA49vmMMyS6o2MLF8I4pAsFYmD8afs/eMa
        SfUmMFpveQczSMhSQm36sg2odBdzk2akivntSFDX8g==
X-Google-Smtp-Source: ABdhPJwEaNvqG0ZV37t2Y1+i/pTJpr4zoV4YS+/xc/rPXZLKk7jlQTKTnwX/U9xCnjR23azTioSKJiSjazeCfYhP9vM=
X-Received: by 2002:a05:620a:1706:: with SMTP id az6mr21476733qkb.424.1628615338508;
 Tue, 10 Aug 2021 10:08:58 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Aug 2021 19:08:45 +0200
Message-ID: <CACT4Y+YvovgRNC5EFhN_d=jApwSAsWcNj35=FCJf1k867vBqfw@mail.gmail.com>
Subject: finding regressions with syzkaller
To:     regressions@lists.linux.dev,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        automated-testing@yoctoproject.org,
        Sasha Levin <sashalevin@google.com>,
        Marco Elver <elver@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Mara Mihali <mihalimara22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to give an overview of an idea and an early prototype we
developed as part of an intern project. This is not yet at the stage
of producing real results, but I just wanted to share the idea with
you and maybe get some feedback.

The idea is to generate random test programs (as syzkaller does) and
then execute them on 2 different kernels and compare results (so
called "differential fuzzing"). This has the potential of finding not
just various "crashes" but also logical bugs and regressions.

Initially we thought of comparing Linux with gVisor or FreeBSD on a
common subset of syscalls. But it turns out we can also compare
different versions of Linux (LTS vs upstream, or different LTS
versions, or LTS .1 with .y) to find any changes in
behavior/regressions. Ultimately such an approach could detect and
report a large spectrum of various small and large changes in various
subsystems automatically and potentially even bisect the commit that
introduces the difference.

In the initial version we only considered returned errno's (including
0/success) as "results" of execution of a program. But theoretically
it should be enough to sense lots of differences, e.g. if a file state
is different that it can be sensed with a subsequent read returning
different results.

The major issue is various false positive differences caused by
timings, non-determinism, accumulated state, intentional and
semi-intentional changes (e.g. subtle API extensions), etc. We learnt
how to deal with some of these to some degree, but feasibility is
still an open question.

So far we were able to find few real-ish differences, the most
interesting I think is this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d25e3a3de0d6fb2f660dbc7d643b2c632beb1743
which silently does s/EBADF/ENXIO/:

- f = fdget(p->wq_fd);
- if (!f.file)
-     return -EBADF;
+ f = fdget(p->wq_fd);
+ if (!f.file)
+     return -ENXIO;

I don't know how important this difference is, but I think it's
exciting and promising that the tool was able to sense this change.

The other difference we discovered is caused by this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=97ba62b278674293762c3d91f724f1bb922f04e0

Which adds attr->sigtrap:
+ if (attr->sigtrap && !attr->remove_on_exec)
+     return -EINVAL;

So the new kernel returns EINVAL for some input, while the old kernel
did not recornize this flag and returned E2BIG. This is an example of
a subtle API extension, which represent a problem for the tool (bolder
API changes like a new syscall, or a new /dev node are easier to
handle automatically).

If you are interested in more info, here are some links:
https://github.com/google/syzkaller/blob/master/docs/syz_verifier.md
https://github.com/google/syzkaller/issues/692
https://github.com/google/syzkaller/issues/200

Since this work is in very early stage, I only have very high-level questions:
 - what do you think about feasibility/usefulness of this idea in general?
 - any suggestions on how to make the tool find more differences/bugs
or how to make it more reliable?
 - is there a list or pointers to some known past regressions that
would be useful to find with such tool? (I've looked at the things
reported on the regressions@ list, but it's mostly crashes/not
booting, but that's what syzkaller can find already well)
 - anybody else we should CC?

Thanks
