Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94E038292D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhEQKAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34607 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhEQKAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:00:03 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1O-0002UN-LH
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:46 +0000
Received: by mail-ed1-f71.google.com with SMTP id x3-20020a50ba830000b029038caed0dd2eso3612440ede.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aryvr0WgEo8bWNtAfbtzLN/J7xGo1WAIW/73w16ITWM=;
        b=EKXw6PS+d3NvIIKKtWCNNAie6e+2uxWhqgEDmukr0nT/YPeASKnQh+fyxtfTQmH6LR
         AXInVDZbA+95nYISz5zkXgYqYbj7SC6yeWphyRw2qj/EbrfJ9cwYIBuXxoTXE97Z7A08
         GC3yRZxm7hZlk9k+e4Ozdor/tDQdO86/2G6J3Ty1+Ry4qa5tEidWl9oDB2Yd3RIPG3dy
         ydwpkCj9NLuShogr4FDwGre08DX5S2mIQGOVBlqnKq+lJ3GRdHrCfznBBXBfcjymDMur
         gh2OtOsCzJVRzc47m60A6n2Fxa2Q/q1lyy1BA0lVvJGB4uTydTswwpIyuRjgVk+W4idW
         4HZg==
X-Gm-Message-State: AOAM531Ve8Ie2SE2PoAXcFG9rxD3vTIcpAxy7XAbbpl3Nfw++hNvuGy0
        5Y4u7rYAAb3oBin60CdCUCOdE23iQRhuEimX1+w73JmYTAYS+o2OHOMhA2N7ww73X86CJRLnR+v
        690XzbihQctAC4k2/IEEWC0ij7g8kqyNSV8RW/BYQww==
X-Received: by 2002:a17:906:a1c7:: with SMTP id bx7mr23860519ejb.401.1621245526444;
        Mon, 17 May 2021 02:58:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWAvdSu8sV+io+MPCQIcSCODXnTmxxY+ztqvBezIuW5+E34H+F4Z8F9CqiVahvXi//qqJNQg==
X-Received: by 2002:a17:906:a1c7:: with SMTP id bx7mr23860506ejb.401.1621245526290;
        Mon, 17 May 2021 02:58:46 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y25sm1920565edq.75.2021.05.17.02.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:46 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] w1: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:44 +0200
Message-Id: <20210517095844.81933-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find drivers/w1 -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/w1/masters/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 24b9a8e05f64..32e993ea6f96 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -17,12 +17,12 @@ config W1_MASTER_MATROX
 
 config W1_MASTER_DS2490
 	tristate "DS2490 USB <-> W1 transport layer for 1-wire"
-  	depends on USB
-  	help
+	depends on USB
+	help
 	  Say Y here if you want to have a driver for DS2490 based USB <-> W1 bridges,
 	  for example DS9490*.
 
-  	  This support is also available as a module.  If so, the module
+	  This support is also available as a module.  If so, the module
 	  will be called ds2490.
 
 config W1_MASTER_DS2482
-- 
2.27.0

