Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7232E0EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCEFBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:01:01 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:14420 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhCEFBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:01:00 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1254h7xX022465;
        Thu, 4 Mar 2021 21:00:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=MhRYpAqN37kztJ4LW/ZOnXAODaQTKYQMouHaujVcppk=;
 b=EzPtXSx2NmvPKhKZUgTHriaOrUg7y8P8eZs/kZA7jLwJuty5279FWru+TqBX3d85ljzN
 z74C9udFy6Vf4Fg4Nt8LmxmCNTTUKXd+axOxzvJGyaURrl7Gg/46aDz86V7WgBjpONSm
 70H2M93Q1vKwQn1ihqXeh1habYzfCy8N6jpn2xkYCeI4KN9BCQCuxgDNmhe3BiPwaM4x
 zv+qcDH52wDiuc8Bi9u7AZ/xmjo5EJ5KPEWjOhlb8sCeRW0LRCRNg1HMuJ7jnKH4qXbI
 L2+PAyji6BLMSgYpIdkCOtevv+eidohUIxQx4n9VHq65Za+4lI5ExeWGSHyJgjIbfopD Pg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 372bvqpuxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 21:00:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaTfJcRN7fCETHhEXB3odqFvNvDf0QGmydk/+OEq3zbzR7D5N1+xKRqE0ioul+8xRF2bdgx5DIa0OF4e6J2jpU7BXNznelq60PJd60LNQJKoEcRL5n0E8BkLUBGWw073aeshCaGUDQBrNfQDt74MCCbTX0doU7bzzI89urnj6zW2N/CTi2WtPNgDPyyUIYoE/Yn3O8fD5HsZDM/Dumqq+xSowW2VFrJyj6XbJvWFOn2lM54wCvo13p4ptAExcGgZHWQcmNsCyyt2cb4NGdreOmak/vKtIgpwEQiagpgBv4Tq263rcf6qnkzgwTew0nlOpCeou2qYY2T6HxQ79G0/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhRYpAqN37kztJ4LW/ZOnXAODaQTKYQMouHaujVcppk=;
 b=TnkHZZs7hEQ0jKyzlSID3RtXJAw/ZSRHrXBMsdnCd0iEFFUc4X/QBx5mBmHGbyQ/ouJqSKencHlOglPNdtHhnLsh4Grl+6NZVzL9hFVaxRF8vvxBoNZxy/0Xh/Nmli0r3A8EsgbUmTbYOuo5jZMsJ3QTwjYye8PwYapd6mnJGs79t/Wylhe8mmetY4+W3ITFYrlgsM55CeCFJcGxiu0RR3KsuSm3mqhuRvLYkW0gP6Ia1F69QbJmJR2UPkFJXNk6M1Q0C330rGdk4K9tHcBH7KghsEFGU1o23K2sGa7zLhyDSHqP4IsxKP85HZEOm8qrKTS3j/nV8DOOQfq+Jj2C0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhRYpAqN37kztJ4LW/ZOnXAODaQTKYQMouHaujVcppk=;
 b=k7AwI1PTGy7t9+lpmRgHnbyRBkkwX09K6I2w2ysWVg6k60HqnL1S3EGCS7rjB2aTz4Ex4ADmYqGPCWJ2SxCLJHoRKSqytliku6SCarApHo4otzM5DGTxNsmVx1Ga2DjfhdDxdJEdJqQZKznPH2mSRn1iqYfnZQ25ysgVlT09pTA=
Received: from DS7PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:3b5::31)
 by SN1PR07MB3997.namprd07.prod.outlook.com (2603:10b6:802:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 05:00:52 +0000
Received: from DM6NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::4b) by DS7PR03CA0056.outlook.office365.com
 (2603:10b6:5:3b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 05:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT013.mail.protection.outlook.com (10.13.178.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Fri, 5 Mar 2021 05:00:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 12550mCv143465
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 21:00:50 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 5 Mar 2021 06:00:48 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Mar 2021 06:00:48 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 12550lXq004224;
        Fri, 5 Mar 2021 06:00:47 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 12550l7d004223;
        Fri, 5 Mar 2021 06:00:47 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
Date:   Fri, 5 Mar 2021 06:00:28 +0100
Message-ID: <20210305050028.3329-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3398708-f7b6-4756-438a-08d8df93a62a
X-MS-TrafficTypeDiagnostic: SN1PR07MB3997:
X-Microsoft-Antispam-PRVS: <SN1PR07MB3997127126DDE977814D9F7BDD969@SN1PR07MB3997.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76/XyUA3b7KKejpyQb63hDD1mvcE9OFxRsMXOO69ORzeeYGfwQJ9wdGMbwBfXHGiKvriaxcsR15d/NcL/9vrVQWZomAtgJsx+7tq9ZO0mm29eY2odJAj/6KLKJ9Px964J6dP8Jiu4QBOSzr1Z+/7GCbax1B+E7qhaLvqVgzi0VWHFKTUU7a6zin1Kk+mUIix9QQj9mVwo0yYMRuQ8KSnehFIX80pJhh+Fx4/Mf48fdxC5Uc+Vbdyx185mwJf73ktowfQjPFZDsO0xWJ9b1xMkZPHu2yYGeIylUMczU3EKQgXu0yDzIgN48CHqr36jgEshdqXjDRTIapdM+AZI+6DNd/QzqijrdcjumV8a1wpFEH7+7FhOivoMK1e3Byl0Bw0CY2P3PeLz/8MKELb14L8SIB9ih2xWnqp6XaYG0TzufCFjzGjs5NeDHrYXConXuMcxkYVWAFFj7HxNYbWR/qZXSGgxag6z9ME5eqAI3NdiQQfxuKu0TKLfxOFeapeZ4fSiwjFcVpmidIQCb2PGpurudB+aSXIIbKJWwDzF5iMJwIUa+VjM7XC8TRfFEs8Hk9E3koT8xmUQgM69jOkpbehEJIh1zQZ3y7z+CEbsPHtyusze4ey1XIXgU3CDBTIG+SYsHPlIz46CcDzeUVdzfA+yZkGIuMvIuJ8nM2/VArCSfxNY8EodxTpWh1cmi2QiZYwT/cplYPe2Mb9Uhe1xgjMqw==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(36092001)(46966006)(36840700001)(82310400003)(82740400003)(36906005)(47076005)(81166007)(336012)(186003)(36860700001)(70206006)(2906002)(5660300002)(86362001)(4326008)(478600001)(42186006)(107886003)(70586007)(356005)(8936002)(316002)(6666004)(6916009)(26005)(426003)(1076003)(54906003)(83380400001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 05:00:51.2850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3398708-f7b6-4756-438a-08d8df93a62a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT013.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3997
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_03:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=690 bulkscore=0 adultscore=1 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1011 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

The value "start_cycle ? 0 : 1" in assignment caused
implicit truncation whole value to 1 byte.
To fix the issue, an explicit casting has been added.

Fixes: commit 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index f9170d177a89..d35bc4490216 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2197,7 +2197,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device *pdev,
 	 * inverted in the first TDs isoc TRB.
 	 */
 	field = TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
-		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
+		(u32)(start_cycle ? 0 : 1) | TRB_SIA | TRB_TBC(burst_count);
 
 	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
 	for (i = 0; i < trbs_per_td; i++) {
-- 
2.25.1

