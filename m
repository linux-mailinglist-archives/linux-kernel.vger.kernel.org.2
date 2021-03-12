Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D7F338AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhCLLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhCLLCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:41 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B54FC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p21so44997230lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUkWWP7QtoyKW+p9PVjEC7J9wcMKoCcktZeNogcq/VI=;
        b=W2jGvcdU20upo5UDCNpO+C2xU5sJJgj/WjGt/U/+tBGOkMgJsUWGnMq4q53K11RwC+
         CND6msi+RrkBF3A7rM4EqHb4660MCEd9LIBtRpkykSkJetAEb8Yasl1xelzIiiznekMJ
         MvHQWCzwMX1OhnZzLQxMzPAPrFDNp1gsOo9AS7c9eaDKaFQBy5epYU/qIPoV4BMEeH59
         3QYBQGsGht7h6gV+J5Na81fARuw/fiHFRzZVia/xNcWcXLLiRoRu2C0zRZEI7w4/rQhA
         bZxqceuAPF9cZPd3aQb26bHTglVpixSRV0WobQYEgjueV6eRctvEfk48b38b/KbaMpIx
         I8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUkWWP7QtoyKW+p9PVjEC7J9wcMKoCcktZeNogcq/VI=;
        b=p4AygF+fKf7GWwUL1+xLSHAs8dFlMBwn3C7dTQpaYf3D3Asb/omleYjMXNniRc6TFF
         rYkPwvZ7gj/LVGGHRN1uH6xvzM+RU7wt/9g9HqhlHGzv8e98MoJvGe+tpWgqKjR4VvBj
         3/N0uFCJbz1nYtEh6wp69lhIXHBLHYvkKEYnrOlVAmlakExDsecA52MK/xCxnviFhfUw
         tAfLSMpl1GP3jf7acE2a4p3VDxgBwkpcC29rbctGpaCyyZPlbDQEHuIHyWwsaTGL4/4o
         9oAv6wbpU2CXxl7CnwDd2VCZnuxpyuKM3as6GnGB7Py1M3vP3ig0+Jimn7/Ny3LAokzr
         HrCA==
X-Gm-Message-State: AOAM533Cvf9bQHbdzFfYSa+JRSymtk+ak/PK45hcNwlYOp3x1gJ8Wb7g
        ufkpX5L661FWP4ejCQAxmqZfrw==
X-Google-Smtp-Source: ABdhPJzOz/wOTBs9Q4k/78L4//AFn4BXGSrmYePYXZnvasIVMMl3mFJmCIu8CQfTYK32QMl3fzCamg==
X-Received: by 2002:a05:6512:acb:: with SMTP id n11mr5013428lfu.288.1615546959825;
        Fri, 12 Mar 2021 03:02:39 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id p13sm1933647ljg.116.2021.03.12.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:38 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.12-rc3
Date:   Fri, 12 Mar 2021 12:02:37 +0100
Message-Id: <20210312110237.174917-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.12-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12-rc2

for you to fetch changes up to f06391c45e83f9a731045deb23df7cc3814fd795:

  mmc: cqhci: Fix random crash when remove mmc module/card (2021-03-09 10:00:52 +0100)

----------------------------------------------------------------
MMC core:
 - Fix partition switch time for eMMC

MMC host:
 - mmci: Enforce R1B response to fix busy detection for the stm32 variants
 - cqhci: Fix crash when removing mmc module/card

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: core: Fix partition switch time for eMMC

Frank Li (1):
      mmc: cqhci: Fix random crash when remove mmc module/card

Yann Gautier (1):
      mmc: mmci: Add MMC_CAP_NEED_RSP_BUSY for the stm32 variants

 drivers/mmc/core/bus.c  | 11 +++++------
 drivers/mmc/core/mmc.c  | 15 +++++++++++----
 drivers/mmc/host/mmci.c | 10 +++++++++-
 3 files changed, 25 insertions(+), 11 deletions(-)
