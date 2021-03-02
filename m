Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77032AE0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360449AbhCBWUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383543AbhCBVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:14:53 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC3C061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:11:38 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id r6so14175114pfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=2Thoi1osEYfXt6vlYmJBsmUQwBzWO9/HMHOzYyQ+dCY=;
        b=JlhYscxyAHwtKr2APcDygmiHuBCdOFe7YuQwU1RS/m/sM/h/ZeBi8ilrOfPasbSJJl
         +DLoSyOj+dvvujDas/nLKbl0ezXnO2kaiDyL5AbnxR3EJ5C/sqLxVQcFLN4vbZO4vCjT
         V57bilDkHqB9jQWQXC2fn2om6Zxx4bsAMNeI72VS7uC3JWueI6gcDZQ5zyLQZ+fcMDMe
         wVLDym1xI0Xj3GqZ6jPp+AWWhA/BJ4RtSZ3lc/crPBjiAMDDshUsWdaCOiGBIwdsAiHT
         g9zuTvJxXASDi/Qx0iW83N+AgQHEvAfIrqM30pl4Ac7HFUmmpBrI+XSowyicspgvFZjS
         Jytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=2Thoi1osEYfXt6vlYmJBsmUQwBzWO9/HMHOzYyQ+dCY=;
        b=qsWMYEf3hZt4crWOU2DhIf2N+cWtCNHlD2Fq1USXZ2+YKDT7GSrGCWtpTE9CeQeF4b
         jbKuO7moME5FkxGtluxsogSfXgHGHehbiyHyfPTioFEqr03x65kBfkrbZYiTU5QcL34C
         i3NVDGBCjW7BN3Th30gem1+MRsikguAhlJ79NKXPmKw6c6O7qjGeOr6v401Ar1ufa0KO
         8+/awyOp33cPs/1OKxBlj+YJ9ywapx+BreWb14DURULDGIT0lHtkqNQq9phnbjFJUHxX
         lAE0NvRA0OHBaQCCQyUrwW62EL5JxKfW1BiBOrntzAjd8a0iYi5k3Y/aJjvoLiWRLohU
         V3Dw==
X-Gm-Message-State: AOAM5305NozlOp0NpjHwmn6WXml8j05mhYsNGMVN7YrRdvRutvuJHazH
        X1bo06MvhmPBzyQZ3Ob85gcMW36uPuneNOY=
X-Google-Smtp-Source: ABdhPJxHGZNlNo7X9updngw4+YMTHQp6SiAUJlgyHdiMIIednhlaxPAEwJdPPnwg/MlCw2I0WeiBu1PlA9GvGWQ=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:a1ad:fce1:8a40:59b6])
 (user=saravanak job=sendgmr) by 2002:a17:90a:6503:: with SMTP id
 i3mr6031863pjj.117.1614719498301; Tue, 02 Mar 2021 13:11:38 -0800 (PST)
Date:   Tue,  2 Mar 2021 13:11:29 -0800
Message-Id: <20210302211133.2244281-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the last few remaining issues reported when fw_devlink=on
by default.

Patch 1 is just [6] pulled in without changes into this series. It reduces
some unnecessary probe reordering caused by a combination of fw_devlink and
existing device link code. This fixes some issue caused by fw_devlink=on
with respect to DMAs and IOMMUs [1].

Patch 2 fixes a warning [2] present in code unrelated to fw_devlink. It was
just exposed by fw_devlink.

Jon,

Patch 2 should address the issues you reported[2] even without [3]. Could
you test this series please?

Michael,

I think Patch 1 should fix [4] without [5]. Can you test the series please?

Geert/Marek,

As far as I know, there shouldn't have any more issues you reported that
are still left unfixed after this series. Please correct me if I'm wrong or
if you find new issues.

[1] - https://lore.kernel.org/lkml/CAMuHMdUVVr8jES51_8_yPoicr-nwad_2nKLYUKweY8mbxx9GJw@mail.gmail.com/
[2] - https://lore.kernel.org/lkml/56f7d032-ba5a-a8c7-23de-2969d98c527e@nvidia.com/
[3] - https://lore.kernel.org/lkml/5176f496-facb-d7b0-9f4e-a9e4b8974178@nvidia.com/
[4] - https://lore.kernel.org/lkml/4b9ae679b6f76d2f7e340e2ec229dd53@walle.cc/
[5] - https://lore.kernel.org/lkml/20210120105246.23218-1-michael@walle.cc/
[6] - https://lore.kernel.org/lkml/20210217235130.1744843-1-saravanak@google.com/

Cc: Michael Walle <michael@walle.cc>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>

Thanks,
Saravana

Saravana Kannan (3):
  driver core: Avoid pointless deferred probe attempts
  driver core: Update device link status properly for
    device_bind_driver()
  Revert "Revert "driver core: Set fw_devlink=on by default""

 drivers/base/base.h    |  1 +
 drivers/base/core.c    | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/base/dd.c      | 10 +++++++++-
 include/linux/device.h |  4 ++++
 4 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

