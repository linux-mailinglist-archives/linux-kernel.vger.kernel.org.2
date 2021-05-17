Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BF382272
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 03:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhEQBEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 21:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEQBEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 21:04:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C2FC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 18:03:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so3837157pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 18:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xfp/CZSlq0nUTfGq9imaIPDDNtjzYw1PPenTa+58Dqo=;
        b=kS74OyXhMmnVrcnUGBLLHJjvg7PqOxe7oz/sxiDvDGf6MhSkFGCDxSzGxBK7DQvrTY
         LV+9mQL0afWiLEa377cNmrh8cW0xkrZqqDdv2GEtlCLJZlTevdXDXuwH265C4e37DxPu
         QZAKga1dXRZ6CzwZ4hAHxvQqqr86BXRn+tPmqIf3ohoQ/LxYuitXVx0JwHKQlw1r4HP3
         lLan7bYAnf+qGmd1lBgvfZJME+jyTQXsIzwMyU/AiRLywqIxNJxLsZhyxuj5FY29EjDo
         eWuDLPCcVbJF94KzmRuhX98uOeHKvkjrLQxecqcOoY3W/OlMSwYnIKMKXKUYLuKz0r/O
         UYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xfp/CZSlq0nUTfGq9imaIPDDNtjzYw1PPenTa+58Dqo=;
        b=q6/hJGOpED8tTaRTYlmxQeF6tpZPTbp+AmEGorT5YULOA+9iTMoJzG2lPLUSIvGtm3
         hCHk93Zpbp2LC4uKRYkxdwziJmjHKmcsEpMUx9faHm8tlJD6zx+T3xRUofWxd6KwlkO9
         AejzhYt+qoN17y7GT0JfjZo0AvLBBm7g2OxJGwZR4Lu2I9VMd5Lo9ks+Iu8ltLb9YKa0
         U88E8YScbituN3QAapkldbAuSjLHjAzQzEdqG57dAp3+RzbNgIZxR3BDQlzeQu6aL1bV
         QU3KzZdXhrVF2bgrZpqsImec9INPF6hw8MDwlDwec9ATaV84BT+NkLUtUEYlFFHv3YN1
         vfZA==
X-Gm-Message-State: AOAM533bN/1ukwalONf/BB+H0Wsrb2IwkDjV7jroxF/r3/hLWoipfsQd
        PTEYsMfi/vEO1/QiDRbbbBJMVw==
X-Google-Smtp-Source: ABdhPJz06jmsRTIRKIBzZHXJ7VIgifp8v4+ig/SrCD4SIYxWcxIfFBGp/sv7xtP7Y0dKn3zp1pz/tA==
X-Received: by 2002:a63:6207:: with SMTP id w7mr60126732pgb.260.1621213407959;
        Sun, 16 May 2021 18:03:27 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 187sm8334434pff.139.2021.05.16.18.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 18:03:27 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: fan53555: Fix slew_shift setting for tcs4525
Date:   Mon, 17 May 2021 09:03:17 +0800
Message-Id: <20210517010318.1027949-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trivial copy-paste mistake.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53555.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 2695be617373..d582ef3a3aeb 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -376,7 +376,7 @@ static int fan53526_voltages_setup_tcs(struct fan53555_device_info *di)
 	case TCS4525_CHIP_ID_12:
 		di->slew_reg = TCS4525_TIME;
 		di->slew_mask = TCS_SLEW_MASK;
-		di->slew_shift = TCS_SLEW_MASK;
+		di->slew_shift = TCS_SLEW_SHIFT;
 
 		/* Init voltage range and step */
 		di->vsel_min = 600000;
-- 
2.25.1

