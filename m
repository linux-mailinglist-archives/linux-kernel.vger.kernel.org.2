Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7F53DDA93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhHBOQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:16:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43502 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236306AbhHBOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:05:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172DlHTF005668;
        Mon, 2 Aug 2021 14:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NtaE/2dvJxZI8QvZ3k0uE+Iovq7rQnsPLiPQveT3BTk=;
 b=BYZ/13UKOQVaSRWZDNXh25j+ahoRbLOuq2oVMOyPCtXW380Or18r/Ea1ULSjLculbMSr
 DWifrxVECflOjlFb8/kcyrgz+jC2HI2NBBOtxVDhKDeuW47eVGcLIiwkOwkxYJWXWQiW
 tdyZOaKALisGmDkU7hy6ASkAVId0J4MqmEAj4f6YXAUV46rxjNaS5+MBS2IwkQVFY2ZZ
 KT6fc2VijLX6XvNNCNTQLI0WBMV6erCxWNdaOPzRwlGZSmpglxqtsUkdjokB/tP68bmr
 TaZROWWawA94ozrkpdEPmFomMc0X+xPOA+8CdYEuIDFG3bfZB4MVLgpgtphVhbuD0XWQ bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=NtaE/2dvJxZI8QvZ3k0uE+Iovq7rQnsPLiPQveT3BTk=;
 b=co9M8XnxPVvY+c0gwkRRDO6a1ze2GOctYGGSimWiNcT5oW5HIYedgAnmM0ebI7C0cj3O
 1OQzSf5YIeXDIIRw+paGgJ7U2iY5dC1KXz6Cq7C5V2/KuslgMUseI7Ca9jJarAXS/+j9
 9gA7Vww50RdFtQBGv+KZ9X5Bt6lPhBES0FRx2bqIKiRtwqx6dKAt3/jeLNV/k0FrsQcM
 t/GVVu9uaG45HHJJwI7FaaI2BawoTihl1Dxac1E6kjKCcUvELWt8l/eq0PGUkGeVYm6D
 knz1hhw5JokjfLNAFPC4vvlXMYBwwqOhZl9UBSnKmN+/68nlnwNpCeGoRhf26S77H74K sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a65vd9c70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 14:05:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172E5I1H105904;
        Mon, 2 Aug 2021 14:05:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 3a4umwr0aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 14:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDNARlIl7wJ1Qh9Vfu/JkQ15kVr5AraSaxDbhfxnS54OFKyHmGbtgEwtMB3ouvQS6kBEPfp7ka/AIT0xnVhtrbF0ogpbAMxE1VO+O5cIySk4W6IJuaxJv5zHYVWAqDNtk58tWNmZoAA9SVRGelG1WUMWrz50lUMaAylr8qhAAwoy4pHduGuKAPOE/os7B8xAGusH9diQ92KBWoIwLaTrvttx6b90RZXj6/bdjgLwabvk5EOlao8fSibo+02A30TbCnoS5g+tTROPYOA5FW8+b9fdM6yRXlE6ythCqh88A79vq7txzH1Y/5RRTGH9w5ciAGO1BMDRBl/jHx4Q9BfTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtaE/2dvJxZI8QvZ3k0uE+Iovq7rQnsPLiPQveT3BTk=;
 b=NxUKWa0pCXUVtYtBKYtJV80K7Ao8J7rdkUcU2yM1z9E+ORqbr97S+PR71nSrAvTRZObZ1ONneX+/hTHYqthCRmRwijBCubPP3lXjw5LxT8iAsoxNc148xqxRESnFC9dJspl33EEAnCy07TJJ/SGnoCKfaXm8fOQWWS7/hVoPG97rY/9u8L9fm0MYFUX0DJPgT0exxEhJFKtK+KrTxMjtXPAXOUB3lCopKqgymkm9VlqvM6/u59gCJZCL5GpgK00NFGq4LyeWzzRXlV83nXofB/zfsW5gQDsV73ELf26rPEkUisE9egw3qh7f8t9slyNQCctejYLJG3+HEPtE007MPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtaE/2dvJxZI8QvZ3k0uE+Iovq7rQnsPLiPQveT3BTk=;
 b=eIGYQNAyD1BNfUyNpsjKOo61Fycue16zyEsX/0QGsx02qROOmfgzzLD0KAnZzxPwHgIyq4qVtf77HRAQ1Hj2U6RsrzxPPNzm8LHD/yqnGniVXIE8uqqRJTUPVi7rmxOxLSrMEAP+gFwp4FNwbETlvAB+eOJzXrpxJ+h7NA6zuX8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4658.namprd10.prod.outlook.com
 (2603:10b6:303:91::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 14:05:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 14:05:25 +0000
Date:   Mon, 2 Aug 2021 17:05:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in
 assignments and parameters
Message-ID: <20210802140505.GZ1931@kadam>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730181452.23062-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 14:05:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec7c1872-6be1-44b6-e934-08d955be934f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46589E211CB7D86C7E898C638EEF9@CO1PR10MB4658.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afXlNMtwg7AtCA308OQRJHbe7ziJ/lRvOg2wk7qxcUgGQYesokFpt7tdNiIHbuxY1nQuUbk8+sC/xJOwtntywrD1OiU41G0t9uTzs0EGxBhEmxl9zuNZhe2KHFi+UxbPBfZYKpAdwiwJiTYCYVnbZU9A9pf+kp2NDuf9PXPkrAtwb0L6bY5hpwwF7UEsPsY882WzGbfj2RvSgPyYQOpIqFiq8dNJJP3YLWpzwZedBtY+gO89+x+ecyxGpAtSzxO+zB26DBddUNvLgsWupqqgHSpCc/hnoCdfLQwyJfeMaG7TI1F02sgLf+NqjIBOjEBF0XrUxsBI2v3+/tlAd1aSnaKsdXpsEdGQ3k7BHWIQi5+pH9GazlCc55HYkjVaBkZgXMSYM/a6A8qGLnoQW1eWRCkgnmdxl6gFouN1b3CdZCCLgzUTmV+iuH8FJMEd3zNGUd7rpca2U/XzHcSreLhWHH0LgtwZOce+9JjLOIkQ9yuxbjK8t/y/txfXvUZjUKi8sfu/njID1mta4Zss+AfL0Dl2UAkq1qmjioUX2S7M805BDK0Z6lBQlipFwJ97Qfw1xAn8MK3CG+huK3rNgLKA/9MaPwV40hs/jGir8uOoQ/OilqcNyF/ghzv5vw7o6Z9LrYmvpKbHhkPwD2YdUtA5MW4o8R9r5L9Kw146emTc9SBWf/6WkVrrQW/yMu/JDyMocqUFFC8yv1fcQpJZclEUvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(136003)(39860400002)(376002)(186003)(55016002)(6916009)(9686003)(1076003)(8676002)(54906003)(33656002)(478600001)(26005)(5660300002)(38100700002)(83380400001)(4326008)(38350700002)(9576002)(66476007)(33716001)(66946007)(956004)(316002)(6666004)(6496006)(44832011)(2906002)(52116002)(8936002)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xOGmR6AyBjyx8xt2x76yK52m8ymTP8QbgFoBxOsqaIzD5Ytp2Ekrd/WpK6Ml?=
 =?us-ascii?Q?s/rVDH/iVZZB1cPlWp8nHlPwihUk8qDuypAfBtbIRdXCZ0lz4y0sGeV9SgAx?=
 =?us-ascii?Q?UlkPOfEmVNH+7YKipWnGpKDTVwQ00TkytkIoqwdxO40Acg3oOAN7I/VyU/yl?=
 =?us-ascii?Q?hz2PDHyVG21ccbqqjwJUpaP7lbmKMlGwYZmTRvdX/FmQKzmqw2VNgRBB2oH5?=
 =?us-ascii?Q?x9e5mW5G6IlBPsqpXYIyGXcMhG/5jqLGxAVkYaO9TypuinlV63r/FtfW9gAr?=
 =?us-ascii?Q?qPPuNdO3V2oxJeEdNij2RGXIx8fFpiDF/6CUzMOXSD34sX0MMtCt0lSp1Mnk?=
 =?us-ascii?Q?16gD2LeeWjNqfVfbABfwV3PobH8kh3QPMbVikA2LOP/FZQOY0kjh89uNDvcF?=
 =?us-ascii?Q?bW6le14tO7afCCruSGar/U/Sf9oVdRTcxQRN0gEH7BorOYpm9B8SenOQWAk1?=
 =?us-ascii?Q?x78Y9g4QGSKljF04D23DMMxZ568vL401crbmbT7pL6IeCGoGN6aKzYq8wxor?=
 =?us-ascii?Q?oYFR0tPnIiV8FLYxe+IcfZDJP4N6Mq+JakgtYMqVKGhevps+mkVghbnkpztC?=
 =?us-ascii?Q?Q4geEns/FwPiFnEJj0AF1SCUTOFEEtWlgRd0rJwWOa6G+WZm3UZSEklOh2hW?=
 =?us-ascii?Q?SKd5vkvGE8WYQdar+waEWLnMysweOQHrr8n/fqarFvIdToCNf9jlusz+R/zn?=
 =?us-ascii?Q?I2rAZB3MaidvepKDERcFWg6Sgs0SLWLt1W8NGgbFghKg46FDKJJnVL7o/Efk?=
 =?us-ascii?Q?P/64gJAgE5OP19KliwRtm082YwJkbc6J52IremO/PYANCGZiYL6Ta1La4rqF?=
 =?us-ascii?Q?foAztQzpzrbMViI23qrqOpUJdNSMJQyqsWx5ZwE0hm3qT0hs32s8+CKtvbSo?=
 =?us-ascii?Q?XGSpEn9nKkG1cPmkpsBCgqGzw1dwA01HZQNqJXJ2IO54cI1nlpd3pVPeH0op?=
 =?us-ascii?Q?lTTZWLh6yST+eEPO1qPXm6U8cBjz0DevU1Hw1jyznAiLtlY4k3TjwwvZz8ed?=
 =?us-ascii?Q?8JDb3mlW+2ZCOeCOriI7DOjdzVN/0NddN8xZ+ZlNkLIzBA1KsNM0ONJeC6al?=
 =?us-ascii?Q?W1lAyextPeylFWxbRvPEP0znBF3FADKG9yplw184aw+9grlPCbEwa6cpICnX?=
 =?us-ascii?Q?Mvtdq2FSRhy+8M4s/h2AmeDAy/LpGbvi4wcS/v/UyK9FMLBCCtOBdIzh1eZK?=
 =?us-ascii?Q?3P32KSAVBZAFcYgeWD6XPpsDHQq93xKzVC1LAj2cu72EARqCusjn7uEpZWhS?=
 =?us-ascii?Q?grAwj0AkqMzQXfculbGkBKMSh8Toezw6KLjHqG7l6ohsROhEyk7j32u5ZnkK?=
 =?us-ascii?Q?KZdN2KPEBO/zl//Q2FKytZWV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7c1872-6be1-44b6-e934-08d955be934f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 14:05:25.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 255BSOnhgGT/EiVxfbJ+A5zFWHd7b2wkjHRDtE4r2YmPx7QZR9unWPnp9B9HyNNT+hj8/h8mmZpYOjNBLM/3Fi/eqe3YBFU/Wx2NOWjKu4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10063 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108020093
X-Proofpoint-GUID: wo6YOzyEilwqCNNf8DOkYV6YmQCHFOFb
X-Proofpoint-ORIG-GUID: wo6YOzyEilwqCNNf8DOkYV6YmQCHFOFb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 08:14:52PM +0200, Fabio M. De Francesco wrote:
> Fix sparse warnings of different base types in assignments
> and in passing function parameters.

This patch fixes some endian bugs but it's not mentioned at all in the
commit message.  Did you send to the correct patch?

> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 46 ++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index e00302137a60..31ca2e548555 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -71,7 +71,7 @@ static inline int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *t
>  	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
>  	int data_len;
>  
> -	data_len = tag->tag_len + TAG_HDR_LEN;
> +	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
>  	if (skb_tailroom(skb) < data_len) {
>  		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
>  		return -1;
> @@ -134,42 +134,68 @@ static inline void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr
>  }
>  
>  static inline void __nat25_generate_ipx_network_addr_with_node(unsigned char *networkAddr,
> -				unsigned int *ipxNetAddr, unsigned char *ipxNodeAddr)
> +				__be32 *ipxNetAddr, unsigned char *ipxNodeAddr)
>  {
> +	union {
> +                unsigned int f0;
> +                unsigned char f1[IPX_NODE_LEN];

What is going on here??  Why is f1 six bytes?

> +        } addr;
> +
>  	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
>  
>  	networkAddr[0] = NAT25_IPX;
> -	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
> +	addr.f0 = be32_to_cpu(*ipxNetAddr);
> +	memcpy(networkAddr+1, addr.f1, 4);

What's the point of a union?  memcpy() doesn't care about endian
anotations.

>  	memcpy(networkAddr+5, ipxNodeAddr, 6);
>  }
>  
>  static inline void __nat25_generate_ipx_network_addr_with_socket(unsigned char *networkAddr,
> -				unsigned int *ipxNetAddr, unsigned short *ipxSocketAddr)
> +				__be32 *ipxNetAddr, __be16 *ipxSocketAddr)
>  {
> +	union {
> +		unsigned int f0;
> +		unsigned char f1[4];
> +	} addr;
> +
>  	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
>  
>  	networkAddr[0] = NAT25_IPX;
> -	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
> -	memcpy(networkAddr+5, (unsigned char *)ipxSocketAddr, 2);
> +	addr.f0 = be32_to_cpu(*ipxNetAddr);
> +	memcpy(networkAddr+1, addr.f1, 4);
> +	addr.f0 ^= addr.f0;

What on earth????

> +	addr.f0 = be16_to_cpu(*ipxSocketAddr);

I'm so puzzled.

> +	memcpy(networkAddr+5, addr.f1, 2);

This patch is really weird so I'm done reviewing it.

regards,
dan carpenter

