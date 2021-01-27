Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA49E306784
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhA0XGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:06:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47422 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbhA0XDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:03:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RMjG5f070928;
        Wed, 27 Jan 2021 23:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=scEKWGhLdZ/Xy4lpd61HUF4B/QjnswXUlKVU3Qqzgsg=;
 b=ahp2eaI6mv1Ag1KANGrbDhywWatT/XNjHFSCtjqBWQ+ECv9lQE+iWh2DSQAz4QYuHDpk
 K12XR6clVd7zIAwF/seXIfzC0QBDJBpFAmSA2VFBKz09Pt/BqfJSFdWY/Op+dfdP1CkH
 xeuz/ZC8JqSmYB0YYvAh4HwRl8I7VB+5pr9so+CctrJNPzjQzbgCGye4FiU6++R1Sk3r
 CetMRK0YJpexPLzaUF3kClbxjtycmUf+dIrlTawDvQJvH1ie4boU6eSOeRaD21yOK7Wr
 dbt6PdPTl+KEMRMNZX4PMkSkM9emo5nlESjvr3S7n59sM4E0rLmxIB/+sA9E3qWpCf+/ JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 3689aassk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 23:02:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RMj7T4154447;
        Wed, 27 Jan 2021 23:02:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 368wcpugfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 23:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThkPyt5mSabx971Pt0SafdfGisrURehMrNCkU/Ozq5RqJRymwETAcX60Wy57mnDmIqWqcopLX6WwOxOFPFZdTNXYiqTXh+6YCreGfvsrLpZdpoUSt2i4iNK65Yd8LvBpvbjlkcjFUtLKt8BFd/Fvj8t17eRLnfIW7IacWVRUlMrGHkAUynJM2ySRHto451ZeMtGzv15hvkGLg6PT6WRPQ5tg5hV2kTmOJwsTvyf8a94F84jcgwingz5C/BF4FBA1ySLe0HeHo1/IGoq77cDBUM+WEmmM4xFUSxzlzYLkSdV2XL9UNXdBV2h8xYscUO5JA81uOLaDUw65EpvzOHtijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scEKWGhLdZ/Xy4lpd61HUF4B/QjnswXUlKVU3Qqzgsg=;
 b=HofTByFdUk9v40xrfpkbPQx+63x1gNeZTQrSC80H9BGZ/xI97TlkmJByQugl5DdXdzkh4MNliYXGdUjBdFPSFARnqlnAWQDABsvRKBfbQcNBA2kKDonoIT46371N+BmnC3DHoPzRF9JWra7MJTARJBjl6FsRPDYVnC2azOz+yLqAuEHbNUiBnYPrR1pLk8yQKqQrXnecdFCx2m5zjpshDkxoKRW1UfC7+stfh/HdDLfyz4o8aSlZlg+iLLCGVMdTs2gcXAf6nNfCWw0W+aujbyIgYA2OUq91K3XHJr5HHc/T/RcUb7pXcvkHlyZXRcS5aA98lKoMV15ZxG/ZGZMzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scEKWGhLdZ/Xy4lpd61HUF4B/QjnswXUlKVU3Qqzgsg=;
 b=aykxeLt3oCBycUYFZLbM0mr1IzCqfTVp7Vq3uOAyuDNNBdG4n5YgLDybkyZDhUFSVFSdgsgPo1IsJOv/HmWhWE+I2oKCQ2thtT5m/dkfO8MwkEOT0SfDNbeMLqUhfpkTh+Fc1wXpoAwbkM4xfRTrIiLhkiS5g+Fz1QxYlxz0lNU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB2031.namprd10.prod.outlook.com (2603:10b6:300:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 23:01:59 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 23:01:59 +0000
Subject: Re: [PATCH v3 1/5] hugetlb: use page.private for hugetlb specific
 page flags
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-2-mike.kravetz@oracle.com>
 <20210127102035.GF827@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c1feff22-115c-ea49-a720-813a86ad9922@oracle.com>
Date:   Wed, 27 Jan 2021 15:01:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210127102035.GF827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0147.namprd04.prod.outlook.com (2603:10b6:104::25)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0147.namprd04.prod.outlook.com (2603:10b6:104::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 23:01:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 046b6c2f-4124-4dbf-5bc5-08d8c3178d2a
X-MS-TrafficTypeDiagnostic: MWHPR10MB2031:
X-Microsoft-Antispam-PRVS: <MWHPR10MB2031F0A6330140CFE4BCF455E2BB9@MWHPR10MB2031.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSFvpTuVPfbgAyhhqGV/alVJSloQ7wjQfGqVGtC8UhWSGcTQIt/GPojr9qjZbH+Gz1g5pd416R54zt/UpgraobpITyFctMn1+rV/i0Xvp7KfhH1WGzpWMotm3FDRht916dXL8oFmaKJryxCbxtwh7ug9aoSGdxDAqCpK7LA/4jxyOit0nvP1Z0Sh2s6GcTyHNM4kQfCfkwwx9lX3mTqP3xtSgvpKFHjVxSFWgbNWzhjHm3yLdTMu/lZ646LAEMvfd3tnpWtDGw10+eRyyo6miKi7+JHeDiIfb3q2Bg3qYS/fqqr7AB3EpkQFSOT281mHSGTnVidOr908bEEwzTpgC46zWvBqHbJqMDbdpQ4Buk85WG3Yhu4ZqLhr0sKSwxlkBqNVZRNj2NondnhGld8Ro3rQtXkJ1wR/CUikcgpoNkSXnMNkGWMY+9+67x7kJ5UpMTPx6kFwIxzonZya02oK7Z1vmmVkVfzxBfMcKlrUoULyUO1yQdMPisb44onwYK99hWr//rSAVXrEUCa3wn7tUae29NJ4k9ZYD5AJU5hLegbEvyj6JgJLSUt06FkpWqJYqYeLxCZXawIBqwjVd2Ynp6dVkiTQjtWumhKbz8Op4mY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(44832011)(956004)(16576012)(4326008)(26005)(2616005)(83380400001)(36756003)(6486002)(2906002)(16526019)(186003)(53546011)(8936002)(5660300002)(7416002)(66556008)(31696002)(86362001)(6916009)(478600001)(66476007)(54906003)(66946007)(316002)(31686004)(8676002)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K0xFNGI5V0hpS2JVY3RHbVMxd3pCY0FiZENzTU4zMnBUek44ZFBXMnZUY2ky?=
 =?utf-8?B?UGUxbURtdkkwZGlHK21TVGplZnNzOUtFNmIxRVlqRmwvK1BMSmJQSWxuZjlD?=
 =?utf-8?B?RHdoQnFqQ0pYMkt2cm9tZjZINU5nLy9kU0tYaGZvMzUxTlptdEVDQnVZNVNp?=
 =?utf-8?B?c2VsYUkrcDRab3FHaFFwZ1BTN3g1b25GYXFHZ2lOcVB6RE5VdzRSQ3pMYnR1?=
 =?utf-8?B?SWJrQ1ZDT25LNHhFdW4yZWxvdjlDcXdJV25leXJGZDR2VTlkTE85WkcvL1h5?=
 =?utf-8?B?YmNiK2lGZkVhV0dGRGpMTU9kUlJHRWV0VWpIZFAzQXk3b3dCMVZGNG5JdWJJ?=
 =?utf-8?B?OHRGUHY5RjVKL0lRSUpuRjlFOEMxREZGc3ZFMGFZVWoycFROU1BqdW4yOU5D?=
 =?utf-8?B?ZTRKY0RnTlppRDJvRk9jNTRDS1lVdGxCeUUzQzNodUFoazFERkxraUJVZnpR?=
 =?utf-8?B?ZW95M24xa1d3UTcrMHYvS1UveGoxNTV3dVplZWkxcWFWMkZHd0RIZ1FQa1NJ?=
 =?utf-8?B?WTlxR3pzMkYyclFhQThLT0VOcEVUc3o3emRPR0ZneHluSVNWbHIxZUR0SlZt?=
 =?utf-8?B?N3pDUnNCOHNUNktMVnIwejd1b1QycWEzdjRIVW5ENUMxc3Rick91WXd5ZXhz?=
 =?utf-8?B?dGlBODBMZC85UFNVSnlKSTNicDlxQ2ZUZTBtVERZajM1blk4TzdodTFDU1hx?=
 =?utf-8?B?SzBwS01NREFicEhSYkd4TlpST1B5T1IzRkJmMWpOQzdNU0VDQkZkZnUrZjJP?=
 =?utf-8?B?djVZNFdVRXMweCtPTXhxWFZVMUpmVjRyOFp0OElwSWRFNC8zTHZDTXB2aHFF?=
 =?utf-8?B?Tll4WWNMMVBIZTlEbjh1S0h4TjJyNWdTY0txOEhmWVZtVFhHblQrajdUNkpQ?=
 =?utf-8?B?UzhiSWZPRndleEJMMkxiZmpLNTJ0ZCtFeC9abjF4ZUU4RjkyTERBa2RQVlNX?=
 =?utf-8?B?U1NjZnJaNnpOWGJ6a1BQOE1nK3VKYXlhd2p3UDd6dkRUeGgvNFNPdVBDMklu?=
 =?utf-8?B?NEVjN3p6UGtZWkQycStqdTJyMEFSdHp4SmI5clU3ZVlvZ0Uvci8zQ0Rqa3Fm?=
 =?utf-8?B?dlBWN3o4T0tGeE9wT2FGcVc2UDhjVnJzamlhUUtzbGZGOW14OFd1RXR2ZVBq?=
 =?utf-8?B?bm9ZWGJOREdPRHowVXpESnRuLzdIZXhqY0VzNlNYNlFaSU16amhyM3FwcVR0?=
 =?utf-8?B?Q1V5dXQzL0xMd3BneGNZeG1pOUNsMDJYWVlVM1VpUkRHRC8xUStRQytQYUg1?=
 =?utf-8?B?L2JEU21qYXBTQVgvTEtsZlhGbmRmNFRDOStBOFhsa0dMWGJIa2piV0NRTElz?=
 =?utf-8?B?ZWYxZFNSY1h6K2JvOGVxY0JwWlpzeEZPbTIydGZqd1lnV2o4c3hrbGMrMENt?=
 =?utf-8?B?cXdCTzMvQXRTZG1ramFhVWlFeFdhcmcxOExpMkh6MlR0eXZ0RW1xUWxXdmlF?=
 =?utf-8?Q?J94y/3Wq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046b6c2f-4124-4dbf-5bc5-08d8c3178d2a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 23:01:59.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haHCKmdJVCUHkU1FLRYGU3FJTE8ue2VYnLMKC9kALvfpjMdzDKr+ow106AQ4KsZRWUN4uN1Zql5ma6bVExSmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2031
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=703 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=948 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 2:20 AM, Michal Hocko wrote:
> [sorry for jumping in late]
> 
> On Fri 22-01-21 11:52:27, Mike Kravetz wrote:
>> As hugetlbfs evolved, state information about hugetlb pages was added.
>> One 'convenient' way of doing this was to use available fields in tail
>> pages.  Over time, it has become difficult to know the meaning or contents
>> of fields simply by looking at a small bit of code.  Sometimes, the
>> naming is just confusing.  For example: The PagePrivate flag indicates
>> a huge page reservation was consumed and needs to be restored if an error
>> is encountered and the page is freed before it is instantiated.  The
>> page.private field contains the pointer to a subpool if the page is
>> associated with one.
> 
> OK, I thought the page.private was abused more than for this very
> specific case.
> 
>> In an effort to make the code more readable, use page.private to contain
>> hugetlb specific page flags.  These flags will have test, set and clear
>> functions similar to those used for 'normal' page flags.  More importantly,
>> an enum of flag values will be created with names that actually reflect
>> their purpose.
> 
> This is definitely a step into the right direction!
> 
>> In this patch,
>> - Create infrastructure for hugetlb specific page flag functions
>> - Move subpool pointer to page[1].private to make way for flags
>>   Create routines with meaningful names to modify subpool field
> 
> This makes some sense as well. It is really important that the primary
> state is stored in the head page. The respective data can be in tail
> pages.
> 
>> - Use new HPageRestoreReserve flag instead of PagePrivate
> 
> Much better! Although wouldn't HPageReserve be sufficient? The flag name
> doesn't really need to tell explicitly what to do with the reserve,
> right? Or would that be too confusing?

Thanks for taking a look.

HPageReserve could be sufficient.  I don't have a strong opinion and was
just trying to add as much meaning to the name as possible.  If you do not
have a strong opinion, I would just leave it as is.

-- 
Mike Kravetz
