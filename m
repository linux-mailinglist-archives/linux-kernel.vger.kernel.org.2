Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF80381054
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhENTOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:14:07 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:53440
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233141AbhENTOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhxLj7ol87eOzfCZDaBimoxxgxvIQljGYCU/6Uza5yuGefO4d/l/hDlHWBWMsSDmqDXi7qfur4+k76wQ72zz5Pssd6nGdk4J+fnKMXWsHdfgSQo9h5K6RMCin7UHZ3gUvaDSbHN5HiqaeKefvxW06oDyOguZNkZ2OBWiTUYM3MpkqMJ9mcxU97VuXlU4flShdgZrgXIMje9OyXH2JJ5nRBnIsZER/5Z2N3Ms+f7AxINHa4LhrY4JciladStL5o7O1O6sLETLtFNzRz6JyhAbtYrkIUqt534/3Xmh1/m3jqwQa1A2lkzxVgyJben1TQeRYiu8nERCAqicOAshqGP/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7RTgSK59X90TKD2lKz5iQAdA1+iK+/3NluGnPGopSs=;
 b=QzQ3oPGxAot9bCAvpMPIaqovuXWGfhugM62fG7WzEeUf6QzZ05t4txl3I8pEuoO+PUZAbSSo+Oya+zVaHlzwDyrijD566yC+E84JafMFun7j0UTg4M6FF8zB8fmfn22KoYBvL+nVk+HKhKXOjl7JSodOHkOKmvSeW1r9o9NzMv2UvIgJ3TPPHkPYoCrqiX4uiO16JnENsNw/BGwS2+5ydi76zSwrA1DHe7s6mFikZFkK7HDFvZ8z2u6D/dlADItjUqZxEPMECmgcAOXAzeBfCUYBBeEplEnzCrxHsdt3j4Bt3X7gTbP996YFgZNGqu1uXpOD//SZG+7Wiw+AjGvsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7RTgSK59X90TKD2lKz5iQAdA1+iK+/3NluGnPGopSs=;
 b=0VspDVNMn8kXIlspJL7Gxh16+dYSOcOup8fkCaFcZ0FpGHfEtY+svybxsGVBWVw3qC5uVUTgw+JIKmHnk7XsCEh669tyqR2GRA4feVoSL5YZauMt9ka8Xug6rcNKN1ZLrBt0CVxuBJ2dSvsIMoxfmWO1c2c26vKUQrkXI2eyEkc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 19:12:51 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4129.025; Fri, 14 May
 2021 19:12:50 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <jroedel@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH] x86/sev-es: Invalidate the GHCB after completing VMGEXIT
Date:   Fri, 14 May 2021 14:12:33 -0500
Message-Id: <fa408ec4020d7ab056875ec8c80d793b75f20a39.1621019553.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR13CA0071.namprd13.prod.outlook.com (2603:10b6:806:23::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Fri, 14 May 2021 19:12:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4daffa44-3844-4dfe-3d7f-08d9170c446a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32748E3C15AA2F0E50DDC55DEC509@DM6PR12MB3274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMc0uFErpXR/wbLjWxZH708YZPiEcL20o+Y3EHuL63qVZ57OHmxeTXOSq6ujidioMjFtcQypkM5gG9HMN5uaWnl1AhAlH+TibMxHKwG5QzFmgrB6BTpMZL+7Ce139Gw10Wo4HHl4RQrsy72TEMr7Rchnfg3YhsOob4O2gqYqaVc0JbdmqwJ3ngIQdEUpMd0tj9tomqi6vWYYSSBM+lUV/2U1RW82/Ixkj1fV7RK3yiYPzLx18MCRZDovb3B8xy4En3Xv9uC49IHwdoMq0QE+Z0HNRBnkqCUDXAC6Pfl2spsdDLaO7XTLEPHWB4ESnY5iQLcyt98x7gLbXVfMzXGXDh3tQ6oODqL/hMDcdqiZ0Dzqod6KkOKa8Gx6ihKjmDGIqS4DWXYdn3UjO9jqNDUuQv+kI5ucVRWmTT9dL+x0erkO++hdlQhErtona/tUQr7H6YqrHA1o9Dt1rT53dZjSwvhkowJ6pWzRv7eb5H01nNEfXZrHixZAXFbhkOjAFma8Rw2+qWRm04ylC6b3w6CIblpjCcOXQ/5iW9Rr+u7XbqF67oEk2LeZvNOrlZhC7DrunOp6Zmq5mMY+nZ9lQn7etvdPeOyZT7KNkeUfRAtG4Goc37PeOO6XgH0KMHSJl9BhqeYEG1/EkS7ZzQUA/AfHlPvmFpuzo5EdEEoMJI1wCMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(83380400001)(66476007)(8936002)(316002)(6666004)(66556008)(86362001)(8676002)(54906003)(7696005)(52116002)(6486002)(4326008)(26005)(956004)(5660300002)(2616005)(7416002)(2906002)(36756003)(66946007)(478600001)(16526019)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dgV7t5+nOZCPipk6aQsv0L7QC63BUuV6uvNm2A+EmVgRLHFr05Ftf51UrSVc?=
 =?us-ascii?Q?wYebYcXf7GUm7sRwNsz7lP2VU3HBUKUO7lb7CniHrRQQauKAcOxPSgUVEZ8d?=
 =?us-ascii?Q?R8XsY8xi0yhpJIVj2GFWn+dkrjZWCD1FVTdBqa0eV5DulP5RFyeCfDKOGDFN?=
 =?us-ascii?Q?66w/fkSEBPkUiUS6aumlGjlHUOx3U3Y+iPUp33qbHVpG8OtFzU6QtRflVKm9?=
 =?us-ascii?Q?Ekp02b/xZC99VSj2v8JZhO7HPgSf6LbI1hdLBq8pr5RjikL/1wDY3Ku/zaP8?=
 =?us-ascii?Q?4kxOH2d6Xx1iR77ke+URS1Dw19oaOkJmTFB9gb1MaH67khNUt00Zv2rK2iZ1?=
 =?us-ascii?Q?wmI7UWX9q7hjXyl6/VHZu3rHHMUqdq32jgWTBjuq8kyOBcaLNZjbEXrTZsE+?=
 =?us-ascii?Q?NXzsCGYiOPI/3ABFHHtqxMcyM+Ym3kQKKa6Wtmw5YcMwbQjHZHuO+ETEQZ8r?=
 =?us-ascii?Q?vDsliqfju7I0MYSeIoYjN/bR1NjesC6Y2/vc96J9GgY1DE5AqaCf+0WppcoW?=
 =?us-ascii?Q?LM7AmvCB7/bfaaqneO5CvUPxYboOAXAifnFiI4YzLDN+a7XLD7QtwF0272ka?=
 =?us-ascii?Q?aAfcHqz+J+SntHDO1iom7s/067t31nXTKDdzEhFMkawzESJFb9hKMc2Wss2z?=
 =?us-ascii?Q?kG1IOVzuuHLpwR5zNvB7yv5kajnHJJg+PsE749iNVyYq9WX3p0e2jKz0qf5n?=
 =?us-ascii?Q?FinDHDufldqJjQDHEQrDKkdjDVYxqA6tqiO1HrYMnWMr1AbujCXJ48LKZHNX?=
 =?us-ascii?Q?XelE7SbTL4VEbwWBWfIWE2p0OaHTvtUSUQfRKSTWFDzF+okKtVr0WtFL1UUt?=
 =?us-ascii?Q?MN1UkEb6Uz2w8+tMbGKOzd4AAQDqTp7IcUrhawhHRFSwVsE60MlzfyH+BkSm?=
 =?us-ascii?Q?lt2Aa+4nY2mCZ5bwy29Ld4XPBj7BSGc36/2XBxsumhja459Zixcx19PYgKMs?=
 =?us-ascii?Q?+cyA0gGpmrRLqpO+zBCYwgnlvFnzdSw73ZsBEZR5eUPwrGPIl/HzXJ+6DZqz?=
 =?us-ascii?Q?iEwETxSttN0Hdy9XzieC1akvPaLmsxnm2z7KOu0ILzArP6YDL+OeZryqRsl7?=
 =?us-ascii?Q?hRY5OEZUBp87FraQ6t/9DoRFXCENR8Gqplcp8G3ap5Nq9F1Rwoa16EFSmNqP?=
 =?us-ascii?Q?kRnRH5XG/q5DpvpqWtS1fZHiGIHRsBvpflWjQ9D/jjrrd4r5V33BTGvCkFos?=
 =?us-ascii?Q?o9gIgiK+DsAvpJP1DKbMsiowZzPQaGMkoJ0KJHSIEPrC274eSEKyDKnaRGhu?=
 =?us-ascii?Q?ZbbVxft+h7c6psFEDVFKbpUvPQw1y6n8O/4TIUA5EbQyu+2ofih3Mf9oUHjX?=
 =?us-ascii?Q?6xoM93FFwkjQh6ta08FKxnNT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daffa44-3844-4dfe-3d7f-08d9170c446a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 19:12:50.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiQvt/A5Z1PlcHuO88iBChJb4YPc/sw4LiTsRY6mfEDEmfvxpx0lqJR361lPecnSjA1WRixPgVOssBLrvGjwUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the VMGEXIT instruction can be issued from userspace, invalidate
the GHCB after performing VMGEXIT processing in the kernel.

Invalidation is only required after userspace is available, so call
vc_ghcb_invalidate() from sev_es_put_ghcb(). Update vc_ghcb_invalidate()
to additionally clear the GHCB exit code, so that a value of 0 is always
present outside VMGEXIT processing in the kernel.

Since vc_ghcb_invalidate() is part of sev-shared.c, move sev_es_put_ghcb()
down to after where sev-shared.c is included.

Fixes: 0786138c78e79 ("x86/sev-es: Add a Runtime #VC Exception Handler")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev-shared.c |  1 +
 arch/x86/kernel/sev.c        | 37 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 6ec8b3bfd76e..9f90f460a28c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -63,6 +63,7 @@ static bool sev_es_negotiate_protocol(void)
 
 static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 {
+	ghcb->save.sw_exit_code = 0;
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 9578c82832aa..5ccb0218c885 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -221,24 +221,6 @@ static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
 	return ghcb;
 }
 
-static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (state->ghcb) {
-		/* Restore GHCB from Backup */
-		*ghcb = *state->ghcb;
-		data->backup_ghcb_active = false;
-		state->ghcb = NULL;
-	} else {
-		data->ghcb_active = false;
-	}
-}
-
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -461,6 +443,25 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
+static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (state->ghcb) {
+		/* Restore GHCB from Backup */
+		*ghcb = *state->ghcb;
+		data->backup_ghcb_active = false;
+		state->ghcb = NULL;
+	} else {
+		vc_ghcb_invalidate(ghcb);
+		data->ghcb_active = false;
+	}
+}
+
 void noinstr __sev_es_nmi_complete(void)
 {
 	struct ghcb_state state;
-- 
2.31.0

