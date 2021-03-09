Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94F332E25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCISVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:21:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49564 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCISVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:21:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129IAHkt140593;
        Tue, 9 Mar 2021 18:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Qzq11SD4sxuxAZO2vEPemrEKoB87cTSs8xrbkiApU54=;
 b=w2aV8LI680wi4mk/CUqw789jwDETz/zoRVqo3YGiubfiua+11X+FnK04J7xI5eIdbom3
 0wAiIg87kYb1G0EbWpg8ylKAZlGx5/4yNa91teYRAI84JY/R2BhRNpFEEf1UToe9ESLV
 sn18xhuKogfKZv1Fg+obQ18K32FaAn5PJVN7UMIW8GcYejFNFQMuCqTGBYxLpWox93Pp
 6NP9kfAqRXnHDSAmc6HazHKTh8Qu43WwK0ld+AkY7cNWJGhMBQ14CU1u73FkdDUNOFnT
 DgTTSpB6PMrN6R8Rd8TyfaZSU28uunSOGburMRSA8aqJZpOONAo7Xv/vbFCOTXJhJD7D 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37415r8ctd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 18:21:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129IB1d8194859;
        Tue, 9 Mar 2021 18:21:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 374kgs6j85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 18:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKnLjMUFSzz/+04nmDX1rHbL+V5pB/NorM7NEWvIScF1oJlEJDSPvxIsDWvuXm4J0Ivs2SDWDs41/35FgceyFk1C9E5HByYb16I2vCvnRCZ59/RZCWCIS/1rCS9htYmdz7tRvZN4VagDt/aaCQCcnn7STQVgfOYd5nqjD5AbDlTHxg8GpdWBzE/Otw1dPHlzV9x08mkdixx58JgCwRyqTMc2DGYd2aqulSOPcrq9OBKsEHtRlu6mnyX5SnjdJMKTM5StRRWyu/Pztu5xPNgvSRYnNHj+vYjkuJp5O5ow9Gb3ZgaxRuctkT1EaA2Wb5uGkPCQ/7UvuwCSUeJLCL0aVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qzq11SD4sxuxAZO2vEPemrEKoB87cTSs8xrbkiApU54=;
 b=BiYbf+ogLy5ROKYb22YC3nmIvycUhwC+cXRDAlToCXfUbyJ8bULuIhbEfW0YbIwCMcm16rHOG5HVjlRBuPgwEYAnruW3ggY5XvyHeMM4/YM/Fly+NA2IHVWD38Grqrszt+70wmVXl7aQCZixea5Q9e7dWdse4u68RfCZtZXx7fTbbx9bBXQ/ify9xBBJVGMV8UyswRNBAI0/h/S7CnHnzjV3AYQplLjbubQk+tS73ME++aQlC5XV/E9/Nut4LrFIo2qaMqHna0nJ3bhPLYkAA7Q1iywx2vYR7rfmuvGNVil0PVkNeLME0I4ldYkKwBuInHz4PTW8l5QsYP9rjbsG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qzq11SD4sxuxAZO2vEPemrEKoB87cTSs8xrbkiApU54=;
 b=U3EvPZ0xdm0+LsN7sj1frs2fcOFteYS5hLhSgECbBN8hl25VvXlIrl605NQMgCy0q4y93lx7drFEt4Xlq2FTSX9F4gwOGi779EoLjpj2y9hhROP+cgSY172pCKlkIUxoTlfjoDME7U27DN9IcMOnvtae0LDlKpCcwFTPZRGGuFA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3763.namprd10.prod.outlook.com (2603:10b6:a03:1f5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 9 Mar
 2021 18:21:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 18:21:18 +0000
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <29cb78c5-4fca-0f0a-c603-0c75f9f50d05@redhat.com>
 <ebb19eb5-ae9e-22f1-4e19-e5fce32c695c@oracle.com>
 <6c66c265-c9b9-ffe9-f860-f96f3485477e@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <777d3771-7d2f-8e88-8496-56440e195a43@oracle.com>
Date:   Tue, 9 Mar 2021 10:21:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <6c66c265-c9b9-ffe9-f860-f96f3485477e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:303:69::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0009.namprd04.prod.outlook.com (2603:10b6:303:69::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 18:21:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e5a6855-0c85-4732-16ef-08d8e328220a
X-MS-TrafficTypeDiagnostic: BY5PR10MB3763:
X-Microsoft-Antispam-PRVS: <BY5PR10MB37636FB7AB2EF8422BA5A1D8E2929@BY5PR10MB3763.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGproCLBCk6KJSMKguZj7wBI0IaZ16y66pQfTSThdkStHgpycH3oWyEDTJNL/Qbjo/CB+SGiZvadaxHDxN0Vt2kTH32hQjC8Yop093Drn826Zu5ailjwlwQicq26/vozbqcwXxTRV1G4enNdkX8BNvg6RXw8Ml2HcGLBZ/V5PbR5t9msqVnZyNZR53dlDnrNawRxgGagvbFgHhn0a+P/6VyezUSPItCbz7ULhnepuChxniDpMAFSOj4WZj6QNwiDZ58amsvHbzWfnN3Adqr0JRaZQ7AqNJWP1dQTCQmV1A/gVgN5Fl4+JCbSh72h3k+WKFA0jPSsWCFVMVhKU/Q6jS6lsO0YJhGjyVGMmrdtjsv48ymYlLdfko45eZ1Lxiay7sLU8bchdlIb/F5s+V/w+/BXstjYmXrcMm/rw/C78/oJN0SPPl+gL4LbMl2zsx6R+A+3VjPGLLPq0IZWKYwo5PQUOxjFeFXANeN0tH6Yb44VAdtSTefVDFLSy71LVJl3dSqQC1BhuqHR3d4C+DlKONY53bewMjyseleyCJc2kjCMiYYw+Z/E+eUS9TnbcP9/aQDDgjjfJy0qsLYI8d8Kx/84c5hAjHckTV89cWNRncU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(5660300002)(36756003)(316002)(53546011)(478600001)(31696002)(86362001)(956004)(2616005)(186003)(44832011)(26005)(6486002)(54906003)(2906002)(8936002)(8676002)(83380400001)(16576012)(4326008)(16526019)(31686004)(66946007)(66556008)(66476007)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z0dUdGFIL0VEMEpBL3E0WGt6VVNWTWEvWEdNa0dIZ1d6cXVST2hCREkxY1VU?=
 =?utf-8?B?VWI1eUZQRUt4RG9oaEdYeEZtS0w5TUpacnZtRWpUOG14Tll6UTRQN1EvdzZn?=
 =?utf-8?B?YWtpWjI5eU1KRXB3Rmt3UEp0cTRlSVIrOXRWZlZocWNzbm80YjMvandQZ0Ir?=
 =?utf-8?B?ZWZlTmQ5U3FQSmtzV01yU2tyZGJGNCtkS0JwM0x1RkY1K0VpWEtCajkyYnFa?=
 =?utf-8?B?bHRpbFVZN2hOd2l0WDFnMzJ2V003WjdUZzFEaHBHRkxWdFhtckpYWWtHeFE0?=
 =?utf-8?B?eFVaVGpXK1RocWh5UHJ5TzNVRStINVIreFhqUmRrdTFXTVoyaVJOUWh0NzJC?=
 =?utf-8?B?a1JzSWhGWk1vZVYzQ2dPa1lFR1pZR2xVVmpqM2RqSU1VUlpVanA5SjFIYURO?=
 =?utf-8?B?MkMza1h6anYrSzFnb0VCaDI4OUN1b1JIK3dCeGtmMCtSanR4VDNiakxHM28w?=
 =?utf-8?B?SjZKRmV1UEhDWUxnajQxbmQ3Z2d4UjZiTjdEY2xieGEzN2JsOUpHNk9QTTBr?=
 =?utf-8?B?cGZjZURsK0JQRTc0L3oyKzlyMTlQWGJBL1JGbVZZY2JrcVZqT2tWOGlhelB1?=
 =?utf-8?B?MUZsV3VIL2FsVnBHQms3T0JMOFJuSmk3cWhSZzlxd3YrWjJJQjZieGxDcmtW?=
 =?utf-8?B?elhhcGtPZys1c3E3aHljZi8vRERvYzFjTFpOTExMNGsrL3djcHd5QTRyaWZh?=
 =?utf-8?B?L2NsR05hN1pHcStzajYvdy9nTm84S2dodSs3Z1Q3cFhybFltazBrOXpYUG1n?=
 =?utf-8?B?MDBoVUMzMWhoRUlaS21BVDlSSnBEZThsUFFKYm9PTzJSWWxmWlE2RGhsOU91?=
 =?utf-8?B?elA2a250aTQrLzZoSmY3cElpaTZ2SCtkSTRpY3RGZXZENUZTTEtTVjNrZzVN?=
 =?utf-8?B?d291Mmt0MXRxcjZ6c1FhS3NuWnVLcE43UlI0YzFDeUdnWmtpVG41Q1hQVEtH?=
 =?utf-8?B?em1xWDMzekErbHY4aERUYW1GRFQ1N2V2alhBazQ1RWxCM1dzVUtnSG1QNE5W?=
 =?utf-8?B?NmtwZmhjbXJwRE9xUXJvN3IrckdHd0lxMGZZbFozZVoycEJWSkFyM0xIMGhY?=
 =?utf-8?B?R1RyY1puVTBVSlZzRCtYQk5ndE1DeFBCRzRxMk1KTDBjWVBnbHc5b2cyOE5o?=
 =?utf-8?B?NVFlQTFZTXVIbUExMWVBMDhGclIxdW9WMmNRYklZOGxDZ0lJd3JKQkdrUEx2?=
 =?utf-8?B?RWtrYTBvdXZqMSs0UGNGVXlNWVduVXFCSXNJWHoyRkptV2hwT0MvME9ESjBn?=
 =?utf-8?B?MXhPbUlxSldDSHcycGUramplVEN6dXZrNEhhdm1mb2N1RUxob1JSWGxlNnN5?=
 =?utf-8?B?ZEZCWUlqZ1liU2lRQm1jb2YvTWJWZVZ0NWFmWGx2bXppUGF3OWt5Zkh4d2lH?=
 =?utf-8?B?cUVkelczS3VIbmI2bTdnL0FXVVZ6N1hKcjZ4MTlMUFpkMlJnMjRXQXhpZlZk?=
 =?utf-8?B?R1JkZUtqNFJJU2xqZGJQb011eXN1eVFkMEZrdktkY2pRVU83M3FMNE1kbHIy?=
 =?utf-8?B?aERyTGZBY04zamJZSGoyZnY2UTZ3SWdEdWNEUzZvb0xVUWZJWWdOeG5oY3Bo?=
 =?utf-8?B?TEM5ZkZOeHozeVRRYzZMbXNFODNnV0E5b042UDltTFhyMjlFYVlyamF1dzlG?=
 =?utf-8?B?V3N5c0lUU2lDSFhKdk9KWXZCNDNXMWZ1Um5wZlE2STdOZUYwVzdxRTFlNGpB?=
 =?utf-8?B?TlhzQkF5RlY3WURySFJqY2RjdTd3Q3NKQVBvUEpoVnR3b2pla1N3MElPdnVL?=
 =?utf-8?Q?V3Nuu9PajfQecfmmphMoFkJPVYuAIHwaFviq/kO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5a6855-0c85-4732-16ef-08d8e328220a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 18:21:18.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+90V4NW8HLf2hRBevEhYT47sV1U0zOOUqPixA1gT2p2Og4LAl6pEFCoEzeNHOkzxVVME6GRdp0g4MJpAfUQRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3763
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 9:50 AM, David Hildenbrand wrote:
> On 09.03.21 18:11, Mike Kravetz wrote:
>> On 3/9/21 1:01 AM, David Hildenbrand wrote:
>>> On 09.03.21 01:18, Mike Kravetz wrote:
>>>> To address these issues, introduce the concept of hugetlb page demotion.
>>>> Demotion provides a means of 'in place' splitting a hugetlb page to
>>>> pages of a smaller size.  For example, on x86 one 1G page can be
>>>> demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
>>>> - demote_size    Read only target page size for demotion
>>>> - demote    Writable number of hugetlb pages to be demoted
>>>>
>>>> Only hugetlb pages which are free at the time of the request can be demoted.
>>>> Demotion does not add to the complexity surplus pages.  Demotion also honors
>>>> reserved huge pages.  Therefore, when a value is written to the sysfs demote
>>>> file that value is only the maximum number of pages which will be demoted.
>>>> It is possible fewer will actually be demoted.
>>>>
>>>> If demote_size is PAGESIZE, demote will simply free pages to the buddy
>>>> allocator.
>>>
>>> With the vmemmap optimizations you will have to rework the vmemmap layout. How is that handled? Couldn't it happen that you are half-way through splitting a PUD into PMDs when you realize that you cannot allocate vmemmap pages for properly handling the remaining PMDs? What would happen then?
>>>
>>> Or are you planning on making both features mutually exclusive?
>>>
>>> Of course, one approach would be first completely restoring the vmemmap for the whole PUD (allocating more pages than necessary in the end) and then freeing individual pages again when optimizing the layout per PMD.
>>>
>>
>> You are right about the need to address this issue.  Patch 3 has the
>> comment:
>>
>> +    /*
>> +     * Note for future:
>> +     * When support for reducing vmemmap of huge pages is added, we
>> +     * will need to allocate vmemmap pages here and could fail.
>> +     */
>>
> 
> I only skimmed over the cover letter so far. :)
> 
>> The simplest approach would be to restore the entire vmemmmap for the
>> larger page and then delete for smaller pages after the split.  We could
>> hook into the existing vmemmmap reduction code with just a few calls.
>> This would fail to demote/split, if the allocation fails.  However, this
>> is not optimal.
>>
>> Ideally, the code would compute how many pages for vmemmmap are needed
>> after the split, allocate those and then construct vmmemmap
>> appropriately when creating the smaller pages.
>>
>> I think we would want to always do the allocation of vmmemmap pages up
>> front and not even start the split process if the allocation fails.  No
>> sense starting something we may not be able to finish.
>>
> 
> Makes sense.
> 
> Another case might also be interesting: Assume you allocated a gigantic page via CMA and denoted it to huge pages. Theoretically (after Oscar's series!), we could come back later and re-allocate a gigantic page via CMA, migrating all now-hugepages out of the CMA region. Would require telling CMA that that area is effectively no longer allocated via CMA (adjusting accounting, bitmaps, etc).
> 

I need to take a close look at Oscar's patches.  Too many thing to look
at/review :)

This series does take into account gigantic pages allocated in CMA.
Such pages can be demoted, and we need to track that they need to go
back to CMA.  Nothing super special for this, mostly a new hugetlb
specific flag to track such pages.

> That would actually be a neat use case to form new gigantic pages later on when necessary :)
> 
> But I assume your primary use case is denoting gigantic pages allocated during boot, not via CMA.
> 
> Maybe you addresses that already as well :)

Yup.

> 
>> I purposely did not address that here as first I wanted to get feedback
>> on the usefulness demote functionality.
>>
> 
> Makes sense. I think there could be some value in having this functionality. Gigantic pages are rare and we might want to keep them as long as possible (and as long as we have sufficient free memory). But once we need huge pages (e.g., smaller VMs, different granularity requiremets), we could denote.
> 

That is exactly the use case of one our product groups.  Hoping to get
feedback from others who might be doing something similar.

> If we ever have pre-zeroing of huge/gigantic pages, your approach could also avoid having to zero huge pages again when the gigantic page was already zeroed.
> 

Having a user option to pre-zero hugetlb pages is also on my 'to do'
list.  We now have hugetlb specific page flags to help with tracking.
-- 
Mike Kravetz
