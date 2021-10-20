Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D038434B03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhJTMTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhJTMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:19:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867C4C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:16:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m42so18490986wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7l9tEWjt9gALSo8nOYC6O9qSCG4oZkj1aRklRrycs50=;
        b=Fof2wvLGAKuIiW29+HHTWkLBFPW4iXCrhlQcaqttB6SQa3lgfpCzV2PUgY6BxqCGd/
         81ZfSzgngwpaPkKKokZKksjkmp+YaR08flLXgEBJr+1PdDbgMxJjTMtbOYjxo29tKqN7
         N26u9u4H9pi+homsuL4cFUTLkK/Guo4a2PSuHmGvj5XS/LAU8X1VOdfrvxPwO0R1TdMr
         mr75QyGkejwiI9TdDBiRXCYB5zcDK2MZpxSg8ay2PJsxBkqW+9WsnL2ko4wwUYz6zPFv
         oII9yKXIDMoC/MdwoMhnQt/0FLSKkU9hspm4+Z795VtB1kRWUJcglAhy9slVHH8hUziG
         NHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7l9tEWjt9gALSo8nOYC6O9qSCG4oZkj1aRklRrycs50=;
        b=07OjJK6RqNS0FGpPAV4WLq8lDm1+4Xmp90i6Xna5tWkvmq2YnTEBU44zbU4aZd0chk
         SGVMnPHfmSlppU0QZyIfC5HOE/BcENjQ5h1hLH2SZutQUyXekfaAo7p4BxUl7psUkLCb
         x1S6vU7oudafWjOCQFppR/ka8IxIWFzVAkB5X1jYYdRgJeqU2NnVaai3kSVm9HLYZ4eU
         jCfHXuWFNJ7VirYJzchxm/7DbD8D49cD9Y5BZvx+xCEyVMDqTvb05yzt/sQrhK4y2Ejx
         P2JEUD6ukJrKKXOS8vvKWHQl27LGz9n9A+6w5TMRvBxWKzQUrSWPWPlFUpMPL6eEkb+g
         c/nw==
X-Gm-Message-State: AOAM530Z2TNZTbsaHG2iiw90ZuJGIIskdHilJi9KXA/z1RGQumnSaXvH
        epHTHufwgjv/s+FWR/1daAvd3DWJKggKOGo1Blw=
X-Google-Smtp-Source: ABdhPJwzjJQEVCqWc6084GfyiSimLpaX5n6bziJNORcmiw+BzY2n9QG9kfvkvwttu+N8oAfXjE4RtA==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr12745984wmi.103.1634732211178;
        Wed, 20 Oct 2021 05:16:51 -0700 (PDT)
Received: from localhost.localdomain ([5.35.48.193])
        by smtp.gmail.com with ESMTPSA id g25sm1889491wrc.88.2021.10.20.05.16.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:16:50 -0700 (PDT)
From:   Denis Kirjanov <kda@linux-powerpc.org>
To:     openrisc@lists.librecores.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: signal: remove unused DEBUG_SIG macro
Date:   Wed, 20 Oct 2021 15:16:37 +0300
Message-Id: <20211020121637.6629-1-kda@linux-powerpc.org>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/openrisc/kernel/signal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 1ebcff271096..99516c9191c7 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -28,8 +28,6 @@
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
 
-#define DEBUG_SIG 0
-
 struct rt_sigframe {
 	struct siginfo info;
 	struct ucontext uc;
-- 
2.16.4

