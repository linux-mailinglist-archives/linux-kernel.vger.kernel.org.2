Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE303ECEE4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhHPG5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:57:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60302 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233349AbhHPG5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:57:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17G6qHIn000531;
        Mon, 16 Aug 2021 06:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+hCqYS80a9M81ccuNsQsUh/gLsQn0wize9ZrHyGTzLI=;
 b=j5rNv20p5H+y/2rZc+wA3twlwn64sNx4qYpj+Yw3xWlAtNJ5vl6s+VdQuY6Y+3ZIqYf2
 yPwOEJR/uHmPI0eUr2oyls3kzkD7u0aIE438Uc6M1FNvrpL6DP2OcJWJp2beUvyjcAls
 pPCdnoq1zY55Dm0RlEqWSJcrBbUt1JcMFUwfYnMmu0tL6WHugblo1tlZiH8n6TAcBEh0
 Z7Gb1w1to5S5Tl352iRfhrUyI6OMfspIdQb4pe5pm6mNdU2HQraFApb4k9HS5RiXUeu1
 9dUUjLPnElQ1GhzyRhoHoNlC79sk9Qp07np1nnRi67Z+0bEl24J+rMsQdNzzNpSr5qH2 UA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=+hCqYS80a9M81ccuNsQsUh/gLsQn0wize9ZrHyGTzLI=;
 b=LGziZjmp4fzAfcU3TB4+xM2XRBpHNxskn1XZ8BlVA79dAU0ZDPO/nsuuwMfIKPfKs84G
 Ltuabr9Hu4FQZ7RLzABsP+lwiG1qhMjtFjjTYeA4yurhdpmcb+kNd2o4+3sBXTg+0nYW
 SrBEIz6kOkm+xX/TA7EOgKJz7UgSquYvQymwvU96kDv5gTNz+MTXOt1crllDDfyAdOe1
 lbEEP5rA86egY2+iIEvJLtVF7YE5HIZdoI2DCoK3evV6KQFclC1nBJXyO6LnfhR0JCre
 PYdApb0SZcmzW5Ei5o+V/umMwqfmPotIDbKKJZ/QbiZ0OFqEaAvM9rTt+Bhr3w9KZOD4 mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af1q99cuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 06:56:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17G6onj0162735;
        Mon, 16 Aug 2021 06:56:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 3ae3vda7p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 06:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEC9SLydfzNuWlDz6sGGZ1Va9oJozps8p8R5JmTEpNdDyNom61zod++o6dn8hoC6YYBs79KeDV3p4yDvvhfinOdcxvoZVmYoYsVk5KDnsO19vQsYj0aN/4vBZX/Ri4mFgWkAE9vS+XA27mtUoFlb9enARZGBnb3xoRV6iuIqpsK8ew6Kf3xzgCVKc7np15dRto0mvi56b6w6Ja0dM1d6vQG1ezNJo/uOgwhdl6+9sDzW9Y+K+b/4N2NCDcT96S9hFDNPpuJ7s9SsMOPSvqlG/ydHg19CDgoUzdgHGJzH7iCaAzyCVOBdbj+mQrYxxP00sQxw0M8JH4jDn9iIF/BFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hCqYS80a9M81ccuNsQsUh/gLsQn0wize9ZrHyGTzLI=;
 b=dF6yDDmNw9wrYRBhY+5pPLswDM+x6d5bTMo7nXmcKVGTn/AY7SV4MHRg7oJNTxqDTGU2M8A5PPrOChIXb5OPs/rFMq9e3TgqUGeK/CdB1nxZaswPPFJThOGj8eb2n+V9HVQqSXaDGM7QK7UBW8Z/W3pqnlmC/sqz1nwUrdfvWurdVqCgzZcb++HRlAAeydHmXiFf5aITFAIX0tZ3fiR0bvc3bMnRUDTgOrH0ban1KDw4DxD/CGACdH+VO7gxqbGomRMYR6Ll6iiPjdZ9fcQYMbePOiCA3sAeqXOEEgjtGKLi4VZU1TGra8f+Jm2xo4OT90KK1/S53gJY6zMtuTnLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hCqYS80a9M81ccuNsQsUh/gLsQn0wize9ZrHyGTzLI=;
 b=omt5x7zUf/hA/K3FwSK17owv1D9YcM+8NUtnyNC/9gWPZXzC7mepeiEP56cW3BY5R1+3PTkOQCSgEvxzmMWUWmgsEEfVmhhkdl9LUAxbQebQmtC73+CbkkVM4xEhgIRlxJfuaNU0bQC3Xlmw/FfpzWP+anaLRRsgJk3uUVPX94k=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4626.namprd10.prod.outlook.com
 (2603:10b6:303:9f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 06:56:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 06:56:11 +0000
Date:   Mon, 16 Aug 2021 09:55:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Leon Romanovsky <leon@kernel.org>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <20210816065552.GE1931@kadam>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
 <YRfYr0fsM1R7O5x6@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRfYr0fsM1R7O5x6@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 06:56:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c6327dc-aad4-4d47-a70c-08d96082ee16
X-MS-TrafficTypeDiagnostic: CO1PR10MB4626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4626F9D95BD8980056FDCE028EFD9@CO1PR10MB4626.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBI3HWYSENFVTccbFEgvrevg2EEEecsRzP6MzQJuBOfS6L20l3JD18hdEogy1OqtjzG1ts0k6yBYtoUTS2T3aYm26KFXIW5PLimD19C/Fvm2ByShxt0ULoWGL7XnGaa30hNzj17xTz+0UMUond/RHxCmVKDukCrXpTsQcl6fYp+0dN0xGdA8jE27imVTWFcY8a+5DXCb+VT8KsDpLIxNEXqaxh9m7dFWGo8A7Js15kQnFjIxdI6xorov3tLQGXm9yFZUwU0EGbHZtcOWy+OPaw/tXKfPGjF/bMz99i5gYzu0m3E3RkVBrcp6nDLObC7RB9ZBbo2iUX9yCFXDoRc8nOsmPH9FG6N9FnMKr1jvpU0YkNKAhzJ7mBUeTSScfmT80LhvQ7d9X05FMoDVwmN8IL+kTlLDqRAgoqOjZVI4BOFzbcKOgpf82Bc4HE1Exv7tIEczgAU4324TnspHEIUQmpV8+V61FPwhB0+5mIjpplbfFooiQsh+LqweclxctMZVeXMH/+9tiTfAthFpInxJo2l1yCM0TBpC7G7/xjkrpYf7gvSFvrlgyhhok4NU7wXyi3EvaenzLO91h9GlOiPTa+uVogpaycxd1kRjBLJ6BQsfYyHgqa6QbF3qGyIHdboaE/b5Ck3othexIUSfoUfNsaKy/8huCmPLt5x+WioM2eyMVTCq1/jv847S90BiqbR6tNLFo6y6lBgfy4SO8BSDpLSYr/bsKEByHvzsRruNdlZ+LULSpsOK8KmpVs183H1NboIm9MKrBpUdd2r3ADvrZBQQBbeE75fFxqsMIpo3ZBR0g6P3ZVMqSn6+Q0zYDY1Eek5GG6XHrWihLlqfTaxV50WCfRbwRqv7Cyk2CCX3bCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(346002)(366004)(26005)(9686003)(33716001)(1076003)(2906002)(8936002)(66946007)(4326008)(478600001)(5660300002)(316002)(66556008)(86362001)(66476007)(33656002)(7416002)(54906003)(186003)(8676002)(966005)(956004)(55016002)(83380400001)(52116002)(9576002)(38350700002)(38100700002)(6496006)(44832011)(6666004)(6916009)(125773002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUzqoH73DO1cF5+vLYgBJvAowosGmPGSBzUYegGuJ37n+txOp55FptWUHePN?=
 =?us-ascii?Q?usiEhsrh7QWtsT9sUvNi939zL0gFgOEMCpWXXR1uWMGNmac1dgqjQuWjldvx?=
 =?us-ascii?Q?5PCUIHNL0XrC5uYfrqFPYcSIYMA8qr6IsG6Jt/mr5iWZrbn0FpBxK9z9WPWv?=
 =?us-ascii?Q?rwCk4BFJp3TejN+KV0XAuYnJNAWHkRVag20r7Eew289F0pgPYB8Y9f6weKs/?=
 =?us-ascii?Q?8uNr/RihiFWaRiW4AQPOcnDOOYPvPNlslWSvimpsGgZeq4zk30QJX/bPBk15?=
 =?us-ascii?Q?CoexZhM5pOUKw85uNd1vhQw0NW9YUiPVcX3JR3d84eXIQP6wBogQnjUV3sHg?=
 =?us-ascii?Q?lu+Xoog3yCODv6gx3dUMnUV/XrviPW4P5+PMLBJF2pGT/msssaGbBz75ZZxH?=
 =?us-ascii?Q?gduEfsSScR0JSO6xoXCTCkGg1yJWZTYdNphe1teNBwQLs3OW9RBhuQTEyqn3?=
 =?us-ascii?Q?qodf8mv+6O2zr1rDMANXL8dsLqhG0eLrFbry4rKNiBpeTX/ADulwpi2SqgkG?=
 =?us-ascii?Q?tB+pwxIoBXRZkfzbnPUoZbI4VUXUFbQo3FbUD9qlTOanCtb1wgl+z9qbxgKZ?=
 =?us-ascii?Q?4sdAO8sazP6UsFhzKI59bEqTtBgWvOaCeexm1i1GJ4OlCsU3wTXNoq6haMgG?=
 =?us-ascii?Q?MXvN+QSEZ8DES6/M2jEVS09jVIi4NdQx6TAxAQL1fBfapOfCDP7NbDzLd/AF?=
 =?us-ascii?Q?Eu1tL2nxqJ9SdzPMh/PNOb20vDBWjjh6aTsHq7YhtPwMZtp6DLi4XSloEbO4?=
 =?us-ascii?Q?/kgwlrsKbaKzphvhfnAvwLV2lD0wuIkrx5KbWzFKdHKzkz30LstRrRM63/0H?=
 =?us-ascii?Q?YS1KEnwS5kOZoHe+psnKeGYDBXuqCOZr0tFA9r0X7nNKRANyz+87WxG+oilZ?=
 =?us-ascii?Q?IHc7A260rRlF0w0MNvnBuJ5a0AeqOauYniQ16Kjc2Jt7OZ68NdkyVLK/TZK8?=
 =?us-ascii?Q?pJgkcee9/UnElAAmhlkY0Z1537fwVGYIqhp/zmBecrFd74p3gsfUZ+1KEvAr?=
 =?us-ascii?Q?xkDxEMs0UySo7LAZsF8+1pbFNwIC7suzAAFq/fyHBT0Aevf4Dxq+23bRWaxx?=
 =?us-ascii?Q?9SzNmv2SPB2HeyVCCl2sx8bjDvT2xBVS7Md5I6kTZZ9FdFVyKZGKwSL4cw8o?=
 =?us-ascii?Q?O301Q2ZG3so35DK+LYlTuijxMHaxnXE9DlWiDr/Xcfq0nkDTqrTReKkPve2G?=
 =?us-ascii?Q?rCqIqNyPgwSfTuN6bCJj5WJ0lGR7G7qYoZQ18dlzEGfNDL754A046wAqKXMZ?=
 =?us-ascii?Q?AGt4AV+uPg+Kqq7bWpybEmd2RSOWsNNrcQft4R3zq061ETFZvu/nb4S+OJZD?=
 =?us-ascii?Q?40sAxsSOxT/gt+jOJCmEMaVa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6327dc-aad4-4d47-a70c-08d96082ee16
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 06:56:10.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR7K35rS+P8Gz8p9DScCVUkowfVQsftz3M4UHNzqJg8lPI+U+iyaj2RhaGX1l15OuhIFW8/dZnFZNM2mmC/jdkx4NH2c6hItCe/EsMGWexM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4626
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10077 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160045
X-Proofpoint-GUID: 1pjpM6Fo6ax_Z5GSYPHHoOaiZ2UjHUfS
X-Proofpoint-ORIG-GUID: 1pjpM6Fo6ax_Z5GSYPHHoOaiZ2UjHUfS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 02:52:31PM +0000, Al Viro wrote:
> On Sat, Aug 14, 2021 at 03:59:22PM +0200, Christophe JAILLET wrote:
> 
> > > +# prefer = {}; to = {0};
> > > +		if ($line =~ /= \{ *0 *\}/) {
> > > +			WARN("ZERO_INITIALIZER",
> > > +			     "= {} is preferred over = {0}\n" . $herecurr);
> 
> Sigh...  "is preferred over" by whom?  Use the active voice, would you?
> 
> > [1] and [2] state that {} and {0} don't have the same effect. So if correct,
> > this is not only a matter of style.
> > 
> > When testing with gcc 10.3.0, I arrived at the conclusion that both {} and
> > {0} HAVE the same behavior (i.e the whole structure and included structures
> > are completely zeroed) and I don't have a C standard to check what the rules
> > are.
> > gcc online doc didn't help me either.
> 
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf, but empty
> initializer-list is gccism anyway.
> 
> Section 6.7.8 is the one to look through there.

That's out of date.  It changed in C11.  Both = { 0 } and = { } will
clear out struct holes. The = { } GCC extension has always initialized
struct holes.

http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf

For partial initializations then all the padding is zeroed.
Unfortunately if you fully initialize the struct then padding is not
initialized.

regards,
dan carpenter

