Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6620D42EFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhJOLju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:39:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40606 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233155AbhJOLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:39:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FB4ltG022075;
        Fri, 15 Oct 2021 11:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=FdOu1UegWPSzGF9P6NinvS7FvitIJruEvbDWHlyO8II=;
 b=WG3R8YyJm893x/8KrNHJLxsyEHvONl9b4DYCDj1c5ynhsAyWclLlyV987XJMdkwvLK02
 9CUZ8gVmr35Q2Vd2YakpWphQClqIalcQYubtyBQnA8E4Ikrxa421+t2Xs0lkmXJqkhp+
 VF1z08EuGAGHiyu1m7d6Fy6OMC7J16SSWUpjVArWpcJMX58TantWl5eX8f1ay/HKpu9h
 CI3ZsqWac4hcSNZR3MHgjoKlWolQLMt1sFyKWhhw4r7TIFzDFJ+ggmnIJAz4NI28Ensr
 ps1MgvHHQp1UKXlVvjL9eN9DlPWqXCU3fDZn2C3VYHHTIRjCFE7Cm4yfiU7XYaROo3xo dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bpfveg4cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 11:37:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19FBLX6f101536;
        Fri, 15 Oct 2021 11:37:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3bkyvfkf0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 11:37:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZknuBIetb6ctxl0WN2mChGdTg6BYdqFvO0DSGdaGY8Y8ekQzhi+Q+qeKuF7v0N46IqryKJ978M2dZilc+k/HGsXWhfKpOIULHrDQld1cbhPySDZ7tZYdFX5tqZK0yrem3pvbJ8NR9zmZWbHkCCCbGUQrEbhSTGQnMj0+24qmc91Mu7zdC7XFgLLr6N0e1Pyv0L5xNbemFhCWnGGvjs7Qhq9/xOVx+VOer7gyMG+THlvobRwuGWS0b6sU2E9Tb4yLNXJauc53+nskgi70lvAbfsDgUNOFJEngSZ2dvE3rN3qxjgG4O6KN+snZZuI84IxR6kSZoJahap8mTVXxE+y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdOu1UegWPSzGF9P6NinvS7FvitIJruEvbDWHlyO8II=;
 b=VPfJijIfBylWJKSHk2Yjq+Kdsu1UhZT9fMTHdjqkbcYPZaBe7BNZ5XkTQWUrujWZN955hAu1dDOi1D0FV96k+BB8goVwWVQgjaeYx/hZtoVdaOgEVDXbLdMKBfMIqN3Ke/Ot2Js654YQw3ACSPz68D2XfG/Jfmtn3MrD7VcU+uXfaijPDvoXiAIE0hfH/kJicPMbwNvKJ2+8vopnvtHALS+kPgzU0sQkMuchY1GH4BXRv+3DWtkwXvK8/izG3FCTgCEY1Sht30JJ+L14QKUmI5Q2do+v3oaOsGSxRyJlDIEWa87fFuAkeKDUQZ+10R98yUD7h1Nt0nzZ5PcpFkL35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdOu1UegWPSzGF9P6NinvS7FvitIJruEvbDWHlyO8II=;
 b=ZAJgWBE00iRQ4fHG687L9GuJ2JRCYsUcZ3rr5dOnHe+iKMND+DlNRGu06M8RGWcP7h0TN0bNn6BgWbqN8iPKzb91O7LPgbodpBazCpqplBfI0EDi7b6ZaQRlILyP7F38qJfmAoBndLjSdOsI8tjVPv46H+BFsqtvULiYjXnmfXI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5666.namprd10.prod.outlook.com
 (2603:10b6:303:19b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 11:37:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 11:37:32 +0000
Date:   Fri, 15 Oct 2021 14:37:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] staging: r8188eu: Use completions instead of
 semaphores
Message-ID: <20211015113715.GR8429@kadam>
References: <20211015110238.1819-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015110238.1819-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 11:37:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59abcb76-004c-4113-4d87-08d98fd02d19
X-MS-TrafficTypeDiagnostic: MW5PR10MB5666:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW5PR10MB566646F62C578CC92B47EF158EB99@MW5PR10MB5666.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zxx55ifyIhW7pcdvU6OxXDqBTMLcLY5dRW2HTVYd5zXkAwEYT0cDDBxtI43s+yYFSDs9aorszC30xWle+uxe1oVu0WwL2ZDdQsic04ZMvpG1Ao0hoECh9XemluhfX8Xh2pFO3DOWP9mpu+fxiNDdN1wmElo4YZU4EOjLGcDU1PS+6be8RKc9pNYW21j3m54b3842DK4rk7n9LcLPWEYjBx16zQrY+hK6RVD/+1oiolzGOcxMLMqyvZs5LJUA0b79kyab87/K2KCry6qZTB5d3DhW+3rmWafVA2XpruP2lK7E0vc5XxihV5jwcSSuj2YJU+/P2P2P/F6d9QwRT+X7Xs6vyDF5L+pMLeOnff560GUxZGMRqMIknYiAn0E9WZ8YhVWbEqWIkHAEPGSOnaZMaLaIdY2uJXrxpI1nb/KIB5Kc6JV+iPrZbZGxsF/wOwxvY2NpXmhO3ODP4lUrhCj9eT0tuy6XFLJe19arxIBRaMvOhDQ0+MvM/0pOvw7jpwP4CUM2DfuI8L34mbNzMxeun8pcTxdnihM3zPqn9yPfqz3DLO4q5U0VdcYizPx5LPjuqQx5qJiuAC8ZNyV/dF1wNB5LjKxrTWcv/pc1CRGKrNwFWjVAuKsIgBk2TKMSNlJ/69Hq6ye6TGuXIyjjTq3Y+viQAmuTuG9uX3Ek5ySwoeULjRLSh2aTQRkaiNe60li+gxyRe8BhKCP8tGGlYAniRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(54906003)(9576002)(316002)(52116002)(86362001)(508600001)(6496006)(33656002)(26005)(5660300002)(8676002)(8936002)(6916009)(66476007)(66556008)(66946007)(186003)(33716001)(9686003)(83380400001)(956004)(6666004)(4326008)(44832011)(2906002)(38100700002)(38350700002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bp7u32ilD6u2524MEbOP27naFTqoOlOvum7LpLfMkWpodc8Zs0G8Dx6FkKxO?=
 =?us-ascii?Q?9kdoc1InYPZRg9Y0pbf3cx+HsbHxHFGi+zywqSyZDBW0Ov+Kk5nQAZlEoaNx?=
 =?us-ascii?Q?1w424E7JrP0BQU8VFA+ND/vfjQgevpj8fMHC3uwTgiPSJDBToqut5WQOjldt?=
 =?us-ascii?Q?auz8XC8YoiIxXt7D2nYmRteqW+ftiFpG+6gv12qaU7lW3VbW24Bs2jHvPKTX?=
 =?us-ascii?Q?c16M1LHtg44F/Jk6kW92WPYBeTW1XYASzYjfq4jU6ZHyjcdEIX7ejAiYveb6?=
 =?us-ascii?Q?NG0pcu7Osok9Adj+W50goJ2lt0P7eGbNpeQAeqiJAgNbnQic+uiDrj5qEV/2?=
 =?us-ascii?Q?OvFI2mCpQ3vbac8ZcexKhD9HXo8D34A1Uo5SOg97xmVR9Di+psxYNbOpJ2q+?=
 =?us-ascii?Q?aWWFwcou+1gT6oR32xpuYRG6d4tl7EUoP5c913DQLyhbFqWJ1w99dL0pjKKw?=
 =?us-ascii?Q?h5V+OOjPUHriaKq3dnA1Gb3IY/hnUwUBHkTYpkgUbkFJidIKu9eKVVOLxJGE?=
 =?us-ascii?Q?+8k2+4IShigdv9kfW1QX1kLFrMmfD6yve9gob/YjLwpMS8WvTgxhpX900pPk?=
 =?us-ascii?Q?8yt11VR9zw2pvj6WUVFdaECG+dvM+w7whUOwjGt86YdTVgH07HlLc1m1v9fl?=
 =?us-ascii?Q?g+bMdeNSEmgDN+w9RbwrAI+QJz4ZPnvQw7NFko1N+C905NEsDn/f2Y8nFePx?=
 =?us-ascii?Q?YIWWKC4pLaebXMxXS8j1uJ3e2SY4pml/jDUFpmkzme2jVXjHf5Ynb1B42d26?=
 =?us-ascii?Q?BV/2+ouU25zBKOGyz4d9rD0ZFVtIScwchqV93kBQ8riMu1cmKUh6sQdCNEf+?=
 =?us-ascii?Q?Qm5fFgG4ELuAnEDdshplx/oBrcVZCXZ6kd4qSqkgZwmm/oCsJKHQqWLe4o2U?=
 =?us-ascii?Q?wNFLrluS5/pqhNQ4qM7ob4Es4I9XCyjBNAlNVv5zD/jyEQWlFuVI3FxspgD7?=
 =?us-ascii?Q?c5w3svS/fsgClNxNQ10QvYeYrL+R358+ye7dN3rBHEdVPFjg0Avp5rQYGodl?=
 =?us-ascii?Q?BR0ZpBaSWc716xqGY2sDyjUvGV+x0aTCdGJGgdCYRRfGyVk55DssyRHeYaIv?=
 =?us-ascii?Q?iYmguRtkTQZaNWJwaoVscI0csAliXk3ycpWYv3yG1YlDHLlLEzyA5YTq7gkD?=
 =?us-ascii?Q?kRAeYx2w2uJkxXCvgUCLNh5o6J1CBHXgRoZAWbB6jAV6DNrfc5ygggP3zyg3?=
 =?us-ascii?Q?SDuXPepu6Ly+xUPNa4fhvkpiKmzbiFnhpUS3ugSKd0i2Hb5+l/P5KhiMG8Ia?=
 =?us-ascii?Q?A4ULPJEG8yJdYFXAEm3N4Ipnb3bKpWksZjF1cO1T6sZ39JZ3eOtdN2IdplqZ?=
 =?us-ascii?Q?LC1pG9ZgoKd3aB4WBj+oaVdv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59abcb76-004c-4113-4d87-08d98fd02d19
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 11:37:32.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAS1EXOpK4HCSflYTY3MDD1rbs080HAvwuMySe5hNa8lc9+Ll6gQy+tGvc/btJ3vbX7RbvUik+0x3abz8xVSjquPbU0FZJbkKTm/bRpin14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5666
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150070
X-Proofpoint-GUID: e9lWFI5xoH04AONEw5SzXOycwgm3b1vU
X-Proofpoint-ORIG-GUID: e9lWFI5xoH04AONEw5SzXOycwgm3b1vU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 01:02:38PM +0200, Fabio M. De Francesco wrote:
> rtw_cmd_thread() "up(s)" a semaphore twice, first to notify callers when
> its execution is started and then to notify when it is about to end.
> 
> It makes the same semaphore go "up" twice in the same thread. This
> construct makes Smatch to warn of duplicate "up(s)".
> 
> This thread uses interruptible semaphores where instead completions are
> more suitable. For this purpose it calls an helper (_rtw_down_sema())
> that returns values that are never checked. It may lead to bugs.
> 
> To address the above-mentioned issues, use two completions variables
> instead of semaphores. Use the uninterruptible versions of
> wake_for_completion*() because the interruptible / killable versions are
> not necessary.
> 
> Tested with "ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]".
> 
> This is an RFC patch because I'm not sure that changing this code
> from using semaphores to using completions variables is actually required.
> After all, the code was working properly with semaphores and, at the same
> time, I'm not sure if the Smatch warning about duplicate "up(s)" should
> actually be addressed.
> 
> I'm waiting for Maintainers and other Reviewers to say if this patch is
> actually needed and, if so, also for suggestions about how to improve
> it. In particular I'm interested to know what they think of using the
> uninterruptible version of wait_for_completion*().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

This is basically what Arnd did to rtl8723bs in commit:

commit 09a8ea34cf431bfb77159197e46753d101c528c5
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Dec 10 22:40:30 2018 +0100

    staging: rtl8723bs: change semaphores to completions

But there are some differences.  His patch is a little bit cleaner
because it gets rid of "pcmdpriv->cmd_queue_sema".  Could you basically
just ports Arnd's patch for this driver?

His patch goes quite a bit further as well, and change some other
semaphors but we could do it piece meal and just change the
rtw_cmd_thread() related ones.

regards,
dan carpenter

