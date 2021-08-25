Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972CC3F7196
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhHYJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:20:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11864 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233932AbhHYJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:20:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P92kkE000915;
        Wed, 25 Aug 2021 09:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jWy/ij4NN4BkpNuBjTJ2cbtC69ltqfSHKxKionwHTjA=;
 b=JkAEoeA+4ETzTqK37B8DimXre9hlw9ZVDUKAf5zfhD3esFgZlzEA+6ZiP31bRWxpZDcp
 v1LFoc/6nZYOxgN9pqGdtrV1T/sMCyHv68oR5ElpQ5/UFBE7K9KQqWf0NpaUn2VSkzsB
 /ZUYVbBRnaJpu/5oOr24NP6gURUYl1jPvOecMP1FlUO7NNACVC8M/a+/+mePz9aWE4u5
 PuJ+BAeQ3bOPT7uuefQUdyrwvxqu4kBQrdz3HG0wW/VN+5r0oryvZIVu3My3COA484OP
 KGLTZT6c7A4+rbzCcNcdl7HUjXH3DIo4CWz10gbEwVGgYrK9pTZb7RzoUe3d+xvT4LJM 5Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=jWy/ij4NN4BkpNuBjTJ2cbtC69ltqfSHKxKionwHTjA=;
 b=uAP7O75Z7a3yrUCAHwbxs3uU06a3/tJ6uqTP2NBMSKb+cZrt9RYLn0CQUNSaZUmseU39
 Hcc2Qfzi/JPDkWqj8Eb1oUtBestzV0O2p1WJqCsvGM9NLSQIpj8HbS3SSEhii6ndqbcY
 QQEIr9XSRydoOCjozXHLSOiswu/qlqonIyKr+zgqDrrogMQ04UlGYOA6yWa6k0Zhj9sv
 EEsAmcTbW5I/EbsJD0oILSgNpvvhb/Co7iOZQVwpHpF/ui4FkS12aeELlR95HsyHy5XP
 h7EikAsx88Y5He6u17bgbr7Kh6vBVn/hP2hQHsiyJ1K9/TYbZUs3zz0gfgyBXcfarVGD yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwpdavfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 09:19:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P9BHFd019596;
        Wed, 25 Aug 2021 09:19:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3ajsa6xy1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 09:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+E9+QwM8HemR5PkKTOQS66kQUnD8rHfX05xRZyN+1DfQxBsA5ioEGv0Vwrbc/tqe1vCE4MBrb98SSm9iXePkddskoeXuOPn+JtJp9srpJzbwAFDX/qJTdkhJDf7UMbStSahPIHjGXqHtefqO3aXFLqQRpkjjjRkKLkDmZUc7vL/xoAq/HM/IRA/cnsIDPFRrkZtKIlCj+s80tyyvi2l+SmorUx9nlU9VvMkijSbFRY7tDrJlODcujTNJqJc+QjvITvx2J4Jq7qn3UVl85FKUPsAbt3ZgHjjZPd8t3a8Q81UKr6c+UU1bvusqs8obNjaU13EJUZBjrkP96HMPVKlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWy/ij4NN4BkpNuBjTJ2cbtC69ltqfSHKxKionwHTjA=;
 b=KuwjxpjiJNZPw5BeUO2e+g0ELAzu3wUbXkC2kBV6H21jfGR1/KqkHJM0+sYyvUR3jw8jvdGTVb25MC9fRPwPIEa9XqQHumCKRwp/8xyoxK8Bw6321kzTy6cnNq7WaZ0icxWqigvXUZ20q4FP5jMYAPSdBYJi+Q5si5OAXRU6dhjz+pOi4pN1IVSRKQjJiaA67edPg4+7GnEfslsd1Y429nsInGE+zZDBKRg3LDsbpWDYPdqD90k9LpXD6FXVtGAc7ztj/5EIva5oQ5Xa2KSyqvR/aHiDiI4tlQCKXuPdLf6IDwBy/4feI6xd9mRg2f7yPiuJXPcbumzbztKX35dZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWy/ij4NN4BkpNuBjTJ2cbtC69ltqfSHKxKionwHTjA=;
 b=sNC5pSCVTaBhjz+yqNZ3JHCuQrX7z/zlqGi12nruuA4fc+qULNtTExWI4wS3d/WAcMRG/GW0ZZTg2yWPjLIiu3Q6ET2svs606BllPJBqX3+hug1Gn2b0dt1ceZ+ZKv0MkXESrwbVzdjZVLhMiwDDlDDnO7vcYgwaKwSpUNkuw8U=
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1615.namprd10.prod.outlook.com
 (2603:10b6:301:7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 09:19:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 09:19:38 +0000
Date:   Wed, 25 Aug 2021 12:19:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Larry Finger' <Larry.Finger@lwfinger.net>,
        Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] staging: r8188eu: cast to restricted __be32
Message-ID: <20210825091921.GR1931@kadam>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
 <50439a81aca7ce8c3c97ec1c7247f4cd03f645a5.1629562355.git.aakashhemadri123@gmail.com>
 <20210823084426.yo2mhgbyehkwwz3h@xps.yggdrasil>
 <25d336b5-8008-9b3b-7efe-a82afaea0e98@lwfinger.net>
 <ba4668725f944d12843529f0b0d4a8a2@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4668725f944d12843529f0b0d4a8a2@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 09:19:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90f57987-e724-4b49-1ab5-08d967a97631
X-MS-TrafficTypeDiagnostic: MWHPR10MB1615:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1615692B2B2A8EE15E75FD068EC69@MWHPR10MB1615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDnE+JN9aGU2Q/37IV5j1iW934C7AAnAHI8wwbnNXePPUVYVQSX4zYOdaLcrxEXyGGSp5e+lFw+EaRoI4o66WP3GvyWJO6T1svj4Dx3F4vtkv103x3CTFmi0J27u09JMkSFpg8gv+Fft9Cg4rTLoCyzwNEbFpxb/vXnmFTv5Ql8t6I96/vf6p0dC7RgBAgukUuwDhvdrsNoqfF6GU5tnENWyt/KNU2bBbTx49ygsVwvAY5hywAJJv73EP0wXKsHbLFfHcZL1YMDGq5t3XulPmKf9ZiciWxBDLnvb2bfPhVg8EU3mlYV/nhtdqHFfRQ9UtlClokusTvT/+6iK0Bxlx+uyfUuuMp7tYHguI1WAhfzkHSPaNYLKZdjLjHXohJltGegBBhhSM4g+wM0UIcpc37HfijcvhXZsgQWzh6l1lIodGINpeGvNiwgN9ZbXS3aUxyZapIrZB02niAOyQQXyzQddUpIHBjpc1cy7QbsMgYHJd6DIhdyI9uk1sG2WdjrOu23AwQUlHge3OfZI3YQx8DYNB3EWYEVAWZfQgQ/mObDJRoe+wJJzFt0qO6WrUEMHZGtWIAavUhPqZxlYVedEN0kA7h8enR9zY5i6VoBQ53yLrEgDkmrdUksm9agcexcHGyJnBbkjstbwePoLD5uqCWFCpvxwQhQ+Q+wx+vNkzuFyH/eKxcnoUKErYMHTLAs55e8GXZxsCqcghZw2/M7jyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(5660300002)(33656002)(38350700002)(38100700002)(316002)(478600001)(83380400001)(9686003)(6666004)(55016002)(86362001)(2906002)(186003)(53546011)(26005)(9576002)(33716001)(44832011)(6916009)(6496006)(52116002)(4326008)(54906003)(66946007)(8676002)(1076003)(66476007)(66556008)(8936002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?80V9gk+gDjQh3x6Z5cO0IzNg/nciNjIn3YQ8o8H983/xV9uD4UxMe0uV2v6I?=
 =?us-ascii?Q?dXazKM35C21yXjYbgZ794lQIFBrV0viTd0vfH71sKs8pwlJk7zspbJ5/3wdz?=
 =?us-ascii?Q?GNl0T887j7Is/HoAYKUsFhJ3N56rIZUNjm4Zeh83f1SGrTGv7Rntb1dQpJVl?=
 =?us-ascii?Q?rUawL8o2KKp2eCj8MakvbHcuD6vUH+pTXdBExxiubC3F5tn/Me5GuXRIPwdU?=
 =?us-ascii?Q?F4aSL7AA4fvD/tp7rI64l9Msqsys1oFFQe3pXyUKktdx/LN0wfaEVhZrSIEK?=
 =?us-ascii?Q?PwvGPF+HOR8RRonpLfC6nHvU1Sg9Ir7mcVYVUkYXHisnvk7NOb8Xk6JPsmZJ?=
 =?us-ascii?Q?lxvI0K5c628lxLZ+WzwHYw0h2UR/y4g/GCXoCcfhFlIgaCKg5GjXng5MB+zA?=
 =?us-ascii?Q?bmyv1V3IWSwBcsHBz+N3f6C/6CJ4PuYxJvvRtuJMm9zL3DQW3BN66oloSWO5?=
 =?us-ascii?Q?q9JVQan/mB6xagu5J3b2npmfOCLo52Oe/3kDzArSrbRLY3rDmrYdf8YOBjxQ?=
 =?us-ascii?Q?zKE99uCm5toWsPS5Iy8KBH6jiUBjRsi/p/2qCZwbAHvwgPi6zE3zhyUlD6T4?=
 =?us-ascii?Q?p7qRpko4K/g386BeFBuBIWXzutkiHTuHT6MDoSFrXSv+db3RwYB7tnWZUxD8?=
 =?us-ascii?Q?RtKPW2KIG0xrVgHR6MhqwZjjTgUABZAaEBI9pNl/foR6cWSWysnUEcapcG8A?=
 =?us-ascii?Q?5S61gsh0TFKRV6hzGsWNVs6h9o5zzY4CDZ4rU/gTtRcZE2yKJ93aXQo7Vl4P?=
 =?us-ascii?Q?IfMG2eHINv6lCYkPyXYk/fWMlZumwcYkwPZNEI6yoQ8jbEbfuJh/WrSFARRU?=
 =?us-ascii?Q?1z6OQ4LPHntIGwtZKM0f2aEaDMybd8OpkE1kVRiYMdSiRlxP2hI4BFl21eGc?=
 =?us-ascii?Q?rES/RNLTz+nQW1hOSHJxlJK/dzAR7MgvLm8+mIT6i70RU6yd9rCFTvn3Wba7?=
 =?us-ascii?Q?eRPvDNyEiZFZdPRc3gw6AZYpjRiA/BJVQggvptxFuC6waDsQfEkHgRCSRuek?=
 =?us-ascii?Q?/epktJuDTMqTfNyTnk+ZM/TSnAXAfLKyuqfRMsBuHJ/0tQUP3NpMSBtQvgau?=
 =?us-ascii?Q?TbHhUdtq10L36n07pCaUVC15FIFF5mA6mWQFbI0OwhQGZIIqAU+yNgsVsPrn?=
 =?us-ascii?Q?cG/8r2KQAQCXZe8xFag+sCTFJN+6HY1eo+hHWNFyF9O7VvTdfow002ZXoAKa?=
 =?us-ascii?Q?kES4vit/scIWrbY3Mp2RhxKPhOpNbepLM50xe+xSC7hvAmFSn3MpmQ984Bld?=
 =?us-ascii?Q?UsJ5ZwoBP9oEfJGVTUwQube3w39PzraHlsETSMEPtBZ8REITCJHTxKYVz4el?=
 =?us-ascii?Q?E3XU0EM+3wL+02noX66nbCrH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f57987-e724-4b49-1ab5-08d967a97631
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 09:19:38.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2apUmy6CY3rr3u2FjBolEDC14IBKeRZlWbB2MH3brtobZJjs9ysLTuxLeHpU32WVL+l6rO3g1bfLk4LwBkutqfdx6B017kIziJqyftd48c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1615
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250054
X-Proofpoint-ORIG-GUID: hOxLwnxdvJ2PG_iVieBix1gBlWJ5fT7k
X-Proofpoint-GUID: hOxLwnxdvJ2PG_iVieBix1gBlWJ5fT7k
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 09:13:44AM +0000, David Laight wrote:
> From: Larry Finger
> > Sent: 23 August 2021 15:24
> > 
> > On 8/23/21 3:44 AM, Aakash Hemadri wrote:
> > > On 21/08/21 09:48PM, Aakash Hemadri wrote:
> > >> Fix sparse warning:
> > >>> rtw_br_ext.c:836:54: warning: cast to restricted __be32
> > >>
> > >> dhpch->cookie is be32, change it's type.
> ...
> > >> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > >> index f6d1f6029ec3..f65d94bfa286 100644
> > >> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > >> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> ...
> > >> @@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
> > >>   				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
> > >>   					struct dhcpMessage *dhcph =
> > >>   						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
> 
> This assignment looks dubious at best - WTF is (size_t) for?
> I don't seem to have a source tree with this driver in it (probably only in 'next'?).
> I suspect it should be:
> 	struct dhcp_message *dhcph = (void *)(udph + 1);

Those are equivalent.  Either way works.

regards,
dan carpenter

