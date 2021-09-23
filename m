Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681B9415A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhIWIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:32:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48952 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239676AbhIWIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:32:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N89l7E028634;
        Thu, 23 Sep 2021 08:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wn19sRM6i0lBGnsY6UolTxELIUC8IMsq1U7qeYqylhs=;
 b=O6v2gR8tBn8P75A4CwRbKkKxM1XGEruR0MWVIr4welGfY59HKfXyjWUAYKUsGwHF8us9
 tk594FEJU9zDWdbAfdMZDeirvTWfspMmYKrNGipE0IXYvdiD63raIPRXmNmigkawdSZM
 jdIJg4YioJWXD1Fos+RQkXs+8fypLY8wBN+XSpQNjxPLWa6pXVzrJuvGLXIaF1bVKmZ8
 V6Yl0KRjSDWOYrRi2ymDaYvuY49kLV20LB/NMxUD1L3gjE1mkGd1fJ8sf4Wc8GNvyuJQ
 ny4iE21RsqOwhNc16Yk9km3tlkGtFbBvA7B4hfiKf11qssuMsOrPJhoyWsm+8JSSYU4y Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4pgmd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 08:30:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18N8P2lm126899;
        Thu, 23 Sep 2021 08:30:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 3b7q5dc8e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 08:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoFTeTHYKSgyOv1x6gQS4FbrFfyQ9C9LNZJOPGLSqU8HX2rJCfVjxWTx531ZtSkr7W+505VOrn2e0kBEu3ZuNfogPp56cY9SxB4HhKRbJSgObXE333s7liuKZqQ4YXGm3w6oA4vso7hhTMsE9xyBS8bOjBK4mB80cN6ynUmHvvDShCYRqCY8YeXK7YEkXDQB7o+DNmUi1G18OBTmL+bbVcTHU1ptvYty9fkg3/mOc9OJPdI82d+p8yXTSj+UTQZFbxiHYO2qNvpHyvB6Ey2eIkfZPta+jK8GBYXvPu2ZRJVORjWgx4rfnCtwxrKzMMKEDuKexlrfQI3kc6TD7nIUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wn19sRM6i0lBGnsY6UolTxELIUC8IMsq1U7qeYqylhs=;
 b=mwrvPHPqTQBHIh8ZhSNhRpJC9RpgI+6+LiljtqgTSYn7VVMxinNLE5ctGQqv8enYy/T7f7Z97aTvFJbW/TJb5EvAaIGZg1p2Olf3dWBfi4qzzkgQkKGPArOafO7VuPoACU+sEOz6b1AGeLzXWhncebmJt9kpdjL2Zf/YxIp9mAS1BcA4H08PtUJd6SnFlYJkkm1Q5Nj5zQV1m12p1LHmTRAbq65f4CK3nRIzWZ10zP6qrq6CVSge6aa7ap+bOP2Ku+rEDhRdkvESTVV616rYJm3vAYpxr2fB7XzWSLfIe8YkciIItEPt0o4Ykd2dd90wATrPejul2OUjZB5RCZbi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn19sRM6i0lBGnsY6UolTxELIUC8IMsq1U7qeYqylhs=;
 b=YjvFKIcDttAogE+WU0sD+ISU6aD2+p3G/6RsR9Z5GzBnInJGAs0soFWMIhgcz1d0DbQ/FvoXi5AuzR4/80AgF6H0KmA6Uk6gdygXB0yd8iUskcjQyGcVPvt/pgvxZPuDzPJNBSdH7jiQc5frScoLMvuEQpuYXhY1oDtjiQaLXKk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1568.namprd10.prod.outlook.com
 (2603:10b6:300:26::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 08:30:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Thu, 23 Sep 2021
 08:30:44 +0000
Date:   Thu, 23 Sep 2021 11:30:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Replace camel case variable name
Message-ID: <20210923083018.GB2048@kadam>
References: <20210922225756.694409-1-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922225756.694409-1-tomm.merciai@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 08:30:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1878c6b-45a0-487e-0cb4-08d97e6c6f47
X-MS-TrafficTypeDiagnostic: MWHPR10MB1568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB15683B995299AFBDFFA8E3078EA39@MWHPR10MB1568.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mxds2WiG35iCN+WZUtbyWaL7OQwDhPjGKw+TjK2peQxdjKnyrywtC8uXlqD4f8sR+7tmci4yvCPp5S/WInNQo4YNA9Fz6ZAlppQtJXqPbvrNJN7v7pPzxxjWgYWPD9GEeq+Mbn2vpWLtlGIVXzeGKrz8Lh89XIBCXNBBdqVcMoXPxpk6SRX2LHJfsz+YwNHz8iCJOpyzth3YaT8LLIZdUPgBiUYlscvVIDzLbUFFAq6K6zgf8MEAVKUJnQPDrb8+pJBgcg/2nTyD1BrH7i2lhDZdqGUWbGdUJ6msRZ9BgYRbu9G/CW9kqGImB6lP1l6Bp30lQnbJCglOeGr+4f4966obEhqIu8LLrNb1atr4FgwjHOgdlNqXCEXCi5ZOOmUNTCFnw3fOjq580ycau0cWfFsVVT80dxhl6JVqRsekQ2ElxLWL7DgpT0nb8UBjA6JCWqkZG6uK/bJTCAIW253CHpZqYHYaTjJSrv4ny0SsHiitR0YYM7rCD/p+KZqPTJKYLzsDLYhE5lqSXmcUv/VlBN5dDxqzoHsrbNMcq6SpdCI1s05cJzGvOlhBKChmzPy2ItWh6KnXPByc9OgQ4rwwcYA1BEKQ49Gc9TPmImZM6iovj+wb47wHI/7znOAE7GKnqXUpivR66uGR85NiXZjjDdDO8HTfD6iDg8POyaLcmC8Kcwl8wgzZk+4EX5i7ld15MORymY67aiWAJJ8bDeNJbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(956004)(52116002)(2906002)(6916009)(558084003)(66556008)(38350700002)(33656002)(508600001)(186003)(38100700002)(54906003)(5660300002)(8936002)(66946007)(86362001)(44832011)(33716001)(7416002)(4326008)(9686003)(9576002)(6496006)(55016002)(1076003)(8676002)(26005)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xD6IC+35d3orsaM3k0xIOfgNGxHJEFXTAn42jx/EJtecLG2HInixsqdd4T61?=
 =?us-ascii?Q?9UTzR+bP3iZJ8GCA2QxW0e6UA46pOq7CiHye6StftTQNNOMras2Eu1vOd3jF?=
 =?us-ascii?Q?PK275NTk16aTEUDqefkgCnfh5eOUrV44keb3ovaDNr77hd24zxaQK85W4475?=
 =?us-ascii?Q?nHr0iGWy3JO+2fExLo8pk9jJ8TDdZmVkN7cZX8ELX+Q764VWxFS4i612zpfG?=
 =?us-ascii?Q?3m85a6tjE20dExxzdfDThhjpEOcV1mv/B37GIVZ5C7vCRNpYPkhTVa6Swnlv?=
 =?us-ascii?Q?hhLzRn3hIygw8Bs/PPa3nl+tGveyBQ4IWCJGJa4luTB8PpA9JxZTDh3+M1Tb?=
 =?us-ascii?Q?5mEU2+r1bXjDKcbAl8Ht2H6NCHfooal8OVYwR6rqVwI+dtO/xcsVvNvouV4u?=
 =?us-ascii?Q?oomvtjSQRpb3Kc/nIW9adTaQMyAJRCH/DEEUVOomP8a9r/5B+ZgIaLB//x1Y?=
 =?us-ascii?Q?/pMw/n6NUwA3OSwez1Uh1A9JXMkMuYp4gQ9eMEFoZSuo+4gtBiZ7ZXFeGuBe?=
 =?us-ascii?Q?1qqQewxZjTjBjCeKyllOQ/hpRWo6rrEI55zk3WgUWEdYqzfbChezIEvAudYn?=
 =?us-ascii?Q?usEb6HtVK59ffiYc1DfOFNHNLNweYKfpaBxDXniDYVkfuCR7U7vcOeqcL11F?=
 =?us-ascii?Q?OAX4NEyjJ0XcGdFT6OhUw/afWCkDPnikk9O1OrjcuqlJTVYPiy0Sb4CSE0uJ?=
 =?us-ascii?Q?7cn9GCVbDhZGkmn9jPIOxrjUGsDl/yGsOkp6P56TUxPqMk+UBGC7ip5f0/i9?=
 =?us-ascii?Q?2znY1hJEtcH9XSLYG4w6Afoiw3/Wtumm1ngHOXMYUtEnur4jbpgOpSKab8ET?=
 =?us-ascii?Q?OFun5XViFxYnPjMZfQ1ZEyIxReRYo0OREfvULCJVSzGnm0JTGdcmVbsn5r4r?=
 =?us-ascii?Q?2a0ldJXr1a0BvaWt9rF0kiU0vO2soIoDS2MwlS7/629qQ/f+0YgFEjRNYsD5?=
 =?us-ascii?Q?Ts/gy1X+omnqDCiuTvXTjwEkegHgbvpOS76yxauRmQ4uud9fFkOV9jY5pEkT?=
 =?us-ascii?Q?V2+2t+fa7UJbPvuwmpLY34C3BCaP9L/R/TK7BQ5bzAPfIrX+0fNLihBh3Ua8?=
 =?us-ascii?Q?fc7PKZ1hpjd4vqEhL6oCFtJg++pj0iqGW2d8+ZXuykTwGSQMq2HyRXdAkokD?=
 =?us-ascii?Q?N7Dw/PWT8BebVaPE+NXI8Tuu+f/tje2iOrjAEwy5nxuKcvrOaaHqHHslCwEX?=
 =?us-ascii?Q?vBGSp1YCbwL+JGvQESZkGsCM2y874JuHOZA2Sx4GYTINCHuycRchtpa2vPCK?=
 =?us-ascii?Q?05sNN05kTwEUVxCn9NAGNPdGgAfhCkhNUNoKX0FM2XxZIxQHNcg9fBKce7qo?=
 =?us-ascii?Q?7SxYDpJ/Dh0N6XMWHaeKu/v/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1878c6b-45a0-487e-0cb4-08d97e6c6f47
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 08:30:44.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy12ZgCpbDwJRryT1orp9KacPWQBSopmYp+GgmJpzAs4x6nirNVP4ToiOhZ27xFhMPrsMNwD3bYxGE+b+SDvQGrgHIXTeOHwxALjV2VPcBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230051
X-Proofpoint-ORIG-GUID: ec0kvDXV56qfXLDLRTUZA23bkhyC9Za1
X-Proofpoint-GUID: ec0kvDXV56qfXLDLRTUZA23bkhyC9Za1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You sent about 10 patches with exact same subject.

On Thu, Sep 23, 2021 at 12:57:52AM +0200, Tommaso Merciai wrote:
> Work in progress: replace camel case variables

Leave out the "work in progress".  We're only interested in what this
specific patch, not other patches.

regards,
dan carpenter

