Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA636C733
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhD0NqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbhD0NqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:46:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEE3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:45:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so3509856pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9YMPWRS0Ds2eQ5Z2KcGPAiHu8WNDW38HhDGSmx0+gU=;
        b=fZIcuKJysjbs+mdW6MLVU4L87OKVjzDUf/wBkNobgyLQnrJxN0NKSv6UNaaesw0A/i
         WgdxDOKSC68hNXcbPrNQweJmpgZHCaZRpMiFJUsKDHJ8EDfJJlgx9O+X4fZGQzofJMxz
         /PdwhgAwuCY5z73/z9bKmSCbnDsH357jaNLfVbyJisjzD0zYNmY/gbVCz9lrl7RAEm7Q
         QVh45GASVk5oWM1XMsIou6RbRPmKJv0CZywDCYa+S3WXieYdzjpcHp/OTYM1wo2P3jbQ
         Bk9k2R4mnfPkwE6wJ3gR2pUImvU5vI9BEjpxSMUxbS02D+8BNcQdiXsDx9tDyqeOAN0A
         DAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9YMPWRS0Ds2eQ5Z2KcGPAiHu8WNDW38HhDGSmx0+gU=;
        b=dMEQOtWDBAYRCNQ1EfbacGq7rhrPcF8YzwLmIKQ/9vXfT2q8d3q0a58TzFpgspHcRp
         uYseskN7ZkGnI5knqGNsXBXDdM0UkJCaiGFtSX8nVRQO6KjRbDYlBBY1mpaK3NXVCCd2
         c1Xa6S1MTTZAPRUr52/dgC4MfKcPgpbzFqBgJ3xy2IPnzQ/baFKBSoipkk27wqcyVaoZ
         Itr0A7ns9quM7YmUCMweVvX4r8+JS596TOFWaHlhBLym+iX72OBn9Fjmpk/zw+CDlmRn
         vXgl4krTxc0V3oVnXg0jWELdMuFBSwHWdGKM//6G0wLXEBaYq2R11bl/HNKwiMvNSOR2
         PNKg==
X-Gm-Message-State: AOAM530dbb75ZAxZBMa8W4h2NlxxSH0zPV0XsCqugaffAiiS7f0mEaGM
        ycJri8NQQJLxwi45ttrGe50MbcqNStLCwrY2
X-Google-Smtp-Source: ABdhPJzy9yNShuOLQKWfWbqt0UWlwlcAV0vru508jhSdOaiXtGMzCTSM/vINz7i/Id/L6humbPy63g==
X-Received: by 2002:a17:90b:2355:: with SMTP id ms21mr4990368pjb.226.1619531138126;
        Tue, 27 Apr 2021 06:45:38 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id o9sm3054906pfh.217.2021.04.27.06.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 06:45:37 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: fan53555: Fix off-by-one for TCS4525_NVOLTAGES
Date:   Tue, 27 Apr 2021 21:45:29 +0800
Message-Id: <20210427134529.818784-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, also remove unused TCS_VSEL_NSEL_MASK.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Joseph & Ezequiel,
The TCS4525_NVOLTAGES is unlikely to be 127 because if it's 127 the
rdesc->vsel_mask will be 126 (i.e. 0b1111110, which only allows 64 different selectors).
I don't have the hw to verify (I just read the code and I might be wrong),
please check if this patch is correct or not.
Thanks,
Axel
 drivers/regulator/fan53555.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index f3918f03aaf3..aa963435d2b2 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -55,9 +55,8 @@
 
 #define FAN53555_NVOLTAGES	64	/* Numbers of voltages */
 #define FAN53526_NVOLTAGES	128
-#define TCS4525_NVOLTAGES	127	/* Numbers of voltages */
+#define TCS4525_NVOLTAGES	128	/* Numbers of voltages */
 
-#define TCS_VSEL_NSEL_MASK	0x7f
 #define TCS_VSEL0_MODE		(1 << 7)
 #define TCS_VSEL1_MODE		(1 << 6)
 
-- 
2.25.1

