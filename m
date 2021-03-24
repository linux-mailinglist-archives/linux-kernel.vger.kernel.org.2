Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE66334730C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhCXH4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:56:46 -0400
Received: from mail-eopbgr1320128.outbound.protection.outlook.com ([40.107.132.128]:44158
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232783AbhCXH4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:56:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVBbjf17lCAbpVMYPCUMIKbOYiU5vnxddZfkOZ3hHQNU5FGTeyE+rIRjkvgHsGVOYk2YGc/Z6wps1N65ZsJaoMtqk1bsxf4zfLsle1a+2P0lt6r+fYLk+wFW0Lqiol/O+b2j9w5F2fRDBf3n8uxn+IrbeRO0LiryJRX1d6YGYF/63ZY8urUqzeuEFQEFrj7Y4h4oGmHmDWaamX4VzkLIAFy0Tul9CQTKLEX17qGLqVER4hW4gmPRbJZk2S2y90pgBWrTtKALE+EMVnfC41E6XMngMnpUU3CLxO654SzTLmiGQidV4VZmV9tdhUdXwppNvvne8/oZUsnYzps8+tXpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7E++zR3mVnpKMLStMg1SkFOPPbeqEQPJM0LZZz61Ws=;
 b=VwAuhN1SolBY/PNCX+ad3NEjngDboZuMuMfsnYEqK/7/Fciie56IIY/viPtMILvU8dhozlqIwKuoICelfDHHSiXwqtxEBw4tWX467YzOWOcAd+SRaTWvJaoNda8DwM6cHnGQEAWtMFrPIn0FI0z3NylM/TELf6f938geP0GDywRCnIbYT2OzMLCrUzYd7oBY11RvCGireNb05TCqiUH2tjUr7eu7QUWAsc56LYs/17XUJpe7iW1THyaAIPmYqAAiIGpgNB1jkfhkQjLVKF5FVc3p83DqREK1uVhsYSrqLv/oK7kI4NXutShQAmDYdKhRgu+dX9Qlaf1S/m4S6II0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7E++zR3mVnpKMLStMg1SkFOPPbeqEQPJM0LZZz61Ws=;
 b=tjVQok+prgIgREp5QXCheHhmWFtoSTStBBjPFa75al3cf1onyIWj2rYIL/f9sRX2G9NgH9gyw4YXLYX4S6mwVaqT8HTEwVz/wXFEhD9BVLXYVcY8xa0qfdjWNY0cN0nDezuJa89irfIO8AJVzquEYe38lZnGF/nNSkpe7YK5HxE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB2835.apcprd03.prod.outlook.com (2603:1096:203:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.16; Wed, 24 Mar
 2021 07:56:38 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 07:56:38 +0000
Date:   Wed, 24 Mar 2021 15:56:27 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] usbip: tools: add usage of device mode in usbip_list.c
Message-ID: <YFrwq75Uyef3c9gz@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFrdyKKx1nx8bktm@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Wed, 24 Mar 2021 07:56:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc248827-1760-432c-f7a8-08d8ee9a5a18
X-MS-TrafficTypeDiagnostic: HK0PR03MB2835:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB28358ECC06D2EE0A8A8EC55CBC639@HK0PR03MB2835.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJSJdEhFya2XUzyZRTapU9mx7V3oNVuC3giAXaH9Ws6d5EWwNq4Nkj4AMHaBsd23J/xsEFyD74iQbycP77/SdDA1YCETqfvhnLCB1P/07/NEi+reRdPlUX93Iw+4aSILaLPw8t6TtbbdG03zPR7lIlDGX6/b5d7VipYZof7Sd8ffRS9bF5eV9rRDmvbpSX1GN2ggiuZ95RdAetoy7n+nF1B9ylRCvJFwLH131vTkZHq56/vaa+jjhfZDnL7jArV4NNvL9r7pca5tgzk91Z3DzT1TpAvi/OeeJb56OkWWyi0328AsUZe3vZdJGiFIucBEMeW8Mpwv93o8x2Hq0EOmTWcYySxWWhNd1zYnwN9ivJwieosggKht4xx13wwJ6I0tpEeOi2wqD1PwQ6zmg6Fn/JN0GiX7rHX/FnE1LaKV2xmhyjdW5L9PA3JXwcp/tItcHT4GJ6d/N4iKNHSAYyFS02Cjz/9zrIUred9Kwi65b+uYtYoISa79Mc3LZpCCh9RLca3mTwRrHv00k7473BIKPBo1Nj4gQ5WFdJJWQlmCTLD+Ij8OQB35Ip4WN3K+UMqhcPKZKYwyEYAQBMkOvNxfxZRlNu8nQdZFVqjCkhL1H2Fgxb9d8RyNPYfomRGzXEHDdmAawPC9ZUNoOisjgP6oNnXs5cOOsDSo9TMrVIUG4L8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(376002)(396003)(346002)(39830400003)(366004)(66946007)(66476007)(6666004)(66556008)(478600001)(6496006)(6486002)(8936002)(33716001)(786003)(52116002)(83380400001)(5660300002)(2906002)(8676002)(38100700001)(16526019)(9686003)(4326008)(186003)(316002)(110136005)(86362001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z5XEWbMwBLqpTJKY4adJZP+D6pV/0mCN8Eh+16nOOH/L3lyJYITm+iL4tD+P?=
 =?us-ascii?Q?z1/D7+KuzVu4guQv070zwn5n4PZejY4YvXvub+XZkk7z/IO3/db551Scy9k/?=
 =?us-ascii?Q?F+zR+XRmtBOnOFRXsbyct6aXmHZoLlbxPZe9fpxQCKnL9JkGLd4bihf1PYpX?=
 =?us-ascii?Q?F3XErrV1qVendaSA/zuKSeiMQmnIp18bcyULO2W5o9BpmoPGc5qch87x9STL?=
 =?us-ascii?Q?5pxTbQtdyIQmzoUWXUBIJNJGXGMuQRBvZHGGI7kmDJ2MQqWxLP2s7/LviH+x?=
 =?us-ascii?Q?dtnL0yr2OoRquuhSUhspT+6B+XiAC+0dOb70qQ/PWg5446EU5LRulaHU9wg6?=
 =?us-ascii?Q?urH7FDzXVvrXdg7JOM6vxhXGx7EWlS0o5hUUUq9VdppzZrQqDnrw+Nim/VF9?=
 =?us-ascii?Q?jUeceWbk7j/IwhcUd9kOwPS/q9u2gL8YODJv6LYC0BxIvV9PGVSpy0MW13UH?=
 =?us-ascii?Q?d3LCa8RQd4dj5bgSg9tTbRv1/eps4oQbj3O+iqeCy34TxhMmbLB0b7zFd1o+?=
 =?us-ascii?Q?bSUgr2uZGAFraliWQEVu95SzkwVwxMpHXXjrQ4v5wXQg/WbhmuhUQiEzVfiV?=
 =?us-ascii?Q?P6rQncob8S5XyvvM0jml3OZkW6c8U6uhEGnkUjNyxInzYCG30OZjJ0L13prI?=
 =?us-ascii?Q?eIaExzRgFvDX2CfNmrCy4ajspMNxMGo2QtS18KcrRRDgsFPzykt8jHghxwDg?=
 =?us-ascii?Q?BYUXNCYr/SYOfgcDV9bP+kRMSlMpR7ZCbD8HrDN3VvI8Fye7RBbWcb+FZE6u?=
 =?us-ascii?Q?u+lofVcQusTUSjmwExZQWVk/YSW8TpiM5umjh3EtirVwdck96+uI8xZII+/i?=
 =?us-ascii?Q?3os2ejFXK1B9cN9e5gO/wnii3ampCMaBl91OonVnUQI+0r0x1EEZhL1AC3FD?=
 =?us-ascii?Q?qbu9AeWJojLsdMn6r+fLPJhw4BwmG1tkVPUU4+VgeLAwtDGsxlwnrkGEffY+?=
 =?us-ascii?Q?xalZMHqfpF+sRITr98DGzk061nd3v7/05TCRdmh8k0tJ1KrxTDMBfHUsIjos?=
 =?us-ascii?Q?29+aKn5tSM0gJ2BCCvO2spWM9PWckvel2QWfrZOQ/bFgHfwxM88KVZ86/6wV?=
 =?us-ascii?Q?KGu0otz4/xsP0X1Z3SwNOeDAY6t56ZRz02YEOglaVgMJf6aikEDAaTVxeCPh?=
 =?us-ascii?Q?Tc1RUFwcwPJYCp61NWGgH4hEP6PMxzKLm5t2MHcWAvaCtbUofTJZkTQTtxY8?=
 =?us-ascii?Q?jCzpSeq9nnDJ+3DQlfcTVYPKsSMY/MSMIqbS9wKaKL1d0kkj7L3+keWi6Zw8?=
 =?us-ascii?Q?qpKiTBaUtWsHvk9BZDi4jlRJ4DqdO0IzTbX6tv9Zd8jfer1JW6bHK+Ok7wn8?=
 =?us-ascii?Q?B3D0yr+kr8r8Lz/SXXBkaDzPBOCJBi6Y0RwfmIndhbkQpw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: dc248827-1760-432c-f7a8-08d8ee9a5a18
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 07:56:37.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAx5oklFIHfVJfhX4gG4qL3cAQr674A0WRXIhW24wVonlo3n1zSJwOeAl64puuFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB2835
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

PATCH v5:
    Add documentation of `usbip port` and its usage in examples
    Add flow of detaching in examples
    Rephrase some description and add punctuations
    Fix typo of `usbip attach --ev-id` to `--dev-id`

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

