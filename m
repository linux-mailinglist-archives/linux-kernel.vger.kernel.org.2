Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0E310733
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBEI4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBEI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:56:01 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378ABC0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 00:55:21 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id n14so3083456qvg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bS51Y5GgIZxFE8AHZkRM84LTb51L6P7vtBQy/c+YWPg=;
        b=cWhxe+4l7p3KaN5Cqf2fa9PrvYtd84dtoGndXWOtG6dYYyjzUsYknGLJsyWl8kGibZ
         /LES6HHhgs4+O0o9FNScU/dXxIv3Kp+G4DWWh1SyIc+Ffq0hlpxEHKRpAzLsSI+NXHE3
         IKmTGsoWR8UDH4gF2IxTQtaz0YHv484HPcqAq0APjJMpXpqcpEpR0AWnwIxBlPsr4vu+
         0VXLbMI0Vr6KxOI8NvpN9+TBHgnX2sna01S2HWkPFgV4zVL9Dl78XUM/I3B1qFmUq6qL
         a3fJEtAVwj1PTDuAqHd51W7WgnQnbwgOgSmj1Yl0zfOEMkqnhBDRR+THLbo4mi+CRtL2
         aUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bS51Y5GgIZxFE8AHZkRM84LTb51L6P7vtBQy/c+YWPg=;
        b=uaOnoFdW9AL/NMpQ6Yh92Sosvc1tmIWoDrex6ZwQ3kNhtrEfsJ5ENtjsEo8KX+rhAl
         9w7hfqhZ2hBvxP/VxVfQXFD8+TbFgOBO9W2Z6tYaaVhzW8eiSZLvXpnrAR8NrNr+Oj90
         tn37OWwPUf/uFfzswlDUjWAyQv6BijfcXZw/NF3km8meHsdO5aBKju1AdGhAAhqDs1US
         7Um1tJQ2IYzxDknns3YBc7MngxY45dmrXJxUOzPcPClGJiQHO0fu6dXqom9ef9tOwQxh
         LyVlyWbtDR8OLm0GBQK4TquWqSktZlZ/HsaPPMQbhi/6DJaiw32Mcjde/8kIOLnyEYvS
         5Mng==
X-Gm-Message-State: AOAM5321jl6MNRyU8YBDUor5K/wjQPU5J5+ZX0NShozPHt8hazuCAxp5
        7+EiTof1B8Sevhpm/UuSueQ=
X-Google-Smtp-Source: ABdhPJyLSHZ47N7CC/Ehkhwo84TbX2jkQOTbsOHGFgE0x290AVxonFEGfTZvIlYYmdtuXFeTe4irRA==
X-Received: by 2002:ad4:4348:: with SMTP id q8mr3471455qvs.36.1612515320529;
        Fri, 05 Feb 2021 00:55:20 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.157])
        by smtp.gmail.com with ESMTPSA id t17sm7246145qtq.57.2021.02.05.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 00:55:19 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: mfd: Spelling fixes in the file max77620.c
Date:   Fri,  5 Feb 2021 14:24:56 +0530
Message-Id: <20210205085456.369049-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/Teminology/Terminology/
s/confguration/configuration/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/mfd/max77620.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index fec2096474ad..429f7fbe92bc 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -10,7 +10,7 @@
  *	Mallikarjun Kasoju <mkasoju@nvidia.com>
  */

-/****************** Teminology used in driver ********************
+/****************** Terminology used in driver ********************
  * Here are some terminology used from datasheet for quick reference:
  * Flexible Power Sequence (FPS):
  * The Flexible Power Sequencer (FPS) allows each regulator to power up under
@@ -20,7 +20,7 @@
  * be programmed to be part of a sequence allowing external regulators to be
  * sequenced along with internal regulators. 32KHz clock can be programmed to
  * be part of a sequence.
- * There is 3 FPS confguration registers and all resources are configured to
+ * There is 3 FPS configuration registers and all resources are configured to
  * any of these FPS or no FPS.
  */

--
2.30.0

