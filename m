Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF839419433
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhI0M3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:29:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38672 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234221AbhI0M32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:29:28 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RC3N1w004548;
        Mon, 27 Sep 2021 12:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=FJ8yCBvcbzw5w8I0CYQ3p/wZAPDYsP6fldyXgTv4aOI=;
 b=iycJBXfZAnf0bYFuzkX9Ri66VhqLXo1Xuh2vwJHGdCJyAAAeN/IuLmRjuZlOCbdkEwNo
 mgrIITlJnKcVrQ4kiVrW/ec3Ljk14YpxGg6nNaoHicRCtjjBwfDnpLY0Nk70yZ+sLAfK
 jukgwdXiLMlQ92Cm6KJwFG4hJL4quXNoWKTZH3vL8faCoToR6y4tzjaZOjSjGXzUSknU
 NA/l3X0qKdwnrV1s6h2Jawjh6X7cN6tzQ8vQt1ar8DlrAMsZ3WmfIspb+fkCbd9tpOC8
 d17rQ5uahKCJgcVP5UelrziIQHSXOnCibNaIHZZhJuf51qCTLQS9jK5JRWXHUvuzCzIs 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bam4cmgrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 12:27:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18RCF9PB058775;
        Mon, 27 Sep 2021 12:27:28 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by aserp3020.oracle.com with ESMTP id 3b9x50a9th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 12:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzliowU4GpkR/Aj7c832KzatnBCrE8TgACEVPnWJBybtZqItjxsFaquS+upEgZh/7qupMbfDAUWRZXs2STX/osujUmyeMnSWDCCm1cbi6OhHp1lxWSa7k87b5hrnVEY6FaDeDoWOpFkMvhzssJTGv/kwh/4J5Gx/UX074vYgwFu3GiMSuHokbf0A6FCRNWAm0yLO45GH38M1AXzJmxiLHd5dZd2ErLk90qTSgLNXzYElS5e6wMPaxKV6vea/LErDddOr9Gwt9F5mNud6wS0rjmgrX3ZkOLbw0lKUCW4Yv1jGI6hDew+mJEtU7Y3Z7SLPXH4glHus+QsLHknqTr69mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FJ8yCBvcbzw5w8I0CYQ3p/wZAPDYsP6fldyXgTv4aOI=;
 b=VOhgWLXBsW2krgJuwD9BrlTGsIJCEBi8v0RThJgViFBLQBjaidnVC4dDTWS3n9tBsR+CzgxHTKyWeKOSeyWNypM6DJ0gIZ2qYPXekeQvWdGP0HB0PV65G30Ph2tGtItqZDFnJUwaWt0B7BqrcPN90qqCnmOi6zsNCvKNA2+qVFWjrhJsvlEKNUCqZvgsuY3LhjyT5xrtI3DVyyKr0tPpizKWlWCQQOb3YaPkk5uUcZKParGgfMkP0u0lqDg1twRcPddOxDBD/3OfXGKhN0c2k5NpieSi4czv03cbOSZdLlxKeBHzi66GYHcPQVJiPnl2MPEi5gT2AYX8abb7IGPw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ8yCBvcbzw5w8I0CYQ3p/wZAPDYsP6fldyXgTv4aOI=;
 b=OH27r91nuY+kHuqvUOb6oEOPc6P60bFwWPyfbUI0FsuL1VJf5mkUHAR3FjvE5nz2fyEPzE2UMXIxPJKQGMj+II8uckadrrnw89WgmhLUxZwnV3ZjrCC1Tm41Utmt2c3/0iKyLBxoabByNplr140Ov3+a423TxC+Wu+QktOkBdy8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1901.namprd10.prod.outlook.com
 (2603:10b6:300:10c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 27 Sep
 2021 12:27:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 12:27:24 +0000
Date:   Mon, 27 Sep 2021 15:26:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: shut up out-of-range warning
Message-ID: <20210927122658.GF2048@kadam>
References: <20210927113702.3866843-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927113702.3866843-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Mon, 27 Sep 2021 12:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77c75ca8-85c5-4f0c-4797-08d981b228ee
X-MS-TrafficTypeDiagnostic: MWHPR10MB1901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1901BD6303AABA9BE94E04968EA79@MWHPR10MB1901.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQeInRiHH8uxqu3NZ+w+cVy8ArcisrUWRR6an8EJng49t4M/vCgLSuC/Zy+13OttosqAT47tRLsaLEamH4YbJbpBtQg1y8tpoJjOg5hYNHSgPu09qvt2i9Dl9zDyxb3E5XiA2LI897opYNumOsizGy26vK0dQNq0eR6F1Pfaotmv0gtKBO9SW5YlMbywpY0/KpBRlabFBLbk04Zh+Fv3CXfZnRrEN7F21+PWdCrBdpthjHt6RzMUDW+oh2hkZMjTsSVdkuqRtkYFBAGjeZyqXFooN/dVDAa2rLnrm/U1w48/pd0eHjI1j7KiKiG8Opf1KlOZkFKen35k23mfHHSjXcnqsJsRLKHcYpxBxJ4xxVs7DKrbZCSu1TaXkm8Asl83OUVvMk66+EEiaIP3PAMU5wJJjXP8QSL6CA9HS45GH7RmwGygiTa0SLUUd7OlXWR6JW7nZZduyW54EC1yHQEh8AgOqvmIrTp2kFYPpJrnjzjftnBoRRvGR0XpJz7fgmxqlFQiWEPiD5bx+12e4DBBNobyka4qM+7ue29cxV0sc48IouaXUvHwX5xZv1mJqBaE2zc0tMwpyJQOy4KM5GiI4HHIyTLzHdScK+nDxEMMDb63rU9sqL0CuhXpxtMk0OA2f6xofmQos3d2nE5zQlCODFV9YueKuywWEZ6D5JfTrWe79q0E5W7qxMZOek5ywNBOItQkaJ73gI/pcAtXflqEZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(9576002)(8936002)(1076003)(38100700002)(956004)(33716001)(55016002)(7416002)(33656002)(26005)(2906002)(316002)(6666004)(86362001)(8676002)(508600001)(52116002)(66946007)(5660300002)(6496006)(83380400001)(186003)(44832011)(6916009)(4326008)(9686003)(54906003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwWSPPjP3ya49T9s2ZaBENgkNxCKNUjp4wDMLM1HjB/7A+YTgWNyB6llWa6I?=
 =?us-ascii?Q?LMItLKLbPeKd1iZoAoWc6GeNXa6I0ZIT4SOyoDH7DZLdwFk+cvy7dAc3offC?=
 =?us-ascii?Q?+Dlm0Cpir9jUj5XcgRF2E/Ecjuguk7BtusHzob7mDyNwHBKRbORyskx+BIbJ?=
 =?us-ascii?Q?qjbTjCil1pymvZoeypriLhSoYBCGQRbzk1Xe/DboY24JIvcgTDumb9fJ0siE?=
 =?us-ascii?Q?QyfMDTWjl0pG8YVJfl9Waca5cGysrzOv7TnsUKwKXcrhc/464ReBoTRMOz8x?=
 =?us-ascii?Q?NRQdVruzQ4oO7ejtcAGyptQOW1TPx1UmMa60YcItVOJ/vmZyWhW2T/8wAOzJ?=
 =?us-ascii?Q?GRlzV+mNc7ScKBIyu00q9OpTVX4/vLZllz9SVVrrQQIh0jjGuCaS66JCQ/Z8?=
 =?us-ascii?Q?sZhfILyK0NfCGXt44cDsmcPEquApfAp7Z/1EIDr6V9rUnZbCn+VETpRpZwPi?=
 =?us-ascii?Q?k/rI+ZkpzU3IbQCxN3JIQLWOmDwnu0/Ke8CXgwzQmYBHXIJhy7FwQ/P5KtGM?=
 =?us-ascii?Q?XVOzqutPveJspsCOL7n4WvWU7b3tv2BchjUWdp7UopAlGrzasGQQ4sgfBNrM?=
 =?us-ascii?Q?j5623CHvefC5JLu6lwT80HZplnkguT0o3dMtvt8qJXFJUVtHYKDHUnj/spaF?=
 =?us-ascii?Q?vBtbTfK0bD9jDthCY6BIUW4wgps+G8Hvfc5sbNfwwA+31CCtGAJ3OwKUa536?=
 =?us-ascii?Q?rKPzs/j3dMvC8ymKHyo8pXe3q64OghHqO9YMGvy609b7U/a4K2KxmFpWxUqO?=
 =?us-ascii?Q?wAr+ns9OCxgf9sF9e4w+00tRLu6/EByY1lfM0BKIZ2dXoGeDowVXFIYgrnz2?=
 =?us-ascii?Q?d4p+A8ZoVdrHpS8zOacgmgJLO8Nv1tLTnVqjzYPfIp080SpYPFFd8qiaR/Cr?=
 =?us-ascii?Q?ncOohbHZWCHh5JjUDtMSq8uuPUfMFskHm7SLIf67+DjcmrEOZQ6N5ob3bC4Z?=
 =?us-ascii?Q?o+EqkhtbJQx5pH80KHqogZacyXN29CJD6f4cSZHtxbLKrasFzfIUIpUacaGV?=
 =?us-ascii?Q?nmo+a+n6PN/z6H0WzB4Ej+t870F7H4a9ytrlXlJvxeLV/QnrRU79rhbms9pb?=
 =?us-ascii?Q?SsaufK/rSTuksgx+sthqkb+5g/uFJx1Baet3TT2E+pa3maFDdbOiZHjzW9eR?=
 =?us-ascii?Q?RJzyYM1QMLLbczVGpTd+nyKCRYrXHt8Z5nRx5QRuQNBbUwq2el8xPnZlBciP?=
 =?us-ascii?Q?XquBjT1LNn9YYIIwNCpGzlI1u6YrZ78asjilgxsYqchQf7c576XKIjd1p5y9?=
 =?us-ascii?Q?WR7bno0qlWYfDI0jjaDFzh9+nYdc3GvGorLgvviixLOfJ0jbEKnxj8xipI4a?=
 =?us-ascii?Q?78Wm6UN2t21MVoivepkyV6d4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c75ca8-85c5-4f0c-4797-08d981b228ee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 12:27:24.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qv8cWcDhU6zudd3RTQuraixWiUcfczxv/ySH2jym42bvHP/kvBF/qVl2+ZCzdK28CIc3+e4y7KCn6zVwvJy0t+kSYJKo+2UDHAnbP3KElP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1901
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10119 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109270085
X-Proofpoint-GUID: q7mtb31NJY2tHIElIPJleB-czchtj2Ps
X-Proofpoint-ORIG-GUID: q7mtb31NJY2tHIElIPJleB-czchtj2Ps
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 01:36:56PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The comparison against SIZE_MAX produces a harmless warning on 64-bit
> architectures:
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:185:16: error: result of comparison of constant 419244183493398898 with expression of type 'unsigned int' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
>             ~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Shut up that warning by adding a cast to a longer type.
> 
> Fixes: ca641bae6da9 ("staging: vc04_services: prevent integer overflow in create_pagelist()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index b25369a13452..967f10b9582a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -182,7 +182,7 @@ create_pagelist(char *buf, char __user *ubuf,
>  		offset = (uintptr_t)ubuf & (PAGE_SIZE - 1);
>  	num_pages = DIV_ROUND_UP(count + offset, PAGE_SIZE);
>  
> -	if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
> +	if ((size_t)num_pages > (SIZE_MAX - sizeof(struct pagelist) -
>  			 sizeof(struct vchiq_pagelist_info)) /
>  			(sizeof(u32) + sizeof(pages[0]) +
>  			 sizeof(struct scatterlist)))

The temptation would be to declare "num_pages" as size_t instead of
adding this cost.  But then something will complain about the
"pagelistinfo->num_pages = num_pages;" assignment because
"pagelistinfo->num_pages" is a u32.

The next temptation is to change the SIZE_MAX to UINT_MAX.  I didn't
do that originally because I can't test this and I was trying not to
break things...  We probably still don't want to break things, but maybe
there is someone who is more familiar with this who knows if UINT_MAX is
okay?

regards,
dan carpenter

