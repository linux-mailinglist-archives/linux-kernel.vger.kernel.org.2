Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA22314468
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBHX6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhBHX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:58:30 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CCFC06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 15:57:49 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id l8so4036126ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 15:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BKcbNNOjiBO2ETX8rA0e94Kcv/0Lli4UWrEe/qIvRE=;
        b=KNC+VPHlDueVrMXq1S5/C3olGud4OPz1qXgkjrqCAGN6Esj3rrVX1vx7ruKisOPefR
         MkzSFhRx1oSEp7RaPuVS9x1eluitBSwsVEiIuof3ZJn2MAx4+N5a2I+vf7ZzeM7v3ji0
         7c4SiozsLlDdy1uva4nIDpkMHKl7COC/++5GRQNKxT7AX0nKR9iVrlP99HXE65FFKGZE
         zGA3xLaox1T4twIexyMsH2qJpW3Q4q/G8EK7CC7TApJDRDLNTjnGaG+x1yDl49jv5hYt
         oXm0cSYXegRY7Ht9qCunkDZ7RMYK771pzpJjr46Ne4DCKEp6LuD11FpTkVcqpvKHLHiS
         RupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BKcbNNOjiBO2ETX8rA0e94Kcv/0Lli4UWrEe/qIvRE=;
        b=W7J67TLiKAabAfQwP1R0hEv8BexrfGASmhP3HdXYGNY0TNrvgP1u/fIkWl5QY2L3e0
         BHXUdGsSbQO1XfT3qv9LhBmUZhfcPz8KNN42tqC84sf6pXNGg9UHvHfeXET0+3Thl/4c
         Tf3WFJACjCDBhNpJcv1E3efBipHnCih5L78Hc7/SQJE+D57/ezHD+Yv1OmoXgSbPxQHr
         kVZnRXPMjkrWT8wa0Er05L/XDWeJKWdYKnj/rxYPBJY7LaBQamCdkKL5bm357+VhwZRy
         c5P6PWxXY8t7plnfBGDwVJdfWCQjBdYQ1WoY/ZQHa5owHtSmL+0YcdrrZ1r6XHtxRTH0
         46ww==
X-Gm-Message-State: AOAM531HorS/ClBLuO3kDAUMwHonDTudjtKG3g4nQ8nvxbYmaHluTIe0
        WA40njwaKQ5p3/GPQk/prhdznrZ+ELdbfMrgQiQ5HA==
X-Google-Smtp-Source: ABdhPJyWSN7D3Y6ZE8yWgCF8LiMpKCeSFyCoZ713kZRoDVbY3Hxuk2zkhBte1avCHvyEJ0NFmPIP3IBl22VvJgpOlqU=
X-Received: by 2002:a25:3345:: with SMTP id z66mr29775941ybz.466.1612828669020;
 Mon, 08 Feb 2021 15:57:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210205222651eucas1p28ef87073dea33c1c5224c14aa203bec5@eucas1p2.samsung.com>
 <20210205222644.2357303-1-saravanak@google.com> <7b486072-453d-a344-bdfc-dec58a35c8f5@samsung.com>
In-Reply-To: <7b486072-453d-a344-bdfc-dec58a35c8f5@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 8 Feb 2021 15:57:13 -0800
Message-ID: <CAGETcx9fpiy02+2_kRvtWos1usqA3gtCXqULsN906o70VKVGYA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 12:40 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 05.02.2021 23:26, Saravana Kannan wrote:
> > There are a lot of devices/drivers where they never have a struct device
> > created for them or the driver initializes the hardware without ever
> > binding to the struct device.
> >
> > This series is intended to avoid any boot regressions due to such
> > devices/drivers when fw_devlink=on and also address the handling of
> > optional suppliers.
> >
> > Patch 1 and 2 addresses the issue of firmware nodes that look like
> > they'll have struct devices created for them, but will never actually
> > have struct devices added for them. For example, DT nodes with a
> > compatible property that don't have devices added for them.
> >
> > Patch 3 and 4 allow for handling optional DT bindings.
> >
> > Patch 5 sets up a generic API to handle drivers that never bind with
> > their devices.
> >
> > Patch 6 through 8 update different frameworks to use the new API.
>
> This patchset fixes probing issue observed on various Exynos based
> boards even with commit c09a3e6c97f0 ("soc: samsung: pm_domains: Convert
> to regular platform driver") reverted. Thanks!
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>

Thanks for testing!

-Saravana
