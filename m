Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74F413833
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhIURTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:19:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39482 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhIURTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:19:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LGp61x031172;
        Tue, 21 Sep 2021 17:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Os3eL9Of2truRsvxG/zRLhVRNkf1gk2RVzHLRxTjqL8=;
 b=N8QNbM+cOUEhvTl+5eiNbFABxm5IlyhExb+VzooqCSyZlAWvS6hOAdyBZovq7zbgMKos
 yOYU8SGsEXP3fIwDkd0fWxqPuC0rhjVic4LLyyM/hVbyx8f/16mr27FMSkjJ+uCkdHOA
 L8KWDm1yQCpaCXen/46uXw/JazqeP1CzN4zqp5ZmZGnkHiezsYrMNKIx9lcA5Vty5Z/V
 0IuG/gEB804QHkuYh3uVH1+DCPwavLB1QhIz7z+NqFtWNptETlb95Sw/Vfq2LK/uQUam
 h00GoeoN/+SQRcgAZM198sCnUD25/osvonxuJ5cJwrPDKXc+DxJ/QJs9eqBYeVp+KhGb 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b783eujgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 17:17:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LH9xwZ049835;
        Tue, 21 Sep 2021 17:17:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3020.oracle.com with ESMTP id 3b5svshu7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 17:17:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX1OGROmMinfsHycG86/USAlF2uiTo+/hNZ3iZQW8J6lD0/04TW3XlK5VfYpxRYlN01NMv8Xn9x6uHPraXu1UtcnOhNvGUd5k6Eac3gslY+ElBEPARLtZ3CT72TkZ38eAfHrxp+Mw34o0Fta1b+rpplRoNJfuN8dGaIxbB5lJwXLFkKX86gcLA/kjjfUN7i0N1mvejuKdNoQD78K08oqxdw3jsLvxrnTsi+Q9tyMawXktKapwYHUu94hQU1qhNwzlKbIp2zqboybZ3MesXnlwpcYbLglNIKHNaLLL6Zuu/xaJv0luTI8xW0usZd9QpcEDL4H4oJrwmjJSyxLB3Y8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Os3eL9Of2truRsvxG/zRLhVRNkf1gk2RVzHLRxTjqL8=;
 b=Ck8bTd61eQzlJZNuotVSVd1e+dgQL/IEw78/v4UD3vi9ZnumNF4MXC3rtus8mc+28JTRWPJqzc0o/Eroa+p+Wlf3Lt4wf9gVtg9eou0TCLRmSLkgVN23lL8CFR7UioTt9TKwq7G4CLYOS9Ha6aAMjL5R2l4N0mypuRUAMmBVNiPa2GK28oZ8WbNmw8FWHozaTHzdyH3O0pHJRba36tMF1bjHFz3p3ziABN4LTDn6YHVq1FW93FSY2eFxElCSHaeYahH8lyhG6C1MESRY/6+a5lm8NtbuDdsWT0vUONc9zg249sDR+cqLPSVRG7wzTN+sIomlX5QzDAU/ZwlUMshrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os3eL9Of2truRsvxG/zRLhVRNkf1gk2RVzHLRxTjqL8=;
 b=qP2PhcZXM5fi+kuQB0xBoBGeTInwXsZT8yc6ZWQDI2rysbcHovMLYAbl/WZ0vsWP4RiVNv1mU5XX82VV1Eyqrm80uhF7cEKa8UC++I8x7Ar+Zx0P/8VwWH1Xfz92pIUm5IcEXb0ACgfvTXr6EA5n1hh/MNDjAcolhJNNs7zMGl4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2744.namprd10.prod.outlook.com (2603:10b6:a02:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 17:17:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 17:17:37 +0000
Subject: Re: [PATCH 5/8] hugetlb: document the demote sysfs interfaces
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816224953.157796-6-mike.kravetz@oracle.com>
 <87bl4m9gsw.fsf@linux.ibm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f602af2c-1055-1eff-3071-cca891d779b7@oracle.com>
Date:   Tue, 21 Sep 2021 10:17:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <87bl4m9gsw.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:104:6::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by CO2PR04CA0107.namprd04.prod.outlook.com (2603:10b6:104:6::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 17:17:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd4a817b-9f3c-4fde-9e4c-08d97d23b58e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2744:
X-Microsoft-Antispam-PRVS: <BYAPR10MB27443702C93E982A76F8C9DBE2A19@BYAPR10MB2744.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFiiZq/cw9tnslQBpSFCw9fNygxztbPz6pFNj9HYJla/oQn5y4UMsOgdJa0UCV3MRixc4Pk4PCj9CCBQxdeoFC3kjcuuIQiyWk6xlVvhefooYLox7woeUNfoerLtE+l2LXL9ysMA6dI4qTWmzB7Mcl+A+qX/sduKYuQ5/F7ruB47qFBpmUFj6zNghTm9bII2+LYcQLD5eDdenck5Ipadw7RshRAq4lV97kLSAvuXjLcDQP17f5LCYMTDHdQ/Xu4RHR2YDvLhOcH2rW6MFCu4ZzCwBotZYAShNyLVxXy3mZE43WgJcNR1Fv7kAQwEM1oegduY7Vby0HUXOmQtbIJsg1OstPCVEX0yiyMxTeEJeUxh6A6hdxWGCj1fCNmhykdE12DaEoVpxYHvqds4V0iMF57vH+ZOxtIGm489ndECm3say/X2/bxu+zQyiSLUJ2Iiyg99uSyTIpAg/JV315vjM/OETSL3F/khFfgClKIMKU/T7CXeRfZlQqBFlvCPV+txxPMwRmpyFmLGYVIzzhqUiFqllN+mPSgYWZQjd0vC95W1tsBOQjkTeA+ezNcYGOX+58cE6mCp9I2wr6NnZoX/FdKHVnftKXBkUNlOXJGwmxzrmyr0bHFrscQDCZCv1MCYE7jex1YEazW5e70lTse6gxLmg1Th4nAEWHbtL7aVFA5Hc9Nq07bspJmXXJyeJ0IKJe8s2X9tvTvAp8XBBOxPA9YE/PyxcGVhJEj3QrDtVKpvk0t37UrvjYKOch25kCa0KY3Ss4veyEjhRDbIt0R6dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(508600001)(26005)(2616005)(66556008)(8936002)(66476007)(4326008)(31696002)(8676002)(186003)(54906003)(5660300002)(31686004)(83380400001)(316002)(36756003)(38100700002)(7416002)(86362001)(38350700002)(52116002)(956004)(16576012)(2906002)(6486002)(44832011)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2VUVnp5cHIyQUhVZVVEdFNIMGZKZURyUmFBL0xHSVluc253NTFqTkN2cUhR?=
 =?utf-8?B?RjVJVWdEVGF5S0o3UlFhWkJ0eUlDUGN6cDNxVURtQjZZZWdLbTJrSWpqKysz?=
 =?utf-8?B?UkUycEVsQngrdXgvZ2VRakl5eS95djhLQTdWMWRIbGlEQjUrOTl1VVFxdVpE?=
 =?utf-8?B?cXZ4ZWQzK0JHUllOSkdDd2dUdnZUT0dDNlBrYnhjNFl0RFFIOFlNR05LYVM5?=
 =?utf-8?B?RjBOdmc4ZEdFLzBEMTJ5UlA5Yk8xMHUvRWVGQnpNSHE2TmZ1SzcyYzAyY0Jv?=
 =?utf-8?B?QWs4MlZNbmJkcXA5WnEyYXlnTWRabEJUVTJGWkRFTGlKcFYvaWNQeUI4UFhm?=
 =?utf-8?B?VHFIRDBKc1hJUDNpcE5QdG5DbVRqN3FYYm9nVmxZaXprcnJyVWtYcHR6TG16?=
 =?utf-8?B?L3A3a0VTNFhTMjRBWVdNRHFIK2kwa0t2RVNnamZXRFRSNkp6U1E5ZTRFQnZn?=
 =?utf-8?B?OGtwaHpjUVpSOWtOZ3grV2hudEgrZ3draXhJa1o3RWhkVVNpaTJqanJYUnph?=
 =?utf-8?B?STRIY1gxRk9tTW1FczI0SDlZdmRNVEQwOW5XNThJUkUwbVA1cnoyek5FdzZk?=
 =?utf-8?B?QkFYS1F4a01lckNCOWlJdHgrRWVyZllNaDNYWHM5dVRTaVZET21qU05XaGJq?=
 =?utf-8?B?dDg1cTBMaU9VNjNpMENBN01lbUlGYmtVYnhzUnBUSm5wa3hKQjBPSGVsL0Z6?=
 =?utf-8?B?ZzYxbE4xcGl5akdJaGZkMXNNcHQvU2lJaWl2cXJZOCtST3prSTl6a2UzQ20x?=
 =?utf-8?B?cElGSWZuNm9uQzh6aWo4QUh1dy9zQlEwUTBrTVMzb3ZQbEo3akJ4VFUyVWQz?=
 =?utf-8?B?aXA3WXNFaGFPUW8wMTc1RlNkdTFocGZpNVFheFFMVGdpOW0rSzhLUjc2MnZ1?=
 =?utf-8?B?TSs5RU9zbTFUTmNUUGVFazJQam1EZUN0ZmNyVS8wamRuS0t6UEowZGJuT0h1?=
 =?utf-8?B?b0dKSnNaKzZBVEJ4ZUJzbzZNWFNwUW5vK00rUTRSV2FNL3dRZ0FsRVdROFZj?=
 =?utf-8?B?NlE3WWJZaGNLVmNNc2hjQ3hoYU9oWDJlaXMxbWZlVEwwQ2hEbDVaOFBocmwy?=
 =?utf-8?B?R0V1MFBOU2ZXbGliK3NKNzRkTmZ5SStJM3pLRFFyQnY0SjJmTG1FY0FSVDJB?=
 =?utf-8?B?UU1obU02d0tGQUNHV2dpWUJ1NFUzamFUSXg1UitRUWVPZDN3czFqODk5OWVV?=
 =?utf-8?B?MXo4Rlc2N0dYUEwwbHZuRml1SnorVWxuSGV3Zm5FVG9KZTFqc0JVcFV3dnIw?=
 =?utf-8?B?SysyQTExZ29lVDZrZWQ0ZnVWWVp4TTFFSi9LTkVvemk4cFR4ZVpRTlRXWGVm?=
 =?utf-8?B?MEFKQXUxM2tQUVh3ZXlBRUxPRGdnN0oxdHRqYktoZ0gybHVSR08ydWk2aitD?=
 =?utf-8?B?NW1tV2lnSDRWY2NudjNBZzdSVTByc3NVRUlBSEtLWmp0ZmZUR1VoTG45OGIw?=
 =?utf-8?B?TldPdEp2S201bWpENTc0VUZKTytNeGU3aGFVckgzSVFTOCtBMU9JWlFqT3pB?=
 =?utf-8?B?dXZoNHUzQ3N3OGlKOWNVa2NpZlh3aTVZWnlCRFBpVTJWdUZjUW8rYWtaVG9k?=
 =?utf-8?B?TElCMTExMkF0ZDNOeFlNNWZxR0JzdlE1cHNieXJHNmRCUDFBc2JYaExkSmRp?=
 =?utf-8?B?d0RlcStzY01jenBPYUlhU1FwSkdoK1VOQ09EVGtTWHFENzVMQjlSalJueHJi?=
 =?utf-8?B?eTJjSFVqa3IrbWZoYTIzeXZNaURNTHhLNDF1Mk9PLzNjYU0wdU9LZUN3dStE?=
 =?utf-8?Q?WqskhRjzlXSkUMMi0IfheSjEy0aZ/ftOvG5V/bz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4a817b-9f3c-4fde-9e4c-08d97d23b58e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 17:17:37.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iOnA2GM68hZ1G48hYA9NbKSBXgnNmQsXDFxuZdNttv84t/Fpxw5Q3jOIRsHLygJeL8PdI2ITbWKS1B41Jvq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2744
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210102
X-Proofpoint-GUID: _kIgnpBu_WosIbKwr8bIn1A9IO3qpkDU
X-Proofpoint-ORIG-GUID: _kIgnpBu_WosIbKwr8bIn1A9IO3qpkDU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/21 6:52 AM, Aneesh Kumar K.V wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
>> Describe demote and demote_size interfaces.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  Documentation/admin-guide/mm/hugetlbpage.rst | 29 ++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
>> index 8abaeb144e44..902059a0257b 100644
>> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
>> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
>> @@ -234,8 +234,12 @@ will exist, of the form::
>>  
>>  	hugepages-${size}kB
>>  
>> -Inside each of these directories, the same set of files will exist::
>> +Inside each of these directories, the set of files contained in ``/proc``
>> +will exist.  In addition, two additional interfaces for demoting huge
>> +pages will exist::
>>  
>> +        demote
>> +        demote_size
>>  	nr_hugepages
>>  	nr_hugepages_mempolicy
>>  	nr_overcommit_hugepages
>> @@ -243,7 +247,28 @@ Inside each of these directories, the same set of files will exist::
>>  	resv_hugepages
>>  	surplus_hugepages
>>  
>> -which function as described above for the default huge page-sized case.
>> +The demote interfaces provide the ability to split a huge page into
>> +smaller huge pages.  For example, the x86 architecture supports both
>> +1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
>> +2MB huge pages.  The demote interfaces are:
>> +
>> +demote_size
>> +        is the size of demoted pages.  When a page is demoted a corresponding
>> +        number of huge pages of demote_size will be created.  For huge pages
>> +        of the smallest supported size (2MB on x86), demote_size will be the
>> +        system page size (PAGE_SIZE).  If demote_size is the system page size
>> +        then demoting a page will simply free the huge page.  demote_size is
>> +        a read only interface.
> 
> That is an alternate interface for nr_hugepages. Will it be better to
> return EINVAL on write to 'demote' file below
> /sys/kernel/mm/hugepages/hugepages-2048kB ?
> 
> Or may be not expose demote possibility within 2M hugepage directory at all?
> 

Thanks for taking a look Aneesh!

You are right. If demote_size is PAGE_SIZE, then demote is just an
alternative to freeing huge pages via the nr_hugepages interface.
So, why even provide such an interface?
It certainly would be easy to just not display demote interfaces for the
smallest huge page size.

Based on other feedback, I am also making demote_size writable.  It
makes little sense on x86 with only two huge page sizes.  However, it
might be useful on other architectures with more sizes.  demote_size can
only be a valid huge page size.  Before your comment, I was going to
allow setting demote_size to PAGE_SIZE.  Perhaps, that should not be
allowed.

Thanks for the suggestion,  I think removing support for demote_size ==
PAGE_SIZE will make the code simpler.
-- 
Mike Kravetz
