Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8F4452C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhKDMSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:18:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229843AbhKDMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:18:23 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4CBejF000819;
        Thu, 4 Nov 2021 12:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=e/LU64s1MiRvkszs1wdOjVkRYHpMPjSipHFNxcwBTVA=;
 b=IdR9zHdy0RXzUH9JD6SfW/iftsiqGyCh5H5Q9GlBPFbSXsFySrYrXiZnXHDJXTatz59v
 xILL0oN0SnXvxkGtiHuGp807tnf2i2jMh6AZLZE/X+Z/L2Uvb3NZvUwv92JGpg1a+fXc
 097xnJQoGSOX6gceaXH1oGV3ObGpDpboxxGDWxZHbCrbjH95IJHXwdO9B3eH1Mgsksfe
 1IXQlU8SLUynlCLy2XA0UTFhr/4ReTYUyi9eeyf5uB+9oUZdfw26fG7SBQl/jBcIGtIN
 ZGeQ4eqfg/dIVDWFdB7ccCWUmFBEDyhupU8PxasPtQe9spuFF/q1z7PFKOzFYiZYcRRh Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n8p7hcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 12:15:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4CC6Nh132334;
        Thu, 4 Nov 2021 12:15:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3c0wv7qe6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 12:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP36H57azf/6W3BVUd2Fgcq/2PypJagk+DuCNUtvkZOKdBmHMTk0m0SyaWCsnN3AxRgkM23iSy5kuoB637RZqRAhLW+mYaVgLKBp6MEEzjw+8ZAsbTVHlnIJ7XfqlD4nmALLQkdeR8dCaEXK8n7IS5Tu6YlIilER/Vwbfw8Ub0VrWHY8Zw+tMqeRRdNKeP/BgQtig5uWY8GkuMmmxELxLG/auum9QHLkHWfcgZKbC4Ub8zLR/Jz62jKBd9IeLYyEFjuv/ilRuUEnyA8CJbKdlcuwhr2TUtysVWIGyoOuP0UxmPVhBPMbyvima+F1rQNrhvozzZgr9QD0/2ta/NB2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/LU64s1MiRvkszs1wdOjVkRYHpMPjSipHFNxcwBTVA=;
 b=BW11rCQGSyGq3S4Wbb2EIuR4VZiW+vjkH9+mGK6HtNe2PqPhH2WSBBD+YOqBNT/Pd8j+TvIbHIzyn9t686KIQnNF4uTuuqefuGLigXQy0eU33H2GFE7KDueiK2H+eC0oTIt11OfYkM6tt1a5Xy/tfQ7DbWTGWqBlY4Kkx0NAXt33BNLcLVDpcBG+/qSTClmBJ9Czf1rwK/UGOtSj0qa9OLVxSJ5KACWcwPl1+Wl2k0yn/4lffKTN92NLG6gNzbuRR0qvTkPRVqJarar+IA58+3K/XiR1wxldeDLaX14fyy4CgpuglgWm/NdJQ0NY1kqSAsRSVRTPxxeuzrsEJgxzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/LU64s1MiRvkszs1wdOjVkRYHpMPjSipHFNxcwBTVA=;
 b=yTP3OK2uyXUFQQ+0b5us7MJxnXZxmwncWdQV55VKy0u9TYGee3+ENDbuoZk94ng3+Gjldq36N5ckAktljCiGaRD43uEFJSL8zSP6OxIK7aIse24AO2PuNqUxFDvmq+MT2Jfo3YQAo/c7UjlC3G4ZjBoWwhVc3msWM73OojW+QF8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:18d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 12:15:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 12:15:39 +0000
Date:   Thu, 4 Nov 2021 15:15:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] staging: vt6655: Use incrementation in `idx`
Message-ID: <20211104121519.GA2794@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
 <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635773680.git.karolinadrobnik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635773680.git.karolinadrobnik@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 4 Nov 2021 12:15:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f084f08a-d157-486b-355d-08d99f8cd041
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5749F2286D83698B66377B078E8D9@MW4PR10MB5749.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3q9cS730AcJZtJ/Dp0gCUAD4ZPWNvZ4HGmoqN8S8Y9mFCOGAA8kMcK70zLilxfIPdwL2iBoVceEF6cx5wywOgB0edgIqoBrfQvK7MyLNsduEHxhlFDcfBGKys1LJk8RKTyN37kAFXcoWcmXwl8piV+bpofksktllytTx008DR8udUqCYufRA9kCV2Ft5wVPg3xpq2bbhA+upqghjapl/lA6wRPdM7mOJfVOWQAXYH2c7x5raagaybm7RD7yMM24hwTketuaO6EQPENAiwtA61luE+G0gLMRa1bnkdIsnaIiZSNmiKAnHhoLQ8mmBcyiYbblQRD2HYoULSgrcpSJAiQ+UnQJIXHMcfnfAmtA6apbiaHnS1yep2SQ1EbWYDD6UOr19H87os8qVr3bCGzgp7OsPPjrQ65/m7CAJcsBo3BpYf42lJ3q6agJ8AcBlEbHE9e6wodr55sMEqAPOPU1IEtzEmq+LAkb970YO1P/KWviAXu+P1YpLeBHFOvaUpThpvwtzVxbWmAqytSruIOKmey5MO9qL7YEecF3+kxAcGhIEgyrNZbC7Kg97VZDLqviKQ4E+0ulhpIjOIeQDorGfpT1jFQeABh7Y+EkrJ0stE3yrQssMbBqqosaD4ol6jSQUxvtwafLhvUaF4feUoS9g0bDHDkaPiFBzbMY+i8XMRpaZZez7V99conUFe7hYFLjGEoJl5V7M0R3jLbg527bnG+cLo4xqzjca7kOkr/FFx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(33716001)(186003)(1076003)(6916009)(55016002)(2906002)(9686003)(33656002)(508600001)(26005)(6666004)(4326008)(316002)(83380400001)(44832011)(4744005)(66556008)(66946007)(66476007)(6496006)(38100700002)(86362001)(52116002)(38350700002)(956004)(8676002)(8936002)(5660300002)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UWNkYlrmnVnGEDXipZdAr4zIBIbxV/cxWiuIn6TvhFTZr6SmkSJpjPdliglb?=
 =?us-ascii?Q?Pd6Km9+t8UbtydkQyiwGBXGRWjs7wwvd90uorcK4dKEhBm2Ul7Ik7VAILlIX?=
 =?us-ascii?Q?NQqnfliUsGrGBvigXN1OqShhscPg9vqX4kgANp9xPiS+IsOdcck8PNzK6zbC?=
 =?us-ascii?Q?f+FIU/0Xri8uMg8QZEqKe2NIT0LQrvH6JXGmtSUyE0ZO1i35TcV+A3kMIHpi?=
 =?us-ascii?Q?CP1fF6hyLDp/dY0YTRqx8dqsjI54kcACvUEEStJ6w9aB1Rx+eU9Ipon924zy?=
 =?us-ascii?Q?1JPNM0xcfFpS1EZiceaBFHvjZyRKSfg6/o59ckzc0NzVqSZ67OuPyAPssi8v?=
 =?us-ascii?Q?oevWsLRwXWuaH6o/O7Z+96rY3uBEUR4Klffpu/vfTrWa8ZEauGrwt55E9Xmh?=
 =?us-ascii?Q?4CKWQZa1wZGmfh4lHGllEBvNGaDpL9Guv3N+WCt5vCirBs20sSyyJEVD8+Ae?=
 =?us-ascii?Q?qI3BoRYFXTWJOfOM8IHJegXbi3Guoz29oz5syktiBT+lz2wfFdOFyD89uzN+?=
 =?us-ascii?Q?U8D3RUrlKdW9gzhKhCnzKouuXg5f48pI95xPDZn/IKZntCXnV50zN1u2pejP?=
 =?us-ascii?Q?BEkAo3/oLGd4yVKMOnp7jAiCgytCEWf6XJaExcnu2YWqhW1wnr8KZDpadIwT?=
 =?us-ascii?Q?v/1bBnsJRCk9NEdaM7snIfM3ptKp3vWnA8KJIICXYgS/lx896fz2egrX5jzs?=
 =?us-ascii?Q?T1ItaReaYsiDSHnVx3NAcXZf7R/uhkXl1skOR9GU60ZKB50TWrKFS4z79VeP?=
 =?us-ascii?Q?oyND+EJDAdCgkD6pOx2W0cVIuMwneeNqaFe3/cNFMwC2+q9SAJ+KeZGAlG/I?=
 =?us-ascii?Q?umywAlIZLYNRJ91U/mZBJ7JV7pML41f+Vv911m3AlKxBQq5OTnElanFRUbjl?=
 =?us-ascii?Q?/JHmGMsWKV5K5gEkYSbgH62w/+pXpjK4O4jsX4Bx7naNCAs16Ges0k8Ap4Ef?=
 =?us-ascii?Q?TPz+wEhmcUHT+TRzb+WYGXiWKqAt41V+nXDZo/HR8rqIE+e4bstmIpe6Ef19?=
 =?us-ascii?Q?VDLwuxViZrFEvodm552IFfEiLz5F99aCpPfCetxqXtKievSygh+NV6yip6o4?=
 =?us-ascii?Q?iLXE0C3UUq7oVHENtmUGvtLFHhyU9BqqYsbyXtR4c1+1qhgqWrwU9z4Kydcr?=
 =?us-ascii?Q?AAJWBnAByJPOb3K8jwTvvpQAUo5ead7gQ9kWIlqsfq1hmI2cYXUEvVkMZPnh?=
 =?us-ascii?Q?UMb3kWXQ7j8EMkG6ta55lj3esK1yGINCjQTs8Ic8srXgPxpz8Uj4Sq/KUhj1?=
 =?us-ascii?Q?MPTRZZejji/2bTzzSM93J8zOqoU3SVhj6659VgFT86KJgtwHVO+WWsFgvzy8?=
 =?us-ascii?Q?p+GU8TLlJUBk+D87KJ6crecYOr+sjdqARjzCLsBAQ0Jal6NoEDlOwBs19jDP?=
 =?us-ascii?Q?emAqsZ1ImLXwPFz1vBpJzuOXRCtT1BDmOK/8PUlCGFqNCvyd6p6vJbyvK7fp?=
 =?us-ascii?Q?xBKPnq4DSWvLW65hjeWkyJ24Z4ZBTa2pfguor1XHIXwMm5BDEDuaW/171sLA?=
 =?us-ascii?Q?03Yn23YXi4yh+GUmi4tkwdTamdiA9WHdLoRGBDA4xHQBnZra/qRaa3w7XSIG?=
 =?us-ascii?Q?RMmVNje7LkNRZTp7ebj2KWixj3ezL1cd1TomioTA+pYPVxMa6uRJ0zwOd7Fi?=
 =?us-ascii?Q?1/jxZAA7YHQ5YKMsPwcNkOAOT5RX2IY5rhWSKtx5Br0MB8sIwuUxBi+CaRRV?=
 =?us-ascii?Q?6+L1CNQhuQDMKDxtPgpHmZKRsig=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f084f08a-d157-486b-355d-08d99f8cd041
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 12:15:38.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6QpNQBWRPtbbooihWNm3WKHSdV6ibsSAz3WzMeNZFjbxg4JLMbDK7y8Nz3MXESOrqrCm7P5L1HJPirQozVOPDGJBVaas4tBT8c2ldb3kSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5749
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040052
X-Proofpoint-ORIG-GUID: gwNHpe-O0D3-mclbSfMrpSsNi27b7Oxa
X-Proofpoint-GUID: gwNHpe-O0D3-mclbSfMrpSsNi27b7Oxa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:32:00PM +0000, Karolina Drobnik wrote:
> Increment `idx` in a loop instead of adding the loop counter
> `i` to do so. Thanks to this change, the cast to unsigned short
> can be removed.
> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  drivers/staging/vt6655/rf.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> index f195dafb6e63..c07653566d17 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -700,11 +700,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
>  			return false;
>  
>  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> -			MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_init_table[i]);
> +			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);

The cast was always pointless.  You can remove it without any other
changes.

regards,
dan carpenter

