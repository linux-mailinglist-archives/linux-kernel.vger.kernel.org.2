Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD2399F65
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFCLCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:02:31 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:33466 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:02:30 -0400
Received: by mail-lj1-f178.google.com with SMTP id o8so6634302ljp.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rUlx8O6TNfr8FAo3Ko7jcA+NjSFtbi9cuGQWJwaMeI=;
        b=bk7dW26FtQC+sjFuv3+rhLKc4yVisrxWKzPFfEqdbdZU6I2VjBocKV/I01NVgdsQdo
         VisV4Fc7KJy8g7GuH3c8lHXMXZUp7PoSqbJ8AgqKpg6YsYEEGvQnCc1SwDg/7DK5yU+d
         B6/kZOb0SPVK7Ab9KsOvVVY2WKodszQzpiNvnr9v5484bQ6ntTYKxjKiBK2QpNnYmyOG
         f4WLydV6Pv/PDA8ETfz5gZVx/FXmakvuSWoRz/oOyS6OSZfu4FTDv4O7zDTYWSPfBeQf
         9FoTwueSHKnjSN5jppDQJN2/itUJm9uMYUOgTkasy5Q+nes7nUXDjr9lzmE//HlYQq5P
         UzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rUlx8O6TNfr8FAo3Ko7jcA+NjSFtbi9cuGQWJwaMeI=;
        b=GdR6q2wtqX7b28AvDWb1upfX5FqDiQ/CoBvG6xlmw0BKZ6ojHrz0I1wiPMsaB9eWK9
         66OGStqgrEMqFWlLbQfmvpYROFmqJqB6+MNTZhVXWWF9gHRN0CHHNvTGCW+e3grCDuV/
         LCBqNTBzUX8zu+jq+PUxxEtcPh2/cdAlsrRNSehzxe3TsUd7oqd9sbl+9dRrh7y9vTSb
         W82h1gJHfXQd9I5IiYJsG5uPcvyKXzebY7FRLYiYJ0zX2L7ikCQnBfnO/PSgpyZYXM6B
         Obkaj4wzxV3tVPk/mrBLUPp2neWi6dLnX2VmN0Q2C6oj0XsbVM3z6TtRwGTDlTiqSJnA
         VPJA==
X-Gm-Message-State: AOAM532F8vJ5SjVJtI/Oqv5S1yGIWIqn7RU/VbYsULwdoZXPPpW/FB0b
        p5i+wCEeM35rMt/WTk4i5GHFO7m0Bm2AgRDnZ53l1g==
X-Google-Smtp-Source: ABdhPJzzTSrwt9KuJqNENKblCJ655SIPCV6SW4v0MpBY63K3GyuQRp77wXqdZUTTwUtM1L9r0lb+8zB12pj2CZO41+k=
X-Received: by 2002:a2e:760c:: with SMTP id r12mr27765140ljc.299.1622717985236;
 Thu, 03 Jun 2021 03:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210602064526.GB9872@xsang-OptiPlex-9020> <56316b95-3ec5-74e6-a4f7-d91aea022abe@arm.com>
In-Reply-To: <56316b95-3ec5-74e6-a4f7-d91aea022abe@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Jun 2021 12:59:33 +0200
Message-ID: <CAKfTPtBKORaNBTZHDXhxyByB8NLwUPTRCy6TQw5VusPeJ2n1AQ@mail.gmail.com>
Subject: Re: [sched/pelt] e906550aca: WARNING:at_kernel/sched/fair.c:#update_blocked_averages
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Thu, 3 Jun 2021 at 12:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 02/06/2021 08:45, kernel test robot wrote:
>
> [...]
>
> > kern :warn : [   40.989618] WARNING: CPU: 2 PID: 253 at kernel/sched/fair.c:8029 update_blocked_averages (kbuild/src/consumer/kernel/sched/fair.c:8029 kbuild/src/consumer/kernel/sched/fair.c:8065 kbuild/src/consumer/kernel/sched/fair.c:8152)
>
> Hit something like this on my Ubuntu i7-7567U as well.

Thanks for having a look at this.

>
> With more debugging:
>
> [    7.388006] WARNING: CPU: 1 PID: 926 at kernel/sched/fair.c:8029 update_blocked_averages+0x30d/0x7e0
> ...
> [    7.388167] path=/autogroup-2 load_avg=1 util_avg=0 runnable_avg=1
>
> IMHO, this is because this patch needs:
>
> (1) sched/pelt: ensure that *_sum is always synced with *_avg (2021-06-03 Vincent Guittot)
>
> https://lkml.kernel.org/r/20210601085832.12626-1-vincent.guittot@linaro.org
>
> (2) sched/fair: Keep load_avg and load_sum synced (2021-06-03 Vincent Guittot)
>
> tip/sched/urgent 7c7ad626d9a0
>
> Using both patches underneath makes this warning go away.

I haven't spent time on this but that's also my 1st guess for the root cause

Regards,
Vincent

>
