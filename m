Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3DE3439FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCVGvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCVGvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:51:08 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E8CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:51:08 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y5so7995605qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ng4QK2W9WiNBsUJfqoNFrl5fepUbDbeAq/WthmkCVkQ=;
        b=Q1J7T3rGk9TL04wcFRX95DZH+Z4yA8x0wfxg69rFs+BPiDSKGbISiZJQatr41YZc/q
         fV7psnj5dX8PtgIunvGYDHnLeEUEdX4T4jQSGfU1W79VhrN2eGmEkXrzeOaTDR1kXT1X
         AOwHuB+CKr8Uqj9HmWcqYN514mDT3tgNq2ca8ofSnyZ4Jh/YFKMIkIlH2F3lc5Bsk2XK
         Ex7d/HD2zsrXSNvBFGc4U2MKeR2nfRGgCgjYYQZIW/tcMICe+KvmCz9yXtXiFh3EfOT1
         uGsyUHKD+fSBIEvCRwsy0+0FBmACKT/aIEJylD1prv5sOfpi/LfAevHV/n/IDSLUdiTw
         dD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ng4QK2W9WiNBsUJfqoNFrl5fepUbDbeAq/WthmkCVkQ=;
        b=hUD279NVIOJSAI2//px7pgG1zOQE/ujKKjfVxw4sEoyoqFq1FwXh/i0f8WvF4Mglgs
         WKxeRc4qjPBo8xQ1SGgesl+mQpuERlxYkuJrjomTMVzg3LFdqT6UfSzIrM3QgKo1aTej
         A71xoWgTsihucBR1qUe7q6BtF3Prl+w12xrqXKDr0HloNTmEYhryo9tLkYi+tiCwbBav
         vKpX9bLSztQBoFWszBMaXZPrmrCCckZkUAPIZq4oZL+ova5b1Akf53P9WnpdlhrEEJ1I
         i7XPF7dYY7cjFh88vCkswYNGrGBwu7MVB4FUL0U+YbQXRGpxOzIhpOysPNitsRnnr6vD
         0zgg==
X-Gm-Message-State: AOAM532WZwfVglev7mU4Pn4O2MwviPsyx7BNfSUiQb90d3gFp72dIYSE
        PhUnAYJWsnfyWpgun2s5Q3A=
X-Google-Smtp-Source: ABdhPJw0ScfH0xpTyAvRN6k4dC0WByFlK23impzGOK8akmGEwIgcP4P+RfTlkXJ4KIPOoHiRMwRZyA==
X-Received: by 2002:a05:620a:2108:: with SMTP id l8mr9496087qkl.474.1616395867679;
        Sun, 21 Mar 2021 23:51:07 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
        by smtp.gmail.com with ESMTPSA id e3sm8547210qtj.28.2021.03.21.23.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:51:07 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        andriy.shevchenko@linux.intel.com, unixbhaskar@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ASoC: Intel: Fix a typo
Date:   Mon, 22 Mar 2021 12:20:53 +0530
Message-Id: <20210322065053.74022-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/struture/structure/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/soc/intel/atom/sst/sst.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 4d37d39fd8f4..978bf4255888 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -344,7 +344,7 @@ struct sst_fw_save {
  * @block_lock : spin lock to add block to block_list and assign pvt_id
  * @rx_msg_lock : spin lock to handle the rx messages from the DSP
  * @scard_ops : sst card ops
- * @pci : sst pci device struture
+ * @pci : sst pci device structure
  * @dev : pointer to current device struct
  * @sst_lock : sst device lock
  * @pvt_id : sst private id
--
2.31.0

