Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A13FB482
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhH3LZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:25:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12560 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235387AbhH3LZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:25:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UBOUgS017474;
        Mon, 30 Aug 2021 11:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=A1YG/Pk5oYXDWGcsPiN0QCpmav/k4aThEn+aYpZIg1s=;
 b=aWTAuXW6o9CGkDa0v7B2dQ9B8GYqBiL53ttzh+wfz/mHg8XiQpRzmh6eTGANBp9aYPwb
 Lq9Bb+tnDgsqpwp6GTZsQjpukHPzfyb7Ebh/lqYs3j0wrSh8iTv7RONV0FddBzgKvTWP
 4SfZHXvtqY0bWanMQ71nwqNK+HfjdminWsF/b9NO9IYA4VglqEMCig+RL8TPQNNs6jXq
 L4oBjars7Fp+UB+c1Xol96Z2qJyvUyN2DSnM6m40fBd+RqIm+YBjcvZC2FnRmiUH6rDy
 fhMlDv03qGNYHJ+76YBoFgYtlufb2R697CkFtTRR5cQCHqOCeGmqmE6CgrAd3dctCNcp 4A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=A1YG/Pk5oYXDWGcsPiN0QCpmav/k4aThEn+aYpZIg1s=;
 b=DkzrOJM2C2Aai7kJjr04Z9ufptOb4tF+UvtRCOHCTPaLGBbA9ymgJunH3lWfedxQh9UO
 zspzkGMoJI1ogGea78IGQr8YJ1Gt/NuVzDM6miBkw2TPenPHmqd7sS85mcVx+wmW9ncp
 JER21PVz2wprgdc/mStFX2nfy+W2fn9CfRVuVw/CX5azvEZN8wJvQitDFwGgc0vZacgK
 KwUPzZPtxLhw+oVZ9/ejznrZol0JjR5h5zUsqHA1s5T575TruxaCgE/WKbGL9ndejlOU
 29mohDruFKw3pd/zqo/qZ8AxNMnhiYmfHG9VJCkbjMSXFMy2OPAyL1i8b+gGWcpUQsWX kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxsh9a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 11:24:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UB9ZYv170597;
        Mon, 30 Aug 2021 11:24:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3aqcy2nwpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 11:24:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/kgQqGgejO2plDXE9oZ9oxGpsvozMoR8NTPdzI66U80d3oxwQ8j3PytI2rONvRn6TF+4phws+n4LqSyhyupljLc92T8jaX9kFnuQf34IJtqfuwbX2qEqML/9SbFMt3Zg/MxU6lOoEQiIp18SuTsvBX2tEPJFvHgFMByGxSTv5OK4G6Y2/PMR0jLiLhIlRU7eHW0VNP3SsP6NMSeyT4sX7nccwDEyJOK1SXNP7RAcLZJyUQXBE0nWPf9JvUwKHP5/yA0fnXaav543M/KeSWMEIMbDM++UyvRZTgs+nyDe3lUwEgqNMdQKbYhAmWjDFDW6m8PSCpvzofwL23tnyPZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1YG/Pk5oYXDWGcsPiN0QCpmav/k4aThEn+aYpZIg1s=;
 b=I0OcYD+CmnYUCwTQ5+ubmxYE0b8YVEICA3AgtkM3NCA6MYn2cnuUQ+mK9AqDW/sIlKUQoYxYGP4D5LKfGleYd+/1pPfQ233UN8HFgPluvSNtANpOOicftYCOv7zWXVP6Ca9i/rbaKIUY9dGmBEb6tdHC+5C+cI9ZmrLnGdvx0aZMihwLUqScNO+zHrURXk+Z2RolcFyNV5S2fGQ4gq5SP16Cs/bWlVVPaLdxST0/zrB1bnzdyT6XaxdMdna1uHyZ3P7d9dKewI/vNqWVFYWfH5OEIKSPzD2xGivHofjh4O2fygeGe1nLgao84MYZQO5nMstBy6xRZ3jfYRSm3xai7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1YG/Pk5oYXDWGcsPiN0QCpmav/k4aThEn+aYpZIg1s=;
 b=kn5m7FAiYXFS6rZSg3XOsr2J2APnDGgc/Esm5Ep3Tod/n63C/pHtN1iE4T8GL2I3T80TI6QihS7lnL67M2oa3Y8FwWzWVBxPPptQ2MbAzNGe5Zf2s0NBenE4w39QqlYknepTla1YYVALjuMijWR1s9CHI21xREE2n1Yt9g02CVk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 11:24:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 11:24:03 +0000
Date:   Mon, 30 Aug 2021 14:23:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        straube.linux@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v4] staging: r8188eu: core: remove null check before vfree
Message-ID: <20210830112342.GF12231@kadam>
References: <YSu9GQa1A3s6FYQx@user>
 <20210829171351.u63zoaqa3x5qfodt@kari-VirtualBox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829171351.u63zoaqa3x5qfodt@kari-VirtualBox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 11:23:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a0f72c1-c3ff-48c3-6ff6-08d96ba8abf7
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4595D49A52C634CD5C5BFA728ECB9@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3Tg6qj0OXXN2mCniPnhJmUso4VminXGiDvoJe8QdVgGTrLnX9X/JYA2kQ1ATG8rRoMzJe7hrOxPrl1iTquRk9TTCiNyS5d2aNSbUrECZrTAmOjVRPIA2f99zDjXz4gEdP9x+AIR3Do/hP2+Iu/EANFp6/v1vYH+p4kzs8KBNa4Ds1XZWY+x10HwI+2a46zGQ+2CEhoLq2v/eZDgro4EzDxqH79myP4xv/3baTqqwvsDdu4ymz783Rler8EvdAqrVVI+Hg3BmBstvuv5wATm+ICJuPo6eUGDX6tJfhDsdlQrsy7/rimMx+xHDyaShz0Ah1qiIrJvmTy30aTN0pbBZd4ZwOfGnhJWqJFv4/hzoWZuZ0pNuRyeSxIMfgzFdApsAkiVlOqed2H3ehH/LX9fp6klJeWgEoqUZXj2z3dDfy66rH6rF3F6QUhwC7KuDeyC8KoHKe9ct1t/JtLCOv0kCn+HDjAzkih8SXI5+h8seJiC1lJzy8eHL4ZjW+KE7p+rwRJE4pcmFO8ljvlSz4yokbPrj8HxG8Zol2oD0Cph69fXpZu7E0bQnV6IcoZVJFo50iPUb5x13XDUHiCHXcj1bOJECV4bwQM85UuOquBTAHxMp/jHq9PAu3egaaQQbiML1XS0AGr/Uyeoh1OwEPiC3zJ/yQ7vjQdz3QBw3VkDxkCz393Qi55GQ0m9QqwZh30RSsnUyU1GZVCu1LT/WYZuww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(39860400002)(136003)(346002)(86362001)(7416002)(55016002)(6496006)(316002)(4744005)(8936002)(9686003)(478600001)(5660300002)(52116002)(4326008)(9576002)(66476007)(8676002)(186003)(6666004)(956004)(1076003)(66556008)(38100700002)(38350700002)(2906002)(66946007)(6916009)(33656002)(26005)(33716001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tkAELQzVGDNVbAt/aStFUGQBxwYY5yMWDolk2aX0kBqVryUGN7P0aMlkmS2?=
 =?us-ascii?Q?8/R0Mof+E3XMj0ru4D3rr3pkYWyheZuYANjr8YAJaj84Y+Ng9yAb9mfePvky?=
 =?us-ascii?Q?LsToFzz3h5ShuXPQxITU5QnNWYDUwztkEbpL9TtyWkcqkU6qJ3buWZYMj7ui?=
 =?us-ascii?Q?b/lobS7ar1W0AQ58BEUEOPvXmSD3bu5dce7w22/jedcrVLV9hTpbXg9xXCMX?=
 =?us-ascii?Q?0DQJa7dueBUXYJ9IcrHqXtmuxW8aMQbMwOvuLSm3mCuQhLdHup2SJ/uC18Et?=
 =?us-ascii?Q?P8Yg1fZQYUCsA60kssDRIbGo+qmBW0jsjsnuyEz3yOeyI5Ujs7TRoTiHHp+b?=
 =?us-ascii?Q?4JbCkek9o8fawMvD+c+JUFhPB5WNJZbirRhSuHEcfZybf1ksAuQ6KBtzafoE?=
 =?us-ascii?Q?zyR7QR20BpErlwiaY401K4AmEQpKNrAlb4PU3uZc9YD//kUV67z4XRW9+lMl?=
 =?us-ascii?Q?jLeCJ1lQTZy9hYlAgXJoyy9A4nVAs4YbQWQ3w2X99u6arXptSlk3KNceokmt?=
 =?us-ascii?Q?9Q6lQLLqWbbtJBZkfCaUlF/g7xs4Tr6V7j314dVbCH7KxNaqo4hkRsOhfcSj?=
 =?us-ascii?Q?/OW8F5U48sxwpxEOXiRxAQmHaNUBwO8RSPyoeQqNAmbBVTPFx0XHM0nrpA10?=
 =?us-ascii?Q?r2JbZyIYZA4sh/4UHB0GX4zskJ1c+ukBZhcNWByM516mQ2DxdoBPTCli7Ui5?=
 =?us-ascii?Q?TFGdF+sUe/uJQKqKdCDafx9Cw9Kr11sLQOTQqxCwaecvdllL0UVMx02tXDz9?=
 =?us-ascii?Q?2b2t1NoKo5G8TVyOmlJYk94MdhGOF3OfzX24ThQZuVDVO8F5j5+gKlUg+stK?=
 =?us-ascii?Q?+PAN79ZwNZRUbzSyFtMF6y5NCmN47vBXf6aTSbw7IgVwQnpxB3YUK68fXo7b?=
 =?us-ascii?Q?2qPE6Nm7qzv/1pJbJ7JeS/2gma60Ey4YjV0AFIzfWG7LnHneO18zzActcfJc?=
 =?us-ascii?Q?TgAvD+KHueYh2zN51vDPnAiuvQuOiU4WuG002NxjUxlMLgKTAKn6jyfd9K/3?=
 =?us-ascii?Q?gN1KL0zMnQAf+QLI7RyXYutsYQrtRW42I3jJ+3TtPL5q9vrdpoZ2zCF3SZDj?=
 =?us-ascii?Q?l8u0dV8yeGcmoVSYVdI2U4fbxHvHhQpSlz8Y7TM+R89OP/9a82bQFPFMlr0W?=
 =?us-ascii?Q?veMN0gJrJ15rrFLmTQjDNNFKQHvlBut5tNRkbG9/P9AnVQfR3SfLmc69XUXK?=
 =?us-ascii?Q?6HPYiZxC4imU58Ceju8mD163B7KBac7PtK4Bd04Z67FCGY8YEzSbIGzHZFUG?=
 =?us-ascii?Q?l0mmDvDNu2uxpTOFlyaaq7Y7VHuHRB2/e0jLSIfTap6ZefXwCd24bmj5gL6Z?=
 =?us-ascii?Q?33u2+UAoLOR2tULG2YrmfyAM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0f72c1-c3ff-48c3-6ff6-08d96ba8abf7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 11:24:03.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybo2us8pJbFNsf97yyM4eGqACm+mwduTGrkjuPZL+vMeE8iswnZmTD9BGMHbDxdpejCNVREN3AkwJYqCuERcA21m2TvO7iEuFssH9nILmUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300082
X-Proofpoint-GUID: VF1rw7k3s23HyUAaDHEBEBm6JfswHlo0
X-Proofpoint-ORIG-GUID: VF1rw7k3s23HyUAaDHEBEBm6JfswHlo0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 08:13:51PM +0300, Kari Argillander wrote:
> On Sun, Aug 29, 2021 at 10:30:09PM +0530, Saurav Girepunje wrote:
> > Remove NULL check. NULL check before freeing function is not needed.
> > Correct the indentation.
> > 
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> > 
> > ChangeLog V4:
> > - Add Change log below --- line
> > 
> > ChangeLog V3:
> > - Add change log.
> > 
> > ChangeLog V2:
> > - Correct the indentation.
> 
> You need "---" here also.
> 

No.  It works fine.  I applied it myself with `git am` just to be 100%
sure in case I was missing something.

regards,
dan carpenter

