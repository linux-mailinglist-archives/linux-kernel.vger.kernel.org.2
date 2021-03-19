Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68560341478
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhCSFBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:01:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhCSFBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:01:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J506Qi003977;
        Fri, 19 Mar 2021 05:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=9Qif7I7cvK2OqtuvsyUlhVCaLk6cbRUmtYNgMn1FBek=;
 b=E7kQcNQrCCmCz74xfFsiMzcHBPYJsow5swItYY5UWlfVunVpqnIfC6UNWRmrtOfMDFPd
 hkQ63W0DAMTGoFdq2BB0ZkzvJ2tBhf0AcLfIPFtBPsqqQXtfljR63vU67M2itvJXhszL
 meDxt27fOywnasAvHudIYAuk2pNZ0m2TNduaAsaViMqoKwHDB1MNkRFQbNw3PAVAASDu
 rBlY2Yyg7nGZo0QxdrcnJ77taVgw8vY5Tn7NHm2hfaRTafBVxGkuaVlEtTmfB1cjDtBj
 sR5qWaLpim1tUAaduDsLFTMIa6M7FNvjqUSwpETyxWgUZgtDuEBc9Y2bJT2ghJ5gIp/O 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 378nbmhma4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 05:01:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J501OI028603;
        Fri, 19 Mar 2021 05:01:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by aserp3020.oracle.com with ESMTP id 37cf2v1xwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 05:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCF9qt5TlLwwgAJQnSw4DbBmHW+TmG3uGMg4alssqXYAu1zeHFmqnEggfJ3m/LcT3prHL+Ul9awnxl51pyzYobuRg88yaCn7mpj1cKbV/KyZXB24blIUo8e9OUeWAn/uOnesKy3jhanQMelOv3HLjnxRDULGVZmjH+6P+zy+CgyQGl4wTKPTXuoBnc6h2W+mRR7u5g8q8Z/dFA/+YfOh+h0JUh8aZaQBn+EAZjQGCae7CKZqc0GMLpASeH5KiaaRBH5BE+lCY1Lr/Vrub1ZYsf5IIz7Ue0fIE515NzIMOIlJRXdsIARnFi7RPX8A/kiDq+PGfAxnBLCqlQ31gNXTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qif7I7cvK2OqtuvsyUlhVCaLk6cbRUmtYNgMn1FBek=;
 b=CPbhQxOC1CfBQjtw2BXfqOX2AIEUPcpukJkiD9JuG/q+27Pmy9idICiW2g77Ge7uqdTs8zklWNmK1+WhJUDtFa2DF9Xxcq8dSw9oBR8VPTJnrMnYeACl5/3T9p7kaLwN20VW2S0NGf92NjNjqvd/aeuTTNgGUJo9PssdCXQNyYLLWFuIXbI8JNvpDHFXj/QaACGV3f0O3rH7onn+TRjUH1iiPFpvLZeCEO5Fbpl6UgbRRwycwujXF88e45NdKQrkG6bV0NN7bopoHbPXdtapIi7T5EbCTSNtE3o+iD6/0Ka80ZhoxIChExCNbSZD6BBIIynjIHgMZ5SxIO2xEZsLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qif7I7cvK2OqtuvsyUlhVCaLk6cbRUmtYNgMn1FBek=;
 b=DCWpaSW5bWEgR8QqEz2l1psfhrnd14hNzqUfMrsJNdfGFz2azUl9NX6CoIJVFMBmyVY+jL2jHs+RPH5x7BJtVjtxiUXnaqQQDZWgk0EenDMLncNTDzdjz8562jKAQmiDIor7mzjwhI+HUOm+wlSR/PEneV7Ynn4ncQRtI3eVbvs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 19 Mar
 2021 05:01:18 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 05:01:18 +0000
Date:   Fri, 19 Mar 2021 01:01:11 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, opendmb@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Message-ID: <YFQwFwZbVJoG0DpZ@Konrads-MacBook-Pro.local>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <20210319040055.183433-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319040055.183433-1-f.fainelli@gmail.com>
X-Originating-IP: [138.3.200.45]
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.45) by MWHPR1701CA0012.namprd17.prod.outlook.com (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 05:01:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 465e4465-96e7-4d03-dca8-08d8ea9407a9
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4703:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47037C736B4BA59B1B0D359789689@SJ0PR10MB4703.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sVu0JZEDjrm1VN5rzX2JX2+Cp7vMMcUoSUUluULnXmtHn1ysHm9a0G/OYpgtPW1XGY+nWXCyJ8HMRfpwgKgDWQG0NtS5SE3iHnUHeQS+SjoYD6cK4ItyEH9yGJmkAQEu0pd6hZijyNMJTob89zoDK26b4pAsK+tvuzEJ29ZwCXe74S82o8trCAIepw/G9z/dqxef22RUx+awEE5R3P5Be0FppJEAUMuAqBRSLwboPuZA57NHTQurpniDa0+m4X96x4oIiCWxT3AJPeORYQdkvppqcm50l1Brdt+aXxwFupArPNbj7FqghacXfj0YMHZ8Yhc7OoDfHhmy/g7+ljuyUfIHgc0OwnrV1OUAtvKSRGTSrPpeI034g+p/E0bm9eFi1rL9RgwqsASihGkXgRt2CdFweBKN2phzFUJXXbg3On+zeiYsy4G0NBZbV+Lpm2outhwyhNaq52dpkWlYs3y/MR+gZtuorYHdA7mzq+1lSYh13h6oSGVieVc2+jyYtD0eotGoAz6PLPjGpFp1BaBDydM54C9TMWuimVyMOy3J4QnoRkjMMmJTI9dtOsubGKhMHiGtV+gEL3QN6PJIYu2GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(39860400002)(346002)(7696005)(6506007)(86362001)(66556008)(52116002)(8936002)(16526019)(186003)(2906002)(6666004)(6916009)(38100700001)(26005)(66476007)(5660300002)(66946007)(316002)(4326008)(8676002)(478600001)(9686003)(55016002)(83380400001)(54906003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PDLdQYvMSwvvjGjkLIyr4gVNcZWpaMt4GUnSICaAJp9pwrR6DiEGuPitFC5I?=
 =?us-ascii?Q?GsSYQh4yFKlOdgoJrDyo+MRgeZykUxIhl9WCLtiat8AXZda5//cyKnNNWypk?=
 =?us-ascii?Q?c1CxZXjna/K5f+bLkbgnheIPBKWpr409Q51YrIuhyUOM3mT67EZlMUxygEAf?=
 =?us-ascii?Q?AMMN0s0oaFsv8nF7cjHQ8rI8OSd3Swfh9w+QWvIoBVex4qT57+Bc7MF16LLi?=
 =?us-ascii?Q?qFNsMZnrzGbMfDl6XrUb//PWL5sUNB/I9vxlggtpgo6Pe0u9xroAkSLRtHIV?=
 =?us-ascii?Q?e9Flq8icayjzxqudIXPiOaOT5/pVUrHKrRUsWBDr/gk2Db2ZpLPvB0dtCZF7?=
 =?us-ascii?Q?GnT23z9s21e6yTNMeIgTxab8MShmnScr4tdbNLsiUp31BdhzRDtcwCfigQdj?=
 =?us-ascii?Q?45rCdprKSp4nr8Is+BtHZIMNd/FckGoDHrj4pC01bfn91BOIx7l+Lc6ckdBV?=
 =?us-ascii?Q?9n6+yVMxYlk43BI82jDJOj82je45LjPC/KBxp02QJZo42ZIJ9eUdatol85fH?=
 =?us-ascii?Q?ZVGm/x//3V5hoTqQG3MlxQRMmvuFmeQBwKVHyNfMEaHqO40UGpuYIVs6tDEe?=
 =?us-ascii?Q?595ImeyBrQejo+iNoFn42Jm8/5HxFBOeCp/J9vE+uNfNXxLu3RNbppkzIyaH?=
 =?us-ascii?Q?msNzgsndeku1PVgERhhT043FYmhzTNY+LpIZrIlrHu8fUMmFmiJJyZihhB6k?=
 =?us-ascii?Q?O/noFBWfNRoOpr4rIqMSluzNJ4hlpshaK2AxcshZLQLoQsF85bfwmoRtNY77?=
 =?us-ascii?Q?OJLQEfSX8l4zgD5xTEv30Q2oldZVCUymb1dzHvkOobQ5l1WebdFnfLEPYg6y?=
 =?us-ascii?Q?iBvDq9Za0UI+sl2dl8oB3ZKEUe0lcF2NhEs8Iw7CFUUwswvLkhqG8tPCTOKn?=
 =?us-ascii?Q?igqwCCC1KT9zzNiiVE6P+wB/8UtSK3qHFBwCHivBrPvnh7TNrnk3LdLkXxpm?=
 =?us-ascii?Q?khSJo8cIeV1UhO/ILixHqgrBHADRD4OxSMw46Kf7A6OnhPnX+X9aJoztvryx?=
 =?us-ascii?Q?5WdnfQQp63AOBUBIf5yPFVmdWvMY3jKnD8BLm17/3jCf0xTDlhSYMf5369hQ?=
 =?us-ascii?Q?Lra5+l/jC4X5rxJ5ggeY5wDkomy0bZB8Qy4G7i/ZDFrCUMeY55aid8O/qoOD?=
 =?us-ascii?Q?LMkISgEHK8WBB5ypfhFa/FNU7MUG/QUflhsYR454WEgqCQf8F6/ltkWrqa2+?=
 =?us-ascii?Q?GItK2jZx6DL/zd/nwLGsjRJYqORGTaSt7S6bJQQtLJjXtnYY0b2+6w7IVWbo?=
 =?us-ascii?Q?F++GKUun/GQYXmq8u7By9PE3u/N1WIBYksaL/iPe7X+/DzcY54ApD4YGOuba?=
 =?us-ascii?Q?Cax7fMjU8mzg1F8VED4JuKG0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465e4465-96e7-4d03-dca8-08d8ea9407a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 05:01:18.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdGVhpC/XSHbqkSnELhsPuJSsfNxgFgvZKAGdWVlJSVCugPIXYyoO2jCmx3xo2UTuXv82W9gf6S0fUm+XHE6DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190035
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:00:54PM -0700, Florian Fainelli wrote:
> When SWIOTLB_NO_FORCE is used, there should really be no allocations of
> io_tlb_nslabs to occur since we are not going to use those slabs. If a
> platform was somehow setting swiotlb_no_force and a later call to
> swiotlb_init() was to be made we would still be proceeding with
> allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
> was set on the kernel command line we would have only allocated 2KB.
> 
> This would be inconsistent and the point of initializing io_tlb_nslabs
> to 1, was to avoid hitting the test for io_tlb_nslabs being 0/not
> initialized.

Could you rebase this on devel/for-linus-5.13 in

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git

please?
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  kernel/dma/swiotlb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c10e855a03bc..526c8321b76f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -121,12 +121,10 @@ setup_io_tlb_npages(char *str)
>  	}
>  	if (*str == ',')
>  		++str;
> -	if (!strcmp(str, "force")) {
> +	if (!strcmp(str, "force"))
>  		swiotlb_force = SWIOTLB_FORCE;
> -	} else if (!strcmp(str, "noforce")) {
> +	else if (!strcmp(str, "noforce"))
>  		swiotlb_force = SWIOTLB_NO_FORCE;
> -		io_tlb_nslabs = 1;
> -	}
>  
>  	return 0;
>  }
> @@ -284,6 +282,9 @@ swiotlb_init(int verbose)
>  	unsigned char *vstart;
>  	unsigned long bytes;
>  
> +	if (swiotlb_force == SWIOTLB_NO_FORCE)
> +		goto out;
> +
>  	if (!io_tlb_nslabs) {
>  		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
>  		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> @@ -302,6 +303,7 @@ swiotlb_init(int verbose)
>  		io_tlb_start = 0;
>  	}
>  	pr_warn("Cannot allocate buffer");
> +out:
>  	no_iotlb_memory = true;
>  }
>  
> -- 
> 2.25.1
> 
