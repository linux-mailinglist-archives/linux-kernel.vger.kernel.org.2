Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B73080E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhA1WEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:04:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54944 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA1WES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:04:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SLxQ6v025832;
        Thu, 28 Jan 2021 22:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=x1a4ngKD0B4FPlt/UdyWYr2m5DHPNHYr5X/iTENoVP4=;
 b=L8lXW/99kIs/wnjyIyx6mbIEmAKDUvRDb/EBz1heJJN3tg9eo/9lKLnmjfb1LdsJzQyN
 k4kZZf2TmLB5W9TVgXrjPp9qoe9gNLoMXqVNpc4gpEMCFeBA0T3STJHVBsIiugvDN5eH
 0qpsup/YVIQAXGyj7wIiHa/kPbHfavHwPn3YvnHwzSyfG4gj/FNtegOiVq+hUdYN1e6U
 3EMHjdgMfFEmjt+OtMnZNfxyLtmFA1AQy8NU+8MqXH+O8T6PQc9UEaWje8xdhbp3OGuJ
 rCrvxj39rp1xC6LETEBODpfhWVoEXaGahEBZtMNQb2rIZrTOEY9HHV8cUJ0diuVOg6kz 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3689aaxjqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 22:00:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SM0nlL037849;
        Thu, 28 Jan 2021 22:00:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 368wq2968b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 22:00:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnfwfUdteTZ8LcpENr1syhZq+W182bcpNwRSG2Ew8LNIEwztfp6czmQBj0Ufhtz2jiptzj7J8kKHXiONZyFEvSQregKvSAA9W7CA+3bqxCpJWFCd4njFngP/MmyV8Gxb/ZNzgncU+/WY9khaZ79NLcTsteOolUkz64MYezdV12GyCOnbap4z3IyOvW2uSlBvjB35A10jZ+V1zrvryntwULshPYIHeWWUJ2J0DOPQyiEM5BofggldCbwXenWKeaz4M3isse1p0Ae1NX3w6xkAyybGSr+hvAuKZRvVAZH6E5ByS2PH5AK6LsA5yIRszZaE1I6+R4P3cxgI4d2J9FuwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1a4ngKD0B4FPlt/UdyWYr2m5DHPNHYr5X/iTENoVP4=;
 b=WR1sEEdCx4p1+k0zmqzdn2r7aY3awxo+OExpV6zmxf+QRROCbdjSMp0zS52JaljeCpwqrP3tvm7y/CWtJxnnO0ptPtg20zHMzmfEXDHYe+zMlJYS5k7f6uddJdKxF+2lF5A7J9sPlg2TEAZ/ISFkLA21kwiDEZOySNxpx7latkVTkpcpU/wKDSpWB3RrSayZ/97tRpubRMPLNrJOCmq+1sg2CHzNZullS7WY5qOKTde58j8kEzPPWiMPsJt41FvtDpLDwBSt8/ebA8GeVeymDMs5Tw/6om45G01klb6eR8j93D6NpymuJi4kJ32d3KkQNpqdEk5XMykCaCqjgEFZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1a4ngKD0B4FPlt/UdyWYr2m5DHPNHYr5X/iTENoVP4=;
 b=oD0tpHx8zo4F8INUSB5XI9x+yfgxhBs863kV7S42I3c5tLeAQUdslpGcdBvo9ZRGjJF/bRpV9848+nnMS2dakx0NGxJCQUodtcUGkQsDhWWBz+1VD4bNHpg2icBY5prPfm9L+zaTbGf3OIWUEhIl3yKV2zmlIHKysSthalp2HHs=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2175.namprd10.prod.outlook.com (2603:10b6:301:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Thu, 28 Jan
 2021 22:00:30 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 22:00:30 +0000
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-4-mike.kravetz@oracle.com>
 <20210127103523.GI827@dhcp22.suse.cz>
 <2196d93e-f573-7163-183e-0ad2cec7555e@oracle.com>
 <20210128055221.GA3166@localhost.localdomain>
 <20210128133733.ce1fb2eac98ab5696c08f288@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <12187293-e972-acd8-7789-22ebfa736f95@oracle.com>
Date:   Thu, 28 Jan 2021 14:00:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210128133733.ce1fb2eac98ab5696c08f288@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0391.namprd03.prod.outlook.com
 (2603:10b6:303:115::6) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0391.namprd03.prod.outlook.com (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 22:00:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a10f62c-29be-48a5-af19-08d8c3d820e8
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2175:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21750ACE9C0566F7D39A1AB6E2BA9@MWHPR1001MB2175.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDxZXygNP5bzQcZV8V9F0oV750YJZFnK45nmmlnPv+A8CVhuOVF28GgZ4GoJsS48rnlvlg0+IKtdMWzfkWZeprlrX+Qrrb/wZEVN8jLxfAeVEJcKURXS9xkZp6ucuEfUCRTuoalyH2qwF1awy4lxvshCIa0vAh30RAi/UmvVsrpm76iw9AwgJn/vVoQoxS3RDXry00+WIgliH1/kutGNBb8EFry/d0tvfXMHtZwAxJNNLjh9lVebyJd0omvkzhW23PIZk1qTbTVIAm8rKsBqhkYGfxrLQsNCvNSPsP9XAd/eo1Na/PGeqXMtnx/kpIugxrljSqM5IMxNaor/6NV5fc4rh5fHczxYYj2jZ/8/B65Zdo68+nsyi7l7uH7JkPo7d1Dl/M0sBqCpho8S7lgLt19LTYgyB0cxR+zM6QxfiLuKfM+g79D7gmFkU8BZw194j3p66fG6i7QUodttInGzWWISOMnoecWzvYu4GqUiGYfAdmamoRJ5qKxhebRguvGCRvMm+i3v/uUWZdw3hbiAt/ZAdR7ukSptdCjlTWObyt+F85VU58F61zlek12YsFm88MUt9OcHU6oPbO39RhfCxb5IYWK9i762m7UKHwCyhT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2616005)(2906002)(44832011)(478600001)(6486002)(31696002)(956004)(36756003)(186003)(86362001)(8676002)(66946007)(16576012)(66556008)(31686004)(83380400001)(7416002)(8936002)(66476007)(4326008)(26005)(53546011)(110136005)(5660300002)(316002)(16526019)(52116002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TjhCWUxPZG5pL3MxWTh3NWczYmRmcWNueTZlRjJzN3diOGRxTUdWUjc1WmE2?=
 =?utf-8?B?K2RmbmRadGk2bUFLazQrOTJKR0oyejh3ZGJxZ3hPM0xnVEJHa2xlSjhUSEth?=
 =?utf-8?B?ZUw0WXZxb1dIM1RqT1JTVHRvM2poNEVsWCt4R29yVk5hSXk2V1E4cUxRSGJ5?=
 =?utf-8?B?VjdGQWpUblJaR1NKaFA5S3RWbXVrNTZrcSsrd3NwOW8vWUtDRU52V2FaaXAv?=
 =?utf-8?B?cUtDY29aVVdnRHpTZXpPckxjVHRqWFVYemhnK2tUcVYwa2wwc2V1Y3IyaDhl?=
 =?utf-8?B?YjhXc3pyQUlNeG5VVUFMUXg3Q0lic3ZNQUN3Q1RrQzlTTEdUbHI4aysyaElR?=
 =?utf-8?B?NW52ZE1wM2VEbC9WVkY4Y2xKRVRrQzBsbG9PdFRUdk5NRWJudU4vMExxRGdD?=
 =?utf-8?B?RnVKb1dTRWVQbmdQTmcxTDBnVXBOQ3hsbzY5bkpudEpJcy9XbmMxYlJEWlFz?=
 =?utf-8?B?VkUrby94clRMaE5NYkZ6N0NsenBYMnV4djlSTXF1NFByRTNKOXY2UlFIdWdw?=
 =?utf-8?B?VkNjV3p1OThzZVllaFpncTNqaVpYOXFxMVNoMTZMVXNEcWhHdHpzVVBjS0RR?=
 =?utf-8?B?bUIxWDVySDYzWnBLVklUMzVLTUZZYWdIbFR2RFl1dG40WmxSUktWenB4NGlN?=
 =?utf-8?B?dUMzR3l5QmtwcUtXQ0I1K2Q5M1Z2WGJINGpGNDBkTDJIQnY4dFhJMkUveElW?=
 =?utf-8?B?L0YvTGlITkxuNVRQOTNXT3NQTitiajd2M0FtMWxoQ3RsZlFlQ2NJU0VTUHhN?=
 =?utf-8?B?Z244TG80d0Flb0ZBTzZEUFNBRG91VXpVR29pMThxckR2aTR0UTg5R1N2TFNB?=
 =?utf-8?B?UUZwcXNXanBYdUVXWUIwc2s4SVMvUk5TRGFXMmxaQVV3Z1RBYTJvWDczRHIx?=
 =?utf-8?B?RE1NWW40WmYwQ1ZLT0hQcjVFL2U4eVpsOXlFQXJrdkdaeGVDZDduVWdTM0JK?=
 =?utf-8?B?MnFndS9rQitOemM1aXhsV0ttaGhKUlBUNHNKWHdGa1lsYXZvOWJUK1JyMGtO?=
 =?utf-8?B?U3d1OENGOThWcTZXWlY2S1JiTzBQalNDOG1XQXpkUHBvcDNZcFM5NVkrT2ZE?=
 =?utf-8?B?WnZmL3MvK1d2SFE4OGFQNjVBT1NCMEdta2l2bFZqOXl0YnJFS0hwYXhvMS8r?=
 =?utf-8?B?UFB0T0k5WGlzREJJUnZOSG1Ja0FlaS9icUxLU2xTN1g0dkZxZldkSnJVZUxJ?=
 =?utf-8?B?bGZOSEJNSXk1akhyaDQ4aU5BV0l0WTkvNmlVc1FJbEtMNHlLbThtVVduRm9q?=
 =?utf-8?B?emdhKzl2c21WN2k0aHVqZE1EcWp1WHpqelRDU0xqWFpObXhSYXhQQ3JuUXZt?=
 =?utf-8?B?TWVzTEJSbDY2TjQwVG9GTkN1U0lSemlEMzdmdzJmY1MzYmdNblp3MS95WVEx?=
 =?utf-8?B?d2YzcmVrTnFLb2dlSUpMOHcrK1ZlbFN0d1ZSY0hwNUIxV2J0S1RCaE5TN2ph?=
 =?utf-8?Q?39voIIon?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a10f62c-29be-48a5-af19-08d8c3d820e8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 22:00:30.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mClOp9H4oZnobmzbPIXgmPU4ldrRHLZsYKHZivGeQNhOt9n5xLcQOABaGVufqzXTCimvaiwvEBD4Vz6PWMLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2175
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 1:37 PM, Andrew Morton wrote:
> On Thu, 28 Jan 2021 06:52:21 +0100 Oscar Salvador <osalvador@suse.de> wrote:
> 
>> On Wed, Jan 27, 2021 at 03:36:41PM -0800, Mike Kravetz wrote:
>>> Yes, this patch is somewhat optional.  It should be a minor improvement
>>> in cases where we are dealing with hpages in a non-migratable hstate.
>>> Although, I do not believe this is the common case.
>>>
>>> The real reason for even looking into this was a comment by Oscar.  With
>>> the name change to HPageMigratable, it implies that the page is migratable.
>>> However, this is not the case if the page's hstate does not support migration.
>>> So, if we check the hstate when setting the flag we can eliminate those
>>> cases where the page is certainly not migratable.
>>>
>>> I don't really love this patch.  It has minimal functional value.
>>>
>>> Oscar, what do you think about dropping this?
>>
>> Yeah, I remember this topic arose during a discussion of patch#2 in the
>> early versions, about whether the renaming to HPageMigratable made
>> sense.
>>
>> Back then I thought that we could have this in one place at fault-path [1],
>> which should have made this prettier, but it is not the case.
>> True is that the optimization is little, so I am fine with dropping this
>> patch.
> 
> I've dropped it.

Thanks Andrew.

Michal suggested that comments describing synchronization be added for each
flag.  Since I did 'one patch per flag', that would be an update to each patch.
Or, I could simply add a patch to update the comment block based on what you
already have.

Let me know what is best/easiest for you.
-- 
Mike Kravetz
