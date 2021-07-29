Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216863DA311
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhG2M1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 08:27:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52308 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231938AbhG2M1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:27:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TCPbRV002872;
        Thu, 29 Jul 2021 12:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r9UXmsiSRRHN9eO/ZdEHTccdZZZH0dyvtgpddGANWVE=;
 b=yIcgSK4Y5DzI6mOKAUKEauepbahERfanEDhPNJLqI8OgPPh5R4pNosfXxsKGrChEYETH
 gN4oj4QLS8AREJGondUdH+drtVavekXJ01FOwvn9JTnUtSOkEL2Wpb/fzJ2lx7oAlfyg
 K4vWFeEcMghYO8Cd8S/3K5WrEN/yYuooNJ0v+fAxlPrYSRsLt+j5Fi0CYOleldTDvS12
 jB2nF3LAC+T69DSAT5Dj3TkY5bdpFc8EKNQ8Bia1SbN2bGPNx0zpjzdXMKRwr13G8TNL
 eKTi2vA02AQMivc3v4XEIaGE69VaQG5m2SEtUGGIZUcwCCTrmePufhXoepc3CNzAf3NX Vg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=r9UXmsiSRRHN9eO/ZdEHTccdZZZH0dyvtgpddGANWVE=;
 b=R92SpPbmy0i+MpKSK8qHx5GiFVhMcGnHXMDiL6CXOwdtftQq+HptlzAyX6ghhDh/DZi9
 hT+oxwTa26h5qCYIm80dEf2nSRstXsxDmIakfhkYHl3A03Sv39gvnoA6smQIGUt9EUOY
 z+LMgKD4QxdQzhbM9d226Ta8ueE7l027iMvOF/pbHONFV8qWmyYugVjCdrdr/w14KQhe
 /EBl/s5PuOTB2sifTJbQf+qETO8ecLyYoKTI5IQ2llhJ8pSTAvNreN2obwg/REPgUAwz
 FXzRsUgepEjmz3dgvXLGChABil8ogKB0EwIXCe9c8K9ega0uSAVEZ4PfpMuVhOMmWYQw NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a3uuj827f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 12:27:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16TCPJ9r098226;
        Thu, 29 Jul 2021 12:27:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3a2350u0x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 12:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAh+Rgybm29GUz5zKumBBVROcgmkVubdZrY9Xbo2GwUgLPhSRDpz69nX2eD8nYhfGp+YRSxs3k/eF6f3NgSoqw81/ezhBjErChhTGN5PwAvYp7SR1CZvxtpygculBp4dQLtKw7LaE9w0l+RadHDMOZqh7RS60VY8baAjIBCt98oIsHVq9V2h4hLjWclpeC+dnhTW4cRPqdYMqY/Xk1QwXfz+emLhqqwsBxKnjbCe0W0WXiEKgfKhQwo1jjn+QxoQXehzfx3AH59bHLN2k/7mJtYOcLXTQIl5g9byTOQ/QJs10x+ox2yNOMiTFynd8eBhkvoR3Gn5y5hA46UkxRZehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9UXmsiSRRHN9eO/ZdEHTccdZZZH0dyvtgpddGANWVE=;
 b=iNuKVnWyQOsEpjmvEpKJ5e8TOylX/75EwhgL0aMcaQzdNk2fbW9RLjL6xiB6QCYZduIn1+63hNOsdiRgRuqX+LfeyZ/sEuiLrj+pRYHpYaK1znq/1+o4IvYkOGXQEIdPoa+k5JNcTC0MAJIki4RvvCXsRkMR6TzlRpeD8b29H5pFVFFBPqGNeNXl57SW3DkYQeWhsWkQHobZx0bWgX0T9BSCIjM4xqox1P6dBCpQOCBLcvNWdL5JhFMoFIbc4N4tbQ+Zltb/weHlWiQmndSYcih8mDw+dO0P/3wtWMgbExHvN/8VwMrjqbojtlbTw0igQVwPprRFov7mUE1lZYxFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9UXmsiSRRHN9eO/ZdEHTccdZZZH0dyvtgpddGANWVE=;
 b=YnCsLqoUbvrE5/WgaewVjjmuRYh3YhpZ/Wzz13Mr2VXJt3qiUVQ8GxV+nvGZ3cTC3GUQ6UyF6ng6u+kr7aEDGAjoed7ZaXGPd8VoSjXA9n39c/VE8gQJ7PUqFJrNtEMcT8DaHFaBzFE8QE9u68LfUotckdydDtK2tc1MfvyrFwU=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4689.namprd10.prod.outlook.com
 (2603:10b6:303:98::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Thu, 29 Jul
 2021 12:27:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.032; Thu, 29 Jul 2021
 12:27:17 +0000
Date:   Thu, 29 Jul 2021 15:27:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Defang Bo <bodefang@126.com>, Steven King <sfking@fdwdc.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] m68k: coldfire: return success for clk_enable(NULL)
Message-ID: <20210729122702.GA27150@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0052.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0052.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Thu, 29 Jul 2021 12:27:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 726a04f3-eefd-4b7a-bc3f-08d9528c343b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46899583A692B3A3B43AB0C88EEB9@CO1PR10MB4689.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eIHKDPV41ThebOF6/6vjlE17Ilsrl3HTQ6UvqUrEC88KtZCH1w0VKHQwZkTkWNi/V6FsfJZ2tdo3kvqN7Tyg8UqPBjq8Hv2ZsoilrDLPQbBM+7Ts/IYW6tLpluxNvJ/nQTSs0lF7F2Q4480yd14cjaVsZzJIyHPuFKQLmwHqhr4KiUMcBZc+dtzOfNbA4/1i36EELH8vdeNqmQed7EGtSwMmSbV5+dXJ9Eb1/BJMgRosjnDS3d1HRNRjN6JOrmBDTxyEngn/NWVwtO64UOUoCEdjbYT4w1dTXPIyQNz4X1foBCoBOTi3950/3ELkRwZPVQR7dwT+2e3v9koz6vURlgWLmdq45K9Min0d4DXIGucOSMDQb1Uiz5irLEmKhJg+8b/vSMAfQ3qSi8afO2OYx/pN2nodpwg4gj4/QOfDmm9vLShQKIGrhCqYGjbxf+BVAs41n5kzIsCiLqmI9aBFqviDh68JKfkagiKCLHaDfJMAcPgK9osxYUS5jnMdYcuNPCrMbfkPmX0cwufmCgnlHRte9gyvWQfHt0tQ1ojtEyD1GB5JWgK7UZKahbS/IlCpufxe6Wpbb6KmFgIMVURjoL1GDDs2aQBXBZ8wFNwcTtuei3+tqFqVaLSpEN5cf2y8E7NnJ9Ph3xRymbdTjWhsOvojoff1s7Kj2zma+EHR4lD+ivFOBzQ+kpbkjbAfkaSuPtJV/i3KR+tU5fbfTAHWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39860400002)(1076003)(33716001)(66556008)(6666004)(44832011)(33656002)(54906003)(26005)(86362001)(66946007)(316002)(6916009)(956004)(66476007)(186003)(4326008)(8676002)(4744005)(2906002)(55016002)(9686003)(6496006)(52116002)(83380400001)(5660300002)(8936002)(9576002)(478600001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9V/1g+7e1fLsoyWcCsdgPmhJtwrKwPJCry3OEmhQ7JGrv0eGVNyL8I2mHZUN?=
 =?us-ascii?Q?QsLWHToojOWA0HhnpJ9O7f3UxkSbdQ51fbRGXOQI8toy6aG+OX9kbZcNddGY?=
 =?us-ascii?Q?1WpWqPbsk/yIZMGF1h9EBlHqCZpj16zpBMZKFNqfWPfVWBy+elJa+jpcZtUg?=
 =?us-ascii?Q?yKVwj/d0bmHS1aViNJow0GJQ5I/+i8CQm0pSe3r6KTG06o8rFxYH8MYl3FZ3?=
 =?us-ascii?Q?mEQn7OXGHX1u2rAHaTXypNnKwaMeZ/nDNAo96FSGr/ObO3xn3eL5fQXqPBJg?=
 =?us-ascii?Q?5FxRkTI1EVvCHeXWZcIDzG8NCmlI8h3Pg+SUBcJams6LCHRrbapwrjAWRKiY?=
 =?us-ascii?Q?n+JQIpmJwtAgAH0MQkJQsxXwRVUjxaPcu/0TV76sVflsDtr+AiJUnTIY0xS4?=
 =?us-ascii?Q?cG0YBWE6jyUwQ0bgX3qnvHkVvvkss0GilRriYur6QCaZyiGhu8uraXU6kSBg?=
 =?us-ascii?Q?N6V/PlRkRogpg/ut2GCjiRhsDrLfVxEliY60RIr6OX4oFRvwhZ0xsVvwcD6o?=
 =?us-ascii?Q?z3oS2Nq+hK7itWQfo5eujxLkcCkOMFpOYBTkD0UAAT+EmJtKWKema5lXOVOP?=
 =?us-ascii?Q?6pSkYBKgZ4KsUZHABy22ss3lTZepni6OWF4YIiLpyT1XEVPVzHzedU2K2+Qf?=
 =?us-ascii?Q?as86kP8jn/uA1VDNJSwo8KbsJxuNKApjxfpCZ5zIzzNIgVLaYv+ACMYiPfp9?=
 =?us-ascii?Q?spXIwVnG2AOUMeWW5MYq9j7FDlkr6DxTjebO7ZWurS09bPkNkEgzv7Skv941?=
 =?us-ascii?Q?SpaCF1Or/WoZ73YX1Y+iuqv7if9ZdSdkSZkWXzY/B7QU0mxDxYHOjEEb2hDZ?=
 =?us-ascii?Q?e/XEoCh/b0H1/cQr0f6mwD0ZNEl1mOVrSjVY4eT0oRZrxPcJlrMb6On9NHYR?=
 =?us-ascii?Q?Fq3sRdl58r7Jw5YU3L6fzbCehZdCZQ40a0dJ2WODmL9R7dLKkbK2sjYK56yD?=
 =?us-ascii?Q?Pp7iO3E6V44lLsKUzmSkw/RAk2msCNIYeN5CHsVwpen9buwAnJpTPkZyULDZ?=
 =?us-ascii?Q?X6wSvPXIceMbm3SMl4BjKL8UmisyVIqx5LWfqOv29U6aG30AcxIwhiP0pK0u?=
 =?us-ascii?Q?mIv8SLVKkJOtozqGZtydc5AJsUgsoFsxyTzB7VTY2kMY82rxJLXAJ7LthK2l?=
 =?us-ascii?Q?5qrZ/x8JBrGIFFBL6pOlvMETsEOZKvmHe6mzUxDrJxImqYxbpQUJK25vj7q5?=
 =?us-ascii?Q?ETfGGgCbkVbBKGX6rO3b1IuMen68+zm9TLIKVxmfNNs66y89ncJUqZYj5Htx?=
 =?us-ascii?Q?kCB/DRhdskULIhfaSgLXQUTTUqjum/iYYkBuWB97AdiefPH73z+P9EWi4ysf?=
 =?us-ascii?Q?scICyANQMBLZKQpxKIOoN31H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726a04f3-eefd-4b7a-bc3f-08d9528c343b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 12:27:17.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPp68SGycytBn11cM3H+SLcsrtW+9TdT5S685UxzEdUhM2uqJuIuv7HDoE0f0iedcwAV9oXwuVoRy+h2PtAvXSvQNnzMGAnikPg2F/5t++U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10059 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290080
X-Proofpoint-ORIG-GUID: Hmytubk0iVzd82o99oALJWcX5op702jn
X-Proofpoint-GUID: Hmytubk0iVzd82o99oALJWcX5op702jn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_enable is supposed work when CONFIG_HAVE_CLK is false, but it
returns -EINVAL.  That means some drivers fail during probe.

[    1.680000] flexcan: probe of flexcan.0 failed with error -22

Fixes: c1fb1bf64bb6 ("m68k: let clk_enable() return immediately if clk is NULL")
Fixes: bea8bcb12da0 ("m68knommu: Add support for the Coldfire m5441x.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I can't actually compile test this, but it's correct.

 arch/m68k/coldfire/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index 2ed841e94111..d03b6c4aa86b 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -78,7 +78,7 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 
 	if (!clk)
-		return -EINVAL;
+		return 0;
 
 	spin_lock_irqsave(&clk_lock, flags);
 	if ((clk->enabled++ == 0) && clk->clk_ops)
-- 
2.20.1

