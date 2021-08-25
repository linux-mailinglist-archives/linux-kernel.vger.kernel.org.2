Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7113F7051
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbhHYHZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:25:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24898 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236402AbhHYHZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:25:10 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P4SW5d015031;
        Wed, 25 Aug 2021 07:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ulbYM0dIKMXvV+EaW5R/m3bOTTc2wfKNxVifTk2RKu4=;
 b=jk0ykf1A9Wt9aZHNxS9Q1QcTfHKDFGmDM6MN9FVwC1vxv61rsW3xR9OgEpbWxtDOSiNM
 E5MTFnfUUf5NXy1gIfHEIHiD4EfSYGbVD2ePALwfwvdiPDEotKN4VE9Pz2M2Tc84bj9S
 cB+dX2BZJJ9eLyGb7nHqfK7NY0BwgKYQWY8gRWOfb/EKYHFh9havYvI2U/TVh16kpf7K
 t8KSIEs+moYDmRrsJG0IETQM7zg+hqfd3h8x2RCoRfBtLlGnjz0DXqYBfKhxedzrQjT/
 ADpmbEmlcyWv+MBJ6JY7cTMokM3X/F/dSA7VZkBn/ZXDEPww9nUdokC7NItc6wy9v3ZH 5A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ulbYM0dIKMXvV+EaW5R/m3bOTTc2wfKNxVifTk2RKu4=;
 b=ynDYe/ZWTSDLwyV1itvB/thS5Y/0go0ol1QJ/v1s5t/SPTBnbwLTRfCwxI661zsn49Nh
 svDpJG6284IDqkzKXQMKRH5PexLyPQhVjAeq4FlXrZQMuEU29qAKvhl0M8wyYHyeyRjs
 8GDtPhxkpmoyqkk646Ao4mf5yewkJMbj+fk9FmMPNrebn2oSKKc0Y5BhY/vjG/yBBlYa
 zsKw5Xhb69umjVBaPVN+NnlM1Y6DapzrkUHwQNNKS2PwzrSZlM9yPL4VOu/eDZmrW4tN
 bQPuKrYYzjQVF0eNjS2PBi6q5rKs+54ZgRTgscaaY+N0r8NOopRtqPRlHAzYd01BMiUs Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6jms8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 07:24:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P7FbjP187881;
        Wed, 25 Aug 2021 07:24:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 3ajpkyuf2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 07:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuCCuRqUQzIS6tgmmLvw+2Fs+KuWyfh37VHgrtSuQC/4/Xlb8Vwtv8eLK23I/WjK+TqnxjF2cHcKbdvDDCnYBURJ45Zj86Ocf8HXUmM4LeMSakkx+u2qpGHvbY/7AVDpXL7V0QP9thSYXy1xK+q/uKQQwUKhlLroShEteQRYYfdOI+/iR4CCK9D7y8kGKHhvbRXtM+4O5FqM/93fIKwkf8DBtSFRcVEPMizdU4G5OVu0VQnMXs7QjxscYPNZpitn0Jo56q+m1wljtHP7FfcbkD6ncPHpgtrVrIXAoL4pxchoAmCr7TD1eTJwlayptTjbOchO5E7oyrHJb8KWb3gYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulbYM0dIKMXvV+EaW5R/m3bOTTc2wfKNxVifTk2RKu4=;
 b=lEdEZ2cRXlcNKjSfnlJBPz9m5pxl/0j+9juZeUEE6ThdsK7vKFtzzqk3mYSilnJPgyBXO4+Cujm/O2LW4xQwfABU3lW41B4UkBpRAb+O+wpDW2Z1Oz6AHsYMZQKaMjf2Q2YAQp/7GKAJlymphJKdHEVANmSWFPpXW4UElJ7JtzS/4zvUuZesRIETbZ0KfFT3afrOfoG6CO9FZvryQNgYTjD11ic8+DDBIHO+9di0+dQFhN1VR8G8bQy5R0CS+XYSL06pnAhfzddu540WPTuCYYpfC0G/+IdVYKnDF4HB0mD8Hj36fZNpqp1ClomNzzBU50VunBncLGV0kRNP7TQlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulbYM0dIKMXvV+EaW5R/m3bOTTc2wfKNxVifTk2RKu4=;
 b=UMzufYtEaqyfhROgNJoKPaNfx4DbB1stpFZuTiH03PaFe/8P3OPie8sEzYXpcxFaVDpr9H1ROWqtMAtTozQRXcwe/wfZ2zkSPhSePRRbF8mjEjT5C4B7nRAFgB0zvjoEW/+kDWxeKqGEziWtmnYnEdqjWmgCJlR0E9PYC4vPMzk=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2096.namprd10.prod.outlook.com
 (2603:10b6:301:2c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 07:24:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 07:24:19 +0000
Date:   Wed, 25 Aug 2021 10:24:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] tty: moxa: use semi-colons instead of commas
Message-ID: <20210825072405.GA13013@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0406.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P123CA0406.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:189::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 07:24:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e71936-49a0-4110-8077-08d967995a38
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20965C3204C2C9E1377347DF8EC69@MWHPR1001MB2096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFYCxioIflHttz+jVx1Ma3vnrx0V89wvhhQf5ksgnmda14/FC7NYoMVQ7VORVcQls1/Y/TTTLEUWTnmD89qEDmaDBckezrxWXNorfh69mFpe/8I20zdkHz+4Qh3ZY3+IuuoKVBQZI4JUWKeBZ0XTYAGqHHwHtFasyxkOSXEOOkE+HdsyQAiFh+QoxxvBOa0J3SA1pv4dY96zk/+tLvSSFRVLSadH3apZGm+Cvd6O4SlxfRviHV2qqR8XaMQS2jjMmNzeR19kJAXKicBCUVY+/sypqhCVLubXGgeguN3sDkg4fq/Nq8RSCAUCdIluAGyeqlFnj3i6EYaQLzREo5Hq4brVM2WtGJt1RlVND4Rn4vRN8emROwBEiYFJa5C8bfmEyfpI79kJH0RS3ryvE/Ggqtw7IhX0loqs97qxhRlUCzO6cC6gN0wVnn9sveyZDglDJENdJPyg0RXH8hi6Jn1KETDE1L97RF7toUyl0B2uARjgNhCUWZ4kK4/buAu3h3aBDsIMdGzBYAfqNmgFUQwzArdTAyx2JjIPbY30gUECiM6g0yR35R/46iAIlcj5W8mHsAAcY0JaUuddM/3RC7b5/eaaqXFo3kR+pVEsOnrKxqE2kCr9Ho6zkad1KysCVixCPMJ7AEqGZZsEfDfD5SDeqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39860400002)(478600001)(66476007)(66556008)(6666004)(186003)(33656002)(86362001)(8676002)(38100700002)(9686003)(83380400001)(5660300002)(8936002)(33716001)(66946007)(9576002)(6916009)(55016002)(1076003)(4326008)(6496006)(44832011)(316002)(2906002)(52116002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pnT1BaOjfpl7vuXgXzPVGMxXIos2/gOQKojGJL5v5ADC1P8Uldx6PGIGkvqa?=
 =?us-ascii?Q?ilbj+nAQeUEkRDi6AYYLrvNJwVsSIEciyR/FTjA+PB7reQ8fTGRdecsMYuM3?=
 =?us-ascii?Q?/mlcpcLjrHqjgRU5oSVf7Rroo3du/KzxgxCnHBT0EF3ocJcnJI7wHB7kL4mj?=
 =?us-ascii?Q?iHmw3MGVvWeL8fOEBO8rL9SD6X5gQv+Ylzirj14zqiqa3sAcQ625I76tVxtJ?=
 =?us-ascii?Q?cOtDQp0W+1V2f6InzUezt7oxSCsWy6VxdYS+LuFeOLXefdU6id7++VEcxdWp?=
 =?us-ascii?Q?SKRPcWCUr4qdqT7eIbLggamfNzn6TacIeM6EhcCyGbsWgdb+JVeIwkEBRmff?=
 =?us-ascii?Q?INnUxh1mm27LRe3sUBR1FLMezsLjuHkZCVIsTw754VXcg0VMpVX95RQLu7Tr?=
 =?us-ascii?Q?ZB55NjpOfXEwO6HNjmH9KI96w7561ykCDOLh22ZzrQBvO+oR+JuuZFM7csss?=
 =?us-ascii?Q?0iMkWpASrsI+CbuOFadtEmONAZtlG/F2ZuseeyA6gK5xWlA9wFIs+wJWLsR4?=
 =?us-ascii?Q?4BlO3vETdmkkeRfgxUHdF+H5MZyqfYCXypP48C0vmDn21wV6mV6Wxf/5H5Tu?=
 =?us-ascii?Q?JoxhYYslPZomFZoCDLtElRDwSbtwWGSOg6UORYFmjxEL6oRiKQzSuLD6yjk0?=
 =?us-ascii?Q?fPq1Vd83eO5erBBFCeyg+esVKYPxIgMvQYmuR4tvAKKM/7yUFE3SVOe63sOJ?=
 =?us-ascii?Q?DSbgMZ2wuTIsccNHy5ZdDQ6U+HNzmIKcI7QglFzy7UNx9LAR22ecft2oZIM+?=
 =?us-ascii?Q?tjxmfGqTxR4pihv4f22VzPR+3YnbW/K0P3xkkrPUrtCBOWSJT8inuz+GoE4Z?=
 =?us-ascii?Q?eb+6ECIyQJPKIX9IfiAm72BWM5vKL0c8Ck/RqrSzjE6lbOvy9qve0bv4dYok?=
 =?us-ascii?Q?ro5anECn4+v0/h3PfdF3pwCNrVK4G3Khw1gkQy35Js50x7EgErJfGIEe32ox?=
 =?us-ascii?Q?ivFTV2KUi/LR64wqVCgscTjX/cZp7BZcq3J7FZP5EACZH9hVWhHrcchcH6kG?=
 =?us-ascii?Q?/G2cAFE7uafF2YYAb86M2daOfPcSnwV8m+mL2rSwSaJDTzAB9e5RHbDElvRW?=
 =?us-ascii?Q?lpPdqfKTRovl0gdBnU4R3G3bc6DbVQD1RjPkGj07e2m5n4Y8w7ePNpnGIFvz?=
 =?us-ascii?Q?DIFG6PNMCL6WOJaV89+ZeDVSZE+0sZoAkT/W3CXCAoqCOI07N3QYh6254stM?=
 =?us-ascii?Q?dW6a9N6VSZX9abez8Cm4qk5P2yv/TJWXuSD+LBblW/oKwsj9QG6T8qzI2Fw2?=
 =?us-ascii?Q?Og4yYQQzYY/XbeH/PwBHECDBv8hHUSGR2CYJ9IMLhJrkeLdoPprJiQZYMWjK?=
 =?us-ascii?Q?nlzEqzM0SDX6T9KZA9QVEXW25xhhH4Oai4KLbigps3+z1iBSEOi9xpcPiuGU?=
 =?us-ascii?Q?g3+TXvw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e71936-49a0-4110-8077-08d967995a38
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 07:24:19.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCoIcR+jusjtFnxmW7JcGaPtlz9N7mSEF21WC5Sk7epKBbxCvOoiK9NWDTYZIDUK9q4avIDe7PS08QJB/VFZjZTz1vdikGQKGiBd5CZmBWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2096
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250043
X-Proofpoint-ORIG-GUID: wWSv3OAwMA6ZRYVgCecAMXEJsl3ORDZ6
X-Proofpoint-GUID: wWSv3OAwMA6ZRYVgCecAMXEJsl3ORDZ6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code works but it's cleaner to use a semi-colon to end a statement
instead of a comma.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tty/moxa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 776f78de0f82..bf17e90858b8 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -2034,10 +2034,10 @@ static int moxa_get_serial_info(struct tty_struct *tty,
 	if (!info)
 		return -ENODEV;
 	mutex_lock(&info->port.mutex);
-	ss->type = info->type,
-	ss->line = info->port.tty->index,
-	ss->flags = info->port.flags,
-	ss->baud_base = 921600,
+	ss->type = info->type;
+	ss->line = info->port.tty->index;
+	ss->flags = info->port.flags;
+	ss->baud_base = 921600;
 	ss->close_delay = jiffies_to_msecs(info->port.close_delay) / 10;
 	mutex_unlock(&info->port.mutex);
 	return 0;
-- 
2.20.1

