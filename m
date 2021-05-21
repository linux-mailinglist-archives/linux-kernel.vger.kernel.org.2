Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5026438C090
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhEUHTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhEUHTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:19:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721ACC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:17:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p7so16238278wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nbv8tIC0zQSA2vsZg6URKkKIkrN+B6+9lDSVfqUlevA=;
        b=yRvk8n7nu7yGOaDPRsg85Ukgdoa0emDnQka8niXjKWbwjSvoWeTmd4nXoxHV4SAgBY
         zyATtewCvD3XZYJTowvkUH2+ze/35g+8kAU3hdzke+rlFQde/obujcbTiR8wbhWVrhRI
         Fpg54wE1UiuyZotCHe0kFQ8+GwjRdqRpyTA65T2IKvtGqRFFr9U449bJVtJYOGcC6fIZ
         0Rt2CZK9OvFQjQerPKp5BHC0ho5xMWKa4O82m2gfEXSMwpsAVYY57nDj75B131O4Y3ej
         7AxpXqTrgAS9qbz7/a/ILrbEG3V1VqLlg/AUrDVYT/34u6vN9BPjWPuaKS+fzzkIPe/u
         KrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nbv8tIC0zQSA2vsZg6URKkKIkrN+B6+9lDSVfqUlevA=;
        b=BbqR4Ha9hkrCqMXniYvUdRmlrMdOjRdvlLHus4tX1KVEMh0R5oCAKi74oFtwA/XI2o
         re0XIEMEhmJgGLo9Msjca6KMTN1CmamAnzTPMwVonF5ULAoUiS01vkS6OmWIZrgUe+X8
         eSUMyrJNziM6qOJ3qAWkxYk1VAOIqh1vG9JuELvolfuxnvhPUApWdjmX1xicQBVBd2Cb
         cOWdo/9cPDkSReiJSToRaWSyFSBWfgp236r1FyzK4folKzUXoaVbGO28Rdd5eXEj3pPA
         BaMJzc6+tEuLjkFrEzR4kMzDJ9sLyaiM/9djeX1fcOoRloyAjDkBnM7Zv/032Mmv62LL
         6llQ==
X-Gm-Message-State: AOAM5300bderAIGD8fyjqzI5lLb8rQVmBWUMhhp9B1eB3si6HXhTlb8k
        Gmnv4BYAdP6luimO9HcYqaH9wA==
X-Google-Smtp-Source: ABdhPJwsLtEE7eqex7Km3cQZfXQAsMixWwwPz8Ozxc/yjLn1LQ50jTakPIz2iZqyWdvEjFVvtwdUkw==
X-Received: by 2002:adf:ee11:: with SMTP id y17mr8003126wrn.57.1621581468061;
        Fri, 21 May 2021 00:17:48 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id k205sm5145382wmf.13.2021.05.21.00.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:17:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, russell.h.weight@intel.com
Subject: [PATCH 1/1] Revert "MAINTAINERS: Add entry for Intel MAX 10 mfd driver"
Date:   Fri, 21 May 2021 08:17:44 +0100
Message-Id: <20210521071744.3909566-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 58d91f1c1701de9420acc43a2f4f8004af85c363.

This is a duplicate.

Reported-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d37ee47fc3bf0..0610ae5b7791e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9332,16 +9332,6 @@ F:	drivers/hwmon/intel-m10-bmc-hwmon.c
 F:	drivers/mfd/intel-m10-bmc.c
 F:	include/linux/mfd/intel-m10-bmc.h
 
-INTEL MAX 10 BMC MFD DRIVER
-M:	Xu Yilun <yilun.xu@intel.com>
-R:	Tom Rix <trix@redhat.com>
-S:	Maintained
-F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
-F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
-F:	drivers/hwmon/intel-m10-bmc-hwmon.c
-F:	drivers/mfd/intel-m10-bmc.c
-F:	include/linux/mfd/intel-m10-bmc.h
-
 INTEL MENLOW THERMAL DRIVER
 M:	Sujith Thomas <sujith.thomas@intel.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.31.1

