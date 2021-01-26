Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F3B305007
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhA0Dlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:41:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58972 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbhAZWJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:09:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QLj9jZ091515;
        Tue, 26 Jan 2021 22:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=7mNW6ciIU1WTDZ7aTwCbRpfZojru6ogf1X0iEf46L3E=;
 b=RMU39OcvwGgp3/HTADK1h1cw0dI71RvIVhvagluHD3y916qTkeu1Lpdv/xBmE+6QNE/r
 5bzoYA2kNrwwnoGmI4+JuZpaUXebsL/60jgH5Rvw53MmBy7eQ/YpEZLYnyQxblsYTfcI
 rFLZLz6UiU7Dw/LisvuWLHquPeuypSCyZpimVhjpvEkzxcyXgCiHZdAiYAfiSlQ6uQLT
 Ebgb/wI4QuDMgEUPg8Tt2U8qZ4UdUXfGViX9OAOwCkuMC98ERYMTy5r57xjMct66fhq9
 kIbZ+/lsIKfrz19EOQDSxzor4CpYS2++7HrDpPvgogYe+bhCHNA8ahUWrtnUlK287BVS Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3689aamfu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 22:08:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QLiZTF068246;
        Tue, 26 Jan 2021 22:08:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by aserp3020.oracle.com with ESMTP id 368wpyg51p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 22:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+aZ1CK8d3Yff+DSwX4Ba3sxdVurk12iY5oRaJ+xICc3LJIlo9MsbTxgDt0rfMRfyXPrbvlwVOwvX0cUdqYVkkB9rYBtZwCJkqayUUDIbYiL46HKrDbBvQzHWxPxDjOlTXyQgakczKwkX1h0Er47/iv5W07R7j/rSQKpvhsd1GmAl0d88ph9XZ4N0gIH7lZCQUqklSsk2sZ2qVm0YBu6/KKixepJdX0jq0+ChVzjSFbk4dajYkFhK8K8WpWR3W2PWUzSqStkiCM6CXvIeiCsDhdlA2Www2PboamZLhvGzBtWNjBMjzyPN0kEeEzhB4nBy7TTcHDtRbuFCBjNLF/Bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mNW6ciIU1WTDZ7aTwCbRpfZojru6ogf1X0iEf46L3E=;
 b=h2PwZbKuyNNhS2EeC/tTxKe4fYX7Ukn6uROgByUM3Tyaz6IknM8ITeueW4INOmYsH1ckncvZ10sIslaUb1sdaA5YzoOgQH1LQJNO2/OfXnHKSG/QbTaGTY3gWxynGT3G7G156802qPvUGEv5oiu9tQOi6X+5tyhUwK1pU9gbY4gfkN588GXjWGFcJ03Iobm6wZ1D6ld6FAVTe4WomuzPPfKWVhCejDSOEptigzsoI8EaoU1XNfRcH+7yuZz0RsqoGOOuJMMMcSmUOk7Ysu6G8jxQsosuI3s5FkwsDPHWZ7cNUCwodFgOa6UecbnahW1DVLKV1WihImVJc504DnfTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mNW6ciIU1WTDZ7aTwCbRpfZojru6ogf1X0iEf46L3E=;
 b=xt9OAfodpAK0I8deOWi2J6jQQPWxCOalMbqs5IyqxPA381fFMVj5qFkpgDUZDYiGLQVbbcetMbPEiqlMrxM0ZPk9i47GD44cQuPu1JXrJ7ESeFZoT1I5ywQv60vOp/g6fNhcC7PGiZzMUqwbmpugJb/RUxX+6bQHm0rHgkka2L4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4559.namprd10.prod.outlook.com (2603:10b6:a03:2d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Tue, 26 Jan
 2021 22:08:53 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 22:08:53 +0000
Date:   Tue, 26 Jan 2021 17:08:46 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] kernel/dma: remove unnecessary unmap_kernel_range
Message-ID: <YBCS7toITTwP04aK@Konrads-MacBook-Pro.local>
References: <20210126045404.2492588-1-npiggin@gmail.com>
 <20210126045404.2492588-3-npiggin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126045404.2492588-3-npiggin@gmail.com>
X-Originating-IP: [138.3.200.9]
X-ClientProxiedBy: CH2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:610:53::31) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.9) by CH2PR17CA0021.namprd17.prod.outlook.com (2603:10b6:610:53::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Tue, 26 Jan 2021 22:08:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b955be9-2bd8-4d60-27c0-08d8c246f774
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4559:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45596DDD28E249A71D3B073F89BC9@SJ0PR10MB4559.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVGmA2HwEi1i5ZZvU4FUaSUTZ+tWHBfbJww3dSpf971aQu3quuEGSBr2M+O4NZXpypugw1kroKzFMjxHPLj4AvIiIsGAvytBPJKx6TGV8MB0z+qv6B25YXfjTDd3Mv+Ro1VgokKjyuPg16xNSlG2nGSPbV600aBRVMbp6PcWoRQnWG7NUp4+QRLSLlplxzpmuWKh38VsK/SfvKNnZn7y4uFAwjU5tVrTm2OeKmosg6hsbpuTvR7WGojL9it6AVl+bJzWsVAC5BMxgDSODpscJ+pBnRdZkIngXX9Bs1CjrerRzQeCKTYlnYoap16JrISDPAKejoWyxj2dFu7kwCKKdS5ifxQdYU8Psu4FMvrXRjPU1MixuU3HySrggCjR8r6yT4DKiLIe8SvgYDM/LdBv4WEF8zylV76RuFe8dIZbrUyBGDAzvK6wcQtdUw0rODgxseimje9Onjhe91VEwe+wUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(478600001)(316002)(86362001)(956004)(4744005)(5660300002)(966005)(7696005)(6666004)(83380400001)(54906003)(2906002)(16526019)(52116002)(66476007)(26005)(6916009)(55016002)(66946007)(186003)(9686003)(66556008)(8936002)(8676002)(6506007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FgL5Btt7ay+QCa/R0U3lDslNVRtiHRvudw8xpOFJuiRHDL6FY6LWUBMoBdFn?=
 =?us-ascii?Q?C347AFuCUuIRJAE0mfzxMCYWoudvnw6oX0GcBsAmpmOO/ma9xVLmmnphYurQ?=
 =?us-ascii?Q?7pnZcZq3y0DaNq/+bf/Sp/N+9y0G1EYV0nQHUpLIACOo2vD83DuPPuzVJkuQ?=
 =?us-ascii?Q?ZpxWgFpJN6VYIoG/5GJc3Hi71m8vQ6C+BfqdJH3GsCCZUaAEXTci0IGLPRqt?=
 =?us-ascii?Q?xuzAEoR4Jai7MnqBEIp75aB0xWT/0XmugmUbjPo1sgmK0cvlgf5PnbmPuxeO?=
 =?us-ascii?Q?tO5XiFToHMFR98D4Ov7FdgS9RSnwTKbE2zEweUUzwDrCB0yAjHJYPHNsAKn4?=
 =?us-ascii?Q?U7+PiIHRPkjIYqVgz6S9FLC3s2Je9baguJ7oy9jfGfPaC7cKpBmHVaT3OdZf?=
 =?us-ascii?Q?OrRDpOPkfpFWhXSJVodg2TYDlk0d/8UdkLDKVkS5eEAw57u95zbuf3vny6OM?=
 =?us-ascii?Q?28Kx3KDxgq+IeEDD28ACvSNtusmyor0mkMB2KW4BhP35X436bV8ckftqPgYY?=
 =?us-ascii?Q?FnpENLS1c6NEnklB+4HcZTPJIJPpErHfJGkyCOD/lDzKqiKH9kPWdGWgB90E?=
 =?us-ascii?Q?IuHHjmSTE4HCusyLyIRCis8EeOKC3VlyaucoIwEQcpaSyr5k+Q1CLO6ZmTh1?=
 =?us-ascii?Q?3y9bpTC/Hgg8pKXwaURVeTjWefBbJv2qUfbVEgZRbXTQiseBWnTvr4ixcQYL?=
 =?us-ascii?Q?UtZhQhtRvV8spIavgRqFOSxvL9pIFK+p8bzq3qvvFY0BWQZEiIMrVoH2e4CA?=
 =?us-ascii?Q?UMeKEUHhAWd+C9NxTRQJVPnN+p0uXQUjzent3wufffsWNmzjS5IEObmIzcB2?=
 =?us-ascii?Q?n9ZTQSY7627MxUwIubhTkprz37E91si3Ygn1qTEnDzXV7U0xh7YF3J06sLnE?=
 =?us-ascii?Q?mmshaLPxjDkbSJg/CoxXOu503uHIGENMiHfp8BsHMo2yml2n1bTYBidiVBfK?=
 =?us-ascii?Q?dbFmENWX5wM+3YBzp8jawlCvu6//BAb2A+mgbRyg635qhEo2C5nRQ1tzjzet?=
 =?us-ascii?Q?TKtSwew/Ui1679+X7uanvQAtZKWiA/y0kpLUIl9zBmCPSYsR4Kb3Wco9zOtn?=
 =?us-ascii?Q?w+hcnmVZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b955be9-2bd8-4d60-27c0-08d8c246f774
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 22:08:53.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0nNa6zHyVTyrEvFWCdJ1zU2NW0BbYwUEzf5Ftu9ysWmm2hAwMebNUGIsP8i3bRfATYuK81BmjIkKx+NideA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4559
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260110
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:54:01PM +1000, Nicholas Piggin wrote:
> vunmap will remove ptes.

Should there be some ASSERT after the vunmap to make sure that is the
case? 
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/dma/remap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index 905c3fa005f1..b4526668072e 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -66,6 +66,5 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
>  		return;
>  	}
>  
> -	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
>  	vunmap(cpu_addr);
>  }
> -- 
> 2.23.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
