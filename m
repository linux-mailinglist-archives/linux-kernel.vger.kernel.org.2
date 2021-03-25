Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE25834981B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCYRdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:33:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56814 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCYRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:33:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PHPSDp010770;
        Thu, 25 Mar 2021 17:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ckLmJxwxqg/sAnN53GcPh6XmUdT1t5Rv9A39jELQDJw=;
 b=sOzDzywyR6QQkb6wzYUNNO6J1qvyvKkOtdirwQNqLNDR/C7Tpnz9XKgNF47mojwiJt/J
 twjexdyGlFacbgp1h+Hf85FWZGy659Cpd34UQrKQ7IBqQWgVVIiTndYLnVhpbW/HdDRN
 fiEkN/4PlPRmvUofAABtwn3mV2lKy85bdqjmt8uIKNEHdmXnj8e/0YDHc/9fDBsXFT23
 nPvQEErOCT2heIWJB59hoAx807rKrD06mLLnND0F00uKElTHp/xJon9SuPmcmo9TQZ+7
 jog4bZFgU4Kv51P9xBKPoFVtUzTEYgUtrWR9lbF8nVhAkkqOnZ0eh17KBqDuNlYPGeWD lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37d90mq4f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 17:32:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PHUJ1o057547;
        Thu, 25 Mar 2021 17:32:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 37dttuyg44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 17:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6QBtbsockKEWJjZEibWf7f9em3jOPuG3M0CCHkjmokUORr7stIPQ+GKB9z7/SuyI7PWBk/TMm7fYoCnXc9Xnn+PKe+q6sc12Zu6J8+H3nPiWlLO0BjqGq/LuoDZAxnaF0JIV+TtHan5/kR419+F3LmAMjtxqcDqtC3mTWxBkpN+WVrSrK1e2QzHWAv355YP5HTmcVrMPxqQgEXMOQ+qJ8hxcYMao6QSwbnTNlyhTSLPNO3aCXLBwEf72KRfAuXe/brXX8B1pNUzaADNUCO8YlVUrNkqpbce7t6+mdU6SLVntcmDWocS0lrgBzMvY1wxie1dL6qZvNhTqV1R6VCAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckLmJxwxqg/sAnN53GcPh6XmUdT1t5Rv9A39jELQDJw=;
 b=RbdxgHnI/4tBMPwoJd1E+cZ5XYabiRYkp2eyuIUK0rtR2wERoi+ANnp7hIMId1qP/rLtTQyoi4hC2revNURQAC4qaEst0ZsPsyG7BICHfm98nfebw9eQ+mV4QFt/YQnWZXg10jfWt7TAxhCGJqlM0sCV0mbJD3QgHCxav3LxvK5b1HqntbVIwfKdhGWsQVKnbmjRRg6bEKjJplJHi7pxPV//JuImRPGcBpeN5kja73Yn3Dj74Ec1arQ+TOIrXkw5u5Fb+ujNAZmUKMR/g6YP9MJqriDEkXUZ5ByHoBeDr7LSuVtE5r0ZfQm/mVvX0Paa8xICjz/a3X0Pf1xZmpnzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckLmJxwxqg/sAnN53GcPh6XmUdT1t5Rv9A39jELQDJw=;
 b=uAuyF0I2M2+fM7hVjEPbvlCtwzf/+IAaNYhpqPhUuEKdh+wFC1ZhC9PkZ1SNxF5jeDjcS3Xw5QYxTq9SiiNR5WAi+eGE6MiUTSpqbGodfXuCcnp9oTjHK+nxtmY9URy2nbiZC/2zcEnmzu54Q4Dqg1whJJl09IZ/5NdJQq4eQWI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 17:32:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 17:32:26 +0000
Subject: Re: [PATCH 7/8] hugetlb: make free_huge_page irq safe
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-8-mike.kravetz@oracle.com>
 <YFxyJKR+hHEMwH2i@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3a468388-8845-d3ba-67fe-67138781055e@oracle.com>
Date:   Thu, 25 Mar 2021 10:32:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFxyJKR+hHEMwH2i@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR18CA0052.namprd18.prod.outlook.com
 (2603:10b6:104:2::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR18CA0052.namprd18.prod.outlook.com (2603:10b6:104:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 17:32:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f815f31-6f0a-4d54-321f-08d8efb3f50c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4413:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44131E0474685EA765ABB181E2629@SJ0PR10MB4413.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Io5eXP9QpSt+hk/85s6qdP0nRrbZc5Wc2FwqVA4pQb8ho5jDkTU0Dpp0CENCFEi+O46A4+EpXJ8F783mqYxAI2k6HPLcRDf1p1EZa0lrhEhRRUMjsNzwH7h7jlumuLvY8tyV8qkdUgy9ZlCidIp0PC+sgrT8VKXyRGgHJscB0BlIEfXTns+SQdDon7Jj5CSnzw55oLwSHBqOlDzCAS0nakjf7wuzt7ygme+Oe/y6IG8kNbPZsMRIj17ReQuZAMmriPjlWbhgkVi4IzyA0sr99JDvDGwZJHJCo55tCfMHyWGiQfvzG2UEQsQVxMMes+e5+Q58umlCxXWYvO64OflT1ttcrSTbozjm/E+G1RoH1S4dWp9aTH6Cn2KouN2Aq9c0lO4HAaueDog51bE/I8aw9uPMl79YqGTqiNXt7H4YAqst2ayjhAEKzfJWBVkN/nZxYZTeicdvKPiOP8FmfkXztRxgmoEVctl7DoYyjyhLUXQJovFiLF+OT2UGRZUyd93U20xmkf9sngZspNt31xxi8C5Oy8gpOt8Wo2qdDX8onPsAPRz2OXLIHm26cbY6sAs7449dht21KNFP2OkWZRga9MjCJYR4kGKinrsEA7bT6R9zWuXbG+gcNoAorWWlx57VJa5KpkhOnGZm5gfuiv+SBvnRB2clJy3BBlMmQ0n4qicCV5XSyCTCp2Z7PgBEZg/0gBkNsZCM26eh89Sa8Y6ASNRBScp5I0B2/l+3cM0HCQ3eagQ3reKGDolCIHJ7E4YwCuynuNFiQdogal7drqv/FRZBDPI1SJtWV5n3EmShT9PlYFz1ulwm7PapO2PlT+6r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(366004)(376002)(5660300002)(54906003)(4326008)(2616005)(478600001)(44832011)(316002)(2906002)(16576012)(8936002)(956004)(966005)(38100700001)(31686004)(7416002)(26005)(6916009)(186003)(8676002)(6486002)(16526019)(66556008)(36756003)(52116002)(31696002)(83380400001)(66946007)(53546011)(66476007)(86362001)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R1lWemdvem9SRG9wZmNWek5nTHp6STNpUGZRQlRNZzR4aGVSSW1QSXdWVGNz?=
 =?utf-8?B?S093eG5FbHdSN1Z5QzR3L2FZVmxqU2xpYStBclpQYmpmS2txQVBkM0VxRlZq?=
 =?utf-8?B?NnU4dEVTZU9oWXp2cU1HVkN4QkhGNjcvZWcydUFjd3RiQVJVZnN1Vkh0K3Vs?=
 =?utf-8?B?Qm9ySHpIMTVZcEE1Qk44TVBhZXJabERSMXZIaW9uMjN6MG9RY2NqQ3A0Y0x0?=
 =?utf-8?B?VXFaZ0IyTW9Zd3JHT0xjQmNjdkFEUENvSzV4WXBHSGpGd0dhSzEya2JsNWtv?=
 =?utf-8?B?dGpMMGpNYm1WQzlrUXhIWGpTWWJTajV3MGlzQ2lqWHhuSmJyOVVITFVjK2d0?=
 =?utf-8?B?M2dLYnhsRUVmK2YzM0hac21hdEF3aGVkLzRxSjB6WjFtT016N1pUWVh3QnpG?=
 =?utf-8?B?dTdYQUoySkJ1Z1l1bDdXUnZ5NElHMjFuN25sN0NUanFSZzBadGxSYkhsbGhX?=
 =?utf-8?B?L1QzTWI0akF0ZFQ1angyNytMSCtjMndDdW1ueXJjSm1BNmhHMDVsYUJ3NEtk?=
 =?utf-8?B?K2gzTXNYbUtaa0RQVWVHZzJyeUNwMzFrNXpWU2JtOGQ1ZTFYRHpUcnc0UWtp?=
 =?utf-8?B?V1ZPVjFSc0N2U1J5RHNIdmtEZERmanVtSGkyTDRoSXBER3Z6K0pCSXUrZWsy?=
 =?utf-8?B?QXRNT2Zobk1jREFKNGxWR3hObkE1VElSOXNtOUFqMlVUUG1TZ1g2STJDU1Ju?=
 =?utf-8?B?ZW96QkI2dDJTT3hIaVpYS3UyelNhNlAwUWpsYUJGQnBIbUJJQ2VhVWFhWXhB?=
 =?utf-8?B?ZDhETzRxZVhhS1hpTW9LQWJJaGxqVkUxdUo1dEVHMUJYeXBzRlRxVWxmRm1v?=
 =?utf-8?B?M0gyVHhXM2V2ZmJpdlN6UDNUUzRBQitIU3BkOUJmWkdkL0RoaU0vVzlNc0M1?=
 =?utf-8?B?NUg4akRENHBaOW81YWZhYlhlMTAvT1U2eGRLU0UyeE8vZ2RUc3BvT2JMYWpF?=
 =?utf-8?B?REFLQ25WZ2VLY0toZ0NOajU3SEx1MUZFUVJKc0pieE9JR0pFOFA2V0k4NjBm?=
 =?utf-8?B?eWEyRjQxQ2hmWmFlbSsrdG5WWDJLUVgyRHJ5dnBvU3NJNms0K2lob1Q1YWUw?=
 =?utf-8?B?SVhrMHJxaUZDQVlhT1BKV3VjRkFIeDRmWEhiTnp5cUlxamdUZStSVms4bUdM?=
 =?utf-8?B?Qzd0aCsxd0RaZ0xVK2dHL1p4NEt2Q3NpdjFNTkpsQ3BZKzd6Um5TUU9XMVhI?=
 =?utf-8?B?eEtsV2NZZ1BvbCtiTURQT2NwYkhHSGRaU2R6aEtxM0FuOHhqYkM2dCs3QmRY?=
 =?utf-8?B?MnVKQnkvUmFuM3grWERkQjZNbEtIN1lpVTk3ak5RUktMTlhtU3pHMlh3VXAy?=
 =?utf-8?B?bk5haWNUcXRLOWJkOXU1MGVldnd0RzlESDV3Wmx6dVdRTm91MUt5elc3MzVk?=
 =?utf-8?B?b1I5a21Wc2tGRHFscjhXbzB3NWVjK0d4YmFhYk05TXhaWnZJMy9tbHVVakRB?=
 =?utf-8?B?K2hHV05RRFE2TjU0MXFMaURrTUlNS1hIK0szL1V6QXVtdU9zOEVTMVBpOFFu?=
 =?utf-8?B?cVNtc2FCenFDSitzQ05zSVNnYldwVzUwTHUrWTVjOXlpaVFwRWxHN3EyMldQ?=
 =?utf-8?B?S2gvZ3RDcWZGV20zSmVFMVJmRWpBQ1pzbGt0SXY1VHlaSUZyUGxjMVl3Sng0?=
 =?utf-8?B?TFZHNkhJYzJaR2RURTYxeW42aDRWdWx1a3p4d1BsTG1IQ2RQOUhPemtoL1J2?=
 =?utf-8?B?SGRpUGlDVHhOYWNDWEpCNWZybWRycjJKU09PaGxUT2JVSGEramRVc0VBNzA0?=
 =?utf-8?Q?dC6rQUfuWfIM2R3Sj+pmpetGhpj6K9HtkD6d6SA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f815f31-6f0a-4d54-321f-08d8efb3f50c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 17:32:26.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xz+ANhlIpDKm3yM3PgaYELgXbr1VGx0KiUqZr9MJFw6+lhhQKk1vw0m4dvZ/YOmo3ouHSGguS6qIPVMimXUtww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 4:21 AM, Michal Hocko wrote:
> On Wed 24-03-21 17:28:34, Mike Kravetz wrote:
>> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
>> non-task context") was added to address the issue of free_huge_page
>> being called from irq context.  That commit hands off free_huge_page
>> processing to a workqueue if !in_task.  However, as seen in [1] this
>> does not cover all cases.  Instead, make the locks taken in the
>> free_huge_page irq safe.
> 
> I would just call out the deadlock scenario here in the changelog
> rathert than torture people by forcing them to follow up on the 0day
> report. Something like the below?
> "
> "
> However this doesn't cover all the cases as pointed out by 0day bot
> lockdep report [1]
> :  Possible interrupt unsafe locking scenario:
> : 
> :        CPU0                    CPU1
> :        ----                    ----
> :   lock(hugetlb_lock);
> :                                local_irq_disable();
> :                                lock(slock-AF_INET);
> :                                lock(hugetlb_lock);
> :   <Interrupt>
> :     lock(slock-AF_INET);
> 
> Shakeel has later explained that this is very likely TCP TX
> zerocopy from hugetlb pages scenario when the networking code drops a
> last reference to hugetlb page while having IRQ disabled. Hugetlb
> freeing path doesn't disable IRQ while holding hugetlb_lock so a lock
> dependency chain can lead to a deadlock.
>  

Thanks.  I will update changelog.

> 
>> This patch does the following:
>> - Make hugetlb_lock irq safe.  This is mostly a simple process of
>>   changing spin_*lock calls to spin_*lock_irq* calls.
>> - Make subpool lock irq safe in a similar manner.
>> - Revert the !in_task check and workqueue handoff.
>>
>> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

And, thanks for looking at the series!
-- 
Mike Kravetz
