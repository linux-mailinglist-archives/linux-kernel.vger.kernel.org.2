Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45413438C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 06:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVFr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 01:47:58 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:28110 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhCVFrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:47:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M5gxSm018910;
        Sun, 21 Mar 2021 22:47:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=MK2tO58IR+pfrQl3V5IK2JsPcUaOeELpFQC2HCpAc8s=;
 b=BURqGlS0EmiTTCMsfeTbVNAqDzpBbMHEaOOY7B5zjFShdflpMK8JhAdMpzRzdoiIZjQp
 qyy3FitZkH4fgqhCrEeht7hRcUBtwSAd4PPdLS5c0ct7SWPUfut8NgyQkfLCPIjZhVye
 O5fIkof71vMmH/WcxhB6tPEQjDWEJaRRe2vi8Nue7hd0yV19y7GT0THIkDr+piCwqnc3
 OaWobBamq8eN2F0d/5riCxM9zeKeMCP+0S81U4lR0CegLx2vUI4CiP1LX+Y//eeKcK8m
 sZud+9L5mzIun/d9UMWMigCx2Ho0KVovkTBI/8omKwDVIBFh5r67pZigVJodwm4fnm8S sw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37ddkxc40y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Mar 2021 22:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQJFAQIk1iTJuRQ4t0LY8ra4pJN57q3tvtvWwT2udnBJcxGjhOVJyBQ/YV1qRQxGEsYXdHYn4sJ6R+/fTe26UGRv20b9VEu1j67u9lngwByDICqcsmb9SFJ3eVV8fUpEHeY3IsoKGeAQqFfBtndEmo9bYtUH+uLRfgZgaLoNLzx5gEbr0Tv/4wcUHEep5rGjMGdUuy2Vyz0saVCRga2XXoCfLyBsZ1yiutytU4fWJIq+rlqkXu+GY21bg9iD1hXAqPmdtHoEaDrECPSnV7bWMF/P9TdKjkMK4V4eW9HWM010UJ1i+Ev0b9sYRluC24lR97ohvKGf83SPuIXQiydKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK2tO58IR+pfrQl3V5IK2JsPcUaOeELpFQC2HCpAc8s=;
 b=IrHUUpxd6OSHqZwfzV3YX1Wm4ea6yzkVJ2quT6LpRLGyMYE0Jf0MCPmEFqZsdVdfyoGt7MLt/nplKBo3xdFYzqTi47wy9NKtK6QPJHjlnZOT8bCI+uGKRX/kZBbomyKKxbj1sh6NbLu0mKnnbzw8pWZiX24TtF3dVPi3oMAbc6SaEuggskEgpCsp0lwyNhWfnpDmqB8i95k5TMjkBKn5Qc+4kwNRP4HicTbhF0uD14195BWXTez/uyoyItCXNbR12wzG/92yLmuvCh/j3waHhWExSzIdRRE/vfeGsn7UX7ICsiLRY7kStbaCbbALN4RVtTZy9MdMaaU+evEiJavS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK2tO58IR+pfrQl3V5IK2JsPcUaOeELpFQC2HCpAc8s=;
 b=oqvTdBlx83vmgh0GNdkcRj19UaapDpUuCqctPL79SwOReHvDg3qrcZ1lb72FoNkCiuTHlhcPJDgIa1Z51DMmyUWClyws1A2PVCWYkzloX1ouypgakCm7u0sEcgNKoRVMDbIRzwOcB6q2cMWEq9u26qKkxAj8MCzqrSSa828/550=
Received: from DM6PR06CA0002.namprd06.prod.outlook.com (2603:10b6:5:120::15)
 by BYAPR07MB4328.namprd07.prod.outlook.com (2603:10b6:a02:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Mon, 22 Mar
 2021 05:47:35 +0000
Received: from DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::52) by DM6PR06CA0002.outlook.office365.com
 (2603:10b6:5:120::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 05:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT017.mail.protection.outlook.com (10.13.178.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.10 via Frontend Transport; Mon, 22 Mar 2021 05:47:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 12M5lWX8017496
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Mar 2021 22:47:33 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 06:47:32 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 22 Mar 2021 06:47:31 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 12M5lVtS047929;
        Mon, 22 Mar 2021 06:47:31 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 12M5lUar047927;
        Mon, 22 Mar 2021 06:47:30 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <sfr@canb.auug.org.au>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdnsp: Fixes issue with dequeuing requests after disabling endpoint
Date:   Mon, 22 Mar 2021 06:47:14 +0100
Message-ID: <20210322054714.47151-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6908059e-3623-4269-8a22-08d8ecf5fe64
X-MS-TrafficTypeDiagnostic: BYAPR07MB4328:
X-Microsoft-Antispam-PRVS: <BYAPR07MB43287DE4676416092D34D17ADD659@BYAPR07MB4328.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5Ga7RcDbna0kmyVlzBNnpGwzmwUffd4EDCra9bNPJsaAruNUflSSsAHLA4ZZdrMSOt3rv99Fp9I3udrwGONNh3FCRiivnKMxR8iieb10JCZLuuAqp2RYwSR8bogWameLs0o42/HfNJzHfvT4UWsLiN4FjbiWHoG2DKX1mIAP2RNHHLalR9qBEKim9NP4D/kAUHajbQuIX9tz2Er7KGyOxpL+PVMFxRlqItiWsRbMGRD174yJNlqIKAmSL9d8ITocSkLPxxg9XS1qYSmm3ltAZVBzHTD/gabSkwGkSzTNTzi4wnd8UahRrkeqkvf/Ec0EpEqbsjCyCHs675W6Z1cmn+Y5psSdniiI6uyw7MG8qAinbvrCyX0Ei6JrP+fq8odBmXzvUu4ZeE6XUkfZym463OXeNQjo6zN0jXWgIC7+yyVEJ5Ly0i0phP/wsmTjxuED+O8lXpGHHeEU3GaaJVE/sAwxm1Q4nn/7MDqszHfiWtSXOrQuXH7BoqTUsRVa4yQF6DKtFdhd/zgDp87MJiyT/3IdMErfYv+a8ke1X4RMkYFgxKlLfvxlXf0/g42c8R7FJGtLllEXJZZd/fXYZbJKnsvELTPJ5R5QWfVj7RaRWopDYSfQ1M/9mhb3zdi5vV24iWXKTuWblQ90C6CzVi004w4S0MfaOA7mx2yQG8Ar1kkk3z37bjBm8w8M20zshZJ
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(36092001)(46966006)(36840700001)(8936002)(36906005)(54906003)(70586007)(6666004)(478600001)(26005)(86362001)(5660300002)(83380400001)(336012)(8676002)(42186006)(70206006)(6916009)(356005)(4326008)(316002)(426003)(7636003)(36860700001)(107886003)(2906002)(186003)(82740400003)(82310400003)(1076003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 05:47:35.1020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6908059e-3623-4269-8a22-08d8ecf5fe64
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4328
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_02:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 phishscore=0 mlxlogscore=598 clxscore=1011 impostorscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103220045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch fixes the bug:
BUG: kernel NULL pointer dereference, address: 0000000000000050
PGD 0 P4D 0
Oops: 0002 [#1] SMP PTI
CPU: 0 PID: 4137 Comm: uvc-gadget Tainted: G           OE     5.10.0-next-20201214+ #3
Hardware name: ASUS All Series/Q87T, BIOS 0908 07/22/2014
RIP: 0010:cdnsp_remove_request+0xe9/0x530 [cdnsp_udc_pci]
Code: 01 00 00 31 f6 48 89 df e8 64 d4 ff ff 48 8b 43 08 48 8b 13 45 31 f6 48 89 42 08 48 89 10 b8 98 ff ff ff 48 89 1b 48 89 5b 08 <41> 83 6d 50 01 41 83 af d0 00 00 00 01 41 f6 84 24 78 20 00 00 08
RSP: 0018:ffffb68d00d07b60 EFLAGS: 00010046
RAX: 00000000ffffff98 RBX: ffff9d29c57fbf00 RCX: 0000000000001400
RDX: ffff9d29c57fbf00 RSI: 0000000000000000 RDI: ffff9d29c57fbf00
RBP: ffffb68d00d07bb0 R08: ffff9d2ad9510a00 R09: ffff9d2ac011c000
R10: ffff9d2a12b6e760 R11: 0000000000000000 R12: ffff9d29d3fb8000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff9d29d3fb88c0
FS:  0000000000000000(0000) GS:ffff9d2adba00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 0000000102164005 CR4: 00000000001706f0
Call Trace:
 cdnsp_ep_dequeue+0x3c/0x90 [cdnsp_udc_pci]
 cdnsp_gadget_ep_dequeue+0x3f/0x80 [cdnsp_udc_pci]
 usb_ep_dequeue+0x21/0x70 [udc_core]
 uvcg_video_enable+0x19d/0x220 [usb_f_uvc]
 uvc_v4l2_release+0x49/0x90 [usb_f_uvc]
 v4l2_release+0xa5/0x100 [videodev]
 __fput+0x99/0x250
 ____fput+0xe/0x10
 task_work_run+0x75/0xb0
 do_exit+0x370/0xb80
 do_group_exit+0x43/0xa0
 get_signal+0x12d/0x820
 arch_do_signal_or_restart+0xb2/0x870
 ? __switch_to_asm+0x36/0x70
 ? kern_select+0xc6/0x100
 exit_to_user_mode_prepare+0xfc/0x170
 syscall_exit_to_user_mode+0x2a/0x40
 do_syscall_64+0x43/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fe969cf5dd7
Code: Unable to access opcode bytes at RIP 0x7fe969cf5dad.

Problem occurs for UVC class. During disconnecting the UVC class disable
endpoints and then start dequeuing all requests. This leads to situation
where requests are removed twice. The first one in
cdnsp_gadget_ep_disable and the second in cdnsp_gadget_ep_dequeue
function.
Patch adds condition in cdnsp_gadget_ep_dequeue function which allows
dequeue requests only from enabled endpoint.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v2:
- removed unexpected 'commit' word from fixes tag

 drivers/usb/cdns3/cdnsp-gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index f2ebbacd932e..d7d4bdd57f46 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1128,6 +1128,10 @@ static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
 		return -ESHUTDOWN;
 	}
 
+	/* Requests has been dequeued during disabling endpoint. */
+	if (!(pep->ep_state & EP_ENABLED))
+		return 0;
+
 	spin_lock_irqsave(&pdev->lock, flags);
 	ret = cdnsp_ep_dequeue(pep, to_cdnsp_request(request));
 	spin_unlock_irqrestore(&pdev->lock, flags);
-- 
2.25.1

