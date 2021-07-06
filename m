Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BDD3BC5F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhGFFLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhGFFLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:11:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D1C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 22:08:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x12so26238307eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hHDoPT8iUz2log46tTS8ycTrhaIwizguIXYNV7edjjE=;
        b=JCCtu2wGVFJZgpEGTqAkc+Hdcsyxk5AXJ5mP1deFHLUiIHDF/bvi7ZyonumSV0sgrx
         mdcJlXdIjdFtNWVPiiNLY1laaueR1B5lcsmBy3MnQ8nJq2zRefSRDb0uMGsI12Umtcyd
         /Yz3ZzCMiCFUWdrhNteirK40vSDbjeG47nKTdwJNkvm9e6RSMmAwpA160vAH3sg8jB8d
         VpNE3CBGzYQsbgxwnRpxqpMUmmu0MGHart5Y9QS4+N00Kv+VRw5qBqaYEd4ZlLf5aIyM
         1SXiTikEp5m5jwLQHflvVxE3wwgwgzk35j5oPcYmB5QfP90G6MnOatgLfGwmoIuK8/8A
         52yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hHDoPT8iUz2log46tTS8ycTrhaIwizguIXYNV7edjjE=;
        b=DJ+k6dB4qtuThuBaiu2jVN8s3OhcOrgJxfX5gKAvu0jUo2M+CY6Vk1X+STf607wdFJ
         9gXFy0Ci8sGIVz+VcPM9p0CfO1Q5mwm2yHEhJOCDWSp1PFWxOU6Q8Q98OI7fxN3mo6fG
         nSm/p5HG+hakixw+9dDAAL0kHMTOWxeIxjioaU2XIRiqPiR6ua9f3vIUX+A/QJ6Qpcsw
         CfhB09v/MYSC+lIxE7tyPFEHFFwZw0r+9I7GTcPeKP9xWNIWOrW6gidgfj8tv2j1hryv
         Y9Q6R9J/Q/oxiR5KeJOo3sTUY3a00oeq5NoqjPvqd8U+K8p828y+xw8MVeE7kabcwFLO
         atFg==
X-Gm-Message-State: AOAM532T8RvPSNbLh2DoybhVmX5CDZPoaW/bWiT+GLAO1eTaXG0rYKds
        DsO8kBI3ac8Pf37VB6B23+2IAQ==
X-Google-Smtp-Source: ABdhPJwyp3Apk1jDojmHuKYLDDgPLaspCJ6RGNGPcbNEiWvYDS/C/H03DJrEohUbtDrkJ7c5bT6abA==
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr4187001edd.206.1625548114831;
        Mon, 05 Jul 2021 22:08:34 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:499a:fc00:3532:1608:3da2:d7a9])
        by smtp.gmail.com with ESMTPSA id t11sm1967582edr.34.2021.07.05.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 22:08:34 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-edac@vger.kernel.org
Cc:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/amd64: Do not load EDAC driver when running as a guest
Date:   Tue,  6 Jul 2021 07:08:33 +0200
Message-Id: <20210706050833.9852-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit f0a029fff4a5 ("EDAC/Intel: Do not load EDAC driver when running as a guest")

There's little to no point in loading an EDAC driver running in a guest.

Add a check in each of the Intel EDAC drivers for X86_FEATURE_HYPERVISOR
and simply return -ENODEV in the init routine.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/edac/amd64_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f0d8f60acee1..cdb14575ef31 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3942,6 +3942,9 @@ static int __init amd64_edac_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	if (!x86_match_cpu(amd64_cpuids))
 		return -ENODEV;
 
-- 
2.25.1

