Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A605238291F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhEQKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34563 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhEQJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:59:45 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia16-0002QI-Jf
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:28 +0000
Received: by mail-ed1-f69.google.com with SMTP id y19-20020a0564022713b029038a9f36060dso3603125edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0b3HEZyyYOqROIaXqw5EzBGeOsVdqLNAp58PaXSCCW8=;
        b=BXlcIAaUmoCCIcPdKsGf1e3tRHs/mMwvSotq1VE30bYL4cwvX8oENiytTg3WYq2cNQ
         5COQZloYnFI3ZDt7Bj1x5P0dNR8pmi9zW4nCrcGIPwAEFoqqa4K+5wPitiQJCsJ7ABvX
         gqKp5bpTPkaEngXt7e/bpOKI+bbl/nEA8aoGJE1WsgDS+Pi83YWufjNHWaqFReyM6MKK
         zMiGAju3fZsgd/FX9RKyBR6pUeGfMF3cknb5sa8s9vNF5q2p9wBkEE0hbjJ3xYG1hGY6
         FaKlSgMa8aHgM7u8pIozB/WBSnvopnEuHUmjF1udz49Ug/VBFY1VS/fUZv6DezViSL6B
         Y8Qw==
X-Gm-Message-State: AOAM533+QaamFtGlEt6kEBUOhOmIOKXVmEgQVfKUoXzpzZ/HM0fxzm6P
        d02O0TUMMO4t7NDFr7z++2q5Gv5H7JaP8Lwk3hRHP3SMO7lAWEOBgn5ae/lWyilg8Hp/UAon7sm
        WfrtSWnfk2DN67t6Yh7tCeku2Xd1kKA8wlPNfEotbCw==
X-Received: by 2002:aa7:c0c4:: with SMTP id j4mr11731872edp.168.1621245508353;
        Mon, 17 May 2021 02:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHpKlQHhJ0QbyAmWO4ohuhYi0CRqowScNrU2j28P7Bc9LmcK0oA8dWBpd8EAZ+YskFj58KZw==
X-Received: by 2002:aa7:c0c4:: with SMTP id j4mr11731857edp.168.1621245508184;
        Mon, 17 May 2021 02:58:28 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id x10sm10379267edd.30.2021.05.17.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:27 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@prisktech.co.nz, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] ARM: vt8500: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:26 +0200
Message-Id: <20210517095826.81531-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find arch/arm/mach-vt8500 -name 'Kconfig*' | \
    xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mach-vt8500/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index d01cdd9ad9c7..408e405ae568 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -9,9 +9,9 @@ config ARCH_VT8500
 
 config ARCH_WM8505
 	bool "VIA/Wondermedia 85xx and WM8650"
- 	depends on ARCH_MULTI_V5
- 	select ARCH_VT8500
- 	select CPU_ARM926T
+	depends on ARCH_MULTI_V5
+	select ARCH_VT8500
+	select CPU_ARM926T
 
 config ARCH_WM8750
 	bool "WonderMedia WM8750"
-- 
2.27.0

