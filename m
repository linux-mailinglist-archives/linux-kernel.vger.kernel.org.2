Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA141A082
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhI0Usl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbhI0Usk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:48:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973C3C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:47:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so81561632lfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUJgDhe5ql91zHdk110A3VUkzRnlPgwapOfKmmzrqKs=;
        b=eeGQw4kiAbCR1Oprjoi0VfH2FrJlL2p72C1vOpbGnCsrCq4iZrnIWnXcr5OGNGI+n8
         C2GxE1QLmvkR9FOl5PqSilizzI/qkIg96KcjBeG1shDn3lLybaBrjGZH8JcBoLYl1FBz
         qq8Ms/Y+7izGHu/72wWz0dCGoMZOusEyNC7wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUJgDhe5ql91zHdk110A3VUkzRnlPgwapOfKmmzrqKs=;
        b=VUmy9VPXMQm7PvdSDQdscvDxhZbKiQHWzMFpPICMc7c0Qpw/2GgWTGRYxuuNnGwX+f
         ruonIvexTgFBGG8ME+8W1M4jLKoX5e2X32ZjjJ7jFzHchshuHVDvRlrfJb16JtSW1D4e
         SSyYUzPZlwH37rrkhjP8Mj+1hVIuf24ePXCgix1ec5VQ+4Un38r6bpm13KbdtSuuBXGs
         xBv8MxdjqfnzCjcDVq0vP/xt61Gts5hN4UVcBsW9AlmD0E09pTN2XkXpFu3ZVPDmdWMe
         /JxnMO0SwGZLKin49HQ1UTHovGdRtjTO1MZ6SRTHkJrpmRJXgs+C5H6pPGIydZqIENWf
         4fhg==
X-Gm-Message-State: AOAM5339qqIw1n3kjhZ0EOpy1AagWKFuZFRGjY6pkFh/jJjb3Nrlz7yB
        jbCGzVhnRYqJMjzHF7arr814MbPBcpgumsPdqaU=
X-Google-Smtp-Source: ABdhPJzKKhEP+11sZYDDvivF9Br04htg2UUTVRg5qNS+pqCMUUHj2vPOuMtw/kR/vQM6UEsSE7rVig==
X-Received: by 2002:ac2:4e12:: with SMTP id e18mr1723259lfr.225.1632775619599;
        Mon, 27 Sep 2021 13:46:59 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id g13sm1699856lfj.245.2021.09.27.13.46.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:46:59 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id x27so83104086lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:46:58 -0700 (PDT)
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr1740857lfv.474.1632775618745;
 Mon, 27 Sep 2021 13:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
 <20210927110548.GA771805@roeck-us.net> <CAHk-=wiuGKOBvgje56X-EdOp4mnoz4C2nM1ML6DqRFfsptai3w@mail.gmail.com>
 <20210927200932.GA8510@alpha.franken.de>
In-Reply-To: <20210927200932.GA8510@alpha.franken.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Sep 2021 13:46:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdZgiLoHoQS+C2CP8x5PGn6b=GBkY6K9T3QhDoaeV9mg@mail.gmail.com>
Message-ID: <CAHk-=wgdZgiLoHoQS+C2CP8x5PGn6b=GBkY6K9T3QhDoaeV9mg@mail.gmail.com>
Subject: Re: Linux 5.15-rc3
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 1:35 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> if it was a fix in the mips tree I would have sent it already, but it's
> watchdog driver fix, which was meant to be picked up by Wim.

Oh, my bad. Regardless, it's fixed in my tree now, and all of
Guenter's build failures should be fixed.

Of course, other random configs and compilers are still an issue, but
it's nice to see that most (all?) architectures can at least do a
clean "allmodconfig" build for some random set of tools. I don't think
we've ever been there before.

           Linus
