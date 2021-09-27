Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7A4194E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhI0NRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:17:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57316 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234421AbhI0NRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:17:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RC9hGc015461;
        Mon, 27 Sep 2021 13:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=R48ZNBUrAQTRBDzfh+B/zTjjm9dluuOUPK5nJLnS9zU=;
 b=F3gkY0VGjshozOsrOc/8gB4LRwKOpukS9ulMecFj7/zuK9ETEfybY+JZ6obYjTKlR9ob
 5s8WeNYhLXEy0EtErGFOxU5umJl2hIPfT9KjYOkRoyj3FUwb8WTUTiXBJqKGusWzXchl
 Oab6ZyXv4/56boQDBY5upgIAzlRy/Y4WUSx5gGbQuVIefWRs0zBOqlj+tH4FjQX70q3x
 COHaMVA1o7GBKxYzpX630FeBOZ+5BieGSJZyKP0VtAEj9OBMzMfka04e0QU28xDAqjaO
 ZWRwrATU87uS8QcDtz0UoGzzR0P7S2ol/BFhqI3QrNs2oqYwmD5fS+SVd/ca2BBZSOH0 SA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bar0nc9th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 13:15:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18RDFH2B120485;
        Mon, 27 Sep 2021 13:15:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3b9stcga2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 13:15:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvwHSwlwx2nS0yJ9tsLZbm2QR2Be82aamLidDcLVGHbpCCAgJoz1qPWwzlyYqjAPKJ86Lvxol0iS3O513G/3c0PET7JBQQp64JEAqgcUUCJ7RMX/k5B3XbRdm6mQ4oRBEgsDTRG6kpNYMqeCz0g5wx7WtrCJL07a2IYyiX7l/lk0f2aDoQS/AZQKRS4eexu3k7Ob1/LZ8WQGdYmBRfVJR3LLUVI77U//eVxCOREgbJCNRnjUtyHGLC5J5X3NNg8pjqW9cVWyRxAI3Pft9rqVgpOf8W2UKPVvbGjMZtzOkccK7gWdwCqlDeTTDgQbbp2hnXPGQF2QsV0bGcoA10B/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=R48ZNBUrAQTRBDzfh+B/zTjjm9dluuOUPK5nJLnS9zU=;
 b=ClnehNtffN4dklrLf5xRAgO6sx02kW24SdBeAL9TMAoFHpgVrFE0u8hsU5XFD8HaguwRuhYOHWvIipt/DPmUdQQbfBUy5lUp0iYtwBdsDqugWZIiYUpJPUl9ID0v8uaTxZYWnsbLa0W14A2rVN+fY+UhFNdUi2e3y3ZwCU6TSQVBQU2OZzhvu4wnLNFv9csdsbO1lKKj6aCMTNh4V+FbYEvvTcSXXo8nRD4aNre2DsQVpGfVxSsjQ+hlkf2pv/VFbEkaDBfOVd9xvdaPTiJE+knfXomeFpF8GjHpprlDQIye8coaNyzxzN2CcqHLvP7w3Bp0KuE/p2nFmZtWG0zsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R48ZNBUrAQTRBDzfh+B/zTjjm9dluuOUPK5nJLnS9zU=;
 b=aLvuUEU/VMStT4UtnUEcit1fAh/aORWwKorDPi6K2UYr7JQMZKbicykt2bPYxYdn+iA3YtNJIfYAFUsAQ/ktrDtMrm3dJwFY+gEN5W84D46dfcP/sH7fvMERpl2GSSbAo6PKIBWlAl2ae+yHLaav/vnOJ1PVBp/xXM5d/FoNSh0=
Authentication-Results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2399.namprd10.prod.outlook.com
 (2603:10b6:301:30::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 13:15:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 13:15:38 +0000
Date:   Mon, 27 Sep 2021 16:15:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Estner <michaelestner@web.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avoid crashing the kernel
Message-ID: <20210927131521.GG2048@kadam>
References: <20210925200433.8329-1-michaelestner@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925200433.8329-1-michaelestner@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Mon, 27 Sep 2021 13:15:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5396c2c9-ffad-4c2e-8cbb-08d981b8e5a8
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2399AFDA6969EAB05976CDA88EA79@MWHPR1001MB2399.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJvfgzGUo2wae2TkKwWBx871dSP01nUr13VfDRWyx233yUxIkgVXR2rfH1jZWg8r3m0hSuRXbh21X9Opj3lUiE8Vzl6GP2+x+Ly4nE+jC9PHF4Gf3ly3P3HCDsrndV9cID/FTipWBZ5s0qGn5quh618MU6r6aEsVKr0qJ2betPdlg4CqsK2uXqFWni49LkicuZj4fTVDS4Bpj06We/5mFD5tRJclYYs8dFVDEPJ7ZtlgU3GdjYMAEe4BQzt+mYVLMnM2QsF9ySwCYDHSpERuJT1WC/Iq1Y3wn60MoTE2a9xmqy49P1kaXLJDq+NH9HE2Q84OeBy+z+NPW4l4eEbNPSlrm4C+Vy0kbUxz2xXv4YaabJ7jPXUwXXt1+0Ow1Ogg2nZWGvvoHHy1eowZujZKEG8jUMbFh6WoCIjH+1wyEecpVBY1Co8D7gUh+bLiX+Ob74drWCQ3w1cWxeq8KKISuC7uVmflLD1Iocl9fQP8vQpZaMTaHTfg/tjycebV9xFFxW8UcQu++Fh8W+GjUiPIsKMQcSn9w4rgL6p9zHmvIfPkIH5vlcbzSw03+B+T3Qw+yBVA/s4QmmFwukD6JIlJ0zKAT5Qt8bCNVbml8IWXGCk84/43WeK4TkJpiYRi5xoV5ASh2zTDMoJiLOF1kZQfh5uaRJUaCk4Id51ib9rfWXnz6DNYtSpHpmY3FOdB/WhQm9TeFERF8G2pC2vVwhCLrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6496006)(6916009)(54906003)(1076003)(66556008)(8676002)(66946007)(6666004)(66476007)(33716001)(38350700002)(38100700002)(508600001)(26005)(4326008)(44832011)(86362001)(2906002)(8936002)(33656002)(5660300002)(186003)(9576002)(55016002)(9686003)(4744005)(52116002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pP84a+5GoRHOJj68t4WhS57baW4Gzo2i3aHlXfyo6srU/crXd1rY6xo4MKoW?=
 =?us-ascii?Q?rfAwRnBMWQZJ/ZN4BVjzJK1S+RP5uXlXuL8hBJWmkj9190PpGBLUckoqSxbf?=
 =?us-ascii?Q?xjI1FKKAiGiXmYmUCWnmlzMMWAfeh7oELahMi3RAaarHlTzxc87YDtweh0dQ?=
 =?us-ascii?Q?ktXarG8A6Wf/d0P0CiEGeBYimC1EdCrAF5NUH05rFzHoRzvf9PhNugO4ZreU?=
 =?us-ascii?Q?7HMc0F5VL+vnSAcgBqtx2E3REMNYNVQBNP3YmWVY5gNawsB79wJ3ScPi1O4O?=
 =?us-ascii?Q?PpyM8TU116D7KZqfE9YnFpGntIh13I9p5n2LIKr4IflUPUEfntBAvjcxzbQ9?=
 =?us-ascii?Q?YXLdHay57gkxO0r9IIiJJmi/QaLXUOSSP9ucC1rxQXdEj0QErQxh/8v0RWOB?=
 =?us-ascii?Q?/VzOyefhL2iJ6My/3D14ODpRyKRwBOuZlqLzohXR5ujEB5jo2fxlvLq6/QAa?=
 =?us-ascii?Q?o4CfehRpGNZMBmbPEButXV+ipgmijkaBGWBwSbVW8onMVcyWO0ljHYfRnu29?=
 =?us-ascii?Q?VwiKmkFxrapcGVo8kX5OZ5g4dHRFm0JcvOT1J5VU47+IpkC3os4JyRsWfaY0?=
 =?us-ascii?Q?giqBHWKsvRj9NyUwd+n164jZleTJMn5Rm4rgSV2hYAdqZ34yktvlvOiCwsED?=
 =?us-ascii?Q?FIubug3sAMHt465S8JoLYtnbeymjCg2CP6RA7sMOFGqKjgovB14nvwR7efsD?=
 =?us-ascii?Q?1rHuBcJobDAJ71+Zb62ADM1BrDPNBJWaOYF5wkTOYqlT+klWFgYtkXBc9aT/?=
 =?us-ascii?Q?83ch/xdDIx2UwYZPc2HlX1gN8Fg3n6aRMvfdFnXqbquxsLqepn08NyM/Ai9b?=
 =?us-ascii?Q?b7ZXShdta8LLZFwySRrNZAc1WntK4I7SL6GOm/o2afYtzPTMdLsUlueVFSQR?=
 =?us-ascii?Q?Bf08+K/m2MCXPXqlq30pfDgQRRQMvaIqLsUy8BaD+SO/YgGAdpTiRfNDaRyn?=
 =?us-ascii?Q?vu2dIo06RXxXwfNF3FK1Bv5qsyq9JokmFw407RtxfU1ulyKhcXgWwsEqR+BZ?=
 =?us-ascii?Q?aD2BTkZ2D0/rA8SYRTbSs9IRs190BTdvZGqskqdw3z7F1P5FCBHXtWNX44Ck?=
 =?us-ascii?Q?ElpQajJT66fIFHf0bDOcSN1OcPG0fGgweAuYhu3OMnzN0kbKahhGMUOyIHR8?=
 =?us-ascii?Q?zfPGI1TqvKtQXO7nqwBAn5qZENUUTHioG+gn8LvA6MoUcY29wwqs/wQ5LlLb?=
 =?us-ascii?Q?aqBBiqxDLmd0nMseZQX4qvSyTbRUa5qPtJpYGOMzE+bZq1OIHUv9e5CHpZ1O?=
 =?us-ascii?Q?TWvf7zpPcBQ9DZTj8PATcgTDYFDkNFuoyEpiJvfnGBb42x0h9DbcmvYgKss/?=
 =?us-ascii?Q?OgQ/UQE3VBs6X1uLcEgD0X/x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5396c2c9-ffad-4c2e-8cbb-08d981b8e5a8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 13:15:37.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQEPg+601NCmYA85PPI5nNvR4uf9LnYklyCZC9EIVjTfwc7smnxcTNjYIbY8PVg7Qi3YwMSMujJjNXAVyqfhw5P+DuPU8XFDWDaIbn7osd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2399
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10119 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=738
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109270092
X-Proofpoint-ORIG-GUID: p63UhVXewQ-q_MEdiV-7GRjELIfbpC9v
X-Proofpoint-GUID: p63UhVXewQ-q_MEdiV-7GRjELIfbpC9v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing patch prefix.

On Sat, Sep 25, 2021 at 10:04:30PM +0200, Michael Estner wrote:
> To avoid chrashing the kernel I use WARN_ON instead.
> 

This is not actually the difference at all.  You are doing something
without really understand it.  If we wanted to, we could do this
automically with a Perl script but it really is better if someone can
look at it and think about it a bit.

regards,
dan carpenter

