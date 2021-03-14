Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2999633A2B0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 05:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhCNEp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 23:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhCNEpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 23:45:35 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5DAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 20:45:34 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id x9so6967474qto.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 20:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uoe5TNNaDysbUQasfNAqY0hOSuNv/3CSSDD6bzJQ5fI=;
        b=WRjAdYjdxjs92mVp66j7D7szHl3IbeBRjO+ofLvwzD64sD9QZXZeZ+pSXF8O3MRGbb
         OwveQBhhxwxPv0tAA2vKfzZ+NdQxwrGNwEay93SQFFjGfCfxgh0JMYoFNa4lEQDgAbn9
         pDAqLIHPk9lqkyjQzEHW5mnW8PsX/afur8eptyiKNLL4n48BQ5sgvaCBW84e4zbFUV8h
         nvRV89nzfsIihF9mw2cmPdegTAp4DGB9SRxrG6UNlL1bp9EDUqoVoCdA0TPLs5X5SGP2
         D6YPugWoiJZR0RbsuwQyTSaC3ydtk+eOFv7Jv8QB7vO7mzD4962JS8YuEsGuUNY2/Gzj
         2lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uoe5TNNaDysbUQasfNAqY0hOSuNv/3CSSDD6bzJQ5fI=;
        b=hAG7c5n6FdFHrbmP2s2n1a1ecRYyRRpKpYtKJbI993Dc0XoEKWsqbyIxXTMYodFS0G
         hMqllCZ9lcyzTh/pvd21zWmc0ayEhH6PhbVBbNI+aQ/RUo2/gq1CsKLWNpMORqWXjsIy
         e3ETWJnW33SkD9tyuNr8I7ZIRceB66e2/mLaOnek0HEp0/MJTXHxujDb6qcV/JiXBr7w
         CxA26P6piKD2mdVOBGflNzAPdGabc10d8C+yhcNbonfWoGOq5cfvoykp4eb7y6wtxDk9
         fy12Bopmbff535LQ4oD43kw5XbOTAeaLbx3AAJptCh/+GVSKse6DmTnJM2Ow37h/2oDv
         eAZQ==
X-Gm-Message-State: AOAM532vwZ+L+p/bHT6XDzVijFLEWeb370DXfg3uIPilEGDISg6Okltj
        ZMbn8Jmi8DpqhI5VMPW0zuw=
X-Google-Smtp-Source: ABdhPJy2CqupncRenrFBI7C8/dOxkolIyk5MmQG0y9rTuawAaMe1sJkMeoqec5OQ01ETtylsnBEshQ==
X-Received: by 2002:ac8:149a:: with SMTP id l26mr17763644qtj.210.1615697133669;
        Sat, 13 Mar 2021 20:45:33 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.30])
        by smtp.gmail.com with ESMTPSA id f27sm8005836qkh.118.2021.03.13.20.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 20:45:33 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        chris@chris-wilson.co.uk, tvrtko.ursulin@intel.com,
        mika.kuoppala@linux.intel.com, maarten.lankhorst@linux.intel.com,
        unixbhaskar@gmail.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] gpu: drm: i915: gt: Rudimentary typo fix in the file intel_timeline.c
Date:   Sun, 14 Mar 2021 10:13:03 +0530
Message-Id: <20210314044303.9220-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/bariers/barriers/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_timeline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_timeline.c b/drivers/gpu/drm/i915/gt/intel_timeline.c
index 8015964043eb..2b921c1796dc 100644
--- a/drivers/gpu/drm/i915/gt/intel_timeline.c
+++ b/drivers/gpu/drm/i915/gt/intel_timeline.c
@@ -416,7 +416,7 @@ void intel_timeline_exit(struct intel_timeline *tl)
 	spin_unlock(&timelines->lock);

 	/*
-	 * Since this timeline is idle, all bariers upon which we were waiting
+	 * Since this timeline is idle, all barriers upon which we were waiting
 	 * must also be complete and so we can discard the last used barriers
 	 * without loss of information.
 	 */
--
2.26.2

