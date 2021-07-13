Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC503C7576
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhGMRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:07:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE37C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:04:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so2127564wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=WtaRzyTpTimrVz2KE8pTuBIbaAxYfPRns1eIEThieiY=;
        b=q/jjEmLvMDCdV9t3Z6vym7pfht6YI1u2Zt8Un4w/hwRJjLI1aECY0zsynIFu7Aj0mS
         6JxopUn0PCdmtubFf85Ud2P4xNSNzOjUNKccVNfzQMP67K60F3EY0Nh+OSv7VgxKyMSQ
         88wCwlamWGo/p9fq3OGiveFehu7IEvvU5E9bINomtRq519otp1uX8F6oTZKLExIY3vMM
         TTJL1f6LY0IrVGEUsvdQhMHtPO+X2amlktkkhG3LV/72pADbjVtzbbI0ysDizZq9I8W9
         uJKrFcZJ8f68jbvREbheOsfQiIBfm3z2710NPEoEut/QeroVrGoMT5ClSklIjZx+/muM
         MwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WtaRzyTpTimrVz2KE8pTuBIbaAxYfPRns1eIEThieiY=;
        b=AHT1RXECMMDQ2ZvGxIp9xEhvvR8EnvB5YfU2Igj+OxENoumbuNhB6Dht8inj901J4Q
         ruQfOlX03G4D5JliWoklthWTBeC0dtf0rXdJMPyFgX4uJccXGyyAvHFW+F2zIZ9KPmcF
         JuQiASxSRlrZxOopvO+0GwCgLiIZTnMyGyIpo997TvAIAIIB1OaxedU/Hw9tCvO57X9X
         ff5BtJ3fZVD8OU9kpGZKAfU/oEmDEw7GvRg6t5sWTQYUhw5ILZMn+h2IF6sn1q+jqI7U
         XyZ25TPFQ50j4PjRiy/5yBPtlDjHh6BjdyOEKJuZp35jOXZdD1XQw5WlCdiM/5s5LQ4j
         y8mw==
X-Gm-Message-State: AOAM533Lw2lezsfTM0GzctTKIiLoZgtzZmwEzQ07gKZh/kVvEBITCB9D
        /pZLYP5Dv688uw8pYSTp6lahbOIA97/GzOMTVVrNcnejZ8mWoT9qOEs=
X-Google-Smtp-Source: ABdhPJzYhkf3/ua3NC6zK6sJ9KEd3wb4a5lMZp3VIzMg9KxiVpaj08/bCMOOJxzXfmlF55zcLDKwaKPEKxld4VzDo+c=
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr6216689wmi.11.1626195897771;
 Tue, 13 Jul 2021 10:04:57 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 13 Jul 2021 11:04:41 -0600
Message-ID: <CAJCQCtSZCCPLZpVX_bQ4Nnqhw1d2sgx_MeK9ZkW8iHqnZTdc5Q@mail.gmail.com>
Subject: 5.14-rc1: BUG: workqueue lockup
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[    0.000000] kernel: Linux version 5.14.0-0.rc1.16.fc35.x86_64+debug
(mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.1.1
20210623 (Red Hat 11.1.1-6), GNU ld version 2.36.1-15.fc35) #1 SMP Mon
Jul 12 14:29:14 UTC 2021

Lenovo Thinkpad X1

Sequence of events: boot seems normal, I never went looking for or
noticed the early splats and lockdep warnings related to bluetooth,
worked for a couple hours, put the laptop in s2idle, resumed work, and
then in Terminal ran 'stress-ng -c8' and immediately the whole system
became unresponsive. Not even the mouse arrow would move. And it
wasn't possible to ssh into the laptop. During the 10 minutes, some
desktop UI did change so the graphical environment was still working
but substantially delayed compared to the inputs.

I've been seeing workqueue lockups in Fedora openQA testing with VM's
that do not have bluetooth. Therefore I think the usb and bluetooth
related splat and lockdep warning early on have nothing to do with the
later workqueue lockup.

dmesg (2 week expiration)
https://pastebin.com/zgkLiSkp

This excerpt is from the full log, just as a marker for when stress-ng
was started:
[ 6448.192901] stress-ng[6238]: invoked with 'stress-n' by user 1000

These are the first kernel message to appear following loss of control
(responsiveness):

[ 6485.133492] kernel: perf: interrupt took too long (2540 > 2500),
lowering kernel.perf_event_max_sample_rate to 78000
[ 6503.012190] kernel: BUG: workqueue lockup - pool cpus=0 node=0
flags=0x0 nice=0 stuck for 54s!
[ 6503.012206] kernel: BUG: workqueue lockup - pool cpus=1 node=0
flags=0x0 nice=0 stuck for 53s!
[ 6503.012213] kernel: BUG: workqueue lockup - pool cpus=2 node=0
flags=0x0 nice=0 stuck for 36s!
[ 6503.012219] kernel: BUG: workqueue lockup - pool cpus=3 node=0
flags=0x0 nice=0 stuck for 53s!
[ 6503.012226] kernel: BUG: workqueue lockup - pool cpus=5 node=0
flags=0x0 nice=0 stuck for 38s!

So roughly 53 seconds before the first BUG is reported by the kernel,
but loss of control happened from the time stress-ng was run.

Kernel config:
https://pastebin.com/QzvEy1sQ

-- 
Chris Murphy
