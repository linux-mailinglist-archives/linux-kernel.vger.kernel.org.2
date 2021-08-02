Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49E23DE024
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhHBTjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:39:14 -0400
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:54368
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229537AbhHBTjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:39:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnKNEhL881PmArUqDkHqSrk1DYbCvKzTC78YAbwrRpoDc/uHr6LaLi7IzP2kXMCrFyyTok35EoES+MRcUW7c/95m+5SbQUGfFFj9ZQ2Xoedsih56/RRhzCvKcfBVVDA4bvMoR34QQBKXwdo6Qr56w0+lrcHZfxnSC8pnsH6SiDhhV2PnAquz4i497uOy4gmAFPURMmQ49Nzs14Ziv086dUJ2CAgWN7vLxZDVxQRd38ih9nVzvHTDBm1tnwfW0egZSHcEzGhqBa1S500RHv9h1ourlsWkzWMXVgkYenm/ak4noExB1YXQVxGA/yN4yhxcTedJNHAWDQbJfakwbquLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDuvBir0eR/DOuljJ+Cd7Om+6qhqUpv1n+O6YS+INuE=;
 b=UHs3ZhqCWjRkI2EnCzqmH6aw//iiYNMCQ4B6SetaDfqLSppNuhGhA59jnxs+fVWu0pDqqmek8SrmV/bEl8sVW6WEJ9fDPfx+hghD4+/3141x5IXeKv8F1lB9QTmdOjMEuVyGM4qssNaO+jfDj4dHNQ6Q2NT3Ydy3nsD8Q7SFEobIRsfFMtOL8/71Ms/Q0kS1FhxZTv4z8wtOCUscQ1FV1Dr2tiycyCWgOIUZa3GU1U0saSiWEvL7CRfxJwhIluDw7jlXAysgBt0FEfkErPT7Kk/wAmOQxJAHGB71Pwbqv1kvg76+Q3voOiXRsRC2SHumFgpVHxHqcEUUxb18zhkwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDuvBir0eR/DOuljJ+Cd7Om+6qhqUpv1n+O6YS+INuE=;
 b=DbDKpmGqVSwCE+RKeEMEaz8ckOQY4ljnmV05MMzlOXjQFnChddqENsinXolqIqQRAKh7gep8a/aOabLwQJLRVnD93WZ0ViFASyyue5mA3vFPZAUx9n4jLZ3ZOu3EiqsKhU7rGtVYNdL/7Prwdp3szteek4QTmAH0iBZkeYuklPs=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4524.namprd12.prod.outlook.com (2603:10b6:303:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 19:39:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::add0:6be1:b4de:8bf7]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::add0:6be1:b4de:8bf7%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 19:39:01 +0000
Subject: [PATCH v2] x86/resctrl: Fix default monitoring groups reporting
From:   Babu Moger <babu.moger@amd.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        babu.moger@amd.com, hpa@zytor.com, reinette.chatre@intel.com,
        pawel.szulik@intel.com
Date:   Mon, 02 Aug 2021 14:38:58 -0500
Message-ID: <162793309296.9224.15871659871696482080.stgit@bmoger-ubuntu>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:806:126::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [127.0.1.1] (165.204.77.1) by SN7PR04CA0185.namprd04.prod.outlook.com (2603:10b6:806:126::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 19:38:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66cbe0f8-3485-406d-f4b7-08d955ed2d6d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45245B70E46224A49F3BA02095EF9@MW3PR12MB4524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvRDh2RbEpWLIjQb9cuvxqiA45jME/rAbnyiuIexfCa6fa6l7RP9Vlx2eXoS10VIjYh2Qo3YHA/cByP7kvilfgbie/j8RRULmr3JPv3s2FzKO/8nX+qi4q1SaSc2ekiLd7EBQYY2y/Z80XRqE/BbjgMlmjH6ZIJHrCmky9zxAuBwdjubJK6c89XwPUe+7TWYkpu7lq2ytNvuwlbEQ+mUCYB5LN7R2b7Wc4p+3mGmJX8cZzPhas4iWc0fIDVT2Kg6xGe81NSiiV0I2nXOQTO+euRtapEffd4DrfbM+g3AKzBIRvPvd0Pga/YvVlIoVgB0qfvXxhHsCuCGesf5rL3J+wcL/ElKq7+046l3EAfHsa4X2X1ScyGSIF2zwtti9E8qMlRr+6OE403X0raApu8uTG3nmX/KXsexeXVfOuefnTQUVDuNXLUS0mtBaltjEzqH7u21TpkDdZdw0IgE9z7UU2D7tj03QAV6TuHv01bE46MNi6v3Vqi6OLke75KRKtw46ZTX0Gm10Z8QE7jzcRBS594kX5grJzfOjxthvAJZE13MuGaOOx9Rp4q/Ng/i0VjpJYUzE6eSs3yAv7WWx6w3r2nf6R6lxWrea/XsZ4EoYaUYuw5cHpldOTZmcf9g9H5ZQMBVwBPeLn4UzkdqUsNpC2F2+pf3pe6rAaadC9MKXn67rmEg/AqTd3GJUzjqCgGeO4L7tlFBpbZWPiuxKn5GrzdxfH/Kq+5Jr7/LDXw3p2r+2SO0a4nsM9H08+6tJFC2XiNIeHp8HMhPsPaNnmJgK2UEhyRD4UsgLDgIafYoQTcG16b5fx0RwS7uh0j+J+VBm7fdAkOIxegWiC457rdnzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(33716001)(2906002)(966005)(44832011)(9686003)(52116002)(38350700002)(38100700002)(956004)(6486002)(16576012)(8936002)(316002)(86362001)(4326008)(186003)(8676002)(66476007)(66556008)(66946007)(508600001)(103116003)(83380400001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFKMHFRL0dFSWw3ZnZwZnh3TGl3aTJkcEZBZnVQOHBac3hlcUIrUnY4RjZB?=
 =?utf-8?B?K0QzVnlYVXg4WEVpU1llYUduUDJtS2ZqMUtlUDVmMmVIYUF3alBuUjByMTJH?=
 =?utf-8?B?NnAycGFKSWJNbUdRSXFMVTVaOGhHOE9aODVaUFBITk1DODdqUVRzeU1OR0hH?=
 =?utf-8?B?bUJzV2R3MmZyNUxnMlg5ejRmZDJzOFhRQ3ZMWnJRZGJEdWZIdHRVK3pBTjVa?=
 =?utf-8?B?M2RFMGIwUCt4a0x4TTJZNldLT2UvU1dvSW9Cb1g5TGo5dlMyU2Q0SGlQY0Iw?=
 =?utf-8?B?cTNFaWhHcjRVVEV6RmpGQWFRaStzbWhMcU5KWFJycTFxQ1lhdEdneUFIQmQ3?=
 =?utf-8?B?VHZ2VnFmNnRkN0lDZVVyMmxDYVFwZUJSRVU2dUpvZm9LRjZBdi9NWVNxZnZj?=
 =?utf-8?B?ZWpwa1ZBbWgvQm1McWdCbU95bi9jakhWVUU4eWx0VUMvSVFaR3g5NnlVQ1M0?=
 =?utf-8?B?MWU4ZU4yU29JYWtSZkVraW5IbDF6QjhMQWlyZnB2QzZjRkIvNE83VndveE9J?=
 =?utf-8?B?RXMwc1pTbWZQU01aMXRDZ0FtamZPWFBSUXN1cWcrSlBMeld1U1U3MHM3NEZT?=
 =?utf-8?B?Tno0bmVuZWI0VU56WXpoZ1lVTTRGZTV6VmJkVk9IMXp4bGg3R2hraUpNTTNq?=
 =?utf-8?B?VU1CWXZ1N1BHaW9TYUpNclNzVzVtazR2RWw2L3dtUTU1cU9nRWhuNjh6WGo3?=
 =?utf-8?B?YW9DYU1pZFI2N2xkdjRMMmhseVZZOUxkVmdZVkUyK3FHVE4zZmo2R1pLWnZw?=
 =?utf-8?B?VEFHdlUyQzI5ZmErWmhLMGNMUUduYktTM3dyeXVBTnBrR1FGWWVYUnpmb29S?=
 =?utf-8?B?aGVxdFM4Z0RsRlJzdVM4dHd3R0dhTWZJVE0xcmFGZFpvWVA3THJuNkMrREdQ?=
 =?utf-8?B?RmxwSTB2dVgxLzdCK2pESDV0cXlLSnBZT2hKdngyaUIwMjNVdm9BZi82QnMr?=
 =?utf-8?B?TkdVa1UvcGVpQzBjMFZUNlRCVzhobmsxYTdjaEJMcTBzV3NKOFN3MHVWQk0x?=
 =?utf-8?B?KzZ2YXZXSzZCRHkrOEVKOXhQWlpQRjB2V0dMZWNLYTBPRXM0NFNXUHVkTGRJ?=
 =?utf-8?B?UDRWbkw1NWsyRGpVc0Q1U0J4UnlMd2V2MERteXF4WVpMNklWM2VCemJmVS9Y?=
 =?utf-8?B?dWZ6UUhqSnlsbFhNeGhOM3NxN1Bka3QrSmFjdXBGcE1RUU5qcVowRGc3dkZN?=
 =?utf-8?B?WHRkb2xkUzZnS3ErVGdtNFUrZnZ1d0IwUyt1VXk5R3VZcWZydDdTd0JUZU1y?=
 =?utf-8?B?Y1FiZXd0cmpOUE9TN2RUeGk2SXM1cm5tdFBoRTByM1Z3WTRvVHJIcmJQRi9I?=
 =?utf-8?B?YXcxNmpQZUhmZjMyL2xPVFNraU1rNGIwQXRYc05XRUVzM2pkK2YxaDFXYytZ?=
 =?utf-8?B?WUozODNTRTMyUDIzMERqNG5mQjZ6aUlsSFVVYXVnWkdYWWF0a09mTG1OL2hh?=
 =?utf-8?B?OCs0STEweTdTVHdXOGZJb2MzQ0FvclU5cjJUTEFkU1FyY25LNnNLQkJvUWtu?=
 =?utf-8?B?ZU5YdXBnQU9HU0ZlcmVVeEVGNnJFL3Q4a3Njc1IvTXRRUmluNk93RHIvUklV?=
 =?utf-8?B?ak1hNHNteVZzQjFBcXFsdkcrQW9NSlpoc0NJS0xDVHg0Y2kxelpIVEw5WmZC?=
 =?utf-8?B?bkVYNS9ROXJFMGc4elFjR1NqRDY0L0VBMS9QVEFnM1NCWWV1SHByUDNEeGMr?=
 =?utf-8?B?Y2dkYzBDR29oc29TM3R4RldPWTFNL3M5LzZNMkVJQXd2WUlzR0R1V3hIMGxI?=
 =?utf-8?Q?1BAFcYdP1Cn3H9KiLL+I11hjNIixwLIymGve7GR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cbe0f8-3485-406d-f4b7-08d955ed2d6d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 19:39:00.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZBU06duthAMBIpkT0BKUVQEqcZz8YQf2cr9tyn6UKeKGQhY2vQBvijtOzBTWqqq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4524
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babu Moger <Babu.Moger@amd.com>

Creating a new sub monitoring group in the root /sys/fs/resctrl leads to
getting the "Unavailable" value for mbm_total_bytes and mbm_local_bytes
on the entire filesystem.

Steps to reproduce.
1. #mount -t resctrl resctrl /sys/fs/resctrl/

2. #cd /sys/fs/resctrl/

3. #cat mon_data/mon_L3_00/mbm_total_bytes
   23189832

4. #mkdir mon_groups/test1 (create sub monitor group)

5. #cat mon_data/mon_L3_00/mbm_total_bytes
   Unavailable

When a new monitoring group is created, a new RMID is assigned to the new
group. But the RMID is not active yet. When the events are read on the new
RMID, it is expected to report the status as "Unavailable".

When the user reads the events on the default monitoring group with
multiple subgroups, the events on all sub groups are consolidated together.
Currently, if any of the RMID reads report as "Unavailable", then
everything will be reported as "Unavailable".

Fix the issue by discarding the "Unavailable" reads and reporting all the
successful RMID reads. This is not a problem on Intel systems as Intel
reports 0 on Inactive RMIDs.

Cc: stable@vger.kernel.org
Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213311
Reported-by: Paweł Szulik <pawel.szulik@intel.com>
Signed-off-by: Babu Moger <Babu.Moger@amd.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
---
v2:
  Taken care of Reinette's comments. Added Fixes line and Added Cc to stable.

v1:
  https://lore.kernel.org/lkml/162499005859.4842.12410192091197461691.stgit@bmoger-ubuntu/


 arch/x86/kernel/cpu/resctrl/monitor.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f07c10b87a87..57e4bb695ff9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -285,15 +285,14 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >>= shift;
 }
 
-static int __mon_event_count(u32 rmid, struct rmid_read *rr)
+static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
 	struct mbm_state *m;
 	u64 chunks, tval;
 
 	tval = __rmid_read(rmid, rr->evtid);
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
-		rr->val = tval;
-		return -EINVAL;
+		return tval;
 	}
 	switch (rr->evtid) {
 	case QOS_L3_OCCUP_EVENT_ID:
@@ -305,12 +304,6 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
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
@@ -361,23 +354,29 @@ void mon_event_count(void *info)
 	struct rdtgroup *rdtgrp, *entry;
 	struct rmid_read *rr = info;
 	struct list_head *head;
+	u64 ret_val;
 
 	rdtgrp = rr->rgrp;
 
-	if (__mon_event_count(rdtgrp->mon.rmid, rr))
-		return;
+	ret_val = __mon_event_count(rdtgrp->mon.rmid, rr);
 
 	/*
-	 * For Ctrl groups read data from child monitor groups.
+	 * For Ctrl groups read data from child monitor groups and
+	 * add them together. Count events which are read successfully.
+	 * Discard the rmid_read's reporting errors.
 	 */
 	head = &rdtgrp->mon.crdtgrp_list;
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
-			if (__mon_event_count(entry->mon.rmid, rr))
-				return;
+			if (__mon_event_count(entry->mon.rmid, rr) == 0)
+				ret_val = 0;
 		}
 	}
+
+	/* Report error if none of rmid_reads are successful */
+	if (ret_val)
+		rr->val = ret_val;
 }
 
 /*

