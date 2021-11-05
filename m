Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD194465DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhKEPj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:39:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61900 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233464AbhKEPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:39:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5EYg2E000597;
        Fri, 5 Nov 2021 15:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=pBfaWp3W9qqdPWoaP/nlorPGwsr0v9Y9dZKAZu0gvN0=;
 b=hiWMeIizALnfVpIeF57VyRG4d4yDUi3rbMgZ1VkltUsnDlWyf7olnkGg8/8HudAE/kZm
 INl+NGVUI/XHuoUIf4AgaiCR4dlc61brjPeYz85ST+jafl8wIxOgxbjuywudAS72NzHT
 DRhydPrUJwwmz+jE6UNSZSlmzELLgspeyuKvmoqGH/Ezy6QdaP2VgIfCSf4xjiSAycn/
 qM/xq5KCn6Z7zCjoRnLr9iXBIBX+NOwngoAhUfmho/GYRTsHitD7+jF1TRrIcX9j6r43
 3cZwGc4j2jJbHKSHxa58ZjMmKSouqem6WLsanPCM74jQmLJTIeb9bJEwT0SoW2yW2KBf cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7hu9bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 15:37:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A5Fa252066498;
        Fri, 5 Nov 2021 15:36:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3020.oracle.com with ESMTP id 3c4t5shggv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 15:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boGtBqyVDesrQ0vcA1EwcLGPXleXsz2LbGgVvKgJmRQqF8Ilag0A1dyVqWKIULBg2ic9iIh+E74Bc3HRm4mSWM5cCADCb004SqVdQAi1Jh8hJmt9Fgq+fssvvkytBO+kJEeJ/Nqi0tQlfbFYsnbLCTGPIhoQiCUq11djXsWMeKP39rYqcNo0GxD+WaCCGRFtkH6YMjDDeTPPz4uxZQdEpQbA1+bflCTX4D/BlGPwyoEAFzcy/1f1dzzVQ+3i8Kwkyz0zS+Od0/bU6mHVkkQLaipA6bXrWwkQfWI7YMfoiqHuoSIpfE0MVQOJeJT7AyXTQcKuKK9DkCHXAcWgTVCA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBfaWp3W9qqdPWoaP/nlorPGwsr0v9Y9dZKAZu0gvN0=;
 b=LE+iWexpei7HR7klrcoo7Qji/d8TkGDb0diWPnwpYRXdp6sImUBfGFVjTEw3klMkV5Sli/GAMZ8UC9FfXDtpAXhzg8oPiAmAg8n91wRe14/1gXply0TX49AAblxz75prUf69UzHavgQwfvc8T2egwuhlgCKLk5IRJJI0iqWD+pxxXfO5Zi/lUPZBAmU+miVpUhN+0nYfG4aiEE7g4CJXldTO1gFK5tlX5vYmblq16zXEQdSf++OznSrTl2LBaPku+V+jgrTHV7y8zHzgCY+JAsGyRsISrifccWYfe1PBnrgqzhQOhH0t3XkrfGh2FFtQQyUo5KJZEzPJtpvEG2UwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBfaWp3W9qqdPWoaP/nlorPGwsr0v9Y9dZKAZu0gvN0=;
 b=uKvePoHSY+WG9x6lbWYu+bmL4HyUSbt+7waYTcEDp8P4EaoFPL5gDZb431tgku6RgpdswKQ/afS/U9bh8Gkik1CSZZf+VU8xGQxiQciybBbLQf2Ed35vycFcWimiiaYrpsS3FnKrW4vc1He2+P8OCaaLbGWrqKwZNB9i+JulokE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2093.namprd10.prod.outlook.com
 (2603:10b6:301:36::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 15:36:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 15:36:54 +0000
Date:   Fri, 5 Nov 2021 18:36:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in
 atomic context
Message-ID: <20211105153633.GD2026@kadam>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com>
 <20211105132551.GB2001@kadam>
 <3198013.HnMX8GfXRX@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3198013.HnMX8GfXRX@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19 via Frontend Transport; Fri, 5 Nov 2021 15:36:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 767e8546-cb56-4e13-b82c-08d9a07217ff
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2093:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB209391A8FEAB73D4D4C5213F8E8E9@MWHPR1001MB2093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWnSjT1SN0DGIArFIGGLW9dqZV6ItcVwu3qNPZSO0cl3qa4C6vxjQDkxMSyxLm5Cz3oi5PFPiY7PKGbDvQ9XhYW6c6r+i+zIZixNGMJNTzlzYAs8dMkxl86sTif8qkAGKZdzXHahFJOGX+Cs3q/FnTqLlyxpl4HCV+sRNZjeq3jrsODoVq42ko4ZGb9tCLYic1jJsomrKVJS/lRoOY4UUTEimS+UuIh0e/hLWlKo0cFYIHkQmm+LNG4geaYR6/xlvz5hI6cyalWDRDxrtz3AcwYQAA95+14jrHFZIcvwVIIrv35gTRTr6HbqaU2JF5JYGkjXpsqWL2loZetM/YDxXdj/yWZuSTare5AiTani4MFQJsdh9hKk4kJKShjDcQeNCfV9tTzUzC1DOu1QlZYeglrht/XmhONljHk2K0lwy5DbeetnkZ6G2AgysFtGToEgrRE3sAKXyJRinIX2zfuSkYUXDNxZrLcTQqV6NxBUtWAEhDOcygzvOapSt+L+KQlf2JsO/91BA5CGNfhvEgKFqCDi7UJyhqhX9DOPmNwfd6HV0NVBaRcRfWBp7K+Pungs/SSstxkbShXwRh3OBTkLZvfRG8Ho18D7NFv4b+PQGJ0WC5QnLSZWz4v7iWe9njprTk74/5CjXo3oWo4KsAP4xzWG/IfR79gdGVBwycvL5tqjKE4H2MKtqX1mMFfvyLDO+STlPS4Pk4RZhuO/tY3M1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(6666004)(316002)(9576002)(26005)(9686003)(8936002)(186003)(8676002)(508600001)(4326008)(86362001)(44832011)(33656002)(956004)(6496006)(6916009)(2906002)(52116002)(5660300002)(66946007)(66476007)(66556008)(38350700002)(38100700002)(33716001)(1076003)(83380400001)(4744005)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51wrnnqBe6HWsWTLWuPzuPGOwmd9/BQ5enkkIwBCQvZ9ywWFwtye/g5Q5fqA?=
 =?us-ascii?Q?u4B03KJVcmIX7nqEzoJekcU4qRcZfrBgTxDjJwtABzI79a5FT4NASmg0sIsf?=
 =?us-ascii?Q?eNmZ1PJxEbPhDIbDYR20tqPFXk34EUKAOx/xT/foDviU85VPRBsPne9vVrXA?=
 =?us-ascii?Q?4AnXmfDiSh0c+uybsWPICHH+LpS6DcGst1FDqVdOcfvs1snNcqX16bQ1zGUg?=
 =?us-ascii?Q?7A0uPtNv+X/xZHGejVBteFOO1778i9uOlkLwij9QHXlTK17Eza5FfWsQCc7C?=
 =?us-ascii?Q?GoMfar3jVF4tCK8SWNukcDPMsH2VHAjU0lM0hJ9gEoTV197UJtsfLKDt8t0z?=
 =?us-ascii?Q?fo4yYmhVZ/w7wslftn/tra5Vk4KQaqB1byjC9YG76sdfsHPMDw0wKtegA5Jc?=
 =?us-ascii?Q?DbReL6RWOYfIbiLGMSgmlI5rCyJn8G++LA7vpxDq9sa1JvJ/w9iXgJ75GOmO?=
 =?us-ascii?Q?4v9HpY07sjxkqchiir2JLCrHTjTKVjy2HXvzN9T4gQY0t6Qzwa2Pb5eJiUKr?=
 =?us-ascii?Q?hXw2GSKuXQn3SHoPLKXGrwL9y4NRjpuI3rKnzXDcNChHNSFh8JWqnQoihIxq?=
 =?us-ascii?Q?fD1uBaK+YJVjNEeBN6d98SHzodOb1/V3xPC91/GK6o5ZextiXf8ziHAev8ku?=
 =?us-ascii?Q?Tqg4ZeKqH7HeAMAGU7gHaHqR6o55Nqi9BUL8y0nZRvy9UT3JMOaYkGCITtbD?=
 =?us-ascii?Q?FugQp5v3T471PQW8HcNRW8cyvHgMq4KLzC3jrn35fp8SZxufEyxMz3Fu4iNo?=
 =?us-ascii?Q?lvpKMKYhWCrArVYfAHeLY5dmRRm9b/2YDntlCQy3fgHdy9V/gW5ZCJiPvWVU?=
 =?us-ascii?Q?nVIr+iIoVGQW5a2uebw8/yW0ulsHcKxR1WNnA/XPk22481NvgmMFvlqip3WB?=
 =?us-ascii?Q?w5WQiwGhjsnsmKj6B1Gzs+UNXDDrB+OAiQA3QA3oszhaSvvEUj1/7iXd2ou6?=
 =?us-ascii?Q?ATjvvp7uFBRUnyUgBT5++2WRCktfhHL5s04pbMqvrE5mKyejDbOBOhvAWxYP?=
 =?us-ascii?Q?MZrXSZNPr5/y5DvSEVGuUeMIpNG9vGXpZ9cu8Or+OtOGfTUdXHlWgKlwgm/D?=
 =?us-ascii?Q?FpbmkPEJsK/Rrb8gFQ3eOSY1b71pa/jhwKAaX8zYun8UV4rKmRtv+GZF0ao6?=
 =?us-ascii?Q?8X/VycvF5MIFgKQCP4qOjUmDUOM4PeNjfEO7YxOUvKm/s6jWjDxOnlV/aWM1?=
 =?us-ascii?Q?z8FJ4mcx9XUxzhTDsYyRjm6WOKTPdTgjTEZanbYygCLPHAswBPR/QiKvRyZv?=
 =?us-ascii?Q?NljpLCERLeuvWh84UZdOf5aJWtabTdlQJ+iyTvunnjFoVaQ3l8HO69wcZVKR?=
 =?us-ascii?Q?U4GomRcFTrelRbUsuQbFQ6+ZWPzyDLcmpDSv2wHbNZDl7MrGtugVxRt0677w?=
 =?us-ascii?Q?p7a4UFtafqUjA2vMo8CpHuQwVglrcBjBgMeR0ZuFzLu/xkl1BS6mx4WK5QU8?=
 =?us-ascii?Q?ufxJnnHcIHhxWyz1+m8MHRqlPx4ppoJE4pa48YWflpLtRcxTBEQMJwy3cYe/?=
 =?us-ascii?Q?o+WYNIEtZAAHIzcoubZfzjUNaaFq8a2MS5X/lshvBX6UXUVNLW3XOwYFrJNy?=
 =?us-ascii?Q?n6dC3xXGptWoPKjxzBL6GeGXaAxzSCx46eaSE3bIuRqbvI+uKaDFyeTnxeXZ?=
 =?us-ascii?Q?0m5pAF4TzsfcVo0Z4iolfRG++lzK4PqekK5+qXAmfhR8py4M3XQ99Jc4+eC6?=
 =?us-ascii?Q?Kx1pyR8e8+ESrwrhqjPXBDjsnnE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767e8546-cb56-4e13-b82c-08d9a07217ff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 15:36:54.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0zkjwm7V4wuDwDwYlrEK27++J14A8VvAnvTiCFDfiStq8IliL+6DJmibtUeEfz825WFlBr0fabpWgJ0KYi0gYQrVQ81PT25RhVyg5YH/3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2093
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10159 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=591 suspectscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050089
X-Proofpoint-GUID: K4wDWpkGBZbV9i3OSri7fqYrUPBmFZDL
X-Proofpoint-ORIG-GUID: K4wDWpkGBZbV9i3OSri7fqYrUPBmFZDL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh yeah, you're right.  It never *just* does spinlocks (as stated in the
commit message btw), it does spin_lock_bh() which bumps the soft IRQ
count.

> To summarize, I think that using in_interrupt() in the old wrappers was the 
> wiser choice.

"Wiser" is not the right word.  The wrappers were always stupid, but I
guess they did work in this case so the fixes tag is correct.

regards,
dan carpenter

