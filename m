Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26385443E53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhKCIZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhKCIZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:25:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE9C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 01:23:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k4so1953567plx.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9ffw9+bgwnlSxrtlIbApR7cN+dsc1TBvcpyiR7f8nE=;
        b=LvU6gPRFvFYHYM5eKmKKK6TGeMS1Vhoc0E7TGVI4PCIW8Y/UlReii+N4AhfxloAnJE
         GUax/b5v02F3WL05kfjdDSh2UoF7qTt1+FyFHqKs6E8MIJ94Fw1II5Qkh72NJBCjqcrC
         LSL/L7GZd0M7yfkA4lc7NEEE8tcbjykMXLRbIdMBBvis3SEIB6+DteS5GzXHW2Fv2Kx1
         WnVUgKMOBO+UL4b4HQdvzpP2cHct0uWTMOP0hIQo4/IxF2RTQqtAUnJyOF2iAYeKlRWE
         d4Mir3CmJ3X/le0ubTtSP05JpD0t3lrp4D8951ll3jbUAw90EuygkauLWxhR5yF00tpF
         MdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9ffw9+bgwnlSxrtlIbApR7cN+dsc1TBvcpyiR7f8nE=;
        b=cnDSgzQdLOlSsnmJW9BuTxZNt+ETJ5U1jq68ld3xqizPOJeBytI3tVuFog/VvODyyM
         VB2pq4Dwz6uIi0D8L67rNPBLCmvcIk/NeZ+bBU2juYWGzFi7rjszLoKVpHIY/ierU2/O
         Hju9UFgvhgutCp1/IU2a2h/LvSV8vsoCLIw9a1CJ7mn5DW2buFZSTeqfg5FbtkM7FJeA
         LNiJjfHsiIMKV5CWPm/hCtJRWtKwnY4HGO5w4dSVXUe4KyydipQPZlwoncageqvrWb19
         K9YDB4I7HNmg9wpY+FVrEQK8JMa2HM1zAHgUOsb+IkkFzxAquliMRSTS7FO6GCdi9m0F
         Sz4A==
X-Gm-Message-State: AOAM5314B3+1ml2SBMzkZOaBuvcEqJfjUnwjgzSm30BEBshoJd//Hzap
        vxwMHluj7OhipmGrHR+qoJk=
X-Google-Smtp-Source: ABdhPJwtOuB4wURVIwcAmk69oiqjrfVYIqrLj1k/HsDV9os1UmETZLVI/JUThx2Uv2voAHXw2zUQSQ==
X-Received: by 2002:a17:90a:df97:: with SMTP id p23mr12881187pjv.3.1635927797494;
        Wed, 03 Nov 2021 01:23:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c3sm1652808pfi.144.2021.11.03.01.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 01:23:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers: most: replace snprintf in show functions with sysfs_emit
Date:   Wed,  3 Nov 2021 08:23:13 +0000
Message-Id: <20211103082313.27570-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
funcitons:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 drivers/most/most_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index acabb7715b42..dccbec16000c 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -831,7 +831,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 	int err;
 
 	if (sysfs_streq(name, "arb_address"))
-		return snprintf(buf, PAGE_SIZE, "%04x\n", dci_obj->reg_addr);
+		return sysfs_emit(buf, "%04x\n", dci_obj->reg_addr);
 
 	if (sysfs_streq(name, "arb_value"))
 		reg_addr = dci_obj->reg_addr;
-- 
2.25.1

