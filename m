Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58A730FF62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBDVeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:34:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51660 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBDVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:33:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114LTJrl049008;
        Thu, 4 Feb 2021 21:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3IpY+B5dHb45Pe53mCLCLmuVsd1crQMGPACBIbBVhqw=;
 b=bxNOGTseRSMZTrryyfUQmkF7TuNSEP2tj0gPmWJcg87mfCndhJ0Cc010QE8QD4rAxRYc
 13iSeh7syKgHibuN1Qa/faIRKl1KSp/YicGDTke8ALtDj6/IfBXJAvuG6rruMag+pRsO
 P8WwBg39x2kvThuGOIy8+E2cR5iVcScVC0VdVGvATwxCZ7c8i4cprQVwcFMa2m+uUisn
 qCP59I+t6nxBIwFY8ZOcPMf+3JFiESFz8a46P7eSfJiXq5oo13Mpsy7mnqPxIiyXqPvy
 XXAbAajTtYN683n/fiBLCnieuLlSNE6Y2Myppgnvj3U7sbwkgEJOS5Lj5gnHOKrJovTr 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydm790g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 21:33:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114LPcEP137741;
        Thu, 4 Feb 2021 21:33:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 36dh1t1fdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 21:33:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGEYnpoA2Z6N2Ux/6+pcFPomgU0l7le05FNzhFFzCS5APTGnvJ1qai+V49F2gJJXpunWWTZ3J5FunaI7pu4UgamSw3MC44uT5XQQfA8Lsl3fpziuFhmNN1+cJ9pFJQVp2AIpJRLtn+GFTFuW5nLw6Oez0a39Uv+oHtGwRVcIYzrH45ZuP+92tMdHAUlul+LHrww9F3dYOF9+L4nIWWTHyJOFni2Qv2AuMXs63pGHdrp+ISkr/hrRyVRytdRJOxcOFqwVcCrqjZn1WBHfJmLN0YwfL0F3bBSggOibEr9cHees26/AjGJC7DS5AUH2/F/u/614SRS21djbA8Q95PCqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IpY+B5dHb45Pe53mCLCLmuVsd1crQMGPACBIbBVhqw=;
 b=CvhC/mYPpHwVnlAGHQM0VqhtGPnWYP8I/vBcVOHW1wJk/36pirUryIgBs3MJuODydNIvwTQdtiF0DJh9/TXqZ2gWCrmKv/uN3Z2yDlLnD+tslLOHaGJn3VKTtML6tRjmJ9d5wAaPumfp1qGYLRptUeUTm50LW8TGlVNYuK8mSHqZkUVBWoSBXokzLe9zm+z++b6rigRynuGbALNojYUVTSKZiJ+5FdVarhkydUpN6nIWtMRhUXB+ShTreTimxhhxxU5ij91OxbHlSBv2i7x9WLw54z3NFBVs6MrBE5QSy0CNQEac0H90J1/8RLNGvQFFImOe+W2R13Pv21yI0I3ckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IpY+B5dHb45Pe53mCLCLmuVsd1crQMGPACBIbBVhqw=;
 b=DulbrAeJoMfnUXXD07odMJR5ahlWv7FBfiXJODuVfYLasy3Vjkke/uW2e0L2Yd8+aGLL82rGCUnZP16Zyy1f+MVBBS+yFXi4yXDSUvvt78ZdS4NRdkLFOOIIkiyg7ixa8c4WKHsUvNsV1E54y8I2nPSDJKl9umbZ4GmCrwb7eCg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2109.namprd10.prod.outlook.com (2603:10b6:301:2b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 4 Feb
 2021 21:32:55 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Thu, 4 Feb 2021
 21:32:55 +0000
Subject: Re: [PATCH] mm/hugetlb: Remove obsolete comment in vma_has_reserves()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210204111500.24111-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8f2f3bac-5b33-a560-9b84-b50972739636@oracle.com>
Date:   Thu, 4 Feb 2021 13:32:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210204111500.24111-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:300:117::25) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR03CA0015.namprd03.prod.outlook.com (2603:10b6:300:117::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 4 Feb 2021 21:32:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5e220af-cb58-47e1-5c58-08d8c9546f10
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2109:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21091704446B8E173B7D7995E2B39@MWHPR1001MB2109.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Mc48jOOPSh3tI5TFE0oTcPrXB2O7ntEzBfEUEDlLwssUFA5h2n760lDV9b3aAjUhezc2YedzzdMZ3jjRMlYfWbGyCM2zeXJI/i4xx6O1416Fz5LxBvXcCzoBpsgNZgoLze4w76gneSQ+oufebYjJjOI7REroWkF1JoxZ60e45G3cHXxHlC4xPIN9OqJlYWMHNYbaZ/qyHScxALA0eK2nX3F9PF2JxZuDZTjUcjIMYTmBY/FuvOo+u78zhlRN5R3QDW7tdI8WzYYqSovKVZFaz/O0EkWeK+YY+WLUraO81DaeE+UzUa09Vc8dZSK9AQl6gISPOhO/fOVGScAKPm61OZ4mqoIPxfeQI/1kMRLUdoJKOEzpcqJJBKaifZn9g5pC4QC0qCf3EDOhae7hFnzus4Cm6Z0UQuq4cecTqfhPwVmtmAerARSiqtQOVAAl/EoEU7U469ziHHmeIN9Zd6c6RYp90lwiJDh2uqAqngeIhFpzTjV1tpHi1YpQvH9FCg/cAEkiPsuDMQbR/rrfIhsqrFJ1DcHSwyjkRKs7cENAHnB94Q5++4L2YEc1WmE3J2p3YVW8pCo+/0QSVegHt6VB4VWLVjVBf+Tn3YOZBPemdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(66556008)(8936002)(44832011)(2616005)(66946007)(186003)(16526019)(26005)(83380400001)(316002)(31696002)(478600001)(5660300002)(16576012)(2906002)(4326008)(53546011)(956004)(31686004)(36756003)(86362001)(52116002)(66476007)(6486002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dm50TzcyRlRLcHd2YnJ2THc1NUhjWXR5bEY2Z0VXTGgzWGFRLy9QZDNtVEk2?=
 =?utf-8?B?WFliTTVYTlZtREd6K2poY29ZN0ZrMEMrN0Yvc0F6VzZNL1RSZXg3czZRUWRk?=
 =?utf-8?B?MlJaSnlBbkwxSlIrRWZUUTlOWFVBbkZLRlRycHZaNTJSNHp6d0VkNFpHT205?=
 =?utf-8?B?WFpFZWFGVG9UTng1bEthZGtGa2pnUXpqd3FjU0QxQjZIdEhiYndRQ3VHOVZr?=
 =?utf-8?B?ektjN3F0Q2JMbHFsY29CRy9MR1VUVzYyZGM4ekxEWnZVNVlTdENrVUhEc0hM?=
 =?utf-8?B?ODZHb1V4aFQ5c001aTdmYk5PYzk1NDZVWTdwT3MyNjFvbHQxSEtmcUp4Q1hO?=
 =?utf-8?B?UHNseHdUUTNiejU1RkVNOHdpZkpQdk9xS1JLTm9kTTlyQVZ3MVFRQnVxenJn?=
 =?utf-8?B?VElUSk11VGY4MzNRUWtMRXlMckRsa0czSXp1ZENiclhFamtMYW9UVW5HN0ZG?=
 =?utf-8?B?V0ZWZm5tYXR5TTFPNkVSSENlZ3NhTmRwcHhiSnhOenZSdnRINTNBeDgrMk1D?=
 =?utf-8?B?Y25ScDRxVHBzQUErRXAvZXdhZXp1cTBDdHNWakZNd1l5NGxnRnM4VDlwSUtD?=
 =?utf-8?B?aDZXSUdYcng0QXdDVUN1bW90Rk4zUGdYdUNrS1BxTElMOHNFcnBWOXdOYzFR?=
 =?utf-8?B?dGlKVjBoYlg4TTlYcGM2ZCs2Vlc3RzZ4NHhpY1B3aENkQmhZcUw2Z29PbWpt?=
 =?utf-8?B?RFhOazBPRDZsczhhVVRaTzZYYzNOVDZSZzZ0enVnaEJjcE8vVEV5OWU3R0o5?=
 =?utf-8?B?UmFVR1ZWZjFzK05QWjBLSXRZWjI3MFpuS05iQldFYnlxMGNqZjZmMXVkT2Ju?=
 =?utf-8?B?eE96SVQ1emRJYTlEZWFSUWtoZS9BZGI0SFhwR25BNEh2TWdETFpETVp3R3Rk?=
 =?utf-8?B?T2dlQW1IZWJFTnE2Z3RPUStCM2pDZE12OVRIUmJ1MDRIelZQem1acmpjSmhV?=
 =?utf-8?B?UmxmWVlXa2trZlhZRHdpYWxjaHhDdnRCY05ORFVMS3lybkpsN2hqZzF1Y0NO?=
 =?utf-8?B?L1JhK0dsdjcvb3N2VHdDcnloRHdRL3o4MDFiZXEvSHpvSThOTkJWTkdtUUJy?=
 =?utf-8?B?NFVEb3BUTW96MXMrdnpqYUdmLzNFTk9vSHdaaEhiVmZITTlpMDlZR2x1ejUx?=
 =?utf-8?B?K2IydUdRVXFZVUJXa3RsOFY1cHB1RXNEQUxsY1JLeC9wQUt0bURFZ3kyQWY5?=
 =?utf-8?B?Vi9tWTd4YU53V1FyeFN5aU1YZ2JURzlvM2FVdGwrNFFJbEN1TXZzdVNFNzl1?=
 =?utf-8?B?TTVMKy9UbEk1ZUprckdIR1h1dDArSm9xMFU1WUNyaFpaWlh4Uy9WNjdjR3lJ?=
 =?utf-8?B?eGtKRHZaY3RUSEJ4Smk1VDc4Yk1ZNUJFQXBENVpLb1Z6MWtscVBTRWR3Wm9Y?=
 =?utf-8?B?dm5qZzBOQ1YwK240Qms0R0s5S0lEQ05zSzBTaGtONEVPNUc5YnR4NHcwRTVx?=
 =?utf-8?B?QXZYT1RXOEtKRjc0dkdmTWtWUFBXcnp6S3oxZjFyak44ZlU0dUg0YVBVMUl6?=
 =?utf-8?B?NmZuUTVQUkVHQ2N1UkxTbjlQYmZsakhXVitTT3p3a3Y0anE5elF1RGRxeDN3?=
 =?utf-8?B?Ynk3R2tvdi83dFY0dzJ3MzV4QXpTNFFvQ25wVzk1dHRmRmwyZmVabHBLSHVr?=
 =?utf-8?B?MG5aTzJHdnpDTzljNHdrYjlZTzdkNkxPeWxJZ3VTSEtoTzFDeGtYdWU2NlZX?=
 =?utf-8?B?bFc4OVpxUHczVWwxN3h3NmFwYzRJU2xLYll6WUpxNGMxYlpMWUtacnIxald2?=
 =?utf-8?Q?o6MMWPu/HZFnogIZeLs/ReLUama5WKT2fVNluAK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e220af-cb58-47e1-5c58-08d8c9546f10
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 21:32:55.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjT+66HQQTH/a7ZTZ2cSU+rAsOnIKVcyAUZ5FWQjmQaq5K+WhVyJ0TxhMLEGvzm08FaZD4dD/qrGkkC0Hq4PYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040132
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 3:15 AM, Miaohe Lin wrote:
> Shared mappings are allowed to be created without reservations since
> commit c37f9fb11c97 ("hugetlb: allow huge page mappings to be created
> without reservations"). Remove this obsolete comment which may cause
> confusing.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9501ec6ad517..cf82629319ed 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -998,7 +998,6 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  			return false;
>  	}
>  
> -	/* Shared mappings always use reserves */

I would not say the comment is entirely obsolete or does not apply here.

As mentioned in the commit message, commit c37f9fb11c97 allowed hugetlb
mappings to be created without reserves.  It does this by supporting the
MAP_NORESERVE flag which corresponds to the VM_NORESERVE vma flag.

Right before this comment, a check is made for VM_NORESERVE and the
routine will return.  Therefore, by the time we get to this comment
we know MAP_NORESERVE does not apply and there are reserves associated
the shared mapping.  In this case the comment is making a distinction
between shared mappings which will always have reserves, and private
mappings which may or may not have reserves depending on ownership.

I would suggest either leaving the comment as is, or modifying to include
the information above.  To me, the three distinct blocks of code handling
the NORESERVE, shared and private cases makes things fairly clear and
the comment does apply in that context.
-- 
Mike Kravetz

>  	if (vma->vm_flags & VM_MAYSHARE) {
>  		/*
>  		 * We know VM_NORESERVE is not set.  Therefore, there SHOULD
> 
