Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1240AD70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhINMWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:22:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54702 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232386AbhINMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:22:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9cgiJ029055;
        Tue, 14 Sep 2021 12:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0NMa2KIxA8f/Cs48T4D7Mj3F3HgKNCzSpae/7mBfoxI=;
 b=YsSjBE8GZcR0LzZEHzYGnsh3E29hIbrcIAaWOm4+Kst0WEuHm/kBErsS4nDYK6IyYWMG
 yrpZ3LOf8rA3mdtpw4OBr/PFwqCvPJrP3u6PM2Mroesh2KXSPpBDIwNBuCoSzFHu88fw
 KnQVS8LR+Y9OH5vLQakpyD8sWeOg8j75w6kUMdFI5VkzuasGR+gysuP9czinUkqYCYG8
 fe2QeQVJ6/dzVzbjbzYoEEDcA2kU4wIsy6lSHYy30k9obVCDi9SETq/kvImxQQZsWkdE
 kNYB2meP8n1nU9NoH+EWB6/258o2SmjwH4SDzPQ5cMwx/rDLvcX2janUExcaSLbnjvvx yw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=0NMa2KIxA8f/Cs48T4D7Mj3F3HgKNCzSpae/7mBfoxI=;
 b=kuE86W7E/rld6pUgY/AI9fRzeYsLFOpAkOWuHYUw353/tSFzvwrolgaFtg84FghBMFWy
 KF2GrQ3lIlXyVbrC1zeBo7+curFcB9+U+v1C3zlPkMr5G/XT/Tjw8vRR9cJO9svtdixC
 1O3AYptLoBwq3broxHw1Y1oGSAGYqOotHJ/BKeCQdCUvIaXYXIDTePqMHB0nqR0hlYdM
 SJE+3MgsUx+pf+gKvlhwB0V8Z2dYj9pAT23GvbNvA17AOJv1Dop8KeqCBgWay8JA4aBi
 RjddO39/Cti1dFm5x1WbJNKzODl+3CAUui7e55htt+7T597CoQ5xVSWgEKVbVS0LFMaj kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5sksk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 12:20:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ECAXuc066653;
        Tue, 14 Sep 2021 12:20:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3b0jgd1crg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 12:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObBHz5/G3LX6ZMr55s57Vibu1SjdLqvhajyf14h+WiuV0sRaVjMmGf6BaSWnA/VQ5HYCRn1cfjxVN19Z8TCpIDRGgCLu0OVGRZdyPyv4ZdPPG7hzyEmdgVI6o/qrXdlh7NNlqFS8+JT+WdKFXKhe6Gv/MXa6jYEsxoN1mFINp11PrGEcGc+WVB9dcDFsohLcO4QaPNlgLj5mvL8aJxFSL8WYCBpRBIytZwUKQ1ZFGBLCqJejT35lGfJhBGTSWXVgT3KHfp5b/Vqo38XEVQQ7PcbX6QtsC0FEri6MmvKXENUbG10RTAd2jwCdcTuVpNQiKIiG59H8zRPxDu7DCNb4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0NMa2KIxA8f/Cs48T4D7Mj3F3HgKNCzSpae/7mBfoxI=;
 b=IuOrMX8QNTDKMA33UKXeW9jOuZI4bdBvHT73cSTmlxvFhMEWo6vTDtlgWP2St7DZiCsoLzmm7GL1g58StjhnCU2UHP5cgxV+l9iRK4g446UCInlmRBNBzsAfX6o3JpdVrpqMn3387/YgMiS1N6/uk3SBfI4edhmv2GxyhwwPUbmYlskwvBfoZWjIR6HD+THxOuMDwefT/Of/sh5dpX6WnjJ6oOUigoQCAbSdXw+0xYABV8GiYGB7XPoVckUwq3sryrEb0T6on53N9vAcBtRMOYoKwk7qx0NMQYON9fIHpUnef6MSHv/pK7mGemFOGU5S3tVA+tMx+hMWznk2xIxLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NMa2KIxA8f/Cs48T4D7Mj3F3HgKNCzSpae/7mBfoxI=;
 b=th2rEpLryViNTo4x8nvbFY4sZRawTWvJdNfruYP87udpA0EYZe6GPBUlKEtKPe+7Fhbuedt0Gf1TTEFJzEzB76vPfvMtFm3inkOmTEXn0lDz433Le7cWslxYIOnDdVCdKyhWqsJUncAdpPH3ujDpFhz9NTD3WEmxFyl8TyF13lw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4658.namprd10.prod.outlook.com
 (2603:10b6:303:91::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 12:20:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 12:20:49 +0000
Date:   Tue, 14 Sep 2021 15:20:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 15/18] staging: r8188eu: hal: Clean up
 usbctrl_vendorreq()
Message-ID: <20210914122021.GC2116@kadam>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
 <20210913181002.16651-16-fmdefrancesco@gmail.com>
 <20210914092405.GB2088@kadam>
 <2067006.DYBlakG51R@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2067006.DYBlakG51R@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 12:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da6715b-6380-435e-8676-08d9777a15bd
X-MS-TrafficTypeDiagnostic: CO1PR10MB4658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB465849D96EDF416780F42BCA8EDA9@CO1PR10MB4658.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiIDiA1D+rYa4Z56Y28AC1r4mWoKd48MpvlbGmrMSTMegH0+ZCsDY4QlgdiTq5jcx7wOjlMrmjK66/W4sPSZZMjlrcDM0uLnx4TTBWQcdskuFEe4DLCIIfH4sOJB9I+Cvurqa21C2CTpT183DBzaQEkudIpYu7GI2EfXlDPVPKehemwYgCrB1KV2bKxMYKsIzy0T4gDCnzeC29EjqH05bhAaD6ipJmKpfYoukSxrTukdtqlFBrPD3q6yp29Quq3vMriuMh1OZEtcJU/lo4FAnWlDRfn75+JxwDEF46JzRjC2/+KLeQ4Gzcw1rY1xHRaxufZ76Yu6/VzcVelZaw+ktLV/b5TkE4mqaKblRB6PfQ09xV+N1HiAf6pHJnki2NXUuFVs2sO/tekwPCCpuqk+56szU9iL6ImWJYglmYvy6y8qrdf6hTpuFnMaD3Ii4gZzZzxr3H9Cvd8GfprdL5mMeivWgltvtq5k8G2ue5qKW+LY/OXt6q0leN+AF5uyVU96dlmlm8rh7Sr///OCx8neoZ0838kPsCYQHc07DEdnCKs2wDTL4HAeZCKGWbdVfdjcJfiaem98h9xvJrHHCiamCE59MlfU3NP3ZNtiezSpmRhOybMUDhKLQqT6bnYQE46yOwDw8w4duyQZlrfOya+QoPnOphzR2XCXeoi2fFqL6Zkwg6wUbKt9Q/6ZOhd8e+0n0j5tuRVsdmvaBRLLhJDpyrCuo8cIRT3VJsqR/85ZgnPXirhglJWRj/sGE0bEnpJgP4k1/Ewp3Jtz7k9jtfH8J80NDLI4mYfain+L9jOrC/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(83380400001)(55016002)(1076003)(53546011)(33716001)(33656002)(44832011)(316002)(54906003)(86362001)(26005)(6916009)(6496006)(8936002)(966005)(66476007)(6666004)(186003)(66946007)(478600001)(66556008)(5660300002)(8676002)(4326008)(9576002)(2906002)(9686003)(52116002)(38100700002)(38350700002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hB68N9dyRWlymoJ3uB9ZPkeiMGNBd0kTxxCZW3FhC0xIEuesbiqx7tKK1BBn?=
 =?us-ascii?Q?yuIXgTsl8wkg8BsznoOoTwTBDiRAc4jn6Ld1DMVsQ4GAx41ZZ3+jnSz0N1/2?=
 =?us-ascii?Q?ZbVVq6Z3PjGo6J4fEO1AXVSXVYn/PuukP0+qLU6MBfklRJCF0C19YzB1lN+r?=
 =?us-ascii?Q?jIFNuZHAiID8K6m8fF0OF6N/2uFjeoYCrLmvIcBQoJACtPGpBBofvZ4038HW?=
 =?us-ascii?Q?EtG0e48g9lVx21ef2aXxF1qu2v0Wl2GfCEBDp4n1wiznqV+3xEwA6snWlGzy?=
 =?us-ascii?Q?IKgZJjUz2cRTPUDdXLlw8NRVlhL1wVSK3Hj9uCYxMezws26/YbMK7t4KSTPo?=
 =?us-ascii?Q?MNEuZB5dl2b2mKEptY9mY+oERCLDZfh4PZS4uVWa22xjHC2Ebxd28F/+/WKO?=
 =?us-ascii?Q?YG1kxBLhm9J+9PpiM7inGYWeOFISlvMF8ZFwGBceF64Aup/LFHUmoXJw4C5q?=
 =?us-ascii?Q?t/DX61fx3mhsdEt8dXP0M7UKyFWIatAH34YKo6Tqdk5E68mAyrgiqRUkuxGP?=
 =?us-ascii?Q?yjM3RFP8Wj5vzwoEEIFVjt0TN9Ml2L2zKTFOkbh9c3iEIlti8rYRm1W5W3kH?=
 =?us-ascii?Q?MXdSxsQXp0q0nBXBg2m8dq6lRC3Tv5k2dprFgTjPJku4oqJjrQMR1LLSbihD?=
 =?us-ascii?Q?NuT6te4OIq16CDd6srqvWh48BAkqHq01+Gip5SpmOOWg2Tkq2Ok9BBO+DuLy?=
 =?us-ascii?Q?gJaT1rSswKjxZz3SxBmRkmOKrvXnumvdLSrxKekSjS/s6fPSmgNy9f83EGGI?=
 =?us-ascii?Q?n5nwPY4EJ45Nuv5BBR9Jwa7PAZ9HRtqhU4ADirvDFiXJ4je/y0ULDW8zNSUS?=
 =?us-ascii?Q?8hQr4hC3QdhzJwyXV/g07Kx2k7EHk5BA/7/hRBAjgY6MWHqbT3VjKPakMv2m?=
 =?us-ascii?Q?eZ8JWrirG7p/7c0ffYiZAZuwCnAkcxbiAYTjPjfGtKBUR/zoCSHvmxGhdPmT?=
 =?us-ascii?Q?0bzh7jb0hx5R9+Sv6dreJvnXAZCCORroYlXi7qYzMe0h9Maq9ewGBVsolMMF?=
 =?us-ascii?Q?65ZDx0Pf1oRbd/E0E2VB/Fe+A82lvXsKqDWnTnAI4RTJjp2I1YRD551z2nt4?=
 =?us-ascii?Q?7T1Oaz6ahTw2t7Nzf1L6S0UfkQDfFgp+8zH8zMv0E/zu+0fvqHyxibiPAHXc?=
 =?us-ascii?Q?fY6FZGbMCGFsRgH8YxckyOPTwyG7VaIN5wJOYFtbawHVXOj5yfcuc+6I+aV+?=
 =?us-ascii?Q?QS9XJT199ar3gDRTYm8w7TUGqjc4k/L5faVdK42P9z3dEk/odyMBOeSDnEjm?=
 =?us-ascii?Q?oHKOLx60q6ZtbvQxVM46szhlISmFBl2tF46GU6O2pUHkCYwHjDaYozj+1IdP?=
 =?us-ascii?Q?dw/OMT2neMIogrw7SxpgIJGr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da6715b-6380-435e-8676-08d9777a15bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 12:20:48.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5Vu4Aup4haVSLBrAzALLGdVVCjTPYO2/+o/rmbN5FVgrrkSVKuSMWjXH0klgHNvUArPWKTu0rwQzI9utJXHy4l11jP9k1lh001RXrgcASM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=621 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140076
X-Proofpoint-ORIG-GUID: HtI8JnqVZoA31h5DX3PYjhozZhPcCVze
X-Proofpoint-GUID: HtI8JnqVZoA31h5DX3PYjhozZhPcCVze
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 01:18:01PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, September 14, 2021 11:24:05 AM CEST Dan Carpenter wrote:
> > On Mon, Sep 13, 2021 at 08:09:59PM +0200, Fabio M. De Francesco wrote:
> > > Clean up usbctrl_vendorreq () in usb_ops_linux.c because some
> > > of its code will be reused in this series. This cleanup is in
> > > preparation for shortening the call chains of rtw_read{8,16,32}()
> > > and rtw_write{8,16,32,N}(). More insights about the reasons why at
> > > https://lore.kernel.org/lkml/5319192.FrU0QrjFp7@localhost.localdomain/ 
> > > 
> > 
> > This commit message is quite bad.
> > 
> > This patch has nothing to do with reusing the code or shortening call
> > chains.
> 
> It has to do, in a certain sense. Let me explain please...

I guess I can see that all this stuff is related in your mind, but next
time please leave it out.  Keep the commit messages as simple to
understand as possible.

Just say you are cleaning up the function.  That's a simple motivation.
A good motivation.

regards,
dan carpenter

