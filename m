Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E1530A5C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhBAKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhBAKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:47:30 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0D9C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:46:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m12so860513pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ruFXwiwnXn9Rl+8FKyESMDvuihlw4v9mH5N8bX6l28=;
        b=ifFluBw4D+ZCxUGPEBUP+9KcdMSEQpjaXVz+DmlEqip7kBqCYZS4u9BX8LGcR0sFig
         YVBYG8mhhyOUjtHwwRVuWoRMch5rjPlPQp7yx5m1of3EmDVM6fpm57CrKRqdCiVARV3F
         Ndk/oNUFiLDR7R0ggWzI0re4nwwLuHDMFGznFsvSLFBckV3Octm91S+kDDe2ivcj8qz5
         KyzPYHPI13p+6Zzjcq8SfTpJKMdgUZQczVcISQoVzHj+Tgw2Z7MmGfCVd9+XvF36DffH
         o8Zd5TPxEyeZ9rujmopQU+MFqKLKjF+VdKEaiKNTAX2wRkUZiu07ihfeUMYffmg6/ene
         CDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ruFXwiwnXn9Rl+8FKyESMDvuihlw4v9mH5N8bX6l28=;
        b=IdjLr2B7vx29ywfeeCCJ/5dH4ieXcti1g94SKp6cEZjzbYEQURJQQdWBEvtLEX9k8t
         FhKctWqqCyLxk4r2QyXNNG18Jqo3kc3MeBE6tG9vofC7iul6XjyYqVYE5TmRFwgz16dc
         wRx7zSDMlw7WPL5AoA1Saq1DmifSiILW302FzVbUza488Ob0q2IYJG2W82b0mGVjTl/y
         zMrF4I22ppw9oxdTmJcM9jMY4at/TqqKb5mzEWBmL+rqevO1NTM+aFbSOldPoJzPElOE
         6OnM0GsYNPO0rPQ23O3VTqOlQBNs+sgd4veUJe12CgUVuI9pAXD+AF4nXKczvvsMuyZS
         OZQw==
X-Gm-Message-State: AOAM532eTGJ3PYjhEDlLzKL/N7Dl457H8b0kzxkTqh78KeU82SgiIHgU
        oMEHREijSaaC7oIdviB/eSxtWe4ZDASP
X-Google-Smtp-Source: ABdhPJzA0Nif1ZdivrANdCliTrGstZW5C4hNO0jxf8xPOLESpfhJOph3oXE0pfxdNklVVRpRkPnRjw==
X-Received: by 2002:a17:90a:74ca:: with SMTP id p10mr16558496pjl.34.1612176409062;
        Mon, 01 Feb 2021 02:46:49 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.179])
        by smtp.gmail.com with ESMTPSA id j3sm15208581pjs.50.2021.02.01.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:46:48 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] mailmap: Add entries for Manivannan Sadhasivam
Date:   Mon,  1 Feb 2021 16:16:40 +0530
Message-Id: <20210201104640.108556-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map my personal and work addresses to korg mail address.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 632700cee55c..785c33fa88d0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -200,6 +200,8 @@ Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
+Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
+Manivannan Sadhasivam <mani@kernel.org> <manivannan.sadhasivam@linaro.org>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Mark Brown <broonie@sirena.org.uk>
-- 
2.25.1

