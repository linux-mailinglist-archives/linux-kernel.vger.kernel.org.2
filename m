Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487A41DA40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351122AbhI3Mwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:52:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62914 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351051AbhI3Mwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:52:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UCYohW005826;
        Thu, 30 Sep 2021 12:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9/z9ggPtbHN6T4oIStkOSIQSaIMFojLLTqJceJ3+5TM=;
 b=mY4knPTWt1bdGTN+WEmTC6jFjVRR/p0DI/ZOug8vLSr1cjjLZbOww+e9/0+PL9bN7UM2
 dkI2VzeKCDv5pMKGAmLPw4lq9Kgtd4/w5wJEsQRahCr7g70Kx9wTDvW1AHX2RW4MptkM
 Wb5t/CHrAviAjD+7g6tYhtJ6smrc9p1tsbe2Xw2fkB3jE5NAQyoRAkG6y6qmpo1GwrRF
 tyoWbkqVnudSQMV/fGMlJsBJJf8SHBpndERE9q4mKD+rI1Nu/aK/MiZaCmm8o1sN3PDb
 bqnJm7oPEqQPQBz9PZH5PlyvWzoGvWZwDPaIDsLASWCcKd9i7ousmKcgjKhThIYkbtxL sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6d317q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:50:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UCeqlg030424;
        Thu, 30 Sep 2021 12:49:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3030.oracle.com with ESMTP id 3bc3bmh8hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPj939XChh5PcZm4lNai1jz3w8lCHGwIOMT/jpXpIPVZJ8CRbUP64NkWXhgrU1GNfdxHglfBHMJhZ3olHwJu/NKhIk7FuUIiDIsBNrEjkMuZn0OHLymHQEE+8yPDBF2qX/OCzrhpZCPYw+NayPQW+LkMwMsRVuqu+cqxGD4/s9QKOM2I8u5XvYEHdOMqLw8BdGqY0Qbg3sBxgJWR1K6Bux2zPnz7HcuY+LpMbTwumB7mJnpv3L4JX0pxPEJLERCHcqSFeA/xAE+VUdhJnD1sYYFVYJWL7kM6qteuICt+JH5kvz3PCYCgccgF2wvb3lxk7Hdet80FZqyliE7iJhWdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9/z9ggPtbHN6T4oIStkOSIQSaIMFojLLTqJceJ3+5TM=;
 b=DCClvFgGN+euo5+IY7a/SATalT8Lm6c00A5hA3IMieB3Xd+zktp1/09nuqawiK6ircLynu8ueu0NEOJtqMd4ItnK2Aw5gTBQ3zync+QJH0cSNC8sj3RntXNPket4VB5j2e379buvZ7pSyoll83NihL6VY22azceotjJHv/ufSwSB6OUmuNv1xr0Q+cQZXDUWbqkFHMhfVQuMCXxWCzjkaRsFRxahlgxfuB8ZxyiAtIC6J6sKnrgiKg6ymv9xaFeloKmZReQyxWyQbePvgXWLC5Vtu1yKsP1ZhQVlFFn7SkxLP7qjnlqcaIv0MJu5ihXdpPsuqRUeJTv0MDkRDftzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/z9ggPtbHN6T4oIStkOSIQSaIMFojLLTqJceJ3+5TM=;
 b=Wx2ldoARPfQbR2fXBL0QIi8H5mBNhFx5d829dii5UWvq6eQIVUk3NXqAu8LX+ABZK0y6ezbd9EL+hZUYfn23A2Q8c0wYISrhh/o1Hl3K6uVE2tFnZ5ZAJ63RpqY2PFR5VtBhCgrrWJpys6Z52p/AKo2695hBBg23K494x9M+VCU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1488.namprd10.prod.outlook.com
 (2603:10b6:300:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 12:49:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 12:49:22 +0000
Date:   Thu, 30 Sep 2021 15:49:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dawid Esterhuizen <desterhuizen@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: Statements should start on a tabstop
Message-ID: <20210930124904.GP2048@kadam>
References: <YVWtJDOVInwQoHss@kkobus.whirley.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVWtJDOVInwQoHss@kkobus.whirley.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (41.210.159.27) by JNAP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Thu, 30 Sep 2021 12:49:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 370aef54-b548-40f0-f296-08d98410ba02
X-MS-TrafficTypeDiagnostic: MWHPR10MB1488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB14886578C62C25980D2293C78EAA9@MWHPR10MB1488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJ4zhJ6sCHCl6dMHL6RzQ01Uh8d4xQnJUunq8vSTp/pIyCvkrXZ6QV7+nZ/hsSk5knWh2OPZwjbMrV8A3P2HYaD5I4+SXrh8/U60ZRp4SSwhC6+44O2E6+pt3SR9L3ukhwbdOHgydX44KbOjMYcpy+0+vAL34V8ru8D1Qg29BXyhoxjhwAx5j9b5bFBNm/vv5VaZkswKoYHlDkydCZggkb0YUAoXMqn9P/HLSORKx6rJfPHDu7AZQRhJ0PtioWTkS+vAf5f9NBrX4RHryCkhmyPCUD+WBS9IeTt3nHtWl46sEF5SmYlixNDA0eGdRrIYa/FczRb8ziIJntk3Vcr59YJstyiTVkuTdFCSF0dQWWSlL6wX7MHb0+YaI8eEsTQEYfIM2fpf0BJOzGAThtRSJz96i/zx5UAOqffm29XBTYVhwAXuZIAKj76XUoFtXT3j6GJUPeABENMMYjuXzheb1AUEyb67RFgcxz2w3dflB0Q0LghiJdn+vK2fS7645VBBSYfivdOoETizhh7m5tfwDCkAXlaXoMcNy2h+QOFb5sG5vemB0K621Mj+RjO5eA8MzPvGx+ns39v5h9Gjj4LPnSBjHHl4oRSsmOgfaMiKxpGh3vF93gxW5VQi/fQI4VapgYsMkzDi1mXp0A74uERY1VQWkGOhaIGm22D/y+3ljnX617CQ9Yo8FiIMuB3qeVpgJ4c6Vy6tlw2JS6ZizHChtjz8vewQIBusgqzd6ozBDWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(1076003)(38350700002)(4744005)(8936002)(52116002)(8676002)(6916009)(6496006)(6666004)(508600001)(5001810100001)(9576002)(316002)(54906003)(83380400001)(38100700002)(26005)(86362001)(66946007)(2906002)(9686003)(66476007)(4326008)(33656002)(66556008)(33716001)(55016002)(186003)(44832011)(956004)(5716013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUlSpeLCManwzVUGSBT21lAS+abcaxLHEHUHhhPmlOkwuP2WZvqaPMFIoj3W?=
 =?us-ascii?Q?8lkEvPOJ/zVqzuWmdXLwkKbFc+K/llo7RbTAq4YpJxbAfhthzlz+mDoWiexk?=
 =?us-ascii?Q?zYYqtaCfqK5HKtS8ajwYiIsQcg8AazoofFf7j6BR8rOWKeWQxj1hGLCMmq8h?=
 =?us-ascii?Q?/tOwKwcWp/zwqqbuE6rgQihFZDxu18KPKrhhJQgAv4neAvteQzKflwWlgoYc?=
 =?us-ascii?Q?/tdYCGxFU9Xw8iw/j0wpN3rQYylSrLMNTb9qnZcLMGUq3YNdhOilD44hx+Vc?=
 =?us-ascii?Q?Abp/ZAGQjEpv5MvcLYPl8dQ4AeFhZpTF8DX6I2B+i6ss2i1Q38hpat33LuoE?=
 =?us-ascii?Q?qZjao6aOpd7mxfc2dM9VP6MxC1wDkRb2c7pvll/YqyHtEkDk6tdsRfJmIdeK?=
 =?us-ascii?Q?hTS+tux6JgBoiCWzfyiZ5168fVHAzAAI/A4g2waFU3I5yHu8hjlY5/eoahIl?=
 =?us-ascii?Q?LXmpOl3VFLFHhlZsOpg0FreU5M3gY1mKRZg4IfeksLCjevC7KzZ1aFs//tyH?=
 =?us-ascii?Q?8KI4hILJgHPsOIJHLMJYEaTHT89HWLMIPSH2oYDS1TARNEKeblkgqo/j23Jb?=
 =?us-ascii?Q?4o3wMCjgjPTdNR/am7j/ZP7H3PRbQVAIwTWemfD2mBKeo1QVRFKG0C+IOVqG?=
 =?us-ascii?Q?NwHBqrVXtMkLl1R3MPwHgfkMSIw+U7Xw78uEGiRWWCnbVetcfZ5L3P2EakuF?=
 =?us-ascii?Q?7wRBLhOIof6dp9q3omoykPbg/WCANcz6i24IM2rLNuUs8kJa7QiCuU/D/Sx7?=
 =?us-ascii?Q?wcCcxQKgmV9n07XrYbRBTdH/RG84qrHGtJ0iyC5MRVMWKQdBkyGH4x4Np4wb?=
 =?us-ascii?Q?h0JN9Pu9VNknUfjVgk0vfOh7VyOpdiJ5KYI6eLLJY5AU+GdwxbbwdnlUxcgy?=
 =?us-ascii?Q?ywrnhnSZywdnRNcCrXXHNQc29I7T03iWPS9i5cGxdr4/pnCIZDNSdgGoYCC7?=
 =?us-ascii?Q?gp4U2jqJI/9JUIyHUh/LQDTCWbY0EjeidgcSk34VPg4DFBTPEjiVcVXM+eGR?=
 =?us-ascii?Q?Pq00pvdlEqVNIqQa3MWS0qeD2zimqAbbA7Q25lemaFjZTF7CnwwKtnPhaeFc?=
 =?us-ascii?Q?Axbu0CKTeYQe46IsBR+PrYk/CMoacoiax8u0jEM32aPETHCQOpFX+N/OfMMd?=
 =?us-ascii?Q?cScG4dcyDaobRFGqRFi/dfFTc/6gIx/Osa1neQcMPFayFiFHc/MdDiS2OmIp?=
 =?us-ascii?Q?V9WFAiqj8Hff0Kq10OqQ2QELH9PWE3oZNE6erCzlX2bYwjAqvKLziFOaet8y?=
 =?us-ascii?Q?m2d2KKdC/1BCPfz7zntDyzIvpLi+dvPADeG26QOKEBd7fyKMsemPaT3r8iYC?=
 =?us-ascii?Q?qDMiTxeYRPcKevMmRjhF+5X+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370aef54-b548-40f0-f296-08d98410ba02
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 12:49:22.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NK8kyU60+yS7eKLn8K8r1pIoYX7xteMwhMxqzhCwTVIK6ABwUw5Hpf8GIst46cjS/F3717ypkbLxKvty5yhXKctCLD4v9ezIMobPoqoipF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=998 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300080
X-Proofpoint-GUID: dMN0thQMD1DsSf3ks6mcWr4qcBna7WOY
X-Proofpoint-ORIG-GUID: dMN0thQMD1DsSf3ks6mcWr4qcBna7WOY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:27:16PM +0200, Dawid Esterhuizen wrote:
> This path fixes four checkpatch.pl warnings:
> 
> Statements should start on a tabstop
> 
> Changes since v1:
> 	- Removed the volatile comments as they served no purpose
> 	- Fixed the styling with corrected spacing as per checkpatch.pl
>         for easier reading

This part goes under the --- cut off line

> 
> Signed-off-by: Dawid Esterhuizen <desterhuizen@gmail.com>
> ---
  ^^^
here.

Please send v3.  ;)

regards,
dan carpenter

