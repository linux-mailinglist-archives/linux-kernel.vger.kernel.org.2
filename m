Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65D1363CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbhDSHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:52:43 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35576 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229963AbhDSHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:52:40 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J7n8m7026620;
        Mon, 19 Apr 2021 00:52:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=AZSAyLvlKtc4YQoehx+PKWPs9zsOMVMC4D/vtWCVBOw=;
 b=Gi8nFGdKdvlrA9ozKfg56SPepA938fehx1GaD0nbT3qwaKfqUiRKRZrARM2eSqYZqxhC
 HNUPUoWluhp71c6D4+kY+P+mHCOQyp7J3drpJuZOgdtXYffi1NZ+hE4L1+rwpw880KJt
 Y+MnYUZ4mm2D9O6c6lbpu0ozlDyH9xJzOGW9yatGH/dPjQ8O60QQ0FDlZLizKyHS7nQk
 dqOWBkmMK+vsPeEmu8fAsgdarakh8wllab6RPdCkTQvyR8niAu8Kw+XagyKW5gcYjuTP
 opKLZ1rOoMObrc/cQYrHK8e/fgUSDTBnmV3wR/BrkJYl0HEcgM+sw0UdKleyqTDT3uYM qQ== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37yu91mf3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 00:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dum3WFEr6lYar9FW+8YY99vK6Rm5pOUZ8ICzlrxMDbQ9izmncJLjYnRnDebVFGbVc7Nh+7IR1B+pNDVD8/2lC3mpXjksT/AwVvPgx+NZQDXR5RvLSs4hrFDBMjslzifvMQKhrpZ03M+kncRT2U1QPaA0I+/QNpOy3k76Tq1WCzj46qRR0V84Atm2vk3Yoe6ryoel+kHcMHaAaWE95T7rU/bh+Aj3b4BU7ltkU1e0N+vhPJCqFI+Q+f0xl0dSWiK1QG00nNnSDuZ4pW7Hoc7bLv5Q4LeJU1lyDzdGaylB9RsJjiEkiBnhWw7q2OMQUR6nr4c1SpB6k1rtPe9qqD4+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZSAyLvlKtc4YQoehx+PKWPs9zsOMVMC4D/vtWCVBOw=;
 b=nfisVnxY2DzQipsfu4e6vpiIY4dbnZY54IK/vydn4NvwCisALDGbqVj7cvHWM+mhCDMAZm7f8yAA4NeTzbIjam1J2gXklLjl0INlLjp5apQwMqf7braqXca/dv2q0Ky5bfVZQkPe8dgWtCGTQndI5djqY3bMTiQ6HKuG6SOeMODlHY7u/OaXP6amqfcvl+/3BIg3/MPZ12EN7aedjyZLNlLvx3T6jUqvcm4692qcC9vvFi1M5/6XRCHvo2bfUCtNS4eaxd+AectB1NwtOx1wn6CtlTpOSGw501dC0xh/oq1GTp9ENv5wRfFSQw/2AUW06OZIs2Q00oLIO8LKfmhQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=gmail.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZSAyLvlKtc4YQoehx+PKWPs9zsOMVMC4D/vtWCVBOw=;
 b=A6gkiDwcbmDqx+5TqfKfEQRVfaEypfrakC1MpVJE+0qt6dcCldOLVGcRldXZjZxI9aNP1aW3sv4/TZHYmYVhf5kv7Ov+3i/XFqP2Dr2q/AOZFYvj19E3v21zNDXTZ83TjAAZXlSPhaT3rWXCjGAGguLdnw0sAQwPkclj1AZS9I8=
Received: from MWHPR22CA0002.namprd22.prod.outlook.com (2603:10b6:300:ef::12)
 by SN1PR07MB4030.namprd07.prod.outlook.com (2603:10b6:802:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 07:52:04 +0000
Received: from MW2NAM12FT043.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::5b) by MWHPR22CA0002.outlook.office365.com
 (2603:10b6:300:ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 07:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT043.mail.protection.outlook.com (10.13.180.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.7 via Frontend Transport; Mon, 19 Apr 2021 07:52:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 13J7q11q017347
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 00:52:03 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 09:52:01 +0200
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 19 Apr 2021 09:52:01 +0200
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 13J7q0Zf031370;
        Mon, 19 Apr 2021 09:52:00 +0200
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 13J7pxfu031241;
        Mon, 19 Apr 2021 09:51:59 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <ruslan.bilovol@gmail.com>,
        <jbrunet@baylibre.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 1/2] usb: gadget: f_uac2: Stop endpoint before enabling it.
Date:   Mon, 19 Apr 2021 09:50:53 +0200
Message-ID: <20210419075053.28467-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d23ab83c-03b7-406a-361b-08d9030805f3
X-MS-TrafficTypeDiagnostic: SN1PR07MB4030:
X-Microsoft-Antispam-PRVS: <SN1PR07MB4030F0111E9FA8085AEBE7B3DD499@SN1PR07MB4030.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8rVuFp88UtwH4MUcHF3kO9w+NSe7FubC5wjkTPbgVIT4FkmarQBBoqBafWcz8f3lE7fG0tcPe6pi5GKrdTevTimyrVH0y6NdjciWVQavhXXnLSNW7dNF7TBFlz0IbtzJvAkPx2N0Ck9WfI8pWanYe3NXxQ263+bvryKWOQlZl01LIcmNq1fYoXQLDD3XpV1UiwGk37jivdPZTwCL+W+CD9m/s7FXQxTbIhTbtVjmHUNW8zL86hsUoWENIQKCFEbzeBCc0JuIZ/sSw1kBY5DPgN4X6VRZkWPLaVNEnNu6biOk7BmVquHigvYzxB8SmhuzN1AHz36TJYFPssfGOxHVN5TXHAJBSsAPv9PLBG9Dt1AVS9lOtpxFSlwb/G/TuopthFt+U5O7VgR4emVDi3TlCjbYtUK6RxYIl8UYuTaIYXme6wzagMxYwM2I6pvPTTHAcM+t3FeDYCoKyYW8sPynlmDFElyKr9xI98iYVj4Va0OXW18Ss9m/fm640ZcFNJmK7XggidzUdLLbKJfOsF6d8dT44/S67yEva+SD2yVWwqXHQKmEC9hT6Ryd4+9dfnUvIlLCyeqodUzIE/iokdL4ctY1Knar+Oi63YcEE0fqCQcOU6ieYWAbELtz6B2SveM79ZkpExaRaKnisaobkV0uZ1GHPCVbYZ1dEowgvOCKn7z+qpIuxtG1DmZ2xFFGQCQ
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(36092001)(36840700001)(46966006)(36860700001)(42186006)(316002)(7636003)(336012)(426003)(36906005)(83380400001)(356005)(186003)(4326008)(26005)(1076003)(478600001)(8676002)(6916009)(47076005)(54906003)(8936002)(107886003)(82740400003)(70206006)(86362001)(5660300002)(70586007)(82310400003)(2906002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:52:04.3573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23ab83c-03b7-406a-361b-08d9030805f3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT043.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB4030
X-Proofpoint-GUID: MIxVkS2AkA6Zg9WJ5qarbOfLZ3kZEMNd
X-Proofpoint-ORIG-GUID: MIxVkS2AkA6Zg9WJ5qarbOfLZ3kZEMNd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_02:2021-04-16,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 mlxlogscore=555 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104190053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch adds disabling endpoint before enabling it during changing
alternate setting. Lack of this functionality causes that in some
cases uac2 queue the same request multiple time.
Such situation can occur when host send set interface with
alternate setting 1 twice.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/gadget/function/f_uac2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 9cc5c512a5cd..7d20a9d8a1b4 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -890,17 +890,17 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
 	if (intf == uac2->as_out_intf) {
 		uac2->as_out_alt = alt;
 
+		u_audio_stop_capture(&uac2->g_audio);
+
 		if (alt)
 			ret = u_audio_start_capture(&uac2->g_audio);
-		else
-			u_audio_stop_capture(&uac2->g_audio);
 	} else if (intf == uac2->as_in_intf) {
 		uac2->as_in_alt = alt;
 
+		u_audio_stop_playback(&uac2->g_audio);
+
 		if (alt)
 			ret = u_audio_start_playback(&uac2->g_audio);
-		else
-			u_audio_stop_playback(&uac2->g_audio);
 	} else {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return -EINVAL;
-- 
2.25.1

