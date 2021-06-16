Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870A93AA367
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhFPSpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhFPSpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:45:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:43:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k7so5402882ejv.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMA7/vK7LRnjFQgxNv0v2/iGODVmVsDh1vqgQp94or4=;
        b=H+HT7gjaDeTB++P1/dH3+l0kimHfczGMOya5cg0290WPPUYV4CNlc4afR+SMT1vjx9
         IBxZmjw6XsSDPEw++DWuCxhH2yvswYBOGcg6tJKl3FHpjBfkkLzbix54f1xxDnx4FJmd
         GaLMHb0XqwBEH7eLaIRDU4kCgkSPGpvgAQWp6XmivuPJMxjP3qag1pl16nydWiRhTKsf
         PZ3QkFgiCbEicDxCALHP9cklBbT9xhY2b9snHFXKdOk8k1CICI/Wb+EvmDNmjG+q37ld
         PskSOCI3AdnLugESKgVq+I++rvSCiyiefz/llyRtJ/f4Tjq1x2CulqkAJfy/GxWnGI31
         FRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMA7/vK7LRnjFQgxNv0v2/iGODVmVsDh1vqgQp94or4=;
        b=c9qPhHx6dhRM5Q93Kr5hlmUO+506hXejWxnurJsUiJNSbL/FNEaWveHt/u/dfIt0xt
         Mu1baG8ZZ0TvS9x+tyVvTxRSsZ7q9rRlHFHS97H/gUNxNgM3Pqd6SL0r4g9DBp3NkjNu
         swFgQ+SSTVd5br+B7RvtjGEhbZVpJMlp/DuqwKPVgFnCvzQpnYMjMhTKRcUkf4yFzAJU
         JD/6lch/nPsK18mBCkhJfzQiusVZvEGyNKkhjoEVf3MOG9E7a24R+xTACe0DPFg7OPSN
         pzXFIZXDo5ZJm5M4Rd6kk4i4EsFj+g3QDrqnhE1Zq1tepeDQfnY5n8+dxprRCCJFmiaL
         ceDA==
X-Gm-Message-State: AOAM531lbfXbRzwVjFMPXHmcVk5OGHEnTh72wqWZDw6apVO3e3acyCcI
        0WAGoFoZiw+tT0eNIHfROOY=
X-Google-Smtp-Source: ABdhPJyCQdoWmJu+4TBMEXbcCLFDJ323MMUNh2wo6/F9mOE4JGuEGILLc3vWOxO9dEcyuRIkgx737Q==
X-Received: by 2002:a17:907:2b26:: with SMTP id gc38mr943621ejc.31.1623869014357;
        Wed, 16 Jun 2021 11:43:34 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id n11sm2159275ejg.43.2021.06.16.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:43:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] x86/resctrl: Fix kernel-doc in internal.h
Date:   Wed, 16 Jun 2021 20:43:30 +0200
Message-Id: <20210616184330.13301-1-fmdefrancesco@gmail.com>
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

v2->v3: Fix typo. Inherit the descriptions of membw and mbm_width from
commit
https://lore.kernel.org/lkml/20210614200941.12383-2-james.morse@arm.com/
to make it easier to merge both patches.
v1->v2: According to a first review by Reinette Chartre, remove changes
unrelated to the subject of this patch and modify the descriptions of
two parameters.

 arch/x86/kernel/cpu/resctrl/internal.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c4d320d02fd5..956b83681bcb 100644
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
+ *		       as kernfs private data
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
+ * @mon_data_kn:		kernfs node for the mon_data directory
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
@@ -456,11 +461,13 @@ struct rdt_parse_data {
  * @data_width:		Character width of data when displaying
  * @domains:		All domains for this resource
  * @cache:		Cache allocation related data
+ * @membw:		If the component has bandwidth controls, their properties.
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
  * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
+ * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
-- 
2.32.0

