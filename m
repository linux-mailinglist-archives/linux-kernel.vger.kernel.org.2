Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B174630BACA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhBBJTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:19:49 -0500
Received: from mail-eopbgr770080.outbound.protection.outlook.com ([40.107.77.80]:32229
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231902AbhBBJS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:18:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhF7oHEGegzAxPm6O1070qEyvb5TtLuavJuCzVFIhU0m7u6zRngVsCjNEJAGwCUoKblY2gMTR0Wdm0wRJiZVAd7XZ3uSDcTdX+PajgqHwUtr6Jq22bbJICnRFixgBaa0SHSLDhuF2LyjcCYCbznKy5uZatYZOO8opddEhkbnQS+NCXZIURjZ4myS3gd8JznfHM3FTO0X4niyIfsONxmNcqIDi3Q7CWTbunQgGJHcC6gbydlVrRFjicuzyfK6+iDQSsYrcv2EI8jeJyI2M8Tt5Hq0DQ3CbYdjrqojGOMZmI1u7sOqhi34JTEQnGYQahLzqyYNqQInIOu4sobmh40QvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9QkiJaXRhBTulWPxR6Fg8gPNwmr+UDT+oJSWZ8Mv2E=;
 b=ho4RIkb1ZMjuxr+eZO+qpDmYX36y7r6ftcfPU1HtZWC5rIagefxEo133bv2eys0TgB0IR7HgQ1GhrSeI7oNcycRjqkDOp277attkZcd3djyH+Z8tLd7PzUt71WeD5kyxn5fBKgJV/0+0K9i8w0M+yT7cqWX8BpUYHVw6qyKkNh/xY1KwekxAqlgAlwKoz66TKtPLrfwyP1ay3VsvRQKFsB9EljX7f8cTbUIQKqnDfn+IDbYd9JO3zVYiBHYO/DVNY91acz3gV/ohvw0bIEaSTTQs097dIoVR3G+T5vfb2PP5ANuulfYRdTVsxOB0E5KqcdKPj+T52kEEL/dycbpzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9QkiJaXRhBTulWPxR6Fg8gPNwmr+UDT+oJSWZ8Mv2E=;
 b=phzic25iTlI5fv5ALBjjWp+UzLN4fi2of7ORcUtsitWjsUArypNOH27p1NTGC3NguyHlzbCu6weiaRmJddfzANlncqtHj3YkbOZWP2YdgRNUcyxscAN22xvPicw7Tlp+9O3cMSciMZ3tQQbQIPHe929iRHEtZKywttiwjIy4DBQ=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3560.namprd11.prod.outlook.com (2603:10b6:a03:f8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 09:17:39 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.023; Tue, 2 Feb 2021
 09:17:38 +0000
From:   qiang.zhang@windriver.com
To:     peterz@infradead.org, mingo@redhat.com,
        syzbot+2f6d683983e3905ad8d6@syzkaller.appspotmail.com
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uprobes: Fix kasan UAF reported by syzbot
Date:   Tue,  2 Feb 2021 17:35:35 +0800
Message-Id: <20210202093535.19822-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR04CA0054.apcprd04.prod.outlook.com (2603:1096:202:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 09:17:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 948b6eff-3400-471e-2a2d-08d8c75b6275
X-MS-TrafficTypeDiagnostic: BYAPR11MB3560:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3560C1A28E4CFCC8AA7AA152FFB59@BYAPR11MB3560.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Gs1ozFQlrlPkKhvT0Qk7QFhsAHWN1KQwfIsPdPwhvph2o35uA/NupqXlwIpQNi/ZiJY7YsiuWWU85qYsrO0/0UHo/BU58g3/D2dQ05s41Ul87jczNWzHZc7G4p/rnTeg5kn3/ygRCQoFK2w5vGKSrBMLYzvfTLHrY1utlQGQ0FkPGfk4ajy1cXjJkg/dk0JM+LipOKXbYi+Q1LLbart8WY6/J2mgOts+kPPdmLlw0TOplmliYqBXqOQk1Z7RrnrLsv/E64fVb6QyDsGQcx7JDp3yskHBkn+mqDU93AUf6kpL67X1IT4iTofUWy8JV+xCUd2CGmPbwJ3UlBkvgmVkb4eVodZMUGNNpthin2P8B/tGrWK4ipuI05oo4supYoXyQjcBV/vF2pb5w6Qm9S+JjzQGkKhlubPrN0irwJ057gm6il1y3qsxpMQZlaOmi2c2CM4PpS5hu1rImrqEDFKOS212Opuf5MMYbQjBP3sZKnJpN+u6Oc7DqMaM8uYPZ0pOYrVGa2wcl6ZU3UIFbFhJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(36756003)(478600001)(2616005)(956004)(5660300002)(6506007)(26005)(52116002)(16526019)(8936002)(66556008)(66476007)(66946007)(1076003)(316002)(186003)(83380400001)(6512007)(86362001)(8676002)(4326008)(9686003)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IXuyPkxn4GwRKqc9mqozG149pDfXZoBQUhBeowfUvYVbr6FxRBfJBueyVQTQ?=
 =?us-ascii?Q?AqUL5fHBGC3oquMRZks6k4ABCnHDsaqMw+BUzqK833s160uo/vuw2smPX6U2?=
 =?us-ascii?Q?ZkhMRrUvynHHpUrp1k70BoA3DyeJgqhXF4cMMih0fw1r7JtUQi5pl5i+NFvI?=
 =?us-ascii?Q?rf17e8R6oH088as7DaDxmq44xidG4U56XzRCM1PL6iYifIejP5I2VTRCLqCZ?=
 =?us-ascii?Q?bimgUlLNpnY6V3ywvNkBrX2qQIBzqFvEB4uqryKPKu+oj4lMn7ey29JzMWrH?=
 =?us-ascii?Q?2cN0WsiufSGed8wVAdc5w8KgdQ4yJZqrE7BLmkF4hx7aSt0JwEQB/H/cPjf2?=
 =?us-ascii?Q?Xl7g75wHjp0pOpVk9QapaZUAN6OP/lOrYlRfhmS8+QNDWJ0XOJirTBcAneJ4?=
 =?us-ascii?Q?R1+HX21LpN8axmm6jqA5tUfU/1qJWPjH6Y0xQbsO0jLQ0+zrs1PW0u0AxdXQ?=
 =?us-ascii?Q?Swm6MHtVx7LHOk7Bo1YBNp4VTkxZX1vMEu9a8BkIhhl3p1eNi7yC2pi1tY0K?=
 =?us-ascii?Q?BX5KnvWWmwpMf6NVtg30+QHeuxOn1RKlOIzedY3Imia9XwVYjkxFZP7mKjNc?=
 =?us-ascii?Q?G/M3Z0Mhz0zZbQDLdLWa3aPCPSjg8/5yeNSLgH5xSQzYnJAY8DKEjBxmWmLa?=
 =?us-ascii?Q?br/4ZDV/hB4Be+0/E4bdFK+io3VgJwAfP22gpPm9d0RQNvBxhIQidaKVEJBM?=
 =?us-ascii?Q?TNv8SWV+Nqto7yOuouPIbdVkDlpLDvUEnHT+GztK+VS46t0U/O1b6baMn9H0?=
 =?us-ascii?Q?jcgcMNDg3h6KbcP840rWRftmnRTrRpqM/JKCOthMK782XNgeuYg6l8dPTCwL?=
 =?us-ascii?Q?3L/x2aguFFJeLOl0uOtUIqokou4q2meTsL2h7rm2qIFknEIEMDnKMp/YDX74?=
 =?us-ascii?Q?DBZFf0hiWSIqmtNy6GG9/g7DtQmdW2OlSITPw/DrDi5rvWQWvCSBEcSYMQKc?=
 =?us-ascii?Q?MV3cjJ7GSdgc7IrVHI6Vkm526Z+I9aawnV2tj2ZGrd1XRCfjXPpyP7dxjWCy?=
 =?us-ascii?Q?S4cXnu6JZM9X+TNmxNnoLflxpl779lyoLrhz/bSV+Ki3Y/MwIunnkxO1tpE1?=
 =?us-ascii?Q?9K2Y99lv?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948b6eff-3400-471e-2a2d-08d8c75b6275
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 09:17:38.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W21WheyicBlXTeveiDg4VpN8oY6dxpCSPUjVeVL/nkNuAJaD2ZvUhOE9t9t/Hhb3eoAQTTVZy0eH9d3r3kHjV14D8roQSVmlybK6QvdkdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3560
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Call Trace:
 __dump_stack [inline]
 dump_stack+0x107/0x163
 print_address_description.constprop.0.cold+0x5b/0x2f8
 __kasan_report [inline]
 kasan_report.cold+0x7c/0xd8
 uprobe_cmp [inline]
 __uprobe_cmp [inline]
 rb_find_add [inline]
 __insert_uprobe [inline]
 insert_uprobe [inline]
 alloc_uprobe [inline]
 __uprobe_register+0x70f/0x850
 ..........
 __do_sys_perf_event_open+0x647/0x2e60
 do_syscall_64+0x2d/0x70
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Allocated by task 12710:
 kzalloc [inline]
 alloc_uprobe [inline]
 __uprobe_register+0x19c/0x850
 trace_uprobe_enable [inline]
 trace_uprobe_register+0x443/0x880
 ...........
 __do_sys_perf_event_open+0x647/0x2e60
 do_syscall_64+0x2d/0x70
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 12710:
 kfree+0xe5/0x7b0
 put_uprobe [inline]
 put_uprobe+0x13b/0x190
 uprobe_apply+0xfc/0x130
 uprobe_perf_open [inline]
 trace_uprobe_register+0x5c9/0x880
 ...........
 __do_sys_perf_event_open+0x647/0x2e60
 do_syscall_64+0x2d/0x70
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

 fix the count of references lost in __find_uprobe function

Fixes: c6bc9bd06dff ("rbtree, uprobes: Use rbtree helpers")
Reported-by: syzbot+1182ffb2063c5d087a38@syzkaller.appspotmail.com
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7e15b2efdd87..6addc9780319 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -661,7 +661,7 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
 
 	if (node)
-		return __node_2_uprobe(node);
+		return get_uprobe(__node_2_uprobe(node));
 
 	return NULL;
 }
-- 
2.17.1

