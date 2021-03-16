Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7872E33CEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhCPH47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:56:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37574 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhCPH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:56:32 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lM4Z5-0006SM-AH
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 07:56:31 +0000
Received: by mail-ed1-f72.google.com with SMTP id a26so10194393edt.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jeu86JaIUAOt2lkwOFI4m9LQf3S54ODIpa4kLZOARnM=;
        b=IH9BeXkmGEfd2CDYpB6n28MHJ4T5qfQO/w4lb0q5ffGi6BvNvREpMryk+1MhyfrSPw
         2bERASN1N6cF05N1YcyrEnm2dWxgDgFKPp/51DJHB/UtY66/GWwRRKy+Q8dOkZFKuYHr
         O+sFwgY5Wlak0GrDNGW/IFCAB6Qmv6sbrM7lsDaMOLqGjSG+82FvU+0Ls97YOPW5vKOh
         /tB73V/rmXajV4L2qpb9KxZrsZ+9QWStzbjgl3ceuu//lrXR/dsqtXRGTxvubNkK8Kre
         3jiigXYi2cbupTJZjlGZF0Om10Y+nsAT8GnNM4e7vgvmU0bUdurzUZYTNAl1sFZ8aUcw
         xdlw==
X-Gm-Message-State: AOAM533QRqVKVka4ae/nUSUVUjFKUhS6/3U/WL8jCmNR20Y9RafeT0wc
        dXZ7qeEQ6twM/1I2PODOV80anRhQQU9WXEO5h0iuSV8c2fuera4Iu89O3kd5xb6uMnGsz/zWJYn
        exEU6oP47PfV8vJIuF6jBFjFH782QWlWyvNwQGoqvQg==
X-Received: by 2002:a17:906:1b42:: with SMTP id p2mr28178012ejg.236.1615881391094;
        Tue, 16 Mar 2021 00:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSDWwhSMlE00SSQ6Q68j5cirvJIl8Apo64mYMNnE60g83O/scEiUPyZS5hkkQ+6/Z3THDjqA==
X-Received: by 2002:a17:906:1b42:: with SMTP id p2mr28178003ejg.236.1615881390996;
        Tue, 16 Mar 2021 00:56:30 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id r5sm9725026eds.49.2021.03.16.00.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 00:56:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH RESEND] media: atomisp: do not select COMMON_CLK to fix builds
Date:   Tue, 16 Mar 2021 08:56:25 +0100
Message-Id: <20210316075625.10382-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

COMMON_CLK is a user-selectable option with its own dependencies.  The
most important dependency is !HAVE_LEGACY_CLK.  User-selectable drivers
should not select COMMON_CLK because they will create a dependency cycle
and build failures.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/staging/media/atomisp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
index 37577bb72998..742edb261d85 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -2,9 +2,9 @@
 menuconfig INTEL_ATOMISP
 	bool "Enable support to Intel Atom ISP camera drivers"
 	depends on X86 && EFI && PCI && ACPI
+	depends on COMMON_CLK
 	select IOSF_MBI
 	select MEDIA_CONTROLLER
-	select COMMON_CLK
 	help
 	  Enable support for the Intel ISP2 camera interfaces and MIPI
 	  sensor drivers.
-- 
2.25.1

