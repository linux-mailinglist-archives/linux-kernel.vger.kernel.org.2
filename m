Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C123B779F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhF2SKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:10:12 -0400
Received: from mail-bn1nam07on2082.outbound.protection.outlook.com ([40.107.212.82]:48867
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234874AbhF2SKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:10:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldm0NjLj9zXHICGlJf2Bmtqa1XnN2IuZkXLLQgeEtKxqUl97WOucK1tu6qX8LpCu2Jj+GCTc0ouXRPDnEecp5rKj2lauuz4Qxgryk4SJJkcnvK21OfgzXozp51pI2uOdUO/684+HISqsgpMWbDTmVV5DZZpQlmzkKYWbXdnF7MzrbU4pYoHjk075F0SVoP6+el6yFARUQLxdAWWyq1Tor0cGz9LSrb5/4HfVq+6H7+afa4M/b+fc4fIv9nHrckfqjrZWKc/odSCEtVpS/LDLqoFjZh7Gz9Z/Jth+KJYtA3ay2by7TcUjl0yhLiCoYWQr/M9ne7p3RCQjD8CKE0Ss7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUMvQJfWHS3QvPagVbUg1uob3fY5aVgHYJJf676xCaE=;
 b=gOyjhiKPznobWUXh3qHO+Z7m2hOJg7FT4VkW3TiAMfTdAUaKvXDAAPGEr2QjnOXsPJUDDo8vk2TxUg3MtKilVVNGvR5n736L1qDLnvwoKlMUZvqXZ1dys/mzOBVkLxGVHxtaVv0ZkY4iTa85LO2R26ijUk1Vqagra3nkcXZ3Xlkgs/n+VODm1XmTzlBBT/cu7Cr2CmeONxdIuV1wu07NgJl//Ki+hzfJq++bnXtbPbkSsiNy113iO7gwqEyDqSV8RYsaNnp8mRuOK1QSD+hRSgFxSPZOn8EHnPKq+/OYfWA3HTawe//wB7VcZr9Ez92DzYeYLvJH/HS7CkY64d91xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUMvQJfWHS3QvPagVbUg1uob3fY5aVgHYJJf676xCaE=;
 b=FBY4vzbNP0JWvUYJTPU8InIPX+cZUtIQYyoxSPY+VB0nYchzKPAzUqxGPBvhi0vNftBu/szitpEceDkCv3LiNOnH3y02Xf2TlfdjEs9BAMan47LY6LXZAHn0pn1eTA/EoeVLLiOc8EmQVzmy5ViyXHa+x6iZceYvc78EKAK7laY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0255.namprd12.prod.outlook.com (2603:10b6:301:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:07:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7%8]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:07:41 +0000
Subject: [PATCH] x86/resctrl: Fix default monitoring groups reporting
From:   Babu Moger <babu.moger@amd.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        babu.moger@amd.com, hpa@zytor.com, reinette.chatre@intel.com,
        pawel.szulik@intel.com
Date:   Tue, 29 Jun 2021 13:07:38 -0500
Message-ID: <162499005859.4842.12410192091197461691.stgit@bmoger-ubuntu>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:805:66::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [127.0.1.1] (165.204.77.1) by SN6PR08CA0016.namprd08.prod.outlook.com (2603:10b6:805:66::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Tue, 29 Jun 2021 18:07:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2043425f-10ed-4732-c3e2-08d93b28c918
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0255434098B81DC1EFCFA18895029@MWHPR1201MB0255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: az9CBOXFvweKrwHDVzIxEr2Gv19i3UjgDOFSaLokKwCPjj+Bosr6WvVKUL+ruRbgVrmxAa3WfJjaTrfrfWm3LUPcgW5y/H1wrXjh6kN3YoUf3/1EJmQ1LUseYOkJVYIYoC/lrmWT66xoYSkaREeHyEjwXxPcDP6N8qghONm1wwgOZPabizXGQqGSPFkjdYsQExND2P45geB4VWEtTLkVu29CbAmhmuUqUGgvckxy9eJFpyBkuVQrCRiGFYkqAm1V4zNeWCDalmnyvckwqSXYbteL37PNb3CCwYu9JrzGf/RFiMxfI33rExoh1kbMdBkaByt0GRulFBk4K9HAwv9It7g2WoPMkk9/cYZ6EgKlqljYmiAzHH7vagPXNfhojXbyPv48dn35KEAW1S8A6UzyPSAxuoMEl1GTVovs4CtngVfnGxphFRaFfJlJEb26salQjQeaqzL1KK+IRC0xPX7Q6bZNfY/DuF+e1I0smi3TuLMizmXD2hI3tFKNtIHK4rpcZZ7j4Uz712ZcrRR/VM/4yd8QkJVd+IwpKBa1vT70Y+uaTMroyF0ST1aPRWFS4SWczpCabACDlg6P/yCSv5mhmh13NWmVz/55YDar5rEpZOJkL/+uHNDZD4ItecnjG2hdAKQ5TJ6+NKh5aeRYW/YzRIfsN8NvZiA28mMhpj+6LshHr5yFo2iphJHTgAxDFY6YqMktVq6hkwnP/JaKgkUfqmZA2Yj9E6KQ3K5xuSw/U7txzEfmX31UpFgzvbIJKBXjFdwyODSlTdTxKxBy6JoMBBzC6vLkBd2OJQCoxr3/ixZ71TDHobI8kavB1tkz9YSb1j1EYeyWRBgwVSEp3RnPlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(33716001)(6486002)(66946007)(5660300002)(66476007)(66556008)(83380400001)(478600001)(26005)(316002)(2906002)(16576012)(966005)(4326008)(86362001)(52116002)(186003)(38100700002)(44832011)(8676002)(38350700002)(956004)(103116003)(9686003)(16526019)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlsbjh5MWFZUmpDK0ZLM1QvWG9kZDlzMlppdEVGek9jenhPL01Wc1FrZVQv?=
 =?utf-8?B?VklBMWowbEN3QlF1a0dNTFZENTNYRHh0cURjYlg3UG5FTDBPMXpNcjd3a0M1?=
 =?utf-8?B?dmxieU90WEVNZzZ5S2d5RXVMN2hmN0RydjZ3ei9LK3ViREhMWDFvRjBvZjZa?=
 =?utf-8?B?TzB1Ymp5RGp4KzRUeVlVVXNCZkFJYXR4ejJRUFAvdmZ1VkUzUHp1cEFBamM4?=
 =?utf-8?B?bG51QXM1YUhLWnJ3NnRDZDd0Q2JUUjF3TEZkYVdTVTM3VzlrMFJFYkRaUE9r?=
 =?utf-8?B?YWsxYzA2RDBQOWY2UWkvV01PMnpNdlpPYXlUSEJTZ3cxc1E3ekpvczQxMGdU?=
 =?utf-8?B?WG9Cb0t2M1hzamQzN3NBL3JzZXU5cjBQZDB2bWdKWTB6WkV3MmZDYnRISDNU?=
 =?utf-8?B?SVFGallyTlFsazNqcStYQ2xxeDlvaDVHRGdTTVNOaXNXOE5aTGJsM0hnVjI0?=
 =?utf-8?B?MVJaa1hSNDM0eWg3RXVkNFA3YnU3MWpyNnJEK1puV2ZFK1VuT0NaNkRCeHJo?=
 =?utf-8?B?Yyt1ZDBjblNaMjkyaVJNMjlQTlM4Zjk0MFc4U2lWWTJKUkNFR002dEdmS1hO?=
 =?utf-8?B?MzFxcEcySHM4SXRHWGVRTlBCSEJMR0NJTms2QkFGTVhkTE1Bdk44N3h0aGl4?=
 =?utf-8?B?NGthNy9CSkhnclNGYWpudVlnSGNaWkcrWHRVdWEzOGJPM2JBQ1ZLN3FwMnZ1?=
 =?utf-8?B?bGp3WVI3QjE5MjRka08xUU9vWElNa3pSMTdwbVNoSWFkMENLSHR5SG45QUxh?=
 =?utf-8?B?SXYyd3Y0dmdjQklqd0g4WlppR1BTU2N6QjZmMzVubWpFMHV3MmdyOTRDN2hp?=
 =?utf-8?B?dG1HRTZZd0FtZU01YWxKeTlDNC8zS0FoS0twVGVyejhvb3U3Z2ZFYzhGcU1Q?=
 =?utf-8?B?Ly9XMFB5QWk3VS80UWlSTUpxa3lydEVIb0QxMUY0WHhWbk1POVJnTHZkc0dD?=
 =?utf-8?B?UFd0eC9NTnhRQktFQk05T2ZBWXIyVXR3cXNYVlYwMDdHZXBtMEpVUXRPZnha?=
 =?utf-8?B?M2s1dGp3R1VUZG8vNUtyODdJL0hjaTlJUUd2U2xsVVdVakpyaTVNUlJZZ2t2?=
 =?utf-8?B?TlIvemJ1dVloVW01aXlCVmY5V0hlaHFKOEZITkMxUlZvNE9LMlQ2UVo5MWZx?=
 =?utf-8?B?S0NlL2pRd2Z6Ty9BMWlQZE9yLyt6S1ZOOWpVa1VWc2k2WUtRcjNsdGhrNmdu?=
 =?utf-8?B?V3YyVVZXeEt1aDdMQ290bmxZcDJ0T0poZVBrUGNYekpjSXdCRDdoM1RiZ0VN?=
 =?utf-8?B?QlBjTS81U013ZmdBa3ZBYXZzOWM2RktwRlVHOFVqQlV4SHBOZVJ6Q2JobnlT?=
 =?utf-8?B?eWtrUHI5b1IxcGNEczJ0SEd6TDJCYWIwSHlQcUIvYXFhWVVNY3A1bE9EVE0v?=
 =?utf-8?B?SmV5OWVoM2VFUVRISTZrTGdULzRNb1JHRm91alU2ZzJ4OVE3a1pmU2t3ZVo4?=
 =?utf-8?B?VW5GcUFjQk1WRUpHREZnYjdMOXc3MU1OT25za2hoNy81eERSVXdOVndranRq?=
 =?utf-8?B?d2Iwdks2WnpHVUhkVXhiM2JJNUQxY1lzZ29UVEpVWXZtSi9XVXNITkZZTU0v?=
 =?utf-8?B?cnZDRjdCQVlyWlBXNE1KVzA5MG5kSjQ2UkVQS215MnVOdXJPMmVUL3JIWDRG?=
 =?utf-8?B?NU40ZENEWmtYQk5HTUlrRGlIM01HS0Mrd2pCSFJxaktocU00Yk5iaEw4Z3VX?=
 =?utf-8?B?YXI0TVluSUFweFdnQ0p2TU5kTTBsaTRmemFEN0ljOGt0WklnTjRFMVBnRU12?=
 =?utf-8?Q?T/atkiTUr1eNUOplSaEqDa5C1N3OTBMdj76y8al?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2043425f-10ed-4732-c3e2-08d93b28c918
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:07:40.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOweVk1ekneAh4J7DhfStzzKjDdVSqqHDbtb98Y3wQ9zR4k1vbS4uRGPW30QDgtM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0255
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babu Moger <Babu.Moger@amd.com>

Creating a new sub monitoring group in the root /sys/fs/resctrl leads to
getting the "Unavailable" value for mbm_total_bytes and mbm_local_bytes on
the entire filesystem.

Steps to reproduce.
1. #mount -t resctrl resctrl /sys/fs/resctrl/

2. #cd /sys/fs/resctrl/

3. #cat mon_data/mon_L3_00/mbm_total_bytes 23189832

4. #mkdir mon_groups/test1 (create sub monitor group)

5. #cat mon_data/mon_L3_00/mbm_total_bytes Unavailable

When a new monitoring group is created, a new RMID is assigned to the new
group. But the RMID is not active yet. When the events are read on the new
RMID, it is expected to report the status as "Unavailable".

When the user reads the events on the default monitoring group with
multiple subgroups, the events on all sub groups are consolidated together.
Currently, if any of the RMID reads report as "Unavailable", then
everything will be reported as "Unavailable".

Fix the issue by discarding the "Unavailable" reads and reporting all the
successful RMID reads. This is not a problem on Intel systesm as Intel
reports 0 on Inactive RMIDs.

Reported-by: Paweł Szulik <pawel.szulik@intel.com>
Signed-off-by: Babu Moger <Babu.Moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213311
---
 arch/x86/kernel/cpu/resctrl/monitor.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index dbeaa8409313..9573a30c0587 100644
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

