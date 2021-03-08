Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01319330C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhCHLh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCHLh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:37:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 03:37:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so635405wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 03:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8ABSumopRxhX3bOOU+CF2r1YImKGUPBBN79DPzPoQc=;
        b=qTGAAgs1+zy1cao2XlPMOo2/qIYHp62VyXADDPlERMV4r9K9nlfQ9GH0iuIgOJza6k
         QgqkH/b8u6xt7ca1LyFoSFBtdxoxS4Cia6VH2aJr5NhtkemK1kx1hUDP7QTJl0SB6xWE
         kCrWKnYBEC29/yt9r0AEvlHoZ+2NU/GuAQoGf6htGAunvnCf9IjsyoPzNZO+f+0zpJq8
         iq2rlAO5xqBLR+gZEe3G6ACQ/Hd1H9/nUdMAobkRovNdogUwJUrPRLIy9OZ1bRZ3Z/rE
         cNWxztnJghjHHpyehxQpgXjDCcrn3TqqNLVDerc0uYM/N3vRhF1aKwX5SfaxVYVL1u7Q
         HNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8ABSumopRxhX3bOOU+CF2r1YImKGUPBBN79DPzPoQc=;
        b=RAbCfvJ70dYk4Dr0LVVKNPzBK6FOJ3IjS27sF1cIODcCQQ8m1q6l7NuhA/sJ6Jxv/X
         NQ5SqsIpaaTuu49iHcCInz+hwGFGfWDjzMtf/BaY3dImA0Yyz+Fw4NL9aWbnpk+rMM7o
         5grzJBaDwrNfDe7wUlN38EPEx3qhDMpWzngdM6h5SAp9OBKai5dLFWIlXHhjoZzmjACf
         u3PTLdqb408NUOWO0bxGA8NQvgf6jscq+Pn/U/qjwklIkFbfaoWhg8bYVgAQMn+qR29w
         RXQ3b/aHLt9vOgrB0d/cpOyBRVZp+iFBMzK+q3Y83WLH19D3ncHNL3giYFo3GSwjrExl
         XaUQ==
X-Gm-Message-State: AOAM533Y9kqE3zjUmqAycVOOn/hKWEzIKIzjcqBX6orbEy6W+u4EAVY/
        qSCoxGY/KBqebUt/nxh+g2CGkQpqkOYJKA==
X-Google-Smtp-Source: ABdhPJzvtP3yUsWdjFWnv3mLUSZ+nE32zs5G58Bd972PHZWHpFni40FibDAuNT8E0DM5cs8JyEeZXA==
X-Received: by 2002:a1c:4182:: with SMTP id o124mr22327685wma.61.1615203475530;
        Mon, 08 Mar 2021 03:37:55 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id w6sm19448899wrl.49.2021.03.08.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 03:37:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: bus: Fix device found flag correctly
Date:   Mon,  8 Mar 2021 11:37:52 +0000
Message-Id: <20210308113752.19661-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

found flag that is used to indicate SoundWire device on the bus is
not reset correctly after one iteration, this could miss adding devices
that are enumerated on the bus but on in device list.

Fixes: d52d7a1be02c ("soundwire: Add Slave status handling helpers")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index a9ab4a6264e0..188e391c5a83 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -712,7 +712,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 	struct sdw_slave *slave, *_s;
 	struct sdw_slave_id id;
 	struct sdw_msg msg;
-	bool found = false;
+	bool found;
 	int count = 0, ret;
 	u64 addr;
 
@@ -744,6 +744,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 
 		sdw_extract_slave_id(bus, addr, &id);
 
+		found = false;
 		/* Now compare with entries */
 		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
 			if (sdw_compare_devid(slave, id) == 0) {
-- 
2.21.0

