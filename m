Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1F330EB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCHMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:54:16 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:45194 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhCHMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:54:04 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128Clo5T005532;
        Mon, 8 Mar 2021 04:53:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=sjuXbiY5HZp6zZR0iZQOATszUQt0j+LCtR4Np4M1PUg=;
 b=TQTtPXTV9+8bGHW6/r4KHbCMaWdYKHX3wTuR4KvPGkpqz26hAZCdaD1Cq0PCBdL8zdaj
 E6jsti0npR6YI6OS2QH5dzdcNEhHgAYurpne6hgzHL1pHc+OvIBX7rlgkAGYu73VwmlF
 a5O6STp6XejoKv0jR3wfxL+uli26jNxolC5nvQ9FAl5aQ6+/wyB2HMJJMh1znf6n1NN3
 Mlng/vQybpvF73wfiCtAg1vkCe7GfSb1wI/fVSKmYUXfmf52/zWqbW08UW7Ukrh/Qr63
 DD7D0GckT90vHqHER5mTojFSPrEHPWsffZBaqD1btiEyj45rpbfXNfIkwmCpJeVlVuNn YQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 374762vvc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 04:53:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfU9bOq0fOICcW+2V4nNx21rQ+jrAzk+Y2g264A1aVOgbEpi0Fsu2CVGItkjqtSjx9q/U+FEouq7MZGUZmpvBWxGokknlthpkZc3cLAmWVMsIe8S2aUY4Q4g4AbbMxZDLwsrkbhTAjSP5e6caD4oFCiX3H/4NJ1J0cVVbdWxC0MocUGEK2D1L0celRNBnMI5HL6LwPDMWG6kPOcOiHtEoiTL3G4bkTKbt93mRBdFQxJXrzoscFfZkNzOS9o66H/c3Jy1624xW3k3pHxbBdNZp5JNJRD/USbczzJGW8kjW60SvqVjEvaUussBTYFcZobhFyWB6BaQ8+5AH+5DStA+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjuXbiY5HZp6zZR0iZQOATszUQt0j+LCtR4Np4M1PUg=;
 b=ENVurWgJqZm/XzQ032/UUrE3ferNK/aC4IT00+RzqliFc7PvFDyyzVknkyzbN4Qw7TOKYWCuhOZzxfImBu+3N3kwo+1wlT7vI6ioFtiwHpjh2mWqf75+M9Y9fTuoH05eNjR9ECISvb9tvqbcKJOFcOHnRQFu+2GzsEmbxQDJibfKugMAkEba3KwHajYXgKASDuP83SGw9srN42unFDGsa3pdnr1BaTS0shzvzbf7xY3AZaWYwA17fTwCbkZrxJlyX+Ws/wsozisd2dwEMZ51nfUmm8mk4/xObsQZBU9lJr9rJM8nrm0qIs/1CQ1cX3MjotOx6BG17OwytL1C7qUIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjuXbiY5HZp6zZR0iZQOATszUQt0j+LCtR4Np4M1PUg=;
 b=e8+A0/UGQbmc5oNch6Ol2j1eoW5rH8biAJVpDscy9DEg8eg6FfTsGdChKkQXzs7rwLDNR6ngGvjYgaS2vGbGKcZ/IuLkOrCc7tBEX7Uw27pJm/47dm6Q6nX3ghtYbOStJvDsYQkmaRaFZg7AOhmmnvNF2f08f237Gfy7QPyWDqM=
Received: from BN9PR03CA0476.namprd03.prod.outlook.com (2603:10b6:408:139::31)
 by BYAPR07MB5640.namprd07.prod.outlook.com (2603:10b6:a03:a1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 12:53:54 +0000
Received: from BN8NAM12FT034.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::12) by BN9PR03CA0476.outlook.office365.com
 (2603:10b6:408:139::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 12:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT034.mail.protection.outlook.com (10.13.183.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 12:53:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 128Cro91161074
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 04:53:51 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:53:49 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 8 Mar 2021 13:53:49 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 128Crneb005348;
        Mon, 8 Mar 2021 13:53:49 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 128CrmxF005299;
        Mon, 8 Mar 2021 13:53:48 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <laurent.pinchart@ideasonboard.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peter.chen@kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: gadget: uvc: add bInterval checking for HS mode
Date:   Mon, 8 Mar 2021 13:53:38 +0100
Message-ID: <20210308125338.4824-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25459351-c254-4bfb-9f37-08d8e2313a0b
X-MS-TrafficTypeDiagnostic: BYAPR07MB5640:
X-Microsoft-Antispam-PRVS: <BYAPR07MB56401A7AF1870A9293F9855CDD939@BYAPR07MB5640.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eI0otCkSzZcJnL60Mad0+1QjVi+V+uabbaLAOdZkUix4C0vKgWq8mo4S5I3cW1wxtwdlEgVSAavfTGpZGFnqcvctyCMYRKJu3/SOvu7/3bgmb4vWA0ZS7dohA8uZBNCZTIMmZCCSRkw53W42xpCVYSGblTEEQbP6em7yc/p8qV3eoo17UUMN2Xd+l0ZtY0FugZuOyqDx6hEf6VZSJ18TNiPKLiOyozH45YezcQU3RZ0Rvb/cEeYmDpmew+G11pV6P3Y+dIKbjkq5e9Gg0eGoJmz/kO5AKVywFj2xCBOTQx+W2kBtWaOn/Shdu7zIZagda9ytLl4iu85IUvw8lNmg+LU7ryz7w9dmo0JVnvCY9M99P7QR/T2CAeeb4DbN0JZQHe5J85brgL6uonlquW/YSPXfsHaZQD3szEaTkGH71VXluAlXfK8bs8VPC93O1qofry3RTHa5eW/OagrjPYeWiyvkxx+MhlumGMq9gkR9SyAD63FrcOvMyGmEUuHZ2r9MOj034nCpc23u52Aapcr/yO9v5f+Lytb5LuJN/xfP6je06vt2pZ6C3Xlpgddr7H6J0sa2iUYT9sCHMSm8wioY9iEs6ZjBMnSlVMZC8qh7tvI9lBcF/mP6Jfdz2ZyXp/KLVoJbpdbuft/vujZoIta7E9NYsuwRNabTjZle3qDVOdrGYE1yDDw4zih/c4f+aUhT/UI9W2FCysCaXUwta3VE/A==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36092001)(46966006)(36840700001)(6916009)(356005)(36860700001)(8936002)(6666004)(5660300002)(86362001)(81166007)(82740400003)(186003)(4326008)(47076005)(426003)(26005)(83380400001)(70206006)(478600001)(70586007)(1076003)(336012)(82310400003)(107886003)(8676002)(54906003)(42186006)(316002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 12:53:52.6581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25459351-c254-4bfb-9f37-08d8e2313a0b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT034.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_08:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=641 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103080068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch adds extra checking for bInterval passed by configfs.
The 5.6.4 chapter of USB Specification (rev. 2.0) say:
"A high-bandwidth endpoint must specify a period of 1x125 µs
(i.e., a bInterval value of 1)."

The issue was observed during testing UVC class on CV.
I treat this change as improvement because we can control
bInterval by configfs.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changlog:
v2:
- removed duplicated assignment

 drivers/usb/gadget/function/f_uvc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 44b4352a2676..ed77a126a74f 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -633,7 +633,12 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
 	uvc_hs_streaming_ep.wMaxPacketSize =
 		cpu_to_le16(max_packet_size | ((max_packet_mult - 1) << 11));
-	uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
+
+	/* A high-bandwidth endpoint must specify a bInterval value of 1 */
+	if (max_packet_mult > 1)
+		uvc_hs_streaming_ep.bInterval = 1;
+	else
+		uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
 
 	uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(max_packet_size);
 	uvc_ss_streaming_ep.bInterval = opts->streaming_interval;
-- 
2.25.1

