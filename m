Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED184071A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhIJTFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhIJTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:05:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA91C061756;
        Fri, 10 Sep 2021 12:03:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m9so4038072wrb.1;
        Fri, 10 Sep 2021 12:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXevfslZuYBVfagltpQRsoEe64TrqKR3SYZSkmxiNRI=;
        b=lCIqFvZwSN+DNqD410N9Zrf203q9a9c12M25Jit2InUObJooZ0K1+AsYKwb9E4P/pd
         HR9r2aB2yFSSGJLdf/aJwHo76xpuqlSY818/cnomgdiIEg7IZkRMb4NcFG2hnRs1IxRk
         yyfBzd8bCmqC0yXhPaixK5ORcgUDvIDi5z4XpjAkdwXCU64NpW7iMEH7NIOmeQ1c8VYQ
         KrpF9dEZS6JFMHUZHt3vh89fh2aF30CqER2S7yoN7HEY5GhoVAE9/lFP6D7/giqY1tpR
         EyBVBJL9uBepI5q/WRZtjaZ8hlA0zqA4YD6VjxCAJ3ykuOTorkE9iYVkoi+lgkGWLBBs
         A9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXevfslZuYBVfagltpQRsoEe64TrqKR3SYZSkmxiNRI=;
        b=4nVpJdxGsjMD1UaMH6dwcWXr7WE/V96Wl2ku92XG1hFTeeLxN92QArIEHY6ioITrgL
         43wOXwiLE/gK1/2mONVgNIpL93EEqh+W3c/LqNENwOb1cXJfdyB4IjRN+NScBCpO6cdp
         OBicNYIyzYSwWG2qn/f5y/9Rp45LNRKYvnBVdfxJ91sw5F+Jt3Xjff6Ac5GG+/wPUt1r
         eHth+EAWPmpnbXYfoYTb6Oymv8+ma5+7u1A7whxo1Ip9QrVKlMb0Mt/SukRX53eQxcac
         VdCGI9ejbegU4r628FmjEjZqaY+uRgaPohYj/ZQuzi38qp2TDZQPQ3by7TZc2rVlKCID
         je/Q==
X-Gm-Message-State: AOAM530zCBCznBrz2Nu/68Bv4ecmzgReT7yw1y7N6zAisE7VgRBJ+l6L
        zQ9MFWuHyOvyVuszAEOaqEGi+FEUfZU=
X-Google-Smtp-Source: ABdhPJwhaTrECPI7JhVVNrpKyE4W+cRTf2a/tG92fHbQUb8KyGNNWgUi0uiIU71pYg4bp/XTO7ckFQ==
X-Received: by 2002:a5d:528b:: with SMTP id c11mr11159838wrv.369.1631300627378;
        Fri, 10 Sep 2021 12:03:47 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l124sm4986620wml.8.2021.09.10.12.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:03:46 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add myself as MStar/Sigmastar Armv7 SoC maintainers
Date:   Fri, 10 Sep 2021 21:03:22 +0200
Message-Id: <20210910190322.27058-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910190322.27058-1-romain.perier@gmail.com>
References: <20210910190322.27058-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As proposed by Daniel, I am going to help him to maintain the platform,
so add myself as co-maintainer.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a9a7cbf9456..ad1a0e5a5425 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2231,6 +2231,7 @@ F:	arch/arm/mach-pxa/mioa701.c
 
 ARM/MStar/Sigmastar Armv7 SoC support
 M:	Daniel Palmer <daniel@thingy.jp>
+M:	Romain Perier <romain.perier@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
-- 
2.33.0

