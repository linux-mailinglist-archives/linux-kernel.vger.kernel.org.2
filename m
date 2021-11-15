Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69DE4508E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhKOPv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:51:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56236 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232339AbhKOPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:51:00 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFEvxpq002716;
        Mon, 15 Nov 2021 15:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=M/YAEe+g/gUr9MIspdut6tJiE855ZgGHdJj0Ff0sbxo=;
 b=Z2pB22rahreMk39vPJk7vWMdLxrPtQ56v3kOAFuX0FczmVADKWlB1acxcNVZMzJ6sag/
 etTUyf1yr4TSxtAWOVeCvNK0AvtMcpdQALndXVb9a+E/G1pXKw7rstc1owYkhj41xjQd
 wnRonNVncOt9UPhdNS4xk/7wCsYg1dMxr8trWuygi7TSLPzVILmYQbitMOv+OSIBrbpT
 UEg0ZFxXrhcv82J413oXoa4ts0P9ShRYWEsLI/LsWr5zwbUkMHN+ToUQN+sEM74EvKAW
 MZi9QLmeJlwgW0R/IMShip6aaR2UEKAIp35mcE0fOHPzaMnkVllraV3jpFBa0bRmewag DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3du2nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 15:47:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFFkAu6162041;
        Mon, 15 Nov 2021 15:47:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 3ca2furm37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 15:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxf3Vi84KGuxLHRpnlkBIGMaJN23TDy8+I3mw7qsDZ4Asu793VBVFGvSH8Bc++hkq7mA0rv3tkFMxAbivwakuEYFoqEFJxSXulRsElCG20cVUXsDjZhoxJWZA9GPc/quU7UmP4tCjmzTnJSDe7HwV8u2RjWu0U8HMHDeU+RsbXMjtDSQBB+/tKXYbsxLJ5L4mV3YF/Wd/YLsoUtgokcFbyV9gwoiIHOeoDES4Z4fM0GK6nY++QBVcB4C7pj5eXhO4Wp5IvPPjnN/EVkA3YqOHaKcJj3ce1ufd4vxxodJuVDc8K3jjsz3M61VnL0hOnMgMCLhbkozn2KE/aNChvwm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/YAEe+g/gUr9MIspdut6tJiE855ZgGHdJj0Ff0sbxo=;
 b=OeCz6AIeh9VmVdgkZZNKkbCL+IQtRmmfyLWgOeM5vCjK1jmCDmrohPxuC16mK+fWko3mg76QMbqvz7Nwhq9j928KedPZZEUh28rMmh4mm7KC6QiPZk58rttD5vUx8c42fHU527e9TDU1Onhb7c7bmr4y41rg1AfcTziup27y5m3m89DZOC0PG7GFa3Tjp5m9yYX/DBMbNgm6W3KmEomO/0qUTff1/fGCw1G1BktWQ9FOLetkNGgEzwNG7rHdsMu4x0o1hlJb2LEahhvcqM6+P8wQUjbgsHniSwmEzzdd9em64DUXy4QI8lvXl8kFV4a52BLXiVIfnFmRpofsnjoBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/YAEe+g/gUr9MIspdut6tJiE855ZgGHdJj0Ff0sbxo=;
 b=XSzWYB41HrRTWUbMyR9mqCjyslMz6GwoeVYYE2bK3PcyQEGwL3gd2C3taLuDIXwePrNNb6kJ+GhxTUvL1cIvYdNv33e9aq90WrSu5G00VjL86P4NyFolpwYO72xlHjgpXe7yzPRWyV//6B5DFSKm1jQXYrb7IgHAcWdf1/ZaXa4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1552.namprd10.prod.outlook.com
 (2603:10b6:300:24::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 15:47:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Mon, 15 Nov 2021
 15:47:39 +0000
Date:   Mon, 15 Nov 2021 18:47:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] staging: vt6655: Fix line wrapping in
 `RFvWriteWakeProgSyn`
Message-ID: <20211115154713.GF26989@kadam>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 15:47:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 434eb295-4ef2-4d8b-6596-08d9a84f40e3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1552:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1552FE481F46FB05F4E761A38E989@MWHPR10MB1552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MDw80A4RE078arO+Jdsgzj1pfs3bxkf5WRT1Jo5Nv16I52zF3VCAcuFEgo+j9y0FJ1rXBvrh1O7uv0vApC0Di0ojmEvcDp6jgjdHHk7ZLHeMQ1Qh25oU4YMoI2+2zRiixQNOGeQjPAMA2xZ+uIjOYbynvDpiYpgKM9a4whmoh5/EYAX3GaZUGbDPe8OgdTyg33wb0YN19TkGHK/ws4bAjvCKx8AVnOiWUyVW/e6uLn6i0PVG9sxs7F8j99BASmSxf4PEMK6p36Etpk5OH/tjV94VKNTqo6svq6BZtxg6kLQC9GTFxbd4XhQAXYv4C/RYSP8ZAPNfG7ErzNa9ChVlzKMbJIJsni3yA7kMI80ODFcnwxhvYvAqdhsHDvA2CJ/BOKT8pSkuFc2TSdktKlluBZpRwJqQfeuu946678bs53S9AqPccrk1VFZQiFn7r1wH8i3vHrmVA/tsqwAhzHrr4kDa7qS//5nsrJ+mV9aUQYfjHcDjqbTZQHR/Ulze6CJDKzzyAyepXzyXUXq0bv7k4/7+TYTgXLVD2mu2XgO00epmfc0ZRWSrx+e+5gvnTcME3RuvdVvkZv36Q9G2Inzy4YGO0Z0VNgqR2uwkoWVYVKnsKpaolTzgGWjCvhIlA6btk1a4A9+CtwKPZSYA3bKtucnF6g8U44gFSgr2U397ABQYy+wo5WRfgQEx3bYi7UHP38/Se0vxsdYQwBnOpILjVBvwXA8dlwSawIevKetKsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(366004)(66946007)(38100700002)(316002)(4744005)(55016002)(9686003)(6916009)(1076003)(6666004)(508600001)(66556008)(26005)(33656002)(2906002)(52116002)(8936002)(6496006)(9576002)(66476007)(44832011)(86362001)(8676002)(5660300002)(4326008)(186003)(956004)(33716001)(38350700002)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5WkK0THuV8BF6ZGPaeZXROKqxpYZ2WJk+rxRCq4xGYfKYjLuw+wtd/AfuqYf?=
 =?us-ascii?Q?qwvCTfyiwYo/mcI4Cz+i1soo+uYU8MoBxoeoNfKJV4dXJ0qNaIeBsPL/EIfS?=
 =?us-ascii?Q?QT9zoz0HSx49c3AvpgUJlEwgEO3FbUZRi6LwZBQr2etmRRmSAY1tmBnUZfSd?=
 =?us-ascii?Q?qGa1OpBX28YI5INbSHcwo9jyUevoFUUoORHwvDz3IdwqENJLUyQ/0Wn1Fulr?=
 =?us-ascii?Q?4rfaGBAuCQjNmeu+6iLA1h7puQDLNLTRZOMns6cSWvT05roaXKOQK44ilKNS?=
 =?us-ascii?Q?7wAXeG/TL415p1GQxcJwTnzWH5zyDB7kSBSBgqNxKWbxkNse5YYA8c8uKLnq?=
 =?us-ascii?Q?/luAovn9kWRH5BGF4e6aQFVVmOgOs+oKAV0LWSfqYTr2DvdfUuVwoqKVALhB?=
 =?us-ascii?Q?zBObTJNdQ/Pcs8VtObjjzV+sFB0++gEZ/26u9UUAheD9jP4HULHXwugIgHUw?=
 =?us-ascii?Q?FHwYzrwg6Hafo6yThw5h4ZMKqtFpFGax3IW/YWjvFMnV31L7vWxk3tSHCEiv?=
 =?us-ascii?Q?0iJH3uGEZBO1fr+1KpR4CumXfaPrMrP9uKnoKpuf4V24hhd9YOc68hCZJYZk?=
 =?us-ascii?Q?3+mYNxTgJac3mfWnC0l70qjLDT6ISdC71C+TsQ/4WiFrhAs+Y+o9kCn1KQI/?=
 =?us-ascii?Q?JnaxIWO49sRDPSn/E1fGzwEnLUMIBzd+1xBxDBdYC6iW1jJI+3TlV4GauRs5?=
 =?us-ascii?Q?Bm4t9LAn9ywCtXmRuZ2+IMvBM6tdNz2nLwv3resRGkCaT1+v62m/2KDMctzD?=
 =?us-ascii?Q?D1VV9Ef/5je9rAEQOpIYEzqitTJEMqRg2TdNRI+Dgqp6FoWZFw7QNHyMJ153?=
 =?us-ascii?Q?R1v0oGWBKbdyGNtkw6OCL3B1qbJHXZFONp5A3JpDRVCJfr/0TGYJ+IszTd26?=
 =?us-ascii?Q?POsS6m8esW/4K3fxAmXx0Ww8teKENsHHxQGcrfnpqRQ992EIPY7AD6ruGgyg?=
 =?us-ascii?Q?kByxtu2kXjSmVfRn1RaAN0m4pjjuO2tlzKs66G2Emv1p5Fn2NsaHtWy330zv?=
 =?us-ascii?Q?H55gsr1pb8V4vBD7vC+fyvSDB6BuqQX0q5qFG5WH6XQhj9DqbTkbsm0QMHgw?=
 =?us-ascii?Q?7eBwLvQ0X4eaZAARlqnrVVxyuULxJKWaLeSKo7Spsz1XebrOI/bieC/7l4Je?=
 =?us-ascii?Q?WvX7McdVbeuUzy4ha6H64dTvlQnDtUWqEz/pxn9nGdahGV/N0hIfGEK1RY0m?=
 =?us-ascii?Q?X9h9VuyTvTC+SN9/5zn4fTtlstElgVuYjuXvRNDaC/RZHWxbhithcCtY8hWE?=
 =?us-ascii?Q?VpAwd06kEoF6u4i7/Q+YY1m4GlCNUIBh921F2mrCeR7plO0g/rLeALL+4ion?=
 =?us-ascii?Q?A0l711PULTinIgGU+9/ijJuh0NuVGKa5jv0rrJABY7XFyanTieSD/nKFyeOy?=
 =?us-ascii?Q?TJw+1V59mRxvcee2mBFg8Alz2R+4X38to+X7v6U3WAY6a0Vti2vBFH0pV8Z7?=
 =?us-ascii?Q?XHY7LgMHbNaFD+RHA2IELslI0qAFiJ94TxIwL6iGat+wF/6ohuIUkwuPBAgv?=
 =?us-ascii?Q?iyFgL5dMwuNrB9b7sXQS7KBVu+zVZgmQ/eQ6SN8TtUEi8BkaHdHrV6sLATbg?=
 =?us-ascii?Q?buUipTjzYd1fd2h5y8uytoJlKxxTZByYMMdH4tfvl2Ztyc17C6olVlqT6H0V?=
 =?us-ascii?Q?aic96BmAjok+b139KGrcfRrjIhIpjbwYmW5Ik7sQb/CI08xW/XBAaslQLPzH?=
 =?us-ascii?Q?OvWcUIcLbfdP34Ie2mCagjGWbrM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434eb295-4ef2-4d8b-6596-08d9a84f40e3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 15:47:39.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68qnmFEzy+bCEnSZE7ZXdljgbAGQuv0F7wV+hSBXs8bgKATi+3irWdOkGheXCAzPwmscPmQsKkZ0Jse8GWdj7Ax6e2/sLD1mRlAM0yuV/7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150083
X-Proofpoint-GUID: S98LmVP-WeLDsrjFHqSOwgDSUhch3BNi
X-Proofpoint-ORIG-GUID: S98LmVP-WeLDsrjFHqSOwgDSUhch3BNi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:55:41AM +0000, Karolina Drobnik wrote:
>   * merge two patches (using incrementation in `idx` and cleanup) into one,
>     partially implementing Dan's suggestion

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

I don't know why you didn't implement my suggestions exactly as I
described.... :/

If I were reading this patchset the first time through I would have
NAKed it because patch 2 is done in the wrong way.  In a way, it's my
fault because I tried to explain exactly how the one thing per patch
rule worked and I obviously was not clear.

Ah well...  Let's just merge it and move on.

regards,
dan carpenter

