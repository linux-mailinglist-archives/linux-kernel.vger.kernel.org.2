Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69863487D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCYEGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:06:33 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:10145
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229617AbhCYEGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXkGBAy4fP4XnlJUo1DpagIeqJwG1Fw1R4+29GM0MTtTOPtSgL8bokNtOKrKDeF1VMGZQHIptf+Wo1SjvqQbRO/iCuKu/bEzae+6k5uGGJrDR47XhCdbwSa4+SCSSAnomBHnY9NqeYlKhm2vZjY9nHR6Xu03VOO/TAorXRSWYjqjEz2T/DVCLjeZ+8TswNa0jUHzB6m+N0GodWQAyfIUBfk4Tgd35g0MuVIHR8k326SCJjN2wiFqOkZIwvIjk+M4etj/sN7WaEjduhdgxTGti9UivPKEY+4qZlL4LCIWWJLMKKHNEfJ7MOvqjcag/f6SOJKGmqc11wg/3VTsfA7nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPI2iMCaJyL3JDvGg7kKUT6wKxKWvW/cQtMfjjXSsB0=;
 b=FQ89MeEFq9t6XuOhQgmdit1IKg//wVyp7r39FmS6JB2PG2+8nwsPilq9rSReWrV7+qGG3K3WH92PKi0i2+p+jt61F2cz9cxOnH7GxAwS+T7zFEXhkAnHBQKOTS2hzzmxbNI1fALoCRiP1izrAj7OK60MTJeenPLlELgVkXv5/iQnz7ggs0FSXVa6C52KAtzpYMCgSN0UEZ7YB962msZYckSwGSsusFPrioSSiXk1chCDv3bLZYJbwz8/DM8AHlTMc6J6tPyTk2dkCNP6P/kxchKv6om+WJk1z5OvQ8PkmZaC262dvNNapbT+GFQdeQlo+zuC9qg9Uu0BtdfaLCFmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPI2iMCaJyL3JDvGg7kKUT6wKxKWvW/cQtMfjjXSsB0=;
 b=AF+zUofbIUSsm2qplzuw8Rze7FvHH7RxNjI3kmlVO89g8iiinwEqOeq58U37j26F4RYnaoFSnbB3FXoZT0/bWlfNhaY7CDxHkQfGjZJvMPV2t7z8blGP+Qnl52sf9L6LJsjalCxn/jWpWS1K5W9WMdSJA2FrMfH1fc+ORrt8XdM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB3800.namprd03.prod.outlook.com (2603:10b6:a03:67::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Thu, 25 Mar
 2021 04:06:07 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 04:06:07 +0000
Date:   Thu, 25 Mar 2021 12:06:01 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
Message-ID: <20210325120601.71584253@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR06CA0057.namprd06.prod.outlook.com (2603:10b6:a03:14b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Thu, 25 Mar 2021 04:06:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d27fccf-0018-44d4-bc81-08d8ef435105
X-MS-TrafficTypeDiagnostic: BYAPR03MB3800:
X-Microsoft-Antispam-PRVS: <BYAPR03MB380029B45283A1124AF25FE5ED629@BYAPR03MB3800.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9GjtOYw3N/FBWHfbZzOztZ1A99im3s/qbdmBic3KAD26ctJgOXs2UaSfTOXjswNOZREIdiHcfodc7oyOtzE4w+QrRwQf0ODrXOfiawRaXQFgtC1i+RAeV3J4xDKhYsMMY64WCYSAKhvs3yKEPj3un4pw9FuLSryqKzFUzCzcWrD3piErGlWJWbB/qEpteZHsz72AWIYzCceF/KghQmDtWdvNDjmvyHcl7kv6SIZYEMRzjnkX+evW/gnhdt4d2tAMNLvDfGueSvyhnahQODuUVWn3CfqUfMIqF2V/NGVTWMV4CeBdLqSAuVpmRjEA2iOVeqfX9Fqme/NaHjDmyhKvfzwTYq/2T1Ddb6n2gMGB+oUTn0/i3CUQXf7Rv5zaRzqY5Ct7+2tW8iSYQdTcT8ISTGYp5x2h6DrSiJx+Wz893CTNNHmdcYqjC2ToecXcZIQtF/z3h8kRLFchvCDd25xyIsqeRUOF4BOjm8n65ldph7oYfESRgAD3pxyHH4wl9zZLDXvvKpPOZ8V95TAVBFMeyTTM5T9yumn/JOztxvSFY/3em3yHmeXUGVhq1+SlguU7NTO7eflpCXokaeWhjvUiviWvPyo89qF3Ej/Z+RPbkQdwi5i1Mn7oiECstlkFd0bj4GMtreEeIN9Bv6U54JEetNKSHn9wfy1Ss+MzoNP7CY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(956004)(7696005)(1076003)(186003)(478600001)(9686003)(2906002)(66946007)(52116002)(316002)(4326008)(8676002)(6506007)(16526019)(66476007)(6666004)(55016002)(5660300002)(26005)(110136005)(8936002)(38100700001)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uoIz6EwzqAch+dBk31dgH0+wK5Y/2JU2aMg4Dpvb58sq/dh3TDS6KDm0pE6v?=
 =?us-ascii?Q?zgCrdZiWZTT8F+lJVgmPAfabNm5T5fKD2IuKNcHF0MRCV3xoaNBqZoESAejO?=
 =?us-ascii?Q?2XYHJW/UKys/50WYiMzyYBFTmU1H1uKluGtf6XCA8RMXkH624UBH2Ds5HJLz?=
 =?us-ascii?Q?oNYz0X0fr5kytggTz/QLbV+l8yWnDEXKuBZw/kyjZyxOf34DJ2sNhAqIqLfU?=
 =?us-ascii?Q?jPhzxW9KCHvvLHCXIfJxCIV9Qj7bIGHClQXRiy1FtphC/Dw/R1xvw3zOqXRl?=
 =?us-ascii?Q?iEwra8t6it7BO0C1pBl9IvxYegMfNxRJnCz4c3dLDNp8u91YH7xc6hf81Pwm?=
 =?us-ascii?Q?WBUYKlQvZT3AvTxiC9NcyAV8x1SZtmUTwzDMq0uLaA31noUPS8p7DWAM/UO9?=
 =?us-ascii?Q?fykRA71Eu+ZaGhW1WLkbJK9tyyJLvX9PHyUv2Jpb7v44pGBK+aNohlYHXzWx?=
 =?us-ascii?Q?7hYtbUGKdO9T4PLNXrN1PR/tGen0ZzS6ieMcUrqOJqGAQceQfGWAC9MrgwqT?=
 =?us-ascii?Q?AfN57UZMgGEfa4fzzqpDis7j7Fxie57sEIabr6x66f7/Ax8MJ8mrQd9hJJ42?=
 =?us-ascii?Q?gJcchxbNYlcUexSByACee2xpey1uJkMOsJReX26UjUUohOIKLYCFgu2aEccv?=
 =?us-ascii?Q?TDhdKSfRmaLHin9nqXfxTN6I0b+3g5PWdoWOnf/hRTHxKvEOYN0e5aUd7ORy?=
 =?us-ascii?Q?IkS0ZJMXo4wytAesPdSY8pzsIIITyaAji/4aQJtbHiBVc/pTnxbOQuf87LmB?=
 =?us-ascii?Q?LI2cMYyMBMCDPNgvLtdD0uXEDu8FdxlwgB6WIsq1y7BUKIg+FhA89FntUbI+?=
 =?us-ascii?Q?QcJlqGIrdbhpgNXit+a6qps2/vFxFTNfE7mTMjlYRIf9GI0kXZje2HzXTWyE?=
 =?us-ascii?Q?eS6Fqy0+fSuGYHkuGAw8kW5wTCdOQla54ZuViHcg9SgkL7mxU4PFlT/32TYa?=
 =?us-ascii?Q?GaU5Pu9POLilRYettEM+CgsZHzpH/WF9OWgroii393tVukGcIPKCgyU2NCr8?=
 =?us-ascii?Q?QsTmp1fezDTFPUJhrZagH55+Ut2+LUWEq9NTwazw2wLtgjkCTBYVhPXKPn6+?=
 =?us-ascii?Q?QKhtOqHs9d7LUIUsB3UXRFMg742aLjFBVYD4GQQXFK8cWUOuqbILYg2Gghoc?=
 =?us-ascii?Q?H+LrjKv5dEAJP6dkik7cRUpdd7rhOffn/owsSZaO8Voj12vQcmpuUNMVvj1l?=
 =?us-ascii?Q?o4Eajvhnz6gRzq7/iWK29C4zYHsZSqdwmTgMQp5YVCI4WfcVnSNU1ULL2AZI?=
 =?us-ascii?Q?kGfw6vaNLK3TBGa3qcOyCX8YiBj8DiPgL5sE0MuWOx4NP7VI18DjKlYjEQ1t?=
 =?us-ascii?Q?DAjlFiD7j036ySa3m6OGiaiY?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d27fccf-0018-44d4-bc81-08d8ef435105
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 04:06:07.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G64zrLq2wV36kaImUuaeLwdeJYKnw+vsDtp4lC8ha92+rJCFb+nvmXzXWlj0rf3qGKeCTR8pVZ4OdFfnutUo0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If build kernel without "O=dir", below error will be seen:

In file included from drivers/tee/optee/optee_trace.h:67,
                 from drivers/tee/optee/call.c:18:
./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such file or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^
compilation terminated.

Fix it by adding below line to Makefile:
CFLAGS_call.o := -I$(src)

Tested with and without "O=dir", both can build successfully.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tee/optee/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 56263ae3b1d7..3aa33ea9e6a6 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -6,3 +6,6 @@ optee-objs += rpc.o
 optee-objs += supp.o
 optee-objs += shm_pool.o
 optee-objs += device.o
+
+# for tracing framework to find optee_trace.h
+CFLAGS_call.o := -I$(src)
-- 
2.31.0

