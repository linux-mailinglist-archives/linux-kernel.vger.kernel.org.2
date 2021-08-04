Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2023E01B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbhHDNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:13:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13942 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233389AbhHDNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:13:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174D81ua009812;
        Wed, 4 Aug 2021 13:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XN/lY/MiR1VhFk4VqLuDEUKGQIi3mQfSUmYS1cG3LWA=;
 b=OnTiRUCeXgCGTTMeRqDFXUY+9L5y078gCOI11F3PxFEjge+LfQnGlMCQisVSsuAA+kif
 7XsQ/jnaN3wm+d4qrqMsW0qwtNJjKOy166t1KebYDXWstfz7o2bfBoIVeaQmvbwR+CUH
 Jgjku9OQlQ3c50PvcKA2KIgFAkd0JdgwKfGzEKGh7Nfg6UUszQDvz7VUdhxrdVljOR99
 gNuvA/DYuTwUHN1/KlrDKuBdZpQg2IH9OsFaUBfn6DsMnB03hr8E7H8jj/PcfYEw+Zfg
 ErmQgLLc32ujy4tTOfhhCDojJ6MxmJVfipXStJTeXbzxR6mBTNZS2yKh7/YR9WqTCq/W bQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=XN/lY/MiR1VhFk4VqLuDEUKGQIi3mQfSUmYS1cG3LWA=;
 b=QYPx8N1pmv9GtaRl4jiaXS9GpEOecP0d6bn4SfdyhzBjp4U9jsdW4BR62aIOuYXkF9WN
 vPlCvFyr6Eb08blttRye9ziDoYRbxY+16q1yOdmaLH/J86AQ32CM6onud1hqA8U8iana
 vPMLgyKRAht1viPFovgNSZZTOC/o7Kx6g5C+BIoJVSC+zMuM02GhRDcxeGEttX34zEy5
 11vN27gujPf5QXorDXu1KZ/tBpCUL4E1L8kjeCk2JUcHRLuZ2gNkeFvpMcgWd2dkmI4h
 jKQB5XHhws9gPAnLJsxh/NN/giixfwqrFEHoF5lcjTHBpZVI5hujI7BUDWWjpWvsQsXT mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq09xm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 13:12:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174D9xjL193399;
        Wed, 4 Aug 2021 13:12:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3a7r47syxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 13:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8uoprFNDdOfU8/ZtrFJ1IlBEdsoBuKykeVz4fxKFyGAQzPyB/x89iFKgJUTWItAyrZvrZrTE5kb/1qBFoUgU1bXoEyeOrbjF9wdX0XkRnDI96bwL/chdHKGpvTOzxadTsQnbwaUPEyDQaN/MVpkynRh+yS8+gOTMvO4rlT46cn6JvXCnN3d8Zgn3fbibmxH5eBmv8OhH4EOuRbJXieJgqfE5mlD/j2JTVNbiBFZr/0ThpkQ5aH3AsYS74Fe2Al1+tYUEAwLFnDbhMYc5GhPLVXd+dUBFqOgY5yIswW5p+TCmvylODmQzIrGlwrpW7u8g8KWCo8vgaimkN9ys1slmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN/lY/MiR1VhFk4VqLuDEUKGQIi3mQfSUmYS1cG3LWA=;
 b=UIRxL+TvKDvMqz/yomkUACav7/FR9HUYHSHhUML9STnnfzTNHpyIiN3Sy79tMv7gZDSVl8OZ3IT9N7DSuU5SD1m5UrlAGcvAFMPykvDrHs0ICUZpFKfhskq9E6JM+uWkKwflsq/4APTzzLWYJ/BngkXhISnKySqa6AYgSmufKBsxbhzTkbqNoC0ZFrkG2FLpPwSsyomsse7vBJEXs6Isp7DxKSQmWLkNSwVkeozBpp/eztPeB0SMA5qQV69TJDYbI2/M2cTgCUSd6+aBYO+yp1uoy0psWq/MiQEplnTi1FWykHQKPFTZuiL7FOs9N+oX2eWBqcRVjCJrholCCkXpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN/lY/MiR1VhFk4VqLuDEUKGQIi3mQfSUmYS1cG3LWA=;
 b=pPK0UwQwYQzK5XENnyblS8+ZLEF9n72rdxenChQSae4Jwdk7ncQNeVI7BD1fX6MOdiGMNc+dWkOjaFvRvKezMlMHJDtjm9yKXDcjvU9LGGtrC5vhiVBoqHqgwx72DU//kWtgb7PWgBFOaemnFq/yIT0wESwEvzZ8lK7YozJIP9Q=
Authentication-Results: kaiser.cx; dkim=none (message not signed)
 header.d=none;kaiser.cx; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2205.namprd10.prod.outlook.com
 (2603:10b6:301:2d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 13:12:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 13:12:35 +0000
Date:   Wed, 4 Aug 2021 16:12:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove RT_TRACE and DBG_88E prints
 from ioctl_linux.c
Message-ID: <20210804131214.GK1931@kadam>
References: <20210802073917.8647-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802073917.8647-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:12:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01bc8b29-4ef6-46a9-9031-08d957498655
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2205E4F4C6F8BCC40B4AA38F8EF19@MWHPR1001MB2205.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sAp1wZ/Z3onD/hHEtb6EUnN04dCH8KAePhPHnAOitxE+qOwArYYHGPY0l8DpQqdcyTLPBLRGf9HR1m7CkWynnxoQ2DvOr0w/bt7bXoenAWWVdR4X3QuOlonNaZ70jjQSojg35xgAAi2hlQD0F3etF4Qi0by6hKbTAR57Mjwg8OEE0ozLcuvgUmRPTHGlihHJ/HsEq3Ks0gPG24ozDdn2BJJRjWuAWcaM/FST7mghH7clAjNudGczKcjwTW5CEZP9YsUj0nftK8W8jl8spBBUa63aZzRXpFJCSkSDCc4U7+cfE395Hxlmodn6pWEv/ElBOeATBa/qs4EiE8DkeXuR3AzMK49zaeSijPpXLQQFf+LRGAWxqVX8egyq6vJp1Q4+fhVVSj9XDLTFARpUOpuxWem1kLQuph6qFKLCYdtmkGOmBzhsLdaeK7xtZ9+N5ulSDNG654DQrW+B3dc3XLPfHBYMB9BnKpEzJalOVV+GRn0f5tup6Y6r9kC8AScuGYj1kCcFNWClZTc5IvoK4ipE2k4lskq8Z3Ie3oeQ0xIbRJBEgoBO0ZWNpeSL9Ujvq/IZYlfUK8qntV+mj2n6mfDcAhMaMU3z4wu4UsMqYzJjbHFgaEGqfuWleidJOJw43DvNg63WZEb8E+G0hsrXO39gEiCw5xeVxLjPpjYYo1DgqsMN++6wXmBCZTYN+p9FSsMQ4UvsqSN9bhdldac/x47Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(38350700002)(4326008)(44832011)(9686003)(54906003)(52116002)(33716001)(6496006)(26005)(9576002)(6916009)(316002)(1076003)(8676002)(186003)(8936002)(33656002)(956004)(508600001)(6666004)(66556008)(66946007)(66476007)(2906002)(55016002)(86362001)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6kdA0Me9UGoxLY+gbuidvcV2UAPb+iyYqw5Qp7MiLNXxcbKdCSGR4f2Ga9MG?=
 =?us-ascii?Q?K+wTb77kgGTPJ3dSJwwjxEbdI7h9Q77bplBv8PBcPbhyRHba4EJae9o0L9YO?=
 =?us-ascii?Q?nGAAlVGEFf8m19CGeSTsfdBfHWyDOCxFmaWwrWZpOWI/v054uHzYj4cKKojW?=
 =?us-ascii?Q?H8Y4IsXnb7WafxEcPKVCSlkYObHI5bABX26cNDRnUqE2qlzOwunAjhk/IoIe?=
 =?us-ascii?Q?YFDu+nE+NHbe/gU6Z02L85FdnjkoLdL9dNGDR+CU88ERV1ZK6lI1y1RYCk+Y?=
 =?us-ascii?Q?1AT/qAuiaRIwNJzg5DZ2KSnXJQkwKN3cIVa6Nza3nuqNgybCEJpVXYPS7cji?=
 =?us-ascii?Q?Wb67kN3Qwq5nGmxW4zL03UDT4yCH5TyP8ymbyTFUl5u0EGrD3OOOSKmcZ/F7?=
 =?us-ascii?Q?abq1zvBA9OQU294Al+ZlA/p+AhpXjxux1cw3gukQfKMsi0ZO/LuYF0/jOC0q?=
 =?us-ascii?Q?/0RNhjNrBQgkVyLLffGb3PqsCrdNf93p4wOuoS5q/41CTdtJmtzszUsSuQFD?=
 =?us-ascii?Q?u6MGxiIC36igMOgAwtqQoP7fB6WY26Xa/ezLLI6g+XAi5PlWCkNk8gxLk40o?=
 =?us-ascii?Q?1lFx+y47KPAQrvcYhiVkC8g1Zmr7F+D2Ce6chY+cD70ywfy0zPmkPQgdspv9?=
 =?us-ascii?Q?16LhLfSYuqjyzUM049nfY6FCIMQ/emTNizk007akhNdc83oCDNvNn0LbpLIT?=
 =?us-ascii?Q?XkxTKKM6y2L89e6sx/LobBkPObnRyjjaUPnX8aNsGSell6dZ32I7rlME3Q4R?=
 =?us-ascii?Q?V7HxA/aB6vrHwjr14elXXG09/IG7Cx+G4FMMHCaRWX0ZItSvi7pPMGUAp6r8?=
 =?us-ascii?Q?uGJZw/Q0Fk7JdyokTdN/ymFRwlUuiGABSetlhPXdThR/61AmLWBMCgZFc0BY?=
 =?us-ascii?Q?AUQLeOzwY0ZKDC9qsBPvLWgOw+c5SY3ZKXKMFNqjKCNcTaAXNSIsEecbb072?=
 =?us-ascii?Q?Qg1h79NG+fKShQYF+bbHi9PybTkAFhBv/zeO9qHnL09ZIAsrRGhF+YOtp4Kz?=
 =?us-ascii?Q?ngBTpFnPmlDkJLt5SFhJxwjfHx7YDOBydBOAnk5+izHSaw9Hv1YzrF5V8PXq?=
 =?us-ascii?Q?8HVSQEtCW0PBSwrbngdqX8Ky8yLpxGQ847CC2mtBilmbyiwJ1b3w9gdzaHXB?=
 =?us-ascii?Q?khj9UHIyDXJJsKC87VHKDB9rJonMpKvbEj3Ku31edXrZ7AsBf/tU069AEHoI?=
 =?us-ascii?Q?sL89+tPWTlzxzUVm24LeczGAh2gmylH3ZIsRfLubizH+hTjabOJuNH5aiLCl?=
 =?us-ascii?Q?tj6zszhX/HbphivxM1Fp0kK23D/dT3bkhXHpuJdE4EDj5Ol0+KNIXMNlvWCm?=
 =?us-ascii?Q?pggqNU2VkAs2mKnX0BDmEN9t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bc8b29-4ef6-46a9-9031-08d957498655
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:12:35.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzDpUk6j3KCDsM26oLEAfHzm5kh0RcLtki0RgmnmZ3Z3jCrltGJ2lTtzGcdHsytQQln7I+39KUYWUoilsnIyPzk7eQQk1I+g07BenPStcJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2205
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040070
X-Proofpoint-ORIG-GUID: 0wh_Xy8Qdvvdv4nZmOxcdGHTOG2iRXXA
X-Proofpoint-GUID: 0wh_Xy8Qdvvdv4nZmOxcdGHTOG2iRXXA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 09:39:17AM +0200, Martin Kaiser wrote:
> @@ -4203,7 +3940,6 @@ static int rtw_dbg_port(struct net_device *dev,
>  			u16 start_value = 0;
>  			u32 write_num = extra_arg;
>  			int i;
> -			u8 final;
>  			struct xmit_frame	*xmit_frame;
>  
>  			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
> @@ -4216,12 +3952,6 @@ static int rtw_dbg_port(struct net_device *dev,
>  				rtw_IOL_append_WB_cmd(xmit_frame, reg, i+start_value, 0xFF);
>  			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
>  				ret = -EPERM;
> -
> -			final = rtw_read8(padapter, reg);
> -			if (start_value+write_num-1 == final)
> -				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
> -			else
> -				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
>  		}

I don't have a problem with the patch but these tests don't make any
sense now that we don't print a Success/Fail at the end.  (We should
probably delete the whole function and all the related code)

regards,
dan carpenter

