Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2147341D9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbhI3M2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:28:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48974 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350797AbhI3M2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:28:14 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UCIJeG002842;
        Thu, 30 Sep 2021 12:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=HAvinJjOiNP0rhknjMUtk+rzERxCHv50Td3ZNB4i340=;
 b=O79pelL8pVXbTpGHTrwOkHN1KwmQGVjKE+HpVT91PZdv3jGa/Qaw+UTVInbts/nADW00
 sQR6ZZGvxX4gM3ohhFzgFALwtsVnGt/OveS+0txAerQORycD7ZZHxoSUv44f8ieefe91
 rflWfJof02fotV/AWid1wHkkwplzY0CSJ23qRc2jkUmTBJHRwdlRCeL/nGZAVKWP419n
 JC2dijXVBhc/MHmOiBcvns9VxsoFzaNdwlaQ//3yySSLbUFhAWmxPktuwzIVYZOBEkl9
 SgRS5Enlr/wpGWhdJv62+GQrto7jJz3HtvWzExXor7BCeYv9uif/Gg9XEL/ySWm374XM gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6d2vym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:26:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UCFAAd016998;
        Thu, 30 Sep 2021 12:26:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by aserp3030.oracle.com with ESMTP id 3bd5wb0mre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJldZxvNJi2MEaiqqZ5c9mpdKH23Y7vuLNwAf1uaNHrJdCQj2uM82P1i1/1q87X+flkb4AgVAZpA9wDEVzvgTvxuQclW3ZwK+7JVkDGyYsAuMzKZiKcBujSdqLoCEeIFk9wdp4rDQ7AfdBEAQnbbry7YS9a6bJOlCRdhchdx2ybRbsfw9v75vL0TCUyLG33IkPvVin1skf085KmwpTOmypelnXyM5y8YxPfP8Ayfl+yUuJlf0QBLBidT9WP6mNvmuyoIimmEHENfWH/s0d+RhYJ1xyAfBKuR1yIy09pye18x2y7vaxk+c/6GKxg1+cud8sSWMRH+OOJezSXrlyTzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HAvinJjOiNP0rhknjMUtk+rzERxCHv50Td3ZNB4i340=;
 b=JV9ruw4IfS098yZXYUNpAt0iKL7M5gH1yg72ibxvEILMySmhcigy8FEgqVJ/MBUfjF6tmu6mTi8PmGVWi63AdF+F2c/9cD8TNltYqsZ5HevA3MVjU83GOIg0DG75MaOPzGNQl5KM4fTIqiXlpd3eUUGa68EQWAjadwPUpr60hlTUOV0KATHdKO6u4wRnBFiYzvAoeIyN/5hv/25IrQduQOFL8BPyBjYny3DaRwoEvyoefwN/wD4b9CY3PchGHb4+fe3q2OIpvvzHc3u53JtE1bPIJFAAXyF5MWQv0ozaAt/Ix8FsS0gQJqeq2sW9iRxqyM+uEcrQi0Kt9awnZj4GvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAvinJjOiNP0rhknjMUtk+rzERxCHv50Td3ZNB4i340=;
 b=zXSO0G2+0R7cMGrEUs4LO/yJMd/jzELJT/o79meacoNkbGfBmqPlqmH0St2Y8zs0deuDuF7jm3sdJ599Rxm8PkEAf3geZR/mBT3gANL8DTLQm16+gD6oFk4FLvfdgUHjg/tzZxsIdSpubXkcbX4uzrV0A9nXJyEKf1Qtd+518/w=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1824.namprd10.prod.outlook.com
 (2603:10b6:300:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 12:26:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 12:26:18 +0000
Date:   Thu, 30 Sep 2021 15:26:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: r8188eu: prevent array underflow in
 rtw_hal_update_ra_mask()
Message-ID: <20210930122604.GB10068@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0025.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (41.210.159.27) by ZR0P278CA0025.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Thu, 30 Sep 2021 12:26:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18e5fcf9-77d1-4395-ecc4-08d9840d8112
X-MS-TrafficTypeDiagnostic: MWHPR10MB1824:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1824EC5F2AF84F08FAFCF60B8EAA9@MWHPR10MB1824.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ft6au4UTi4ds+uAo++QQIrf4FQCSMUXMqUmOZIocs9qbSeWF1IRi1qJAZ5MEPOGBOXVTpwzUxQa/5J3unn9paQIFvpBspkey+Ja9gc489Yy8LZQEPK7nOjK37I5YczSaXijuygbc3JQthwuHZWxM1e7n/SudHKSvbyXOzzXoOEiZ3P7DL8llLgiN3bxQFRPuFgi+RzzVVyo09D3A3NMQOMjn+okOCgltZFGP5cSEleKrLCPTtMVsdilropLBV70fxwP8zCqAO4KQ9B495G8/o3BqagliY6knGzbYJdOO7Zpgm4iprfLBbgd8Rn6stesGqnz3fdDArJ+hwDjbJ7rnMmeK0AciKXM/QNO3zOjEmgegqOOFAXuillrroT1EXNa18f9QZHzwV7/kMF/NDhJaWKAPbfiQKxTiFrF341qEzhOyPqqPF5KLMnXkWSZsnE9C8JJUHNhv9+Gp1BRoEb+ewkOttkfodSskZmmmqaWsiCBWBrNVGKwOE8PhrC3cHE8ARjLh0yF7ckY+rRWoBk47Jv/t9RGfadfEN0RsEkgksqa2UQsD434w4zb2RMhWam2JjsUGAbsXPi/WZKFCcFRfvvwfNqiBWrV7vPM9ZvkvE55dbuz6XsrRG9TirD5VteV0NfL+J5pY1OOPsy8BcQmErvKbksKpcFm1Cn1EpwE1gPVB+mDsuMALHE5dux4fRuJY/4FQeURxyLTu8uTzyM+NjDAE3fH31W4j+BKWaeDCiLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(83380400001)(54906003)(6666004)(8936002)(316002)(6916009)(508600001)(1076003)(8676002)(4326008)(66556008)(66476007)(52116002)(66946007)(6496006)(5001810100001)(5660300002)(44832011)(33716001)(9686003)(186003)(26005)(55016002)(2906002)(33656002)(86362001)(38100700002)(38350700002)(956004)(5716013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zlAmeAs3LP8jWpBwK2Un/v6kHpZavg9zKNv3hQpCiJewHhIivc7ZOC0DeYq5?=
 =?us-ascii?Q?t4RXVXdq7ewvAf3YVS8G+CwbIuTLSTsOYW3FICx7ZCs6cz7biANplCBZZs5V?=
 =?us-ascii?Q?lij1dbNQ63B1p87lRxB0NMJnvIEKrtDyQoxPDGvqQnsma0eDw/WWhEWZMAB2?=
 =?us-ascii?Q?LQ2umvbntjbzDAleNPvRbtGywZajXVHvWwYxiVxhuyPrNJnmB/m3hmvBp8gf?=
 =?us-ascii?Q?4ERUpOTDVMeirTzSS7wzwTZfQc95C54qPrtbILio0A/hKCi7Wr7uX6uQ9H1E?=
 =?us-ascii?Q?hW+hW6chE9O5POwiP8+qgzMKWaKRPDaq2Xtlj7L7s5yFTFtpHnIqUotY0Ier?=
 =?us-ascii?Q?La5+y2jZo5A+nEU7FeUZTO7iYxtDKIYOpcbe7v5FdxVmZ4upLsurqoo57tBl?=
 =?us-ascii?Q?8kug0iDSqBUSXIQ9Wl7jBzoIYHwQgUY4VrMdSclB+wozgWoL5Dk/QHulcQF2?=
 =?us-ascii?Q?j3X7ANhLbpe066pH6XtZxAHcPZn8Qy43ApTseH6wSlsd82L6dJ2kqOT0iG6K?=
 =?us-ascii?Q?7rqb6TKy0wKqpCfLRglOIT8RXssvT0wPHdag3Ml6xljn2kiviRvIxqedtOxm?=
 =?us-ascii?Q?y1qL6GByDuUaXVcbsL+bjbdqKndVfw1sveag5LNKmlvWmtsgE4qDkGim+AUY?=
 =?us-ascii?Q?G5FnBxfvYWbK9oCj26NF9rql8D8aWL4HnY9vRwjfPPE1xl0eJfiBOFMNlMQz?=
 =?us-ascii?Q?4va1N5CfjGkUbutLISr9Qw1y14IBrgr0dgYPyNUhLNY/PNRh0n0CsCdPjf1S?=
 =?us-ascii?Q?cuN6bxpsO6XjzVQFBpPi3OEwqDOIpAfjc9Nvl9kXty2XUwuisuvJkezyzTFi?=
 =?us-ascii?Q?7VRFWMss8X9tqzkxtmK+oQvw7ZvWl1hlInmvKD6LwoHCbROZVFopq6royTrZ?=
 =?us-ascii?Q?OXAmpcR+7cC4FVgrDK/A93BI25CDNnIg28F6X0Z1MgjfltjOhZkMb3BMzpjR?=
 =?us-ascii?Q?bb0Vr1v4F7CI3Bm3SVT0ho97jkzbFE+xAHSPzIeAz88vpuSrjwZcu6pAEBgJ?=
 =?us-ascii?Q?0NmPJiec5Ze5EPl38FrO7BSKYOrGzOw8hNufh4Jas6MSvryt6oZtYWwCUeNR?=
 =?us-ascii?Q?cULvtig5HszOr1n83ZwjxVOeViF4jx3UcfqNskEO8xJ4uDUVkgPt93PvZEnu?=
 =?us-ascii?Q?o7MU4y5ZwT7UALCQ+2ejFZxH/rs3/aulxRGyNpyHAZHWh1Ukci/p1ficK2tR?=
 =?us-ascii?Q?rwQz3vkEBbx2nZHDE3QH0qNuBJV+LA+lFaHxK1H6iXKzDpk8r04fsQi9yPPc?=
 =?us-ascii?Q?g7QDGs9uWtz5Ilfb1Lk9L//CBk2voxYN6dSSAapok4iow35+OHdft+V5sXAr?=
 =?us-ascii?Q?5+cSBwa7zVJl8TreLHqFu+Wc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e5fcf9-77d1-4395-ecc4-08d9840d8112
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 12:26:18.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdN5mLv6s1nswXvRef4Nzc4YILayMQOlZ5gjJn7WxEwzbsMu3O1dltOwb7O62qza6HJfH5NyC1CMDMXdf0yfW0bVT2TrFPfN9JtOKtHIfrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1824
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300078
X-Proofpoint-GUID: 2jSXo8MVpG0AiGYFpfREj3wTj7hdvHlx
X-Proofpoint-ORIG-GUID: 2jSXo8MVpG0AiGYFpfREj3wTj7hdvHlx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that "mac_id" is a u32 so this check for underflow does
not work when "mac_id" is zero.  In that situation, "mac_id - 1" is
UINT_MAX instead of -1 so the condition is true.  It leads to an
array underflow on the next line.

Fixes: 8cd574e6af54 ("staging: r8188eu: introduce new hal dir for RTL8188eu driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 410cc4197548..ce0ebdecbd66 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -116,7 +116,7 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &adapt->stapriv;
-		if ((mac_id - 1) > 0)
+		if (mac_id >= 2)
 			psta = pstapriv->sta_aid[(mac_id - 1) - 1];
 		if (psta)
 			add_RATid(adapt, psta, 0);/* todo: based on rssi_level*/
-- 
2.20.1

