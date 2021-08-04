Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E073E0174
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhHDMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:49:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15436 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230325AbhHDMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:49:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174CgcHD005174;
        Wed, 4 Aug 2021 12:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=JEmAkOPAN1ia26WhPvherKGQ6lOSosIOq/n4aFCfihU=;
 b=Paalbs9GdSId84BAkDIEEf+PzXFXjVEmvFJNXg9ezBRYN5U2oRJDBljixIxWqjQ3NDST
 CIVUUbmHZPvSUgw9XnrUar0dOdjLY3DXYpWTEH8rU+wfs2zndYyElLmovWs7qOi40j9l
 NXpWDT6IEnZc3Aj/Xg5HctuBWdE31keRsRoz+VPQcAkue+fpRF4NwRRqVVoXhlZMg+Sj
 q0Bn+c+XgNgm+EOVp7F04sw5feU4hi0xVRrbyuAWDih4PgBxI+23r1kAooY1IXOlK/8I
 OM/EdRUNBuCw0TW5H+oT7aAOeqXDrEC/Medbr1XsXlhvZ10IIlVu2EAEKcLUqilPxjRC rQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=JEmAkOPAN1ia26WhPvherKGQ6lOSosIOq/n4aFCfihU=;
 b=hBZl7bs1Qk7lnK9KP6GO58gud6FjMyRwL1q6B21udZnWewH/stVYU37KSG6jqKGgLFzZ
 kc4+UM7offgvPr0Aj5M9beTuYWrjP/16+QG1kiZQkuTCwdMoDDZPrsq3K7FDT9f81LsL
 kVAkhA9r1P9Yt0QWzHmvWujt9XLt8lPCTF3IjnZfBcYQjMjPVRnhYW/4oGcWUHfiOebX
 6ononZ1oLtDRN37ZOTDTmcGvUFwo5/C35ys8AUNOzIhplfuFUyriWObkKsYaALLncGp2
 DRW7RyIRL9CECwmX4OJIRaMQGbVlbuBpfDgso9KncR8s8ajmaESJTbVGFoaN5qhggR6f IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7hxph5by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 12:49:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174Ck9Dn020575;
        Wed, 4 Aug 2021 12:49:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 3a78d6njxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 12:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7E5xxMyfQ19shDjDL4fiph9VWz1szCHh7SS8JKZecRVp8Q4N2S48fHiXJ0BruI4WyIlRYwl/I20wjlaDkiGWRPZSKkjbtETdzqOVF19Zu4ptqLL691fKGeCbmHmVyKHWpMxITDb7sQAgIIkY2O29yfXpRw1INCMn1dJ39cASGG2m/DubMyZGqgSbpSNrxvsc65bf867BFKlC0YE8mpwifU/LIMFtS9EdGo2Mgvul7EQTC+KNm7Ix6tC0UlJh24SSiDrX1kHWehqOoiB6GzKdAllDnG20CjqzoKyYnN7ZA88y1tE6zrst+p5EZLmvdNgp0SR5vhrP5hI1a1MLjs8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEmAkOPAN1ia26WhPvherKGQ6lOSosIOq/n4aFCfihU=;
 b=Vsu+CNMttLsfwT3XLIXsRi8uybgjq6Jqjt4te2DTT+EZPvQm8sJtlA0ysVfo49ig2bV/S12BmGqjw3K1/F/JABekv25c+K0CiT17bIbyGmQL2v71gJtxn5MRF2HTwGPbcztteluH0iKBFykNdNCMNKKm2kAeUeXfYjM79P5MIeE5m5lYoh60+ZoMU1bI01TXw16x53hmy5AI2mTlFd+iIsqx5y/w3q5MJEVjZyt9kRndOYduKOk2O32BjIjYAd/4gdIeHBpM1pAJjDHcZoZPJYZJUb5BO3eWYCxs4t6BEOMo2hcfOWGls0RcPs6T4sTpUrD6Y7s3wIr1Ds6twLa9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEmAkOPAN1ia26WhPvherKGQ6lOSosIOq/n4aFCfihU=;
 b=zpCbpPtWcQ9Sb3KTtnfW/H5GX0lKKC0vHn296R4Req/gqXBcdYQmXkyCjY95HzNF0hYMC/DfRJSYd1/TtACX/DHUsWHgRhzDfqLjknlq+LibkxDmS4iBpx5PhjOxib84kODrEM9yDD9Jl9jm5Yqb2NQPf2mCJW+fTBgbDOKQ1Cc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4483.namprd10.prod.outlook.com
 (2603:10b6:303:98::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 12:49:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 12:49:29 +0000
Date:   Wed, 4 Aug 2021 15:49:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix cast between incompatible function
 type
Message-ID: <20210804124910.GI1931@kadam>
References: <20210801233242.20436-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210801233242.20436-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 12:49:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36dddc7c-9dda-47bd-f96f-08d957464caa
X-MS-TrafficTypeDiagnostic: CO1PR10MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4483DDA9F8C4A543BA2C72498EF19@CO1PR10MB4483.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbng4UBk4amwOdy7lee3O7Z+wmZFpnZ+DnCcPvz5fWoza+DuIAIezXvh0mw2XI8aK3BdtcXhEnkjgz9NRmcrE2dsmzLZx5CyZQ9U40HeXC86mkAlKVeGZ1c7zoTGREJzxRDh+9UcLS5OXIHAlqIs5g2BkkxGoV5xgQx78t3IZdEaSxtJ/F8ryzGu+TGjdfoCSDHuHxb1DORPNkaxACGhYu0fsD+8NZu6d/scPE8d49tSybBw+TNISgow8TPC9T4NwIyxT8Zd6OKzbBAn8UsmOprmdBNp55srnkQuZAKqlkttEf9nazCTkBKTGOVrn1V43e1dfbvgNm4Mcb/5c+vttqVAnfPRpLXM2hDEqlMV9/4JZ50HfbY5/kbfq27lM+VVoMm1MzLIKOpIfwQBrVpX+6nD0iRdD5KP3V99Inrgd+pYEJYXRDYZk3AYqNAoCJXechKaWWcXqSC02GFfpQgSCMhFFcEb+shMrosPpC3AQ+tvG9eys7lP5vzGk+TZFQOyNKe/GjGvnHcvETI0QEEh1LmRv9Qk/51DoRZVITIkY4BOWq25zP6xyBoFJUrFeiKWOTz7KT4ftOVNwQb4pI94CFMpnBfzKxvFLoASQ66QuYQUZ60J+Zpdg2wmr+ptVWn3i3pwpvl2u2JodDKEDyu/1bAIcwSixhgdHN9m7Rd1xtsIcYCdt3zjLCEoG3ZiTHB9AO/FJcSjELa/ju/rT5+3MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(2906002)(55016002)(66556008)(6916009)(83380400001)(66476007)(33656002)(8676002)(6666004)(956004)(478600001)(26005)(316002)(66946007)(1076003)(52116002)(86362001)(4326008)(33716001)(44832011)(8936002)(38100700002)(5660300002)(186003)(9576002)(38350700002)(9686003)(54906003)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25lY1k0OFA2ZUFHUVhxT2k1KzBBdVZ5UUJscjBoSzFETnFqRUJYRXZ3U3do?=
 =?utf-8?B?QzQzV1pUbzhid1liblBlTFZzd3FlWFFYVU1ZZ1BzSXFmTzhyamJZMjZobG0r?=
 =?utf-8?B?aXFqTktSNitEN2VLWDVFcUZaVk1LOS9JNTFsRENpd2p5dzVEd3JaQ0ZETmpI?=
 =?utf-8?B?R0N1ZjZuQUp1OHZaeFB4aHdwZzliWVdOcDlxR0NId242SVgrVDYzd292Qlhi?=
 =?utf-8?B?b1ZYWXpRMTg1cTRTdWdRNm90OWVLdzgzQm9wZmRLRUtJVWQwak5xamg4UllT?=
 =?utf-8?B?SmxDOWRRNHJRTWIvTzdScWtmS3RVOFpKaStuVWJMcnRhc2MxYlBuUjdXTFpy?=
 =?utf-8?B?TnhJdDR6dDk3NENCWk5BZnRGa1lZazBnOXRYUDZXRTJBcTFxRmVUQXJBTmp3?=
 =?utf-8?B?aGVjVzUxRmIzTWU2T0dwSFN5L2dVdWpJN0NnUkpFVFpjVElha0NPcldRN3dv?=
 =?utf-8?B?V0s1d05WckU5eDBYWWJsekxVa2lIYng5Q2NIMXJWWVdKNkVPaTA1c3p0Mm5k?=
 =?utf-8?B?N25wTk9CQU93dHE3bzVHSCtza3JqQXNBL3dLcEtvc1hsUFoycFJValZVaWc0?=
 =?utf-8?B?UFlVMmpGZU00THZSSmd6Unp6cUtkY0FVVDI4VHBPVVVpSXVFU05aaW5XamU5?=
 =?utf-8?B?VExsQUF0YkRlYVlac1lWTWE3bi85d2x1b0pkbEw2eTY5R2xGNmxiekROZnMr?=
 =?utf-8?B?MnlvVDNvQVA1eGcySU5kb0ptUDExUnNaUlFLeVBsZUwvbWlqd2JFTUFUbVNI?=
 =?utf-8?B?MGd5SjluWDhxRWM1SlJGUDRuQ1pTM1FvMm5jeFg2MWlaVzRrK01wR0ZRNFF5?=
 =?utf-8?B?U0VqM0ZyOW1UUkNZNHVrTVh5V3h1bkZIQTJJT2lIV0loNStnc3hYUnZvUGkx?=
 =?utf-8?B?YTdsQ2p4ZWpDeG9QSlVNNFVscjdObExueGVvQVV2dzFjNlVvR2tTQUVPYi83?=
 =?utf-8?B?aU1jTHZCTDllYkJkcXdpVDA0UFYwSGJidEhEL3E5OG5BZXZqaU9Gb1BOeVNj?=
 =?utf-8?B?Nll3ejZSbzZqRHJKSUp1cU9yVjR3YUJOZlVLYjJsdU5HelcrMFpGQXZsRGRx?=
 =?utf-8?B?QVVwenZkK3VoNDdMV1g5bmlocm1lc3ZqN1EzRHk5d1hjQTgwN3dLWjUwd3Zh?=
 =?utf-8?B?Q0tjS1E0bThzclJWOElVWmF2dHl2SWJhdmJIVnFmcmV2cllDZUovU3JPMXU4?=
 =?utf-8?B?R0VTVUVyWmFwMjl0NFhXVVk5bmlPMHRvMEdUWXJXTlNEczRENTFXa3d3Tloz?=
 =?utf-8?B?NDdtaktaNDFCa3pLd2ZLRDZrZVlub09tRGp0R2ZMaklRaXNkTmJyN3NWbmlV?=
 =?utf-8?B?OXpIaXZvakRKR1VRbXJSc0l5UjNyejZHL29ZNzN1aklXcFk4cCsxZUFhVDlo?=
 =?utf-8?B?ODYxRElmc0dPRVJMMHVIMnYwQVErTXcwZU03N0pNV015T0gxZnlxdlNwc2Vr?=
 =?utf-8?B?TlZ4Z0NEYWxjUy9mV0JQS1E2ZXdZVXcvSEUyTEx4OWoxMHNtYlNmVHBNSjNP?=
 =?utf-8?B?NzZ6ZnIrZ0daT1FjN2w3REV4RnozQVBpTFlyeVZoclNIM1daeHNNbDFPQUs5?=
 =?utf-8?B?WnVDdFRNMFUvTEQ5M2QyQmJFYlp2c2FkZzc5dTUvVEcybnUwNGwyTldOWWpN?=
 =?utf-8?B?b3g3Tk9rMTNpTDNVQk9DZUtrOUpQVE8vbkxtYmRydkRIY1pWdE8vL0xqakdK?=
 =?utf-8?B?V1pUdkhQajk2V0x3Rytsekw0am05UExqRlJSWTF6MHV4alFIckFiQmR1cks5?=
 =?utf-8?Q?hcQAeRHdMLjowlG1TDggAU8k7RKGMJS9x4BqIPx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dddc7c-9dda-47bd-f96f-08d957464caa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 12:49:29.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmP1I8Aei6xBjit8yEYqV2c8gOLn5NnU+dXwHISoxui+XHpxn7/0psL7KwGmqFenNo297XdGxDUdZBRtJgg3cbevnN9MzxpNOnVbqPWYMR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040067
X-Proofpoint-GUID: eD5_ZCYI9NoytJ6E7A2YO7iPD9_WSj0v
X-Proofpoint-ORIG-GUID: eD5_ZCYI9NoytJ6E7A2YO7iPD9_WSj0v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 01:32:41AM +0200, Fabio M. De Francesco wrote:
> Fix sparse warnings of casts between incompatible function
> types from ‘void (*)(void *)’ to ‘void (*)(long unsigned int)’
> [-Wcast-function-type].
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 2 +-
>  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> index 2e3f624d0f22..ef722b4a9ddb 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> @@ -38,7 +38,7 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
>  	struct recv_buf *precvbuf;
>  
>  	tasklet_init(&precvpriv->recv_tasklet,
> -		     (void(*)(unsigned long))rtl8188eu_recv_tasklet,
> +		     (void *)rtl8188eu_recv_tasklet,

The correct fix is to change rtl8188eu_recv_tasklet to take an unsigned
long instead of a pointer.  Then you can remove the casting entirely.

The rule here is that you should try avoid casting things to a void
pointer.

regards,
dan carpenter

