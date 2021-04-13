Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E835E820
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348373AbhDMVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:19:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56114 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhDMVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:19:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DL9dwV115882;
        Tue, 13 Apr 2021 21:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oCyDSCHaalnwqn+iOixto63M4mygAPN5U3w6ndGM1xA=;
 b=GqytREnt7BqV7TMiEQI9e8vVfiPYWlra7yqNpN9dzXeKtGnd3/Jl439pD5wc2RlegzEI
 CNk/Pr2dZuZCYMn9N12fs1qNBx8YtJloYnFDBrxyWpVjaGOoRLII/fCvNvLF/Uxd8Q7M
 4w1TbmwkzFGEQ1sPTmE5G2Nw7K092Tnjxly/Jmg1T3aTDuQoWCLT3qtbqDy8fjTA2VTP
 51o7DIgFysgXbvzTC9qkuTSoeY2sfPzkygvxbi9bKKgSRvsRp/wcmtCDnfWDZLH127Yz
 sqOn3KVvJIDdZwMpWyeB3oKfAsGZpjHaVFgksDf3USGQae+PNLs5nvaFOgXfIaBdYSVf aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37u4nngf4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 21:19:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DLGNXm001114;
        Tue, 13 Apr 2021 21:19:07 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by userp3030.oracle.com with ESMTP id 37unxxd9wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 21:19:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xiv549/96tZ8BwLfpEumBqAUmQeUrXGcmXYkwHamVtXZxkcdDcfdSaIGv8mfYxlJx7oFTQnIbNlFm4BLQKIhiR4PDqe5Sxc0mJluTOKRj8yANXwAFrSdFho2QoWW4RG8JvI14CFCPKkg9oHHrP78Cg5BpU6Zkk/eZVQ7fCP/B97e2ibKWcoSlB7nAV6G2rTwPFPUkz2q5Nkfn7Qe6KwMI//P675XQOGT1ahKAhuyULDvCi9g6vGM5KVKrZ2eNth3un9TBJ69+o2YkhwUFpOZo6v+ohvwnhz7Y6PFQjkNBcUAi6WTgWuBtA0Lm6OfD2x4ew4gnG/IT6zNor7pC7du6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCyDSCHaalnwqn+iOixto63M4mygAPN5U3w6ndGM1xA=;
 b=G7PKoBenR/W0qYkpWOB5jS0zZ+bBwx95nOvXPfTKFjZrYzaGlBCWsZHsxfe4zY2GGGdU5n2d9jQ+UZJGbGrh48ZmraUJgQNKpCrDLPm1jhjQbAkkcNjWu0S2OHV9vqDJIfwytvZbmquk9jDnLB9p6g7E3X3xG8x4yG3GruW/FlIU6hcEpSYGvFEFgKtSLKECElmD/XbfD8pttUlTueRzIyw/VtGVYWaMES3cg8SrB7AMgyrQsx7CKC7kOGp+TucnXRbwQBK6/YCBkstgPxc1WMtIamlDekI5r3Xk5AqTs4fQt+z0g7Urxo32AEatDlurHnWi62ON52IHMEBJvRqLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCyDSCHaalnwqn+iOixto63M4mygAPN5U3w6ndGM1xA=;
 b=l/V6UebZaO9SfFflM3q0Upu5wahkgg2Cb8A/2Z8nCjl5eZHMeb7mDplDtOJQs14O3CVVWLjH0+u+MeOVSVEIsg/5G02blkZ+3oQzHTS/uCQArxE8zaF77Ue/ovJ5mlwI07lJdOHejNAOhOOk/aHe4CF6svyQwVftuCTRHPFmMks=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5405.namprd10.prod.outlook.com (2603:10b6:a03:3bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 21:19:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 21:19:05 +0000
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de> <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
Date:   Tue, 13 Apr 2021 14:19:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW3PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:303:2a::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW3PR06CA0016.namprd06.prod.outlook.com (2603:10b6:303:2a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22 via Frontend Transport; Tue, 13 Apr 2021 21:19:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e662221-9919-4399-44ff-08d8fec1c488
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5405:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5405AD0CA1AE6D079567E02CE24F9@SJ0PR10MB5405.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxHzfUiiYsfNW3EbovzBAgWQCY32RqkOlGY892NNWtc9zjSm/1jpYShsvLtqMTngFtc7oiFdLnWnwQaYwUV5wub6OWZ5iezupvK9r56AcuMJ7TY9zF/f3F2KGGiIQq9Hy1XtL5OQulyMJp1w4smDbI1vkY2MUdhJcfm4OJJD2W4xjzeF6DX2Xnjx/g/gIxpKLm1nGJYla1O3+s7HsL5fZho2DufppI9bLbgCu4DWkpWQ7RVluauvUpj6LuP8yEea9PVEDVLkcLXEFKqv4bN1pXLwhMcHDSJTrFNpcn6HFmjS8euFuH05WLPy+A89znNNhjytcCL5fyy4APxICIN8kv0xiTOEY+no0PC3aoY+BWzQSkzMQcfuffKrcl9vC76Olmaouz+3xpuvNxicE8btlRuJEjOAnWFZQbeh0kMG6Hz+N1wigKt/STCesODhUYgXvE0D2akzkBuUWtcIeFfBDGGkdcO0ivecrZYLxp+3Pdhg/yZ1lIrV4+ARGT2XTIJhs4z3/WU/7uODuV5Bz7kVrfOagcYtp77m4z+lJb7XkC9I6ALcZV/mA530aNsDfza3zW2K10GQcAR3zF96TlMA8UoGQlkbmm6xOd3xQVI60fXY/FLIUY55dmYAQgyK0Oo+tYuyLuWt+JvtxzJexb/76ZpPn7srHDryvP4I1CUlxa5yImNCpq0A/kRsEOU2i2mQ4BoYh2fowQ+kOMn3t/w2qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(39860400002)(396003)(66556008)(110136005)(16576012)(83380400001)(2616005)(478600001)(4326008)(38100700002)(186003)(66946007)(956004)(66476007)(31696002)(2906002)(26005)(86362001)(36756003)(6486002)(8936002)(38350700002)(16526019)(31686004)(54906003)(53546011)(5660300002)(52116002)(8676002)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bWRpa2QzZE1vT2xpTVdUWGp3bEdjQzY4dm1BSnhqTHN5UnpTN3VpZzN0VWVL?=
 =?utf-8?B?TC9xandkdkltamE2V2MweU15RmlmeERsVDg0UGVHQjh4elZiZzR6S29hcjZm?=
 =?utf-8?B?a3FJR3VHaVRTMWN3djJtN1FCb0p3VldFNFVWdDhaTms1Y011M0FiVk5nKy9U?=
 =?utf-8?B?ZGtHaCtKQ21MN1VCVldoODFsZ3J5dW5VdDA3OWhYMmtSdGJEbk9GNnlSSi9q?=
 =?utf-8?B?Z3E1NFhWOHl3NVI2SkRnU0tzamUrMElFVndrL0dyNWtsYjNLamNQK3lGbVZn?=
 =?utf-8?B?b3hUanJsL05ZYko0SUN5UHBCVHhKS1d2R1k1TlR6cTltOFJPMmZZeWd4ZXlD?=
 =?utf-8?B?eTB5SzNURmExR0JLRUVhdkJLbzJCY2pNa0hlRTJrU0lwWEJjUDdLWmpKSGVm?=
 =?utf-8?B?SDNOWXlkaFg3cERZaDhpMlBNRHRTUjdhWFg5QmJ1Z2VHNmtvbnowYTVIclN4?=
 =?utf-8?B?V2JNMDN5YWhGWlliVVVBN1pNTmhBZXFTQlFoTGV1VmhvSGI5QUtSYnIwVEpt?=
 =?utf-8?B?RWVTRXBCSHdiWml1eDlXVURHWWo5WjVmelFycnZYTkFXcmdqSGpaNjBsdEJB?=
 =?utf-8?B?cWxuN2NLbDlXTWxTdm5tTXhva2ZDaFVCMGFJcmFUMG92UkhPeHJ5eTRxT3Rj?=
 =?utf-8?B?RkN5dFV2cVk2Y3F6bm0wM3d4ZE11RmMyamFrMXk1NFZqcGxialE4NjZEN2c2?=
 =?utf-8?B?QnhwQTk1UFpiSFFvZXZJTFBMVDRaZ2hkRVJ3Mll0dDVUck9oZ0pwZkplT0or?=
 =?utf-8?B?NGpzOS9Uc2ZKeWhMMks0a1Rmbk8yNHZpZHVOTGtvZEg3ZGlIOVZhUUhmUGlS?=
 =?utf-8?B?dHhCZ2FUd1d2dVRUaENKbHBPQzY4eDNGSUdBcmFZUUNtUGFoT3VDREp2Mmxz?=
 =?utf-8?B?dTF3cHUzN0hyN2lMcXJpc1JZUkdXQmVBaDE0dUVTVHdhVmRhaHorb1Y0TFRI?=
 =?utf-8?B?RG01dGlBM0p5VUJhVXkrV3hhTk5TejhpTmgyT2FFTnp1TVBiSStqbGxzZFdK?=
 =?utf-8?B?SmZtTi9RQ1IzeXN1b3ZsTnBjMHlmMUlxNVdIcGwwb2FvdnNaREFHRHVOZTNG?=
 =?utf-8?B?RlcrYmtSdm1rRC9CQ1Vlc01pNThJanpvVXZjZ2dMNVEybFBjL1Y3ZzRNSERa?=
 =?utf-8?B?RDRYMFh5dmlrUWloRkV3UDVsY1UwYlp5M2xwSU8yUG1iYUxVNmh6amRVekRn?=
 =?utf-8?B?TmlaVWdXTXdiajZuM1RNRURBNWlFaEFEREF1aXhnZDRFUjN3YW5mVk1nR01Z?=
 =?utf-8?B?QmxsUUVUSERweFk2SjFMQUlJdmcxb205M2d0U2d0SGI0aXdka0IwNldJWlJi?=
 =?utf-8?B?UE8yNkVDS1Zva1dZeWEwSzh1UlNaNzRaNzFXUDR0Sk5OSWhFVWFhT25pdHlO?=
 =?utf-8?B?cHVsQmNoTVBaL3NMaDcxaTh3blFCT2h5R0xybDE2SndINWlRT2Rja3NZZTla?=
 =?utf-8?B?L01QOHZnblF2d0ovUC9CUTJadXdEM1NqbFRqcGhSZTdmcDlaaGF2U0diVXVC?=
 =?utf-8?B?R0xyK2NZZWRCdFlFaS9QL0FhMWtENjJleDhIL1RDWWFBS29mSVlidXVxVWJO?=
 =?utf-8?B?Umtzc1IwUFFiQy90cUlORncyYXcxeU5QaWgyS0tyM2JVYm5xa3N4d0c1UlBD?=
 =?utf-8?B?NTZWc3pKUHlFTlZFV0syYUZiVTlpME5qZXRzYjR4eXh6bUh6WlloYUpZM1ZR?=
 =?utf-8?B?SFhIYkFjSnBsMWlaVUFGa21VUW1WbndHa254WDdrMVRhM0xzSzRKbHhIanZo?=
 =?utf-8?Q?5BtLl70RcJ51TsWqPVM7EGq7zW7UoGvSV37yaml?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e662221-9919-4399-44ff-08d8fec1c488
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 21:19:05.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwttR1z/MPCtDUU5tNlJiShaH7i5hZJTPSrtYKbPxSx405/Vh8bHwQkjHeJEfzwZW83xlVO/w/vQPV/C2jpSYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5405
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130141
X-Proofpoint-ORIG-GUID: es44st_NZaO2tZjrgv4Cs1giuQro6v3M
X-Proofpoint-GUID: es44st_NZaO2tZjrgv4Cs1giuQro6v3M
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 6:23 AM, Michal Hocko wrote:
> On Tue 13-04-21 12:47:43, Oscar Salvador wrote:
>> Currently, the clearing of the flag is done under the lock, but this
>> is unnecessary as we just allocated the page and we did not give it
>> away yet, so no one should be messing with it.
>>
>> Also, this helps making clear that here the lock is only protecting the
>> counter.
> 
> While moving the flag clearing is ok I am wondering why do we need that
> in the first place. I think it is just a leftover from 6c0371490140
> ("hugetlb: convert PageHugeFreed to HPageFreed flag"). Prior to that a tail
> page as been used to keep track of the state but now all happens in the
> head page and the flag uses page->private which is always initialized
> when allocated by the allocator (post_alloc_hook).

Yes, this was just left over from 6c0371490140.  And, as you mention
post_alloc_hook will clear page->private for all non-gigantic pages
allocated via buddy.

> Or do we need it for giga pages which are not allocated by the page
> allocator? If yes then moving it to prep_compound_gigantic_page would be
> better.

I am pretty sure dynamically allocated giga pages have page->Private
cleared as well.  It is not obvious, but the alloc_contig_range code
used to put together giga pages will end up calling isolate_freepages_range
that will call split_map_pages and then post_alloc_hook for each MAX_ORDER
block.  As mentioned, this is not obvious and I would hate to rely on this
behavior not changing.

> 
> So should we just drop it here?

The only place where page->private may not be initialized is when we do
allocations at boot time from memblock.  In this case, we will add the
pages to the free list via put_page/free_huge_page so the appropriate
flags will be cleared before anyone notices.

I'm wondering if we should just do a set_page_private(page, 0) here in
prep_new_huge_page since we now use that field for flags.  Or, is that
overkill?
-- 
Mike Kravetz
