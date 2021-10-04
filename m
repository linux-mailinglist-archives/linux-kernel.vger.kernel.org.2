Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B142166B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhJDSaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:30:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7882 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234998AbhJDSaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:30:00 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194IJXaJ023925;
        Mon, 4 Oct 2021 18:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ojUXUEd49xMX16WzSEjlZKUSxgKlackdW6wM2QhQfEk=;
 b=NNyKgqiZiflcRLBlvti0M5OIjyqhDhCyLfP0ic8C9Le7hfFFQqBe1NYZOJVKzRNL/Aad
 u+0FBZZTC0vnMJ0pR9amjUUSZOqSJvmhSlwkceunQVp2GIsR1y8Ss2IE3MbNNeWfTVdb
 EmjR687ahqNhwNy9ybYrrxyVmHzaTV2lMup+Mj3s+s5/JEH3a76ckxPpO0T/TN3iCO5H
 JOT6ZL1LdjE9NwRpjbx3vy6zeOVmfuzAkB5nawLFsUTSDUCnxPTH9nyIHEmph68PvsH6
 pUMCBVPpk06+8LoXh6+wfKaxU4T7T/3ZO4W+BZlvUGA/zA79IBX3wJiDY2JmImu08r+e xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gher0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 18:27:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194IAbSH168897;
        Mon, 4 Oct 2021 18:27:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 3bf0s59hwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 18:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0hm+vXPuhcJp+5zFPzOLAlDcvjb/WVKYquXjUvaFS3Z5snBeofiBvYT6qajpgYyi7JsDfS1gvzPcOfCjK+ZlmDbgs+HTfKzII8jULnMR61wstlXq6nAR8LPGp5Ejh3dLHE+Uh3X/8OgzaAyf8ZBqycgT+9LsB1+2JGb9z8T4SxyDiRRDdPy3a71becb3anfI5bLSHlHUo18muLAMh+eMW9TqZVy8JA2uBD8BljcwF9bHS++8L4IBTDAlgXHSwuPRfAnyh7BleQv5HXifYB4sUXcXKwxhLiPW/dSyi4bC8fEZcPueGs5Ea41rTnk7omFCsOduHugsKA9x7CPTSPd9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojUXUEd49xMX16WzSEjlZKUSxgKlackdW6wM2QhQfEk=;
 b=clk+hFdYxBpsE39wtxCmU2NGQs2QW9JQvJbn4jRsOFx202rckGJGMQqRDM7IqSKx7QHAPfkohuEGY0+9bGtWKWw9FEv8yw8b/yMV2TLHtrVmHU+v96IG0lWyizuFhxiqGd4EKcCO6wbH6X9gnEmmDxdcioX9lRZPer/jeYVGdCvdp8lgH3i16uw76Jh+QRUIMRu5GE5ejx0pSdWf0gjrWpUCp6R+04xP8rTTDKlbZZEoDrMsetNRIt+TJQs8Jg1S7Srdzmuelk6+q3Kjvhe78yoXvS/yNpLzurHdr9lKRoMdpom53uQYe3N+aPM7tszijWEXLWeb9RZh2ELLa3exNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojUXUEd49xMX16WzSEjlZKUSxgKlackdW6wM2QhQfEk=;
 b=Zav62dFgnXSxtjF13bUsr+qtsCHpk0Pd5Uin8qCoDaft5bsYvQglosSvkY3RBFKXvgrHulsGcm3y9+tDjrKoILPLnW/EgrzcyeG2Jr8ZBUV9gPlGYLKe6OCEA/tP6WvS2jWD3/GS6K1aJTfpnxeho7UlxWxDFxu3qRw6q2X+6aw=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Mon, 4 Oct
 2021 18:27:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 18:27:39 +0000
Subject: Re: [PATCH v3 1/5] hugetlb: add demote hugetlb page sysfs interfaces
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
 <20211001175210.45968-2-mike.kravetz@oracle.com>
 <YVr7C8ek1g9hKz4C@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <81c2e7d0-cbdf-56fd-2a59-34c180d5a979@oracle.com>
Date:   Mon, 4 Oct 2021 11:27:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YVr7C8ek1g9hKz4C@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1701CA0022.namprd17.prod.outlook.com
 (2603:10b6:301:14::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR1701CA0022.namprd17.prod.outlook.com (2603:10b6:301:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend Transport; Mon, 4 Oct 2021 18:27:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2cb515e-64d1-4938-4bef-08d98764a54a
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-Microsoft-Antispam-PRVS: <BY5PR10MB39875B4D206304F2417331D4E2AE9@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocVd+ypSkT36Xnflk1rvLF7HndmB+NBICQzfDOt56vqNNrKdiL6FYUYdVg+kAWv2htZkdMwB29VZpjgU5NLRR6kRqHO38VRg5MNRSPsjvKlmlvCz/+VNJL7cxlMlMLBQBrXAHSsbKyNhsqGqBflT1BpJOaZsnLhOr9Imy6WGeSD5kDRNBNnNb1Frf8AgJ9Ba0LlTP1ycCzyDwDRYUipBW87AqKUwySlHPhJfre2dB2RukApT+7mE88zSyUIoC6YqBMjDyfLx10Ovi6uvj46gVfQ5v309jiMhlFEt4zQdbiGkVMajTR3GOkCNfco+CD4/lIuBzxt+H6PaEPsc/NWS6p9HqxCtAD0AjjoNvXGD6xo6WtpOSMMuYuef1XR29lfaOFAgoZPo3ft5H7jS9+li+D0DVytBMRiUHSMyquD0jPbuFmCH4ov9fh1OA8tPwiC3+PLoF+N+G56tvD+QoLg9lJsyVb4I9TL6NqsLB3rdKfKj0lWToccJ3KoosUuhrlhiJN8IgoLQKh4BzatJ9RN2dwV8kbiflBU3+4E78KIqWIefRp3bEicxJJvMiGPxeZkLqZICPRM9Wt1Ww9SYzD9Wo5M9bUl/B7Izoy37utpjAm57N9BeJ0N3VrqDlgksKy7NGQpJ8ziGkEFM5yscNlLJ6Yza0/sBCTn5e8X0DCk3I+U3MuTfbLEHyykEwt87yVhsLGLpfwI/Q/ZLMyzp8D4Ko3ZK6Nd3aZe9tieyamFfjj+2hSfijLNP3Pz5ttERJYQ+wAIgOabyic6MmchnwYeAbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(53546011)(66946007)(86362001)(16576012)(6916009)(8676002)(66476007)(316002)(38350700002)(38100700002)(52116002)(36756003)(31686004)(66556008)(54906003)(2906002)(508600001)(44832011)(956004)(2616005)(186003)(26005)(6486002)(5660300002)(8936002)(4326008)(83380400001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhjUGhNR2RTQmdNYk56V0t5bjBDOEYyTm83WC9XbWY0MCtrMkhBMUFSV0Z6?=
 =?utf-8?B?T2JMVWgwbDBWb0MwWFc3Ri9sckpxd2hMaWZlNThlUitFSHU0QmpqTjM0OSsz?=
 =?utf-8?B?QmRDT0UzeldxeWxmWS9ZYUZicDJUSEppRUVNa1JwajV5bWxTdml0aW5YdXp5?=
 =?utf-8?B?K2Q3NE1mSW9OSm9ydnhpenBxQTM1NW1Lc1paZkV4UGNiSEJ3RU9Ja3dFbmd5?=
 =?utf-8?B?QXNXS2lqY3pTdGwwTThoKzNLa3VSYkxlTktJOWZrZFFuZ1ZJYlFvNmYvZnZD?=
 =?utf-8?B?V3hKbFB4bTk5WG1CZlZPMG1kTnhxZG1xZmorY3JiY0JtUndzdEpqcWk3NDA2?=
 =?utf-8?B?RDlRZ3JBc2FoZWcza3o5dDlramV1eHFENGxHTVZXeDZMVHAxblQrTXJQcU1M?=
 =?utf-8?B?NmJuM2UzWnhxQnFEQS9zYng3bXdMZlpMMWg4bFIrbzB6T05yQU1iTHdVeUV5?=
 =?utf-8?B?Y0JoYjdMekdZNjVidGtMa1BtOVByUzZZMElsRHU2R1lxc2ozdHdzeTlMbTVt?=
 =?utf-8?B?MTRMMzFIczRraXRlbjExdjAvek1YbEU4KzQxaUNSTk5XYUJreFBFTXBlRnlS?=
 =?utf-8?B?TE5kVWZWQUhlVzNQVFR0OE1BL1Y0M09TQytRbWFVUm51MWVSeXVyUk9DVFgv?=
 =?utf-8?B?U3JhOXgrNXVjdDVEMW02d0MwVXRkQk5oaWVOOHhRVm5Rd2d4TnZsckh4Y1JD?=
 =?utf-8?B?NXNsbEJCMVFaTWx1eVBiWERUdkxJV2FCVmI4bkhpVVZWRFM4TUJNRXZ3NWd6?=
 =?utf-8?B?US9LRWE3cTkxTkM0VUY4TFV6M2FuZlZac0Jlc2dZT29WRmZSd3BhYXVEdndR?=
 =?utf-8?B?bDVBNGVvRHV4OEVKSTliSEJMM05xUTVreVlrcjkzdkx3ZXJ4d2ZBWFlHU0Rm?=
 =?utf-8?B?c0NyR3FXaGsrVFUrdGZZQ1drajh0UTBSUHZ3UDZ4MGNpZkZoV1RrREV4eUhO?=
 =?utf-8?B?YXlDeE9YNHo2UDJ4cUQ4cWROWGFOWEhXNW9WR2dhRVBqaHJra3VwZWszQTJX?=
 =?utf-8?B?b1dKdk1aMVVoR1lyY0JDdFROYlhmb1BxRnVGcEwzL2ZVcHBBem13azN4ZVNl?=
 =?utf-8?B?bjB6NDFOMXRZUTVRQkxRRVMvSW16QVQxY01zUW56cGovT0xTaFFBNGpsUXFq?=
 =?utf-8?B?SWM3VDRnTzBUQjd3Rit6R25vUVN4RXpCbzhrMHoyRHBNTE9oZEV6c1hmcllk?=
 =?utf-8?B?SFpGSVpLV1pBN29mU0E0c3h6MFJIUkhMR1pzcWl6RTJEcUlNYWtUd2xETWpv?=
 =?utf-8?B?UWkxVjE0azZpVm1qalFjb0xNczFiTmdncVlnL29SOU1yQWwrOHlrNkU0ejZl?=
 =?utf-8?B?Ly9oMUc0SW41U3ZJanZJRVVsQ3MzaVJHSnY5cVZzS3hGdG1ZYkV2aWpTaitN?=
 =?utf-8?B?eW93OHhiUjJ4REhoQnBVM0IwUjFVZER2dVRDYUxvQ0l4aE9xU3RjOEx3Yk0r?=
 =?utf-8?B?NmtxNlVlYkNDWk92TGJVMm9wN2FCMGJIQklPbFNqM2JuRVBOWnQ2cUJYYTJB?=
 =?utf-8?B?SUV3TWcxK01vTDdpM3NZSlpaOWpKMm0zNi9YeDBqZkdDNFR6V25LWE5CUlda?=
 =?utf-8?B?NkRxNjhKM01OaldDYTdmLzR3TlB6ZUJrZHpWOGd2WTJVckNDRnZLcDhVUmtV?=
 =?utf-8?B?MVc4M1h4eTN1MjZwaFdQUkthVjM2eGM5QVphTi82NXA3THBaU1c5TktXdEFO?=
 =?utf-8?B?aWtENE5mZWtSc3h0THdrVHY3OUVmbEFmaHhpVlRBb0J4SWt0WWpocENLazB3?=
 =?utf-8?Q?uUGtcrM+b8RZFxgrO3aJVFT1FwqzaaqX/UtV/4v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cb515e-64d1-4938-4bef-08d98764a54a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 18:27:39.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NXwNOJH6s/5zkfkzKvQpQ5tFfXgvgkKVw00z0QumbP+HgIhWgyR5E9SnojuuLhfoQCzJF41DvTsJX56k5w29A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040126
X-Proofpoint-GUID: RmXyuI-akyAokuHCCnL7lCZBULp1OC-W
X-Proofpoint-ORIG-GUID: RmXyuI-akyAokuHCCnL7lCZBULp1OC-W
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 6:00 AM, Oscar Salvador wrote:
> On Fri, Oct 01, 2021 at 10:52:06AM -0700, Mike Kravetz wrote:
>> -which function as described above for the default huge page-sized case.
>> +The demote interfaces provide the ability to split a huge page into
>> +smaller huge pages.  For example, the x86 architecture supports both
>> +1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
>> +2MB huge pages.  Demote interfaces are not available for the smallest
>> +huge page size.  The demote interfaces are:
>> +
>> +demote_size
>> +        is the size of demoted pages.  When a page is demoted a corresponding
>> +        number of huge pages of demote_size will be created.  By default,
>> +        demote_size is set to the next smaller huge page size.  If there are
>> +        multiple smaller huge page sizes, demote_size can be set to any of
>> +        these smaller sizes.  Only huge page sizes less then the current huge
> 
> s/then/than ?
> 

Thanks

>>  static void __init hugetlb_init_hstates(void)
>>  {
>> -	struct hstate *h;
>> +	struct hstate *h, *h2;
>>  
>>  	for_each_hstate(h) {
>>  		if (minimum_order > huge_page_order(h))
>> @@ -2995,6 +2995,23 @@ static void __init hugetlb_init_hstates(void)
>>  		/* oversize hugepages were init'ed in early boot */
>>  		if (!hstate_is_gigantic(h))
>>  			hugetlb_hstate_alloc_pages(h);
>> +
>> +		/*
>> +		 * Set demote order for each hstate.  Note that
>> +		 * h->demote_order is initially 0.
>> +		 * - We can not demote gigantic pages if runtime freeing
>> +		 *   is not supported.
>> +		 */
>> +		if (!hstate_is_gigantic(h) ||
>> +		    gigantic_page_runtime_supported()) {
> 
> Based on the comment, I think that making the condition explicit looks
> better from my point of view.
> 
> if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     continue;
> 

Agreed.  In addition, this code will look better when more conditions
are added in subsequent patches.

-- 
Mike Kravetz

>> +			for_each_hstate(h2) {
>> +				if (h2 == h)
>> +					continue;
>> +				if (h2->order < h->order &&
>> +				    h2->order > h->demote_order)
>> +					h->demote_order = h2->order;
>> +			}
>> +		}
>>  	}
>>  	VM_BUG_ON(minimum_order == UINT_MAX);
>>  }
>> @@ -3235,9 +3252,29 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>>  	return 0;
>>  }
>>  
