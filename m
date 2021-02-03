Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529DF30E6CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhBCXFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:05:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45724 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbhBCXEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:04:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113MwxMk068344;
        Wed, 3 Feb 2021 23:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lJvAUElyMygyvOVB6EAj4J3sVnHxFFqRxHMdKGwsW9s=;
 b=aM386A2IgIYYXjJksG5Qr94AahMvXE0K3sr4bgEEhwRNC+TbuVjRzQX0c749nh9jZndB
 7OVtTxr8a9msHtjEG6kZd0qoqcsNcbPjRJrs6bmqAwnVvStTvh0Wg3Elewte30Qr+2iR
 smwHQ8yXBMm+RFHA+l4VdMlMPqWqZRwozg99e/l6mxukJqHrqf2sZgoMDXmnjaGpKL8m
 4ewrfDdKCyYMgZEjQTdoHWtRU6msnU0oyLOY+oew8tIvyLiVE+g2NYF2sVHlX5LFL+aq
 Az9/SW6JMuu3aX7vG5gflneaQY9QmzS+rulr5gjX95y/b7xKEBCsD+YRXjr0s2vVehnD pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydm2m9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 23:03:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113N0JLD194299;
        Wed, 3 Feb 2021 23:01:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3020.oracle.com with ESMTP id 36dh7u9pg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 23:01:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRF7jo/poo4w5mPN0qRar7jOezwO+rw5Ff9WGYYUtz52PUH7kb2JW0n2De4G/CGF4D6rUtPUWZOQ+PKoIGpfS/cqH1Rg6y5n01i/oeb0lfwO9cAGpzn4BQkrzjs+FIjdKgi7gzHilT5/aEo55gvP1Z0rMGL5/RxG8GI7CKy3fFeSMT3YzSEtcLk7bYB1MM4B61yDgCPcdsF7fvL84Kazi8CZzUB5GJuwQmHWd2/uOvABzd2Lk41eypIAVMUVxXFWt5TN+QBT/Ae0aeJqbgDFPn4kbvMwvw1x2OzLPmbPop0yKrEEyrY8BRW0f+J1/L1O2zYY8auvXSdjO+KLIa6prw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJvAUElyMygyvOVB6EAj4J3sVnHxFFqRxHMdKGwsW9s=;
 b=Ksk8b9LVt/McLPJUEimg4s/US+Rs3QjcVMgiARnJabYNm4sC7QtM5Ogy1iVzOGy2NnFtB4NQtopMZGj3vqN8KxKgJie3mRXOpjHA+uq3Wb0jw5dZrTqHwmUWUT9or4LMUbmOUGUG5MTuaoIkwHKDGr63QZ0oKCHeg/2vwOc8zYZrGuSk/e0DTsTtzA5S/hKgHCDyesGZZCUuCQ1I5VfzGXrRrGeeuHk1QFN6IoCSNWREswD2fixM8EpkhA47VilBUQ7zb7nJGQINwmGFGixX2Hup130+uWcYdva/r7ae1sUH787I7Yr4ZJosTZ4yYWdpDK+7roQi2FA6GOvNj23qKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJvAUElyMygyvOVB6EAj4J3sVnHxFFqRxHMdKGwsW9s=;
 b=GehCplD+Kb/C/2mVuV5K9H8rulc0HnznyrAEbHttP89ydatyF5rLCFiIvFi3TbkXaBS1iHSD9Qdfx4O9ijBnjmQ9BHqVuYULvk+6YuQbHT+xw5xmpkodlcKtj2/jdHo/0DrT9bgNvpAXvrS8z1lxXhTBHKH4FTfeREhPtcBPALI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 3 Feb
 2021 23:01:27 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Wed, 3 Feb 2021
 23:01:27 +0000
Subject: Re: [PATCH 1/4] hugetlb: Dedup the code to add a new file_region
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
 <20210203210832.113685-2-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8f738381-5867-cb74-4d8f-11667bfc9e38@oracle.com>
Date:   Wed, 3 Feb 2021 15:01:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210203210832.113685-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:300:115::23) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0037.namprd11.prod.outlook.com (2603:10b6:300:115::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 23:01:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c22620c7-edb8-4e0a-1f2d-08d8c897a2c4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4514:
X-Microsoft-Antispam-PRVS: <CO1PR10MB451422807DF345B2B3BAF826E2B49@CO1PR10MB4514.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcXHcvwGwU2iwNrOVG6mOWWqnBwlrNAYhh2EAkuGE12dFruHwg/f8HMQtxyJ7/bt2rWGYkkGJg3GqcdeS/Bth8gzYaOpsE2iSrgLiwojOshR4FQUPefV6MmpqeJTS8QrSThFmqEcqrnJCs0TtYUQqEdbD4IjQkRRILeEQH2mB7t6/UFFwnNkYdn22vz5onk2Or1rZCWVb8LqP2MjwqEvvahcJvFbm7eDMWeo+6QcHhuFs44xPGSj8poXq7FtM9ySWZ3Ix63koucsP+S/kFRo3UiOMjVybxrqhfdS7Djbc+z0sjGTd3N9K1GdbPbXJuMyJ5RWz4C6acyBN4+LUHsRh/iyNoC0Z1T1JGkbZXpX0737nxqUkwrtm2mxtlnuZIKjMm2X9fCM7phaNYYxRGNTuVPO1SxwI2o839oLWszsnKWhpCgLGIe22FNEqv9x+MNhsqkjMFg3psKPIn+jG8fT5TOKUtPRYOJS/ekbDwgxVyJ1k4b5fMYAOkbqwR/DnewSwZ95sPw4Zq8dRgINYSxNePWEQhKVAEo8aqdg6D27VLssW3uR7sttBvAVepGOxrOn91v7siDOYf6e6yIX2nGgRWZK5ueKczmsbLkxGtMiIPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(16526019)(186003)(2616005)(956004)(8676002)(86362001)(7416002)(6486002)(44832011)(2906002)(31696002)(31686004)(83380400001)(26005)(36756003)(8936002)(53546011)(478600001)(316002)(16576012)(4744005)(54906003)(52116002)(66556008)(66946007)(66476007)(4326008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDQ2SVRScGI5S1M1T3hMeXhsYkpLMjFob21KNVZHN0ptQThVM2NhTUlVWUxK?=
 =?utf-8?B?dVJpV0M5Ykx6bUszNUxDZGNKTTZTN0lWZmdmNWtDN29KTmdwbTRiODNqM3ht?=
 =?utf-8?B?bWcwRFo0R0RtUEkxTXNMS0k5M0dxNDRFNDM3b2lGZ3JyeDIwTmI4Nm55QitO?=
 =?utf-8?B?cURLdmt0UThGd2NoaFBQcm10ajI5WTZJYzRJclhydEZ1eWpQTXNSZDZ6VXlo?=
 =?utf-8?B?VXFObnJxWlFDLzZUMHF0ODl6VnhBNUdicXFxQm9HRURaZy9lcmZ6dDVjZGpv?=
 =?utf-8?B?V0xaRy9BNmFnZEliQUY0ZVZKM1BtZVZnWjFZVHV4ODg2U2QrelNCK1U5OVhJ?=
 =?utf-8?B?cjI4RzM2UXFXVVZabGE2L1laYTBSSWxyUGNpdDRld3pscTFsQnJEbU5uRlRx?=
 =?utf-8?B?dEVQV0xmTytCVXJYYi9CTlBBdXFuQTNNZ1hhcnBtWHdMaTZ0NXJ2UjRTRlc3?=
 =?utf-8?B?V3ZOSEhnejJXRWtKSUw5aXlpUGxNMy9YcDdjc1ZWbDRZOVpoajQzVUVFRmE5?=
 =?utf-8?B?K1dodXZ2eVl5WklNWDRZSVdLeWhSU0pwT05NT3UxWHRDbEkvcGN6c1ZNK09p?=
 =?utf-8?B?dUF5R1pDZ1F3ak1jd05jRW1qRFIrV0RkY3VXUlowWkZueXZsci9pWUhjUjNP?=
 =?utf-8?B?VUFBVEgrb1cxTXFlNnZqKzhRL0xnTWFHanF4MC9uS3g1dnRydG8vSDBKYmdR?=
 =?utf-8?B?aFNyb0x4SlVoUDRuVWE0RzJnOVJ4aWQzUHcxVmdOS3E4YjNpRTFHZUt0M1hp?=
 =?utf-8?B?YkJEVHR3T29ESFRlayttVHRqbHpaOEdtMUhpYVl6YXRDdnJxa21iNGVIdzVF?=
 =?utf-8?B?TmxzTkNLNmZSN2h6R2ZkUlZtUGtjbXBvM01Hdml4YUNkMkw4ZmpjaC9lQVFp?=
 =?utf-8?B?U0Ryc2tCMjB1OFI0TnY2SnB6MjJoOFVPbGV4Snk5NlBUN1J4YXk2dWoxNlM3?=
 =?utf-8?B?S294OUN2VkRvekhIZnhoeEY4MmtMZjgvR1pEK0RXUGZEZG5iNDhnb1I0MzAz?=
 =?utf-8?B?cTByem5FM0JZKzdma3lJT3o5aDQ3bDlyM0hMaXYyWUdmbnN6SEtKdFAvVFBx?=
 =?utf-8?B?ZVhmR09aVUErQi8yZXk5QjhEK2F2YWNhbEg1ZHlpbjNGTTFnUDIyYUlvd0hi?=
 =?utf-8?B?WTg2QXYzQVcrQW12MjVTeGhQNlEyZTE0ejhZTDBHaytPMko0c09NUzhNK0lr?=
 =?utf-8?B?NlY0MjNENER3MllIUjBVMWFnc05XenI1WXZwSFh2b0szNTI4WURSUzd3TzFW?=
 =?utf-8?B?V2pzSHlvSDhkUng5SVUvdSs5cXl5Tms4ZDFwcU1zS040QVBlTHExcU9KTm1D?=
 =?utf-8?B?M3Uyc2k0ZjVNZ1BSbk1ZbENBZ3ZRODB2MWNMRFo2a29sZFU0K1hNM1lUaE1m?=
 =?utf-8?B?VlNERm1JR3QxOWN6MVZUYWhPSFJzSnUrcTBZNDJ5eDFZKzFQU2J0SmhJcjVF?=
 =?utf-8?B?eVFGMm9XeU42d0pRK3ZROFlJVUxMSnJqWFhzcUhkSWViVnFwL1MvWFFZZUJH?=
 =?utf-8?B?K243NUl0Z09LdEhHci9iVFRTOEVUamc0QzQ5emsxVndLYU8rRzZOMnRVa2xE?=
 =?utf-8?B?d0RwV0ZZUWFNUG5naWpFNDlJMW4zTWR5cjB1ZDc0czArVjZwd3JEeEcxdzAv?=
 =?utf-8?B?UitNWTRBMTZtd1lSc3lhd3FvQ0xhMk1KcDZ6WGVXNDMvWlM4Wmkwck84LzhI?=
 =?utf-8?B?b2hxQ0Q2U1lRcXU3T3ppR21zbGJOOTJQU2dTUW5CWmFhb0RXeFBEVGdaZVEr?=
 =?utf-8?Q?ztulqlfeVrw9zWNRVM9s+piLREvSU64itf9txqT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22620c7-edb8-4e0a-1f2d-08d8c897a2c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 23:01:27.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXYcqnaVLTOdhcAwHX90QMAcFWkyrmGXN3moLA4XyXmvI18SuPo8OCDca+B0Pxj4P4y33rx58AE2uBWsuy0Zag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030142
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 1:08 PM, Peter Xu wrote:
> Introduce hugetlb_resv_map_add() helper to add a new file_region rather than
> duplication the similar code twice in add_reservation_in_range().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 51 +++++++++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18f6ee317900..d2859c2aecc9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c

Thanks, that is a pretty straight forward change.  A cleanup with no
functional change.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
