Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B299A3A6AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhFNPq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbhFNPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:46:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6EC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:44:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cb9so47184142edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDbZQDD7AmQpkyAX6ICSISTpnsH7HuGUW0N98X9N/EE=;
        b=QLnDJ7DCxTPhuCiOL9yo4mFPStyjZcXD8J0TdMiJgYzcwvVx56zPBN7tsiFNRrwhjb
         1+tq+6/KM8oPwHverw7uBB1QyV0hP9TNfX20NG2UsecrG+NB71oC7/scbySJH5xzt85v
         X92b8e7/fkRAfkD4LW1wBBOBX36wy5MoCeVEkUqnAW/h2NBO3cG4Nl8fdPlyrphZ9PPy
         GFJ20NblRLy8dZWSMdfLbHVM+J4r1yTWYUA1+Gh2pkrf0R9u3O8QkrOg8FHGRTvJR6o9
         u33yXfy17HRj0B6NeaiUmGN5cncK5Nc4lkG4etcPMd733J0exWSfnf0mL3Rs/aNjOqHk
         6EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDbZQDD7AmQpkyAX6ICSISTpnsH7HuGUW0N98X9N/EE=;
        b=UbqO2UUotGmRSfaTG26pkXcWfsS1bnEiofS7aj2UhuyEG0YcdGk8hmgFRMXAies19G
         PfqF3H2Mw2fUpSWYkj97l5jx+KNDXCHkz/yamgJA+MeGxuyavTzotbl1khWq1FQLaqWm
         Dk+8QzgQHksWLxsk5n2lVJZD2f9XPvAlfCOuo4F+HjeIHA58todWfhQf7Br5VFdzmWFl
         mWo7KSCRd4qBqGfJ3sEFSBCbRWAdy0TmO/theB7j8FuHS260WWr0Auv2PGT1cxlisuWM
         JoB9eA7mXrfyde5kzep2/AgU/z+oqBMrtccfIZw/4e2Z/e/ss8a3UQc0C2+qwy0IBWow
         AmZQ==
X-Gm-Message-State: AOAM531yvLtmwO+xbjaHTR/bEZX+iGAzZB0VuEqVA2+tpRR2UW06CJPW
        nBSVpzpUVYkcq1DQItYHFb8=
X-Google-Smtp-Source: ABdhPJxl8Fs3MY4BL+NcceRSjy9R8ujcdP6JAovT1hNYe6usVWcHDl7k4SyAneAs/Jme+ZSgMthutQ==
X-Received: by 2002:aa7:c3d0:: with SMTP id l16mr17769700edr.65.1623685482722;
        Mon, 14 Jun 2021 08:44:42 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id dy19sm9182284edb.68.2021.06.14.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:44:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] x86/resctrl: Fix kernel-doc in internal.h
Date:   Mon, 14 Jun 2021 17:44:38 +0200
Message-Id: <20210614154438.17075-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of undocumented parameters. Issues detected by
scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: According to a first review by Reinette Chartre, remove changes
unrelated to the subject of this patch and modify the descriptions of
two parameters.
 
 arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c4d320d02fd5..ac691af0174b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -70,6 +70,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
  * @name:		name of the event
+ * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
 	u32			evtid;
@@ -78,10 +79,13 @@ struct mon_evt {
 };
 
 /**
- * struct mon_data_bits - Monitoring details for each event file
- * @rid:               Resource id associated with the event file.
+ * union mon_data_bits - Monitoring details for each event file
+ * @priv:	       Used to store monitoring event data in @u
+ * 		       as kernfs private data
+ * @rid:               Resource id associated with the event file
  * @evtid:             Event id associated with the event file
  * @domid:             The domain to which the event file belongs
+ * @u:		       Name of the bit fields struct
  */
 union mon_data_bits {
 	void *priv;
@@ -119,6 +123,7 @@ enum rdt_group_type {
  * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
  * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
  *                          allowed AND the allocations are Cache Pseudo-Locked
+ * @RDT_NUM_MODES: Total number of modes
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
@@ -142,7 +147,7 @@ enum rdtgrp_mode {
 
 /**
  * struct mongroup - store mon group's data in resctrl fs.
- * @mon_data_kn		kernlfs node for the mon_data directory
+ * @mon_data_kn:		kernlfs node for the mon_data directory
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
@@ -282,11 +287,11 @@ struct rftype {
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
@@ -450,17 +455,19 @@ struct rdt_parse_data {
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
+ * @mbm_width:		Width of memory bandwidth monitoring hardware counter
  * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
-- 
2.32.0

