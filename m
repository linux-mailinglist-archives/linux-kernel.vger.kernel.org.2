Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFB402769
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbhIGKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbhIGKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:55:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAFDC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:54:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e26so6504232wmk.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KjB/qGwGzPv2/i+OhRtAA5IG1o1hCFcMQ634Zy4lY7w=;
        b=ScQ39B9839t6KnTkvG2qSh+r7QqGs/OPNTUnP1nVVcFA3cCoV6/GzhQv2u00FdkQRQ
         Azs2vMwqXo9IbIbd5Btw/pIKCHZpwPtfYdU7fKnx5NrdgAxt3vAoWC/vvRpVeU3Il0QZ
         Y11g0KM4YpyT23E6QfO+D49Uiesb6EMO+QLgnEAd/Dn6HfTF3GUd2etAWdJH/3HEwKLp
         7tPcvVzKsyoqod4a2PWC11zFRRF6uRG+c4fDuEVfPLzhQV/Mpktv6FUYYoDui+1BF81p
         NlfT3KVFZ1lBM48arlyqLmTK3F5nLDdcchC+v7ji10sPqJ3dsRo8rfmu972GUBIzKxY4
         P5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KjB/qGwGzPv2/i+OhRtAA5IG1o1hCFcMQ634Zy4lY7w=;
        b=kjCDZyO9sQEfwKgpV66SjSn4+QOKuiVSaTLajsXaRm3P06kHMqUMnvsetiOak4b0su
         u7Zn+vZheUI/joXlcjgZerbs/RcJTqaxsVu4Xo0bw3HZJKp2GFrwo318s/jUlkfi+TGu
         SMmLmPEsLEkteYW3W8cO1pxCEY8spqGqhRJPSi4IlWoXBEIfX4nR4cnvC+B5m4AwA8gk
         wdTe0IjCB1INP3Dh/7aO0sv+SMohFAdirTJC3BtPknaazZfBTu3JiIWjEM+TLhH3eNYE
         T4HrF6P7oSuAW9qS+CVHWWU4uRZgsKXhUdWAC+ZIRAAUv4fAfYosMl5ilkvCh24uoi/Q
         Awmw==
X-Gm-Message-State: AOAM532YAkj9F+9WSH8p52CLFxUDfR0HcI6jiaUtf9PMdQPIDe80tDBf
        JitYMwfpA0BF3CvSRxbFkLgOY4btqrvHaw==
X-Google-Smtp-Source: ABdhPJxIR48oys1SqA4BtNjBnIL4DbC0MXqcnHhqs7sZFTISJuD+xZ247bLqbfBEewUCAn4VDL5IBw==
X-Received: by 2002:a7b:c7cc:: with SMTP id z12mr3324162wmk.108.1631012048617;
        Tue, 07 Sep 2021 03:54:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f5sm1989982wmb.47.2021.09.07.03.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:54:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] soundwire: debugfs: use controller id and link_id for debugfs
Date:   Tue,  7 Sep 2021 11:53:32 +0100
Message-Id: <20210907105332.1257-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

link_id can be zero and if we have multiple controller instances
in a system like Qualcomm debugfs will end-up with duplicate namespace
resulting in incorrect debugfs entries.

Using bus-id and link-id combination should give a unique debugfs directory
entry and should fix below warning too.
"debugfs: Directory 'master-0' with parent 'soundwire' already present!"

Fixes: bf03473d5bcc ("soundwire: add debugfs support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	Added Link ID along with bus id.

 drivers/soundwire/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index b6cad0d59b7b..49900cd207bc 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -19,7 +19,7 @@ void sdw_bus_debugfs_init(struct sdw_bus *bus)
 		return;
 
 	/* create the debugfs master-N */
-	snprintf(name, sizeof(name), "master-%d", bus->link_id);
+	snprintf(name, sizeof(name), "master-%d-%d", bus->id, bus->link_id);
 	bus->debugfs = debugfs_create_dir(name, sdw_debugfs_root);
 }
 
-- 
2.21.0

