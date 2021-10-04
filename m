Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54288421402
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhJDQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhJDQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:25:55 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA1C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:24:06 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id t15so16418166ilj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wa+qR4DQQgdeGGR2x5iYgoTdNdOLpXJkhIGIP1HQ+Mk=;
        b=PTOF6K/+kxAPv1FyYZNAr81E5vKVvYvTOygcSTfsLCR9Lw2itZoIsYjx9oW2EmpCJH
         5VbJJVZuFjKRHaQM9wt4B/rqHMVkwnStR4OmheKRWRuCONHcAfIjLpPvnsBHDbmCzp7F
         szqQ7X6Ny7wA9SRJrdXHtwgwisetwY061j/mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wa+qR4DQQgdeGGR2x5iYgoTdNdOLpXJkhIGIP1HQ+Mk=;
        b=jW4lowE+CkXdgYm4PaUnbxlMExUXn1FPJk1/WsytQ2wz8lLT+e9DaeAo839CimzaI3
         85umnLIB5gXTbgwswXoPkI6PXAm0wspHJfcM03bKysdEuHB3LnExdZNp9GciHhc5661S
         yKfOX/QHR9QmqbUFfojru0DjvBHRdFb4DVnX621zPVMAMEJV30uPChVwOW14h+G4Zmej
         sjwzeJIlEVXpJCCQ4WOnAgra5iBA1gmYQIzUc28IgIhgFFEKkFSmhvpXs+yzn8j/pdrJ
         bJamUETRc4KY4XDUUTJNpD3m7O6ejsTVzBkOm4gBDGWoYe9wcFKzG+5IkjsMM0illR2M
         1DAg==
X-Gm-Message-State: AOAM530kdMbKOcJ1YXPLDS9hddNf/Q+VuO7slWDp10nTtVcOj6THb3uL
        sfOa1AIXuW1tGZAmFqKvI8w+lA2EbppbFA==
X-Google-Smtp-Source: ABdhPJzR/rSeh/cfZJ9mTVGKP2GEV8A8bgkG1DSeCWs96vGLt9NNNJjUebUpXZO732WjHoyZ+ZtSlw==
X-Received: by 2002:a05:6e02:1bce:: with SMTP id x14mr2309582ilv.168.1633364645020;
        Mon, 04 Oct 2021 09:24:05 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id f7sm9413749ilc.82.2021.10.04.09.24.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 09:24:04 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id e144so20966606iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:24:04 -0700 (PDT)
X-Received: by 2002:a6b:7415:: with SMTP id s21mr10151731iog.168.1633364644186;
 Mon, 04 Oct 2021 09:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211003142210.GD30759@xsang-OptiPlex-9020>
In-Reply-To: <20211003142210.GD30759@xsang-OptiPlex-9020>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 Oct 2021 09:23:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5qpV4Wb3EUB+9d4xtvx_rbhP=V5++8-6i1d6FZSa2PQ@mail.gmail.com>
Message-ID: <CAD=FV=W5qpV4Wb3EUB+9d4xtvx_rbhP=V5++8-6i1d6FZSa2PQ@mail.gmail.com>
Subject: Re: [drm/edid] bac9c29482: Oops:#[##]
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 3, 2021 at 7:02 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: bac9c29482248b00cccfdfef1f34175714d33370 ("drm/edid: Break out reading block 0 of the EDID")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
>
> in testcase: fio-basic
> version: fio-x86_64-3.15-1_20210828
> with following parameters:
>
>         runtime: 300s
>         disk: 1HDD
>         fs: btrfs
>         nr_task: 100%
>         test_size: 128G
>         rw: write
>         bs: 4k
>         ioengine: filecreate
>         cpufreq_governor: performance
>         ucode: 0x42e
>
> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
> test-url: https://github.com/axboe/fio
>
>
> on test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> 39mKernel Config[   14.138938][  T304] ata6: SATA max UDMA/133 abar m2048@0xd0b00000 port 0xd0b00380 irq 61
> [[   14.198770][  T635] ipmi_si dmi-ipmi-si.0: IPMI kcs interface initialized
> [   14.332374][    T5] #PF: supervisor read access in kernel mode
> [   14.338904][    T5] #PF: error_code(0x0000) - not-present page
> [   14.345414][    T5] PGD 0 P4D 0
> [   14.349018][    T5] Oops: 0000 [#1] SMP PTI
> r to synchronize[   14.353687][    T5] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.15.0-rc1-00114-gbac9c2948224 #1
> [   14.365136][    T5] Hardware name: Intel Corporation S2600WP/S2600WP, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
>  boot up for ifu[   14.377368][    T5] Workqueue: events work_for_cpu_fn
> [   14.384541][    T5] RIP: 0010:connector_bad_edid+0x12/0x180 [drm]
> [   14.391370][    T5] Code: 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 0f 1f 44 00 00 41 54 55 89 d5 53 48 89 f3 48 83 ec 20 <0f> b6 56 7e 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 c1 e2
> [   14.414456][    T5] RSP: 0018:ffffc90000093b58 EFLAGS: 00010282
> [   14.421077][    T5] RAX: ffff888172c5df01 RBX: ffffffffffffffea RCX: 00000000000003f9
> [   14.429823][    T5] RDX: 0000000000000001 RSI: ffffffffffffffea RDI: ffff8881e02b6668
> [   14.438567][    T5] RBP: 0000000000000001 R08: 00000a77fb35e0ea R09: 0000000000000000
> [   14.447321][    T5] R10: 00000000000000e9 R11: 00000000000191e4 R12: ffffffffc03b5d80
> [   14.456060][    T5] R13: ffff8881e02bf800 R14: 0000000000000000 R15: ffffffffffffffea
>          Startin[   14.464807][    T5] FS:  0000000000000000(0000) GS:ffff888f03600000(0000) knlGS:0000000000000000
> [   14.476158][    T5] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  Journal to Pers[   14.476160][    T5] CR2: 0000000000000068 CR3: 00000002adcbe002 CR4: 00000000001706f0
> [   14.476167][    T5]  ? drm_hdmi_avi_infoframe_bars+0x40/0x40 [drm]
> 0m...
> [   14.476180][    T5]  ? drm_hdmi_avi_infoframe_bars+0x40/0x40 [drm]
> [   14.476190][    T5]  drm_do_get_edid+0xf4/0x300 [drm]
> [   14.491802][  T738] ata6: SATA link down (SStatus 0 SControl 300)

I will assume that this is the same problem reported by Geert [1].
I've posted a fix [2].

[1] https://lore.kernel.org/r/CAMuHMdWy+aASNevg8nc9LTvR9QNrGYZQnB3sYYLDRfEU1w_idg@mail.gmail.com
[2] https://lore.kernel.org/r/20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid/
