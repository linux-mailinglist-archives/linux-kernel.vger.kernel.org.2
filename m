Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE73A0F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhFIJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhFIJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:25:00 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F4C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 02:22:52 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id f21so10763689vsl.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0YZpXNbvNe/aSIMfW/fwl9JTlg+qPtxAYhHQZpkJJ4=;
        b=CyVtn6ZSLRs1oFQym5BtCew3deGCkiBozlrFzkPIiKz5Rb7UCB26M8AyNnmSisKHTr
         F1/le1gMmi0RFt6NQF0eucGdqRZgkKDwvYbOOjVt8bCBLLIf3lTcakxEWcNDLAB89nKG
         4IosI3wPfmZwZhHQSynroTq0O6TTShBe35D+FTlwBf+3t0N1a7XKJ8lXf9U7PYgbVrP7
         Tb53lyrs2E+NfzJ/u1vOGHtJLC35qtzM1KkFafmPlmXLBKlKUVybXKgcVnniOCWnuMZX
         J7CXv8iAEtf6FD4DSZOqz4p97tUD7Kj0xj5QL8CMLT6Wb8/FNP0Y5e8EGjMm/b1enD4B
         GOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0YZpXNbvNe/aSIMfW/fwl9JTlg+qPtxAYhHQZpkJJ4=;
        b=FSuWnGA9aKAWPCIfi0VAHjx46Xg6oGIo1BpIgCCx8hW0I8hAvZROYFeLL9HOLX2syh
         n9/d9VpYTjtZabwYQmkxAnpnOqlffLW5X6e2rAnfUWFOZz9yfNbocK8uQba7EH0qYfEX
         xvoKRYuLjVgpMlwWP+u2f/zPiPfeOkZV0zLp/7ZBhrLJ89kPhQssp1KdtFUUxwWBB31t
         1Vkc1N8JNBQsOZxRvwSrUroedMhNXTb0B/RbL6+gzLWkSxyH4aqWsi7rQibvgC4KpMQ8
         aGLIfxBebY3pcJsR/Yg0F7+ikaekupEbJqsS9pmKDJIEfJBcX/a2HiVTIbXUFsLyTn2H
         U0ZA==
X-Gm-Message-State: AOAM532t8jAKVcx4rVLSvEDD94m5/zCu2UD9KB3qLtMeRTf0ZSttOuxg
        UCOFKZ+KUwtWv/nz565n5T/TEqw7pjCbyZ59ITc8ng==
X-Google-Smtp-Source: ABdhPJwmQWO+A9c4qf5r1Sf38PiCEAqfFiT0xFdSmkConGycXQzCXk0CGXuaUZiTt7ZCa0L/YNo6OIhaj0pjcUYyCjg=
X-Received: by 2002:a67:e359:: with SMTP id s25mr3243979vsm.55.1623230571541;
 Wed, 09 Jun 2021 02:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210602192758.38735-1-alcooperx@gmail.com> <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com> <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com>
In-Reply-To: <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Jun 2021 11:22:15 +0200
Message-ID: <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 05:07, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 6/8/2021 5:40 AM, Ulf Hansson wrote:
> > On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
> >>
> >> Add support for the legacy Arasan sdhci controller on the BCM7211 and
> >> related SoC's. This includes adding a .shutdown callback to increase
> >> the power savings during S5.
> >
> > Please split this into two separate changes.
> >
> > May I also ask about the ->shutdown() callback and in relation to S5.
> > What makes the ->shutdown callback only being invoked for S5?
>
> It is not only called for S5 (entered via poweroff on a prompt) but also
> during kexec or reboot. The poweroff path is via:
>
> kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
> .shutdown()
>
> For kexec or reboot we do not really care about power savings since we
> are about to load a new image anyway, however for S5/poweroff we do care
> about quiescing the eMMC controller in a way that its clocks and the
> eMMC device can be put into low power mode since we will stay in that
> mode for seconds/hours/days until someone presses a button on their
> remote (or other wake-up sources).

Hmm, I am not sure I understand correctly. At shutdown we don't care
about wake-up sources from the kernel point of view, instead we treat
everything as if it will be powered off.

We put devices into low power state at system suspend and potentially
also during some of the hibernation phases.

Graceful shutdown of the eMMC is also managed by the mmc core.

Kind regards
Uffe
