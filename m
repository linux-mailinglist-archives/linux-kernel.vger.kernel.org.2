Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB64452B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhKDMMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:12:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21414 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhKDMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:12:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4C6cXs019885;
        Thu, 4 Nov 2021 12:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=EqLAdqHY3etkcPYWPSHo3tgNngL4zTVP879nZai9yBQ=;
 b=kdv5mlzzNFLCdDKw5M3ZAmzwBXszCdIFsI1wqWMFxktJrC3dHgLXVJBclmzviWquAecB
 i97bbD95IStcD8j700Iwsv+N+hAasxe07aRzJqC4qFzkFJDU39Uf4RWZE8vOEiCYs0+w
 thESuA3nefe7YHZLEmEDw401yG6lf8zotQP/h6vNt49ZCpY82GfQW5s+4ptMzP23YDzY
 Z3useTIxRTA64q0kBHuWwbs9ryToKmFbKXbUwPVOyZjsaxrJxSTeXM84wH9CHRNLTfel
 pLYbOIAxWwub5uGdHVD4ypS3B611Lmk2JX/WopSYjm6HpPyX4lLxomSLaHMPDW3SOV2d Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3mt5g1y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 12:09:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4C15T7045878;
        Thu, 4 Nov 2021 12:09:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by userp3030.oracle.com with ESMTP id 3c27k8k0cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 12:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0DZyhhImErUqiyo6iirzSlSg0oHNyyulvWefkODaZuE2j2Ghwpk4q0fRpBjUL0P9afhA8zMEu6i2zDfxnv2Q35kkm1sLP1So+Oedrtc2bnytPldIQRZ3ifAnFeD9bnG3EwgcqUUrLb5GkW9A8Zs3RMtTaBcEJzc6RQMn/5IrsaGVLTosQxxzbzjUG2YKcI1HVOUSqAbbe5EsKOAkl2KK28LxBa5uSjtuZIUhDExIxnOgAQJ37OqdhuSOMxiP1GZy9q5XZqUDn89ZcI1vbkHHqn9vSiawV1g0otNmr4BlfADKV4eoqHwAyFuITO4+YOXkqf9uGXU+CzJ9YsT4RSczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqLAdqHY3etkcPYWPSHo3tgNngL4zTVP879nZai9yBQ=;
 b=U0ePiJs6PktxKam7exvvd5KnAJlBAH68g0aRwY7H7ptzEXtp28uT22wwe63XIvlgiWeojPgOcTs5TUoSbSbB61dJYgNDI5krHgRfJw8nLwn3GNA8netLff8C4W1tAtes5I0XvTl0tdHWBcsi/2WJggPlcNaw+oqaXiRoWSHs1v6FeVEAHsEWlKFpuJ6J4b/BvvXawmE+tK48xAJ7hY3L8ihUE0gGmt9ypcwb50sUo2jrQ+kBckc3Z2z+h6Q6KAagTdLb8K0uVVbMfE8kCfYrkxU7FM7W9W5FcrD1weu8SmmfZEOVUaPYpEGnYlGEmHZhl16kGhTxqi6nPn2iiAMROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqLAdqHY3etkcPYWPSHo3tgNngL4zTVP879nZai9yBQ=;
 b=ANJE7z5/Kdaduz3BmT6jOmqC8nM8Vbgw/8uqJvoQABmLmz4pqpTBEAePjrorVVTt9eVM/HfWVXHg+Wlw5SJoCpWSKtrXpMmj3U/uC6NaSrl7htGzN7AaxtFTghSJbgi1ebh2ZLa8LcdA/aVqJ+JdnrZYeqrNaug3FHsCVhBHY7g=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1551.namprd10.prod.outlook.com
 (2603:10b6:300:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Thu, 4 Nov
 2021 12:09:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 12:09:27 +0000
Date:   Thu, 4 Nov 2021 15:09:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] staging: vt6655: Introduce `idx` temporary
 variable
Message-ID: <20211104120906.GZ2794@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
 <34bd0e8f42597edf006a950d420345befc4e0bc2.1635773680.git.karolinadrobnik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34bd0e8f42597edf006a950d420345befc4e0bc2.1635773680.git.karolinadrobnik@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 12:09:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adf8d0dc-48ff-4abc-4935-08d99f8bf29e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1551:
X-Microsoft-Antispam-PRVS: <MWHPR10MB15517BAC2574890E04103B9B8E8D9@MWHPR10MB1551.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPZB2DrmIklCZDI6U2U1mZLHsxyOzlP9jUcybdtqYSuCGLTZyFJsE+xSX5eViGWHonTKuTtaeWg2t9dJwSDGxWUR/C3n9uTqNmeZaZ3+RNQLNj2TDvOsHA6LltaclIXR/bSYtD5Kv6LaIRhgwCzHty7/sPj0wqP/20ZSvt7dpb3UAIBulo1oLz4ghQ1fC2+xiaLYJ8OLp7FValICpc75F7pNl/eU+ydxuQ+kJ1mS4KaCITRhyAJb0Vz0e+UT8I4g5gSbbXxFbh1jwAmtYLSDe3naxyyXCfHG31DZsRJElK2TsOWV4gYIVFlQDU5pgsK42Vb0wVEsZeHlrBr9gT7+4zrUdK/S9svEkEUm+RDrXaAJPv9rxz7dBH56cB6u2sCLjDv/m+iZzDuWjMlXPWyuwXxACl5nUrPZst4Y2RHbvIJ2iPnY+97QPJxIIKE3k8VoaxB+b/pNl6/MtBq3xFLJn7MqfBpT8JJGMaNOwGUWJ1ekd25a7vU9URi1319bkokEeKWDtouzKLi49+1t+eWuSKz1g5Hsg6Z/uJ2yFAWQiUH7CPxhlcnHz0+zspbhhPzTLvBzdtX86JTHmIInMeOjYyXwiV1TLzAEyMJKgIpkT6KAk25Z7lIy7JVoit/FvccSXDFUBWbeS3amVjvrd3mURwfAEIG3JzEsqLvy37xftroBJTvbmNl9eKLfax6eG+z2DD6aWXzS+GQgXjA83Ut1VveUpozCEkSyJGLG7kupQFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(9686003)(5660300002)(38100700002)(956004)(66556008)(66476007)(66946007)(33656002)(508600001)(26005)(186003)(6666004)(52116002)(6496006)(1076003)(4744005)(38350700002)(55016002)(6916009)(4326008)(2906002)(8676002)(44832011)(86362001)(316002)(9576002)(8936002)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oy9HO6Ls6m8mDtsPhG+iQ7yro/iMovt8RWq71KQTAbSzlJ188cC5e7nTpn7/?=
 =?us-ascii?Q?6AwQgjVHad32+2ogANWLwmNBwUKx/JyCGkxJPfnNsfnIPP7oS+hpvdA84sCU?=
 =?us-ascii?Q?gl6ahl+D4ZpTMEZxCao/2VmqjSd/tE1uBMtK6ROwuuePXx62+pLmdJSUSGmM?=
 =?us-ascii?Q?6yt6/U4uVdvZGg22Ej2xDzkLQeDhd22XZ33cnIlEnGAOkk+nXeLThq+B4vZX?=
 =?us-ascii?Q?+6YiaO/ffWb8yXzFi7oLrpp4SIIRXe1FekRJ7k5c4D86S+Y7niLrNPDwsaGV?=
 =?us-ascii?Q?s3MRnFVKDkMO3CcLpMN/fehQRAild7HpUU6ix8c1qHOBRrmJ+2G4bdnIxGt+?=
 =?us-ascii?Q?VINjj3wHDF1q8E/34jPSeUGFGNYTcKuAEorNQGUohcGvXBPDPfO+KMJzVRGa?=
 =?us-ascii?Q?SCmG9rNQIGccm071TidkGcvDLu+hdgpNxWQIp1VyORVg9trMjzekLl2iSNwE?=
 =?us-ascii?Q?ZpgPH8ohHSpBRySAFkpril7NggenwLUHijuIRkqQeMMWqlhyBoxNBqoHbeB7?=
 =?us-ascii?Q?Q1itWvSH6fCvuh5ra94fzeNDUz54sSrMSuOKykOV65fdtx9RrdV7rhbdoxv8?=
 =?us-ascii?Q?92e/XObsxQFLIIGvE/4B/QqUOExj1SDxz/MKztClLuDTzkWwTAkCgS0av6TQ?=
 =?us-ascii?Q?CwYR3+aP1fl2uCy1wccN7MbV/0Ynmckorv0CnFGqtumKnS/qsJmrbBB6vPvh?=
 =?us-ascii?Q?5eXTwxzELHoPg9oEzFqtZPM3q2Fjfu62Z6gcREE1jSBzqCaqNZ8dLEGRwo4N?=
 =?us-ascii?Q?Hv7X/iZGHj4sHN5mVsPhnVl5GR5hHVEa0c0PTaM3sgcTBvJUNt7SXJhXBuOi?=
 =?us-ascii?Q?TV3oa2UAaHQZdi0pRFvXBIoaY/1kB2wLRE9weYkNPLm7o05cuQr7OW+PT89v?=
 =?us-ascii?Q?YSyjFjfuGGzjbkxCGvVvAExjSLqaxsx660n5CSU0pmTe8I1uWs4dTOuo+0u0?=
 =?us-ascii?Q?Acao+oyWNF+Vxds45520HniGOuaBWvjSOjS/qHrg1Bgi2QgvNTLfnIFMzXUZ?=
 =?us-ascii?Q?pivMxLNB/CGpRng+BB72Sncdvacy7zTjpFnRUuODm6fFgGJR/62bdqzqNrfP?=
 =?us-ascii?Q?yffjuv9evO/c9Cx5py0g3aJQNdxCJ2wToPpQCE7BQWQN5frFJtq6Jp2lApdV?=
 =?us-ascii?Q?CordFUglmSRW5gwLk9ie3btNn99/yoQ7npij8NV7fNl3nL7WHPBvdEVaaxR3?=
 =?us-ascii?Q?Js0GBGQSYlz0za1l1DhkOMR7AKKO0jWbtIaz5xa/kGuDKDAr8RcYmvx4PUIS?=
 =?us-ascii?Q?+n25b5wU9j+anoFeQYquKHMb5SjMGuKpPswvtdv461bL6+uGXhvySWhuHXVV?=
 =?us-ascii?Q?N6PIM5QMZJEeoIJtv8ZoHVm1LHz3SFmgWvyLISe1DHbHj40qjsXahjdJKXuG?=
 =?us-ascii?Q?Ib+oqdAC5yslC76j5/YWI4AE3Pa3vY74dlAmmDXmJ0ychO+r0l3MmcvhJOks?=
 =?us-ascii?Q?GyNgGrA6M6MvQk6fNf48d02ilIs1g8aQCIUnd7Gup8Vh1DSeYKgLJxxkY/de?=
 =?us-ascii?Q?DW1LoZ9qs2fMeqtyXjB/glbYdluJIpsOmnOAtI5r6nVs4JbrK0Xl3+wWP9Uc?=
 =?us-ascii?Q?Y6wdMKhm3S6RoKCaosH+Qbt70xZle8j9suZ/boqaJWrzbKao0REyWSyLYD6B?=
 =?us-ascii?Q?J54jCpZggMMBPwp4SIiGQwkavd7LtDT8IPXek0AWW2VMomJDquGpdGnBVlla?=
 =?us-ascii?Q?99kuX7zpJXnC98At/cCA+yexhnk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf8d0dc-48ff-4abc-4935-08d99f8bf29e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 12:09:27.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJ205VF6isAcLaMxlqRy6dMotV0IthYc5DZPGcfQG0XmGWiglMRMpWh1OPIucwRt5NzmcSsp/mM//aRAJ8EHeBw9CWrQ6W7E/gYbwPeH4vI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1551
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=851 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040051
X-Proofpoint-ORIG-GUID: QH9LKGvYLPvhB6ljC21aeJVpPIe66iLc
X-Proofpoint-GUID: QH9LKGvYLPvhB6ljC21aeJVpPIe66iLc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:31:59PM +0000, Karolina Drobnik wrote:
> Add a local variable to store `MISCFIFO_SYNDATA_IDX` offset.
> This change helps in shortening the lines in `rf.c` that
> are deemed too long by checkpatch.pl.
> 

I started reviewing the v1 patch but I should have been reviewing this
patchset.  Please don't do this.  Leave the constant as a constant so
we don't have to look it up.

regards,
dan carpenter

