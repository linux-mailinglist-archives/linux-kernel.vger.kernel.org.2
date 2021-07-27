Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148C03D752A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhG0Mi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 08:38:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58914 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236419AbhG0Mi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:38:27 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RCbDWq030217;
        Tue, 27 Jul 2021 12:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=OLikN6/ldUOu2HDAbyO7EN7THzEQovye/QTrkcgAtGo=;
 b=v4leiZrZ+25a2+Ton14cq0vBSEpXq5gTTjlz8u/nTEKm0hk/kwrmoGZ5HFewXEwxo+Iq
 j8K5vICKX6u6CwymWq7TVyQqriKyrN43uU+EEDmcKe5XfcU9KZvYEfCwyn1/PicE+zPk
 pyaKv/O6kjpUMF8YnPcOdCK8VMdXO1k+r0yi2IvTqiH88/3FLlgSpLLXLRAw649oHpe0
 qZ/fOjVOo2tFJerVl3NyJeff7qud5fxPWNKocnfOGIeJfsBi8fekB6YIJSGHtXYZg+bQ
 YEFPXelZ26tHD1uwTF6hPPW05PggQAxC6EgIvYR3M6nYSVivFD3hpHcgJ+XxlpUMqzGf dw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=OLikN6/ldUOu2HDAbyO7EN7THzEQovye/QTrkcgAtGo=;
 b=os7vmFB7/47bPLnFPK7cyvgI6O9kmZjQh83dBUdJd8OzBMBGsek6rv2b0YFsJHsr6Dn6
 4L0wY01fGPAP24onT+NGt0HlgnyU2LfWKYJPJ4mLP4pVra0rV8kkJpJyB1Z98aAC6T05
 TqVBhPB7CPnemWgKaRZUSpnVCV2KnGd3Y8/PX2gxZ0OP5HKqQM+jvtHfX6lIR64SeoGU
 kB6sbD9dwHJzHqYroAo70SAMnmIV+5iJOM29W2lOOZM28kiVf4EMeBpUQd5w/l3J6YF4
 iMsOewTe4L94HIg1l260TpMHjvUG+IKIUM88y7X+mVWmtxy9M0vtGsBdo+b5v3Xb31Pz NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234w1ph5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 12:38:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RCUoFx053043;
        Tue, 27 Jul 2021 12:38:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 3a234ve1cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 12:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq5n48vZOUB+evWuTVNC2zRQlpORp03Vb1exTtbLmdBUcr31gMXa4ME9x9CTwwc/vONSoUxDV7nQRlsVFoj/3I1p3sFRMRyAJKiICj6+r7yDrL536scgqWdycFTm5NnsBM92d/5HhqT1Ny9okk0g+/YfTxaSuA1cGSLd6ByXgOcUbIu1QASE4QcHSn8m/39GRwTJaZhrXRiKGFyq1w+39IhE4K873Sj3va5U5LKx9tAjNu1T/wad2fjW+ivJjH5nUEYScSKgXMpiodZ+Y93t/JOmXzq2C34Lw7TQeSSXPjSxVoayWI1cUOFlAj6odDKDEmEpKALKGVjkpVhCA3RZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLikN6/ldUOu2HDAbyO7EN7THzEQovye/QTrkcgAtGo=;
 b=jNHrFwEqyqOSCtTfC0uuX/e8adm6R4yLYQy3AuKKwYPt4i4q9d3bCJsfGZDuR3DULVQM32BUAJc2tjY4s+yGnuoB7AibDECwiQk0VeTLXM79Fxcp+xrqyRX/dIhTkcNuiSD1f5xj5lJqnRy4U7BoB4ETlYF2dEFFp0aJgbyOPrSlK3w8vqWkznkHnTgLBEI/7uy0YAs+TCoQzt0L3mcXBORSwyfbIKlTtn/p1cfSccFZJkCjajhj0m5Dw5nmQpvAQDwhlNSuh3GfGqTsly0VF4bsJGj5/arjKTAMZPwsjgK27KNYGRTpJbYhCocGz6kaBMkMCdKwIf8V7sRK4lSM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLikN6/ldUOu2HDAbyO7EN7THzEQovye/QTrkcgAtGo=;
 b=TVdTh/JYmxKeql7pHwjiUr8swHyucKVrPbZOz7FPBFBpDN9lx7cj7OKI1fieLmgZpuLnXVKFdupW6n+5yS1P9KkcPBbmUigZg5+e0dE4Ou2M35YfpFMle5BcPd1lP0vMFGhxME6Jzf538onnax8jCpnJgn8yF/tUtKyXAt4lq2s=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5460.namprd10.prod.outlook.com
 (2603:10b6:5:35e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 12:38:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 12:38:14 +0000
Date:   Tue, 27 Jul 2021 15:37:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Brother Matthew De Angelis <matthew.v.deangelis@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tablet: acecad: update the reference count of the usb
 interface structure
Message-ID: <20210727123756.GL1931@kadam>
References: <20210724205542.GA549014@pc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724205542.GA549014@pc>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Tue, 27 Jul 2021 12:38:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5b83889-c518-47c6-152e-08d950fb668f
X-MS-TrafficTypeDiagnostic: CO6PR10MB5460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB54604B5821C01643001E7C438EE99@CO6PR10MB5460.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hf/Exq86TIC58HH0tte1CeryTbWLSC8d2BImyZrYa9/GCi5fYYowMskp6LkADeOgT0jd9cAeOszUM1sFQRnFKbUlRflNwM3ne8U6xWYldzzoAZ0NIWifsL48i25AvIGHF7akCUyvGaWZmaluxkGuDq1vkPwRW7M633Yn+qleyTOdzKW1nHoVwj4swr6gzYBVuI/7jts+rMxcEToB9uEsuU4v+JPwSagfzWuwtUYhQdKbB2YDaCUa9RXDdu+EfOn2ywa0j6ckOuHYxHb9Vs4ViWHNKteePV6ISpjxH+Jn1CDBQhvNGf2hBiNdqrHlmz1izeIxtwqk4cHr8JzTGaoFrfp3nErm+NwEDm5VyhV7wa0eR2hX2tAg+HGtRlRULu90Sq+DlueYAYKsEeLjqesN3eZXXOUwOsg2IJw3cJGgHPGBYoScXoZVIx9bpD+mrSOYIBraVW7yEuWvDRWeYzoSBC2cHy41lOBkye4Eu1G/6s0hoykV/Equp+CVfOYIJxgHaiOyRN8BU9ZQZY2wND02r7eezaUc3tftPCvb895c04Q8FjJi8gVQozbaNXmDkjssqu0UdHG37hijgTIgicHQJjkXcg9ya+8jewwASIOHm99fivlIX20g0Qjp+j7ly0mI4An/XlJITPKCZjLZJbjHLu8vqOA72NbLZ/VCCPqGyQIkF7H93T8daflh2xy1tMT19VsUVSEQbmf11jhmROeGog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(396003)(376002)(54906003)(33716001)(8936002)(86362001)(8676002)(186003)(52116002)(6496006)(9686003)(15650500001)(956004)(9576002)(4326008)(6916009)(1076003)(7416002)(26005)(5660300002)(316002)(44832011)(66556008)(478600001)(55016002)(2906002)(6666004)(38350700002)(38100700002)(33656002)(83380400001)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2b9N2Omi6fGmfExRTkhs9tu7fOPOdW5HbvWhf4d22hMGXbzsC0xOvS1DiWWh?=
 =?us-ascii?Q?T4gZleyosk2CzBweriZ4fVNjIklhj5UmCWQJVrMAk/GtPi9vlOrY3ru3SyhB?=
 =?us-ascii?Q?Ago1ObGve+ytpCpA7BvxMQ/xwXRat7vbuas+flus535Ys3XOi01DWB8+7tz9?=
 =?us-ascii?Q?4vUBSDj+/VmRcuYJwAMbZqqL4Pzpe68Ygz4dh+T0aALow5QbnUfJVMs58aL7?=
 =?us-ascii?Q?Vw2Civ1X07svwfs/ZAqbBA5b5ABmL4cYfg6mfNn5pHzsIyefJzExUpY9+Q4s?=
 =?us-ascii?Q?aoTkGOAUjz2qbCxC6g3nD7D9RlfNBMzwAYJlQQQcbJlMwy/nKKR1IIbJ1hzq?=
 =?us-ascii?Q?KGHzQPtpqesFzF6kyXHjwCKRmD6n0UHsWqLbf4wgOsbpHBfUuHm+TC1xQHs3?=
 =?us-ascii?Q?M7J5VzASD1BfyxPKctysK22U0v8fXqgA4yObdiSlwfXXCrC3YpBb5ZtOIRBt?=
 =?us-ascii?Q?3coNWJbo1MrCDPxDm3F/agNsA8+F+OnRMHxj7mfY8OxOsv+dVmwY58s80uS3?=
 =?us-ascii?Q?7hJJ20bn9iLlZ9+aLtGAgDPHSX51x+9m1AQgHR/W3/zTU0uSRSVeNhfTnz4S?=
 =?us-ascii?Q?nPKJr32/JV67IDd8Khn73Tb4yf9qqvOBKUMPp9/oIoQPixoWka0ACF3AGgMc?=
 =?us-ascii?Q?eVgpwzztaG0A3aW2XJf7NZjLzNRq8Zvh2KRx50yK6XoIY1zanYnc/GIXBxN1?=
 =?us-ascii?Q?kj6hjoGJFnwYZCTxs5W7jCsxJ+1FIKSfWfrqQZAnPqTUMzPgRxSVlSugpOiA?=
 =?us-ascii?Q?I3durD2wGeRADcEAsWWcecL0ZE7yRq8rWymh6MLB2s9GIO9xc4Bl90nmRxr1?=
 =?us-ascii?Q?OUUPpAIO/7iPjuAJFWQ+UdDJNlsTYscX5NUSqlnu9ycL6OY7ptSyNai1k4Ik?=
 =?us-ascii?Q?cf9i5N7JAmKsRzyiPm+MUnpoEsJ981aOUa4Lhg5nppKHTs2+3cAQVTjTORlT?=
 =?us-ascii?Q?7bdiz4tbvV/pDLXrM0c5wYweQXVXub/LPzOfXxwiw6rW4STOaDydVCuw+xcT?=
 =?us-ascii?Q?ZaQVlqUbCTnSAEpffoXOdRAFkeAOHY80mElOqDeDI5mTTmJ+wyvux6wvcU8O?=
 =?us-ascii?Q?RZ9vxd+LqgQ3OOe67awY0C0HX8Ik4e/nOtAZG4FR75byK3mgcUBOY8NMiHYg?=
 =?us-ascii?Q?J/lbjD3Jpjs41PBTU4xAjdNngbZk3fY/4Fl+FHiliYbhD8XqSzhw15kwfd9O?=
 =?us-ascii?Q?bF5jMtZ8mfiBi+IJCUJfm5o9uHMTLXW4RTZiBSf87OkrN5Bqp0F3p7som0oi?=
 =?us-ascii?Q?j9PJLFLCOjzwY046plEDleQO+ojf0jMjoLjyBTR71ggOOtUaOtc58Lji42Bc?=
 =?us-ascii?Q?uC7uF0Y4qulaiUJPu+YtsVvM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b83889-c518-47c6-152e-08d950fb668f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 12:38:14.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPmL4PDHKaypMV8ZldwLkl8EsgAvBYvyi5zgPBieST0oYA3nCgEeH0KhkBFvjx5/IL7F0unGgC3VGt1WYqG4j/+ouFkCMuLx8x8CIUqu9Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5460
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270073
X-Proofpoint-ORIG-GUID: GELP4Yx8YBL6mNK5DYn3xanYCLCaBROP
X-Proofpoint-GUID: GELP4Yx8YBL6mNK5DYn3xanYCLCaBROP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 09:55:42PM +0100, Salah Triki wrote:
> Use usb_get_intf() and usb_put_intf() in order to update the reference
> count of the usb interface structure.
> 

This commit message doesn't say what the user visible effects are.  If
you encountered this bug at runtime then please put the stack trace in
the commit mesage.

Add a Fixes tag.

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/input/tablet/acecad.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
> index a38d1fe97334..85fe134a30ee 100644
> --- a/drivers/input/tablet/acecad.c
> +++ b/drivers/input/tablet/acecad.c
> @@ -151,7 +151,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
>  		goto fail2;
>  	}
>  
> -	acecad->intf = intf;
> +	acecad->intf = usb_get_intf(intf);
>  	acecad->input = input_dev;
>  
>  	if (dev->manufacturer)

You need to call usb_put_intf() if input_register_device() fails.

regards,
dan carpenter

