Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AD37F31C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhEMGfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:35:24 -0400
Received: from mail-mw2nam08on2076.outbound.protection.outlook.com ([40.107.101.76]:44705
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230177AbhEMGfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:35:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDF80bpsiVMpkRmiCz6YUcQzQjAZYNJfkkI3zc7aBoWcU5uEeeYcuenfmsL5s4E3lt8TK5ljfcTPk7dAls2sFR8YpNPkGlFFcguOSDyVmftVwA+yguc1qjqEx1JpKSnjFityRqpbOsHBryzfeXMRYL2rY92y3fGKlDibE0RnYQa/fFBSUxNkEC7uvwWJwwSa5CdT2HICeoe8MzIuvdzoE+2kL6LQNGZ8yOap+Nw6STIdpC4GWCtUFZCU+uBBY82SMlQHLlz4aLric8SHfVUsSNQGl1VZ8r25niT8GGn86p4yK9EMjD1/uEGvEkOCdJ++Rfg2ubXVmtc3OQIJp27+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZSwCrySz/FpeBQ4u5iT5G/hdy4/r8PqE2BlHIAYLLU=;
 b=gM5Z0ZaeHqZAv/PvjDiBB+k8FD0orZ5ZHvzDVTe6D/7Zxzg+V/eFjHLWBJVTUtYDctqDDE0KYukLvtv5O5y8DozHU2aFVD2ONbktQHMiE6kZUn1NTQ3Y/2B9F5uxt2puCIiHEz1QAq6+qTK86DxsIS1w1ENO9XnfKW0MZtQabxl7np6MT8xPj6tlkXUitf5Vl04zM68GMK98w0uX7Zs503frJaV2WGWr0WGhufSyFxsGabfX1tCbdQ8hPWwzcbn67nxtFpgXyOaLPzq6LGm9F4z7KhiVQ6VcqmCmlj5VzzUaFA04QwmZzF1CyY5h2hpQY9ACvyvNXBcl5yyzQUj0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZSwCrySz/FpeBQ4u5iT5G/hdy4/r8PqE2BlHIAYLLU=;
 b=TtjXjttQ9rXZ2FpN9ymJlnSNQWLOCIFlEBij8AJ4pQyYnVfSIuWOlN/BpDbmO9VGIH4eTqNvdULEGDq+T6waIPyw6j3WNZ4oc+ifGAOEWqeF05tcQ+7znlFpILBDKuzqDnqtBzzkuXyfC8XgD/gQbwWjD6KNfOf6SW9X0TIOmlA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6140.namprd03.prod.outlook.com (2603:10b6:408:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 06:34:07 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 06:34:07 +0000
Date:   Thu, 13 May 2021 14:33:54 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] timer: Use static_branch_likely() for timers_nohz_active
Message-ID: <20210513143354.096c6baf@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0376.namprd03.prod.outlook.com (2603:10b6:a03:3a1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.50 via Frontend Transport; Thu, 13 May 2021 06:34:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 322e58bc-4a51-46b0-5f8f-08d915d91be0
X-MS-TrafficTypeDiagnostic: BN9PR03MB6140:
X-Microsoft-Antispam-PRVS: <BN9PR03MB614000A8E1ED3D30DD62101FED519@BN9PR03MB6140.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /79Qd+abrH2OQgp86UUDlDFlUlhxAA14gOgXa/DnB7+xfFtkQs7OoxYWRf9imH4GUgLpZubFaT5PrnvhcEwDDMZMGnj3pYKH7SzzkXxx+DdpDlBo4xGDxWVPzjsFn4vbQAei466v+hi1QBedNaAYV8ln/qRkJtwG0VsxXMpTBIUk5CCyQ199ZVSC5zYVps6rAKhUgJ85XBsd30tQGajMsY4YxFnKJJ0qa4mmWLAW5KzynUQglSgP++Fsxc36a4CPzPn3dWhUSaFma5IHyz9RXjfqwOYS0CPxFrzWLohRm0D2fiwLU3MlqrZsFgC3HSmwzhB2Am1xevpL1ShiwZQU4PPUwt9wQ4KcY/ZQcQYTpZutk4ptrBQcGsofFuljTqFz1NfrfFNxNzDYzB2hTz5Wqa/15cEm8nzteAlFYd92DWIg/dBmP2jTSTNYDYm4tpAXvHPy/hw8LsX8cxIXafFezvupL364Jg9LasOOu4AxkD/ZYlkLfkcfEdJsvU71NU9O+bqnNf85YSRMPoUGPtBVR9vl8A3eRdxxELkLCNS3ECUmP/hZVCJrd3s/aGcqCaDqcHvYLs2MhnCa7TY8W2V2sJ3PKK/g2g6q4M52FdOrqpCN2PkLn6qe+dRY8J2tdUvIL3cT7bIOTkIv9Ty4AM1FJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39840400004)(346002)(396003)(136003)(86362001)(4326008)(66476007)(1076003)(316002)(83380400001)(2906002)(9686003)(55016002)(66946007)(38350700002)(52116002)(6666004)(7696005)(110136005)(16526019)(8936002)(186003)(8676002)(478600001)(6506007)(956004)(38100700002)(4744005)(26005)(66556008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?f5A40bXhOcv5p8aa4APl5wh+J2kyuPhrEiymi2t0aZXa1bLa8ElUh14Vpck1?=
 =?us-ascii?Q?KcBJfQM2ll2rxPGvwTELY9wQWTrZxRVl3H9m9HGfH4IgNkgRmv7r0VOkCifC?=
 =?us-ascii?Q?o1U9eR2kDVwqynzLib3Ukkrtbspm+Vt6Yx2IlYDAVpyL+zqmi3R4gF5QF/aw?=
 =?us-ascii?Q?cJVYLFCJXdEHYqDBcif5jzLyXiDS9lYYxhtqSeHyc3ymCCiwkjNaigb9naPM?=
 =?us-ascii?Q?fRvTzV7bvMxsjAcTUwW0Xwv/Tm8sDH6kRrItvLr0qsrgluyPZXiNPaTp+G1y?=
 =?us-ascii?Q?PAuCAvQeZhPbTsD5eCgDKpMiOGIZv/RywAFpHgzI/xnDHfH7Sv4NTW6tVLli?=
 =?us-ascii?Q?nComQ49hjdQ7jp2AVCxu2ZJuxsef0FDZrrLttljl9lhn3R+7/v5XXymH+gx1?=
 =?us-ascii?Q?qgQQg2YzUKQ3uPul/47g4u8axo6niqnosSACklu9PaXazupnrfwrwBQoIKl9?=
 =?us-ascii?Q?IlORJnAB2FxvVaG14OyXWI6iFDkFDTdAk7D52yPv+eOOQHaiBc4EBqrNSzdz?=
 =?us-ascii?Q?Ib4wGnCvmkfg806fCiNHwUAsFyT4dmDIo2Xdkvb6vTuFQqn49iPoRD2ojGTH?=
 =?us-ascii?Q?RrvC5EH1ZGWiwoOfTwOUpyDRmrNfq39sgWsLC0s0Qrkq3g939Nk4ojrvGcgg?=
 =?us-ascii?Q?BIcpg0lhjsnyc4Wo9knPRBpnOWgR3TufwpOsPuYDiVIXuWCILUrluE59MDhK?=
 =?us-ascii?Q?jJpIXTwPG1lKtaxeHh8+/XqpNPQ19a0lo9n/4MjACPexMYGurEtBfWvBxo5B?=
 =?us-ascii?Q?JFHWyvc7oKDqwayHcOBFJsoPmHicyapdJXcxu1a4Lw6XAcPgeYp1cv31K+p/?=
 =?us-ascii?Q?86G8ia7VYQq0bocBruvEY6VEYrxVVHHT9yLlsx9VhMbB8h7FhOzrQP+pmUM4?=
 =?us-ascii?Q?ezu11JH6Llq0ZajZ6vqRUkoIGb9ov4/HPIRT8D+T5RqWlWIrhlTJW0rAy/CE?=
 =?us-ascii?Q?Q/kpTlJmJPeMbXQug3LKpINBRp8eKElSH3oe/fWrKnPMmxbfcMfeEqUVj8St?=
 =?us-ascii?Q?q8DL8Rc0yZ4xUoxuA3HZhfLdSirDYL/N8yfEr+uZIxN9E+cnxUV33b3EfVAZ?=
 =?us-ascii?Q?zagdF5o7YvqzTipGtQxQP1vwRqnzSXz+43I4IO3nRTz4h2Oh7+GKeW9wkDSc?=
 =?us-ascii?Q?dQThYdux2idI36Ewc9MM4eQ4q8Q8LGCKKWeHoZvngijhm4W8L8rCDDX9JRj9?=
 =?us-ascii?Q?1sNgnQ+z2oRuiLiV2Q6u2sKRKJzgn8QKdo0iRlpmTC2f3ENAFVgJlJoU7E2K?=
 =?us-ascii?Q?NwA+j8H0LVIEM74ZgPgBAqG7Ct2bJYKtrKa8aOwGcBQ+OGVpUqN+JV3sTruT?=
 =?us-ascii?Q?opRYum6oDmrrCB9Z2oTJtsF8?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322e58bc-4a51-46b0-5f8f-08d915d91be0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 06:34:07.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lwsDlxyqSobGJ+lNZThlwTn+PLldzpOvd7z6Q7Vck/HRDtAQua6a5byhoWH1zcXBUgE8RJvjewj18BRtLWSAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOHZ is likely to be enabled, so use static_branch_likely() to
reflect this fact. This could improve the finally generated code
a bit for the most likely scenario, I.E save two "jmp" instructions.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d111adf4a0cb..40d4fe7fa207 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -265,7 +265,7 @@ int timer_migration_handler(struct ctl_table *table, int write,
 
 static inline bool is_timers_nohz_active(void)
 {
-	return static_branch_unlikely(&timers_nohz_active);
+	return static_branch_likely(&timers_nohz_active);
 }
 #else
 static inline bool is_timers_nohz_active(void) { return false; }
-- 
2.31.0

