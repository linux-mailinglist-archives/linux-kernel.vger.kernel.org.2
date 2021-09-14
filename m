Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E940A57D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhINEku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhINEkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:40:49 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:32 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m6-20020ac807c6000000b0029994381c5fso58940652qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MBZWbXq3qFjZV5/ZC8HwIyzto3i55hakr9gaFzMLH80=;
        b=L0yWiIs/H1pcr2VgfXiChut+VNbQqyG4LaWc4rXYTCaWv73cZzZ4XvaUTXd0bn1PGT
         eTzOROq7bDQ2m3Lp5mkyQ5Ni2/lOJHQjCspdN4UD0H63Bd7M2LU2zmJLFxcdG9YZZHlv
         3goQrJi7Kp74VUTyTd72wNDr684s15fDdOGZQZTayDnW4TjYTrxN2ws1TZXdlKxhA9Lh
         fkqEsP92mr+UQ+9hoEYHjRr57itkSJjpdrA/Ub//hf7Ry1C6bfdeGMkD3y1fNFY1R6Dl
         g5qUMQiUL5f7bVkTolT4TV4RUvZxAzU+hsuhEbTzQ7jCZTOaYUhTY+is8GEJqhjJ+7f/
         nzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MBZWbXq3qFjZV5/ZC8HwIyzto3i55hakr9gaFzMLH80=;
        b=aKcCccpV8nAUolAx0NVs78bPN5B8JUz/z0fopcsweYXPuBVIFdDnQYpReyusJgKff4
         TYm0rMV51H2r2I6spC+jl+Xc7H+OujyOEmULaP6PVKi4NdNX9U0kDuVbZimxB/KHDBhF
         KqPauKQIYMYMQKAEaT/avcqP4Oca0F4sa3w5Yynmrlgcex7NwAhEyWe2BtmceovHu8k1
         cxLv23iOBe6ygp8yZTKd+RsAf6efBJWN+gpFyM/Az7C1Cab2Z+6kLk+FGp4mTUtDD1wH
         dNnaBorXZSxGw7UPB29lY5Jwc+tN5Fuq/+apmP73em9/39Yz7XCG/ElSyurK3A3rV6iK
         auKg==
X-Gm-Message-State: AOAM531flTQBUSUJw0y6VxhhuUW2P9+v4djNROtykrU3RbHVTq6cEdsC
        1EOXMZOZNWkTD/Ran6t3f/Jeh/ZdASEgC/c=
X-Google-Smtp-Source: ABdhPJzU0QaIz6Qgy7JLyhsHtnJh70JJ/g+0PY7TLATivIwy6XzJf4VIQZSpiPUCYaKdymdqUbCcUeLY/SPjVi0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:48b:108c:f6a1:56f3])
 (user=saravanak job=sendgmr) by 2002:a0c:f38b:: with SMTP id
 i11mr3327369qvk.42.1631594371438; Mon, 13 Sep 2021 21:39:31 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:39:22 -0700
Message-Id: <20210914043928.4066136-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v1 0/5] fw_devlink improvements
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Patches ready for picking up:
Patch 1 fixes a bug in fw_devlink.
Patch 2-4 are meant to make debugging easier

Patches that need a bit of discussion:
Patch 5 is an RFC for fw_devlink.debug cmdline param

CCin'g a bunch of folks who've had to deal with debugging fw_devlink to
comment on the need/lack of need for Patch 5:
Cc: John Stultz <john.stultz@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>

Thanks,
Saravana

Saravana Kannan (5):
  driver core: fw_devlink: Improve handling of cyclic dependencies
  driver core: Set deferred probe reason when deferred by driver core
  driver core: Create __fwnode_link_del() helper function
  driver core: Add debug logs when fwnode links are added/deleted
  driver core: Add fw_devlink.debug command line boolean parameter

 drivers/base/base.h |   9 ++++
 drivers/base/core.c | 118 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 99 insertions(+), 28 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

