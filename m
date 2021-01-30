Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6F9309327
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhA3JS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhA3ENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 23:13:38 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A358C061355
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 20:03:49 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id n22so7495746qtv.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 20:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=6yjiROmKXwI5iy3N25Dq+Vp2KGEiJYR7/eTGN7b8WqE=;
        b=WkbIQAqdWGfFeU7O8qmZVRy0Q1Ra+14RGwmTbc29b04j77rcth7QCAxHA4+EFEVuh8
         xcYInAaWJZPGS8kJwzeKjtMX8scRAqCSkH7ny0GuoqsHYke1nc27oOrXJtCElv/ZcvZO
         gecl5ikLFYBlfLd/0bcEfPp2gdtFAwEmMkgH9Z3+TcHWP+uqfxTaxN8cYZ7QI2Z6a9Hh
         EbFsJP/FrMNaBZht8XCs75kjAOiX/UlOx21Lq0x3mb8CJItu70WwihQkA1v73xy9w1og
         3enOizDZI+BVlb7rO01zBkoHhxG4GY2GBjwnCbMrQ4PCbg1Rn+wU0/e8BjCEBE0OVn8W
         FQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=6yjiROmKXwI5iy3N25Dq+Vp2KGEiJYR7/eTGN7b8WqE=;
        b=K4CJCItQ+4O6t1gzQbiMubOpcZHfPyJ1frJ4fcWF003Jb4g5oytFgUF5i0aruup1RD
         l7Mv8rum51Ww/+bixRzHKwk5ks9a2IfHU1CdNtYHc/x48NYaS2EI2kUmo5Dr+6nAiVEO
         EdjO4UaKSo5FcEm466OK4gpwT7Obk2NHeJ5FqhUPUuBwYKqbGTHwtstWGlHyGfvsioE8
         Wxr+6iyxkri+BOS+RWVIzXPIgEOdv2QcycBxqju9GUg7qtzcM9aKk2o/FhePL6wTayYd
         kYJdIvSBYY9onEJc8WmW+bzqmtcntx6WXXJjxYW8kwt0OMdGk8t3GMd7M/wgGJawMPcb
         qpRA==
X-Gm-Message-State: AOAM530NIq68z9pDLyQACM6WkpcqxGyT4/9qyWbDWzUltvaJU7QEB0Nh
        G7R5/vxf53q4R4z0rHgyu3qHTbOPMZB9RwA=
X-Google-Smtp-Source: ABdhPJxEWOYD5y9oRx9km/I3IsjqchR2ILXWtrE4D/Upc4y0tZDFw25zF4Pd9+BGFHz8osCBNOhGHJW5Igps4TM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:b65f:: with SMTP id
 q31mr6637023qvf.24.1611979428638; Fri, 29 Jan 2021 20:03:48 -0800 (PST)
Date:   Fri, 29 Jan 2021 20:03:42 -0800
Message-Id: <20210130040344.2807439-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v1 0/2] Make fw_devlink=on more forgiving
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series solves two general issues with fw_devlink=on

Patch 1/2 addresses the issue of firmware nodes that look like they'll
have struct devices created for them, but will never actually have
struct devices added for them. For example, DT nodes with a compatible
property that don't have devices added for them.

Patch 2/2 address (for static kernels) the issue of optional suppliers
that'll never have a driver registered for them. So, if the device could
have probed with fw_devlink=permissive with a static kernel, this patch
should allow those devices to probe with a fw_devlink=on. This doesn't
solve it for the case where modules are enabled because there's no way
to tell if a driver will never be registered or it's just about to be
registered. I have some other ideas for that, but it'll have to come
later thinking about it a bit.

These two patches might remove the need for several other patches that
went in as fixes for commit e590474768f1 ("driver core: Set
fw_devlink=on by default"), but I think all those fixes are good
changes. So I think we should leave those in.

Marek, Geert,

Can you try this series on a static kernel with your OF_POPULATED
changes reverted? I just want to make sure these patches can identify
and fix those cases.

Tudor,

You should still make the clock driver fix (because it's a bug), but I
think this series will fix your issue too (even without the clock driver
fix). Can you please give this a shot?

Marc,

Can you try this series with the gpiolib fix reverted please? I'm pretty
sure this will fix that case.

Linus,

This series very likely removes the need for the gpiolib patch (we can
wait for Marc to confirm). I'm split on whether we should leave it in or
not. Thoughts?

Thanks,
Saravana

Saravana Kannan (2):
  driver core: fw_devlink: Detect supplier devices that will never be
    added
  driver core: fw_devlink: Handle missing drivers for optional suppliers

 drivers/base/base.h |   2 +
 drivers/base/core.c | 134 +++++++++++++++++++++++++++++++++++++-------
 drivers/base/dd.c   |   5 ++
 3 files changed, 121 insertions(+), 20 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

