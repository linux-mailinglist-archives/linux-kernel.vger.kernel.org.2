Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAAC420615
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhJDG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:57:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27168 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232655AbhJDG5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:57:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1946Fxrw010779;
        Mon, 4 Oct 2021 06:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=P2X6462xTdry0pScGpkb4C+Gk3MGhvjG381qybw2f54=;
 b=hcDuH0xUpM6NFZCuIxhsPmP7aTM63cv3bqeh/aOCY06ON9McduqtFdlwg6uNgwYy/EkZ
 4td/FSFfpMXQ9sIdZ5qgSqf4ycBNk76yfrRu59CDYQWfgyoIZgUjZlyIm8BdCDGyq6W/
 sMWoabXmJBFwl8IIQlWx3yLu93VrSsut6K5boohqUnegALxp5J17lZzyRb+54gtqtDz1
 hLtnCMqyOgCVOQU11LmUmpwidITqKONOUf4dz4V2LC66E2h5Gfiv4jfpruSWUAQeudih
 vkhmJRqoJ+zwKaASkqNXhcnoEptzQFk/n79ZihKCbItHb2QM/JvMwLu0eLrS/dyMO42K Qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bfaskt2r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 06:55:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1946nqYY139489;
        Mon, 4 Oct 2021 06:55:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3bev7r8e62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 06:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1zWcZEjhNb+S+gf2l9/Olr+pmLjA6cEeYWUb8uDz+NCKydCoyZiFr2JBPlik00Ra/Dl+4PuHw+0fhwlxtRTkZOKcDNj32g0zjZbDpsAqIT5JgLJ2xivwpn2FMzFqyaYiNHrsjKWE7bIJITYgfPfz9CoYMIgvXfNc/opIJ9zhNYRYIIVKaQdwEUGTBUkSu2XyIUWLLILfJPsxWazlfOlFYTjEmJawWo3yobXlB2imFQU2xJeKWhrs46j/auNnlm9IUKCPNkbpDtquJoaYQSg5QI9hCRNQQlos5o/LyS6GYvZvFWHDOQS2ungM8gM6xHPcQLgRlnfllU2+VZhO/thcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2X6462xTdry0pScGpkb4C+Gk3MGhvjG381qybw2f54=;
 b=mHrMa+l4bJxrouv3rXfUdfI/kyC4da7kRBg22YA1r7S1gM2hjvOxVBQNb6OAjROGeds34NfEh6JGSHa8LvZ9iPxUWL9QrPlqIZA1LtxkYfvGPo4B5CdsH1DXJwCw+8ieO2hy80L8e5E5AHSlWFcK8S/qSFW6dUAmqIJpVyYE/NhfYq/I4QSKnjrrXQfmtRLWOraJQdAEN1gPXmp+rZSY0jsrZg1rYzhQ45ouGefSWB/zD/U4Uq7f1YiwtlE1zG3Pnik47J2sBd3x9Dtf/mKxf5KFA7N17hOyO6PhnioB6rvvOwYHDB6CxdduFraCmyhiI6OuWOAjMVlxDERvNxNraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2X6462xTdry0pScGpkb4C+Gk3MGhvjG381qybw2f54=;
 b=ZeGaraQQOeG+1ZLAriLRrNEv34G/Tf+W/QF1nqwSd3Ci68z5DHSGYQIs4PROIx2oaVYqH7p1x/uwRhFsIvJGT9QfwqDaJnEhN5gN82JGW9qrZdNTWNIOVDnrFlXNZJmoyT5UyELHeQFbkicgYbxdHS5mu05t1uvvkW6nlQdqKrU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1359.namprd10.prod.outlook.com
 (2603:10b6:300:1f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 06:55:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 06:55:31 +0000
Date:   Mon, 4 Oct 2021 09:55:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, arnd@arndb.de,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] staging: vchiq_core: cleanup blank lines
Message-ID: <20211004065511.GC2083@kadam>
References: <20211003195758.36572-1-gascoar@gmail.com>
 <20211003195758.36572-2-gascoar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003195758.36572-2-gascoar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 06:55:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d2a0be-43ca-4967-031b-08d98703f4e1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB13590717EBE720D8B81875DA8EAE9@MWHPR10MB1359.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsK2mRPkLx94/YS/9Mpz4PZm7DNxLa0atUT704pHCvVVA0DjhlQbqWYUtugkbl/PjTP65l9LFw5R87uvGdo47HreD076+cn0jMgyWdzE/9CHANjJfJuC4slWdKGIqgLD4cRXKAS9HuuKTFaTYIq6h+fQdipHUh0y1nUygZjCBntrego7ognGncIaWB2gRqe4lsozRWAayLjXXtfjxEKToXsSiIqg8Y0mduLNpGMx1nQsuxHK1+mEce13J+Za8zrFkzXaD+wn1IfxexTd+VcDV4402NiQjbNxYflP8akDIgOuJ0fNjLX8l5IhQA0gE7A2BI7JP2FjF2ac1qjdu3IS5gbZumWVdfplHyWMGHt2eBxX46HmMK/J4RLcbAvXzsVj7OYsYlrpjwTKevS6u/Lb6SUXFWAKZfWAtCpsMEnLMLooTJc0e3P0g55FqyPoTB74+l7cQw7KggDfY6MqdoT9dNcs7Ra3zASYA4/uKmQkOUrP/zABsTk8zaYfhC8Ya5T99pkd+QHQMJKwPUbMDq3gyDwm4EnA7O5ZzuSCdPJuMFAiE+DXgQNfk8+hvItt7JiZpJ3eOTb1SXzFFDJ1zqvdWA6D85gD1D3ZBJrROS7W8M79Buw7DzsjwXPKdWKaZUzWj2CM1rAfoOzmfWQeycAW2SPng5FIJFl+suRbLbJR48BJObqGAq5X2YjtSd7YLW+f/+V2594uWy3ZnCkNov109w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(9576002)(2906002)(66556008)(52116002)(1076003)(66476007)(186003)(4744005)(33656002)(6496006)(508600001)(66946007)(33716001)(9686003)(956004)(7416002)(86362001)(6916009)(8676002)(55016002)(5660300002)(44832011)(83380400001)(8936002)(38100700002)(38350700002)(4326008)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jlXLTNhf0bThU73bflmpTuD+Ty4WDnGgV7kHU3MjFEAgpUwU4KWD1uclmALh?=
 =?us-ascii?Q?NZHqBrQE5Sa0Ai3uhEuHGxlphKrM0cjqoy2jfNrwmYpPmXph8A86ejaP0SkW?=
 =?us-ascii?Q?ixYHyWQmDIiZ9SEkPwIjZEsBVzN/kT2cGbSaIwFF3LvAgHu00eNd/4f3gc88?=
 =?us-ascii?Q?ADymUAomP+DWaYgdL4/h4YBAiVE9vINW8kDT0ziZAT5JOvK49l9oPZ/GawdP?=
 =?us-ascii?Q?Db3DEkvaLKgI0K3T/3TEW4fI5lzeNXmCbW42WPSwEL2JYR8bK6ebwu7ZmsKC?=
 =?us-ascii?Q?3luCrB/483I7OwPvqSSvWU9gfNTDrDMLELFiS4Pnqe+NOuVFhKauQpCYUd4E?=
 =?us-ascii?Q?xfKDLoajalAqpR39nLjUJ7NMzj/vsqdlxEd9gJUvzUgKsCia4p3iD87AhJjK?=
 =?us-ascii?Q?iq5wICiiBUbmsLMCADx1Npn5DqSI1axB6wMilEiFFr5bCBLKCiYUVBjlpaKl?=
 =?us-ascii?Q?OVmYnQWsyMBLa7u5atPjyAoUmpXWH5HeBvaGNMPQHQYsUtCf3EN/dqLcz2ii?=
 =?us-ascii?Q?7WmpSrFBcNxJql102/lpSgtSFrxS2UgZgoBz6jlklygQKqDc+pBU0NLhgsUb?=
 =?us-ascii?Q?jCxz2QYiklE9940XVg+Eh1hN7VKmek8P9Yu+EoQ4JJx7Tj0hr54PLEcS0FqY?=
 =?us-ascii?Q?QBlTvjxNU/FFaWdNVYQm6aWV3oDFxLyOeIbfK69QgwIT5fPC0oonYFlRYfn0?=
 =?us-ascii?Q?hSPcqok80ZX7hEkjuWud8rKWjZ0e6vPXQ1NLLjjmIKSn9tN12gy4qAFVjMcH?=
 =?us-ascii?Q?YaWH0gy/k2l3MUqiXAlXnRwyFka7NBwtPPKXK1WWdia7kPgtKWvrgrrGgcMV?=
 =?us-ascii?Q?P/RAzeaRPwHdHQGjqxMtQHgtH0D3+Ts/ADkZdyMk/J9029N3XAzYIHlVETCR?=
 =?us-ascii?Q?7vwO9pRilkqzF0huMftecmomeq3jMMtnjjnLBat+iJflu2WXWy/yp43B6bqw?=
 =?us-ascii?Q?N/RmBTi9lp7Fd2QeLowEO9HAwnMw/RGh20000LxZPxZwbd7EFePQqueNtpV1?=
 =?us-ascii?Q?EuUevev/lwrdCB3chYW1qPX4WEFWtw8Rgfv3YQilNaZVuOcQqIsjTyiKdLC1?=
 =?us-ascii?Q?fRIHgZ1XlBBDW0m1i4L0/jl4h+SEABKkAJGmA6gRxNR81DJxUc9vIK2KujW/?=
 =?us-ascii?Q?XFEfk+BRqXzHAOQ8xNgnIVx4oTMngNW6VcO6Z/KnnKwASH+3ZdCFeyFMjllt?=
 =?us-ascii?Q?5WcHXpPgyERrt4Ez/QzsSjaE2msvAZMqXoAl6FTJhi8s2GpXp+ifFlCe5sfL?=
 =?us-ascii?Q?Qk9iMBMy/vwhabd8WJZuV/hKgv/mob8PQog3VcF8aMBPHkj6YcVrvbYTJpdJ?=
 =?us-ascii?Q?xPbbqz1g8Th4on9KtpxJBMMD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d2a0be-43ca-4967-031b-08d98703f4e1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 06:55:31.4313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFJcwlACUNgdweRqqtxddNrB8Ts2Wsi8ebJ2zhpLLjoh/U1DrwvcTW8x/9ZYaRxoBXMsRC59oB5xJ0J8mKhuKBquMfMW2ZXZNuGTt7b4ATg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1359
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040048
X-Proofpoint-ORIG-GUID: G_6cCXAa1Qbx58Br4bwwg736YVhCsMGV
X-Proofpoint-GUID: G_6cCXAa1Qbx58Br4bwwg736YVhCsMGV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 04:57:51PM -0300, Gaston Gonzalez wrote:
> Remove unnecessary blank lines.
> 
> Reported by checkpatch.pl
> 
> Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> ---

[ snip ]

> @@ -3207,7 +3206,6 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle,
>  	}
>  
>  	state = service->state;
> -
>  	queue = (dir == VCHIQ_BULK_TRANSMIT) ?
>  		&service->bulk_tx : &service->bulk_rx;
>  


I don't care one way or the other about the blank line, but it's
not a checkpatch warning.

regards,
dan carpenter

