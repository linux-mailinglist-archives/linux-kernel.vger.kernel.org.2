Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1D3A4F95
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhFLP4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:56:37 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:35580 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhFLP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:56:36 -0400
Received: by mail-ej1-f66.google.com with SMTP id h24so9176194ejy.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YEwH1xUBexaQjQy444AMFhTWl7ncLLt62r7flQpz9jM=;
        b=GODhFnOeQE1VVVSsaeZFv9hSewICmz3npeogQ3oKgNneqJy/y7hoKh1Kt8M8N6bxeu
         UPNuaM8s0zokT9Elnh4mav5Hdagdvzp5DCbevGLBVELqw0C+iFZRR1/8Gm7hf1lEupM7
         k6CysTYjU1qcG5AULZw6jZDvdRwSUgqog8fdufVu3MC4Ox2quyj0ijHcZUEYA4xKSQL2
         RYVOFWWS+d8h4ZxDs5sr9rwlCbXz4MEZhCihRfZgd+6oWxLh+h2xi2rHpnvW+HUXHaYx
         EOwVqFVtUgPCM2YKZ8g7Ur1fAe2xpj+XGf2RPQM0m5jmDdxN/7KGDQT8qx117API9svX
         l3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YEwH1xUBexaQjQy444AMFhTWl7ncLLt62r7flQpz9jM=;
        b=mvA21Iunk7HW+KNIfG7eLEYreyJEoxTzk2FPN+uBXsk1GwcOMj74y3DwkxFn/qZEg4
         bVOJyvMLZQcrDXhbkgbQguYaEnAXEDAp390gs64hZE6gcoYzKlgtOxusw5jJ3cU7MoLZ
         2PFFvNy2ljLXx5LCjnsj1p3y8OLdRCLdnO0zka5rW26BQoXZ5Y2K9mC5xPWaUaSGzScp
         R9l0M9jHpflZ5Qvors4zkDnAyDXErnJInXTUXe/OXWjpvy5MSdYxz+1IvVZSdPWsdp9k
         SsHwYWJ36QFXU0yXrum57rX+xkolV5rQDe4CEaGAJ7NAdb1R6EttBay7tm7oVEAT5fEW
         P/MQ==
X-Gm-Message-State: AOAM531zlS7CLaH7dpX8WJ8BiccUhvNHKCnYpyj2XMH6ZesjdTW6WM65
        i0er/1NWu3z52Cjm9s6WaKN+O1O1AqPWmYEpbHVzqQ==
X-Google-Smtp-Source: ABdhPJz/1njMW9zMPTNfjSiKq/DyVCSiDCmlohXKU8qTerXwEQoPDKmW2VNaL8+JPI3ZELFR80ekznjGzCAW0kjcxGU=
X-Received: by 2002:a17:906:56ca:: with SMTP id an10mr8233290ejc.328.1623513199038;
 Sat, 12 Jun 2021 08:53:19 -0700 (PDT)
MIME-Version: 1.0
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sat, 12 Jun 2021 23:52:43 +0800
Message-ID: <CAFRkauAcKy_h77UXuMGMM8KKsivcccVScBm-Xwu0Oc7ne4Wtkw@mail.gmail.com>
Subject: regulator: Question about hi655x ldo19 voltage table
To:     Chen Feng <puck.chen@hisilicon.com>, Fei Wang <w.f@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Current code has below voltage table for ldo19:

static const unsigned int ldo19_voltages[] = {
        1800000, 1850000, 1900000, 1750000,
        2800000, 2850000, 2900000, 3000000,
};

The 1750000 looks unusual but I cannot find the datasheet to confirm it.
I found in the initial version of the patch submission, it has below
regulator-vset-table [1]

+               ldo19: regulator@a38 {
+                       compatible = "hisilicon,hi655x-regulator-pmic";
+                       regulator-name = "ldo19";
+                       regulator-min-microvolt = <1800000>;
+                       regulator-max-microvolt = <3000000>;
+                       regulator-initial-mode = <0x02>;
+                       regulator-off-on-delay = <360>;
+                       regulator-ctrl-regs = <0x02f 0x030 0x031>;
+                       regulator-ctrl-mask = <0x2>;
+                       regulator-vset-regs = <0x084>;
+                       regulator-vset-mask = <0x3>;
+                       regulator-n-vol = <8>;
+                       regulator-vset-table  = <1800000>,<1850000>,
+                                               <1900000>,<2750000>,
+                                               <2800000>,<2850000>,
+                                               <2900000>,<3000000>;

So I'm wondering if the 1750000 is a typo? (should be 2750000).
Can someone help to confirm this?

[1] https://lore.kernel.org/patchwork/patch/615156/
