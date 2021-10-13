Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971E442BBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhJMJpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:45:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17444 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239219AbhJMJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:45:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D9Noga028297;
        Wed, 13 Oct 2021 09:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=5c8bJ4tN9RRx3fPLcKsnN14qIcXux1VzreokLjjR5zE=;
 b=yFZjtu9juYrloLm/tvc6uOWeH1cNifsVRs+RlteKZOwe6f4KbN4gDy3wXgKJT3Jjvo0u
 FO0tu/saOUGSFl71kr57Z5hsdOrlOaf/3iZvFIoLGL5D5AgOkDjsC2Mtl9fGg1YPirVm
 AWVbXJSGsjLtzFpwOHh8mkSl7kQKQXnMvYqx5jI5HVIlXfQisMqqfljjASXmM2q2azsL
 EJBDKDpxbafXNMA2sQhtYeIxmv1Fb8zdTCpBqXoQQKNsx1fG5uuW4LoPutSMhhTbQPrE
 kvzOgg5tO+R2TfBPuzWpikppBaH00tmwYxPF/oo9ZT7Ub7t6PDL9fm0Gat0WXSupnBZd tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbjav8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 09:42:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D9eTPE172016;
        Wed, 13 Oct 2021 09:42:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 3bkyxt5qxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 09:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMWZrRIhR9lajQ5VWyH/2eWcKbKxVwyMvlsXTJzBLI/6k2c8pYiFSgki/a3hu9oXp96+G4ANcX0VHn5XeDwnf8M39VQ2U6f6x6qfjRWqCn0BIe3+UmL3lEPTlLgHp8Dm64WuVkXhaCue/LnJOTYGED+h4deFwL/Lpd0ywS2j5PLmc3Am8S/6Y+6BRWy9RAC6CtR6jiX5wWHeMRRqECEAdkkE59KQKA6RoQsDxjzvbs0tMlcJ4qYSYwOFVGsEAvhVijvYB5n+pwFDU1lFEtgi0ADSl52vCh5EiM8dClpn3efHG7AsS6xsmCde/tefASbFlQr6uBwLWoaXOAASUXVqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c8bJ4tN9RRx3fPLcKsnN14qIcXux1VzreokLjjR5zE=;
 b=NJnYvgO1VyURQsSfQ7oyDKpLj2RcQgVBHIAfEmjHozGEfbZX7dnj0M+l/NOcjqYQ4mjofYpUfGL3s19nLqB02QrJZOobhMFF//iOVOrhxLU+LyQs8v9cMAMXohj6KSjHRrsDhLLZbWNAVxNrkatBVeLuahuaMBhDKIikxDoLUFz2Ebzjbe4ss9LBo7cDPhC/3VQO3DlQKqIl7xWBBGfLYZu94VZukxxxNO57t4JBWlLV7grkUICGMsVYI/p2obPdZPZaUsdDn0j9+2RDbf1sjpehM0fBNv2OsGQuhR0OYmDJ11x/eoeqh2GqoUs52wMXZkrcVISEKnWCMfeeyLcXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c8bJ4tN9RRx3fPLcKsnN14qIcXux1VzreokLjjR5zE=;
 b=iTj6Ig2t0TQ+tC2qCNkVaa7e3k6T1JCnpOARrkuPXMt7WBGGvwXJ25Oxe9lE4PNN0+sL4t8wvPLnajwfvctjIsGENRw2cvnQtKwnayM86cNTKJ6qXTNtZVA4p/2lybfSuKgYpOLQZRbvUbzE8NZZrXUQOoANGiCt4E8bet7+jJY=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1816.namprd10.prod.outlook.com
 (2603:10b6:903:123::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 09:42:51 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809%5]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 09:42:51 +0000
Date:   Wed, 13 Oct 2021 12:42:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] staging: r8188eu: use kzalloc instead of kmalloc and
 memset
Message-ID: <20211013094227.GJ8429@kadam>
References: <20211013070149.349-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013070149.349-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 09:42:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e551492d-e914-486c-239a-08d98e2dd29f
X-MS-TrafficTypeDiagnostic: CY4PR10MB1816:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB18166622CAD07A0A1AD7E3748EB79@CY4PR10MB1816.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWQ5LNMiuJuO1vlibIKCzgZFFjWQ9usOzBZaMZNKuHcL5VEphPfSLuPsnMq8DSzrte2EHShYWbWNb64vpbUAuzfv7WkCmDU/UoI3VGqmJ9rY0RvuCYuRGcm5v6uML9jvBmUB6H+JEtxfFgUd4JafE6pAB9Jjk1Ozz0/NcMWexuBDLxFijVEDsPCUokOOf90qH5bJ0sgiLDcqez4gx00NEBTsUzoOmOE1QR4lAHiJXVdGrf9cFV/6hS84Hvc+W5Jv4efJJsp+O9XUdd/+p9oXQ8bI7JjaKRoHuZdYrgMe5t1kldmmG06nRvEkivcuYJEIr+wbGtDFDOc7L+qDi8iseVKSeXLpX5xYiT3cX3f7rF3qoaH7dCihDxiWZF/ehBuNM8zmHUKpwdtnEDOLAB9S46062LngbWQY9nACT9L0W2JXrBmyc2M0xzcafvqlhnsG+1tNrWOEbZWJkDKBizQS1UnocfjQUdVb0QfynMEnVT/T7AzQVvXNTW6dAu3BqxzYlw15V1Fux3z6bMUdInnyK1OzCDJtiS8vUjLdn2aQs2LwBLqiETwjjM7UPjW2FD9qCg6UYBjs9zOc2jLxci9LfVTWNMKqR68IViBR6+UPNNwt7/cLpZww1e2pM4+wm9u7BI/Yx1EbN5nWlntbpsC/TyD1+HEeWeOZInUUKArlfMzvmysKgEbDpaheWQjUlXTWK7BYXhov6k5UTv08PkUABQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(33656002)(6496006)(5660300002)(38350700002)(186003)(508600001)(8676002)(66476007)(66556008)(9686003)(66946007)(8936002)(33716001)(1076003)(9576002)(26005)(55016002)(956004)(38100700002)(2906002)(54906003)(44832011)(6916009)(6666004)(83380400001)(86362001)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ki1Hv5OGKIXmY6Y+8VLBRvJHBTbBvERZp+/dS6kaT1gU2dBviage9PrywIDR?=
 =?us-ascii?Q?BH0XRr3Xz4DvzgwovW1j4tOCsFEtsTYwDt4umuFUFP720yZac+IhkzKeiqgg?=
 =?us-ascii?Q?Iut5FTcfpu/2PTaKwwhVryHYvEgUimyXcacPzzXaORdwUIk/E1uc3r5RKCUE?=
 =?us-ascii?Q?3U/TPtAHb1c6fAcK6hP4J71xAcTrhFH6HOHMrAtxAiY7bA0K4cp42IpnnoCf?=
 =?us-ascii?Q?ukLOlspikKiDUKAEGh6PR5dmgoJcwQ4icrseut5HXKQc8VtqqxrXbTtLhQjh?=
 =?us-ascii?Q?qExZz72UqHrbdM8arVhoHZD3r7EVhEoTXIOzylPlWjuaUOwEt/8qNaQQ/TmK?=
 =?us-ascii?Q?Wwv+4NcvukABycfov9NPvEr5xOEBMOWpC/dtqpJNnSR1sOXPmKFWWF4Nbxj+?=
 =?us-ascii?Q?f41KeSUmrRjSoQafICuVK/NyZQrxk2UT+5LQGiccvFlNPOdCYDzhH7WRmp9Q?=
 =?us-ascii?Q?fL1Il0+wA65VQCKw40b+pHfwMs9QUgHh2/mJHxV7ICU7bewSBA8abhhP1vvR?=
 =?us-ascii?Q?/egOmsDVKJuYQF4HhESaPOgR4XVAfx9uOhY1GCRWUWrrBIeyNF50mc34xNL8?=
 =?us-ascii?Q?KH67aPWkJc+VteaLm8pv5bS+DMgkYjwP0gpxo7vFcpcYONSaOo/6QSFX6sUd?=
 =?us-ascii?Q?BX2hdEz/Fh+XlKssDxPu0wrrFhrNqoY9BmiJI+mtlXkSojfEMQ7jDvxxLxoG?=
 =?us-ascii?Q?rdUsUoCp7FraquNh2HWMER2qlb4eraLnJnaN5PW97Ts1C5ExVhuib5WyXhz4?=
 =?us-ascii?Q?yJ2XmkCdetTXeN/hxLCARGaej4RmiZ5hEEh8WiUs1xKlh0AvDyExuFtuS0m7?=
 =?us-ascii?Q?lhN/IXRUfNnktocC+2N0JH1rRgD//3UP9QrDTgJtFvlLE96FQVQeSJDxMHne?=
 =?us-ascii?Q?ROV8EWAiejZW+lqDJpZ28+iButlehXyVfZp2mUaLpP21js/nx5oiNQsW6oQu?=
 =?us-ascii?Q?7tAp6vFskB9lPF+DWNB3872LvQk4mUM0wbeDQXQdZMK6pzcPTjypMHSLkmqd?=
 =?us-ascii?Q?cGi3eMkYxhsP2Wo0rtnmnprw15DNxSp8ls5dyT/Pb0gnKGHrjnxpFj5SbTxN?=
 =?us-ascii?Q?XkJLyNcB7yHTG5Rv0BC2n+mkr/1MS7FfrfdkBTVuSXN5wY7fg0Inh0PrUQII?=
 =?us-ascii?Q?5Gon9LOyviaqmYAYxSJwDuwlYeXdTOPppwDCpEoJA89Uu8W2jIvxyKp3/+hy?=
 =?us-ascii?Q?J56+3/WXe6SHVK3DxUaZSdk3kVDS6wxm52ASnU09BPOIoZTlkjEIf/mi0fqk?=
 =?us-ascii?Q?silLDqbm/nsePZXwGb6tN93rPeAK2amjFqFhawqlhmogO3KyUWiVBBa7oEdy?=
 =?us-ascii?Q?fD7oki5TB8+XK05yRgGNIkOQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e551492d-e914-486c-239a-08d98e2dd29f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 09:42:51.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb7u17esbDyzCi7vPCFQRi1C35ep7MaFI/hERt8IWvLWugPacmZpJp9kYWZYmrqDxnCIadts0ChvIpT37bjapjpabE9bfKhNzpJjZSHK0uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1816
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130065
X-Proofpoint-GUID: s8vpF2K86tV1a2KA6azQUmLztqEK6JeP
X-Proofpoint-ORIG-GUID: s8vpF2K86tV1a2KA6azQUmLztqEK6JeP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:01:28AM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/staging/r8188eu/os_dep/ioctl_linux.c:422:10-17:
> WARNING: kzalloc should be used for pwep, instead of kmalloc/memset
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 0201f6fbeb25..51f46696a593 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -419,11 +419,10 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		if (wep_key_len > 0) {
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
> -			pwep = kmalloc(wep_total_len, GFP_KERNEL);
> +			pwep = kzalloc(wep_total_len, GFP_KERNEL);
>  			if (!pwep)
>  				goto exit;

Not related to your patch, but this is missing an error code as well.
It should be:

	if (!pwep) {
		ret = -ENOMEM;
		goto exit;
	}

regards,
dan carpenter

