Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C539F724
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhFHM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:56:15 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:33317 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhFHM4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:56:14 -0400
Received: by mail-vs1-f44.google.com with SMTP id f11so10797334vst.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDlE8XM+AqrC8aactj8iOE9/9/UtQhGPP6ubsL853mE=;
        b=ynpc10QMwm1EgFSorofuApQoVcK7XFUqTGiG/nOznXG5OK3Vs7OJvq5di819+XZX7P
         KE41fyCrCkIn1O+QuYypb2iUsvHiElO1lrhDqRlgEjkqcpZrVQlSkxZIG/wthzCj3fOj
         htkCrvsm8PvJfnwOADdWmCPFNfL3nWvUUQBney1QxyJIaw3CT+VJ5TdluB2SKBfpXdpO
         QZlyXchlhzlevdx7DuKhficlhG+d06CvwIttQhfJf2dk1TEaZD6wNjjEFr6fsSFongIf
         sWu1mQq8ztnYQrqVoRNTv10PzYGdlu2ZCTk8ODBhRLMeYY+90Xu0zDLoKov/EJlc1iMt
         NIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDlE8XM+AqrC8aactj8iOE9/9/UtQhGPP6ubsL853mE=;
        b=r4wiKDo+IVbcX/DVQJkaOX38+jMadkuzrG/oyyCdwNXkb9Yohdrnu9jmgoMw9EjnXK
         0ivgYbqAaaXoWDaESDSz9JxlCgykT7TrhL7X1hZwN4WetV0Eiv6LRJ0jVS+uNy77gVUR
         Wj2IQeKQmR0lu+z+K/HBHEMTRJ30W5zpLKZjV8oCO+ZZD8oVDPawOZyhyI6tGNnDqoA1
         fnvTufL/oGXEEKGOGC2AmjeutmugMrA7PChzA8nUaoTesAtNawmssHKu+nuB0KxmkMMp
         KdQs/mUOxb5nRCKl1/wS+QnYcypq1vj5UPME5z08j72tLBsR/4cGHYnXyQKQxz35HMDW
         uxyQ==
X-Gm-Message-State: AOAM532w+uwIWTYF23jNAwlMLQs58GnbS8Z7KAchXXt3jp3IFki+0t3s
        o8avqRRgFfKScRZWRHUYKeU0yQJn4Si69Md6xNbeQg==
X-Google-Smtp-Source: ABdhPJzXlM5//BYqNHry4rGqxcGe5fwgnxOs8PtRpsSla+nUrxQuMCRfrAnGVPJFCfoi/NqcFSD0YHHKehrlKhq2/SM=
X-Received: by 2002:a05:6102:3023:: with SMTP id v3mr11576713vsa.19.1623156789091;
 Tue, 08 Jun 2021 05:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210603182242.25733-1-rashmi.a@intel.com> <20210603182242.25733-3-rashmi.a@intel.com>
In-Reply-To: <20210603182242.25733-3-rashmi.a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 14:52:33 +0200
Message-ID: <CAPDyKFr-vuP_bdG-iFjJyS3ZeVDiVq+3aVERHjBo-8BHf38m9g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=E2=80=9CPATCH=E2=80=9D_2=2F2=5D_phy=3A_intel=3A_Fix_for_warnings_d?=
        =?UTF-8?Q?ue_to_EMMC_clock_175Mhz_change_in_FIP?=
To:     rashmi.a@intel.com, Kishon <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-phy@lists.infradead.org,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 at 20:22, <rashmi.a@intel.com> wrote:
>
> From: Rashmi A <rashmi.a@intel.com>
>
> Since the EMMC clock was changed from 200Mhz to 175Mhz in FIP,
> there were some warnings introduced, as the frequency values
> being checked was still wrt 200Mhz in code. Hence, the frequency
> checks are now updated based on the current 175Mhz EMMC clock changed
> in FIP.
>
> Spamming kernel log msg:
> "phy phy-20290000.mmc_phy.2: Unsupported rate: 43750000"
>
> Signed-off-by: Rashmi A <rashmi.a@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

I guess $subject patch should be queued together with patch1/2 (via
the mmc tree?), no?

Vinod, Kishion, if that's okay I need an ack from you to pick it up.

Kind regards
Uffe

> ---
>  drivers/phy/intel/phy-intel-keembay-emmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/intel/phy-intel-keembay-emmc.c b/drivers/phy/intel/phy-intel-keembay-emmc.c
> index eb7c635ed89a..0eb11ac7c2e2 100644
> --- a/drivers/phy/intel/phy-intel-keembay-emmc.c
> +++ b/drivers/phy/intel/phy-intel-keembay-emmc.c
> @@ -95,7 +95,8 @@ static int keembay_emmc_phy_power(struct phy *phy, bool on_off)
>         else
>                 freqsel = 0x0;
>
> -       if (mhz < 50 || mhz > 200)
> +       /* Check for EMMC clock rate*/
> +       if (mhz > 175)
>                 dev_warn(&phy->dev, "Unsupported rate: %d MHz\n", mhz);
>
>         /*
> --
> 2.17.1
>
