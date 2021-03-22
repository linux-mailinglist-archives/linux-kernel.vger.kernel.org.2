Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9365345082
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhCVUOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:14:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41278 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCVUNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:13:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MKDKRH144127;
        Mon, 22 Mar 2021 20:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DruSbRDvSI0EVI7CiTt+4S2UegBAXto7qXbZtvFJUlk=;
 b=pmEEyILALAL0u2SiE13fgES/bKP66PImaqFvQKPOHwhNYK1jhpzk8/dAIdL1kXIjT3Rb
 eXbHaZhCJ742lZHsiVb4STmkj767+1dsMlCNApAdkBstXOqkUrGSvcaEROZYpc9JW/yR
 SSQEAjzr5jyW7NfYwWrghnFtURNUs+Aw4m86RiPPI7KGZyp9I85KCcVFcYqxN1HickPx
 WihrRbqMFNNlZLGF1c5hsA9rIsrwazbfpeV3pQuWSajEe8wA2+zfBbJN7fA9b3R2Uom3
 C0YZYBJdvii84ibDGuRbbqY1K5gVOTSD7tLLkIevFdvNNtqjYWUu+7xFy+p0JpNpY6Xv nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37d90mcqrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 20:13:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MKB4Mc040071;
        Mon, 22 Mar 2021 20:13:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 37dtmnn3g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 20:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh1haGHkwvfNhkmQPrX0pakMehtU/YPBOS9eNz4wPxSuDUxmKVcq9IIRtDtI9nPg8ynUQTf9rgtB/RtRYaGS9NsrMjHO4OIaXpZ+MSCFt+QmUqq9EuslHdofA17CiKfMBo2LpVAnS2YKjq4e2Ny0Wk9GEjnRiPKYcaLaSYnVirvfc5twqHJoVKkEr8T9Z0vRsVBrWtW2Eu8c2kWrgRYX1+e9svLYQusqUFtNajNFPwLE3S7CN7zkclonzMvwJrLHvSOG+Snjr38oJ5da3hVn3yEiaaEcvRX0sNVmn7GmeUJxnySiluIDR6FmffJkjGasJi8UlsxA95hGs3pnrNQ2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DruSbRDvSI0EVI7CiTt+4S2UegBAXto7qXbZtvFJUlk=;
 b=PqgSX1bNY5Rs4Dt+SImMcbKoAWb5MhmfgAAco+9fvb+wo/GoxYBSCdNL/0gN+VIJyXcDpSiZCfHJdZQkh9wX/UoAyNd+RYoWuzDCo3p7kXX8ECnPHVV6iVFK2oW4oKtjExXEnqnXFh8cISkNuDcnj5EHLU5UqjdFMRAP7P9pgkFfhIdfUkhOQKDDknFyaire/eTseq7SDGbrSHkWO9DbZlA4AOgtOHbTJaux5nxzGNNMOqq88YBh7Jo8oWIBkWJeb0NkOXxzl0CLKTVpE5k3NjB11bL3DpGkAtSVeZ5bw3UfGGZiajjHFfNCqG9x7FN4xeYn93n1Ayox70m0c+2OvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DruSbRDvSI0EVI7CiTt+4S2UegBAXto7qXbZtvFJUlk=;
 b=BnjEmQal2mwa+VymRSOwkpirIhNkIuGw8mQXug1N/MALKROA4Vs0KrtbqaYrecorYbz9PZB0GdmAK8jPeb1LOH7JAwaUU8lE4EPAd8EJMu6DEyA2GFzxmb587WGLpmZegWQPqDI3ntXGmI7Zeh2cARlA2RvN+fK1F73bkERyaD8=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 20:13:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 20:13:17 +0000
Subject: Re: [PATCH] userfaultfd/hugetlbfs: Fix minor fault page leak
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210322175132.36659-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <816f4e98-6285-0a75-366a-c1025ab0c7f4@oracle.com>
Date:   Mon, 22 Mar 2021 13:13:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210322175132.36659-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0144.namprd04.prod.outlook.com (2603:10b6:303:84::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 20:13:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b99f294f-3f92-4275-e30c-08d8ed6eee48
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4736:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4736A0A6C8FF7FBC7B646A0EE2659@SJ0PR10MB4736.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3gJhrfC3tYxz7mNw+u0zDOYhSTrXNNe8YaORlu1nSnLpj5TW2IovLYpavobkeHPqMgc0Omd1C08fP3oA3EDFXem6ZutT1l7jlOhjX3oVZVpFIMWMW3lrWoNhZWNugZJ/G983b1eLI4pdjsSdEqKHwVOY85xxpkvkPcixo14R4xp0+x1gICcmHspdOKoJmCH4xYhMI7FNUSu77X92jiD+obkqTWqBNha0SB6BZjWHQ4mF9daonPLjr5P5GIItq0/C0pp8kTcxm9vFTDmbVi3jCswzwU9fbqCF5qCTg48xvIK5aJg+JunwJk6HFSie9WdJL76OTnukdhxDl1noWoxEZ2AbHrAVs7qcMAvKbrH17BGzN5Rch0ZqlV7EfJhGnsHoqFkXulgDpal1fhhgcOhImF8YHE+F1M7O5GjrhC0413IpbkVrRzbIm5r3WNPA86Dg7Ji6FHzlGZr6AbzM3/5S3wW/ryl/07Rdo0m7UapFB09qmhpmazlZ+va5A8sUnKqner7h0h/if0eYrJ+/deMKq5lvtZ0x+3cvUOxVhgD4R2b1ATEdfGeqXKOrQdsiuwmFwdql+hoGlXTbdSFFvd9WrRBtYan7U44jGAxBELKQMyWna/qSsPpAtUHMG+OCv1uZMJUBp8r9d4Z4LP1WmA8ZcB6xqbFl2eHJ5jFOLJITmdZWXUlxcN4iDuWYYyn9LEt9kPLFxVhXcm3VVssqUxvnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(2616005)(38100700001)(6486002)(4326008)(8676002)(2906002)(956004)(86362001)(83380400001)(31686004)(186003)(16526019)(31696002)(54906003)(16576012)(316002)(36756003)(26005)(8936002)(44832011)(478600001)(52116002)(66946007)(66556008)(66476007)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YTV4aHdBM2UxcEhRcHpEdEFIVW01UHg3THd2THU0dlB5b1BQRTBSVSt0bFEr?=
 =?utf-8?B?ZkZmczZRRDNKMmpFNDN1d2gzS2R0dGJmUGxWbzBDSEVkUDRpaDFvS3l6UnFS?=
 =?utf-8?B?aVFKbVE0d2VJTForckVJMCs3WGVPckNwWE9FQ0tGTjFPZVFRT0F0b3E3NVYv?=
 =?utf-8?B?eFNMcjdCb3owUFdzdWcwUUJjUnhtaWNhM2tGb1pJYWh2QXV4OGtBamY0Mlh1?=
 =?utf-8?B?SkszQXRjOUVPaW55QnNMRTVNUGhvaitpbWpIRmt0eWJXUjRmS2JiOEhyazhn?=
 =?utf-8?B?VHdxNnJDdDBZTHRoSFk2N09vOTd1RjNRaW1IdlpTblErQ2pPV2ZPczhaYUZY?=
 =?utf-8?B?Rzc1eTRWYWRrMkRqS0xlNGtiRVlkYlYyZU0zSUNhRTVQYzBENVlpRVhlbWc3?=
 =?utf-8?B?NTY2cTRaOGhHM0h5U0FuNE5rc3ZLZVBnMStSMW5xeUdKSHh0YU5qSU9RbURo?=
 =?utf-8?B?QjY4MUp3M3FNRHNHNXZtVGV3WlE4MDU3cGpVbzBsVXJTdnU4RVd5d3Vhamt6?=
 =?utf-8?B?Vzc2b1RocGdhNVFYZEx4ZGhZRFFYSnlMOHlnYWNhbDZDUFNBREFvSFNQOEo2?=
 =?utf-8?B?dDZTVDQrenN5OUVYQ2VTN2pyL3ZleENIS1h2THQwaVNHVUhsSTlLd3djQXZk?=
 =?utf-8?B?UXJIeGtPdXlWYXF4WHdQY3FpKzVpTXRvOWZRRnJkWCt6K1hBdE9sWUhkYlRD?=
 =?utf-8?B?WW5HY0ZEOU1GTUNNMGRNbkY5T1JaQlJ6VEVxTm9Ia1p1SXhub1U1THJHQ24v?=
 =?utf-8?B?cDdzSitIUEhvdVBXeVBTRWg2cisrZ04zWTFNdnRFUmJFTlVQMEFXWWlwNkFy?=
 =?utf-8?B?TFVBSk44cUJmaWtqem5OVkdqRkMrU1Ryc3BwNGZObHJpNG1NWll5STlZUFJX?=
 =?utf-8?B?OHdadDR6VlNldUxSdmo2SUcrQmM5cDYzdElLZEZoYkJ0MU1TVWM1WVFHMSsr?=
 =?utf-8?B?ZzI4czV1ZWF0dGFaa2xqVkh3WVNnc0J6YUd2cFhBcDhaeDBYcUZFZm1wZ1lG?=
 =?utf-8?B?dmJxL09vVHlIRmNKMjYrRk92YW5IbGxiT1dUcDVjQXhINXN0ZGxjMmhkc3lO?=
 =?utf-8?B?aFk1WG43QmtyOHdFYXVQZmhOalhUUnd0ZDZxVWlWUjY0bHJZQXFnVVlEUDRx?=
 =?utf-8?B?b2luMU96ZmZUY3VremJPeWt3VTVLMlNRbXBmRVNSVjVZWUY1cXVTcHZoSXBa?=
 =?utf-8?B?Yzk4ZGpvdlZDQWdlbEdld2JGU2wxTGprQ0R1S014aVh1MmwxUjAwekhwdFZO?=
 =?utf-8?B?S1h4RUp0L1BsWU95cnNkWVFkcTFTSGE4bmJseUQrcjJhMDA3U2VZV2FVV3RS?=
 =?utf-8?B?ZnZDUGIzOStlOStJNERGd280am1xaVpLSmJHYVpMY0xnSHhidWRrUHZ1bnhQ?=
 =?utf-8?B?czFQSnhvRWh3eFhwbFpVOTNwZGhMSzBFWVlIQXh6ZWdnSWNGK1VMWnl1R092?=
 =?utf-8?B?amF6UFUvUkIzcU9aZ1lRYXJDVXM3aUNmTXMvVFBGYUZRT0RSdEVRNHo1UDdI?=
 =?utf-8?B?M1dKd1ZuNHNoWThWUTdtYzlWWUd5WWJSVW13U2dZQ3ZyTGduTFJuOWM2Ylc0?=
 =?utf-8?B?Tzl2VzRmOUJ1M3F5dFBlZWZyMVZHa0hrZW9qWTBTNnk0N25NTkJOTkdUUjJX?=
 =?utf-8?B?ZEVoZ3lPTWcwODYrZGZEQVJjWjY3Yk8wU1FMYWs0MVV6Q1M2b1dmb1o1MnMw?=
 =?utf-8?B?K21uU2pDMEhDSk1QcjFkY3k2SnZHYnhQdXdtcEl6aVNEUjNoRmx3L2pOd0V4?=
 =?utf-8?Q?B/P/6/DWwN3J5rgOHKs8mpEbU6MVCZ2Dfve3RRC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99f294f-3f92-4275-e30c-08d8ed6eee48
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 20:13:17.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNUwQ7oeJVcIMnunJOrx9i+6btLpN9wdlPs1aeYZyiFeMryPcZ4wxcZyY3/CznnUhNtKjd/dLlM9d0drWkU83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 10:51 AM, Peter Xu wrote:
> When uffd-minor enabled, we need to put the page cache before handling the
> userfault in hugetlb_no_page(), otherwise the page refcount got leaked.
> 
> This can be reproduced by running userfaultfd selftest with hugetlb_shared
> mode, then cat /proc/meminfo.
> 
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Fixes: f2bf15fb0969 ("userfaultfd: add minor fault registration mode")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks for finding/fixing.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

I think this is just in Andrew's tree.  So it will need to be fixed
there.
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 408dbc08298a..56b78a206913 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4449,6 +4449,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		/* Check for page in userfault range. */
>  		if (userfaultfd_minor(vma)) {
>  			unlock_page(page);
> +			put_page(page);
>  			ret = hugetlb_handle_userfault(vma, mapping, idx,
>  						       flags, haddr,
>  						       VM_UFFD_MINOR);
> 
