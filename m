Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17BC3FB361
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhH3Jt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:49:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10694 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235733AbhH3Jt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:49:27 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17U6wwwq020852;
        Mon, 30 Aug 2021 09:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=c/Dqw7QqOygI+RTWDn5D4xB5HNJn3eihTSztKBHtxHg=;
 b=A6t87k0LUCm/b/1tVCDl6uFfU6qVXTun58g8MB4VfBfh+DNr2Mokaau/AuKd8VS97OF+
 z5Y+oIg5bSVS4MTvZHz2XSBdfpkxpSi+OgpdzvSV9YVjCtpKIRVK+lPR0fVUQ9ngo4pn
 O9Bm4gYL/nbEiF7TMslqDaiatpTedYOkD+xPPni0SWa+UNNymN3nbDWM8Mdvsx4Gwo3y
 RAIVEkZGDK70VcrAKmsbWF4yxx9N8ocIVSGafczNqynye0ZLDrE3K0XTGXlj/cDWpgpI
 xWAQR8LsMnJRmWCXN7x6528a6znJiQvvk08CaScjrGAAFsK2ffXlpTW8TJjYPlzJ/S0H hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=c/Dqw7QqOygI+RTWDn5D4xB5HNJn3eihTSztKBHtxHg=;
 b=oD1ySx44gByTNbl/2W112W76GQ81TIHP5eR+MyaMk2zqeNQHk2XbhlURF8t0tUIKKsLF
 BINCUi+9ULuhLWavUo4xvFXTLWadgZ4ltu/53zw2NE0h3A/BnFeLLSNt9Of2dtlDDcw3
 oooZ6Tr+TACaG3FxXTX762rblfLd6g2bDZPlBaMBY2yaWMeSy4MVedbo2hn2ngAkLFqW
 FF/JZQqG5qQA7scxuy79KPE6grnJ5bEfCxEe3IwhI+dKT5Zt+iVsiDPdyXzRvAyZWlEd
 KCkZBmcz+FHZrBpJHkpDa1mLlkz7sglxxmAtmzkDVmG+CSOZB4O3ppvgH3WQUlxg/dYj qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arc1a14y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 09:48:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17U9kBSi076643;
        Mon, 30 Aug 2021 09:48:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 3arpf21qth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 09:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUUBpuYgc0JIEpzaYGP5wJOvoJIQoCn4cg5Whoen1cr4wyIjgfF9i3oEXxUOZSrZFz9j4Hse51Mt5PcFwrV9Sj0a2I7hdvL4YN4HOQO92R/x5jDpaD7TiGrk9i3+uoqIk18bbAew6R5/58LwTH0u196Z2wuk2Xh3FWSUxeLlipVgEVqYtz1RtAci3LukGwe6o+ssKqSqL4hGWgYg3v0+RLyYZQjwXBOQWsFWevqC6BCQgPJU8WgpGS1aVrbwxE+UWsXCOXzqSk3jjeDSNDqXrLcFxNrDp5M/36yvitrFNboSxZpg8LdicfWFpD13V0sGTp5HsmlaelYP2mOk1AWFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Dqw7QqOygI+RTWDn5D4xB5HNJn3eihTSztKBHtxHg=;
 b=MWxsg0AY7zCDvXVhoy/Hfo9a6S7sOTIEGXJyRFPlPlnvTunAUsTofm+AoOEVB2KUQyZzM43l0FvwVybBt8Yv20Cgrs+A0uyFQr3R72B+a5qeeZIyGzQDW5syrPJCRIm4od/WFtPyRHLv129u6vyapKlckV+KeikPNl1g4srN9JKAyDGN+5od7m0yEN3RuPvdPecX3DgoEhgMBajGiFHKxk4uXyuRj4BzbAfbnkWZ3GE+2QRctNUlE8E9esCUPWxAD0ZfrcsKGxpjsJKODD222x2Emxoo++sMJG7BN+pPftAjLNxbu68DVuyrDzCr1lqyoiqhwgHqiCn8rlJtoj8hog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Dqw7QqOygI+RTWDn5D4xB5HNJn3eihTSztKBHtxHg=;
 b=zFsNWE08yJ5mQHW6Qr+mji93IQglEW2JQSu/Yd071Hvzo/x657WZKtVGakFTc5FtPJelp2TG+DhlSGJNdY4/tKfYk/bABNDvSF2fF6SUrYnEhRcjKTit4czPyFa/nOv6MbUfPTLPHEk/lM32dSRu/tZ+Cf31RdfkWKGgB0rDHEE=
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2094.namprd10.prod.outlook.com
 (2603:10b6:301:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Mon, 30 Aug
 2021 09:48:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 09:48:27 +0000
Date:   Mon, 30 Aug 2021 12:48:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v1 3/4] char: xillybus: Remove usage of remaining
 deprecated pci_ API
Message-ID: <20210830094810.GC12231@kadam>
References: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
 <19d67ac0208a609aef1e28278b3f2477aa714029.1630083668.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d67ac0208a609aef1e28278b3f2477aa714029.1630083668.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Mon, 30 Aug 2021 09:48:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd1ad05-91e5-4147-c0ea-08d96b9b5100
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20945BFB96E6DC3C1F19F9858ECB9@MWHPR1001MB2094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIcBlOV4UAhd8TU4wlf3PPknAZPhb2VIvTJbiHyCdCI6jk4F4Po/hWgolQZR9Tozr4MjnAqaq/OZ+W+EChJg1g55vW9Iv0VYUQbLNRG2z+7QEGB5MIn8oIFRNs352OzU5vWvV9A9V3mT9mXVbdDWrEJqHOlwa4b2feVL4rgxX18hq9RyYDXwxd+5vReT1zhz8f3h+s6jvnaXqogwBIRIltbrZmLNIkISceWsNSWVIbJlYHO2mbIW3J1viddaARMMQzTYHzkgF8vDcQYFsmpQS4j+OSF/mZtWvwvNUM/wDbVQiB8rBcHUjj7R2HYHELztMgM9I252QJcsNX9/m7IhJ1yPKsjf8RytFnRqyfLexPyYf0O3Sx/YY/a4vxS+X/zlw/BHcOAEuBOYnCd8vzuHf87+ASTqHmq/WUfEQgtvcFdgcpdhgeTyQ11FdzRUT0u/a4R4rDqP5Y+ezFrc9VrIP2JgQNqKS62B+pSpFEjM61yt8yUpmK+tWZ8mSX7XT1vGMuSHXPZDdP6yh4K0pGFZbSd1meH6cKPTJF50zWciGuu0LeayOYog5AdOv1OVBGxI6Gv7P3VQ882bIbkytRtGAdfxbqGMpQrVur196NF23IPrudw9Py9THpZkz9ipiYVm+ktxwN7GEK0PAEaX7oPodeiIPB77+fczBnT/7sICX1z9cRGMWMKdRPSVJiN4L2MywaZTNGkSEKky8VPxPksScw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(33716001)(86362001)(38350700002)(38100700002)(2906002)(9686003)(1076003)(26005)(316002)(44832011)(956004)(52116002)(8936002)(6496006)(9576002)(4326008)(8676002)(6666004)(5660300002)(478600001)(186003)(55016002)(6916009)(66946007)(66476007)(66556008)(33656002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqR4ikKw2eOWpxQJ94OTUQBPsz2YdPY0tEUbZxwtHJSUv/QokMPBwyD4yP1v?=
 =?us-ascii?Q?zvLlOIz8rLfCOd25UhBpjBhxQKfzC2D3XY0BJliuYXWBXeYHsp6ZyBgHdxY4?=
 =?us-ascii?Q?NjZwlDiLZ2y2SdEq7bNHTeyfjaitEhIiYLQ9EJ537Seko8dxGhNdx/07RvEt?=
 =?us-ascii?Q?tQQ10xKysh/me9ywPSvBrWBaftot+vneETnqxjyZq0e73HTbiOnx1ETwt+Zs?=
 =?us-ascii?Q?uPDxwon1MXm7CJvN/CX7fgnvb/sYjkTC+80xI5XjVKsEMPAlIzJZ/b7QWj0g?=
 =?us-ascii?Q?pIR9ybriywpW09APaQvhmDB4uU4ZOfKL/mqg1Wj14cvbF1vIQmBMPBMjJnL6?=
 =?us-ascii?Q?YiLp/hokfOL5+W55OSFaAW33UHQYEldTbQGcLKpqpmiLkp+MWGdqwOsgQAyc?=
 =?us-ascii?Q?H8tz7OMnmBEbtPmMjjlnMqdEkh0EtEez+iiySDC3IjkxtNu22DUGO5Go92AQ?=
 =?us-ascii?Q?wK8hX8QkPNJnU7Bv1x9X1li/0DGGaITin7Ak/biJA5lYyL5CoTm+JLx1LfsZ?=
 =?us-ascii?Q?0ninoCnJquZMOpXGSjWBLrFKXBuz3stLDmnX+xstFlAPC+GtHFwKD7q9huQZ?=
 =?us-ascii?Q?FInUKYIsjOAzWExWY6tvUS34zgEa2iNHvKeDhGOODR+cfxQeBg1F8yc+bUBK?=
 =?us-ascii?Q?3SjQ43DJ9cbqj/WdRBHIF6vF+m+pAHjQ/lPvN6ngjr243MsDEn37a1qb2TDU?=
 =?us-ascii?Q?MYMb3hKqBBIRvhORwaXaN1xLeNIUnxezcMUMQ+XmajLdB6fq0Vsgb71xgTPh?=
 =?us-ascii?Q?MjMybHqn3gyQwolOK5h25JDGTHDT5G09dxxKt80yXABhtFpOuaiMTvMQlZAd?=
 =?us-ascii?Q?dWy0c4xNeBKDQgWSyCY3fQ0+krxfM20Ik7fUlmo3/w6v0t4S47COjrOr7ycH?=
 =?us-ascii?Q?MVB5Ar9l4eiWze9TXlgiIzhYL/EVWDTUL2yvPd8S0snOeHy3lV5gmrPCDGTp?=
 =?us-ascii?Q?txepkRhyqaHHVBXPUdPiJgDlsmfqkGvIUBnZCJG6QTQX5ZD9wKEJ/5QYNTW9?=
 =?us-ascii?Q?OQwdzVBpXsL6FBDBTgmfLi74wOSysoCgb5+/DoLAg2A+Ng4wocCkG92yFOim?=
 =?us-ascii?Q?qLwXJ9UgArHxsgSrKiFR+x+poiCZ2q24o1hI2fy+2KfVWh0BZLRmsl3dCOcj?=
 =?us-ascii?Q?QGAaYuRe5g3pODI2qiQ3cSle55lXuVgmZtzxApLKjzLxDMdkU4ZoKP4xo6jv?=
 =?us-ascii?Q?J/NuO4LmezOW5C98eRTWDooX571I4OT+VwJPzvgjXyLJpRIVVkiHpk/AoZHB?=
 =?us-ascii?Q?cyioVKhedyfPuMB5NeAaKNfPS8ObtthyYdlvqO0+LYnq5FE5C6HLb3PhxZh6?=
 =?us-ascii?Q?fH3ja+MjHBW/ySca2075LptC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd1ad05-91e5-4147-c0ea-08d96b9b5100
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 09:48:27.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFnH9Svr9RFwaxxKJuALTuM6KhlFIv8c1em630C6RTMfVS/Li9SXNRq4zU1sC0hb8g6c1KRz+M4Hd0dg+dqE4rwnIrvl87y9qDSujpzEp0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300072
X-Proofpoint-GUID: t78F7mj8ireQUCYW6ce9JU3UIfmt4oJc
X-Proofpoint-ORIG-GUID: t78F7mj8ireQUCYW6ce9JU3UIfmt4oJc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 07:17:47PM +0200, Christophe JAILLET wrote:
> diff --git a/drivers/char/xillybus/xillybus.h b/drivers/char/xillybus/xillybus.h
> index 7c71bdef7ccb..55d47cb13a7b 100644
> --- a/drivers/char/xillybus/xillybus.h
> +++ b/drivers/char/xillybus/xillybus.h
> @@ -87,7 +87,6 @@ struct xilly_channel {
>  };
>  
>  struct xilly_endpoint {
> -	struct pci_dev *pdev;
>  	struct device *dev;
>  	struct xilly_endpoint_hardware *ephw;
>  
> diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
> index 931d0bf4cec6..0ced9ec6977f 100644
> --- a/drivers/char/xillybus/xillybus_core.c
> +++ b/drivers/char/xillybus/xillybus_core.c
> @@ -1783,7 +1783,7 @@ struct xilly_endpoint *xillybus_init_endpoint(struct pci_dev *pdev,
>  	if (!endpoint)
>  		return NULL;
>  
> -	endpoint->pdev = pdev;
> +	(void)pdev;	// silence a compiler warning, will be removed

Just out of curiousity which compiler warning is this?  I don't think
GCC will complain.  I think there are other compilers which complain but
I don't know which.

>  	endpoint->dev = dev;
>  	endpoint->ephw = ephw;
>  	endpoint->msg_counter = 0x0b;

regards,
dan carpenter

