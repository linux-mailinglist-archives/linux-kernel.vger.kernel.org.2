Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92F33308D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhCHHcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:32:02 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33662 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231936AbhCHHbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:31:36 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1287VYPh026232;
        Sun, 7 Mar 2021 23:31:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=RmnFAAMNturGR5aZJQFGNRPhSbK1R7KREzN4K9En3L8=;
 b=Vz4ZJwXdYvtBMhzmRh0PVxZZDDMEXyi/68sE8mUkxJsUQHQUKRl78w9X+dM1U90mRyli
 RB9GRFC7GcVzYRpeBejmkom6zc+095keJ5GIAyaSWid10/fXKkkvrZnGvHQo+nz6lltG
 xQEWE7V06N9dD+n09RhxmsDs5uHdAfi0p/oON6Z2e0lo8P7WyxSMIbi+lo5nf5rNlkrS
 fy+3r2ptLqw933vysv2W5zGBN6pUiF4fmE5wePlTRdACVk3fAOjeCoLgBbALXhyjDMko
 SJBIWlBn2JLe4m6PNhMCpI52xC5VyRYk5+TmZW8EWriHTmzeuIgbaNtjbZ3wRl/3P8qy /g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 374762v3tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 23:31:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHepstXAFaXFg8jvEfdckW9eH7u9jd+KZtd+2e3C+N+1XoOYoF/mQmuph2yzcXqoS73dYTYZozi4iLTxJbcyIeaBgSb1AZcuk6OgUlbvgKFGP7J45n+U6cSIrMNlkklo8ThBHU1jshN9u24kp1rJ6z4Q4yWEslGzlqq3cgtfJ/OUj3rDujaSr+1yYCdRI8QW4XglNxDmaKS2boq3imiG/GY3uCl53rpsYn7M1rG5bXf1YVhKzUQLu8drxDdasz3xgmqRljan/sjOqQaim5mFriilQ4DwcfTKmfTnbWW/JHcv8Fnj6H3BnSitj+i1hAM/Fp/1tlqohpGwrUkGGgr+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmnFAAMNturGR5aZJQFGNRPhSbK1R7KREzN4K9En3L8=;
 b=Wd6QKGsyjaW56vYxHqIZBof+VtNgkIqZC/ldyGs+KAzNrIAjQCyp+B9gYjjU1GAovAsDyQwbeitxtJTMU8npfCefzJkgOuTwP0hloSGUCWMZnF2s2GmUD2GYFvlU7QP6LsWtsvR4hEiXT6UbejHe/bbu7J9RRg4moLqM00iwEEqxpSftCoyYbN6qq6UQdH+TrAojs+9S/q2d10C+Fz9Gms7Lr+JwIqVVEeB7M40YHGqsB9gPJTcEszrpkTSFoKIKO5MUAzjR5yY/8VumZUvillUtwULQtx0FS8g1q2ZIgtJJcffMFFH5p0myB22AdiNY3Nh491O4k8ryeFxspSoxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 158.140.1.148) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmnFAAMNturGR5aZJQFGNRPhSbK1R7KREzN4K9En3L8=;
 b=n8VMppdrAS++Uj9TKHvv5fh0yKwmBvFr+lwYm1dWm3JqNQaiyu1B5c5J7uuejdTPIpZcDdPt+gPete8F8gyNepE0k2Q2Vz82LvZ1SVyXO8qAW+yynA7K2fcVv7B5v2hRBJySthaSw9EN3qTdCeEFCvd8VViaycziYkodaXHc7YE=
Received: from MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33)
 by BL0PR07MB3972.namprd07.prod.outlook.com (2603:10b6:207:4b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 07:31:27 +0000
Received: from MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::d2) by MW2PR16CA0056.outlook.office365.com
 (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 07:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT048.mail.protection.outlook.com (10.13.180.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 07:31:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1287VOsb010696
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Mar 2021 23:31:25 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 08:31:24 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 8 Mar 2021 08:31:23 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 1287VNvc034646;
        Mon, 8 Mar 2021 08:31:23 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 1287VM5C034645;
        Mon, 8 Mar 2021 08:31:22 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdnsp: Fixes incorrect value in ISOC TRB
Date:   Mon, 8 Mar 2021 08:31:03 +0100
Message-ID: <20210308073103.33763-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b77917-69e4-466c-c2b1-08d8e2042f04
X-MS-TrafficTypeDiagnostic: BL0PR07MB3972:
X-Microsoft-Antispam-PRVS: <BL0PR07MB39720AE340234BEB5162DBAADD939@BL0PR07MB3972.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7WP4oQsQnUPz1fm/b1s04Mg//6v5iSD2JT3B4A5eQNPoEcOVgh5UYPiCCnHe4fN/a8lxP2lnCo7DN6YMLwQHv9Tblgj3UJEPpzbUfCE6ewvnKgt8XHxVhtYOyVYILLyCMv7Fpmj6yd/D3YXpO5dXdMCiTHNeE3y7ggScxi7DZUjRiIEMdqdniTbojKl2RIXaqdj4wGpYdAb2qXPhmavoipNffOqBm9kNzD24F+ff0xFHTd7HDRD0MLMZQsacxudKClrrCPj4RlRC76Fs8QwMrCk3bQpUii90cMjpnr37UTAhKXJxPdN1WBYRqMTXunqnyasJmi8suRz8oIis7GQtK5tRCBNdXuwS3BXbgzKl1bK9E2aTR+23TV5blyh3jgQb+N/3HqqlMNmCnhtVF/3655c1iX2ZEVCQYXR/lmPxmLpwkdfxw4W2i2EQvU0hFtwKPOOA95KA+0hvbr/oYCP/gE3yqe1uH61DX0TPioNrkkSVFmHN9HLvFKstsXkclGThQX/ENQkM2dJJT64A7OSUC3ZXRvf+ER53auH0K/2x/R3DFnblWMqLy1OtIUQRldGxfI2pF7t2VsDi5rqPZmhxPvau0PtPqlGupKwqOyA8J5olsdbaU3fp7/Q4T5cVsLUcyDQ9nEQXQm2TNsHXHy0x2KSPJS3TsA2bXo4WCaF/PKdDE+0u5YtrwNDiEpdr6+c
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36092001)(46966006)(36840700001)(26005)(8936002)(426003)(42186006)(478600001)(54906003)(82740400003)(86362001)(36906005)(356005)(4326008)(6666004)(316002)(1076003)(5660300002)(83380400001)(7636003)(336012)(47076005)(107886003)(70586007)(186003)(2906002)(6916009)(8676002)(82310400003)(70206006)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 07:31:26.9003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b77917-69e4-466c-c2b1-08d8e2042f04
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3972
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_02:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=575 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103080039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Fixes issue with priority of operator. Operator "|" priority is
higher then "? :".
To improve the readability the operator "? :" has been replaced with
"if ()" statement.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v2:
- changed the commit log
- added separate "if" statement to improve readability

 drivers/usb/cdns3/cdnsp-ring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index e15e13ba27dc..b23f09a68427 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2198,7 +2198,10 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device *pdev,
 	 * inverted in the first TDs isoc TRB.
 	 */
 	field = TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
-		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
+		TRB_SIA | TRB_TBC(burst_count);
+
+	if (!start_cycle)
+		field |= TRB_CYCLE;
 
 	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
 	for (i = 0; i < trbs_per_td; i++) {
-- 
2.25.1

