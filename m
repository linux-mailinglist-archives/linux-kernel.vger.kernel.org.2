Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3CC345EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhCWNBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:01:32 -0400
Received: from mail-eopbgr1300108.outbound.protection.outlook.com ([40.107.130.108]:3456
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229884AbhCWNBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAguj7wdHP5QoIZ9HUqC3X6HToYeG2Yyk+wbFJP3U47Mjwsab/I9jLU0ftosCZtx9zx+/HqZ1thbijKsX4HOlZRXo1na1CpsKlGCb/i3xCiJiNWovf5IwPiVmaIcBwAn2OqOGbiZ8OkBu4Vkc/1/CG29Cx1JAiAy/BdkF11cyG236G7t0Vd0FwbxcyYcSuQZPhJ3b+d/MJwc0NP1/C8I+IrcNWLP/mzi08F+ABxr0HTnEcT3TiIYZbULWQ7UK0e+M11sWG8MaMs/ChjCgunoVNWerUv/rzuRy9JoGLFzoMcntYVXQO5KlhyURJggqTxSUk7cTRhxe7+AGKHql/2Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJLzqcWQKuNdSLB/S3k7Bpoj/lWMug8hvwdwBaG1W50=;
 b=fnyuHoOJgH6kMF6poeReqIJIVWJDUxzatMNiG4zOWhoRYowdpUEF3ZJHlWodF/vXCfT0dSJF5afvcMQNxjEzZuax/HtAYSONqi/MwZIA8WTkCErsxdIHZD2jbDWe7gIJVlxDJNttwyTb8TbReK+b6/cgDuzy8KlL7PbohIBeX4lXgcrf8MTdiGxi+H4t2Ie+0264fjQEl9qsf+0kk3PH7iTVXu4qktGuosChXQPMrLc0g0dWWuYy/f9UNiChO9zSeXwZWrsdBBfPZ7R5ekrWNEVaVPnYLr6MzOgG2fpecsxeqyfMIX0VCi0FLllRRHtHX8BGPE7jEwHG2Zo7gFlXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJLzqcWQKuNdSLB/S3k7Bpoj/lWMug8hvwdwBaG1W50=;
 b=onfuSWXO/AILY0gy3jfrmoIJyw2cBmBm4tnmRZnMOBB0L47V0PoetqfZLwNadGcB6ReS6yr7mpYVC+pYdNxHkuwMGmXyH4eAxCnZmaRREUwzdeujtBBkwYZ2oOGspTcBAM3gGneebC3FifJeN5TS9pccnuap3yBbnTR8Y8RDUqs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK2PR0302MB2514.apcprd03.prod.outlook.com (2603:1096:202:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.14; Tue, 23 Mar
 2021 13:01:18 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3977.024; Tue, 23 Mar 2021
 13:01:18 +0000
Date:   Tue, 23 Mar 2021 21:01:11 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] usbip: tools: add usage of device mode in usbip_list.c
Message-ID: <YFnmlwlau57tj3dE@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFnlUaF2njDjIhfM@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: HKAPR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:203:c8::21) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by HKAPR03CA0016.apcprd03.prod.outlook.com (2603:1096:203:c8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Tue, 23 Mar 2021 13:01:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a0fab93-c4ee-4491-4c42-08d8edfbbf85
X-MS-TrafficTypeDiagnostic: HK2PR0302MB2514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK2PR0302MB2514A2AEA2AAE383486C83D5BC649@HK2PR0302MB2514.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qv19HiEg9wr6uEQRzirRo4pMDXOiX76cGdkxaE2QAnpnrE3xZ017tRIMwdhr8awPUXRhtWcG0bmMMgsCoY7KOQvfFSJKwNNWeKYs3cAaYKXDoTMPkoMhVodL5GxlRYElTe53ajRjwcqTo/q6IKbeibdC/go1Ws8g3YUzWwJoOQ0ekudApvL3syN4A+p2MvDMXFIRiha87XhWb0Qs1sYCc6qKMXVm5mmgy5I66EarU4NBGs0BlLbAK4BC4cuLf5ffjbOym5HQ6kEQU3dffsIDW8ofDQeH5dIlb6sKHOiml0/Zoo4h/EqUpjr49r/YYtn9esuSJEZXtIzTKimPxhbcRoTPG20S2tVK/BdZneO8DE7l27ZsV8Keo9wjjUC5cOgSnhtIesU78NiZo2/s8pz/57gMTTij/sPJeDWWHzDBYGnv4YfCfbW6ih0RxWpqDkd/n7apM0+deHw5/taDStR0OB6xyhRawSh2XG4+cZJ9lZ1Y/it7KEsHVPINI5W+k1zVjNp/kAmDPXp3+RiB0WzNDSTL8f4dnnvBMdu2ymCNR9YQlsutbnPepvPm5K1zPFNNuAh6mPlLJi302zeoAf3pMtlTz8HyBCeOnkoES56vfZ7i47DFrW3RfNHJAwPhbvLNLcNprKhAfWLMEHQGXVT0aaWCsLg22s4K8PCQaABxCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(366004)(136003)(346002)(376002)(39830400003)(8676002)(52116002)(110136005)(5660300002)(6496006)(33716001)(186003)(16526019)(8936002)(83380400001)(9686003)(6666004)(2906002)(38100700001)(66946007)(66556008)(86362001)(478600001)(316002)(786003)(66476007)(6486002)(4326008)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vz7sNXqd4TkZT8bRKmgpd6H/dOz0o1B1J1xM7ZPd9p4Yhgk3RSRJW6LDrMZy?=
 =?us-ascii?Q?o0bjl5/fBEiToJ6j5UoskD++aMHBOGKzcyqtan3LEl20AMSDJvvfbW0MludD?=
 =?us-ascii?Q?4KsbpzW12tBKOhALy+GrOyU8J88CHXrtCbHWGsIHRrwnh/kQQ8A4dMQBdUGF?=
 =?us-ascii?Q?KGPZO6dlYZf3/kFrybDY9oxowqlNOHeWKJvthrjrOqIkW4HjGRk3dslXShPg?=
 =?us-ascii?Q?Rs6h6KWiXYTsj0m51Dq1ICcgnLqEG09ylpx6o1FLTw4ZdxRFfWw6F77fnelP?=
 =?us-ascii?Q?2GIfs9p9Tm7RAwpE1Klu2IxyqNU+S7hBLZp9txMAKSIU7xXlwBqUXqOej3vw?=
 =?us-ascii?Q?uFf7/sGm1dni3hht/QYJ8AC8SywyI52FF2xfKi4zUqbbm7GDqON2T0gakJ4P?=
 =?us-ascii?Q?BFBbkSmH8gmRJEOwiVo4/5MRoPphRgMD4+j7d12+UBc46pEQPm3cenULKHOg?=
 =?us-ascii?Q?BhN1rZ6s0o1rq9GjLNL87Y5Wuj7dYUTYcgLjRP82ViJ9OTE66aeGw6KXH670?=
 =?us-ascii?Q?CI+9QHDEGpkjyOoM4Lwx2ifrkWvpiAj/vfrCF7R6WfOfcbsVUVNKwkm9gziA?=
 =?us-ascii?Q?0IVXYtHTvPcxxmdF4xVPjtCzwcfOTm0IbdEzzkCa1xUPoB2N9c94WLaihP2u?=
 =?us-ascii?Q?gvfCo+pfyUBgAg2fiVek9Y9/kQ13WUsMuOqz4MZyZ1f++VHQcVeahI9oVzio?=
 =?us-ascii?Q?Um6MwmWjH+unow4Y+lidFBQr1JaZ8yGN2exvr2YVU2DOvj3SZTlcfJRKbd76?=
 =?us-ascii?Q?gqgzxxmiIWu8KeSJjpgb33G/vryjVRWRZMytuw+HTI+ZY+IsRL5M10kQk9vQ?=
 =?us-ascii?Q?WH87jbWZrcbv7Vao9oJOR+ydSj8awJmMkuFMVA5Z6U2lzcWpQCcng5Gm2GOH?=
 =?us-ascii?Q?59P2EuKPAv3i8mbbtqDHPPXHT563VX/XRxgfqM0xuc4ySKTSOW6onDtARGkD?=
 =?us-ascii?Q?5dK9hpZ3A+a3myolNvOid39eVoRyQBqlzg8gP+f/J5vNAgWy5PtB4ofWR6lR?=
 =?us-ascii?Q?O16m1oodiKcE6Hnn15OSx2qcWzqkn31X4B5ApkYiN3tvIHLHOpbUP6r/QPF/?=
 =?us-ascii?Q?5mwygB4oUja3hmLyLVqYL3uVtb16Jh6+3iZtBBZlDOzjZx5Us09/evrwUwVX?=
 =?us-ascii?Q?MUb/UVaT/RRBdPjn5g60oADqk0zsDQ9/oceF9X4sHHfqzs+trmncsEouNtWA?=
 =?us-ascii?Q?4tev8KAUDtDA4I8X8GQAbSjdsqaVNJ9IIWsBmdPNofOK8QDkFwHQOecL7M22?=
 =?us-ascii?Q?l3Bcj3bwYgKfZCGpGjUKRiuqzi3ppN1JNz/tlomu7Ig3W/kG5Gz3lfQGrG8u?=
 =?us-ascii?Q?H9keSuLXDwH+RpxZAljAr/3de53UwqEejPW7ebruCOhnCg=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0fab93-c4ee-4491-4c42-08d8edfbbf85
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 13:01:18.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul3PpmTy1YaLE2VtSuGMN0/XKY8PizM5OzjAqshI9DKY5G/UOFW5ik9zNeyd4QjN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2514
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option '-d/--device' was implemented in 'usbip list' but not
shown in usage. Hence this commit adds this option to usage.

Signed-off-by: Hongren Zheng <i@zenithal.me>
---
 tools/usb/usbip/src/usbip_list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

PATCH v2:
    Add signed-off-by line

PATCH v3:
    Move patch changelog after the marker line
    Remove nickname in signed-off-by line

PATCH v4:
    Use commit short hash and message instead of long hash only when
      referring to commit in the kernel

diff --git a/tools/usb/usbip/src/usbip_list.c b/tools/usb/usbip/src/usbip_list.c
index 8625b0f514ee..3d810bcca02f 100644
--- a/tools/usb/usbip/src/usbip_list.c
+++ b/tools/usb/usbip/src/usbip_list.c
@@ -33,7 +33,8 @@ static const char usbip_list_usage_string[] =
 	"usbip list [-p|--parsable] <args>\n"
 	"    -p, --parsable         Parsable list format\n"
 	"    -r, --remote=<host>    List the exportable USB devices on <host>\n"
-	"    -l, --local            List the local USB devices\n";
+	"    -l, --local            List the local USB devices\n"
+	"    -d, --device           List the local USB gadgets bound to usbip-vudc\n";
 
 void usbip_list_usage(void)
 {
-- 
2.30.1

