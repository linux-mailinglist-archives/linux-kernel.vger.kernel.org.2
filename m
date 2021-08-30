Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B083FB3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhH3Kks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:40:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40810 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236288AbhH3Kkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:40:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17U6woML032083;
        Mon, 30 Aug 2021 10:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=vl3pzbtuuRPM8NnxvNi7n1ZApjrxdHqMBfF2ibwFpiI=;
 b=qEAaZGu+JfM1nFGuqiZFljzfN79aXSFEn9hRbbtA9lZ21V2YlPCvVhfOMeXviznPLVWb
 FWYBUYPlFfZxstRC7FxUQyO7iEhhS2zx5w1togpzFXLElKiS+jPPkPDxbMlFqaR0fi2X
 bX6WW9EHS33Hd0l6gQh9Bwd0Sa2mgnV3WwSA24YcSg6PBFbGxQrAWQj1tpJFMUTk3rhg
 X85aLxgoL3lUbfvDddFXVE8zmz36A9z4ZSp09cWxi/Dd/Zo2GcVawK1ZrjY4Ac7UfJd7
 dOYIclYhmEupXl9HU+vx90E0rjCe84Eq0COeqjMZ493as69MxxXKN+tAtIDoMzgxAtIr 9Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=vl3pzbtuuRPM8NnxvNi7n1ZApjrxdHqMBfF2ibwFpiI=;
 b=wsT76+petaBuqtXfBDfGS7O7DtXKCDz0Wo1vcxxIvkJ8Mve2BVKMEUjlxUWlYn8YhjyV
 1jEn1e6/oscGH5T1XbkKPLMpLp8Tb2Ji9vkvFXJ5Rm34T/Jnmm2bweWy2sZvbLsVyfa3
 S9yQRpP/tkh0AKDRPJUWc2QsbaOPuG8y1VUs93C16l8CZisnnAY8FyiU4WmVqoGxalxl
 zWbBaGXIw4Du5nwb5LS1GbJJjEYRNdiNF2ToPbYELzLHQor9jOo6NK6Tuw96q1iU+M/0
 VVlKyUi5GESexLDzS3z4NKDD7JpoYpP107WURnVBE+vHA3XoDA2iE8ZPxNFMqRNOUfAs jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxsh6rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 10:39:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UAZY6b020190;
        Mon, 30 Aug 2021 10:39:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3aqcy2m1mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 10:39:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D03WCXhbeJ/spYV4QT0KliSEVdwZ3LuKkZro+lc+oW3VHa4X4AgqPBrHE9cm+yZiYkQb4wP9ExE6SaseNsL8DybooP7i/Ofkuf7m3eiej8rXdZICaNcYWDN7H6kscGQDS2fFn1o/ywenAR/PW7j8JVpmW68ywv5/Pypt1smLf4bpUoPeXL8mHtLUxLuyAXEB4NcBvp+5/BfZC2w0JKBqECc1qLoTWTxRW5Xy5AWX64w6W57MsmNvu2EGNDDfo2AJ/SqFYu8J1iVZwPuv0Xwq8CZ2HahVh1tMCDXRHcE9vz7vGeHIh1HuSDTobanPLgZZHrcnpg5SWFYBZ2ZSX4odFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl3pzbtuuRPM8NnxvNi7n1ZApjrxdHqMBfF2ibwFpiI=;
 b=Id1KhxLDG5WyWwj+DJyxWuHPexflUFsbZUIKpw5dGY/T5Uos3nML0i+ToFE3NyuYFlgbDMkYjtTb7eB6LLC/OsExz8PtQ/GdCBcW4nGAcCC/rBrYKJY2FqlyH0A0n+OYIefUR+c0WYSB6E9qur+mI1PETABOS/eDhW7kLEYQi0Aj3h1EZUSeVWWao2nZIbaZFG6wvlTQsSgxXYiVqJkPWq9wPWGJD7et6/DmwjcS027z3wr2rC7co9jhYywlVYhQGjxP5obGHCzJh6MF5mXNJvLVmOL9YLf+rhOLmDLjbQQC+3OVFIiFL4AT2Zo0FU/8whPxYW/VKDrTGgoFFg3mwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl3pzbtuuRPM8NnxvNi7n1ZApjrxdHqMBfF2ibwFpiI=;
 b=k37f9QKhsq0ahECm2MssKn7ZqS4KKrBrpsAd+3qIAHUXNyZvPKrZDnFnbKSREeFdUBI1wMK8+ZxvLDAH1q0HqlpdAFuw3m2vEvQT3k/h7kOSQC/W8ZtdiT0x/Cy90ciRWnsp6o6OPH6jg5CrPjuaUSvp9R9bFXq+GUaUUAPLfWg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2207.namprd10.prod.outlook.com
 (2603:10b6:301:36::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 10:39:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 10:39:31 +0000
Date:   Mon, 30 Aug 2021 13:39:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: r8188eu: incorrect type in
 csum_ipv6_magic
Message-ID: <20210830103912.GD12231@kadam>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
 <0b7d6e92c79a6daf55a0c3a4961df6f33a9bcf37.1630148641.git.aakashhemadri123@gmail.com>
 <20210828113726.v4tmknjosvgb7bke@kari-VirtualBox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828113726.v4tmknjosvgb7bke@kari-VirtualBox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Mon, 30 Aug 2021 10:39:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0873958-7701-48bb-b7eb-08d96ba272c8
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2207BC3191AF3F883327067B8ECB9@MWHPR1001MB2207.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00GVJXoQM4Gv3Y79RgVATAj4FFEiyAm08Yn41RZwVPoBNQM+p2biRTe2yufs5VLykaAYs2RshLCWU9EEF5qqYWrWBMKBxhp/FjYTdynm6byT21qZSZAjqvfg82ubXu+nqIwCaMYrhA+LMUZtoRkh+XwquzvlATV90dZC14JEzW4gL2h1OjQjEdQ/egJsZyrV1sXsigZ522xGO6+TkXnSNq+KefBoOBy3TPPkRFg5kT4y1deADCM9Og1P9Z6jQ9sBOiebwbVLYzbDKpgIk/ks2zTBklH+HOEjoTo55Oi7dHxixf1J585ITUOzst+MIHTgzTTSVjwOiKEso3kLgG3/JH5qflC9EE/jJ74x9J+7gnOF+kwMDoTN2CU40C2m+zG7M2oyyZdEhRkaddT0BvOOe8xCpF58o1oJ/kfOcs0GbjlaCZoNwyVHj5eNbrqmDDGovraT8BlZRBXwPocRi4DKawhi/8376di7WGwYQMODf7Cv6HCMGs8p75n5ZTd3gLGBYEubMvw07AF7QR5axjtKUq0E1+7u6z61f+FjUDlLNBpyRnquDB+b3ELak6DbkuCjWHlgJesZSsFBqNyQVKX4X3xeN0bv9FqzBeIo+hBQO3Mkk5KxLY5y7L5KPXPzwpWbO24tz098u1wNQLrHgDnYwmuS7H0RoU2SfU+t6iuZNaxU9YM1vBdKFURFsZiulHDGFe+r8hejQEiZCmBnwHG8xizR4mRcgh3LErTYZbC9bZwKFmjN82/cB/8vtuQQKX5Gd5UWUnEdEavXkdMSu52Xus4Hl76+JdWH0V6+sQpD8NE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(33656002)(9686003)(83380400001)(4326008)(66476007)(316002)(6496006)(26005)(54906003)(478600001)(966005)(66946007)(33716001)(8676002)(66556008)(1076003)(44832011)(2906002)(6666004)(186003)(8936002)(6916009)(52116002)(5660300002)(86362001)(9576002)(38350700002)(38100700002)(956004)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZaILrr22BF2Fi+12lOOE6BX2hxtny1JbJuZNXVQPzJ43KeOvCW8u0C6VqE34?=
 =?us-ascii?Q?5BRpLs4Ri6Sx+WUuhPu9DGoKdNBxRVG0z4tx0djUIO/pQ8Sg5tAxGbP1EcIt?=
 =?us-ascii?Q?vwfVZ6fn3FK0NclDBEpqfHiRwU1+ZKIq3wnTbyvsXp8S4cwPVgVbdCzTuh2B?=
 =?us-ascii?Q?bYKUBooRjDLWM/0RABksx7+vaZdTXl2Gprc5OdhbNHuM+Ds2rPaHhfw5OPZg?=
 =?us-ascii?Q?PODgj9vqunnQIRIdv2URkDg7fTn3D7o/iPECgdJmCkUrjz/12UZD1a/NN37F?=
 =?us-ascii?Q?Bq0ROKIaOi/J1SaG8jnoImdjCJsHmmoVpWzyc0cgSdYrIThplMZUVFF8Bdiv?=
 =?us-ascii?Q?G1/PSbTQdgYLq2NhEaLGpldd6d/zl+I1xbBX5MNSpgl3abZDUJ0ULfYRFnGB?=
 =?us-ascii?Q?SBRZIpoxvkbI1RFFQFJ6WDU29kHXdhPCdneevZ7rL7ae0b88fAVHQ/G+8eS+?=
 =?us-ascii?Q?uGKJf8jmmj/MaKWiy0u6Cxhh/z2ONJVqj2D8gV5g3jI9zxV6tPQRg+jBA/RQ?=
 =?us-ascii?Q?OR6x//ycvPpjD+81LMHl/nMcx2rVguWMAuku7IcdaXEmTPkSdbjqLfjDSTHo?=
 =?us-ascii?Q?ANLP7mZ+gagD+zvQPk6weOn0faY2XH4oQvBoNYV845dae7hh1QKyayWGMjvQ?=
 =?us-ascii?Q?g3DTz6ZF0b+dHORGvipeq761253lbtiyKBW2HJyDNnr0eHzXhbMDI7YHONQg?=
 =?us-ascii?Q?j1sBCUqB0UOJNcyh/bDENZN3NDDW6j89AD/oVnOfR/i2CQxjBmcG8FG5GklY?=
 =?us-ascii?Q?od5ygFHcc5dJCS7zQhSSrj2V6cOFqTu3+P4T8q3e+BvbUcUVye3952rhWfCY?=
 =?us-ascii?Q?J0apPkl4/yVG3sFcQQ59bJ9NFX96sDZEoU6FCiz3lhlduhKrr8R/6oRVBFVm?=
 =?us-ascii?Q?qEhhI48t/+vuGpUzTEYEklXc6mns3FVX25i6mFP5yQB1dwxm0UiguTaOkb06?=
 =?us-ascii?Q?cxj5qRnQ/sue3nRl1tFUpuqwGsAZAE8nFZs4XF73T1OXfcUTKjGJ0FaUqt5M?=
 =?us-ascii?Q?fhPPo8A1lAJjjcU8N0DUuKvr+/AvK3InzDT7+NNfKctlX4KmsHtJpfKyuTaR?=
 =?us-ascii?Q?HCVPZrLDlzWdRy65Ndxo1tbMayjk5wr/l2ImvWMANSGBoye84Ye/J5Am3jV+?=
 =?us-ascii?Q?4bJReFich87qmlxvm0ILBDhduKO7S6us7D9DNlA54AL7pnc+AkKI+coTVaT0?=
 =?us-ascii?Q?udS78PxnynMIB+pn3ZZyiQvsJkHw/eJinH5qWhkqOI5/0KwFi4eHioNAVNaQ?=
 =?us-ascii?Q?sIf/d0LIqHx+Jjjx0w8b1sJIKIp8U+2tpdnioTOZJKzcpjydMhW6zG7X5YDg?=
 =?us-ascii?Q?egFY89m9h2ZNJOYprAr1my18?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0873958-7701-48bb-b7eb-08d96ba272c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 10:39:30.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vri9UCKwwW3nVqHWyhWb0IT9DMEMMVVJBRe07EQ8HHyaW6EQsEccjmkEhHv2LFbfWzR6Y5yPXf6FmTT3akWApligTajmoqbadm4I99TdA4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2207
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300077
X-Proofpoint-GUID: 9W67oxumY7tePmOO1ZW1vPCA6wYaSwbU
X-Proofpoint-ORIG-GUID: 9W67oxumY7tePmOO1ZW1vPCA6wYaSwbU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 02:37:26PM +0300, Kari Argillander wrote:
> [PATCH v5 2/3] staging: r8188eu: incorrect type in csum_ipv6_magic
> 
> Subject should start with imperative mood. Every patch in this series
> needs this fix.
> 
> I actually check linux coding style and did not found mention about
> this, but if you look kernel log then you see that it is at least
> unwritten rule. You can check this if you want
> https://chris.beams.io/posts/git-commit/#imperative

The imperitive rule is stupid.  We're dealing with thousands of people
and lots of them don't speak English as a first language and it's hard
to write commit messages.  Let's not make it harder than it already is.

If you look through the commit messages on this list people are like.
"Blah blah blah.  Fix it!"  I like that approach because it shows how
humanity can triumph over pointless beaucrats.  But in terms of
understanding the commit adding "Fix it!" doesn't add any value.

The only thing which matters if if the commit message has the correct
information in an understandable way.

regards,
dan carpenter
