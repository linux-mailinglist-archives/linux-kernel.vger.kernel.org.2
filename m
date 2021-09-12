Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF7407D6B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhILNAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhILNAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 09:00:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 05:59:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v19so1740330pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gziWymGKd/N4XqAzL2X7+DQr7Q04RE8infD/f3Yvzzc=;
        b=t60ZqyoRrIwm9pu++xVzotaT7SDxxeGnrvwXGIlQFrQF/R8kty4mAQXqalHm5oPtYT
         2zWzj7sTMkRbhGK5yjm3QbpC+/r5qk+e1wuFRaCHd1/iNyyc1JY30ERbRNM40YyrXXqp
         eZg2+Khl+TFMgUF65TmwWz2MxAJwQqkudRTjFCev+HmIma2EKCuZeMt8RIVEv21pihSa
         iV3tZ9g1GSzhNol629hEVE9NzmCo0h0BK8MfoY8WzWTwJI7ymtO2ibsrtSCx6XZR+V6D
         VdLZibP64J1chv6aRlIoJmUUJw23BH/w6qBITGxWzCB0RTyqCrVpNbamUDbjSHeaDXfY
         vSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gziWymGKd/N4XqAzL2X7+DQr7Q04RE8infD/f3Yvzzc=;
        b=CCYnInFEEUWHSEOWeW3LepJLZ1P07Tkbmg+u3HopKTIaCuFEnzpHZPYh5w/LWslr7i
         xazKrR4FnfhOXGC8YBJ4A6YT2/aGlTZV5LTktDJ61coJhV9iPUfBomQdU63muCECJ+ph
         G/LVKYQqtNJWf2p6ivQ8nqSgKZuFYd/eBYZBsloeQ8YTmW2eiZGTpuQFBIX+Ek00ht5P
         Fn3vPn5oypn3PEqpxp7LX089pLkXJN+niFny3qkzqfeVtSiJ9LhfbDaFK+Oe31FsrBkG
         gAsmeNzsFO2rrG3dqxpGwf89z1NmqU3Eh8lM7pentt0wbZnPGPYxATJ8dfxuAQc+qVOZ
         DVNg==
X-Gm-Message-State: AOAM530HKnRIZtumGbUR8oEtvDhlz51oHv7I7sMe87MbRCauJYju10Vi
        iqrqKs70WsE5WOnQ1sjImqquYg==
X-Google-Smtp-Source: ABdhPJzSftAsePNgPtVUw+6bOeeX+WkMUVMEGjLi5EJHKFKX/eCW6wQ7Jkz/4CYWfjhP0Js49l15xw==
X-Received: by 2002:a17:902:d202:b0:13a:709b:dfb0 with SMTP id t2-20020a170902d20200b0013a709bdfb0mr6146219ply.34.1631451572560;
        Sun, 12 Sep 2021 05:59:32 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id e11sm4120094pfn.49.2021.09.12.05.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 05:59:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/2] coresight: Fix for snapshot mode
Date:   Sun, 12 Sep 2021 20:57:46 +0800
Message-Id: <20210912125748.2816606-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the snapshot mode in the CoreSight driver.

The first patch simplifies the head pointer handling for AUX buffer, the
second patch updates the driver comments to reflect the latest status
for perf tool.

Changes from v3:
- Made the comments generic in CoreSight drivers (Suzuki).

Changes from v2:
- Minor improvement the commits for patches 01 and 02.


Leo Yan (2):
  coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
  coresight: Update comments for removing cs_etm_find_snapshot()

 drivers/hwtracing/coresight/coresight-etb10.c   |  5 ++---
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  5 ++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 15 +++++----------
 3 files changed, 9 insertions(+), 16 deletions(-)

-- 
2.25.1

