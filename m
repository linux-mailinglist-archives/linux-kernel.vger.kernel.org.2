Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419593E170F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbhHEOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:38:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49246 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233247AbhHEOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:38:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175EWIcK010306;
        Thu, 5 Aug 2021 14:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=2T8kC3r7f0m5pl4v5bJw2IEIJgIjbC0XarMl6GefkIM=;
 b=k9VoZK5ro21Ng96/IyZElG18+gMI/snSznhCemCiy4LPGL8CQhkLlyf0yRsSmsDAKung
 LaP33v3gOr3ygRQnUXVg5QybY7siTzq56BKrPdQJSjIFziWI2pwTFa9E/1i8QNc+FLhF
 61PNaORaUMqYyB0Vahc5L/j5YThaEW7tmF+EB/1JOsviUj1ITKsLjJcEE1lmDuuT5kWc
 bAn/UifzJ//IrHSUkxfGfH6CUfY3Kfrb6uTrPmgM15c68b+xwbBb/hPe4qmvl1gDqYvi
 Gdn/JVD6QQLhRacHrcmERZVR2VIAZmsb9W4sL2m6CxpQuzP0mQd9w5AiLeYPEIbLGFVz iw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=2T8kC3r7f0m5pl4v5bJw2IEIJgIjbC0XarMl6GefkIM=;
 b=jtoi502KpYC3V5i0hZ27Vr2P3i8hYKoWbT1g/6V1KmWUHAUD92CnbhCETysSBVtZPUes
 Ue/BmFwYW3XkJMdEDGG3Ajm5z0LWC63Kyv8QXjNApaI4lSNv+/SwD4t4jEdzYHH5hd2x
 E+dHOE9APTOliubAl5RZfnZ4g9Yq1z7FpPXljOQA5z2fCec2BEGCPtjSeZ/6LAm1oo7I
 AasSJzakUFyXdTWIuVp2LKA72mUrpJnv2f5SORpqlYvKqtHpTRNLcvAdnHjM7h0C8+9G
 Us97OIHabydaEVj3+Oj7fxPnamMYpxxxFCPRIX9svLrpng8kah+10NAUqx3nX0NLHh0R tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a843p9khm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 14:37:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175EZVdF084068;
        Thu, 5 Aug 2021 14:37:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3020.oracle.com with ESMTP id 3a5ga0bcn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 14:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da2J/FgDrCB1fz7gkE54GkcySPVtD/JLbkzLKcgLLtBgK+2OA9gKSSzICa4s1hO9sF1a3Bz/AEYncxsgcpPKBP+7wLFiu7Hh3udrRSj6mU6SXgdnVIsgRowlSZqdvj3IPcjgPHL2iMFeEtNwfkjRbsfo/4yTOwOxdmMZY+BWUSor/B1pdUDCkz73Thsrrmtgee7LB7Lzz039PKick4QjDcDcgyuCaWbLo2I0xe82kqfO6gEnmivUjV1ixME44ubrO16PJrULsplZgb0K9zIFSf5jgxjONEQ/Enq+iT+d48FZv23PzPCatz69CSZYd5/GaAZVyWyja9MnOjowTurkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T8kC3r7f0m5pl4v5bJw2IEIJgIjbC0XarMl6GefkIM=;
 b=NZzX48rCNWXzWfymtUImmijGaf9MjzFCPqUOa3cUXkxqGyNMVEe8kWd0r2vTIhCWriKmUtBBaZts8m4qYAtX7QO/tiyqw69Fd1LIqINtkMdspAQe0QIGlyP1Xj2xKLd8u6W2XJ6GUn6WK52t5FhRs8H3emLj2IoVdx/r+Hsr8M222U6r3aGVc7rAAbTkLHPfOe6wA+9HNMBHP92eUSnYBqkF9Fo1SYy/oMSaZryyNdPtcIE3z3PRpOJbku2tBe+teS9vKUUNmuyj+6/UqkxX9gTrBhyr0l7djzgisRzrusODuYJ3ErogJ3kg4GDzhyiNZc/59wU6aEm2AMlu2ghiLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T8kC3r7f0m5pl4v5bJw2IEIJgIjbC0XarMl6GefkIM=;
 b=RovftT1cEO6Sk0/x0r3AqNXOiLSBqDeiOM32/F/FRFUZvY1MAqIjhqc2dIAFTrbzgMbhOb0IeBl4suf4xce1mtJVuEuhl3K8ASzoDcSCRqMJQjT51obzyDvkTrerhhZpUhyzcOUQLJFo+wH3QfB226wxJihioozq34dJ/J/SxEE=
Authentication-Results: kaiser.cx; dkim=none (message not signed)
 header.d=none;kaiser.cx; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4499.namprd10.prod.outlook.com
 (2603:10b6:303:6d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 5 Aug
 2021 14:37:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 14:37:27 +0000
Date:   Thu, 5 Aug 2021 17:37:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove label at the end of a function
Message-ID: <20210805143708.GO1931@kadam>
References: <20210805130750.7974-1-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210805130750.7974-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 14:37:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e64845f7-0f57-4141-5472-08d9581e8c43
X-MS-TrafficTypeDiagnostic: CO1PR10MB4499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44992B87F1B6B055F878FC458EF29@CO1PR10MB4499.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9nMhyi/fqyl0X5tGU2bzE7hsFDC1MfgeBwH265at1cHuhms2UC+T8geTAPfH4kPjJewz8OC5dh5HhQ5XKFrJJS12AcBn3W7yKQoBNvd8jViXH+HWc6aGaWBsFrMG1J0Dea+QA3IURWLZqomVE7LP8BvgFPaq3/zs/wMxSmuat9WBMWlYMbkP9/EbV17b/ttYEtVfQS5EJz/q4LWqOonQbIXex78L04FaWc16zvc87KsGYotxGx97H8SNt2I2CGItezFEdIABnhG5QDb0OqIklip5IDFhIHL10CRWTIf0IDuRUKFi7fjprAkzieDz+cJeBcxtfnEfN53z/J5EzklGUvifJwi2+8itlfC9F+hrxzQvwUqe01npYZnaC68mWpwHeIdVpI3tXB7RS2j/hG8hWSK6FgQv0QRIagzmshn111F1pLEnD3+lIfjWNYIaDeLmRamtJXB6aMWRUzCkAhBCBJtAxg5D1RucEhKFSO3D+w1kaXEN7ix1A5Ouh+nQDe2sXIpVkixcLBThFdTrelv8bBZ2hakCV0vp7KBHcS3kE1MHBYpsxm6FX6GxWm+UFsA6re9LyCXvQPbKz8lRAY3JBchLT1Txyw/iMG5bEMH0jA0lufhWRLaLxYbCemTcoFtBWs66VM/2zXBPUKxvOJLdG6fdReqIymKuJ5Tem9x1PXqbiiyxN4eljCsufExO0F3pGSKCmVSg/9sdFnQTyxQbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(396003)(366004)(26005)(186003)(6666004)(54906003)(66476007)(33716001)(6916009)(8936002)(4326008)(1076003)(4744005)(55016002)(33656002)(66946007)(66556008)(956004)(2906002)(316002)(5660300002)(9686003)(8676002)(9576002)(38100700002)(38350700002)(478600001)(6496006)(86362001)(52116002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkdkTVRnRlVYY2dxWGdmNnk4ZmxpU0VnbmhkTHBXNmpoVEp0Q3JvdEJudWpo?=
 =?utf-8?B?NDlSZ2R0ZkZUZmdqS1QyNisyMHc1Smd4L1lmakJOR1BLMzFVeGF1dW9DU0hs?=
 =?utf-8?B?SnBWV2tUMUFqYUlBaXVTeHZyT3phWGdua1JENDNoM3dhNFlMYkw4N3BsaGVD?=
 =?utf-8?B?OWFXNGMwYXlCRHM2dEF2aStzSDMxWXdrM0ljWEVnbmF0bngxbG9YZ3MxWSt6?=
 =?utf-8?B?ZlQwcFpMUHNSVkcvOXpZUGJlL3JWeVlNTVAxSVJDMU9FOEQ2OHhzNkdZTkZa?=
 =?utf-8?B?a0ZVVHJvK2dxa2ZFM2EvczFYb0I4SFVBdlVPeDVlQis1c3VVOHFBWmorV0s2?=
 =?utf-8?B?ZGRPT050TzFnc0RGdjIxbXFUWG8zMzk2Y0Z3Wk1CQXV0TVFiRHdGd0pLOGFW?=
 =?utf-8?B?Z0ZvaUtMS0cvOGtjS0llTW54QTBENGRlWVR4N1YreEdXUUFCM3k2ejNNRlZY?=
 =?utf-8?B?dUgrWFc5WlhaeEpVSHhUWmdlNlplUmg5enlhYWxtRWxtcFZteW9FTUxNS096?=
 =?utf-8?B?dGVVQVVxSXczc2Jpdy9tY3p6cWZob0ZCdGFkZHMrVzBva1JFeE0wRTU5WDNm?=
 =?utf-8?B?dCs3MU5IUHhzUzlsYzh0NVBBL2VacWtvZm5tdjgzQkVnekQ2WUNLR2FmTTFr?=
 =?utf-8?B?cUtpcnFwVmRrRG9LWjFNOVVyR0ZSc0tpTWRTR2orTEx3RmtqTkJwTGRvajZh?=
 =?utf-8?B?QVNTSUh3eTJWYXFuUDh3QVowRVp1MXF0Mk9weHZLM1pyQlU1MHFJbzZaaFRn?=
 =?utf-8?B?ZXJDVk43S0hOa2dxcnJHN2crWWhJT2Y0b3lhVkNIUmFMRU5obmFGK1h4a2NV?=
 =?utf-8?B?NlNnTkVDb2lSQ1p1SWpJQVNyL2F0Z1ZPM1pXYWkzMG0veFN3Uk5OTTZ2QXdi?=
 =?utf-8?B?eGZnRlhOM2NjNWYweGtvb2Q4ajlPekhFZW9INzFUQVBJUUxCa3NWZFNTVk8v?=
 =?utf-8?B?aWpMSzNNUmNzMS96VHBGV1BTT01nRnFWZzRHWGFHSS9rdVhLa1c5Nmg2MDRZ?=
 =?utf-8?B?TldjR2pvQUMxNHhxb2hhUHNRMTZMQ0xVUWFLOW5pbVBJOFNMdXlZTXpqeEZj?=
 =?utf-8?B?Z0FuazFKT0FuOFVJMVNHOFpNUWdsbnpUOWhDR1Y0MTdoaG51OUxNcE1mdlVq?=
 =?utf-8?B?dlUwS09aZ0RHTkx1ZUNpSGZRV3FsUDBQRHRBa1pHbkJNUEdTMU9oZ1JvWUhF?=
 =?utf-8?B?VE9aWWpKYzhueWIrVi9nTnJQVE5SeG81SnFKL1JEdjBjZWZSSlhiN1ZSZFRO?=
 =?utf-8?B?UDFMcmtzRGhoWTJOMEtVbTZvWGlpZGRoRGdzK004QWxwM1hzS1Znd1VzTEsx?=
 =?utf-8?B?WnRpMENkcjhwOE1ub0V6TDhQOEZ6ZzRGV1FIODRHZUhpYXdRUmZFaXFUTitF?=
 =?utf-8?B?VHlEazcxREdYWW9nemI5emhzZk5wZFpZUXBoR2NwdVpuWktna3JTbzd2Q1lZ?=
 =?utf-8?B?TytmS1ZRbnVjSDI4VmtYR1plZzRCNUl2S0ladU52SjY1T1ZPOW80RjQ0ZFE4?=
 =?utf-8?B?NmJoc3dzcDM2MWw4L2NQYzJpMTVleXVSVHNyRUFubUVuODBIR25MY3JPUjVH?=
 =?utf-8?B?ZVNwenpkN2xwbGNLYkpmWWZialFXUHUvZ21oZElWNEdrOUQ5RUl6ZHJuVWYy?=
 =?utf-8?B?OURvVU1tQzhTaUgveWJ2MFhTdDZNdlNSYm1aa0xhNlUrZ3JDamFibzErejk1?=
 =?utf-8?B?VGc2QXQ1RVZ3cy9FcmdrcnBEejZrRXQ0Vm9QajQ4MmptNEtranVvc2xTTEV4?=
 =?utf-8?Q?jK3x1Qsz2nuEsw35X3E/wHDkm0p0LRAO27Nznw6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64845f7-0f57-4141-5472-08d9581e8c43
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 14:37:27.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ael2nZ6KiYh3FqZw8C+MbRuuUAQwNw4wcEnusaHVP+UBmsRUxr0v8KEgJdKgACWwA5CoZtkeOIyWqiB5ApSCx++RsusN/dw43VJ7V/YQXs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=995 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050088
X-Proofpoint-ORIG-GUID: C8RDL2tWhqQT9NyRGfc0yOu_ere6FD_F
X-Proofpoint-GUID: C8RDL2tWhqQT9NyRGfc0yOu_ere6FD_F
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 03:07:50PM +0200, Martin Kaiser wrote:
> Compilation fails for me
> 
> drivers/staging/r8188eu/hal/rtl8188e_dm.c: In function ‘rtl8188e_HalDmWatchDog’:
> drivers/staging/r8188eu/hal/rtl8188e_dm.c:182:1: error: label at end of compound statement
>   182 | skip_dm:
>       | ^~~~~~~
> 
> Remove the label at the end of the function. Replace the jump to this label
> with a return statement.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

This needs a Fixes tag.

regards,
dan carpenter

