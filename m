Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB07C40ADD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhINMgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232920AbhINMgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:36:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC3BA60FED
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631622935;
        bh=v6AkjW9KH6HTqCpgB1qg29+8WnES0yfsEN29ZRiutTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AyvBvp3r+bpgEGVlB+uHeCPb9C89UrFZHQo+bHESmCAWUypgJFqmE5L2m0vJwEyIF
         GaFlZJIJffWfjv5yKHr7/FOu+OcoYNwCorK1jvXIKt8HGcghVihFqTNXJDNWExiuhG
         EWV00o5OT1JkT8rEgS2VZwJs36pp/F0yPOnLikpNHiNaADxlKhBysfPISrCmHBmljy
         2ThQ7AYxMNva2VIhd62y6VCTxs+cubxnrVIMBK0uRiI72BBgxKtVANINO3hQvMPWDh
         stALc57tN4y0vmvSFBvbwSTd/2B7h+8/+b8vtEAdAwIf6pOMVmxOB4UWjta8y4wlsK
         FMb1bHNpbdNQw==
Received: by mail-ed1-f46.google.com with SMTP id h17so9513876edj.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:35:35 -0700 (PDT)
X-Gm-Message-State: AOAM531l19U30VB6X3yF2h8nLxUtZxJOzShwNeUdp4l3S6NDQunimkrA
        +ZbY5D5FYtQQv0km4A+RBCoewhic983tv210+A==
X-Google-Smtp-Source: ABdhPJyGDyxKaWA1ojHga43nQMWt/OBfXcdzcCLAHa2S0mUuTH0AWr9TYtJGBHU8xItZHhMt+7ADGi/w47x2PuB7698=
X-Received: by 2002:a05:6402:150a:: with SMTP id f10mr19053835edw.318.1631622934311;
 Tue, 14 Sep 2021 05:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com> <20210914043928.4066136-2-saravanak@google.com>
In-Reply-To: <20210914043928.4066136-2-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Sep 2021 07:35:23 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+FXN9cU5h7ZtcR_P6kuF-Hs3Cy-Z8rEug=F_4v0sWggg@mail.gmail.com>
Message-ID: <CAL_Jsq+FXN9cU5h7ZtcR_P6kuF-Hs3Cy-Z8rEug=F_4v0sWggg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] driver core: fw_devlink: Improve handling of
 cyclic dependencies
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:39 PM Saravana Kannan <saravanak@google.com> wrote:
>
> When we have a dependency of the form:
>
> Device-A -> Device-C
>         Device-B
>
> Device-C -> Device-B
>
> Where,
> * Indentation denotes "child of" parent in previous line.
> * X -> Y denotes X is consumer of Y based on firmware (Eg: DT).
>
> We have cyclic dependency: device-A -> device-C -> device-B -> device-A
>
> fw_devlink current treats device-C -> device-B dependency as an invalid
> dependency and doesn't enforce it but leaves the rest of the
> dependencies as is.
>
> While the current behavior is necessary, it is not sufficient if the
> false dependency in this example is actually device-A -> device-C. When
> this is the case, device-C will correctly probe defer waiting for
> device-B to be added, but device-A will be incorrectly probe deferred by
> fw_devlink waiting on device-C to probe successfully. Due to this, none
> of the devices in the cycle will end up probing.
>
> To fix this, we need to go relax all the dependencies in the cycle like
> we already do in the other instances where fw_devlink detects cycles.
> A real world example of this was reported[1] and analyzed[2].
>
> [1] - https://lore.kernel.org/lkml/0a2c4106-7f48-2bb5-048e-8c001a7c3fda@samsung.com/
> [2] - https://lore.kernel.org/lkml/CAGETcx8peaew90SWiux=TyvuGgvTQOmO4BFALz7aj0Za5QdNFQ@mail.gmail.com/
> Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Am I supposed to apply this? What about the revert and mdio-parent-bus
support you mentioned? Those are needed too? Please send me a series
with what I should apply for 5.15, not fixes and new features
combined.

Rob
