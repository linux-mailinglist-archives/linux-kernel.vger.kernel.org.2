Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10535E46D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346943AbhDMQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:56:46 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:44591 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhDMQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:56:40 -0400
Received: by mail-lf1-f45.google.com with SMTP id e14so15688947lfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PLs2idnlCT+BrCssylkLjLCqQ64RiQvKHsO94aHXHoc=;
        b=pbaLDr1VC49hn80iw3eKa5iB3TYAaclZauvrXsDG3Q8GMv8J8yVIe9aeREoa34Nyc5
         Gs1Lv5w0rssBHa7NMILEaPWgEGA6Av+mD1gu2VbOfYvp5/p7JE4O0hzolrndBiaZpcJg
         EDFsxWC/AdbU1qm+4Fw63KdUdsaaAa9oWnM4igzjVX4XdwVf+n5pHmzvn6OLqWIXZ64F
         gIUlFy4pslTzi8ubTOrcg/K8GFkzcvDo2wRtVnYfOpB2PYr99oYjHgOvlzs/2swSTCZQ
         tgmUPmMYu6HU8nBLz6Ynb8Q1/ZIPgVEdRJJMczccrY602L9jcvIivgSVhXz6HgPeCLOV
         tz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PLs2idnlCT+BrCssylkLjLCqQ64RiQvKHsO94aHXHoc=;
        b=oohFaNmXd0tHYUUCKoZNe+LACUN6IXqTrJdS/6VlF3JoH9FMEFeftM0DqPKwD7YTom
         zfAqBJ2H05G9Zt874nl+MSRZ30UYpPvxOteFVzWvIeoXfOD09bCU69RB2T059HPCEjMy
         9uKGzBoJPREJBwEtWpxRWwzHvfAPJTyhyLVuaWK2WTth4yLmaZb4yOZIhb9ailci6VfY
         ea/QA0fywcjuFeiZ626LASqUX5di+YVouABmqsIen5VhMsep0dyif20OhqS4PumoMuyE
         ky62b8Ir/J1wdB3JoJw1zEchbs2rZlqPw1H6uJ4t7MTiN+MBiJJGE0zrQNgjnfuO0hIq
         DsCg==
X-Gm-Message-State: AOAM531YwaB4jzNvv2YD+47Z12w1xftDJgLoLvZdPM6gLvGtWkXi4UMH
        3yYqvJpw+veFoGrx0AvKZieffYoRpyTqO/TRheU=
X-Google-Smtp-Source: ABdhPJyNDuuRiClf58r4o7BJI3+jV+tEspkeNSW/eG/ZdUxT0qKGa2rodcCXz+KGEMXeu/rpZ6l9T9dxMMR2AW2JpRk=
X-Received: by 2002:a19:c218:: with SMTP id l24mr22775980lfc.524.1618332919909;
 Tue, 13 Apr 2021 09:55:19 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Tue, 13 Apr 2021 09:55:08 -0700
Message-ID: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
To:     Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mikael.beckius@windriver.com,
        tglx@linutronix.de, Lorenzo Colitti <lorenzo@google.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (or at least the version of it that showed up in 5.10.24
LTS when combined with Android Common Kernel and some arm phone
platform drivers) causes a roughly 60% regression (from ~5.3-6 gbps
down to ~2.2gbps) on running pktgen when egressing via ncm gadget on a
SuperSpeed+ 10gbps USB3 connection.

The regression is not there in 5.10.23, and is present in 5.10.24 and
5.10.26.  Reverting just this one patch is confirmed to restore
performance (both on 5.10.24 and 5.10.26).

We don't know the cause, as we know nothing about hrtimers... but we
lightly suspect that the ncm->task_timer in f_ncm.c is perhaps not
firing as often as it should...

Unfortunately I have no idea how to replicate this on commonly
available hardware (or with a pure stable or 5.11/5.12 Linus tree)
since it requires a gadget capable usb3.1 10gbps controller (which I
only have access to in combination with a 5.10-based arm+dwc3 soc).

(the regression is visible with just usb3.0, but it's smaller due to
usb3.0 topping out at just under 4gbps, though it still drops to
2.2gbps -- and this still doesn't help since usb3 gadget capable
controllers are nearly as rare)

- Maciej & Lorenzo
