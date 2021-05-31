Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E7395765
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhEaIwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhEaIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:52:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66017C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:50:31 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id h20so10554133qko.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x32hKsSaoJx8LJdG4ppTOfzr/Vq7FJJQzpMa1jFi8JE=;
        b=BbcftNrl3xfTMBpG3BVoT8S6UO7/P6wgQnca69NnKDi+0J5VDbQAGToas1XH0+6oKo
         9LBlNOsoLO8vWCYu8094HsvbN+h4trXaJs7x6YMQc4LzDgedp+EDjmwZprVho4Xnotu3
         vpNJXaRAv6XGv4Qqupiz19UUOYVxKpIgzoGha1JaGAWT4/ZBURRWOFBAs3KUgbEC1LX9
         0RsPMatFOwAQ3b2vfS3qED2LlRwObfy5c3IWwnhOv/n9EFAlLLoiwvnGOHbkfjHr53GN
         mjSk7IS0I8efW3iV+6zZWP4UuOnukPIdxrTixTea7m2ehntNsqCX/8h9NSN8jnZUqUam
         Tzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x32hKsSaoJx8LJdG4ppTOfzr/Vq7FJJQzpMa1jFi8JE=;
        b=jx74DDeBU61HQONJ3RDXjdgyjzbwr+Py6+c7+YHOW6nN5bX3X+9fbsuzDWHSpAD5TU
         UDNcHRZd7nbOn77V40i6JtEnOLGlaZW+Fql87yPIgdzNNH+7RnsIz9sivjqWQwY3HlhE
         dO5/CxWBc4eSaqbiViPwf7EwVP1bFSkC4phjTjW+Lmr7OYSDiz6588jDlHRu8/VuzXdi
         3eJHuwQu9uFHJjSPW96vuT5SzZdqAYepMvoTFgsac6twLddrHF1WvhOngzfpW3Omi+T5
         S2W+E/Q5WDnXPYZT1qX/+Ll4APq6Mxw1Ei3ZsiWNBCvUMzcF9KQdw0prCBKMqBn4VdHE
         A2Nw==
X-Gm-Message-State: AOAM533PVjz1KVxqEo0wT8/V20RFZcN32kRVGpZA+73feSpd4KX1/Sni
        zwrS22VKHuMZ3BuxKMCtJvtQU+/yAQI543prNlGMlA==
X-Google-Smtp-Source: ABdhPJx2ZlewDsJ7aT2KkCRf5QVLASI81jS72AgkJDKnBiZXBNWfy0nYpAaHVhowMP1T2cfZ/to5HWCuBZs60hcq5Kk=
X-Received: by 2002:a37:4694:: with SMTP id t142mr15650398qka.265.1622451030253;
 Mon, 31 May 2021 01:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b808c705c345b35d@google.com> <0000000000009dfd7c05c3463b32@google.com>
 <CACT4Y+ZkGw8GDs9vYzs5t7iBba+5ZRKmTnp3zXAnkOsmyWp6Rw@mail.gmail.com>
 <9B8B972A-EC9F-4806-9897-41581578646A@gmail.com> <ea23ca6b-0893-1303-524c-a7e07d909931@i-love.sakura.ne.jp>
In-Reply-To: <ea23ca6b-0893-1303-524c-a7e07d909931@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 31 May 2021 10:50:18 +0200
Message-ID: <CACT4Y+bnaR9WfAWEE=fmAgLD088sxPbJqsjnX8RDF3jzGRpPYA@mail.gmail.com>
Subject: Re: [syzbot] unexpected kernel reboot (5)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "joey.jiaojg" <joey.jiaojg@gmail.com>,
        syzbot <syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 3:17 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/05/27 21:15, joey.jiaojg wrote:
> > I tested on qemu and Android device, not found the reboot.
> > Any kernel version different?
>
> Kernel version needs to be v5.11-rc5+ because this reproducer
> depends on commit f2d6c2708bd8 ("kernfs: wire up ->splice_read
> and ->splice_write"). Also, this reproducer depends on contents
> of /sys/power/state file.
>
> ----------
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/sendfile.h>
>
> int main(int argc, char *argv[])
> {
>         const int fd = open("/sys/power/state", O_RDWR);
>         off_t offset = 7;
>
>         /* Assumes that 3 bytes from offset 7 in /sys/power/state are "mem". */
>         sendfile(fd, fd, &offset, 3);
>         return 0;
> }
> ----------
>
> On 2021/05/27 21:19, joey.jiaojg wrote:
> > Or we can add glob code like
> > /sys/**/*:-/sys/power/state to exclude.
>
> Well, since /sys/ includes mount points for other filesystems such as
> securityfs ( /sys/kernel/security/ ), debugfs ( /sys/kernel/debug/ )
> and cgroup ( /sys/fs/cgroup/ ), just excluding this specific file is not
> sufficient. I think we have to start from removing glob["/sys/**/*"] .

FTR, Joey is working on support for excluding specific patterns from globs:
https://github.com/google/syzkaller/pull/2602

I agree /sys/**/* may be too broad. On my machine /sys contains 82501
files. But it's also hard for me to tell what exactly should be
included/excluded. Do we know any definitely bad files/dirs?
Or alternatively, we can just wait for more reports from syzbot when
it opens something we don't want it to open. The benefit of working on
testing :)
