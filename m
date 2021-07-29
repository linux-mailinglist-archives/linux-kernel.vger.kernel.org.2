Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360393DAF3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhG2WhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:37:12 -0400
Received: from foss.arm.com ([217.140.110.172]:59278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235385AbhG2WhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:37:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2153711D4;
        Thu, 29 Jul 2021 15:36:57 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DFCB3F70D;
        Thu, 29 Jul 2021 15:36:55 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
Subject: [PATCH v1 13/20] x86/recstrl: Allow per-rmid arch private storage to be reset
Date:   Thu, 29 Jul 2021 22:36:03 +0000
Message-Id: <20210729223610.29373-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729223610.29373-1-james.morse@arm.com>
References: <20210729223610.29373-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To abstract the rmid counters into a helper that returns the number
of bytes counted, architecture specific per-rmid state is needed.

It needs to be possible to reset this hidden state, as the values
may outlive the life of an rmid, or the mount time of the filesystem.

mon_event_read() is called with first = true when an rmid is first
allocated in mkdir_mondata_subdir(). Add resctrl_arch_reset_rmid()
and call it from __mon_event_count()'s rr->first check.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 18 ++++--------
 arch/x86/kernel/cpu/resctrl/monitor.c  | 38 +++++++++++++++++++++-----
 include/linux/resctrl.h                | 23 ++++++++++++++++
 3 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index aaae900a8ef3..f3f31315a907 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -22,14 +22,6 @@
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
 
-/*
- * Event IDs are used to program IA32_QM_EVTSEL before reading event
- * counter from IA32_QM_CTR
- */
-#define QOS_L3_OCCUP_EVENT_ID		0x01
-#define QOS_L3_MBM_TOTAL_EVENT_ID	0x02
-#define QOS_L3_MBM_LOCAL_EVENT_ID	0x03
-
 #define CQM_LIMBOCHECK_INTERVAL	1000
 
 #define MBM_CNTR_WIDTH_BASE		24
@@ -73,7 +65,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
-	u32			evtid;
+	enum resctrl_event_id	evtid;
 	char			*name;
 	struct list_head	list;
 };
@@ -90,9 +82,9 @@ struct mon_evt {
 union mon_data_bits {
 	void *priv;
 	struct {
-		unsigned int rid	: 10;
-		unsigned int evtid	: 8;
-		unsigned int domid	: 14;
+		unsigned int rid		: 10;
+		enum resctrl_event_id evtid	: 8;
+		unsigned int domid		: 14;
 	} u;
 };
 
@@ -100,7 +92,7 @@ struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
 	struct rdt_domain	*d;
-	int			evtid;
+	enum resctrl_event_id	evtid;
 	bool			first;
 	u64			val;
 };
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index af60e154f0ed..3b8b29470a5c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -137,7 +137,34 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
 	return entry;
 }
 
-static u64 __rmid_read(u32 rmid, u32 eventid)
+static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
+						 u32 rmid,
+						 enum resctrl_event_id eventid)
+{
+	switch (eventid) {
+	case QOS_L3_OCCUP_EVENT_ID:
+		return NULL;
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return &hw_dom->arch_mbm_total[rmid];
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return &hw_dom->arch_mbm_local[rmid];
+	}
+
+	return NULL;
+}
+
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct arch_mbm_state *m;
+
+	m = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (m)
+		memset(m, 0, sizeof(*m));
+}
+
+static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
 {
 	u64 val;
 
@@ -291,6 +318,9 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	struct mbm_state *m;
 	u64 chunks, tval;
 
+	if (rr->first)
+		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
+
 	tval = __rmid_read(rmid, rr->evtid);
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
 		rr->val = tval;
@@ -306,12 +336,6 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
 		m = &rr->d->mbm_local[rmid];
 		break;
-	default:
-		/*
-		 * Code would never reach here because
-		 * an invalid event id would fail the __rmid_read.
-		 */
-		return -EINVAL;
 	}
 
 	if (rr->first) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 4fe2d5500315..79e83ce3dfbc 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -32,6 +32,16 @@ enum resctrl_conf_type {
 
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
+/*
+ * Event IDs, the values match those used to program IA32_QM_EVTSEL before
+ * reading IA32_QM_CTR on RDT systems.
+ */
+enum resctrl_event_id {
+	QOS_L3_OCCUP_EVENT_ID		= 0x01,
+	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
+	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
+};
+
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
@@ -219,4 +229,17 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 
+/**
+ * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
+ *			       and eventid.
+ * @r:		The domain's resource.
+ * @d:		The rmid's domain.
+ * @rmid:	The rmid whose counter values should be reset.
+ * @eventid:	The eventid whose counter values should be reset.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid);
+
 #endif /* _RESCTRL_H */
-- 
2.30.2

