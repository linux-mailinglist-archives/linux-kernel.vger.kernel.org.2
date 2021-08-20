Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE63F317F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhHTQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:33:52 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:57825
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229632AbhHTQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:33:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpyVCNYVWqKX0KlnQx7jugMfbY3a9nazU0c6ocAznVRSG4V3JHzOV1MuLqLHPZIKXdNZcMUzRKn33Z5GpwbMCRs8flMYDiuxqEy8PEkus6jQlvConA2k3i/uiogzLfUGx6/xlFER8Wsqut/xdW5nzugptNMy/b0zk8I91YMtffDbF/EMj51GCtvQUFisfsh9LTIxfiJkJQk2uSrE8O0cMucu5t0BY14jEelUjBTQSEor1rWXBNxFzs+IjlW2u3sfnowaCJ2d6pnGwKw59eG+9zK8xK8V8wfoNNL44s1ZPVRDdbsp3cCDO5eQXOXKjdwCnU6X5fSBbxnJwkMI+NRCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNyTfRS7S96cDzyW4cQcuHLoZd+TsB90GVBnK547XtU=;
 b=CH3Twu9FSDwpiA9x1SGL/85kp7Zv/O7xIi70kuizx4Iq9oh2M7xQpUfH/ZHTKzPBZ2nmZtt7WydlY+I3TpV1n+Bd4DWI04ZrVDLPPE+riBQSZaeBRypdyTY93/GU4Buq9DO0ru4vV3ycgVDDvVC2bTKh/e+DhPiPUNuVFnm044C2XymP5XnrvLO8bueQLmrKu9jOnkQZcfCer8hipkr38cpDe+1XuNaPfyDzQsVosL4Zfcd5E2SHXhNyzGyOhHLHP4jGdk3bVTp1BJD9B5HouWyNmMOruxCrnkF6OZfKZVnqIj9Kzmyt23cZPFbHLMT3h4NMHSBaIf/uyWrYXxeguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNyTfRS7S96cDzyW4cQcuHLoZd+TsB90GVBnK547XtU=;
 b=kHXhfsOovufd6O1y2g03iyxNf64yWTlkpSm1L6LN6xJe2hOz/RSDepCcEKjxtWbRfNxRWZybGtPS3vsSFiTUBMKbqlqXqZAuwzldY5ocCZjz2LstX3xUDE4s47EvlO9DNCC7y4gcBKbIs82mLSJyyeXSZvA9o5OP9HR/bWMrYwc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1805.namprd12.prod.outlook.com (2603:10b6:300:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 16:33:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3987:37e5:4db7:944e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3987:37e5:4db7:944e%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 16:33:10 +0000
Subject: [PATCH] x86/resctrl: Fix 'uninitialized symbol' build warning
From:   Babu Moger <babu.moger@amd.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, Terry.Bowman@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        reinette.chatre@intel.com
Date:   Fri, 20 Aug 2021 11:33:08 -0500
Message-ID: <162947718839.12313.2592762168334394449.stgit@bmoger-ubuntu>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0120.namprd11.prod.outlook.com
 (2603:10b6:806:d1::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [127.0.1.1] (165.204.77.1) by SA0PR11CA0120.namprd11.prod.outlook.com (2603:10b6:806:d1::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 16:33:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d1b9d07-bd47-4fd5-235c-08d963f832b0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB18054E0D75B18F93578C57F595C19@MWHPR12MB1805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6jGkQHwXnobE+FSkNIF98txWL7NB7HQ8hGSB01AzGGzs47PspScXxAT59z5EFLh/J0hB7YE1nJvO5UWS2L5uFaSelGT4o4whZNm5ZaMHelGMNmtY4w8nMsWWE+9wKYZqYEcOkGQdTVLfqmcJRZdXfuWyeNi3ILedxVtDGTgtqmfUwzejundhqYiRWF/SE5oduihiY1s5QpBQ3+qM9LbrQ/BEKPg0DP7pfMa4W3Ca4bkFlrAqTFQXiCvv3SOyDvvC3L63M2w+VJeC+yKIubAFH1DmXb8OnzXm6t9LCyyOG6/xdbWBznnO7Vx6l3bOANNPhZ+rCcQCV0B8AgrRT1ddqDDucXnedNvREhO1j6L8Vd8vc7eJl7D9AukwsN3FNFUk5Vf8Cy8kfxU+WmtmM6BJ/SfN/MLHkFYHFFAS93DbG2H7Ygo/3eegzULcs4zq8Seav50m1FRASWY1HIM4h/lFPXpchlDem58pBTrZY4LOKtxAF8DFMUYa/5BhK3v5on+A5pqjPZmZfKyxvRn00KHL9yryT9qX8fEoyQmk5Pbp6xySH2pr3VXfGTaCfQB4FS+9YMmtUDclE1Xzz+ybwBLxHk7PPXZGok8mFcY4VWJFamHI6lzgLzW4e2fO/WMfEkw5nHbJSm5V4immvJdkw8Vz5kflgEfGopV1fZpTBVV1PlNExwBILhgK/NbAysV5JxidTi5R6S8cwEbvf3qgsk9DHnxMqAUk1QCKvlXAGaStkUBDTz4Uyi2l+A+8zRTQp9jlo3Yxi/QxaF/yagBNLHokxD3fcbZ9xlJlnLMnQ2xLG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(346002)(366004)(39860400002)(376002)(136003)(966005)(8936002)(86362001)(44832011)(103116003)(9686003)(478600001)(16576012)(2906002)(5660300002)(186003)(316002)(4326008)(66476007)(66556008)(66946007)(33716001)(26005)(8676002)(38350700002)(83380400001)(6486002)(52116002)(956004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzJSeGFWcU5PZFRqS1lFSWF4TG1ad1pXWG5CT1lHVEs1NFdVOXNFUG5yNWxa?=
 =?utf-8?B?OU1LNlNvNW9McUJybW04NjZNSkRtakduVWFzK3BYZ2hyL2c2WVlGY0FZaFRU?=
 =?utf-8?B?dEp0enREdzBiNmIwcDU3SlRzSVdDQmpNQktGN2VBUk4vV3BZcm5la0hXWnpI?=
 =?utf-8?B?ZmtsOWk4Z1pVUGl2cG45TEdkTms0YWhVRlh5bEJVa1hOTmRNR29JUFFBRnRi?=
 =?utf-8?B?ZWJJYkh2S1BISmgzaTRSL0JnOFlnRksyQ015T2ZvUzBwcTRmY1FlTkk2S3FI?=
 =?utf-8?B?YVpSdVd6MmNlTDByUmRVaC8xcEw3eTloMmlKM2dWaFpRK3JXOVhiTGZDKy9V?=
 =?utf-8?B?SG5iT0QrNTM1Sy8yRzRKUHQ1clhZb0RVcjBkMFdqYnJxWTE4KzlTelZXanF1?=
 =?utf-8?B?TFNVZDF5U0RmeGNKRCtFL0lZc0VXSGNVQmZ3NnBYWjNUNVZ0Y1ZrcHhRRWZy?=
 =?utf-8?B?c2ZBQmhkcHBCWnNFNUhjVHE5NWdhaUl0MFZ4VU5meFp1amg4K3hoMmh0cjVB?=
 =?utf-8?B?UnBHRGFpdERLUWl0ejNNd05kLzNZSi9QMS9zMmpLUDBSUzdIUmxyS2IrN1ZW?=
 =?utf-8?B?T0NUVncvbGoyR1c2Qk5zajMzSEFPUlVPdmdHQm8wYWJUQWU0M0RybVo1amNE?=
 =?utf-8?B?TFpkb2VQbXpiZUhFWURaM2ZOMlg0RU9laFJSL1hYdUV0VzFPNm9WbUE2cW1m?=
 =?utf-8?B?RHVyUGNMK2o0VWlKWUwvaDF4cU8wMzRSTDRzOG9EaHZUQ2ZLL0lXSXdxOW5H?=
 =?utf-8?B?OW9HTlN6RGo0RkRzQ0VueG5wNFZqZVQ1YWwrRUFHVlV5R2g0K0JxR0kwNmNV?=
 =?utf-8?B?Q1p5amxIZUF2Z0pJRFJtS3FzRkJSNGlIakhkQnVodDh6UEpHQnBJNTlJQzBZ?=
 =?utf-8?B?SzNCRGMrZEZGZzRxYjZiN3Bxc0JXV20xSWtaUGZhcHVQNVlWK1JEWGc5d09r?=
 =?utf-8?B?dm5QUmlCQzVadDM1MXRkWUcrYmg5eVVlQmdlOVJaSGttc1QrdTBSaUZTUElB?=
 =?utf-8?B?YWRkT2xGY2hmSEtJOUorY3JyM1Z5cGJFajhCa0dWeFZ3eTMzMk1VeUFxMTht?=
 =?utf-8?B?dEh6Mnk0KzVKcFZzQlZzTzZiUUFVQWNjbVhtS0tJSUdmQTY0TTc5QUFieVpu?=
 =?utf-8?B?WU5vVkUvM0JXUHYwNlJoOTBPQ3RqZUNKRHlGZVRSOG44R2tsb05YbFZ6ZEc1?=
 =?utf-8?B?YWdOWDJLZTJRM1pMWmYvZ0lwd3JJTmxiZDdsN2VaR091dkF0SzZ1WVJWKzNM?=
 =?utf-8?B?czY4bU1JTXdZN1gxMVJ2UWJDbUIzby9nQk9DckExRnBHRlZEa0pzWkF6a0Y3?=
 =?utf-8?B?dURueis4enNQRGVXdHgyamJQNFgzSnovM1BHSFVCcVdvc2d5YlFrdUVLZzlO?=
 =?utf-8?B?QnVnaU5CRlFzSExnM0VFSWJZUEl4RmY4eUplSGhOUWU1QUFZT3JqV3Y0MGxy?=
 =?utf-8?B?UkFaMy9XZG40R0Ywb0dBc2Fqd2xETHBVeFdkV0hVTHpaWUdnUCtjUGl0bkVC?=
 =?utf-8?B?MDhWSFRpTWJhakdNblBwZEVYUTV6V1lyNGY3U04rby8rZlBodDN0dDhYS0xZ?=
 =?utf-8?B?dE8vckpXMDkxejAxREVOYnN1dGhSdy9VS21oc3VtRkZkOFhnVEVZcnp4bU55?=
 =?utf-8?B?LzdVZ3UvV283TENBNThaUGNYV25IWlpzdjY2dkozMmJxYjBYeWpGV0tYdExh?=
 =?utf-8?B?dXRTeThVM0dJdUZkQjYwV1FxSmdWUE5ibXQ3UFJQLy9HWHhnZjFtMzFxd1JD?=
 =?utf-8?Q?nFNsc7OB8XCYgG4gWhr7MtvmihpjsC9UyOfY7WJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1b9d07-bd47-4fd5-235c-08d963f832b0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 16:33:10.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YD0qj/iPO1SUBRQuRVyP9/VZ9DFZXg9QURhuHkNpZhAy/OfaaMIyJBKlZnzNuOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1805
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit 064855a69003 ("x86/resctrl: Fix default monitoring
groups reporting"), caused a RHEL8.5 build failure with an uninitialized
variable warning treated as an error. The commit removed the default case
snippet. The RHEL8.5 Makefile uses '-Werror=maybe-uninitialized' to force
uninitialized variable warnings to be treated as errors. This is also
reported by kernel test robot. The error from the RHEL8.5 build is below:

arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘__mon_event_count’:
arch/x86/kernel/cpu/resctrl/monitor.c:261:12: error: ‘m’ may be used
uninitialized in this function [-Werror=maybe-uninitialized]
  m->chunks += chunks;
            ^~

The upstream Makefile does not build using '-Werror=maybe-uninitialized'.
So, the problem is not seen there. Fix the problem by putting back the
default case snippet.

Fixes: 064855a69003 ("x86/resctrl: Fix default monitoring groups reporting")
Cc: stable@vger.kernel.org
Reported-by: Terry Bowman <Terry.Bowman@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/6118d218.4ZZRXYKZCzQSq1Km%25lkp@intel.com/

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 57e4bb695ff9..8caf871b796f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
 		m = &rr->d->mbm_local[rmid];
 		break;
+	default:
+		/*
+		 * Code would never reach here because an invalid
+		 * event id would fail the __rmid_read.
+		 */
+		return RMID_VAL_ERROR;
 	}
 
 	if (rr->first) {

