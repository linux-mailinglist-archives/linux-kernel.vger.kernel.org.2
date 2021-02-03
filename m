Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D031E30DC5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhBCON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232207AbhBCOND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:13:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7421A64DF6;
        Wed,  3 Feb 2021 14:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612361542;
        bh=T++J5syGvH0espiFuRJNwSEFgx3QMah2rvs8uNHSMwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jx81uWucQNol4gDJQ2c2pVpciHkvS/kE8ZXhQCB/dQflxlASVJQetTFbtE9/SLThZ
         GWq3Qo3XZjx4enDj+orr5odCIvop/UwT+oqFsAmFl81jvBoSB/5sd5ZLqurxJtYr+y
         DPvlWLeoe4sVcipxrjCjskDQcajQcPb8bhErBbJEhCUpH8p1VUqqm06j5geZ2zfys7
         LhPe+puBP8os/Eb9M5maGe5EnLUqe7TmTn80GhjavxEPUzPg/lIWUDuHMkWsnwQPSr
         fGW6S2ocvpswqzxwPO8NNNtC74K5wr/qiob8ak2ERv1RyQC1EebknBwEWQBO6mo6+M
         qIlICyrmGGw8g==
Received: by mail-ej1-f41.google.com with SMTP id a9so17607069ejr.2;
        Wed, 03 Feb 2021 06:12:22 -0800 (PST)
X-Gm-Message-State: AOAM532OQ3jUoaXaidBT1m9ZFKYa/LTTvEc5mD6sXE9opewFDUkcSIlQ
        1Et0SFS9bustOS1we0woK4SUTExx0T/7yYMlPQ==
X-Google-Smtp-Source: ABdhPJzh+o3yuJlKqDtPu4rsfjDGkCFzx7d4rkkAtc/i2TuxwiEHLBbUNKhP9AOyod2wFn6gChPTFRpQJBYiCNoVbdM=
X-Received: by 2002:a17:906:958f:: with SMTP id r15mr3261133ejx.360.1612361540898;
 Wed, 03 Feb 2021 06:12:20 -0800 (PST)
MIME-Version: 1.0
References: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
 <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com> <210b0e5a-767b-c285-62e2-23de19bd3cf1@xilinx.com>
In-Reply-To: <210b0e5a-767b-c285-62e2-23de19bd3cf1@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 3 Feb 2021 08:12:08 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+m7F+nD6VKd2L5i44hz32_-6iX3toZ0A0CBT-g7Xqu9g@mail.gmail.com>
Message-ID: <CAL_Jsq+m7F+nD6VKd2L5i44hz32_-6iX3toZ0A0CBT-g7Xqu9g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: zynq: Add address-cells property to interrupt controllers
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
>
>
> On 2/1/21 6:41 PM, Rob Herring wrote:
> > On Mon, Feb 1, 2021 at 8:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >>
> >> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
> >> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
> >> commit
> >> "81e0919a3e21 checks: Add interrupt provider test"
> >> where reasons for this checking are mentioned as
> >> "A missing #address-cells property is less critical, but creates
> >> ambiguities when used in interrupt-map properties, so warn about this as
> >> well now."
> >>
> >> Add address-cells property to gic and gpio nodes to get rid of this warning.
> >> The similar change has been done for ZynqMP too.
> >
> > FYI, we're going to make this check dependent on having an
> > interrupt-map property. So adding these isn't necessary.
>
> Good to know. Is there going to be report if interrupt-map doesn't
> exist? Which can end up with reverting these changes?

You mean a warning if '#address-cells' is present and interrupt-map is
not? No, that would cause lots of warnings.

Rob
