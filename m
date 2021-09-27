Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C628041924F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhI0KkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:40:01 -0400
Received: from egress-ip4a.ess.de.barracuda.com ([18.184.203.227]:41370 "EHLO
        egress-ip4a.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233819AbhI0KkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:40:00 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197]) by mx-outbound12-93.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 27 Sep 2021 10:38:19 +0000
Received: by mail-pf1-f197.google.com with SMTP id l201-20020a6288d2000000b0044b825184a9so2786636pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p76vO38lP42vKSvVTlZjl6ogRnpGJnVTAURe7DbLNkY=;
        b=J9t1M0Y3lar2Zm0toksTFZlqMFRNIYO+HUJ/JJNwyImt1r4B64TWR8Pz5IQzZW4m0L
         VcqU1jCTWxdjlzLiQq+9O8ItLkayX+mB+trs3PetHBUZdTq2WRsRXqGcetO3vkxMAf+i
         eR0FoEst0NY0+To6v3t0lVfhb8x9vKXtpU01Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p76vO38lP42vKSvVTlZjl6ogRnpGJnVTAURe7DbLNkY=;
        b=sIIXhRp611fyNOFyEu+4qVTxJMnX/W7YjtNSppUUVdu2Z9lBEH5zcT4BQ3838Ub2zR
         mYKuA6ZT4rpIqNtim/epQmOpm/ONgSXzd+RP4mr3yhBnxpX38svvRyhlQFIZhkmztztk
         m5oAYlYSUAU2rXmuL3M1rkKIgiuJf7V5tOv9NbW3OhkLa2p9VCX50LOWR2PcFsnvqDeF
         w2GjBSXApyBH9XYx5SK8+NwNuHD0HC2LRlLYle7PQN5I5/5lg7VK9XiXZbazwhP7JKpm
         hhv5WhzbiNzbPBPpYc59AfLRobPFD1kPVO+zisGPYet3goqp8Y6PDy+lLpIfspuZyXoy
         3DFA==
X-Gm-Message-State: AOAM53221EYkX6VfMfvi4CyHDSmRJUWTa4qrcnOc4vuyjJ8CvuW1U9J0
        kGo4Iu/HZxUYumdoo1Wpvy1YdNOP2FUQcwZbrE78kRhaiLKs6jaOsSwHo4WmEi5SaJxU+s1x/TM
        wkZ2dH0Q437TpRK3nfkfLSGCXH7aBg84s2bnDkirRPZiMhHrDw6hhAGuwrSsX
X-Received: by 2002:a63:4464:: with SMTP id t36mr15950963pgk.4.1632739098417;
        Mon, 27 Sep 2021 03:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPvl9zDSO8xOMaDvu7fZO/wrBNF6HH9FdoyajHTFW7U9Lihp4AqMlhBOHiinSjGPKUQ8/LRg==
X-Received: by 2002:a63:4464:: with SMTP id t36mr15950947pgk.4.1632739098139;
        Mon, 27 Sep 2021 03:38:18 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id t68sm18030894pgc.59.2021.09.27.03.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 03:38:17 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 0/2] dt-bindings: remoteproc: k3-r5f|dsp: Remove
Date:   Mon, 27 Sep 2021 16:08:09 +0530
Message-Id: <20210927103811.11222-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1632739098-303165-5388-277-1
X-BESS-VER: 2019.1_20210921.2035
X-BESS-Apparent-Source-IP: 209.85.210.197
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234758 [from 
        cloudscan10-245.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.20 PR0N_SUBJECT           META: Subject has letters around special characters (pr0n) 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO, PR0N_SUBJECT
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
The series of patches are meant to help make the rproc bindings for K3
r5f and dsp support independent of board/platform involved.

Changes in V4:
Addressed review comments:
- Removed Fixes tags from the commit descriptions.
- Updated subject and commit description to emphasis on cleaning up of the 
  example to address the dt_binding_check warnings.


V3: https://lore.kernel.org/all/20210917095426.19277-1-sinthu.raja@ti.com/
V2: https://lore.kernel.org/all/20210818074030.1877-1-sinthu.raja@ti.com/
V1: https://lore.kernel.org/all/20210817152005.21575-1-sinthu.raja@ti.com/

Sinthu Raja (2):
  dt-bindings: remoteproc: k3-r5f: Cleanup SoC compatible from DT
    example
  dt-bindings: remoteproc: k3-dsp: Cleanup SoC compatible from DT
    example

 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml       | 4 +---
 .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml       | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.31.1

