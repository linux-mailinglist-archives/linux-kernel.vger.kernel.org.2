Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF1428CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhJKMMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:12:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63996 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234675AbhJKMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:12:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BAdxYJ004168;
        Mon, 11 Oct 2021 12:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=uOJLc/eWhTNiW7Hymf/I4QnxZ9uegEen/wTr7VCwI7c=;
 b=o0ugt2OXeD8660jEuIn/GFyTIhoM8hwhBH2yuj+0gQinmX8Y0Z7g2zBKS8EPHdYYQgts
 Fh7uKeRIVWxj9Bis0/yrAdtPKUp52olWUmeB01OV+zSLxeUF80VdP97y2GZYrWxMnD8m
 Ob22Lo9UGWV96inUDJqMFwhZn/lgR7+hjLSc4s6wp669Ofn0o93hEISgrtI7bOvm3HPg
 uOXuxDbzKoZhcYCmF+6MtbLVhS3rRA4l4Jpb3chig66YGf/vqOPj/JfDqq0xlQGzUO8V
 JU6JPpGTau5+vl/LZPVluVAJfolhqVYjm5ZybgcOtXAJEr/iL6zcGp2MXJPvOajattbe uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkxxabh42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:09:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BC504J045365;
        Mon, 11 Oct 2021 12:09:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3bkyv6wtj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn7pF0vMXpsQPTgX2WGIeDkkLzIGfjiKfUHFbOMhJwj3bmL2+WHTU8pX+Hp2eZslUYtdY3QzqKKeoJVAwsQjrxIQpeZYYyiPAuJDa3QMGyS7x573XSaZUA8pGhhnbDqEOw0YDH/sZujzBVdixoPTAk5S9YH2zZFoXJYBGnimuoFm+oYwasWv2dhOdV8gAvxFmc0K//GNDHDDz0kwpxZONBIGQTSRGn6W20v//Dwo2uTEd0Yc6OsYfwKb24e8Gsqqep5zhAa2VET+TiEdV+sm3Zo2pJDVfrb8queTSwa1IWHELDXzbDVKzYn0wcC1SUgDP5IFpqsfGXsBZkesN27/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOJLc/eWhTNiW7Hymf/I4QnxZ9uegEen/wTr7VCwI7c=;
 b=UJb5lCTphNDGhl37ksGpKwDNTpwNbQLbl+4iZ9XBRcjnA2+CIW6BvUSEnn3gS3xXZHvsEU0xAUYua5G6bdD+0MKYT7xE3De6fP5w2KK6tiILPCnZ8JENUKmM8ch54Arg97pW0F1A4yGzZghTp5Hqae6+52wa8CbSo2c5qYbF/WAra5G3MWjxTu+vrSmBPR7C4NUKtc6Pzz0sqATTgKfQE8DP4fPtJzaNR2GLqQ+rWIFsTRX5ldoKrY4paIahx7IpDytycpNgRh9D/M4xQyGRMGAJfy7yrA7KNNKSZolvf0uKWtYENOyOjgKoD7dsaZBOQ7skdHPIpdFwKjQuRTKb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOJLc/eWhTNiW7Hymf/I4QnxZ9uegEen/wTr7VCwI7c=;
 b=NKm9luKM0tybrnfdk0fTkJh/0IS3le5m7XpRfkgYMUS62dUY+rkUoMGuRrU1cXeWuldV5qcqGFVDaHU6VDvAjMoxj31QhE/FrdKFAfIr0ocedJqYCDI8RP4ARwLIxfWHcKF1UkAFoxX2AhFSqI9Fi6jSGOr37TrsWI2cU+eWqgU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2157.namprd10.prod.outlook.com
 (2603:10b6:301:32::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 12:09:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:09:49 +0000
Date:   Mon, 11 Oct 2021 15:09:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, deborahbrouwer3563@gmail.com,
        hdegoede@redhat.com, marcocesati@gmail.com, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: core: simplify the if condition
Message-ID: <20211011120930.GI2048@kadam>
References: <YWEwFf0YMi4W1xKN@user>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWEwFf0YMi4W1xKN@user>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend Transport; Mon, 11 Oct 2021 12:09:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5437c761-da94-4aca-165f-08d98cb005f4
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21576B6FAEC8D5BB529736B48EB59@MWHPR1001MB2157.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOlXs6RnR2EtQrfbFUe8PFqhM1iNNN9FqULJXIZ1dD4X+UcviN8xf0PGaPSwkJeQ9clwdct8+vHCXu8zbhhYtPIgFMkpO9x9+7zcIFH9RI/YD4ZXGRB5f51X/egP2+8yLHcT0RkOumQdQGJB0T30CFtTdkB0kydQNgJRkkwkkd242kHnNTdeo/E75w+/XU3YnDGafh7jXh0dvUgimAxXeq1Z6db2sieQjcYCCFHr3SQXzdxjVacYQ9zrvASYriWwtZ4/wYsFp9wd3bMUx2Tcl+h98l2JiTi2NhrSvjqA3fHHdPjN4Xcgp6u6X4eDP2D/Avf27O7jEW5H6ftYiipJnnC/tTr3xfkdfW/Cy8RIxBW53jg/vOpgXTsSJcAuz+q6+fqNJEhsJ/LcaSqvRQtDvXCJiK1k/ti3j+VsRwWk08Vbx+HyTdzLEtg33epkYK5g85Sgp0mlsXewOlpMMMZxKHSdyvqfC25/Rydhhji6GaoU/PpNMJZ/dPGB+nXuBpUREBxruLWcyqtp2wIRbgEx7bx5KXlstUKvOIojVfMBocGcLqvsLBTpkJPBf0TbcANWD1DlYrZn6R4GaITjk5Oc1EBmVUZ9cigkJU+2iZioiSb1RgX0MrCuo7++djVDCnkl2WRsrff02/mu9arqxMTl/bDaYWoJWcdLRlzr0o/Xumo71Lk0clCT4HqNRCif4jK+3RuclWG1I/ztGV3Kx5CmJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(33716001)(1076003)(6916009)(8936002)(7416002)(2906002)(86362001)(52116002)(6496006)(66556008)(66476007)(66946007)(6666004)(55016002)(508600001)(9686003)(4326008)(5660300002)(956004)(8676002)(316002)(38100700002)(38350700002)(33656002)(9576002)(26005)(44832011)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kg4y2b+Lyaq3YDxlZln66o4UtEC+AHw/zTvTlhrZoqkdDqRRdy/cEDSUt9Dc?=
 =?us-ascii?Q?N5+pv72fKqwJ0znb5QS7EPWlghUk+sgBGK0ssQqhX24/GKFfH9rFXqsqGHSg?=
 =?us-ascii?Q?lJJEDzkJlxKIESWC/HC8gr8sYu0sIsLF/Jkh/NT/06ZkNrwBliU2kO87IoSL?=
 =?us-ascii?Q?k14LsnUI3RXdczQZOc6pRtC8kRk11RNJjiieD7z9H2Aty7p6AYQdJTp7Rwt0?=
 =?us-ascii?Q?42CNFqXYDNusPrFLKBjg+fD4rzzfPC8NJN1M63zl0qE5JuJX22ozzPrEr83q?=
 =?us-ascii?Q?cNUTfhPU4oebxdbHnlCgDYBjUH6vQzFzBrjd0g6+qKosnH6i4FtOc28tR3Et?=
 =?us-ascii?Q?+D5kGSbPgqaCYSLOMl+/iTeHFYCjfEVJjff+ZHHJbPpUCxGuaShex8fxCGm+?=
 =?us-ascii?Q?IclgX1vesYXAUADlykMxIKRQkUOGbXl+zIoJRFTvVs2LBd4AmAhWS2rPPdqQ?=
 =?us-ascii?Q?aMKwaYLEeEXWMvhuZ8mHQn83tCOEdLN5aLYWXgonNGIxNOlh1d177YBse/Cn?=
 =?us-ascii?Q?Z+Yo8k9mXFJtUe4XprRZ14X80FE55QDRXvA/XYuBoxdAJkXjUAYpm9EuQJqH?=
 =?us-ascii?Q?7P03sQ7o+ERdjgQd8trrqav8UdhaWLK/33IIYlMmoACcpwMGxtM7dNzEutrw?=
 =?us-ascii?Q?Osa6UwbdKG3u1YZpped2CMScPbhk3DRk6qDUljW3WNWlAMVYwUcCHho+9HJp?=
 =?us-ascii?Q?5qHVmo6FQjAzmDSCUjQd+fpk0PVAOW2y23rxRs2Ej6ZfLiOJ56V1CZna9fNy?=
 =?us-ascii?Q?DnPjvf5L0MqSEbwJoVjyXFJL13TDKILKruA+BeeAI2foCTNHebYeEteYE9vf?=
 =?us-ascii?Q?nyvZkLJnvWm8G6iC0mVliBmgi5I2rxsCNxltlJ5c1oZx8ZAjKDp9zjJQe/iX?=
 =?us-ascii?Q?iqzMQFbUgesM35/0BzkTMY3Ta9qcZ5jQ3C+EwWBtkFwFQD62EOrBXdPxVnF8?=
 =?us-ascii?Q?XLb34rUu/vh07kFFp1+I7SX2IOPtyQ6UbH/A2HHfEfjXGWq3pLYBx8SIZTft?=
 =?us-ascii?Q?jvg7eH307etwXKtzUL6osxniZ3ZJVGmeiIyD9Bu6u2GDPcIJ409w41k/k50k?=
 =?us-ascii?Q?8BF5+Twey5IVjthdmfUCe/BPMMLmQqEARGdQ7BNzwXadIxKRXiD7uq6KOAIR?=
 =?us-ascii?Q?kQ1N90QOJqhFSWzZ+3xD1CRFmrb11UQwc469dDasZGXvFdOI71tj3610muwe?=
 =?us-ascii?Q?B0MHeAWi7LU2V0Fch9B21o6ea6ik8hBkJozFBY7uuPERVv8x5BQ5RW0YtYef?=
 =?us-ascii?Q?FfNkRl6NOXCjXMHhfB0G2hPLwjokTz6aDb0kJWnt84+m0GF4vDsM06VmqmX6?=
 =?us-ascii?Q?SdH2GTlNFw1XgYaqjM3b5Gy7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5437c761-da94-4aca-165f-08d98cb005f4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:09:49.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAD+kx/sTr6Tvf0Y71O07M0u5HYZzIKm2AgCGX16xH2cqI8Fsefd+0pHUtXbkOJQdr86+o0JYePs5mo2ogjoK6hsqvF304ZDDO1zkFoTAFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2157
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=881
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110110070
X-Proofpoint-GUID: DabQV6NOArK-mZL4Y4r9TjIY9kan0rwO
X-Proofpoint-ORIG-GUID: DabQV6NOArK-mZL4Y4r9TjIY9kan0rwO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You didn't compile test the patch.

On Sat, Oct 09, 2021 at 11:30:53AM +0530, Saurav Girepunje wrote:
> if psta is NULL, function is returning with fail. On next if condition
> again checking if psta is not a NULL. Remove multiple if condition check.
> 

I don't think this is an accurate description of what the patch does.

> Function is already using goto exit statement to exit.Replace multiple
> return with goto exit statement.

No.  Do nothing labels only hurt readability and introduce "forgot to
set the error code bugs."

regards,
dan carpenter

