Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BB3FBD58
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhH3UQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhH3UQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:16:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D26C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:15:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j12so27921183ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdkLBxeprc22pYzDrCGRhm5Mln6o/u5YuB0oLAShsfU=;
        b=SvQjZPnrKDQjoOS7De5eX7kZmrBx8eC1vg6xlCXuICo8J1kvbzxn9dHJ8HcjngZPv4
         gOe/9w6uT+FaAzMIiF3Oz/9mr9TlVU1tB1bUF9h/MPSHovgRZzP1BImuFmVtuvtc+2A6
         yzZ1Obpw0jtxLiElMSWmEulWzxyPRVL66CIO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdkLBxeprc22pYzDrCGRhm5Mln6o/u5YuB0oLAShsfU=;
        b=bBysxpCJG9CxjcaZHVRVvLk4DD4IiZxCIaJk86VRBMUtrBrsKHcecE84HNWbdmHIEd
         J3lMxx1o1fRso2G/gBqt+S2odJlLmhLl0sFU+hUikroR0KQzie2Gy/TDIkVyIGOugZfZ
         4BHiC2y9PT6GAQE7WYSmUhloyFyiphg4b/x3jlmAmUyIDB8s+Rti0FxS+OIB5cos/TZl
         QFYznLoqfPdQ0ciflaPV7ENiZOiS4vtfK7vNUbqq2pQEhb/DUvIuOu5/SZ96Um5urVqy
         +maIiYh9oZGehnfBA2Cuu9xejuM6xEONRGaQKUyPyGzBMEYxxsWng324eLuPEa5No3v2
         aEmw==
X-Gm-Message-State: AOAM5338opLyp3LU37uLsa5M+b9rY5cIAdxYpDRayIpQ4HW5u4m8d/q7
        P6Yqn26ePITiyhtSAubR4nistxQCsxgDf6h7oU0=
X-Google-Smtp-Source: ABdhPJxfE6vJz8stIlXYZWAzUumcVl2wIq3NbzEFIOvU655AVmaokw1E53jN6SfkMnpgW7oOwxZ5kA==
X-Received: by 2002:a2e:22c6:: with SMTP id i189mr21595378lji.144.1630354553932;
        Mon, 30 Aug 2021 13:15:53 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k20sm761422lfm.93.2021.08.30.13.15.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 13:15:53 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id m18so19517925lfl.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:15:53 -0700 (PDT)
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr6228220lfu.253.1630354553028;
 Mon, 30 Aug 2021 13:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <20210830201225.GA2671970@roeck-us.net>
In-Reply-To: <20210830201225.GA2671970@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 13:15:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2-1PyGj94cb+jYWb4vCcJ3JG6s6Li7c12dPOhdTs1RA@mail.gmail.com>
Message-ID: <CAHk-=wi2-1PyGj94cb+jYWb4vCcJ3JG6s6Li7c12dPOhdTs1RA@mail.gmail.com>
Subject: Re: Linux 5.14
To:     Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 1:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> So far so good, but there is a brand new runtime warning, seen when booting
> s390 images.
>
> [    3.218816] ------------[ cut here ]------------
> [    3.219010] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:5779 sched_core_cpu_starting+0x172/0x180
> [    3.222845] Call Trace:
> [    3.222992]  [<0000000000186e86>] sched_core_cpu_starting+0x176/0x180
> [    3.223114] ([<0000000000186dc4>] sched_core_cpu_starting+0xb4/0x180)
> [    3.223182]  [<00000000001963e4>] sched_cpu_starting+0x2c/0x68
> [    3.223243]  [<000000000014f288>] cpuhp_invoke_callback+0x318/0x970
> [    3.223304]  [<000000000014f970>] cpuhp_invoke_callback_range+0x90/0x108
> [    3.223364]  [<000000000015123c>] notify_cpu_starting+0x84/0xa8
> [    3.223426]  [<0000000000117bca>] smp_init_secondary+0x72/0xf0
> [    3.223492]  [<0000000000117846>] smp_start_secondary+0x86/0x90
>
> Commit 3c474b3239f12 ("sched: Fix Core-wide rq->lock for uninitialized
> CPUs") seems to be the culprit. Indeed, the warning is gone after reverting
> this commit.

Ouch, not great timing.

Adding the s390 people to the cc too, just to make sure everybody
involved is aware.

           Linus
