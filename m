Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1388C3FB78F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhH3OKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:10:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18712 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhH3OKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:10:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UE4HQT005141;
        Mon, 30 Aug 2021 14:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wNdvRMCc7orn/20DEeCbZIdJh7pnbJVUCcHYK761M5U=;
 b=xZb0MwJ0WJLl6MhgF6ho1GL7sp5g+8EHOusmE2ZdCYmvRcL9Vfmh1E+JSuEkixiNJUoG
 Z8PLM3FOY2oVRvruEtwgqsRznr7JmgGH7XFnyPuXRx6cfGmJo8HBInCR68XtGDJNHemA
 L/rnHWILXStyQJGM40V6w3F30m+Rprnj4AJcE92JZmBb4VzBFvNHCA/zyhJwsClcTTYP
 GD7pxVdVZNgnwUjrAGHIBo/mmALu7z09kKCD0fEYNd18YGDBQTU0ttRiZ/ypQuTWG1I2
 mziW0mUHyKXi/Bj/UaGkOXZPBpsr93H0qiSFXViYKtVsKWaQ5VlSKOJfYBQreDu9+DLm xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=wNdvRMCc7orn/20DEeCbZIdJh7pnbJVUCcHYK761M5U=;
 b=yBuCfCmoNJLcmLGFsHwbiUVdINMQNhkuZwsEtzAl8Wnk08ZfMyV8vytNiJ2OrI+EFYBY
 KoUmerm3NhoISujitUcIOve66Uu4NArpGGtQ/mjc+r1GfvR4Q9mgtnjVF/udDINSsBxV
 ok3BElcn0Islbl7VcYlf6plaNbtyU9T2JdIJ9O+0YBxQxvCz/fVRpDLBM7MgRH02vh9/
 j7sRr49oFeGgEfYa76tKqljr9gdv4RcK/TqA5obUciJqG4q5N3ZpGn0AGr0Zs+kOjQz4
 5DBhuJZlnjK/4sdpEtKZYhRfcEhQkeB8CtzxXk2Z+qTvy3ECD8tRG+M+Ltb2m7JiF6dO jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbymhmb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 14:09:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UE5lQA073774;
        Mon, 30 Aug 2021 14:09:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3aqb6c0g3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 14:09:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFUjmL+LC4X6E3jCWedokMQNQKTaCygvFOxO+F4drjZwlwL+KldFYpbOfU8O3HCpuhia6ziGNjwscXMJzjr2l3BEOjBOEMoKcxfJk4+fnPTnEidrR78+MF7XHI04XOHl0rfz29XQz7wIypuCQrSKYVCsoijzgrJHu4hjzZUePi3IlN2SKAVGG3htwNwdWM3cDq0oWj3fhel1Co0zAH9S/Z4zOBrny25OqZndIUGgCnxZuvmKe1e8X1iCXtusxhrt0uvTA0DsPUfIT5UuQqroPevL5fLE90FSAgfxfn98t1XsK32Igqut4zhjUu/W57Od7gBJho+SSXDkxZV4WfcyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNdvRMCc7orn/20DEeCbZIdJh7pnbJVUCcHYK761M5U=;
 b=QWEXKVmUB6VA6tgwEy3qA9r3Ha9p5kMoRrxU/5wKyp/5NHxH0PnXVk1P9qVn0JwNIAhRxPGymJpWu+fNFtUU4Sz8SpXx2UzZc06ZGXuXtY0mTui8762AUkrxsj7PZHscdnpgWNOCw6okavBT6VAvXHXKTgwRpHibYARiAEnZe2u8ijMW42qVJBKC1AkSwd6ETHCzt4Yg9Xet93LLuifZ33CERVBWF9RrNphvfsNcyfzcC1pQz5qJDnOyn2LKUDM7eXYQksLEGUk1VgjCdkAnB+yfpq9SM2pL4PYyd2XgQZJVzDBrIbt1VsNW1jnIejSUVPlN9xQGL4tCvItWZSzbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNdvRMCc7orn/20DEeCbZIdJh7pnbJVUCcHYK761M5U=;
 b=tbiIgO2wsDP8FC4DMvgmNuNHkCzE6njzc13PgSy4MSpHMoIK1cR7G5viEgjf1zFyaFGN0SA0LOKXaIZdZuaDOuq14TjUn7k0pcFMbWspdkLfSE5x7ap1d7K9XqCuzq201awwVe68zxuJDJCda0vL2+jjax2aoDBGkjCyl/IaYv4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 14:09:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 14:09:12 +0000
Date:   Mon, 30 Aug 2021 17:08:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Werner <andreas.werner@men.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mcb: fix error handling in mcb_alloc_bus()
Message-ID: <20210830140856.GX7722@kadam>
References: <YLX7bAD4UPCpIBmq@mwanda>
 <c4cffc84-be11-6558-60aa-a5217963b1f6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cffc84-be11-6558-60aa-a5217963b1f6@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Mon, 30 Aug 2021 14:09:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d910575a-2add-46b2-3bc9-08d96bbfbddf
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45131AEE0EF01182D18A9A9D8ECB9@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQFbGCz/BYsrlPasaEh4RR5EXnkBI88tJJPZ3Wxd8lbD/xueLKWVtrdUbrJSOLGA6cV/hTeWAeLmrpmgxH4ND2aaGpb4w/fp5cbKt5tQ7fVDAd7XAmNDUrFJ4hFRJMfiZWpnUwHNMU4bl1upcKJn11DclnEGwCSHk0EChRERGlanAKFcozoR+9Pfcq4gGCY5fSxeoij00fbQCj7+n+sFB2QxGur2tw2A7iapqGpbJAQO6pC+lnJ5mXXyuXd/cgmwNFC1O0miz1sOtvur1PhiJrP71HX5Tp/R+E6dm73jkbV5KiXpuIHOvxiK3quLq8EzWo96n5aGT0Etu4qv2tUzANyZXFPv2ToRh5imFZcXRyRQAPJOnr8LQxj4yY0INjCHxYjaVcyEX1Ij3GgNK5k6gUnWVnlppTN/CDZA1KuavSyEpS527hVnrRro9Of0yHVUfL88fTiVlaaG0+SZ3ejCM8i4ENEE+mjkGkyfYxPsJBcysmIJgW89tMizKqivdR4snMhHH6hONT6t8DKnFFWv9rYxkt9iGvjxruHK6Q1o3b0WokTsw7n4K8vdwxz23LDOQUiiix2sDKxxZYPEzXPcMe8FZm3x8YtBpYH/4TyFKQs1c+HIt8JbC4qjSrIVZYYIzI2zKI0/B1Vjf7FpdfdModNB/0WMPUEHCoGRd9fo2Qz0R94I+/K8qkMHCCeyX64gylofInc9rzlKzqY+sZ433w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(1076003)(9686003)(5660300002)(6916009)(38350700002)(4744005)(8936002)(33716001)(33656002)(66476007)(26005)(86362001)(478600001)(956004)(9576002)(6496006)(54906003)(2906002)(66946007)(316002)(4326008)(186003)(55016002)(38100700002)(8676002)(6666004)(66556008)(52116002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hG/oGoyNSrVEX4Kk/xCPPcSxnefNcZ/bmxsOWaWOhZGxv98ddJA3J7txCGeR?=
 =?us-ascii?Q?I9NIYgUfzDMwW18b5+jMjEBLzVojoyNcogkB0ktOdeiDoe6sErRgDSIwesGx?=
 =?us-ascii?Q?+/Kaj2d9GYK6xrJDvwGfr1bm45ZWlZvX/isPXKsahpiRzL9T3D1KeFsAgMus?=
 =?us-ascii?Q?NvWGCSeADjF/8uPmEtOTu9LAEhMCG0vVcp2ayYNHLrc0deYvA+hj5WQjrUHV?=
 =?us-ascii?Q?hjvHSo9/8xJ0Nfa4Q1O25Oj4TZLo+xNTRXB1Dn23wjQfCnwGLDqiRORacq/h?=
 =?us-ascii?Q?5lMjyUk5SL/xayPHh6UVrhWnp6KJ/UOyMeiuGdPR577Lc1JHm0WD6kaiWUUv?=
 =?us-ascii?Q?uWwSC7h5K61AuNIUs6aOO/a6FvnuTUx2jPqHxYnvEFBK2dK9+XK7iXdaV5FX?=
 =?us-ascii?Q?QvsWlEn/tWwHWQYgqNXI4Au3NFPfRfrV/lLcaQd3p592uIvzuzLKVD4qAytv?=
 =?us-ascii?Q?jjkgsaUmSyunz8/FDp/w5TV8sIgcPCpGZxz32cIYbNc/8kXoTBC7TCcVAcb/?=
 =?us-ascii?Q?u5L7xAqpYNSD6bdHKlRBcJTTvbpDD2SOU0rh7wuyeW4Y6npSHteht/i7jRmU?=
 =?us-ascii?Q?q55pqm8MZKzuYdlp0aNCX0WuLijkwuCwzHL5UDOelD+UzMQ6mf/Gtg9S3XUo?=
 =?us-ascii?Q?5FxDDN/Vj23Xe74iUi75yWpa9U4PHlJpDdqzvqXeYVZ4BmcT5/ra/imZ+ZRT?=
 =?us-ascii?Q?/mzOqZt8wJqWwJzT9cCeBAhl4nvFTdIaVSiFrF1YVIOrqYj19oo6nGVNgmqo?=
 =?us-ascii?Q?NIPJzGM33tFmZLTE1csC/ZxBiuKspHgmnty4NlAJG3OIfbPNP01oJwIGI94D?=
 =?us-ascii?Q?tIpfueGidRextZcx7Dd5b/j0hkDo5Bn3/w0rOnPNwqnnsJuOGxNfZOk8+xM1?=
 =?us-ascii?Q?IAkraQv0EviD0TfKNwlSODb33+w2VhSa/658bo1MD9U6PVQmA09pCnqgZ9Y4?=
 =?us-ascii?Q?soUlV5q/4ghPtMmbGl7lPtNPH+xK5MpxoOwGmj7N8ynE/Q0G/LX/q8FcvjBf?=
 =?us-ascii?Q?wB28iO0OQ1q2uFq8V/UBmym6mg9TAPOSo/OfwybjuSlv3+Sh8/9AvGH8bx1+?=
 =?us-ascii?Q?cZEplRpb/6ptcwBEWNk1j0mHpsNddE4wiXZC3SfRh1VB6rhclbE2NZPM1R2v?=
 =?us-ascii?Q?ugjl/4TasKH7PEyoVN/0ZA43+EgS9d1GhSVAbAr6zZ7SHJ2lPwHKJyP53hfo?=
 =?us-ascii?Q?EaEHGoDYA9oILPA2khJM2KNlOpaNSTgvaSrIxTDcU1Jj5OZDKxUxXMeKcEml?=
 =?us-ascii?Q?QJ/nsQEyocYelIlmPpCjEA9Iji+nEjx7cwn4c0VCkko5tW45kTmZG5XEwpWO?=
 =?us-ascii?Q?3b8ihuYk32r3NzlmGMdoarYQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d910575a-2add-46b2-3bc9-08d96bbfbddf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 14:09:12.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKWbyUD3c439Fy8cySxtS6T5d78RxSpN4N3pN6JzWpbRpc3BcuQ5Y4q375QacswuCuUrZBzGYFUS6lEWdZOh2n8QI8lQtdS4UR5QIWwUgy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300100
X-Proofpoint-ORIG-GUID: Qo21ltgkyc00R7CPKkiCkDW473e5IBxj
X-Proofpoint-GUID: Qo21ltgkyc00R7CPKkiCkDW473e5IBxj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 03:23:55PM +0200, Johannes Thumshirn wrote:
> 
> 
> Am 01.06.21 um 11:18 schrieb Dan Carpenter:
> > There are two bugs:
> > 1) If ida_simple_get() fails then this code calls put_device(carrier)
> >    but we haven't yet called get_device(carrier) and probably that
> >    leads to a use after free.
> > 2) After device_initialize() then we need to use put_device() to
> >    release the bus.  This will free the internal resources tied to the
> >    device and call mcb_free_bus() which will free the rest.
> >
> > Fixes: 5d9e2ab9fea4 ("mcb: Implement bus->dev.release callback")
> > Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> 
> Thanks applied

This is still not in linux-next.

regards,
dan carpenter
