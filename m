Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2423937CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhE0VON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:14:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27052 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234725AbhE0VOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:14:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RLBp43017674;
        Thu, 27 May 2021 21:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R2Dqq/R0aip9cjzzFpEKTslwFmtoPLt5Yn+huHXWVbY=;
 b=ghDv7u1wBOnAQVTO/yQFZJxI16LRvfQhRkvLGZEdjVzfL7cWb1S122ktNadbRsMXTSW+
 GKdwSqLGwn5WuPb1oZL+4kDWxKeNJH691aOHxF1/9utPVqXUKRZuam+6KTwRNHvXfU/F
 2E6kqQSbNsAI613hBL8UmtTtWr/Vgj3LOKWP0I//oUHUMp9z/uIRP5u1TUaONi8BSmyB
 i0t5wq/Xhf95+XY78PQojTVpVfFUiAcHJYu5wyLym1D+qdA2D2TL3gYV0WitijSKPYZo
 DGVV9n1oZqHxmr3H7UTsjpxLiedUWWXgwRuH9/1yYAYUwPRmg1Jl8U3LQHuYTjhiUYUg dw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38smut0n2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 21:12:26 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14RLCPof091466;
        Thu, 27 May 2021 21:12:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 38pr0dxqdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 21:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFK8EHvcglSVZ+bgLLm7HgKtQcbjq/TCeSwH3jWWO84Qse/VcRWcane5ognTsB7nv6hUsZ1lQlUHdMAeJPlGJE2Mf4QDt4pjlkZModCU8A24Lkkg6/z+tts1Io7ZOpbW0UOHtsq7m037Z3K9AlOG9eFXTRXCYl71BN6hU1dZCVY4R/50uyQmbltHy1x6o3j6vg6+DeHSu9rwJRS3PXs2rzQyLtfoCx0BS3pOL4KvbwMHCg0iu758tyTJQfm7qQunflVQiBBpb6yJaeQHbk2wjzrUpDZ2A836UyAGjynYx/gKDVeGsRRUdqmthr8+NmQMXs32YhNGPa4msXed+SRbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2Dqq/R0aip9cjzzFpEKTslwFmtoPLt5Yn+huHXWVbY=;
 b=S7fh6RsQhhN1zIH0pNl4BMbpJCIX3Ogk4YhfUcruDwcztnGoHPfcYOsJQmuQDN1zF8Txh0cJfQaJrmwKUIq0QDnrFcEa52hl9V5Qnk0nolUfakXIFbOJBgQWMui5QQ9fDhygb4v/gclGZDf7NaveT8A0ureuaYyfA4E3a2+Sp6bk0/7//iCl9qq+MJYTWIwRLDCF3RkU0tVEcnvrIhAD3cIrpD55s6LTaA795BUHVuQAt5Q5SJOmdftpmi+NnZH1Z0DWMeRyTUYR1qDK1ovB55cxajmk7WqXPh9Ed82BCflYFMYLYplq7vKgp/hXotvVCDQqGsCGeaZp67ZPxS/iTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2Dqq/R0aip9cjzzFpEKTslwFmtoPLt5Yn+huHXWVbY=;
 b=qDgySt557jCOiMqTOKc7vS4lxkhpmizKFeuQTjEEw8M3bwMuoY9hYkqV5uVgd9EkpBBojaTXaJb8Lg9dVoVKjumfdvzSSyINHtRP1ej3KN6uFTzqP9Iv6BbwHYbaSLgFGcca7ocjWQwTdvlucSf8dJNT0J+0ODemwOBJB1pEoQA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4354.namprd10.prod.outlook.com (2603:10b6:a03:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 21:12:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 21:12:23 +0000
Subject: Re: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
 <2097f731-0b72-a5bc-1011-09447089a81b@oracle.com>
 <YK/44mOnwZgUOdYA@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cfd46177-16b7-7eac-0845-41109552044a@oracle.com>
Date:   Thu, 27 May 2021 14:12:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YK/44mOnwZgUOdYA@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0060.namprd10.prod.outlook.com
 (2603:10b6:300:2c::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR10CA0060.namprd10.prod.outlook.com (2603:10b6:300:2c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 21:12:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddee6ada-cf31-4e7b-8e40-08d921541f49
X-MS-TrafficTypeDiagnostic: BY5PR10MB4354:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4354E108E2C01BE0F71232F7E2239@BY5PR10MB4354.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIMgLSRuS4pv8KRE/o7Ecvjam5OeIe5wgvBJ6jLuNC/9CR8tkJGkuDFse7g5+kz/k3FdvkvYl4NlSQ4gCyB0aTvS8pqDz58deSPZrU3Kgo4UrP/46v1XsGQSUrPe33BpSA87OJWfgrPG8I4qH8MUN2TbSoihWri3Uv90Epg3iZHOAnfU9Ib0ecUBnDFKhOYh94jv6Z3P4Qun9cAcyet4wSL4fVkJ92e7PvAlnMfk2claUnhwV6G9NRFD1e0q2q5VZkkony4Hw3SucbIXSEu2uwQEPF6gzQBNTYkm57OzeJvkdAWP4WdPlXQdV6YUl/GZ+bEhr/PROKmDwWstOvUPArkBnHHlt6Myfd+uYx4f188geCgm5RVBsV/3l5jb0NbArUo4ZI4VQAT3A/tPHSw4qwZDRIf0IN0J0hXKrKacOFNpmdxIXNDrTunm90bTMzCfNgTr/tr6sXl1RgWa8Aw2AWpanS7pCeV6m5Le0uLObe9GAJcP7WnqBEbZ3Z8iaDzgUbBOsdyE33GAoqndrVjoElC8x0b7CzFep0cphOrh22CJ1/5NnX5ENIJXunsxYSk6kjvRnQ1MOce6NopSZIXf+CR2dXASF43aSoWF4rsPyu8ue+Jwr9XqUCZRhrRiMxQmH2B5O4sUthIME+6QjoQOF+kU4zOl0RfGVaHk9Jnp/uCGySzj2B8O2VIuN+vu5kcG0+jYKRHY+/5av2lfan/MUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39860400002)(396003)(36756003)(316002)(53546011)(26005)(16526019)(186003)(52116002)(956004)(66946007)(31686004)(66476007)(44832011)(2906002)(38350700002)(16576012)(6916009)(5660300002)(6486002)(31696002)(4326008)(8676002)(478600001)(2616005)(83380400001)(54906003)(38100700002)(66556008)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ri91RTliRjU1S3hzbnNGS1VrRXJBNEowczRCM0xqYk82NUdLZ3h0NC9ZM0NT?=
 =?utf-8?B?Z2NOUDIwS21Ia1ZQUlEzaHFkTnJlNkhWK1pRdmt0NHhtS3RMa1B6empZdEdl?=
 =?utf-8?B?VWNXajMvTHk1dHRuaG44WCtzdGFabHdpNDl3SXRBR2x4YW83VW56bUd0K1BE?=
 =?utf-8?B?V2V5UEFRM1hkVWFZbDBhVUVrL3pydGZKVFAwWm5pWWZ4OTZPWDhDYjRLWVdy?=
 =?utf-8?B?aXk0QUZ6bkZ4YWdXMWRvK3dnMjFWc1cra1A1SFFqWHpzMEw5VCtOdkxKZi9V?=
 =?utf-8?B?bHNiUm41Umozb2VUbENOeUFRM0ptQ3g3VkpvcVBpUlYzNThKS25Zc0hjZCsw?=
 =?utf-8?B?K1NvSm5xcE5nUmNNMmxNL3pZWFBlbjZnTGExSkcxT3l0R1NORmsycGlaa1cx?=
 =?utf-8?B?YXpOdEVnYk1qa2E4L2tqQ3ZNL1VtbXdwalRFZHJkVTVDVFkwb1hsb3lTRmll?=
 =?utf-8?B?NkRWOXZnYzIzMmxFdGRhNEh1bGRCYTN3VUlZUi85bkRvVGZ5UlA0dGhUUVpu?=
 =?utf-8?B?VC95Z0ZVNGpEU0hNZDNtUVhUSHIvck1aeFlCdzJLV2hUWUZjVWxyK25tR0x5?=
 =?utf-8?B?aW4rdmJYMVJpemVUYmR0VVQwUnkza291M1Axc2pMSnRUSGpCSmJ1bGg0RGNz?=
 =?utf-8?B?ZmhDWGhFVkdQTDhvUXRHa3V5OGdVak5YcHlndUhLQXQ3amZSR21UTE8wUUhS?=
 =?utf-8?B?SE15SGNhRTRkU2FIZmZoaVhsYTNuR0NlMmxMU0xiSGg1TWtkNWJIMWpkb0Mr?=
 =?utf-8?B?NTFPNzhQellVRVFHQmJCMis5Y1p1OWhKYUlwSGdIMTFRdmFYbmUyWFV5L3J4?=
 =?utf-8?B?VkRYWDF2QmhVRTdtNVhvTzJIb2puWWhsd2RwbkZ5Qk0vdlZIVkRxdHBoZlRJ?=
 =?utf-8?B?UDNoSEJoRG9raHNWRm90ajJFdGxib2pkN3A3Qnp3Yks4WURYYXd4dDdseUpD?=
 =?utf-8?B?VmdrdmM0TmRUajZJQXNXQVhBeHlXdkFVSDVHZjgyTlh5Tk9UWE8rSVJEMEFI?=
 =?utf-8?B?WFdFY3R1dFJtNGJZczJvaDI4K29GWUlCdmFMSHJtZWFMTnNZNEVDY3BhWWcr?=
 =?utf-8?B?ZnJ6L1JlVEtkRnNtZysrTDZRaDVBWS82MzVSOUZDTFFjT1ZIcVZmZHp4UGZk?=
 =?utf-8?B?Q05XZi9yMHRBWk0vNm5JTllFZ1V1OSsvZUtnZm81bDRkeERRa1Q3cVE1dmhk?=
 =?utf-8?B?aHpzVUxJNS80NHNtU1NZeXBkcDVxQkZaMkF4aURSYVhHeEF4V1FDWWtjZlc0?=
 =?utf-8?B?NTZ3OTVGZjlxaXp3S1JKNGRKdkRFUW51YjAya3REQnJDVFB1cVYrcGhSa0RL?=
 =?utf-8?B?WGVINkM3OUl6enBnVVlLYTlnbXBYSFY4K05nVzBQMk82SnRYa3p2VzFEamsx?=
 =?utf-8?B?OWpwWWc0RXI0TWkvSkZyZ2VaaVp6VTFTeG9wQ2F5RTNNQWpuRFdKVUF0S042?=
 =?utf-8?B?eHFXTzhWMis4MDk3Rk9kTWsvVWZTRngxd01oTENxem5aTlNSaDJRS3Q5ckU2?=
 =?utf-8?B?dEkxQnBZVG9lRS9MOENkN2FOaXJ4dTFtQ2FtY0FIa29sM3hnM3gvYlNham9U?=
 =?utf-8?B?eS9RZmppV1RMeGRFcFIxTGwwK0hVYVlIajFMWE1FMEZPbXc3aExJcjhVU0FD?=
 =?utf-8?B?M3dOVUxyOFkrM3E3eTdmcUxaeEN3eFlJWmFpeGdySnFWRTIySGlkWTMreUw5?=
 =?utf-8?B?UllTVThvWTBnVHNPN1BCWjl2M01KZnlEVEZ6MzhJRytvb1U3Q1FjNXNBNUsw?=
 =?utf-8?Q?9IPpY1tbz6vayo3UM6j1XKJ8bdqAJZ50TEEQRxM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddee6ada-cf31-4e7b-8e40-08d921541f49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 21:12:23.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QH5LmgJ76B6M9bbOkF9PYR03U0XLaVJFtZYg1wDsWUb9Gssl8a2GgvHHxAijEPLciYDcpxI64X8x7jRpsgQGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4354
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=848 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270136
X-Proofpoint-ORIG-GUID: X0GWY_XS19aHqCMP0jIilPKqBFhCsXpX
X-Proofpoint-GUID: X0GWY_XS19aHqCMP0jIilPKqBFhCsXpX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 12:54 PM, Michal Hocko wrote:
> On Thu 27-05-21 09:28:51, Mike Kravetz wrote:
>> On 5/26/21 4:52 PM, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> remove_hugetlb_page() dereferences page->lru, so it's assumed that the
>>> page points to a head page, but one of the caller,
>>> dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
>>> which could be a tail page.  So pass 'head' to it, instead.
>>>
>>
>> I believe we have the same problem later in the routine when calling
>> add_hugetlb_page()?
> 
> Can we ever get a tail page there?
> 

Yes.  Actually alloc_huge_page_vmemmap() and add_hugetlb_page() calls
later in the same block of code expect head page but we pass 'page' which
could be a tail page.

>> If so, should we combine the changes?  Or, do we need two patches as
>> the bugs were introduced with different commits?
> 
> If there is an issue then I would go with a separate patch.
> 

The calls to alloc_huge_page_vmemmap() and add_hugetlb_page() are only
in Andrew's tree (and next).  So, they can be fixed there.

I'll send a patch shortly.
-- 
Mike Kravetz
