Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D943AA2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhFPSRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFPSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:17:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03905C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:15:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id he7so5267454ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iA13K48KzuIpGYq/i6ECiGc+2z0+pd9ewcweV2NprfM=;
        b=TLsEvASallv1e9fGnDkLSXtD27jr2uuZYlSl/qELft7u3mmI5O6iCT68bjlI2SRYjq
         LxmKvqHBQ0pao+Uxd/R68LUVIv8qKlkQ3eiybcG57MD2PJ5Y1Xn5/7JgMPNQ2VuVfok2
         nB5Lacc9rj0oXI9IS/6yGbe5ivHQ2GIqhKixuxjdDmFVQvLXCO8FD4kT5JxD5a+/nA0b
         xLmXiJjEvFfqhBTAt/DX4qaPdrYE7X1isYZZzACxD8MoUBotLnM3QV8A3y6CcH+NAgm/
         Esu41rX6r4P88e600Ow+xR7cRXgEyT1kbyVXctZLJZS0F7axWgdxmiXqK49vmHnorvMS
         ag/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iA13K48KzuIpGYq/i6ECiGc+2z0+pd9ewcweV2NprfM=;
        b=tv4prVwJrwHAe1ChA5kY6pNCur85TfIW86mosI2BzU45DuKWBeUjsyNq7xh+A+JNf+
         k7Qlf+pnoCUvgGK7faFycD8TeY2FG7jaavXYDtH4V3GuPdEcmOOB/kVNyojYaor7xstD
         1jeEN6N1Oi4w9llKQk4ewKqv6VVBlXH1+bCbePdF6jNB1D7pd1mikhpyr8hndZoIKLj1
         1vHWdLxzF+YJ8IpTmkfC01WJUOGy/Z+M/BFeWd2xOYAbSFjorJ/1dQGgIaEtIVO3fmKM
         t8jobQGxmbwfw6Ic3hVb1autW3tg7LOxM5w12TfLEzN4CMFDs5VV6QyASkiZfDScShN0
         Ai/Q==
X-Gm-Message-State: AOAM530FpPB49xWQkNM9TR9j7Bd/jNupQ9Wa8BJ1UhBnlzDfwPDCpni+
        UNOFCtsXGS5ejJBzPR8zM7w=
X-Google-Smtp-Source: ABdhPJyZivDHqofphT91qZKlZv+pZggVunWdW2DumesRxQxnkb6L8WYCj9mO4pLFAaygrekuOSX9sA==
X-Received: by 2002:a17:906:26ce:: with SMTP id u14mr805906ejc.187.1623867336632;
        Wed, 16 Jun 2021 11:15:36 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id d25sm2442634edu.83.2021.06.16.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:15:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4] x86/resctrl: Fix kernel-doc in pseudo_lock.c
Date:   Wed, 16 Jun 2021 20:15:30 +0200
Message-Id: <20210616181530.4094-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add undocumented parameters detected by scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v3->v4: Restore the description of a parameter to the original text
because it is preferred.
v2->v3: According to a second review by Reinette Chatre, drop many 
unrelated changes that should go in separate patches. Modify also the
patch log.
v1->v2: According to a first review by Reinette Chatre
<reinette.chatre@intel.com>, modify the 'Subject' to conform to x86
subsystem, modify a wrong description, and run 'scripts/kernel-doc'
to find out more warnings that 'sparse' didn't notice.

 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 05a89e33fde2..2207916cae65 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -49,6 +49,7 @@ static struct class *pseudo_lock_class;
 
 /**
  * get_prefetch_disable_bits - prefetch disable bits of supported platforms
+ * @void: It takes no parameters.
  *
  * Capture the list of platforms that have been validated to support
  * pseudo-locking. This includes testing to ensure pseudo-locked regions
@@ -162,7 +163,7 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
 }
 
 /**
- * pseudo_lock_pm_req - A power management QoS request list entry
+ * struct pseudo_lock_pm_req - A power management QoS request list entry
  * @list:	Entry within the @pm_reqs list for a pseudo-locked region
  * @req:	PM QoS request
  */
@@ -184,6 +185,7 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
 
 /**
  * pseudo_lock_cstates_constrain - Restrict cores from entering C6
+ * @plr: Pseudo-locked region
  *
  * To prevent the cache from being affected by power management entering
  * C6 has to be avoided. This is accomplished by requesting a latency
@@ -196,6 +198,8 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
  * the ACPI latencies need to be considered while keeping in mind that C2
  * may be set to map to deeper sleep states. In this case the latency
  * requirement needs to prevent entering C2 also.
+ *
+ * Return: 0 on success, <0 on failure
  */
 static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
 {
@@ -520,7 +524,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 
 /**
  * rdtgroup_monitor_in_progress - Test if monitoring in progress
- * @r: resource group being queried
+ * @rdtgrp: resource group being queried
  *
  * Return: 1 if monitor groups have been created for this resource
  * group, 0 otherwise.
@@ -1140,6 +1144,8 @@ static int measure_l3_residency(void *_plr)
 
 /**
  * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
+ * @rdtgrp: Resource group to which the pseudo-locked region belongs.
+ * @sel: Selector of which measurement to perform on a pseudo-locked region.
  *
  * The measurement of latency to access a pseudo-locked region should be
  * done from a cpu that is associated with that pseudo-locked region.
-- 
2.32.0

