Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1E3DFCB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhHDIUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:20:49 -0400
Received: from mail-eopbgr1310055.outbound.protection.outlook.com ([40.107.131.55]:63792
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236291AbhHDIUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOYi6juEiR0KLXoTt4I5XdjovvabcMA3gPhXK3qo4OsH1DtKkqxKbhEOl9Z03CEBawPZiwdq1xUrrP9oJIMaR/xkrs59lwJWBNIvufZUtfQwYYBc/aJiQDKIPLP7eUT8SwDiizxRhS4SbaNxUVvw4C4gJYX+2lc/ZzQG8/r7xfjnJxSTl2o7H63o/4VebOebHg/vQezu30Upbo1YYdpd2+nQ/61XdgRw0l1XRURoJGriZN1OHHostRmO7muOic+4plxVHguCs97D/SinxpqYQvjCuh//8nI7BL+mI9/YRwmXklAVE7oVaGuhr7FptyslOekw/0UIaUE9LBMuaSZepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBeWr+L5Rrwtz2/0uDiix7MZXZyzzmmY3dUilSf/PX4=;
 b=LOvKviSqyFNwhZm1WsLOo1tWQJxp+TGBUGMUy3alNCuxOzb2+EgFMQI502WkLx96iuSYOC3JOo+yM6okt3a975sOGWwo/iB3C1rZosVm1qgCcwuyeOOCR23CYuuvQYRgFd1QGv6SZ4LycgC6yD6vnYRPVA3H6eg2YIGwDrf3jxwiBNHZbM9FEaV5/7dtBx9nttugK0Rm6Dioy7tInf/XWWPajLcWJeCESSvuZEZaZI7XaAsd6QuN9lfrzYP5s+waROibCFLMBOmpsBh1YCUSWhTvnkthqZ5ogfsGAiHnjuzjE++zLqMhjrvAxLso5srQZpNP2Qz0pt/Cm3NrnnV+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBeWr+L5Rrwtz2/0uDiix7MZXZyzzmmY3dUilSf/PX4=;
 b=JsHXNKevZmFtWTgpydneqMZzRSTUTI+wMuK8VHJ3qy0KTzVs6V5SeYfvovAu6kfrshZ1s/CuFxiz/VFoINbpewA1TPUqk8beNriHU7LsjUb//mWtGMo+I5dQUOkqMOQiptu7H4ZI/AHL78Zgm4/UorvlUZgQsnFGXxriJgZA/C4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oppo.com;
Received: from HKAPR02MB4356.apcprd02.prod.outlook.com (2603:1096:203:d6::16)
 by HK0PR02MB2660.apcprd02.prod.outlook.com (2603:1096:203:63::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Wed, 4 Aug
 2021 08:20:33 +0000
Received: from HKAPR02MB4356.apcprd02.prod.outlook.com
 ([fe80::d4ab:76fc:6326:a0eb]) by HKAPR02MB4356.apcprd02.prod.outlook.com
 ([fe80::d4ab:76fc:6326:a0eb%5]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 08:20:33 +0000
From:   zhangkui <zhangkui@oppo.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     zhangkui <zhangkui@oppo.com>
Subject: [PATCH] mm/madvise: add MADV_WILLNEED to process_madvise()
Date:   Wed,  4 Aug 2021 16:20:10 +0800
Message-Id: <20210804082010.12482-1-zhangkui@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: HK2PR04CA0073.apcprd04.prod.outlook.com
 (2603:1096:202:15::17) To HKAPR02MB4356.apcprd02.prod.outlook.com
 (2603:1096:203:d6::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.71) by HK2PR04CA0073.apcprd04.prod.outlook.com (2603:1096:202:15::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Wed, 4 Aug 2021 08:20:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb74758-0909-4fd6-5c34-08d95720baa1
X-MS-TrafficTypeDiagnostic: HK0PR02MB2660:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR02MB2660E8C5748483FF3943D861B8F19@HK0PR02MB2660.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAaxfwFCg2SAGeQPbasoEc9c9v33cKW+E2cO8E41eo4lXoKPXKLvhroZOQzZYu3fYjHioMFREm+odhy6Pz86rIGR/KZ0OvOuf+EtCWkMu1JXq7FDBOnZ3LnjNphBGShW1cxbpW+JclvtgVVZzvlPr/MVQP22KlGK9dUb2K2TFHwCuaoPOhuWrMeBoNeCjqVhyI2qvI+EKQ+3ByZTMV8My3GIvgnrC96cM5K7yXuVslRt30HT+hDZ/lmjeh0F/Zf5C9whr6h+3y8U1nRisaLnrH0pShCNRsAtUAIiuQewtVfJ648xcyjdTYH/83SnU2OIphbONiBOT0r/IwQOQ9QYRttNHKAek6yNMQsVddwTRVQehAevEKtGRb+LRL/9iEh/IdQ3zYIeHAIQaHTV7Y8uZ5wfp7YjrWr6SP8yEh9zO3wgk7ZCvNWFu6Edum+0uOi1XEumopH0Fok9SrdOXVPdlVmx/QgnF+JbBFSOoG0Mvu5yEIGxvPf4MjrFy4lSJ3ZcGz9nCxEgaUuBFoHdBSwB90GF3qgpk2dscWx035YmYR1oDLkusZj/u27v/lP7DkACqxyXkv0YLwKckv/Y6UAqJnOaSG8GbIinNyVtpm6LIRvJ+T3pqPGQHFDr1XmZJ6QN8m77MDvjuFcxY5qxykGh34iDBe+vQaGWvRL2W/Diq5IT7JhQwF0FNtHdVxq0sz0TdxMfRvBzpEI8G4h5iAucLidSnzE/dkHBm7f5P1ZBdYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4356.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(86362001)(8936002)(8676002)(1076003)(36756003)(2906002)(38100700002)(316002)(956004)(38350700002)(107886003)(2616005)(6512007)(186003)(66946007)(5660300002)(66476007)(26005)(52116002)(478600001)(4326008)(6666004)(6486002)(66556008)(83380400001)(6506007)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPrFS5nUjZCH0qDxjwC1adFNchpW/C+2ZDrR0zxfBC9+gnqdMuYLdLuPuutI?=
 =?us-ascii?Q?sx0CJD1tn5WyEidqrN15O1WiwZHAAxdCaJcTakcIe89U+gtq2CESqcx33FlB?=
 =?us-ascii?Q?BcoG4l23ebGML94igGcC2dC5PZ2iT7QB0acGSV5T2R+iuU3pQY+rNqnzAtrU?=
 =?us-ascii?Q?19HWVJRBnpvsG5RBUdPE3UyNXrOYGg/bA9DtuCi//jUc9M9Wz2WVfaHC9EoO?=
 =?us-ascii?Q?TcH+ossQbUqJ9btJiORRpN9hC96e8IhNHpj44TO+V0FPlFr/pVEm+OkEKW2D?=
 =?us-ascii?Q?h50LiYUdVOXCQUl0wylL4SP73x18nZhU7EifI9AD02Jzc44Xtu6Dk34zZswm?=
 =?us-ascii?Q?zTUyLWKhHzzGmo4G3htuxjScjgEJW5Sb7135kWBF3IbkjsvsA4HnD68znC2l?=
 =?us-ascii?Q?qE5/o+fsADzyuPNVMmB0JmvLWBvR9UrqZhHHxioFelAWlaV1sHljgCBD1hQf?=
 =?us-ascii?Q?Oox8UmyFWcRXS4VRWoUwUd1Q+/QrmGbwRD53APMoL/Hcurlt2sjjCDk+AxuN?=
 =?us-ascii?Q?2NL5hesnXh2s9zpJF7SogFsXe69I5HdMWDPJXJNCJn9KyMgnjBNGVIvDnsCN?=
 =?us-ascii?Q?AlCAsNetw05n9fEISE7PkztPWf2eTxTXGI3cQnp949ZKY3JLk+Pu6/yPfzXQ?=
 =?us-ascii?Q?VekJtadXLE5ydLApi0rjdJdKG53cT1CCYYaKNh9mzkTbVI/cVF89v+drrOtF?=
 =?us-ascii?Q?PjlcJnOAUO7FcR9gnYShxmhstdszyFIIAo8079/o/KlhkK2o9DDYjiDhWrUq?=
 =?us-ascii?Q?KgEeOlKmY3qJCne4WAJVp1njw357iL+0k6goDbMyjzckpwcEMq1EYVQovCuK?=
 =?us-ascii?Q?YT3pOVKl2wj3kn9JfPsT9oI4fwUiAijzsPhiQLXPPFaqgL6g6Nlm7qCoN53c?=
 =?us-ascii?Q?Qm3W/vVFWEHwK6V5CGFOJBnq4Mlbmc0QxgOxNhmLw1yiIBBkGLQRsVAUyDR1?=
 =?us-ascii?Q?ZPCXr+jaV98frcM1IsjtI+vKYB77Hat0vksYQ5FUFKw6qkMEBOeiE0UZfQ0k?=
 =?us-ascii?Q?uTdlcz6PCJNodh1PPZeO5EaJ+EOlWr5sFFa27YLDTig6g3YP8TtF9WOaatQU?=
 =?us-ascii?Q?9Vh574e+nYznAb4dQr3V++lU1UoDo9dL0BLzWWLOH8w2nYrJMEp3lwDMDZaW?=
 =?us-ascii?Q?scmKxOR2Gmc9r6OqvKyp5xPwmTr3/+/OXTfn8ebOY0Tv16E9FPSHsUg1U0zk?=
 =?us-ascii?Q?ox4D4uTjG6nvMylI3TVcjCHSediJVzoQnUAYVUIxhIsWhxNjhUjZYyZOlcEF?=
 =?us-ascii?Q?QHa9OJ6UIf9AWXkC8MZY7ZOHpyWNZqTjf5EHdjj7LeAKLWRdeTHhqyzCgCeu?=
 =?us-ascii?Q?nUmIGw1wk2EGYk8ouWjxITFg?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb74758-0909-4fd6-5c34-08d95720baa1
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4356.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 08:20:33.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: os6idkcYdusfrDJRDSEmsn2uj8bIpl6bMQgHFHh7QRWX9SAMK7Zde25Rt/lp89QgPuDUjF2xxBBdCeSIUj8tVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2660
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a usecase in Android that an app process's memory is swapped out
by process_madvise() with MADV_PAGEOUT, such as the memory is swapped to
zram or a backing device. When the process is scheduled to running, like
switch to foreground, multiple page faults may cause the app dropped
frames.
To reduce the problem, SMS can read-ahead memory of the process immediately
when the app switches to forground.
Calling process_madvise() with MADV_WILLNEED can meet this need.

Signed-off-by: zhangkui <zhangkui@oppo.com>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 6d3d348b17f4..b9681fb3fbb5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1046,6 +1046,7 @@ process_madvise_behavior_valid(int behavior)
        switch (behavior) {
        case MADV_COLD:
        case MADV_PAGEOUT:
+       case MADV_WILLNEED:
                return true;
        default:
                return false;
--
2.25.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
