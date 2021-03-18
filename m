Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8034012E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCRIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:48:59 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54828 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229866AbhCRIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:48:44 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I8jICI018541;
        Thu, 18 Mar 2021 01:48:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=iLKsd+d1tGYhuzoxR+ALr1T/Ml5LJ+vFN21VNbcpO+s=;
 b=nkkjpVThbGCNhgq8XysdP0n32cT1lKUZFOIPkE662dxVHWeFfG/2OZlyehVIcM1Hwenw
 cKLpn2+vILeINePjAvr8K9q6Bh0GZ0xILznGm8mTdQt354bEpLD90X74k+GTviWFoLcH
 R7JAU0lPZssg5Z26+fomapGvkxOAo0SIqogciOaLL0l7LYWl28UYXmx0VCpbK+N2AAjX
 /2PRSknLxO4aiWForPjk7LU5Qs7J5RaIiT9wUj0cxJfaBa4z7WiQPGHkVvKC74fUBuDn
 VhQCl8EGztommw9vJityl3f8Zmuxru70hDLU4lHFOZ4qpNoHIVSrBvSBaPs2cNhHRIUZ uA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2rvx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 01:48:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCKgGOLGvtXwqOjvsRiWwqEw3dWfXhhq+zADiuyjGzoh0aQA2WIPdxrG3MiBlaU953/73H4HmN87V/CJALRCx+qx4Q30go+ui3tvABZ+ycepVmgIFx5Lq7d2B35OCnjuo8GHQyTA4VuoVI+J7TlfLksbNSbM1Ef8ZIiefdfFbBDYc0Fh6KLcKaPBDdJl+l9vTUy7Z07sfEW0/o1js44woI1ji8qKrIT+0H+HPjU3D9Wly1kRulmHEX/Yi4QYSm5i+GDmrmbafYKzV2fBsajNPvzDVzdxrY94AOwlrhix0v35lMMRygBISpmnAAXSA9u4I10oBPn/+LPyHWxfWrnFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLKsd+d1tGYhuzoxR+ALr1T/Ml5LJ+vFN21VNbcpO+s=;
 b=GtUKXGJFA/sYIGuDc9jIrfpkjQCkGsqebaFdekoa7LIuwylFKwdny8Cjjb1IPK/YSxC7Zm5wPDd6w2C4DnljLJa3ato+CMFDFy9sEjNNxDKEkm0RmjVkrmhUUj7IJMha0BeLy8uYa4IHQgk6OOd6AqEhk11dWv+q6/hKMPsk1oWyjHyRmhs8oUEKbiQpaQLiNWMp3SxVtG/MQJvyqZF5bY05WKzTvgmXgWehz306RqYXoYkpA5gUXsEG2cW2Rp7dS2ucsCkH6IOVqAOq9re2aqM4j2LVarsy067pJWLY9CFiu3RMr8YwNB4A4c3jdtNmjSbGdMfetk0Up+165PHNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLKsd+d1tGYhuzoxR+ALr1T/Ml5LJ+vFN21VNbcpO+s=;
 b=I1+PMss5jJGl/kDZuvPY75Y49rfa5rKevHjUyapPbvwYzuTUbqfp6LgJy7deBmcLaR5jIUMdpqEW08a7hmOfW1JakFuZuYuPhVSWT9tklX5K4ubi/yecbqfGCl4PzFeGi4EQIQesLLXMAKxfRDcD3KbdUZCINqfI775SNoJQ0og=
Received: from BN9PR03CA0385.namprd03.prod.outlook.com (2603:10b6:408:f7::30)
 by PH0PR07MB8637.namprd07.prod.outlook.com (2603:10b6:510:82::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 08:48:39 +0000
Received: from BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::52) by BN9PR03CA0385.outlook.office365.com
 (2603:10b6:408:f7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 08:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT065.mail.protection.outlook.com (10.13.182.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.9 via Frontend Transport; Thu, 18 Mar 2021 08:48:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 12I8mcVW030064
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 04:48:38 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Mar 2021 09:48:25 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 18 Mar 2021 09:48:25 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 12I8mOS9041203;
        Thu, 18 Mar 2021 09:48:24 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 12I8mO9h041202;
        Thu, 18 Mar 2021 09:48:24 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fixes issue with dequeuing requests after disabling endpoint
Date:   Thu, 18 Mar 2021 09:47:22 +0100
Message-ID: <20210318084722.38412-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74a1f6b8-b8db-4679-c242-08d8e9eaa051
X-MS-TrafficTypeDiagnostic: PH0PR07MB8637:
X-Microsoft-Antispam-PRVS: <PH0PR07MB863762C265A7E4BCEC8F336ADD699@PH0PR07MB8637.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frrGeDcVStTgmkQgIToYxd0rAwKlZKouNZwm6cD9zhVxz1T/86zKfgqfPfJU1Ikc4r4rarIDeO1lwoRKba9UxV5i0pPsXZxLunpeLHtfQD460pX6UuHjXPnm3SBdLaKIUt8rz0r7N/qj5UQS6aDB1lZFZT1lw1bs21OrbQn8LK9FzL4u/M9mDWxTup7Ql0vSNAqexMrb2OHiOHoRkpOvFUMmeuHOXskKJsQzdezCsbjvRgFKHhzgIfwnDvIIiz8u8RNnSF5s0pYwrRGsEgNWzYDmAG5s5FXZDwnjkjqzueU2W8h3wNfJK8cQIRyEKZ128j1Hsbjmk5p7JkFnyaZHWT3g2aCBlLIVLLyXj5QsxM1mS7nMd1Fv4czc78mBlRrImVf5tnEeBdtG2DRzc4X9N8wsxDlkDTlXlX9q2tQNRWErqP7SPLepDVMhp9PbcaIU2gfdKkCc3SYqauQg3pauRVC7aVfjRwxBHuehnGit73riAkJSNstCRERXq+B84EJ7I6Z1vMym/f4gwEu0TeFkSzPzyaRU61NmklpWHz2RoaU1nvdWx4q5aD7VCbXuwipb2nVJf2sjMWqVV01ndM8pfYSZQhBVv5XK57lASnJ7Sh1IcXQTmu5OJBH94ftXuLJ5a3+928E4/YHs2Of3gqqrb0AV72s54/yDk+6DK1eMVOuwxWTTGXcQzM3M3aMUEd7ZmLSby+GrC8zKfMKPUll5tQ==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36092001)(36840700001)(46966006)(4326008)(478600001)(5660300002)(107886003)(81166007)(54906003)(8936002)(42186006)(316002)(1076003)(36906005)(2906002)(6916009)(26005)(8676002)(186003)(82310400003)(86362001)(70586007)(82740400003)(47076005)(70206006)(426003)(336012)(356005)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 08:48:39.4017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a1f6b8-b8db-4679-c242-08d8e9eaa051
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8637
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_02:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=524 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180066
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

Fixes: commit 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
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

