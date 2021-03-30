Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E834DF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC3DU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:20:57 -0400
Received: from mail-eopbgr760073.outbound.protection.outlook.com ([40.107.76.73]:17839
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229483AbhC3DUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC3eh1ApKy7qPdMPrJBs/69s4b7T35K7o6TTGtZ02y92uoaky6de6rApmMeRIAUxYxBpDUOmCfY/xqOSfVQ/H2fqLPqDfpimLnRXz+w28czUDir1DlhQIoPqWiM2XMDur/Crhs4HfVfk40XN93Bx3gUHGpFep34ArERUtjmTagNDLEDf2+Qv1ZrvX8lJbAqH0rCFohxfjM+bA9jPT1vPCUAHvALAs4i7eH3qtETstCDj5GczESjEjez1OyygKcvZLfc55eZSSJ3HM9qHjZEdlqWGEpJTB2eFGG1TpYWZ9FNyEzDkWXy0WvHzmTw1B92IDfGw9hf96AzLj7zL353WeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCxrKQA0/2AtF2r0V2I14Clr9EaHc4xtm/hMf7FLdgs=;
 b=jDFGcVuMHXIew5As+vpefS55tJVzBjI9DQDq2TPv30IXZYYSeunbqG9O3lANsoZ+BNkibUkcNlKwrZJDnSqmhaMQFEcsVm4v/GYbt2IxgR14wHClhwwK4Rq2z6GeD2nwcQTx9AC5IScAjkZ6OkgAQLxwvd34x81bBTvmTfUvjdkt/+WZ5TPFFA0wZPTolepWc0UwkVBmomGycQ//IRgMMoOuBu1bSrLxLemNPEwPqyhu8d49HtEmL7ankKm/zSZONmt7Rd24d+I19T1GBU78EuFWPuAG1Fmftd7HE7s4gnrsmaGyagFsMmzzPSkRAQ7h2YE1dS4NxTXTQpwx6ni/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCxrKQA0/2AtF2r0V2I14Clr9EaHc4xtm/hMf7FLdgs=;
 b=Cvs7YiRCq6Rnyby17v69M7FJb4I+OwTYE2HWrI59o12pD9h++lPak90TtaCSo24Mf3ndfJzVeBkPdEA2xeZ+O+sNAImHCPq0bzoxcv6JU/PM4JzH5sRLkmlOdTyHVXRJK5PyvsPT04llMhAX+MI31Y4CmtUD7B8ZUFnlyKJbfMs=
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4616.namprd03.prod.outlook.com (2603:10b6:a03:13c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 03:20:21 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 03:20:21 +0000
Date:   Tue, 30 Mar 2021 11:20:15 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: ptdump: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20210330112015.738f4365@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::25) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0200.namprd13.prod.outlook.com (2603:10b6:a03:2c3::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14 via Frontend Transport; Tue, 30 Mar 2021 03:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab9174c2-30ca-47ce-a0b2-08d8f32ac03f
X-MS-TrafficTypeDiagnostic: BYAPR03MB4616:
X-Microsoft-Antispam-PRVS: <BYAPR03MB46166C0B352B65C2C0D7E00BED7D9@BYAPR03MB4616.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRLzgPUkTZOPAfi+cSuUrLra3e16innlPPxuTVO4skZZQddKRastx2NWP4MsIeiBSCx6tpsMnW5WV7RfLcEAsyyFphMrObafh1S3z+aLd4gSmFZn8TSsWloz0ZCqWsBobOw17sX6i4z3MkUYvhXk7yY1Wg4V5kqh2/uM5sLZ0gY+Bsc5quSr5KDEXz60oaukLSq/Pzi514WcE8hSSL+G8D1+AYsFZau48mvIJvwRewpVIoohbIi3h0bNrbFguBDmXRor2Vav+gVfZ0zlGT9BwgXqzZQriCaQd6FlsyoyBKhKNELVoygU16imJbe6U2CqDAFR8daSAS4ccSZy1r7iZbL9C3haDFyB9ZN2gv7TyCWwJwW27N77Uv5lAfu7bU1dd0UxgHgO/LYwPxVSpmzxQdChpMHLaErwsN8R23g1kd5gzFdAPIIszm4iswRjGoLiR4dzUreNmvSsp4XKIp6h84M3uJVt1dubEUzz5JrdaH3mnEYOa0D+lTNde9Qmb9Rq86YPyH8bokSo6GyRogeuIC7OHGZbFPY4HTq5ErMd0tjSIhM+hb2VqR30VcxsX8Fihr151AdRcTCSdgIxh7HRihXv1MdGkgk/PKeiZPWigmvOW8CA5vx7iedfHWM7xKNYgFwjs6O4QoHJjkVqdwSAUk/3JI5sD0d+SVprV0L+AZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(86362001)(4326008)(2906002)(8676002)(83380400001)(478600001)(186003)(26005)(16526019)(6506007)(316002)(5660300002)(1076003)(7696005)(9686003)(956004)(66556008)(66476007)(66946007)(8936002)(55016002)(6666004)(52116002)(4744005)(38100700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9Bhwpom99nlM5uPLgGRHvCKT1skGA9fIP0n/X4KSLtQtRZLLrNzUmBeBDeyP?=
 =?us-ascii?Q?FKYFJKKAQ8kXFuRC+sY5ecnv4u5JWjohOixRiPJgnwLMug0UTVnSUe0bB2Dn?=
 =?us-ascii?Q?HkNR8EFHmDrbFJlFhT68r2fKHc+jRokhiPyRI+rWrqLpc1ajFur9LS1lOWbI?=
 =?us-ascii?Q?UNHac+3npAkHQyAA91vBiBGQ4CcN0Xu1yWwUTmBLoTpJB6TdD+7Te9djYt4O?=
 =?us-ascii?Q?8JP71mnW5/wLbI8UN1gqpBDt2iiWc+1a8n1CmRlNGvdWt4AP3dJbWnN5IfQm?=
 =?us-ascii?Q?9jyt/5yIQ3YS9IRq+tPwSsree/6750uRcCmkodDtQKPYc2klwdftrI1d28OH?=
 =?us-ascii?Q?zfBHwUuTuUokNE6+1JDNOaQ4JZUpZm7+BfGZqtl3kD+AUFx+pQT6UN4dUMQ9?=
 =?us-ascii?Q?ydTS5B71G83/USdB6mtvh+lUAIKGQvjYMJ9V9CDJGXQeCza3MZDxmoQlQ8Mu?=
 =?us-ascii?Q?u8XcCMK4d8pqUJk7thXuqRCzN67cN0PL+ENFSzqMGe5iKVCz6B03R5wH02Rc?=
 =?us-ascii?Q?6lnnrXkc99drmJr4Gf6Yg9pxh27OPS3vWYTh8HmUi/P6Z73OCNlPjMFPPMJP?=
 =?us-ascii?Q?LKFRyQwDYZBB1s4AiGFWKUQkb3tx/jI3brdfSFfhi/x7TsSGDrJA6ga4xNDT?=
 =?us-ascii?Q?bVjTdu7aWCYEhrY5ciKhCgWvknQEklFXm8pZ55R+GQtW9NEbCw5C5xcl5WcD?=
 =?us-ascii?Q?2S9cbYoTRLhJAsWqaWF4UB1g6j5iYj6PycwOe4KzKmFMi4fOmnxCaoOQXvTo?=
 =?us-ascii?Q?tcEZFJ1VKE7jr72FJ7WiWH3dY4VBhi6p24X1zpiwQWjruaMigN9Il7+wUslL?=
 =?us-ascii?Q?OaQZFiC8iwLzy3ADvsF8hxX4SyKZtv7BmbmQSKTE02rUm8v80w2Btav5Rtjz?=
 =?us-ascii?Q?x8o1nO3pZ5h4XosNaWl1ntktimInf/e1sEbDqqKkU7HB2YdE6+BQec+PZhA+?=
 =?us-ascii?Q?jBzjA1IhP9UnoiDrg0Yn7eV+VzRGlWZOkmAC5zUQHaTzCaSToZFi5NSJQlbX?=
 =?us-ascii?Q?Ctwn7SGEZH3pMcwv2iyVF8Fzij7dLqR1BcAVgkxvKhWPsNL9lB8QA7Q2vfkm?=
 =?us-ascii?Q?gjxm1VQ3DjM4lhRoe1iFYeuy8MRRYDiB1FeRJaDHzbyjGa1H7yep0dWBVVFJ?=
 =?us-ascii?Q?i6yg6C0JpbNX9D416SvXptlot4nJYEMlSpLvTNwa5lKq+Isda7WQEv9cTiJI?=
 =?us-ascii?Q?4XUvyCZPzechKjMNPCClQzY/X/6GZVSz3LDSTuYqOPqAreJKMU2GxJwu2R5M?=
 =?us-ascii?Q?NtQ6uBwZnWyKnylBlBShlc5AOoTRBz1PF+HPoAxa/ykfjHOLXsUQCvJuKm/z?=
 =?us-ascii?Q?1ExrPMrWR1if14fIAOiQojeX?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9174c2-30ca-47ce-a0b2-08d8f32ac03f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 03:20:21.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9SMiYJwR+ywFm826gko5DlWA0mNkw9gluuFaNRBZNw/G4b28a+FK6izgZPupktM2LQSaChcejuxPEOwvQ5PNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/mm/ptdump_debugfs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index 8df9afac8d81..318de969ae0f 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -11,18 +11,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	ptdump_walk_pgd(m, info);
 	return 0;
 }
-
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, inode->i_private);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
2.31.0

