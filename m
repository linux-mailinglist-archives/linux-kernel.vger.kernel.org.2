Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E57A3A69CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhFNPLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhFNPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:11:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D136C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:09:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g20so17352006ejt.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nS4UUGRoYFO8XuhntM83rYU5OFIuElNUgrC4hv5zVEw=;
        b=Gx19XFniz0S90ZOzBRGyKfu6K3XR2SeYSfvZ/jCrcZRiJ3iI2PU4fy//dH/geP6bnT
         dGF5XRn6BYT3tee634X6a0ocuq9Tecw+Tp+Pfvi/dqKYe4cxJQBjpl6h28i+EKzVjdko
         T9FvB4YD1XgdsEKrQjOVmctUlFaPH9P8teNfpMr5R78Z0RsIoV6yJl+wBb/DzG78/U7X
         QiP8f5I12g6ODDeT6VKN+fzgTbzpok9LC7dDY3ROGmgU/yZBT6KGqR0z6RvCV8qo5T5z
         eWAqeBx+NUO00QGVkvSDpIHqTmSHhV+d0sEa8ppAbr5J0geVuLlBO3g3eKhblUiq5ZzY
         kosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nS4UUGRoYFO8XuhntM83rYU5OFIuElNUgrC4hv5zVEw=;
        b=gGNAMFT363cvZ8JJNr8cwmtpmhhu/h4PmRHFtj4QxblDKWE1LT+gi/frzKISwoZbHY
         IF6AMghtIRyGLKXmmufD1376AAQ6InpAtHTzhiW+Y09dEUIh7kEIKnMo2BS3wm70fHnM
         p5k2F56HyH/n3HzjxoEixiIRAI/Loe+Dwenkyx9f1Yob5rvJYOldQWivVj684RztiXm6
         xUoperNXgzY9wFJ77Nr8/PJqKKbxv/bxk9pT37uK8BkedBEPhOtbqTIbLa02U7AGEU3A
         KZqVa+ljpHSM3Z6uoEwnBARIexFnQBy52HSjd0Y5Zu1jBF0Bs0kNznCrER4vYzRBia/s
         ZHSA==
X-Gm-Message-State: AOAM5314qH429PPn5k4D6eChw34AiJzhMU2cAHJXMWE0dsu2J9ZxYNll
        tYUVd1EZISR13cSt4GM3kpg=
X-Google-Smtp-Source: ABdhPJwybqirNZF9TD5nNpOuJH6sW6OWCb7SUxeFPY75PFg3bJpbgVpK8wDuby9nbS0u/Yw251amsA==
X-Received: by 2002:a17:906:eb88:: with SMTP id mh8mr15549128ejb.540.1623683374015;
        Mon, 14 Jun 2021 08:09:34 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id du7sm9137288edb.1.2021.06.14.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:09:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] x86/resctrl: Fix kernel-doc in pseudo_lock.c
Date:   Mon, 14 Jun 2021 17:09:29 +0200
Message-Id: <20210614150929.3151-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add undocumented parameters detected by scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
v2->v3: According to a second review by Reinette Chatre, drop many 
unrelated changes that should go in separate patches. Modify also the
patch log.
v1->v2: According to a first review by Reinette Chatre
<reinette.chatre@intel.com>, modify the 'Subject' to conform to x86
subsystem, modify a wrong description, and run 'scripts/kernel-doc'
to find out more warnings that 'sparse' didn't notice.

 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 05a89e33fde2..84b9bf4daa33 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -49,6 +49,7 @@ static struct class *pseudo_lock_class;
 
 /**
  * get_prefetch_disable_bits - prefetch disable bits of supported platforms
+ * @void: It takes no parameters.
  *
  * Capture the list of platforms that have been validated to support
  * pseudo-locking. This includes testing to ensure pseudo-locked regions
@@ -162,8 +163,9 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
 }
 
 /**
- * pseudo_lock_pm_req - A power management QoS request list entry
- * @list:	Entry within the @pm_reqs list for a pseudo-locked region
+ * struct pseudo_lock_pm_req - A power management QoS request list entry
+ * @list:	Entry within the power management requests list for a
+ *		pseudo-locked region
  * @req:	PM QoS request
  */
 struct pseudo_lock_pm_req {
@@ -184,6 +186,7 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
 
 /**
  * pseudo_lock_cstates_constrain - Restrict cores from entering C6
+ * @plr: Pseudo-locked region
  *
  * To prevent the cache from being affected by power management entering
  * C6 has to be avoided. This is accomplished by requesting a latency
@@ -196,6 +199,8 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
  * the ACPI latencies need to be considered while keeping in mind that C2
  * may be set to map to deeper sleep states. In this case the latency
  * requirement needs to prevent entering C2 also.
+ *
+ * Return: 0 on success, <0 on failure
  */
 static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
 {
@@ -520,7 +525,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 
 /**
  * rdtgroup_monitor_in_progress - Test if monitoring in progress
- * @r: resource group being queried
+ * @rdtgrp: resource group being queried
  *
  * Return: 1 if monitor groups have been created for this resource
  * group, 0 otherwise.
@@ -1140,6 +1145,8 @@ static int measure_l3_residency(void *_plr)
 
 /**
  * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
+ * @rdtgrp: Resource group to which the pseudo-locked region belongs.
+ * @sel: Selector of which measurement to perform on a pseudo-locked region.
  *
  * The measurement of latency to access a pseudo-locked region should be
  * done from a cpu that is associated with that pseudo-locked region.
-- 
2.32.0

