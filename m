Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A33B559C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhF0Wmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 18:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhF0Wmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 18:42:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2F0C061574;
        Sun, 27 Jun 2021 15:40:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h2so22699224edt.3;
        Sun, 27 Jun 2021 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slZufKqFz802FONUtf3n7bSuBW3tmbUsPHVs2VZ3Gpo=;
        b=SazL/ovzGjBiHJSJupDWYJeQNxRVlPb5+n/A+KqsCEeC5RJETZVjm/4mgLrooh9Lis
         8K8Bj+EQ+YWkSwlZRGAYlEPLSfjgfQvCujONP/rFvbRb6skQc5pNX20RXLQLd09kinKc
         FVNjy69epxNbFTa7fmIdnEsRe/b+tnzHilil8qeSGBsTCshAZvc+nbCcxzvLKDQtyjSS
         xmkEIUHgSUh3+QSCoJyV3GONRvWIsDjNFqoMlqGcjSsl2TJFH4Udej3WFde02aC2ZfFX
         /Bo8yh1ofynHaIhLRYQ4WQlKDYTctK9epnsYJYUY0ye89Mfn+MGMTKpexXGmYf6dRSsN
         punA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slZufKqFz802FONUtf3n7bSuBW3tmbUsPHVs2VZ3Gpo=;
        b=Nkp4Qa9aGYf0EtavM+r3d5csuHI/hjkw71up1esdNMCsI58GZd3oBIP10+3uviyaXI
         jIfdStCi951OYX+HWoqM1y8Q1NG+HvuGpako9oD4IOfQ0W7SCLWWkzckWTBrSx0u9uGz
         NyrLQaFUqK5wzfYeHs0ZM9baJq1xbvEvkAr1unqOcgJcOJoxVUNHsuDVxHLflqPZX9hm
         cArJmsMppA5/m2z5vCn6rtmHRwyLnodpw8HPX4uAxV/fvW2FGwsOqHEd4qL4nrEhTO3x
         JyYExwHty5F2pRg0zIx1VajyAnJKOsUmPE9xDj5pUPDpb3/IjXrztVjCOCXhjKBiPCKN
         Facg==
X-Gm-Message-State: AOAM533oowyodO4/5gFJmwxBxFJyjim5YsbD4n6QglLu+iskICNvlPCj
        a9706uTXCm5MZtrdJnMGgs8=
X-Google-Smtp-Source: ABdhPJzt1v9sSB4xUUvLiesCnMrJogU+eJY3qTDriqZKqVfH0fvh3LB3+vQc4Emf2P62YNJ38JVMWA==
X-Received: by 2002:aa7:d554:: with SMTP id u20mr4057983edr.50.1624833617828;
        Sun, 27 Jun 2021 15:40:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-bd64-8b00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:bd64:8b00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id jz27sm6048861ejc.33.2021.06.27.15.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 15:40:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/3] clk: meson: rounding for fast clocks on 32-bit SoCs
Date:   Mon, 28 Jun 2021 00:39:56 +0200
Message-Id: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the 32-bit Amlogic Meson8/8b/8m2 SoCs we run into a problem with the
fast HDMI PLL and it's OD (post-dividers). This clock tree can run at
up to approx. 3GHz.
This however causes a problem, because these rates require BIT(31) to
be usable. Unfortunately this is not the case with clk_ops.round_rate
on 32-bit systems. BIT(31) is reserved for the sign (+ or -).

clk_ops.determine_rate does not suffer from this limitation. It uses
an int to signal any errors and can then take all available 32 bits for
the clock rate.

Changes since v1 from [0]:
- reworked the first patch so the the existing
  divider_{ro_}round_rate_parent implementations are using the new
  divider_{ro_}determine_rate implementations to avoid code duplication
  (thanks Jerome for the suggestion)
- added a patch to switch the default clk_divider_{ro_}ops to use
  .determine_rate instead of .round_rate as suggested by Jerome
  (thanks)
- dropped a patch for the Meson PLL ops as these are independent from
  the divider patches and Jerome has applied that one directly (thanks)
- added Jerome's Reviewed-by to the meson clk-regmap patch (thanks!)
- dropped the RFC prefix

Changes since v2 from [1]:
- Added Jerome's Reviewed-by to patches 1 and 2 (thank you!)
- fixed typo in the cover letter (availble -> available)


[0] https://patchwork.kernel.org/project/linux-clk/cover/20210517203724.1006254-1-martin.blumenstingl@googlemail.com/
[1] https://patchwork.kernel.org/project/linux-clk/cover/20210524103733.554878-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (3):
  clk: divider: Add re-usable determine_rate implementations
  clk: divider: Switch from .round_rate to .determine_rate by default
  clk: meson: regmap: switch to determine_rate for the dividers

 drivers/clk/clk-divider.c      | 93 +++++++++++++++++++++++++---------
 drivers/clk/meson/clk-regmap.c | 19 ++++---
 include/linux/clk-provider.h   |  6 +++
 3 files changed, 85 insertions(+), 33 deletions(-)

-- 
2.32.0

