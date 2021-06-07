Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5339E37A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhFGQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:26:18 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:38537 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbhFGQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:22:23 -0400
Received: by mail-io1-f52.google.com with SMTP id b25so18912953iot.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=VJQtUziQQOmirURcTe7echHKsqVLuwIGsSiIYyW3kwA=;
        b=PKRlzUUtjkfar2pm9yhdQpJhbwQKFsgD1IOvv4aJik49t9UTvCgkLl+zJTs1I6QMhv
         S/C6B64HEax+sY9q/pv2OFAD5SdH8UiEL6r5N7jROeqIRRzBTS0V7VXEAydZHeiGuyGh
         uFLJe3zhCRf0bB/S/6IK3YM9EBMO9PfbBS84c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VJQtUziQQOmirURcTe7echHKsqVLuwIGsSiIYyW3kwA=;
        b=mc85nHUJS1xVDbqtCsZub1BsRpWU3mNfgeHvrdK4EIKWLfNT7rsNDPLQ3jEGOIdouV
         tIZrw2M0VjDS5zQYxnoWa6JydW9/tkjAcs2IWLYMUBW8QMJHZjFNE6t4bXE4y3sT5BoR
         FNNPf/SnmEJQYJtPVP0eQzy3pnpYyCGbUEk4RyDWFraaJttCENzDL+MsWSubEn6CEte3
         Lm+hKbzniQeqBj+uKyEOX6tyA2q15jt/irhyxwSbEKYq8fMMtNqOgIOK5TNw4om0SVEZ
         Riz3LvmIIX1MoKWLnXQ5Ym6ZAVmepZOzvsWjHU45cTMhb+wE7Gy14HuZjNduSW/A6V23
         /VRw==
X-Gm-Message-State: AOAM533n2qFKXk/1ync3wNDWvMamliHb1L/HVoYX3GANp5y2eFBAqDtH
        szYR1Y/Sg6DBlcR6UedhKZTgtV9X79NW656Gkj+xiw==
X-Google-Smtp-Source: ABdhPJyL+rkd0abCmJ4+7UipXZRX+AUq9ft0/5i1qGgM5E0dOUTH1Gb+92xF0TSM888MrUSM4h6JH9yaGk5l5A/RmPI=
X-Received: by 2002:a05:6638:5ad:: with SMTP id b13mr17403785jar.42.1623082751898;
 Mon, 07 Jun 2021 09:19:11 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 7 Jun 2021 12:19:01 -0400
Message-ID: <CAEXW_YTcO=hbmdq3nOx2RJfT2yPyoFnQx5niB38R2Lzpsp38bA@mail.gmail.com>
Subject: iowait boost is broken
To:     Beata Michalska <beata.michalska@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Looks like iowait boost is completely broken upstream. Just
documenting my findings of iowait boost issues:

1. If a CPU requests iowait boost in a cluster, another CPU can go
ahead and reset very quickly it since it thinks there's no new request
for the iowait boosting CPU
2. If the iowait is longer than a tick, then successive iowait boost
doubling does not happen. So heavy I/O waiting code never gets a
boost.
3. update_load_avg() is triggered right after the the iowait boost
request which makes another cpufreq update request, this request is a
non-iowait boost one so it ends up resetting the iowait boost request
(in the same path!).
4. Same as #3 but due the update_blocked_averages from new idle balance path.

Here is a patch that tries to address these problems and I see better
cpufreq boosting happening, however it is just a test broken patch to
highlight the issues:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=sched/5.4/iowait-boost-debug-1&id=3627d896d499d168fef9a388e5d6b3359acc3423

I think we ought to rewrite the whole mess instead of fixing it since
a lot has changed in scheduler code over time it feels. Beata is
working on rewriting the whole iowait boost infra, I am glad she has
started the work on this and looking forward to helping with the
patches.

thanks,
 - Joel
