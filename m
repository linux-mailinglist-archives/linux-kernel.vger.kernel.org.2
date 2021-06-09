Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B323A08C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhFIA5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:57:32 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35823 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhFIA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:57:31 -0400
Received: by mail-wr1-f42.google.com with SMTP id m18so23481213wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbFgX3UJ1Q3Aj0ZiAl1bfNghzCpTB0DWkuD0W/YEdT8=;
        b=VR/eoGkC3O9b1nQ5MDJAFN6aJbYfNHSrCLsMSAlfjdOjPiUqyR1soGfbfAd2qp1D6C
         iewKBtrnzineqqyX3ZwA0vYnTkDITdkpyiSe090YISNB51hq1rzN67LDafE19mI+hp5X
         ymtSnkijZ4NCrMZztbjAniiGm/Dj6pYM1Mt2FUOrMwbzllasYmR62g/mqepe/LLrmpwY
         H/iuIVgmkDqKJr47mIx/1NrzQKBL6+29gDOFUSzOtdE1Qvl9DErcNG42rsQ4Ue1ymgI+
         eCIpMqYShmZ2/QK8DuqpbUo1ZGvLxLDdJPRUkFhO138cZXnqhPa7gIWq7+Iz6ISEaxbN
         lEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbFgX3UJ1Q3Aj0ZiAl1bfNghzCpTB0DWkuD0W/YEdT8=;
        b=e0G4Y04o0/m2ajARhB1C1A1VeOkXuuC2C6eAJsjSNQM0KMIGkjsoV2VDHHnShf4fu7
         6HdY0LfAackuFrIGiMUXjNkcJ60NdclvNoYrDSDdPE0ej/y2hxX57z9uDBIBg4ujzyZq
         4Xf23MnFT66ZUU9FbcrCTMLj39Wzgi4e/0VINIvcc6NecSeLRoCzNPtcKxh21JdxY2Ko
         yJwa9lWRhpTV6uXkRjaPSvbA7P7omxhSHZ5h0WUMDmtVYPFto6dEHKPDxwwoOx8rqfIK
         2tDfXVbMqfUkitO7pIfpIv4Z1t0U10EMvTU0rHMFUD6aV2rSY7Of1dtcvttKyV9cZp8e
         R8nA==
X-Gm-Message-State: AOAM531/MrITVHVNBVBKKnaIjxS2uwF9zhQ3k6ZyPuGQVNv1dJgHONwN
        JgMeAJbRBR5kODYGwntvKyw=
X-Google-Smtp-Source: ABdhPJxT/j8xQwTxVv7KuCLrJrvrwgDodXO+EIkhuOaEcuc8Y4gSYd4HDzCpYO7npAbOXKYKKbvH5w==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr3943662wri.219.1623200061052;
        Tue, 08 Jun 2021 17:54:21 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id t9sm15059830wmq.14.2021.06.08.17.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:54:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] x86/resctrl: Fix kernel-doc in internal.h
Date:   Wed,  9 Jun 2021 02:54:15 +0200
Message-Id: <20210609005415.6993-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added description of undocumented parameters. Fixed some minor
kernel-doc grammar issues. Issues largely detected by
scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 28 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c4d320d02fd5..f360944a7ae1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -68,8 +68,9 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
 /**
  * struct mon_evt - Entry in the event list of a resource
- * @evtid:		event id
- * @name:		name of the event
+ * @evtid:		Event id
+ * @name:		Name of the event
+ * @list:		List head
  */
 struct mon_evt {
 	u32			evtid;
@@ -78,10 +79,12 @@ struct mon_evt {
 };
 
 /**
- * struct mon_data_bits - Monitoring details for each event file
- * @rid:               Resource id associated with the event file.
+ * union mon_data_bits - Monitoring details for each event file
+ * @priv:	       Private data for the union	
+ * @rid:               Resource id associated with the event file
  * @evtid:             Event id associated with the event file
  * @domid:             The domain to which the event file belongs
+ * @u:		       Name of the bit fields struct
  */
 union mon_data_bits {
 	void *priv;
@@ -119,6 +122,7 @@ enum rdt_group_type {
  * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
  * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
  *                          allowed AND the allocations are Cache Pseudo-Locked
+ * @RDT_NUM_MODES: Total number of modes
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
@@ -142,7 +146,7 @@ enum rdtgrp_mode {
 
 /**
  * struct mongroup - store mon group's data in resctrl fs.
- * @mon_data_kn		kernlfs node for the mon_data directory
+ * @mon_data_kn:		kernlfs node for the mon_data directory
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
@@ -282,11 +286,11 @@ struct rftype {
 /**
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
- * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
+ * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
  * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
- * @prev_bw	The most recent bandwidth in MBps
- * @delta_bw	Difference between the current and previous bandwidth
- * @delta_comp	Indicates whether to compute the delta_bw
+ * @prev_bw:	The most recent bandwidth in MBps
+ * @delta_bw:	Difference between the current and previous bandwidth
+ * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
 	u64	chunks;
@@ -450,18 +454,20 @@ struct rdt_parse_data {
  * @name:		Name to use in "schemata" file
  * @num_closid:		Number of CLOSIDs available
  * @cache_level:	Which cache level defines scope of this resource
- * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
+ * @default_ctrl:	Specifies default cache cbm or memory B/W percent
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @data_width:		Character width of data when displaying
  * @domains:		All domains for this resource
  * @cache:		Cache allocation related data
+ * @membw:		Memory bandwidth allocation related data
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
  * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
- * @fflags:		flags to choose base and info files
+ * @mbm_width:		Width of memory bandwidth monitoring counter
+ * @fflags:		Flags to choose base and info files
  */
 struct rdt_resource {
 	int			rid;
-- 
2.31.1

