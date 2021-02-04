Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E430E8E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhBDAs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:48:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45070 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhBDAse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:48:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1140i2g3044714;
        Thu, 4 Feb 2021 00:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tTcyMAPYYuhHQNcRrnPOKemNk22mPw/VrXILhCFGPaQ=;
 b=GHOHbZQmG1jPGgHZ+0JjtXmaCKElWu/uN8gxZoOyzHyhNVzOb2FcNtJ8IThO/9if3Cc0
 sESsgJ+3l60COvl0V5F5Kl+GgIjhOdgqE+ygPX4KBiyqCyCTdRt6NLHaL7v39/sy4Yfw
 bxGUsDWZ1K0Np8P2YSdxY9T9V2K4NznUXj91QW0L4oIEoUSk/k3Kx5yIqcXnJGd3T2v0
 wQvgZ0VHAEo3+maWVy1D2bGyUjP43mGESWdOPZgQJpCc20bM5lofJWo9gfp2BsrXatRx
 Byk2iAbsbfhN00IkyGJ0fl7hB+mv6ilurvxqaUpvoeToC8LoftiuY8gMfzV+4P8c2iEu 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyb32mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 00:47:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1140j2J3138020;
        Thu, 4 Feb 2021 00:45:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 36dhc1y91e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 00:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWxYevUjMpZSWtY8vXmrcuylSUp/E02x5X68pYOiaj4pCjsyhtKUqFsajw4cz5hCrlJM8jcEMzKr+6TflK9v6h2ZVLdsD5sEWj9gI/Amv1dYsyQode10QPTyWF+rkY+tDfWV4HYccsud7XgkPrYJMXjfRWEsqAIF6WFEqw6QE69vWmCK0vpCde7ZiuU/2z2JhK0R/a9MP0/IKiZn8BSv+N7e5u4Yf2h6OrzzJllH4k7TLu8ROKpYwAIobryu3PjY+fycR427+CWYbZsnwsU+jrAP+kGuPCAyopBQkch6s1tW9PrzaNxSP/JxSigB2JkLWzUPHWtCYB287t2TLJC1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTcyMAPYYuhHQNcRrnPOKemNk22mPw/VrXILhCFGPaQ=;
 b=CBh3Q9uHMgNopIGycLeN3TQFFhW6VZDrsomeaD43cW7OAyh98BBMUjyCvG7RMlFljEdgRG+BUGKWu66uqOy+hRl8ymNPZZ2vO6GWh7mTlfq4GMOR8uD9/ZH/RgtFg1a5rVT7F98ZGb3A9R/cVKbdiqOE9LHC+0284kf3vuyqkv15aKOl0WjC019va9Q/tFZP1koou286rQZPMd7RseO4XZeOtCC1xDffdHWTBuexs6Qbypzcxz0eupPO6PiDq4Vc1jbH3tuuhbjyc4ORi4G/oUCPdgjl2yfEHJJvcHE5cM6HHqV5FQ+/sRtSKYoh1HUlceLpw6aVR6psjJQkZq0NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTcyMAPYYuhHQNcRrnPOKemNk22mPw/VrXILhCFGPaQ=;
 b=DH46aqWx3KmUWPHV9muIBMnn4w7yGnVRMExL9PqNyU1bO6y+Wz0thLbV2nehAGT+w5bJmL2TpJ7Ipb3ZYKJGeX1ssxhszmja0SAchFUREEM2iHBVS88f2xpqwDuT79D3sObpobiZvkc7iDqe6QP60GZzivc6eugIBG9NSvNt/tk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2109.namprd10.prod.outlook.com (2603:10b6:301:2b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 4 Feb
 2021 00:45:05 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Thu, 4 Feb 2021
 00:45:05 +0000
Subject: Re: [PATCH 2/4] hugetlg: Break earlier in add_reservation_in_range()
 when we can
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210203210832.113685-1-peterx@redhat.com>
 <20210203210832.113685-3-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a90497d1-5bb0-ce30-437e-41d3ffa9e12e@oracle.com>
Date:   Wed, 3 Feb 2021 16:45:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210203210832.113685-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:104:6::31) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0105.namprd04.prod.outlook.com (2603:10b6:104:6::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 00:45:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa91d8a3-f9f5-4fae-ed8d-08d8c8a61d4e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2109:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21095E8A40C60E4BBB3DEE42E2B39@MWHPR1001MB2109.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aijZJNkwkxJ5l9RJczJWbtZUO3WiWPfFXSvum2VrUlkhzYmetVB4KHCGiaeuDUpmGSRY8cd/WVrlDPEtNbM3Ftxb60ChZFKDmgw+dTfsylS7Spcmk1DTos0LwZ09GHVPBhvG93pxf1sDg5VvErsW06WWzoTuYkFeYP4k/ZoOZZ2dpyzhOlCB3m+9WVmI1wIYg6rgmmT7FjgBqOiovsrcpxN77q0FL4T5FMR9SIsyMqW1appx+gtvKl4eeGAaleAPw+Lwth1WZ4YYUsNiQVQ+Xj+KdMPRuMJyY/9elUYyFYD/ACS5lMVgRV6y1zosmBP+ObIIWvYQ9JnZ9ZNtxxkfhumZLMVRUduhrZrfH3iy5pVc7SUapZkca471azrtLBq7qBky++iSFmLB+8awiGxDljVo+JfJMNBz6CUgEm3RUcoEo+2kCfRZ/PZvFW2xpD8kHZHA4WwOruY5Ia+Kg04SB0btD7IsjZIY8mcdKxk3V09+UKg6pPBjHC/f4V2c+6cESbMU5K+fdMrr5l8FYli2HcdcRCqQoep9Eg8jRajnrzBfJpYeS5ZsIMJiKmv5oKtA1cCxXmOQXDb+DOYVKL4WP8nfilMYwsGWxD1DaVdq//M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39840400004)(7416002)(16576012)(316002)(956004)(36756003)(6486002)(2906002)(5660300002)(478600001)(4326008)(31696002)(31686004)(16526019)(53546011)(54906003)(86362001)(8676002)(52116002)(8936002)(2616005)(66556008)(186003)(26005)(44832011)(83380400001)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZXNwQUNTRHdpL1l2bHhPeXlZVVBIS0FETTZLT0cyNVpucmJxQ1Q5ZktJV1RD?=
 =?utf-8?B?dzFZTTFEMXdBeG1UVUs2eVNxWHltU2lHblF5ak8rMUlzWEpYaGVaK1ZWMnJ3?=
 =?utf-8?B?OGV5ZUJnVi9veWJmQTdjYnZYcENoTElFYkxiTERIUVJxVWhWTVYvLzJpOTlp?=
 =?utf-8?B?MExjUVd6QkxFRWRCVG9RRHFtMnlFNDNwZGdNZ3JCQm9lZHorSFNJOXlkQ1Ra?=
 =?utf-8?B?SDZkR2NHOWtzVFViVmc4QmlxaDRRd29oRkZNTzhZWldHMmllUFJ4dkVYVnhm?=
 =?utf-8?B?K3pZR1JnaWQ2aGdKa2s0QlZ4UVA5SFJybGQvVVhGNUVPb2tNNUZ6YjVPYzBZ?=
 =?utf-8?B?TlZtNEgrU0hMd3RzcXYyN20wTHB3ZFBLVmU5QlpKaGVJYkYraXgxK3NlbHNs?=
 =?utf-8?B?WmdlNkQzNDlCYkpHaHZIL28rSkxRWUd0WlhPZlFtaE44eHI1azluWlVTS3Mz?=
 =?utf-8?B?ZUx2QnV0bmMzMlBSMTVRWFp3dzQvaXBKS2FTb2pkMCtjN2FyVE1QMnd1bXRZ?=
 =?utf-8?B?aStZWDFpR2lJSWFUdzFVMDhNUFYvMC9SZlJIVE1yRTZ5WmtMeklZeElwcUhI?=
 =?utf-8?B?MzZwWklYMVJCTTA1eVpXQ3lhOHJ6M1h5NGpvS01xS3Fuazh5UVN3dU8zcXNq?=
 =?utf-8?B?QUk5UjhBcXZsck9xL05qYnladFR4VFY5Q2JKNWdjNUh4OGJsMkl6NmJ3U2Q3?=
 =?utf-8?B?OURWYk82MW43RWUrMjEyVXJhdURvcU5USWU2V3ZPNG85SS9DeWp0MXJ0SFZt?=
 =?utf-8?B?azBnWXppcEFlOFViYmYxT1U0SG1LUWRIc2owVEZiR3V4UDc5OVRDUHUzYTNL?=
 =?utf-8?B?TkZBZ0svNG80ZThUcGdsbmZFNHR2cGt2UDFvSTNDazNwazRmTjJGTFlHajNu?=
 =?utf-8?B?bDZtOFJOQytUNnZBTzJYaGVaZDlpNFppQkwvUW1GTktmdzA3NEJrSFgvQnpa?=
 =?utf-8?B?Q2F1cmNZZWYzOGxxUVNqNHRHMUVzckVJNG9objMvYUY5c0N0UUhFV0c5Vlhq?=
 =?utf-8?B?MWVWMXp4S3owdHJNSTRhSkF5Tk5oQkw3Q1pMOEZEWXkwRGVCNzNpandHNE5R?=
 =?utf-8?B?VFlRMjNGNk9RMmVwelhHcFdNdkFKa3YxLzdFM1k1ajYxczNsdGQ0Y3plWERT?=
 =?utf-8?B?WUpvaDhQTEFrYU44RW1FZmU4eG0veUdaeG5CSjdrbHhUQVhXckJqWUVKTWtU?=
 =?utf-8?B?N2s5dGNxaXhjcUhVd1ZoS1BnekcrSzhWTmtqNXFtZUY4SU40RlNXVEpSR09t?=
 =?utf-8?B?eVlYdTBXRGUwSUJPcjI5TGdSTGJoNXBxRVFadWI4TnF4ODI2Ui9VVzRGcURI?=
 =?utf-8?B?MmZvRGZjd1NlME4wY0QzdjBJajhVMzBnWkZ4OUhQdUZacy90eHkrd3RncFU3?=
 =?utf-8?B?Q3ZiUFJ4SDRWWXBScW51dkFhS24wc0tsQW5LZW9yOWR2RUZ1dXJrdFFPMytN?=
 =?utf-8?B?a3ZIMHlLbEdmeXk4MGVkNzZOdjg5MEd2d2tJRmtrZzJWVk84d21FTi9ja2tr?=
 =?utf-8?B?QUNHZDEzWERQSEM3VXF1MktiMW15aGhPeXozSnpYYS9lU1liZVh4Q3pYcmZk?=
 =?utf-8?B?UDEwd0d1ZWQrOXJYNUd6dmE5bEo2TkxuUWNjUklXRWEwRkROUlEzUjNZRWto?=
 =?utf-8?B?aTZCd09XUmoweStaYk1FemlpTkxscmRnM3ZTZlBvVGs4UnA3b2ZBWS90V0Vw?=
 =?utf-8?B?ejdwTlNUd0xGa2tka2JtV3d0d0p6ZkVuWWtJSngyRnhXNE5aNlRiSnNaNG9X?=
 =?utf-8?Q?M7CbHo9wpfc0J1Nl6mn01uD3nkAofzirP8ciJu1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa91d8a3-f9f5-4fae-ed8d-08d8c8a61d4e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 00:45:05.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czhgaeMTLQIWFIjEY1KJ1/pH5dWI0DCvO3mpj8z15xlPzJSyyz81dKwYCBK+Z9/yfCeEd5Yvp+OUWEZj8rfeGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040001
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 1:08 PM, Peter Xu wrote:
> All the regions maintained in hugetlb reserved map is inclusive on "from" but
> exclusive on "to".  We can break earlier even if rg->from==t because it already
> means no possible intersection.
> 
> This does not need a Fixes in all cases because when it happens (rg->from==t)
> we'll not break out of the loop while we should, however the next thing we'd do
> is still add the last file_region we'd need and quit the loop in the next
> round.  So this change is not a bugfix (since the old code should still run
> okay iiuc), but we'd better still touch it up to make it logically sane.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d2859c2aecc9..9e6ea96bf33b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -377,7 +377,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  		/* When we find a region that starts beyond our range, we've
>  		 * finished.
>  		 */
> -		if (rg->from > t)
> +		if (rg->from >= t)
>  			break;
>  
>  		/* Add an entry for last_accounted_offset -> rg->from, and
> 

Changing any of this code makes me nervous.  However, I agree with your
analysis.  The change makes the code match the comment WRT the [from, to)
nature of regions.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
