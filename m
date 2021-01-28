Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1F307D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhA1SKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhA1SFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:05:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C6AC06121F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so3632478wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/DwODThT9yC2p7TIC8q4FOkFeXMx+9HaJ4TFjAbkcM=;
        b=IcehFqxg+qhB/Bt2N/xmvTOQuNtPxLWBYFNOY1uPVKFq6t37B8P6+QnybvCbJfIA0g
         mHUNP7ASctifTUszQvOB+5y7G0oU/eSaeZKeAreNjtBPSzoijZeIitNytsMQ793/pOOS
         l0T0sWha6HXVk5kMRVejg7Z2bHFXa46jLIbiy0rTXPg0nPwTFrRrRDbSIq+2zXlWGmbL
         RWXJHlbHhMfR9Hucr89j3YzuE8r2piliwu92LDTV0LHIpbg1c6KOAlenjcx8HChqLW79
         S5JiOCzAh1OIDpQPJ/npZfS0jnteGMOhfBJ0KpNOtHj5xvkgxYTlExW+zELNTPJ/vYAg
         tS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/DwODThT9yC2p7TIC8q4FOkFeXMx+9HaJ4TFjAbkcM=;
        b=C10cXAcJSqtuF8wxNLwPN3+kiTE41S+UiDVAjqWIOtj5wvDrD29M1fQsPVVRtFhgP/
         EWHHHlBKrL70XkA5oEew29USujB8Afq6p8mJWEMUYvC2eCpERA6jFgi/bjpyoat6jAmX
         YXWdwPPVWqbgG1/4UR7FUtNg6RUSXlLXoUmHaEWvhFwlvNYblFK4hJRFneF0igcDoQL9
         ZiZJF0tETvOUrrJ6cqQYPTZ93JAPnecZ6zW/mmNP4zqn09XhHLDExNG27WEmAzOk2g07
         TSVaLS9mOFhrsahWfBQoh2pJNXKNxsaJzDHhiDMzwaJzlXsrlDCaj2w0Ok6qTK5SDJDp
         2Qaw==
X-Gm-Message-State: AOAM533VOT54IEtbsEBdg4cmCoKSd9gWBE/I+HEmIR/1Ga+40oB1bnGu
        McIhbuwYxmLznBuN4Fzp/Jx6oA==
X-Google-Smtp-Source: ABdhPJxVOhutxcNoDQUOFr31hXwp4y4YTk/hM1DXXDnAs/FBnB2x/NCn3+pnA2qCqgH/1pK5aeCmXg==
X-Received: by 2002:adf:b64f:: with SMTP id i15mr244663wre.279.1611856975325;
        Thu, 28 Jan 2021 10:02:55 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 10/20] ata: ahci_ceva: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:29 +0000
Message-Id: <20210128180239.548512-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ATA drivers use the SCSI host template, a series of interwoven
macros, to aid with initialisation.  Some of these macros conflict,
resulting in the over-writing of previously set values.

This is known behaviour and can be safely ignored.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/ata/ahci_ceva.c:15:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
 drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
 drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/sata_sil24.c:378:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_sil24.c:378:16: note: (near initialization for ‘sil24_sht.can_queue’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 4542f101042ac..c7460c6b94c1d 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_acard-ahci.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
-- 
2.25.1

