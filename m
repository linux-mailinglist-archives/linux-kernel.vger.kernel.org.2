Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3334415A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhKAIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKAIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:55:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838E6C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 01:52:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l13so6077346pls.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=cYDgColUiEr/kRhN6F8e+Hfxm9EHcULEhMrrp+2aVaI=;
        b=Kkv5I9rzV41Nz5vHAhshinI5K3SIHQwCSqo9fFyU20sXhBnAz9vZ1ZDOW0yRI2UGkw
         qFt6MysQetU/mahF2IzVf8O/4rR/ep9wmMNHKjV19bda9sUYU3PsVMCaw3CzQDFX/tKU
         b0S53eeqJBxUUI+yX7x362K2PR5/fhzR/rQMaTostTsIi/YYUBY6lhCrWAOBp69NwqRk
         aA2mDI/Nt6ET8XMRF/CSULKL6+ctcR6nu9EZRnEgv79y0QjdadujmU7PANKtaHS7W4P2
         DjMWItZrk9REucO1RGSnbz61WSFunqBXS7MAqnhIaiVlTM6UKNVKj4eAoA+R+vc8QAPL
         7rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cYDgColUiEr/kRhN6F8e+Hfxm9EHcULEhMrrp+2aVaI=;
        b=2riebhY1k812v+Bm3KPRoU2XOnUXKo3yJCO6MGWYykE+e2YxJnaYbi6k63nvrKlVNi
         e9cnkZAXorqywOfGeb1tWJ9Oc6i7Hi4FqpQwHrvgQzLpgc6pqmACk2nTK865eKrmyQHp
         RmfBuF1oF7eFE6gqA60xJcPyWK+d2OzDEsjQP4NhEGaG2snjfOIABxOrlD9fsdWDVpPZ
         zJdGwtwv83zhgxYc4S5s2o0VxhqI10KI4gmjARvjnFw5gUFHWUa/qtYYKfcq73UnDe9U
         0TilWP1qH/O3bXcQbRRn1Vt/McCdzA2AGeD+O6FP4lyOByHP69bTsNse6meaCH3cpxUv
         9lGw==
X-Gm-Message-State: AOAM532VKwerCmxh5iPH84prwm5FVEvB248qK2WpEhD5/8TlwEkkuIRP
        rbUuxquzDMOyrdqL4MQGdl7qA+TeA2LilpwNX10x2HFgoY7vbx3y
X-Google-Smtp-Source: ABdhPJzmt87+4oaao5gXnH3XfeL1HnWQdu1XI02s/QlbyOFODcnTExdN8WSM5NxxsanJcgCi3NmTzEs6UWHQlpKclsk=
X-Received: by 2002:a17:90b:4d12:: with SMTP id mw18mr36581837pjb.174.1635756749960;
 Mon, 01 Nov 2021 01:52:29 -0700 (PDT)
MIME-Version: 1.0
From:   Mighty M <mightymb17@gmail.com>
Date:   Mon, 1 Nov 2021 14:22:18 +0530
Message-ID: <CACLAQJEWGnMoA9hZrwK2CKheAxkVidDQVgb=S44GW-ypftxQrw@mail.gmail.com>
Subject: Adding support for audio (WM1811) Inbox
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to add audio support to my device,
samsung-espresso3g, but cannot seem to wrap my head around it. Other
devices in mainline are other exynos samsung's (aries/midas/arndale) all of
which have some drivers in mainline, while mine is an omap. I would
like to know how would I start adding the support. Here's the
downstream driver
https://github.com/Unlegacy-Android/android_kernel_ti_omap4/blob/3.0/common/sound/soc/omap/espresso.c
Any help would be appreciated. Audio is very confusing
Thanks a lot!

Best Regards,
Mighty.
