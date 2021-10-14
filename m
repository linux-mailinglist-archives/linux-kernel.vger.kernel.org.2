Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7442DCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhJNPBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:01:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30222 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232333AbhJNPAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:00:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EDue0S001729;
        Thu, 14 Oct 2021 14:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3yS9+5H+JDILk2p+4wPwP7D5PVr/5f/1xmvnCEQK5Rs=;
 b=cR6U0dPlAjoE9IQ2jU0O/1U57alzKf2v9yOcRR5NolrRgcfyQL1EJW1ev63Px+Qd8JeO
 m/x0SzMsnWWrIOeXckB5DxRIiY4InwskKNZZOBaQRB2167dBbEK1N8HfYzUTqBUUzdmf
 2/Yzf9L3K6y0Yewo+YF5Yoa7t3uYE1VfnuNL1iZDsbAAG2ZeRuClDmjol/LeR/2nGJHu
 KTI3IHDDP8ZhADHJCeWtmJVKsmkyADhFC+vBaS1e5ibfm1+r0hoE1LbTWpWvjgGHe3oe
 3lW2J/dVG4xcdzFPdx8NlPQNhew9Qm2s6SNrv0KiQ5kbkCRru8LcnxwD2YWpHnjtTp13 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bpfy62q06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 14:58:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19EEepYg150610;
        Thu, 14 Oct 2021 14:57:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3bmae2qkw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 14:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQXFxmKC42y9CIZutPt3ygTeik0/ccLvBTeK1gqhgW3hiAg2vm9ZT6bbadHgMUvuoMz0bZDq5D/uiy9wJbApp+mKED+9ooXh06+EGRNJZH//piERtZ941E1Oqgk0yMK8kWzFWLYGsf9g1Btn5KURfRqFisBUsO/ewhqHnzs/wOUuiRC3D5ehBJSKLbjVQwbe4WYB2RIU91DEmygtE12iZmcsBZ5d6i426IzBJwx90TB3YqHSO3yw+d5oJfnrY2daDeMkU0nejgrSmDX/LccUxtPv32jTBdM8rBUG+Qkvbusot9rS+IlAMuronFTD1ocd1Bekpsdi7ndpWPRc2173dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yS9+5H+JDILk2p+4wPwP7D5PVr/5f/1xmvnCEQK5Rs=;
 b=ZAnrmItDKaSj9hAsfnQ0EosQwi3DqXnq2T1gdItdEnaF52zI6nrLEAGlMywC9B5KsPqDNKUjsVGlFpWuvIF87FdwioGp/wVbWjVfEdaRzxKXzehVIa0L8+dsivD14xf59pXKdcUV2+FNlw7eJau5xtkV9gwGIAlP3HM0yrRHGbqZWZPnj6c0VP9a6WX1T8izsUMZwyPqKitOg1/aM8aUODAojmgzXTsA3V/SzL87E9VeFsmAVwXD1/UqBYGAY8zmazpzQg9cEK88ndFPE4S7gMqaxfuJEkaPqN6+GTKgXz5eqy8j86m2AbLwBUb67/woRBX2I2Vodmyx7CpO5qqtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yS9+5H+JDILk2p+4wPwP7D5PVr/5f/1xmvnCEQK5Rs=;
 b=Pn2xC/r28K6nrHvaFnMZKPdVrf6AKw7S8z/or07AsTbEm21rcxr4rdtCwj+pOrUEg5XRmXjDLN0WuK/LPMrOxNYl2GP7Kmg6/EDI4q39YtgSOjw7LTlMZjQp7VJaUcMg5FzZS0G5Rhx6jku5dpUF2Quvp1bJm7dO/Doz3eUshk0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Thu, 14 Oct
 2021 14:57:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 14:57:47 +0000
Date:   Thu, 14 Oct 2021 17:57:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH v3] staging: rtl8723bs: os_dep: simplify the return
 statement
Message-ID: <20211014145726.GO8429@kadam>
References: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 14:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9d197e-9dab-4da9-cfbf-08d98f22fbef
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2095E531186DA438D5E094A88EB89@MWHPR1001MB2095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tAxAXakxcgftPrQSKpd0Q2MqM4fUlRm2WVnZPZEOiPJLRXACE6jkFFNlPMuUumQQVoXcPhum++l1H9eNd0LdSslC6v3q3oHe4kXHRw3C9fQI12fQBzj+cdNxC5j86mfmBednd35vOpF9QzGrJyG4VnMUpK/yuEF+IANngMUZJ1dppNlfspoR90tnEZqWepYj7gmwWJo2aMveWPjQksCFrr95dFvDXTpWFPKqjhVDFf7T//owW2uVPlgwXCClyDuO5JeYCG5cVJrtV0rqWokZ26z4eWJSz/XSKPsPLXsV+VegLaM49YhMNSzSZ445rAiS5qLLcKlPz47btg2jL/o72SGanB1NApGAamPdCst3C1sQLCJSezQ/2m9qadQLmdNoSVew4e6O/90xA7r/hasu0sXKtLJXsVvqHT7zld1z03cF6QsjFchSQQRPggL14KUCct6Lnb2/tJczofN1GOzxPXUrt+BceUQclrUq74cekh/h3u5DqE/uKDKSxiRKFNJDXw+gNDkeeGMMqf1IfzM8ljRWL+Lo1TZz9nwY3Ylmh8Es37K7y4ljfkvoyRO/P6fqLC0i5pbDNi0nzhEf2xmsrSdOJgBg4TMm1xzCjItAZYna0eBd8AT3Sw8I7NG6HHs0VU/vMMO5YzwPMl6sDtC8ctqvhmyH+3dHy09WPH4j8wsoxmqJ/fJ4hS+xHDuXIMVwRLndogrGWPC99/0qPZE5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(6496006)(55016002)(44832011)(2906002)(86362001)(5660300002)(4744005)(33716001)(66946007)(52116002)(508600001)(66556008)(8676002)(83380400001)(316002)(38100700002)(956004)(4326008)(8936002)(33656002)(6666004)(1076003)(9576002)(38350700002)(26005)(6916009)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVSoxzq76in9uEtcKQSZ7AF4WaaQhBK6MYGNQLg9WXuKkxUp3z7R6yo97lv9?=
 =?us-ascii?Q?tMfzwPz53DH6IDsTMcHbzrpg2JjoN/BLJ79QP6s+NL6NsTUzFwVbYdXkDlPj?=
 =?us-ascii?Q?cQ52jo/OXzowk3XgRPjtJ7L+Dc4RQP97IXFD5o6eAmxd0DzoN2n7wZ4eF5q5?=
 =?us-ascii?Q?OGPUSat3Mz0rDeqVDNJzq/F8MmaFUTMFR9MuINgkk6HS9LFx/W2UHIui73Wz?=
 =?us-ascii?Q?jl4rUw16cNKy1dVOvEnBrp5Md00BYrkP/l9awfjET91qOMen8d2rxELezphV?=
 =?us-ascii?Q?R9FZvHNk1KTHxtV3m+dULn9i8VOJ6p9WEj4HYsN6sx0QjSeVU8grOwcN3LRe?=
 =?us-ascii?Q?5X2o2aa5CkQkLdz96nvwppHqK9/YdH50D/KlbTC2jw4SElaZgfJP/n0ReUK4?=
 =?us-ascii?Q?AjiiT6RNaMX7xnhZxvEpaKmmamouPltomo+GnajgqBTmECmy7QIREfY7fYgj?=
 =?us-ascii?Q?HH6K4P7YjElGi9PV7ufsZ5FdcoLICajEp2hWo0e68MZmqpVMOqs+HVikPKFd?=
 =?us-ascii?Q?duuBrkDTtqajvcZfeVjlwFWEN2njNvl2H5YL2SntxeItBUk+l9czBDtK3Len?=
 =?us-ascii?Q?PXBcnEnQGkwh2zldLrPdmWTpTCXTbW0893tQIan6zleCI+GSvFy7oadDR8Kj?=
 =?us-ascii?Q?L9jQ7uVlB2HYV467bu0s18mW5KXuqMCbz2lGapTgMZAAnCzRJMmfdLA77NBg?=
 =?us-ascii?Q?yos0tbL7Ku6753ioJuQWXCg7Smy/Z+PC1Anuqh6tRZLJ7dSPEa3oGzmfijkB?=
 =?us-ascii?Q?SopeU1ugUmQNV0eKNVLp6uiqglO5JCIvQbr4RKdk1k1RvvGtHI1I80uUSIH7?=
 =?us-ascii?Q?dyH+TrYFH5OoF9pHoGg4BkJ8aJrlZJ26lnjXR84TfrrhbTLlwY3zN1k19Zxf?=
 =?us-ascii?Q?0ff0VrpDFtMhIuDKpnFkiZ64qtofR4hh34VAE8zmf9DmiV1ZzFglVu9jtpZz?=
 =?us-ascii?Q?Ej8df5Gmv8iHTN3XNf2vKW3fe0VGWEm6JwOICFPudyNO+EkDIZgVTrwMe9T8?=
 =?us-ascii?Q?4Shan23MhHx40Nskh366M+xAZT1jVgDPP5VjzrckR8Mto9P/WrvvSJ8jPmKp?=
 =?us-ascii?Q?zbFRtbUjJXkcMo9uoCtlSFJSyf283k8dqNv+7ifYrB9AS6JQ1w2t5wD31dYo?=
 =?us-ascii?Q?E2dhHGvGe1EIkwvn+XF/pR/bPHhTRoqJudyCEl3RVB0QpJ/fV0ghiDp47opB?=
 =?us-ascii?Q?3JKk/D3P7De2O68j6e11i1g+6fqEbWQjGrY0l0GC1VPFf2ZDQiCnfljkPbGX?=
 =?us-ascii?Q?awKGo0CZyPbvzInVHsZ81zJenPWRlKxKJspGUT57OvCEAuRKGhdZozkLUP6h?=
 =?us-ascii?Q?X5I4MJJ6Okix3QVwSifzuxMF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9d197e-9dab-4da9-cfbf-08d98f22fbef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 14:57:46.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Do8ax4IF7f0MX2+WuDzltky8ng+OvWGJFHi1vgHW4WmtSwLnSMmpUsJX5aIf/BuUYeEMY5lt3Zoov1aAUy/Usd571amp/onoQV3Ztc+dwnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2095
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140091
X-Proofpoint-GUID: pwFCyxArIdiajF-LktmuTTIqEXHuiU_H
X-Proofpoint-ORIG-GUID: pwFCyxArIdiajF-LktmuTTIqEXHuiU_H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 08:10:00PM +0530, Saurav Girepunje wrote:
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 29 ++++++++-----------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 0868f56e2979..217b86bfb722 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2281,19 +2281,16 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
>  	struct rtw_wdev_priv *pwdev_priv = adapter_wdev_data(padapter);
> 
>  	if (!name) {
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}

You need to delete the curly braces, otherwise your patch will introduce
a checkpatch warning.  Same below as well.

regards,
dan carpenter

