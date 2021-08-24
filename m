Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9009B3F595E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhHXHum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:50:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26102 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234616AbhHXHuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:50:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O7MeMA031023;
        Tue, 24 Aug 2021 07:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=rI9i7tW4LjHetGdf9zd0iiveOcUE/oCwTm1bcaDMOLI=;
 b=giwgiAzdu1LFuyXPebSd4lPwtXfrqbJ0QYoFqo/BcMzY0M1BuwZyUGptUjxvv8uO9Vo6
 +9WMnX4NzVoARGj1R9X8zyBnNH1zMPiaLFQnV4H3JsI5t+eB19aMPt/squ/kPw/3ujCA
 58aPT+u6XWbn99EAG/SmMMfzimGQn8jEoW+oxbM6oSCcok+WYPgSqk3HWDeEyye1ZL+z
 l7P4Cdy1qA8DgkByUCfGUAhMoCxWu0ckXLClWAJe83LrPl6mNJTS8h3o9HurQMKrTxYs
 08bzDIN+fpnCiQzmaj/gGK0SYpkmmOvP7Ig1mgOTXc/rD/tZgbGRBpx2vbaClbB+YNhT gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=rI9i7tW4LjHetGdf9zd0iiveOcUE/oCwTm1bcaDMOLI=;
 b=Fz5BfZyst81WkQqgIC4eM5VZZw3zIvVdAgfROZy8+QEOWPThGyXPrL3hpEzDsU8Ru4ak
 UlabxbMHJ3IDi8vhrVnrSyEkIlzYTdBSJFdgdv5MNqMU9CjPNgJzQyMc8fPs0pwkVtLm
 c4V+SZPfOCsn5g6q02ZjzQrowMpcDzeQUVJi38ihVMm9NFGZ0k1br+mAsxXpcltLOxlS
 gwwvZUwx7ukZlw/ujnjQ3V4oDAUnCo10tF+k0QYHiwrRjYyoXRg419sH7CPBOKqBZYni
 iNfbw5vvcY87RecOBDCZ+8HnPN9NAnSW7+YQKJdMJa+KAb7lZEI0YnrpmJkMnhBdMo7j ZQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akw7nbm9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 07:49:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O7jEei135236;
        Tue, 24 Aug 2021 07:49:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3020.oracle.com with ESMTP id 3ajsa4tmq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 07:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPMM9yE/GR8wPWKKfvE1pZbycWMPUQYA9ydTVpS9DDvXHWdxgTG9gaV5L/z2/mmGh/Z72Qel21T+Ne+ZKjnRP7Hvygx0RPOx/j0eUe/0OP69ppw+o9B+wcRXuK5FqQv96gggS95gZfASyrwYlaWo2mlanj5zrboCXICrmZxlUSnOXVkBXoIzrqT7DnKRtnPteGYNEmk+6tSThlCmoGSKfZA1bOmSB9/F/vkRXKQpfO0XgryC/M6fg5sPCkG4rX0rcnNkAU4PvjEMa46hWQ5E0TKelAAOWkxtyAmMrWtIWXJjlyGnt5iDCWw256sVoL3KCLB6ivImJNUhRv4JVxOI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI9i7tW4LjHetGdf9zd0iiveOcUE/oCwTm1bcaDMOLI=;
 b=VwS5Aas3bJ5fhYQAwUS9VfCtgfTlpaTVvMyM2LphCxASWO/RHO3s1MMI9XYp7ALhU6BFcUEnggZn1HIYgLz2XM934paa9lPrajLGfY0375cKHaL8TfMhWFy45q91JHWjbakR8XCKCTeptaOMGTsDSPKUt6ApHfThjIVE6UmVt5DLUZ92QPMITZWdikAalorNOupAA8Gx1NfXxOmHyNUk5bvTRNjIgNmzRPTLEq/O64BNj9B5D3UOkLdR594mpzyeRWDvHJgbwHzVLeP9gzdNfqYMvFuW1/uQQfIITahzNO4d8CCc48kGbsHDp3a2aQ0q0kviu4V0j6o/MqWYMH2dow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI9i7tW4LjHetGdf9zd0iiveOcUE/oCwTm1bcaDMOLI=;
 b=MZ/UJp28PnrCxXu1+POWJoCL6/nb/fQh5V3VyrOhN8oIkLalZqpHiqVL3MHCvPQ7Nd7tK6jKv+dsDi5TrbNozeRzN+JL0Y8iw48bvaV57waCv9aSD+7Y+Y7pozNnTWbrIbrYffKN0ilERLiT6FeRH8WAqGdwG+VABbhm5Yk367c=
Authentication-Results: paragon-software.com; dkim=none (message not signed)
 header.d=none;paragon-software.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1821.namprd10.prod.outlook.com
 (2603:10b6:300:107::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 07:49:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 07:49:43 +0000
Date:   Tue, 24 Aug 2021 10:49:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3] fs/ntfs3: Fix error code in indx_add_allocate()
Message-ID: <20210824074932.GA13096@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 07:49:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eef4a2d2-0f6a-4848-3dfe-08d966d3bc70
X-MS-TrafficTypeDiagnostic: MWHPR10MB1821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18214A92210163EA028F06F68EC59@MWHPR10MB1821.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgjpCrNBaPw0qZavJrKveJGL1+RYTnNaRap6AgkFVHWn59Defmp2Up9OI6pZFgUgmTzXu9+xHKDoODhr1k/C18Anz0fEzmAYEg9Yi5Fxlom9XzVG7bhEeQHqv66bweX8j1qOA1NtfjI7hOtXXXuJfVVUfeFgnbEVgAxozYIZJL+qMCq8HQLMuMmXi6U+uE1Fx/UY+Wo/WRAvFtkglRkeQUTtT2xD+RG+WwfJdlPGOsPGstxraC+RBufK/HWih8WFtavLHUxCWCKq75nFG0hptcYEgQgcr1LFFMILwwLO6a9VHQahkLfStE35SRV5eM4mu1H3XQ166j36aaa3yeG7Wn8/rWTibK7Yyy8XGQev5YkN6vrfUDSUSTGxgc2eYMeJI04sOE66apPgtaE/KN4fVKdMnBGl+Odj2X7mmybaD7ZixO0VGwGzWuqe4METoSmhk1y3E5wY69CLzN15Y4TQDKlzu80a1aZvDIWRImYxMggEo6uwbWrRwbzHQrUH6oW+TIYRpqaKnsOjQdziyRRrmtjiknIqTYNeEGSFGyD1qLbV4G0mCFvjTpi3j9skGuVfQ49zg8KsoAtkItBZvMv80asNpvLjB+UKha/DaWg0rCXYrmMTinIFFAJFdlEohUZc/xSu2WesAJHd1xQP/PCzk+GZO0vliwKb4q4T4vQN7v6VOTDqOztN8TOlKIYGaZhax1NXfR85usQHkrE/UZ7yqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(376002)(346002)(1076003)(9686003)(956004)(86362001)(6916009)(55016002)(5660300002)(4744005)(44832011)(9576002)(6666004)(83380400001)(478600001)(33656002)(186003)(26005)(8676002)(8936002)(6496006)(66476007)(66946007)(38100700002)(66556008)(4326008)(38350700002)(316002)(2906002)(33716001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bW7SMl8l2HvtgCSGcNNVuJdCbNxCFOp5Jwk7d/+lMqALfMW01gsFJIFP2i3t?=
 =?us-ascii?Q?IiXdFuR7jOE1iKwnIQxfaMmJ3inAHgulBim8P3QJHz58tQhQcwOasgoaWxaW?=
 =?us-ascii?Q?nBj6ZtIQVGzQ2MZPJOyPmVXEd0zXH7g4HcsX5LYqNYF6BFk3taeFHG6nAdi4?=
 =?us-ascii?Q?jxCrSY9FOLS9WQ6hHyPKZ9/QE2OHMofvb1CuBCxeFCrLyEGuN/vYHlaXeYmG?=
 =?us-ascii?Q?3w/TBtOwga0a4C+BRk6C1rCRbV6dFB6qSFaSCeUxNRLCrrQAa88pqAJeAyTj?=
 =?us-ascii?Q?GlbbeaX7mQtmh/E51geBZDEpd8oLLU04P4m4kcUhmDZaOUgMQR6dRUZOiRbT?=
 =?us-ascii?Q?7g3UxNmqWbLXD6tUkZCE5N0QThIgHkX1BjM3F74IUf+Wq/mOrvVnfTFuW24m?=
 =?us-ascii?Q?h8tY/9RdQTgqf0gCTNxeazQCpo6e5v3FfOuRcZu+wNrvRDxfejYLAEpkxEry?=
 =?us-ascii?Q?HruqOnwAUZ4ypd1HFqInOa3xc6rUGtoRfHwwqJL00G6c3+SqBktLCZmgH6lI?=
 =?us-ascii?Q?Lkfyrc6AcjHCPyGwQjlI0G4fSsL31hoEe28Yytxzuu/Pe/KpPgvziXVHmVqE?=
 =?us-ascii?Q?ZHanaMe/OO1I8WPWqnUKUDh4N0QgpQ0P5Fc6dJ7bvfUMSbn7Ou2Ez1Y3ZQr+?=
 =?us-ascii?Q?HPUgdGnc8IEvzr/nO4RL3YwTJcBmxHPfazpMxgg+dr+GzjJogDLiKsTEtlg4?=
 =?us-ascii?Q?+1h/0OFkUukRSHHcScc87OJJyXNiT68sw8ESvOGnW0DEHa1FIt/Jmi3a9j3I?=
 =?us-ascii?Q?kXaA8mSoQiukJCjDgh6schXMSo2XjPNBu6FXhNKAB/N5tmWQn//CmbONOQE3?=
 =?us-ascii?Q?C/tCjmdZNTw+MIshWkgvdd1fGubia5hKOSkNerTePw27xE+48aNN42DeZWDc?=
 =?us-ascii?Q?ey4YQIVz4PAdxHpvcIOlONcCYUG+4Z2FqMPvQWLRPKSzGJufBCzkSczlGKt8?=
 =?us-ascii?Q?k/s4x5bsBJmPqqersEV8puZF8lKqco21YvZl2umZP4Bgxkewg//88QQyffMx?=
 =?us-ascii?Q?ELe9pGwShRzSl1iduIBAkx/Jw72ARAmCPxseMMuDyaskB1v8GAFC+5c3q8Xz?=
 =?us-ascii?Q?zn0OuY6YNzVBpLdv0jkjkjZhw240dPA2bo9RivNTGJA81g/hGF7+gcJltHdi?=
 =?us-ascii?Q?4D+h4EGjoTEccblJbYLD1r9ttcZt4sBpbfoYf6aZwC4hzf+9YeQanWeCFZoo?=
 =?us-ascii?Q?D5Kk4+SvdCjCq6Z6CcJGkyZfZGd6pwv/34f5IbmdgWiPXeN54CU1C0LU+QLV?=
 =?us-ascii?Q?BSRrL8GTNJAmZ7T+PaCWkAFB7vTPAyhV8a823uvG4i8dZlfJCOxCIYANUYqn?=
 =?us-ascii?Q?pWDSWygA2vlbwdE7Nptul9wE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef4a2d2-0f6a-4848-3dfe-08d966d3bc70
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 07:49:43.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIOqatgjavv7uEGTACcsjU13kGEtNaXL0LSZYn3XdmXPqmuCOt0Ed6Ft6eabJfFaJcbGQ1ofJWodISDvn6QWvnOjZ/bOCPVuyfPZleuUkvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1821
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240052
X-Proofpoint-GUID: mLfYoBjpo4ehHO_t2_EYL5YFS65RdaIu
X-Proofpoint-ORIG-GUID: mLfYoBjpo4ehHO_t2_EYL5YFS65RdaIu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -EINVAL if ni_find_attr() fails.  Don't return success.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ntfs3/index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6aa9540ece47..07d6dee0a4ba 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1499,6 +1499,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	alloc = ni_find_attr(ni, NULL, NULL, ATTR_ALLOC, in->name, in->name_len,
 			     NULL, &mi);
 	if (!alloc) {
+		err = -EINVAL;
 		if (bmp)
 			goto out2;
 		goto out1;
-- 
2.20.1

