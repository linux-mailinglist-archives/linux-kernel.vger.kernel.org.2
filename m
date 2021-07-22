Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268333D21F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhGVJgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhGVJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:35:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B515C061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:16:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u13so7649155lfs.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eHLHjox7zsczggbpP2vHWZT/EIVYwJHBH0DP5HlM7w=;
        b=x1tO8OYnLwZb9nAwnXIGFPsFwfEkpHQOahGVKQx3T3T4EOWPDaOIYtJSrF9v2pwu5l
         mALJ9n3U2pTK+U5IUVgA4mhw8r9dg/WDfliPqylLqZkYDec+84JKimexugRtTNU9xGgy
         +1QM/d7Fo0KEiCSq5KBBVWSSWnYYzEBK60T6fRsMvy7xf1HN3IK8wL406Qr4X0iWaMMP
         K9QIyM7JO8WTabhUcHA7iQg7IhJI84KRKEMXPdo7lgYKL8jLyH9CBMQbpVWKKqTnnHrN
         LcQtthY7r5ovd4fR+rmTQMdTU9ckqBEgEMBQpoU6f+g1LP3TJ/KuQe/HXSS9k7OFvKSb
         PV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eHLHjox7zsczggbpP2vHWZT/EIVYwJHBH0DP5HlM7w=;
        b=dnfB/G6RyWC/zpdlMRCv9gBnNa4tpjSJo0fWyYCXqc18d/XBI/ypC+NIMrOzyxjZiE
         5SM3Vu1019VOPwL8f3A94/QLcPAHacW/Qwn4iijxoPS6TcPbjRVJcj76pLSp2bsV3RdK
         9pTKJrQiAjvazW2hr++IDx7xlYK3PV4HPc1T0OOuBX/hTGw6L3L40xJab7SVSDbM+7S1
         gurKPXG428kzukiJIWE+6iY7+NTFiN80DePvzrhD25mxkvIaSduwFPj5EW0tJr8m80L3
         25DVK9WPLExI6P1vdJR2uFD5uMUsbXfzinBp4cz4nYuoQTcxbCTbc6aQVAgRbjQlJ6U7
         8Zwg==
X-Gm-Message-State: AOAM532nz1Wn32scNxlJX7MlmUOZD1q3hLL9pqT6Ojp/Z8hvPw1KYO4H
        GkSIfhWsMt8VVwTnJ5GOZAW6Zg==
X-Google-Smtp-Source: ABdhPJw9TizBuvUh6xSY0JKfIbezhc96UjLT7eNLSWjOA1hKD5sUDSm/1sdz2vsck9JjcbXqj9BpzA==
X-Received: by 2002:a05:6512:13a9:: with SMTP id p41mr28367918lfa.403.1626948977378;
        Thu, 22 Jul 2021 03:16:17 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id j15sm3053181lja.21.2021.07.22.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:16:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.14-rc3
Date:   Thu, 22 Jul 2021 12:16:15 +0200
Message-Id: <20210722101615.31766-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.14-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc1

for you to fetch changes up to 10252bae863d09b9648bed2e035572d207200ca1:

  mmc: core: Don't allocate IDA for OF aliases (2021-07-14 18:55:28 +0200)

----------------------------------------------------------------
MMC core:
 - Use kref to fix KASAN splats triggered during card removal
 - Don't allocate IDA for OF aliases

----------------------------------------------------------------
Stephen Boyd (2):
      mmc: core: Use kref in place of struct mmc_blk_data::usage
      mmc: core: Don't allocate IDA for OF aliases

 drivers/mmc/core/block.c | 35 +++++++++++++++++++++--------------
 drivers/mmc/core/host.c  | 20 ++++++++++----------
 2 files changed, 31 insertions(+), 24 deletions(-)
