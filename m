Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD836851E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhDVQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhDVQoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:44:46 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA67C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:44:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a5so15637965ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9ZCA1jpSijMrLEuBfryYeCSXFosZIBDTpSAgfFxECU=;
        b=Enp+Rf14e067EBgnKIXnKbunUmlpWq+PCFBxeF3S3f0flWUSIGJc9W8hw3nJKJe1MO
         tvXYZULzrizz+YKrHAQC7vEE5v4mLqxoKkTDaK39CGK4NUuSH4oAiG5Jxrkrp3YgCMSI
         +cmZmFOco8sLou5PwI+leHlmmmcjr/Vwhak+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9ZCA1jpSijMrLEuBfryYeCSXFosZIBDTpSAgfFxECU=;
        b=U6ZO7Ndszul6kjkPG9SHKjeAel8gPWLfaulG8qdqN5cPLa7izKEsodk1XpJl5N3PTF
         jRXixSat89iJo8CyFtKN5ICDFj0EpX/UQlvLpwoZ01c2W/d/miGUiYzhhmdPRfmVbjIW
         zU6XCKaeQhx+Xs7h7u/9YauekHjjWcEDJsIRdb7d61I7K8E7rIBg6KBJ+xpL2tqBKNYi
         RP8cvc4FwQ8h4ZeHQlm5DrC3ZHIZNuTyeFVz9x0/5Kpoqm8F10bItYIy1qcvY0s1qLkL
         hQuCt3hjXuDlRx3oZIrfdUjCT9xUVaxTqEaFPUfapjxbCXd3ed1yV4GTFay4Jv5LS+Tk
         fsHw==
X-Gm-Message-State: AOAM533NO6aR/uvvh5mTaHldfho4mq4MPDsae/XDKIAoIK3E1+2LZC28
        JQ3AAx3orPbr/C8kHTRau8l9+h58Ne9cDX+AkBTiyA==
X-Google-Smtp-Source: ABdhPJxbK2ud3a4uQ6KVnVYtRzkcf1ADVfuQeoNO6IZU9URAhYI1rtxuioHUbKmGsLf8z1qqpI9lHOuCaXgMir3VZIg=
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr3065124ljk.442.1619109850312;
 Thu, 22 Apr 2021 09:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org>
In-Reply-To: <20210422120459.447350175@infradead.org>
From:   Don Hiatt <dhiatt@digitalocean.com>
Date:   Thu, 22 Apr 2021 09:43:59 -0700
Message-ID: <CAOY2WoyMyqjGSWf1JD7tmsBHwKgjpxL7FB3sYjFSge8fBMZv6g@mail.gmail.com>
Subject: Re: [PATCH 00/19] sched: Core Scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 5:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hai,
>
> This is an agressive fold of all the core-scheduling work so far. I've stripped
> a whole bunch of tags along the way (hopefully not too many, please yell if you
> feel I made a mistake), including tested-by. Please retest.
>
> Changes since the last partial post is dropping all the cgroup stuff and
> PR_SCHED_CORE_CLEAR as well as that exec() behaviour in order to later resolve
> the cgroup issue.
>
Hi Peter,

Is there a reason that PR_SCHED_CORE_CLEAR got removed? It's handy to
be able to clear
cookies.

Thanks,

Don

> Since we're really rather late for the coming merge window, my plan was to
> merge the lot right after the merge window.
>
> Again, please test.
>
> These patches should shortly be available in my queue.git.
>
> ---
>  b/kernel/sched/core_sched.c                     |  229 ++++++
>  b/tools/testing/selftests/sched/.gitignore      |    1
>  b/tools/testing/selftests/sched/Makefile        |   14
>  b/tools/testing/selftests/sched/config          |    1
>  b/tools/testing/selftests/sched/cs_prctl_test.c |  338 +++++++++
>  include/linux/sched.h                           |   19
>  include/uapi/linux/prctl.h                      |    8
>  kernel/Kconfig.preempt                          |    6
>  kernel/fork.c                                   |    4
>  kernel/sched/Makefile                           |    1
>  kernel/sched/core.c                             |  858 ++++++++++++++++++++++--
>  kernel/sched/cpuacct.c                          |   12
>  kernel/sched/deadline.c                         |   38 -
>  kernel/sched/debug.c                            |    4
>  kernel/sched/fair.c                             |  276 +++++--
>  kernel/sched/idle.c                             |   13
>  kernel/sched/pelt.h                             |    2
>  kernel/sched/rt.c                               |   31
>  kernel/sched/sched.h                            |  393 ++++++++--
>  kernel/sched/stop_task.c                        |   14
>  kernel/sched/topology.c                         |    4
>  kernel/sys.c                                    |    5
>  tools/include/uapi/linux/prctl.h                |    8
>  23 files changed, 2057 insertions(+), 222 deletions(-)
>
