Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2440C085
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhIOHa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:30:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38526 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhIOHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:30:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F2aGrP007088;
        Wed, 15 Sep 2021 07:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Dnrp2YS0JM/wCAf9E/u1cAfZ1Z+KRSS2VkTJoZo8Nek=;
 b=RMlXrj+oyqhqMJrvdoQZgh2bNWHRnMsC5rcdttcjrClJqRFCyh57+oKEkj+l8y+i03jL
 NM4BbgTH7toJ+PEczQpMK4mNyECKAu7LO0yMyQbMy49NIMHHsP/pxUvBlwXZbcycz7k7
 680mXyq213oDlVeAH90rMwwqKexeM/ptcBYP8fRmVL8dRM0SN+TbEsasADQ78ZGduo7w
 GSmGVdYllj1zIuNroWeXBGKP+GzO56k5+Q0DBEzRWMGj3fa1FULm9FgKqIsu7RiBnqf4
 xhFHrvNG7PR1wpHBgDtDj2tDYZ18Y7YARNSQvsGC7mEgaOO+tl/UFodhlZrG386jJTZG Qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Dnrp2YS0JM/wCAf9E/u1cAfZ1Z+KRSS2VkTJoZo8Nek=;
 b=I9kJEel47aknbVQTmT4EO0NlvJlIqndvQGJ3vZeKCcUbqiZJ4vh/QY9SPZGIreRzYCfY
 F6JD7/dDeMT9LmNspYpWQhvAEGfZLKFmgGmIca57DhAY9XwiPJgyjr1M6nhC/vKEUWEi
 NFe1EL2zopucRYdHZSGs9sh37zxrkeu4n8QBAnd6sy6bZNr8tVH+Zmw2+lis5tsc9IPu
 n9iuAsnUzx9rKIQk50J60k/BQ/VBGyHO18PG5OHHoXeHwDKc+ms8g/AgBLjr8s1/iq/l
 JizRFq3VjuMUALn71h4PPU3dD/1ktmp74WEKqpHlb0StF+bDMAQjdwXhtxkYnXZL25z8 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p4f3us8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 07:29:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18F7QQai158879;
        Wed, 15 Sep 2021 07:29:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by aserp3020.oracle.com with ESMTP id 3b0m97dwbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 07:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFrHBgFbqIATDSZRVnXm2g6UF/M9xfLsBDorBkcC8eOhGfnKBUbjgDoVLLlh2xCfCZNIdEKNlF1Zoko4nNsjeqYTS5w6+q1s6tzKAs2e0KEXcpCBy30MmEhQXjcZLCNcDjmtDpFEV9pYgWFdKW69g8IUNJ6tGxkl7N/u7MeamVXxr1mUckQOvek5wYSA8MpNCELmiz7YWv2WnWjUGks0mUa0w2cTMcX9EN89a/mhGjCcSqnTC+ZP5QRzokuAJag6y2Rlptpr4CWY6oGwcGFCLFKDYRT5ORkuirr9i0+2ogdAxPFWIe+M/E3GRnnyfRjc6eZpaICfJEB1Vxfp8HvXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Dnrp2YS0JM/wCAf9E/u1cAfZ1Z+KRSS2VkTJoZo8Nek=;
 b=H+gC9/JGH5niUDlBoU9tsNl7udBSMK3UuyGkdVeoj1nuUIR7q8SugJgQFhecFPmn2ks318DnsbvzPHqAaqIEWwcxuNKedXWXV9DsJsBnwNyXtC+83VKb6NNgvJhCjuGLlTPdCDV6M3KV88qs6km4E67njObwn+Bv7MxbRNCgHdWMrftJ3VebQEndaxECWEOANwkdStqkGnvjFCvE/vqXbgpmldbtSoRJznDKPvLZGkWVRtQPtJk6y4TTi71U9Tpf0wGA4tQ9jGhvCTLjt+OdPO4eDcpn41kjfySS7gI+TNwN9t6DtX+NgRiM11Oc5eC29MHnM2qLCWHXUjnF5V+mgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnrp2YS0JM/wCAf9E/u1cAfZ1Z+KRSS2VkTJoZo8Nek=;
 b=j4+o25+wjeUPs8Rrz2CXpSXXGIxZkN/28Wbdr7Z/n4erKB1sMbu6cq8udBS3jPQMLLUpo8kRbA7/pc05s9UOLvEq1TyWUok4B5j4YuzJoh1kP5hrxQkulYiqWR+beJ8lDb1+YIUgrHe21KaGt7Tfz47eMFIMm2SBoN6rP4WY/3Y=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1904.namprd10.prod.outlook.com
 (2603:10b6:300:10a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 07:29:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 07:29:22 +0000
Date:   Wed, 15 Sep 2021 10:29:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, arnd@arndb.de,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: vchiq_arm: replace sleep() with
 usleep_range()
Message-ID: <20210915072904.GF2116@kadam>
References: <20210914213532.396654-1-gascoar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914213532.396654-1-gascoar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 07:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c7fddb-5e6e-4910-89b3-08d9781a8966
X-MS-TrafficTypeDiagnostic: MWHPR10MB1904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1904F012FEA8CD281697D2DA8EDB9@MWHPR10MB1904.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0FEuWu/fka1C+z3wv7IfW81Xpe3RGO4VZB7MAUOmIke5cnHOBl+WyF9L/WpxLfPgjw5vuA/L58UpmbO94VSE+X4Ctc+cD1G2zhLmVyCJHjAv4R1dKQzt8lA56p7UTWXvJ7uIQOOjByP1+eZ1Fi7oGdkWNI+Q2+16B9IfKUkAcO8MlVjt6AuCYWKD80kTHJ5ceg4E/wXAh7kpFRnJJowmzka7uc5/ox29CZ/u1Hd7zewa7gQE8CexxyBvZg7KkQmAl8uBs8IkmHC2V7c5CF0JRo3wxgh3L6PRX/85GY0sF0wAcMDqpXNZXm4A63DSV4uZrPZ/rBGNkXe7OAg36w795v90BbVaZWbxzbfobsfluhve1g3aDi/ufP4I8KqUw8Evbvi3IDxBr1AN1EG2Nq5eKsiNzHJs5SsWjGDFruoN7ilh40TrWGshDl+RNpdIb/lcDCOoZGC8M4VdS7GmQJn1oZSXprHp9oCV1zJ/X30UkONr4ZW82Z14n+3K+6ra5vtCtd9CqCFgf+vCYh+iZ3awMpWRtJHNh+I1J05sjq8LZtyI3IZ+Bk1lPMohhxPklYiOrIyENTTxQyR/2wfCteFTu37nIQt7x4ykvw/ubcfa+2wBaJx5BqdFjGEmO3zzM2bqt9L1SXB/o6o10bprQIiU8Y5aNhcQw5B+kM6x6eVwxQsdSBAsxqDfQ7qIl661MMjFwnnRS7HcrBosDPNVOjC6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(366004)(346002)(4744005)(66946007)(66556008)(83380400001)(2906002)(6666004)(66476007)(8936002)(38350700002)(38100700002)(44832011)(9576002)(7416002)(8676002)(956004)(26005)(33656002)(52116002)(186003)(6496006)(9686003)(316002)(55016002)(5660300002)(1076003)(86362001)(33716001)(478600001)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5t2BsdfQJOwQuV0mlo8D2OUO5lN8ZVn2dF4bGDFq0X1iCASDClmjYpbwEADr?=
 =?us-ascii?Q?Wbkm8aP5+x/pyc+L88lUnGhcwuoZha6Za27PmizqJbrtHKtdqfuuMRrrQh7M?=
 =?us-ascii?Q?eT945XQahDwVdwSIXrvNZcTNkc0wnxmhviRJbMTncYfEwvf2Fte30km9Yx/N?=
 =?us-ascii?Q?8XcC9crBrDePAUscGg60NuNcGXcsVQ6lmnqNehkitNXk6TSc8KhZhtrIOrAB?=
 =?us-ascii?Q?v8c6tC5mXD/I3LajligyOutiom+c2iS7kfz/FnyBtV7XZJDyeoHj8E12JDE+?=
 =?us-ascii?Q?gsRpR42PjZ8BC1p+1JqRaZpN4Iu1w3tXieDzoZmvvicr64S724/JX88Lm/2M?=
 =?us-ascii?Q?fFtkQaKYke4ek1r9VntHxksl68qPA6yRtl17N2GQt7p97HA4GCqEKSQu5bwX?=
 =?us-ascii?Q?rR3/YGHfeZCIFr36xuGRmOXh6IWFb7XFJUPr9KBu52mP+WTQWDmaAPJUBn8X?=
 =?us-ascii?Q?qWESgpvyx7QcUI9vN7CoaDUKtEPVbSCgp3nMbN+23si2N4++d10jstj/DdZs?=
 =?us-ascii?Q?5g7nKclUqwYudGmJMpdSJYbNzUAKixJyIaqti4ofPhHaBuduo+YGq8burtLv?=
 =?us-ascii?Q?HSEDg/sOXlazLZDOzz0KVWQPIPriNr1TxLzPv+Wh9DSZ++OsYF/OKcIYYDtr?=
 =?us-ascii?Q?xmWKwJGkfDgiOSkxaS83rSt/cTsGrJ6bL0IQ11010RDUcXZ+sExu4jtKDluQ?=
 =?us-ascii?Q?uZxtfCKGvk3Avir64TIxZ8zVK6SxYNce0fZT8//0/tTMZqJKlE4MKSaLtfW4?=
 =?us-ascii?Q?a2Azk4TUlj5O8QselxyAcmiDazlRdItYCHjf670oVLAtr54mnzaWzZYaaP0I?=
 =?us-ascii?Q?IWJh5u+tHSmB4KLY6g2mYjHojXWVilYSetqEE9+2jl8GRpSrwV1283Ij2rup?=
 =?us-ascii?Q?1n0i5Y8mWvBZEgpBo8z32qTzF6kMn3sAD5JuTEtAWyU+fAI8zLzvtnx89VUn?=
 =?us-ascii?Q?im4XidUC10YJPcm1hV9NPQ8Ar7TC+LnuS54U+LZ6uq+AmlK7J1wlvXboD2EY?=
 =?us-ascii?Q?iLk6SctswVqNXXF6bPEixE5zlddqaQy25XWcSikgZjeM6dxdNVhSreFOxIlA?=
 =?us-ascii?Q?SDstLf/CAnQrwrfip3PkTYX2ZEy+kdBgkMn65umtSwEl4tiZJuiC/d+kUv62?=
 =?us-ascii?Q?s392Qen/+cNQsdS83tpsoO/b6ulm5ag9gQvW+MwTBIC9bJ2oAuuimUsrcK9u?=
 =?us-ascii?Q?NmKYvHmJRz0QP6N6TknvZNEbsY9yq4LhlmhRVZgmPTfTdWPvpkKJWr70ohBr?=
 =?us-ascii?Q?aRD81cPxP6GQWbKWFUkYsaWASJ7Wp88YFDLHRptL3kMCugDmw9LXcd5MNkLk?=
 =?us-ascii?Q?DsGoFOxPNSiE6v2vf2S/4y72?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c7fddb-5e6e-4910-89b3-08d9781a8966
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 07:29:22.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOhcY5JWD8B+1o1SjZql4KxJkIgZVvxrlUtIdrY7MU9ZNcLKmGtHKBe+qW0WJLXOyhAkxg+5skRS7NfJ2DACwy5m20ZndnMSQHB/ne0Vjlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1904
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150046
X-Proofpoint-GUID: OiqPHwXseJCxr2tsYSkJU5xTjgp2n4Dj
X-Proofpoint-ORIG-GUID: OiqPHwXseJCxr2tsYSkJU5xTjgp2n4Dj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 06:35:26PM -0300, Gaston Gonzalez wrote:
> usleep_range() should be used instead of sleep() when sleepings range
> from 10 us to 20 ms, [1].
> 
> Reported by checkpatch.pl
> 
> [1] Documentation/timers/timers-howto.txt

For this particular warning, you should probably just ignore it, if you
can't test it...

You need a Signed-off-by.  Please run checkpatch.pl on your patches.

regards,
dan carpenter

