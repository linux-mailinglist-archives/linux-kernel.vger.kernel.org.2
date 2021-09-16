Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE440E5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351223AbhIPRPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:15:19 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59414
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348302AbhIPRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:08:32 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3104D402D0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811923;
        bh=G5XLzRNzE6Anf6+jGBSbUrQ+OGTKc6EmRKiKobcBIgk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Df0He+fGAGSLWwbO0QbLp/nO9+qsKNxxaE/+g6SOUFOrq5Q6JoHfwgkTkj+Ww87pK
         SQ8ftNeBT/dTLcVUM10D22znGQiexDhhB7ZRNHIdlVwK/feIoV6lxux36pxtgrdRAW
         EAsF+goocpH+vOI4DDwaTimeS6Oa83E14k+DjGVjwoNbMjvr1GFJNIKospgMIMW/ZV
         FCZj4nWtIJ7n1iA5dnDUEG6lPdwmVhi41EzxyosPNWzAwQQiopNAGS2fiHZzGVSEFp
         GjL35EDGZcedEd07U5nkfR8BKTdfKuAU9UVS1lozX8k2Tx6hzGRmQZuVPYhsZmxj0H
         F91NYx+tY4m/A==
Received: by mail-wr1-f72.google.com with SMTP id s13-20020a5d69cd000000b00159d49442cbso2683916wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5XLzRNzE6Anf6+jGBSbUrQ+OGTKc6EmRKiKobcBIgk=;
        b=wjM0zLMAgn6ixhnyByW8ep2Tv2uusKy1GOQGEKwT2r7CdEQGR50WTsjgA9n/WyNkTm
         CBzQQrxcAkoQ1J1D4HA2p4I1w0ZJU3TPmfY8yeGsNSYbwpqxsGZHBnwa4s1Ub6RfiiIQ
         +iF59Aujnp8v1ZxNFCGbyS40JbcMI5WhBujVVJROZw9HJDKnO46UOH4+EKLwxhuVIdTn
         O6MjMV/FGr6yNaLykEa+GgZCj4ewHVdWuBnv+selUZiFenFowGu7J+UhDPc/+nuhXX1Z
         k9uwgtfHglHQ3nOFoRjTVXB5mDhWbRIde9exjX+tDee2DRwrEiB2s/9rzCxoucrRAbRS
         jwbg==
X-Gm-Message-State: AOAM530tAXjiD0waGJnJDDemLZLHsb5CEi2O56hd/18LZdAGbsXOjVpH
        30wAl3zOh5z0ZiEyG+abz/1lIJcP1dzOhK9EhTDB8NowLkx5vSq4DScWHuTNtGPOXY1A2dmjQig
        D80kV1yokOuB5sQIRtfLlY4a7tfIDgtxA7f4/KRelwA==
X-Received: by 2002:a05:600c:2281:: with SMTP id 1mr6032275wmf.164.1631811922648;
        Thu, 16 Sep 2021 10:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCja6HX8P4A49WxgOb6Z3yAX4QBJSx9DhE2B/5EXTQQQ9K2cb1KDQ849/FD0ejwCXzxV4ZWA==
X-Received: by 2002:a05:600c:2281:: with SMTP id 1mr6032253wmf.164.1631811922471;
        Thu, 16 Sep 2021 10:05:22 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d7sm4134544wrf.3.2021.09.16.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/armada: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:05:20 +0200
Message-Id: <20210916170520.138093-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/gpu/drm/armada/armada_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 8e3e98f13db4..d45d49b290a8 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -293,4 +293,3 @@ module_exit(armada_drm_exit);
 MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
 MODULE_DESCRIPTION("Armada DRM Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:armada-drm");
-- 
2.30.2

