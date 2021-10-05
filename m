Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CC2422EB4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhJERIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:08:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9196 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234459AbhJERIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:08:37 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Gs5jX029416;
        Tue, 5 Oct 2021 17:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7xgNoFGWYhdC2o2ETsGK+MWSREL4OqZlV+rA7ccMvnQ=;
 b=NkadXpCHT3bxCWkr5PgJLLa0oYgozQef/Bxr62aLx1gFhRoS5lI/OSGYJPxbClRKeNyG
 eKpdRkwOHKg3Ef6JHoyakBGi3Vec2yRg39ZcuHMlcmFW5ASMF9zwoc0OJyPphDp8oXx6
 1ko+qTwlkIe2vCBjXCw2S7vZDI1ZM3Gt1kgBMrkAtOYC7ZEPMrmEKdkCw5Ny3CvCxK+a
 a3J91aqyGY725+U21qRRB7UqaGVUxlIOfrGcMeGQIXjvHqMr1PvFt58O0HfeGSdjQb7z
 z3trf8GODSWKq3eZRf6C+6qwtqigVTNEiZNclnT/MWOVLAS3rmlGZKlUdM8bVeiXm867 cQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kscng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 17:06:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195H0LQu167982;
        Tue, 5 Oct 2021 17:06:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3bev8x1p0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 17:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdHCjTgH5VyppvHOJfp0t6Q87tHaNgRfKsvzY3AN64TIJRm1unmkpmd01dWiJPSyAmLwQ5Gy4CxnWxRSa8f0kRNyJ4ClFyK+Ub5yXt3aE6M2oQhURpO817jXGUnIm12C9Av8f5fO99yWw/gSLqQDPPMtiitSNl11WcEeuVSDPs+n+F8AkcZ8RItpoTSt9vv0H2lbMDxn0NZCbIT4W650KZ0xcTCQtEcoaUiBJ4dGpJm00roCrRXuWp2iRDFOoEFt5tiq9eHCc3ddLpm+7kxINaGXSZIkHcTlmP63MuWuxR+Occ961wE20mHJiZI3RprvP4KwzVRWvdeo1Wb/OY0Ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xgNoFGWYhdC2o2ETsGK+MWSREL4OqZlV+rA7ccMvnQ=;
 b=AFhXm8+ftn7hIh/RrbG7M65xezPt2ByFevG4kIIRB37fSg8/GQNkDmkFQZN5REHepaUU32W2bZbhlIOnefAGmJxGHCDaYq5J5c8WQA0WJTGyvtD+3hXURYoyP5p1dsJ8RHnFK2Ws1BHlH0PbqGSYkfRCOoR5ixwpb1ACDNp4zqwKUrXmKLCQo+KY5P9Nzmi7IJV9fmwtCf8+077gpzqGWs9KEC3ITx3tTzs9KPT9G6SUQEtAUUpylGpD/IJ8dOt1+MYBFeW1MRqIabXfra1CmbGyTiSbTPhkgXjvFhKuQl4cWM1NUD6IQLT01BkdaOQnFGPEWd4B7R9yf3fs1zbwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xgNoFGWYhdC2o2ETsGK+MWSREL4OqZlV+rA7ccMvnQ=;
 b=gUX/AUCVA13K+AS+Nu5RMf59mGIjcBHBHRniFOiXlq2/ePIrApFkCQk5lytJEqccQ1kZbX08fQ0osGNJUIwEJPxAQo7CV2IpZJRCq5dtBqfyE9G29kmAGcSPBLeqKnaQyFTZbQ+Kr/NaYD2RXhhhjIKeggaasNDznu9GQx1WvaE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4145.namprd10.prod.outlook.com (2603:10b6:a03:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 17:06:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 17:06:28 +0000
Subject: Re: [PATCH v3 2/5] mm/cma: add cma_pages_valid to determine if pages
 are in CMA
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-3-mike.kravetz@oracle.com>
 <20211005084557.GB20412@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c01d3e08-aa53-f62e-1979-3d8a14414f0d@oracle.com>
Date:   Tue, 5 Oct 2021 10:06:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211005084557.GB20412@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 5 Oct 2021 17:06:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f7142d-820e-490f-bc11-08d988227841
X-MS-TrafficTypeDiagnostic: BY5PR10MB4145:
X-Microsoft-Antispam-PRVS: <BY5PR10MB41459AC48B70AD6339ADB3F2E2AF9@BY5PR10MB4145.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N316/VFz1GD+WPPBlu2Hua0HlU8NRULMGNxqeR44UZ6O/nuoZuksYGTnOHiBXs92GfNyzQ3qttcdLwfjZYg+HhbbDghjHo2tCq/zhTsgGJlSXgQj0K40sZGvMliGCLX4/DvDNGP9XA8kZKWMZTNHBjTjyM9kyvI7ntu0SI5vyQsd7Dw+YhyA8vaDoAriTkf1tT/V8ty1dOS6BwoxX0u7EU1VtXKju7UiIF0GvAgmNMwm6G28gxbP/tsUGXDQ5rmciJgKLQTWI7A7ggOlOac/oOwh7fyeXutbw95Zt4TCy/ziurRq+3YRokW37sc4XYAzDa/i2ChWveHiKQ+Z/bhG3fw4T7fX967HIGuENXRMhMN9+JeqfgUXQf/8s9FmDma4DzcgZ8WAc0HM4ZAxzZSkRLA+wHdVI2PuQ00bHgvmV3PqF4eSbwyzxFIIlIK5dBjxutpKx3H6fv/ZMf5/w9dv6p6H+vZwGqX0zkujFO3WdqeCKlEV+QlIhO93gDGtugJjZQ2N6+H2Je5BsvhTbA5o/YQ2c2Pg/wuMIK6JMCbNttKzWRWcf+g4lEaxiYEUSikyPR6q/OQm8LcL9ufE+5hlwegD5uUK7QUtIzJspDl32VhfeiFgu/rBF6eagFbHAkUqYiqXMM68jRdGZE6YXIShOz7rqvJaOF5EJQECsedbMzaEvjXA6xTRPPeCLAEY75My7QHjjKjmf7K+5LZz9z79IiuyIG6yi3XC8Z1Lx1HUYwyBrq+O1s4GgXkmr14QfesakPxyVALkqQpv+Qww98vtsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(2616005)(956004)(52116002)(38100700002)(6916009)(4326008)(36756003)(86362001)(38350700002)(31696002)(5660300002)(83380400001)(44832011)(8676002)(66556008)(7416002)(2906002)(508600001)(6486002)(66476007)(316002)(186003)(26005)(16576012)(54906003)(31686004)(53546011)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRSN2xsZEw1Sk1manBxWEpDU2llWTlzb1VwMDEvWjl3ZUprSlQzeHdqc2xs?=
 =?utf-8?B?UlE4RzlFOGhIcXlobW1peXBNb2JsV2xQMkxuN0dMbVA0VmQ0WkRzVEZYSUFz?=
 =?utf-8?B?bG9lTi9RMFlyR2xRSnU1TUtzMUlFZXRHc2V4dkZTcTQ1VTRlczFtdEtIWmxG?=
 =?utf-8?B?Q2VVQkdkcWdyaTVOMHU3bGFtRE1ZQXIzMlNwOW5GM3g3YUozTCs0SVNJN0ZF?=
 =?utf-8?B?d3ZCdmtIZFZIYWJVSHR5VUl2bmJWNDNXTXpyayt2MkdwUXpEaks4dWNjN2NY?=
 =?utf-8?B?Z3oxeDhienZ5VERPYVpCaktCY0RYRTlHZ0h4VG1DaUlaaFFQMHQwWWN0MlJY?=
 =?utf-8?B?NXhqVmpFaTFiUHdGMDRyT1MrY3NtWnF3cWYyM0hkVGFKVFh1d2w0VDV3OTdT?=
 =?utf-8?B?VGUvYTBMT3BaUElXckowSXlkRUZ3WVVNK1BtQWhNUTFjYTZWakd2N3B3N1Vm?=
 =?utf-8?B?Yi9hR0xLUXgveVJiZ2NyOVBjS2p6MGFGWnovNDVYdVFROWVqZ2tsSU45dDhl?=
 =?utf-8?B?cXhwSFlzdDlvOGpIVml5enJwTDEwL0JMb2dXMkd2MWhRZWJLUW03aGZmMVVt?=
 =?utf-8?B?ejJlYmtLTFRZM2diWStIMXVnbXRId0VPTzhlRytxWk5TbDhYVzNIeHJzaDFZ?=
 =?utf-8?B?MGlnQ01RbExOSUVvUnY0Tk1RVjk4N3FySWdnZ3F2UUZVK0dyTS9WcEpCUXVI?=
 =?utf-8?B?bmdzejQ2aHhPbkRVcURFRDZ3c0xaN245UHpqbVB5SHZCVURjWHJlNVdRQ2Fx?=
 =?utf-8?B?Y1JtNnEwQkNFbk9PZDBjb1hFL0MyVy9uUXhIT1hMY3F3bXZwUFVNc2ZKWTdV?=
 =?utf-8?B?QzBIdlZzbUkzd2pQSDU0ci9ZQzhuWE1nZ3FCcVNoWSszQndvQzNKVEl0ZDZX?=
 =?utf-8?B?T295YU5kcy95TlY1Q3lkTHh2WUhNWFdHUERoMWR1SkF1c0t6SjdnUXM1Z2Nw?=
 =?utf-8?B?cDgyUlNndWJjcjFtT25mbnhuMjMzOGlqVEltYmRoK2txV0RwdHRKaEpyTTZs?=
 =?utf-8?B?QUdxZjc3QnNoUjE4T096cHZzbFM5ZUFQM0R6MFZGOG1ZTWt1QXFzR1pmeUVX?=
 =?utf-8?B?VXRuOCs3N1BKYTZDWDQxTXUrRzFiSVFWWVlrTHgzNFQ4dWlmd1phQlhhUVJD?=
 =?utf-8?B?cWxVTVE2dUY4Rk5KWWpsOWt6Y0VWcjBrWTAyUUNFaS9kekhrQUxxVjk3RFV0?=
 =?utf-8?B?ZC9KeDVlL1ZTeTU5K0czV1p3MnRRMzFiQUxBcWlUQmNyRnVGSU8rVW1QREpz?=
 =?utf-8?B?OG9yYnV3d2RpZGdCb2FRTjI3K3VYb2VoTU9MajZEZTBzY1RZemhPczlSU081?=
 =?utf-8?B?VXorbTcxcTA4WEk3SW4zRnVmdm5pRStOTVNvNVR6NkhnMmdlblhOQ3lhMDlw?=
 =?utf-8?B?dW1ubUxBczJpVFJuYmRVUEZlOGYvci9NT3hGeU02ZjBoY3EvTGFnOTBuSEpV?=
 =?utf-8?B?bEsvcExMMExXbTltZEhkRGMyVlA4Q2ljNGk0VG9TcUZ6eUpFUU9zdUw0dnpY?=
 =?utf-8?B?bmxVRkoya3hrS0pjQVYxNEVXZnl3alp6Z0VZRWg3NWtFSVF5ejdQcFA2a2tl?=
 =?utf-8?B?U1M4STNrSlpJZnpzYWljeSt6RG1UWUZDUkpZZHd2V3VzRkNuUkNRUWV0UkR2?=
 =?utf-8?B?dktHOWQ0UUpNUW9LMjA1YkV5RE52ZkxvYUttd0Zyb2hxZHNheDh6elBNM1BF?=
 =?utf-8?B?ZksxWUE3ZERqclU0QlVwOEU5NFNEODYvL2lYNDFiTUdvSjJrTmZpWGNMbVIx?=
 =?utf-8?Q?CEDKGG5SS4CglxtGM720nX24SR7/uanu9RLaUD+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f7142d-820e-490f-bc11-08d988227841
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 17:06:27.9367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObTF4cE2ELcL/dENowcsXv8kMh3PkCdgDGkYlTfXTBY4Qmxc4ixcLMCoz9Z6OE01lOLhjm+1O8VKrqAuwBzt4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4145
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050102
X-Proofpoint-GUID: nDpFiyzDFIDVDbEoJl09fj5fS_NkxLMf
X-Proofpoint-ORIG-GUID: nDpFiyzDFIDVDbEoJl09fj5fS_NkxLMf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 1:45 AM, Oscar Salvador wrote:
> On Fri, Oct 01, 2021 at 10:52:07AM -0700, Mike Kravetz wrote:
>> +bool cma_pages_valid(struct cma *cma, const struct page *pages,
>> +		     unsigned long count)
>> +{
>> +	unsigned long pfn;
>> +
>> +	if (!cma || !pages)
>> +		return false;
>> +
>> +	pfn = page_to_pfn(pages);
>> +
>> +	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  /**
>>   * cma_release() - release allocated pages
>>   * @cma:   Contiguous memory region for which the allocation is performed.
>> @@ -539,16 +555,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
>>  {
>>  	unsigned long pfn;
>>  
>> -	if (!cma || !pages)
>> +	if (!cma_pages_valid(cma, pages, count))
>>  		return false;
>>  
>>  	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
>>  
>>  	pfn = page_to_pfn(pages);
>>  
>> -	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
>> -		return false;
>> -
> 
> After this patch, the timing of printing the debug statement changes as we back
> off earlier.
> You might want to point that out in the changelog in case someone wonders why.
> 

When making this change, I did not want to duplicate that debug
statement.  However, duplicated code only becomes an issue if
CONFIG_DEBUG.  So, duplication should be acceptable.

I will make the debug statements function as before.
-- 
Mike Kravetz
