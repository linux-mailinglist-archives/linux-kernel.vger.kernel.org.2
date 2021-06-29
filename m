Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9225A3B74DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhF2PMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhF2PMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:12:01 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97CCC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:09:32 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x1so12326319vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ei8DhtlygzR0YzhvSAOeJxbaayqBzli32veTEMkT6ts=;
        b=KgCSN8MP8fJ6RDcn54L6DX3FgWWGlkmkFcMOPl4oYjR+d58BcJXY+kdqECuBlpC2q/
         Zc9QzTM1DWkzKtufY4WNCpGcAk64qpkwDRDcSfo9xZUr1kY9tINWtT/fq8jSrFqi9DN2
         zOZQDMuYG9BN2JbnQkr0pw3IKy8XsYEBMqOptpxnNb4ajTfOWiuQe9SXHmUXJ28Dbpg8
         XLg54I0B0EkIlkUJAcEeHvS8TIRh7JEWrlfZYDW4dbWJuS923h+HF3c4OEZb2VJ2xw+g
         krVEM/e0zj4PMxRLeHZPi814CtN/d0ZpQW931V6gCvWNUOSMCWPDJMahFGL6G2woinRi
         5ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ei8DhtlygzR0YzhvSAOeJxbaayqBzli32veTEMkT6ts=;
        b=in8CP+2T6HIngVRlfCbfhcpchCNWhuwA1M5lLxS6/Xms04ntxdGnpvRpuJr8LqahBy
         6CrWHvxDLXAnzb7lR/Bc1WbNOQnvlFp6XrgHzdCNkVYddEsMSLolrovRX5ZKw0kHNqEp
         T3OFG/op3SSqti24F2TG8VxGF37PtYv/j50oykUbvRLYKekm5MWA3kRutVdvHvfI8oLz
         ++Z7CbiF1YHsZ1LtrkZcgKiS8hi78vlZxOnzTX82/4pastGeDyZA8UvnnL0S8TiHe2Z4
         1CV6YErInaxAPLkbrf0rcbramTXlV8qPWLZT1K28JH6X/+8VP3QWY7EGw3CQmovgEKaN
         tW/g==
X-Gm-Message-State: AOAM532+jCns5QkjFTTrjSyB7RxJ+9CqCo6JLbvN5dWeD1wRJU8rix2H
        KCNEjsQPZfj92xEKt5wJ/JIULK9972QYezzzOpoNLw==
X-Google-Smtp-Source: ABdhPJwL/Tz4unVTR5YW3TPwtQhdejHIVarPlrmHY5dQZ9xC87opBGYtDHlgJBwMv9bg3bGpYPV+Vy5yzTNslaeT0ZM=
X-Received: by 2002:a05:6102:3a70:: with SMTP id bf16mr26199022vsb.48.1624979372186;
 Tue, 29 Jun 2021 08:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210603182242.25733-1-rashmi.a@intel.com>
In-Reply-To: <20210603182242.25733-1-rashmi.a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 17:08:55 +0200
Message-ID: <CAPDyKFpr=jjcjK=c7-cifYdGBw7ywmLsuJWw=bE8ZYqGuiUSfA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFvigJxQQVRDSOKAnSAwLzJdIFtLTUJdIG1tYyBjbG9jay1mcmVxdWVuY3kgcHJvcA==?=
        =?UTF-8?B?ZXJ0eSB1cGRhdGUgYW5k?=
To:     rashmi.a@intel.com
Cc:     linux-drivers-review-request@eclists.intel.com,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-phy@lists.infradead.org, Mark Gross <mgross@linux.intel.com>,
        kris.pan@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 at 20:22, <rashmi.a@intel.com> wrote:
>
> From: Rashmi A <rashmi.a@intel.com>
>
> Patch1: If clock-frequency property is set and it is not the same as the
>         current clock rate of clk_xin(base clock frequency), set clk_xin
>         to use the provided clock rate.
>
> Patch2: Since the EMMC clock in KMB was changed from 200Mhz to 175Mhz in
>         FIP,there were some warnings introduced, as the frequency values
>         being checked was still wrt 200Mhz in code. Hence, the frequency
>         checks are now updated based on the current 175Mhz EMMC clock
>         changed in FIP.
>
> Review comments from Adrian Hunter have been incorporated.
> Above 2  patches are tested with Keem Bay evaluation module board.
>
> Please help to review this patch set.
>
>
> Rashmi A (2):
>   mmc: sdhci-of-arasan: Use clock-frequency property to update clk_xin
>   phy: intel: Fix for warnings due to EMMC clock 175Mhz change in FIP
>
>  drivers/mmc/host/sdhci-of-arasan.c         | 14 ++++++++++++--
>  drivers/phy/intel/phy-intel-keembay-emmc.c |  3 ++-
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>

Applied for fixes, thanks!

Kind regards
Uffe
