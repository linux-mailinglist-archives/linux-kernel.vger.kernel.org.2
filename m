Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80B30AF3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhBAS21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:28:27 -0500
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:60768
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232776AbhBAS1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:27:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUeMH1d2nRxiEKFDSZ4yoYNIRcq7otAc/bBjdEOW/xJ1Jm6H18U8wsgwvGL79ZHyXIKVLHbPnT8JyxIueCTolOMBNHAUUxeXh3Vdwj92KRu22BmlIDTuHQ1a/e9zdyM1SaDiSlRDEj4pq3m+dGhNEVNhu47VjPuIeYAKCGneQBBr65JHbqwFToS+DyOuIXHNLqoP8zlqT5vdALRIpXGFCfr38hE9dsCMrvmX34tYY4vtGARMAGxUFfI3qtr21ael1+lFApTrJFC7jXwueU7/tHfPKnP+YvIUZlZ77me3FG85ye9PLaHnIa2WkyOz2jNlzCgAhAkmU3Kr99Pd4Kl4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFIJP/PTLqytAC5Qdf0gtOcN2xgKECHn5IOOsx98rRw=;
 b=GXpU+K+lV/4F12Z+gvh7V9Vt01SJEKIdxoNHK/KALAquhxUhw/pKiEGJJi/p5LCB3LWpzJVz35a9D0wSXyygvhubf82Sbu+l4KwdW7S8EA0QMmz4zrJNB6JFJVl4qTqPvDV1bdizOyF8D8Nog05fPlvTgED/v6YD3OYNUlrI6DVFXm/+OGOirsRviz0kwlenCV2ypVXajWZ5+dLXt68Bu1kuwkXVIliTbhutx13FgIhkJZMBo41a3/F3gWrFt5P094Z2pblPGoic2MHZfUdZkr5wvH8I6lGa7ghEPrFri7bATxm9h4zcEQPU7P9MnAWs1t5jT8jIRi/8zwxL1DisxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFIJP/PTLqytAC5Qdf0gtOcN2xgKECHn5IOOsx98rRw=;
 b=Dml+OUEm37rHgwg1qKcAtmpJ97c0ZgFeTJ3fbFLqYbB0/TulNf4+ZN15cDoNgSIVuWVnOu8fyX36/8a8ilOiqK7L5uKSSWLXvNKlpeKn0Yx8/DBWv2tEtJxktZthNoHbnuE/IkHTwdtL/2pKKH6xc9Z923D8TLr0W8tKddhKxUo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Mon, 1 Feb 2021 18:26:40 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b8aa:f23e:fcad:23ee]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b8aa:f23e:fcad:23ee%8]) with mapi id 15.20.3805.025; Mon, 1 Feb 2021
 18:26:40 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/sev-es: Do not unroll string I/O for SEV-ES guests
Date:   Mon,  1 Feb 2021 12:26:27 -0600
Message-Id: <3de04b5b638546ac75d42ba52307fe1a922173d3.1612203987.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.30.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0117.namprd11.prod.outlook.com
 (2603:10b6:806:d1::32) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA0PR11CA0117.namprd11.prod.outlook.com (2603:10b6:806:d1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 18:26:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 663fe3b1-d780-4190-de5a-08d8c6deeb08
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3369209744B401A417B76C5AECB69@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bq4EWYhXpERBAjxH4bIr9umWEzCBCfqaGUxZnSCqRm0SMXr7qcN2A3Gf0/bAqWeNyHK2fZ4n4n/TaXlY0P0MCpndAxiDimAP8PAyxhZAj6UJBBjcorlUw+vfpB3cKBkT8MeHMOKu/UIIrlDtSefoO7kvnkJCUCdkLoBlhv06M2xjzyx2dFY5tROtuSak4eUUR9tEE72aRE50ozga6g1PzavYIKLfir5sozg4AdDWJKQ1voedX/pnM2tjMZkk5HRzmgQh+X9GC10t65g52mESoDLTC6S0VMTZsICYmsGBom3j7rGEYuEMQbP3PgzdR9AoYJNYN/9YJCd55oeHCsfn+dKH/i2U4AJ85fR46HK+oafzJxQA1dqKXjiueNjd4aGY+jquopXTEK2bCfuqiE1cmFukjb+nu689vX1yxgVt0wKjtojfZK3mAbWAZx4kcjd7DtXw+PfIV52QdfXH0nx3Ecw+5R8CGw6tWMG4KF1Wv9tqia5HuyT0PI706e7U/jnj7atEsrzWgZ01vAtpCkWSmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(54906003)(8676002)(52116002)(66946007)(478600001)(8936002)(86362001)(956004)(2906002)(7696005)(2616005)(83380400001)(4326008)(16526019)(26005)(186003)(66556008)(7416002)(316002)(6666004)(5660300002)(66476007)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4TmE5x29g73J/Wsfm1n1R+gkIC/HRYrXetPrMtWlG2oC6P0Tt7R3mnrBg8Jx?=
 =?us-ascii?Q?REP+94WE8oAEc0zCdGHXU058Kyq8CT16QqxmxMp0CDaVK16kK1gFqUC5p45H?=
 =?us-ascii?Q?UciJdUw/tiOUY9W9tc7eUNLezERJji8dGTmQ0eo2S8lRjtoDwySkFyO9YMcX?=
 =?us-ascii?Q?Ry2EBDQDynq7NPq/RAYSEUdSn8yLnJBZfCODcMEske0wMh0beUtTzZyG6znT?=
 =?us-ascii?Q?6ZCNzfmZdyxoqx2ecCFfT34BP64U9QDuyaGxqdDVASBqiCEZ7DCvx7vad33A?=
 =?us-ascii?Q?tmpPBcAExjFXGk7vyqblAkr6CUJQNWg8vssGjPxrc8ODYBqB/hJfj2i4Ii3V?=
 =?us-ascii?Q?3OQkfKzFsEddb0Nk22hywsdRVdAVe661E23mVjKGTLzK/OSsFn+4VJFxklmu?=
 =?us-ascii?Q?Ts4RoOOrqaaTS9yLsRP2Za6qtF6Tq/J23GH6fPacIvL8F5OfIzWZrvvWVJlI?=
 =?us-ascii?Q?AN3fO+3Hr95oSXYvEcdQOpRGAjljOf5L5lPDOaZXbX2RlZjBH39Nh0qRn2Gn?=
 =?us-ascii?Q?aCMSSipqW+FBsM61AcGhcXdlLX1e75I4IJQmPV5p54NC9QtJixRhd3Wpjv/y?=
 =?us-ascii?Q?9+1HsHqpRfMfzFCrm5KRXRoysqMap7C5oq7U8V5RLIfz2leBAvXiZYoztbLs?=
 =?us-ascii?Q?+wGb+lop3bCeWMX8T69tYVpG8shbgAAc1nJM912UKpR925XEQtdqhvhE8VmJ?=
 =?us-ascii?Q?d5t7dHgb1fqRWsWfLDJKxFsBj/kO/2jgQoO28WBoscE0y6SeEZHlyqK+oC3x?=
 =?us-ascii?Q?Kw4qinwKhkwFpoQP3cc63R8eVdic7J7/hvHBulCWIbNveangXkN9B7P/euC9?=
 =?us-ascii?Q?VrY23eXEfeszLOwyB2bTqNMWdDKXzPkyOzNhUrwRPJJA5rf3bii6u5X0FfSK?=
 =?us-ascii?Q?Q7diRT6gf2m6HQb27HPvjkjrA9sP8jPrki3zs1DeMBOMl9N0veby/91SJfTf?=
 =?us-ascii?Q?aLGa/KGIouW/IagUuvFAhDKPNxs6QsM7wXx9PbOuFZF1WlJ+7v1Nzs3UU9rF?=
 =?us-ascii?Q?DIlLslwvCeKEdHvPDO2bYAHYgE2gtfJ92hfEOYeX2wcNwy/pYn80vCjyU1+a?=
 =?us-ascii?Q?qQEcolBW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663fe3b1-d780-4190-de5a-08d8c6deeb08
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 18:26:40.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1UVGikXrpB4iK8PQYlUUWZxLcZynXeY7GM+Ha7ltGcESAqG8hwM4uY2Lnc/qzXT1kmNsGp2GgeNW8qKUIVcvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Under the GHCB specification, SEV-ES guests can support string I/O. The
current #VC handler contains this support, so remove the need to unroll
kernel string I/O operations. This will reduce the number of #VC
exceptions generated as well as the number VMEXITS for the guest.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/mm/mem_encrypt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c79e5736ab2b..d55ea77e1ca8 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -474,9 +474,10 @@ void __init mem_encrypt_init(void)
 	swiotlb_update_mem_attributes();
 
 	/*
-	 * With SEV, we need to unroll the rep string I/O instructions.
+	 * With SEV, we need to unroll the rep string I/O instructions,
+	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (sev_active())
+	if (sev_active() && !sev_es_active())
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();

base-commit: a7e0bdf1b07ea6169930ec42b0bdb17e1c1e3bb0
-- 
2.30.0

