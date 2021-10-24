Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44A8438C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 00:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJXWqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 18:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhJXWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 18:46:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C1C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:44:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c28so4046830lfv.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51ktLrJvct0ot1+JgSOephKK4b8DM/OzJiyeTI83ARQ=;
        b=UenXvHNONXZSMSuuyNNb4R194pRYfRIhTqBBsQrRzUTEUetCCaiBoOHIccpGAxBLSI
         tr5U5Qb/AL5+zxd+T71wwjCidfpswk6MZUdH7hcePfh0gnJ3QDtjfeo4qZ1KKv0TZC0e
         dzR3FxMLvoEPiGxeBB3m6HOD2RRBqKB1i3XB+9G3dDcBNu2b3Iy0d14XnucSmt42FqUD
         /HfMhAf/e7DUMWVWTyWKzaUAvP3rs8WCh10iKQUygNr3/tV571jtPT99eFMhAPNOu0g0
         W68cozCn7TQHvsJqerBpRQ/sFKRoCSqtHEa/XaifvU4SEVVrxryPF9yG+51wmEV4d0Xd
         OCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51ktLrJvct0ot1+JgSOephKK4b8DM/OzJiyeTI83ARQ=;
        b=mnTBdXkIgqF0hA9XBecAjE0vsaf4qWTdgzahrXrCPu7qj6NN5VQIqt3dJ+Tkz0cEMi
         Dw4ThmE2GO+YO9hhzGnaha+W9CxeTJfPVbW5IRrHE1TQB+QOIKFVUpZ/ALLvtQUhsr/C
         UV6HeeK4v7FoOofx5sk7CxBWg3Kx8c9u9Ka9QLPmR2QtsjAE3Ol9euoHHCkux6Xlg2jO
         aqQ0Yx9qyOgyIIM/Bzhp5AAEv36nnXTMbyKAZ7yph2JDDihCa7C/62LDZTYmjHrgxN0L
         gxozE9gqe0yqmhMqaOiYzhdltCnmQmE9DsjBEJJWxvwPGRKRHA4HZElmOV1FKyPoJHtf
         M6gA==
X-Gm-Message-State: AOAM532vphvJ1ukay2chyumWKjwb+fi/dzI7QGJuqmLoMFR316mFjrkd
        ipYfHTqu5HDig+oHMz012POWwarp8HvMSpSefXCoBA==
X-Google-Smtp-Source: ABdhPJyqdgKU5NUoVy996qBcNZrXN43FVzKMrjq+DSYceoIwbTHqzzHyA3WMU3OJ565gUXZ41mYygscsYLZdzGYyr6Y=
X-Received: by 2002:a05:6512:3407:: with SMTP id i7mr13558069lfr.563.1635115453218;
 Sun, 24 Oct 2021 15:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sun, 24 Oct 2021 15:44:03 -0700
Message-ID: <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 6:03 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> Hello,

Hi,

>
> I have an Intel 6130 and an Intel 5218.  These machines have HWP.  They
> are configured to boot with active mode and performance as the power
> governor.  Since the following commit:
>
> commit a365ab6b9dfbaf8fb4fb4cd5d8a4c55dc4fb8b1c (HEAD, refs/bisect/bad)
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon Dec 14 21:09:26 2020 +0100
>
>     cpufreq: intel_pstate: Implement the ->adjust_perf() callback
>
> If I change te mode from active to passive, I have the impression that the
> machine is no longer able to raise the core frequencies above the minimum.
> Changing the mode back to active has no effect.  This persists if I reboot
> to another kernel.
>
> Here are some runs that illustrate the problem.  I have tested the
> benchmark many times, and apart from this issue its performance is stable.

Could you also list the CPU frequency scaling governor being used in your
tests. I know you mentioned the performance governor above, but it
changes between active/passive/active transitions.

Example from my test computer:

Note 1: It is only for brevity of this e-mail that I only list for one CPU.
Obviously, I looked at all CPUs when doing this.

Note 2: The test example and conditions have been cherry picked
for dramatic effect.

$ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_driver
intel_pstate
$ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
performance
$ cat /sys/devices/system/cpu/intel_pstate/status
active
$ ./ping-pong-many 100000 500 10
1418.0660 usecs/loop. (less is better)

$ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
passive
$ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_driver
intel_cpufreq
$ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
schedutil
$ cat /sys/devices/system/cpu/intel_pstate/status
passive
$ ./ping-pong-many 100000 500 10
5053.6355 usecs/loop.

$ echo active | sudo tee /sys/devices/system/cpu/intel_pstate/status
active
$ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_driver
intel_pstate
$ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
powersave
$ cat /sys/devices/system/cpu/intel_pstate/status
active
$ ./ping-pong-many 100000 500 10
2253.5833 usecs/loop.

... Doug

>
> Intel 6130:
>
> root@yeti-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
> ===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
> ===== DaCapo 9.12-MR1 avrora completed warmup 1 in 3420 msec =====
> ===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
> ===== DaCapo 9.12-MR1 avrora completed warmup 2 in 2536 msec =====
> ===== DaCapo 9.12-MR1 avrora starting =====
> ===== DaCapo 9.12-MR1 avrora PASSED in 2502 msec =====
> root@yeti-2:/tmp# echo passive | tee /sys/devices/system/cpu/intel_pstate/status
> passive
> root@yeti-2:/tmp#
> root@yeti-2:/tmp# echo active | tee /sys/devices/system/cpu/intel_pstate/status
> active
> root@yeti-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
> ===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
> ===== DaCapo 9.12-MR1 avrora completed warmup 1 in 7561 msec =====
> ===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
> ===== DaCapo 9.12-MR1 avrora completed warmup 2 in 6528 msec =====
> ===== DaCapo 9.12-MR1 avrora starting =====
> ===== DaCapo 9.12-MR1 avrora PASSED in 7796 msec =====
>
> -------------------------------------------------------------------------
>
> Intel 5218:
>
> root@troll-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
> ===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
> ===== DaCapo 9.12-MR1 avrora completed warmup 1 in 2265 msec =====
> ===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
> ===== DaCapo 9.12-MR1 avrora completed warmup 2 in 2033 msec =====
> ===== DaCapo 9.12-MR1 avrora starting =====
> ===== DaCapo 9.12-MR1 avrora PASSED in 2068 msec =====
> root@troll-2:/tmp# echo passive | tee /sys/devices/system/cpu/intel_pstate/status
> passive
> root@troll-2:/tmp# echo active | tee /sys/devices/system/cpu/intel_pstate/statusactive
> root@troll-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
> ===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
> ===== DaCapo 9.12-MR1 avrora completed warmup 1 in 4363 msec =====
> ===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
> ===== DaCapo 9.12-MR1 avrora completed warmup 2 in 4486 msec =====
> ===== DaCapo 9.12-MR1 avrora starting =====
> ===== DaCapo 9.12-MR1 avrora PASSED in 3417 msec =====
>
> -------------------------------------------------------------------------
>
> thanks,
> julia
