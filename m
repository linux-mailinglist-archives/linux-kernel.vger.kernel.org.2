Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBBD3D0AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhGUH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbhGUHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:52:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84155C0613E1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:32:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n11so610537plc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pf6yv9jzBQ/5AFzoIiLQG3uhUQu1tpDnak3e79XC28M=;
        b=y621LkRHoi99PoVsbnU6S0bH0TRJ5AQnMgOjpKF2WeizYtAtjYEO4wMVTq0GXd76Dx
         DViLNHf98/Czq3TvPL2kWUcgaWOm5bihicRD4yEqjftumKKgsyvoLgul2JrkM15M/Jrm
         vwWifgz5nXe8nKG/cEfmv72QUuURbldIZczbabFzQMd3BrMgIdooTAMVBilzLpdjYpJH
         1fLAP7FPSDPZdI4uV3+BC4PTZvruO/4otSFfN8ILdtj0ZpXdV+sP2wfT+HZdkiuoyeI5
         mK9KUCMw4ADGl0/8xmY6I4G/9GOnQTMKkKNW12qrrkblyDl+7sqmf+clAHi1LsFrCM6F
         VPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pf6yv9jzBQ/5AFzoIiLQG3uhUQu1tpDnak3e79XC28M=;
        b=bUINDekxlGRbLmVEVeU+hCSizWwwVt9kWDWRR3MY2NgpzbKAm7XEBCf9IAMEsNQvLm
         Djm8z4TyLhzZKRySLriQsLdq2Blr1TvJxRBbcbFKcPgWpjPgVs4gvurRJ9synSsGkPh+
         ZgX2I28Ktj3PlRK/5jUKeQd8PN6eynNVhYSAZU7jlFZbQjOjDvQF4gouop7+Mn/tG/gC
         cwGEjUVsEjn6sXLMIp68rF3PUbjC80elN73+YYlnrC2anltPhh5x6b+gs0o8lsOPvy6N
         Cl+8LLOr3UPozgRKDOT2M0q0O5aeFLwdFqCRBDIxMEHJJmH4xRbAeII6p/hMm1MpSa46
         VBOg==
X-Gm-Message-State: AOAM532AoKvJV6Ep8tIrRTNAtwva+9VDPj9OhGrEHMukLf+nlSMOM2Wr
        QEp3JlM18CCHJJrAQ9qE1mAzW5GB+m44A53UNF/UeQ==
X-Google-Smtp-Source: ABdhPJzRQYs9xMtL6uWdKACy4LYj8NjRc/WHONkTYnb65giEix9lTJqOkotPC3WrBp5cVQ+01FK/g1KFYFLuwN5g3L4=
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr33821256pju.205.1626856367721;
 Wed, 21 Jul 2021 01:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210721082058.71098-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210721082058.71098-1-andriy.shevchenko@linux.intel.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 21 Jul 2021 10:42:42 +0200
Message-ID: <CAMZdPi_SotoXgWHQxHyWnjVHs1M2t3xa8+qhsD21b_qcp+t_ag@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] net: wwan: iosm: Switch to use module_pci_driver() macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     M Chetan Kumar <m.chetan.kumar@intel.com>,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Intel Corporation <linuxwwan@intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 at 10:20, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Eliminate some boilerplate code by using module_pci_driver() instead of
> init/exit, moving the salient bits from init into probe.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
