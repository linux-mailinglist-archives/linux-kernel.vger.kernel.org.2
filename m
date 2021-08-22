Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398D03F4002
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhHVOiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhHVOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:38:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7966BC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:37:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d6so21969519edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfPaT2o9ejPWoclQhHTem2PUE+dQ31fbuBiXbqF2/GI=;
        b=1lYBBWVF9iTKaRw0g2x7Ef/GnarjXuLUUwBd1DD2lwxJ5n4R03JXaXNlAJWg2gJbdQ
         RQ7K2vvei3VZdnT1MT3y6RgKLenZcXrWcWKmEdNgBtpNlQlIoUjQTxQ1KVmJa34r+Z9Q
         Aeq/ZESYm2UbKOLrqHrka6d8w+Pub9K9pWzw0FNwwcK1ywpLWvs3dnpkeuNwZLeuRrp6
         M7Gw+RXDsiJ95Vjc7+yZei9UEdmgSl2F3daV1VGtK1LiO9F/L8mNWknQmo0G6EnxIJ0P
         FNyu++YmrcPvepNWLGJvRVMxPZ2MuOpJ2vhnq08Hb8mkFP6nDZgW3qvLLYxfG7SsF0z6
         ZckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfPaT2o9ejPWoclQhHTem2PUE+dQ31fbuBiXbqF2/GI=;
        b=AmWR/uc0d+FGKvicLH9iWUJLSsgoEOXYSxKtsVuox/3DHMPv6CULF8ckpc29qqE6Na
         QwZY/aL9CYMnjHgmkZG5BqyKkCrepKPUJuH92Iy/PqHpSUeA+w6avGxc70refRSOoxQ1
         tOPTyXKo9Zv4kqMYP5FPEjun2pfHapjzVV2TIiZEy0CYU7lcL0WEW0rc34qnZqZ0gO8s
         NJptxubtHo/jvyPLIxNUOTfI/Drj5cfQYgCrwkxI6oDyziOnFO3NWocw6rooj+V3lexE
         oq2OIeqhkvczcndUt3ldeSUWJT9lKtr8v0n91WLJ50RWoU6BNqU3/AM6/M+9Vs0V372X
         t6Lw==
X-Gm-Message-State: AOAM5304xf/VHJoT/XeELDgwZ6ChUZ38vDHZ963svp0yrYQKPEznjIN9
        0/9jAafpewEkWWq6w/VptHAyHXe+Kom64YpgOCvBtg==
X-Google-Smtp-Source: ABdhPJz6igOpeceGcgr1x7CHFqZncopWDgHJVTamT1TtjkqwGes1sDKzPMFHqc3Ugyy3G58z0QA9QnCpuUuzz7/NhmI=
X-Received: by 2002:a50:a452:: with SMTP id v18mr11615212edb.17.1629643056044;
 Sun, 22 Aug 2021 07:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210822115755.3171937-1-knaerzche@gmail.com>
In-Reply-To: <20210822115755.3171937-1-knaerzche@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 22 Aug 2021 11:37:24 -0300
Message-ID: <CAAEAJfDLvctAk3omLgFBBbzvufFKwSW5_cQZ+MjvyN4khGOe_w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Re-add interrupt-names for RK3399's vpu
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex, Heiko,

On Sun, 22 Aug 2021 at 08:58, Alex Bee <knaerzche@gmail.com> wrote:
>
> Commit a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
> intended to remove the interrupt-names property for mmu nodes, but it
> also removed it for the vpu node in rk3399.dtsi. That makes the driver
> fail probing currently.
> Fix this by re-adding the property for this node.
>
> Fixes: a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")

AFAICS a728c10dd62a removed lots of interrupt-names properties
from devices other than IOMMU.

Maybe it's best to revert it?

Thanks,
Ezequiel
