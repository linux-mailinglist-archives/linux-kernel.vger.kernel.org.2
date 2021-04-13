Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A735E5A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbhDMRw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:52:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36396 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbhDMRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:52:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHZiIE102407;
        Tue, 13 Apr 2021 17:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eeRYD7WOb1xGZyMoSS8RWHltP2xJxanmifyxj8y4PDo=;
 b=TliFtkKikiV0hpxNWs5DCe3VGNx9tBZloyV34HLNKkS14HE8HKnbUYgvmfZ4NRqwx29I
 uuSGu5CS9gX8jolGKv7f01ObLLTCh/HG0Ba35EZMER7V0Or1nOJiXPobNgiPRmtive4S
 d9OIqivplrX9VV+R+uwEjXhioEi9KJHUryIUAmVeJJ3B7V8ZhkP1a6ZGAIdNs1RdO7nh
 AMsFFG3FXPwb8ygGP44++PToQMoa5xFglPWPVxF6mA6Yu8aQFU73eVB11IAfIfUVa6Ks
 0PRbFJKz3BXsH+hBaOCS6I6N8Hm8B2D4en/2ibcK/G7qdUu/VuhdT5lDMvC3yEcDj3UN 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37u1hbg38r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 17:52:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHZTpK057239;
        Tue, 13 Apr 2021 17:52:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 37unssq97v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 17:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRPpB7+f9dqDnR5kj6e2mLrz3w3obit89uOKNMkGlkaCs6693MDvQo3FnBykuTChGQiPh2HZ2jT8FX6rFT7sFIxRvhmlsRble2jOr1sXniF6bvwfSRxWXZ7CK24BIBD9kjcJGcZpveMGgYBW827nXf8WZHg49gEqbnf7OWuJc/Wo7KrGUYKoLW6833Qy7Lc4NWC7EL9chDNPmTHDUJnu0WHs2onqY6QIIiefNaE9LlvcnQA3vMjjneO1gxyKTavV9NC31MRglGAmzuR9ilBNninthOss3USfJVSYv/Q9LFDLFvbzhdLgAKg8/VK9pgwfZZ7c0kxrzqU0PS0KKYJUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeRYD7WOb1xGZyMoSS8RWHltP2xJxanmifyxj8y4PDo=;
 b=fxbHh+rUpg+L9NsK1stIi+z3VXr5hKImkKJ7KE+cxKMF0gzkn+Trvse/pHFPrZVYEIbBSq1Cs+Q6F7+LcKgdZYZm2T+PSkLzu8+on4fdM/620nCgACkhDeF+cVO9uE9uqEgb0FXBAZ8SVAlLl5C7Qek/2JpvwZVIW26vV/C4DCfAiuwxwKh3WlezwZGHAGFdhI9WYBDrSgVJtdm+VGWJqQkkyt3GpH1lSi8d/+wPIOBlN3HGT3Re9WL4EEjEErygd9a04j6yFY9UQsbd5+4jU15ARqA2P0apBOODPqYE4HVxRFDariBhmuUs28D5SEXGEHrptyK5JgTruLCwzUbv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeRYD7WOb1xGZyMoSS8RWHltP2xJxanmifyxj8y4PDo=;
 b=MeMBGNwIzGgnE9ZHF0DOECoA+cfa5eWubsGE3HxWp/f0javETweQ+kHzCB8Z2pxWpoFVmi1KvQTOO8iZR1pYoNO92Z5OgAUT8VK/8T5qvTdg/LwHpFvBwXGXA32Gf13zmmQYmw/eLtYskmmjeg7/FGT+/41SkRUvfhTavWpgj8k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4559.namprd10.prod.outlook.com (2603:10b6:a03:2d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 17:52:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:52:26 +0000
Subject: Re: [PATCH v7 2/7] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-3-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a7d5f0b9-360e-c3b3-d13e-4e115dc81145@oracle.com>
Date:   Tue, 13 Apr 2021 10:52:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210413104747.12177-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW3PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:303:2a::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW3PR06CA0003.namprd06.prod.outlook.com (2603:10b6:303:2a::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20 via Frontend Transport; Tue, 13 Apr 2021 17:52:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9dc026-c8a1-4066-d3ae-08d8fea4e669
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4559:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB455976ED53B648FF355B1524E24F9@SJ0PR10MB4559.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIfvFqbiH8Npph7SAr/90KkGCQUpyohdS0oBaxIC3lWgjmpq2hhvDskihnsq3bF/WlS1CLPGGe40u81NGAVrX0u4+Q/nEi876xpKqYHyZMUD+Xe1GeylcxwSV5DP+WoztIUaEf6c0s8jAr5E6YhPixdNwkIYe1OyKqhVdEcStLB8o7f+LvGZy2gJq8CJHLGZA2UhfMuQGdgPicJIWbjlNqB6bAx0+U4CshlN/UVMVC3PcRu3Yb/T1NEFk7eN9H5Ulu+sLtUiNBZ7Z8bXnnM7of/mNt5I76WJsZFI0gqdGYF3qOd5oOIgmDkrVz8xPT7E2qXm7vzfj4IOdAPd9wwgwAg+z7w+e/amFkoW/fy6lUQ/qv6MhuTCjq/5lLBZgcopxGhHZ8bFnyhbB9gz/UAbU3/vRpp/qZEgIqzskFrFRn0DXotdTQWVkS4LdfvcJkx0t/3IemhddoOjKyg/2a6jw4DELZll6Tt+l5fccmIv/Fkt7B9Vc4+vjpFrb8eOxl+/A/gUQhS82HXrS3yUQAy0mm4WRXki1i3ZckJP0nQEqYnQYxglxFTlcGX531EUQ5IykI4BrsGNGut4AjLqeEiSUny6eRYOAh9yHZVet4jT+2vqDg0SHbJC5V+1CvIWG5sp0NZF4Y+Kv4G24SJMJG6RDatRHKysHvNC8D/TWhOQFQZbAd4rzJHhXi8Fe4dA8GiQbi2B9oujrSFGTEbDEjg5Rz8IceYo2E6Q5x6wvZe3f2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(31696002)(54906003)(5660300002)(38350700002)(66946007)(4326008)(8676002)(110136005)(53546011)(52116002)(36756003)(2616005)(2906002)(316002)(86362001)(66476007)(16576012)(4744005)(186003)(31686004)(16526019)(6486002)(44832011)(478600001)(83380400001)(956004)(8936002)(66556008)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QzlpYktOaXJjRlc1Q054bW9la1NJVUxjWDh2bmpsbytuVjBvYWZ0UXo4Zm92?=
 =?utf-8?B?d0RLVjhHN2ozaklzNkk2cGdlVUlvUlhUbzMwWWVTT085Z3luUHVVeG5DMnRz?=
 =?utf-8?B?ak5MeGVmanZyejhtMDJvZit6OG5UeFRQdmVYVDRjTTluVHFDK04xaGlOdzd5?=
 =?utf-8?B?ZlF1OW1oZG82QWordWk0Um1lejQ1S0F5MHFSdGFQWjRGN0ZTRlFLejRYSDEx?=
 =?utf-8?B?Q2pqdDcwQVVMYU5lejBxSkpZeitSMFIwYkRBdVp1NjNwSmRFSmFORjQ2Tno2?=
 =?utf-8?B?QXRESml4alF1T2t0eHF1eUpEamovQ1FZL0NJcGFTeTJyQzR6cTVaRjlOaEhV?=
 =?utf-8?B?SDY1YXJKVlFNNlJGZ0M5UkFFQ200dHdLMmVma0dQOUZGajZHaHFJZkNrWnlj?=
 =?utf-8?B?WHJRWGcrbmppYzNCU1ljbiswVmZrdFJVT0VIcWZ6MWxDa0UyZ21YZGtZK1By?=
 =?utf-8?B?bVY2N3JnSWc5ZGZFYzhIYlJKb2FhOVhqRHJCRFlZK0xDaDRiY1B5U3pUN2E0?=
 =?utf-8?B?LzhzTEtNUkdaZ1A5MGZ0ZUkvaUNQNXRiaXdVd3N5TU1TZE1rMXVBbGtaYkJ0?=
 =?utf-8?B?ZVlsQ3pjRmVmcVpSS05MNkk2NlI3eWk5Q1QyM0dPN3ZsK2YrSXNvUkRSV29Y?=
 =?utf-8?B?QlE1STZRMzZ4dWlXOWNzTWs4eFRjSFBRbnBtOFpZeGl1c2hORjlGT0RFem4z?=
 =?utf-8?B?a014TEtsK25DZ0tiblNveFdoY2c3UkpJRC81ZFh3SkN0ZGFvc0lCOVdQWHQ4?=
 =?utf-8?B?dlNHRVdrRDRqbmxGbVNtRjZIclUyVlpTWXhWMkdxTlBYL1RLWkRLTFZpQzFj?=
 =?utf-8?B?TFA5QmVNaThuang5NDMwOWsvOERDV1N6clBFMC85TXBraEZaR2syVVRsZjJ4?=
 =?utf-8?B?eEpBdWZSb3hraXhaQ2NrRTNvRlQzbHc3dWk2c0ZRTWJ4QkhqRzRyU0hKZzVk?=
 =?utf-8?B?dzNoWEdxdUhaSngzYms4Z0M5WVQ5cmlSNkRxYzlWdWdXWVQreDFIUVZvdVRP?=
 =?utf-8?B?TStCTzJxaUI3OHdqWGZaV1pZeDBtSjRHU1d4MUdwKzhjUStmRFZ5Sk1NQnNk?=
 =?utf-8?B?c1RXZm5XWXdjanJCdXJ2aGFkQ0QrK1RhMUptK2ZPeWRBQ2ovUGNMSXZLK1ZU?=
 =?utf-8?B?WENEOHdlK2NGbmF5SHQ1ais2NG5ha0pnS3hTTlZuV2tHN0xGdUlodVN2TFFr?=
 =?utf-8?B?UWU2Q2FUUDl3bENRcnF3dzcrU1A3WWZUa3ljUG5QTUExd2h6Mml0NjY0cHU4?=
 =?utf-8?B?VTNMRkplanFNNU9RamtvZmxGMVE2akZkREd5N0lHZXNUOGt3NmdGTjByb0Ru?=
 =?utf-8?B?d0M3aEcwS1J2eCtENUdVdHVjdWEzN21BU2pRWlBKcHgramJIc1ZWQUdNckNX?=
 =?utf-8?B?NDl3MTRITzlsbnNUT2pRWVM1M1RmZlozZDZYVnVDMnBaNEE3N0RUc01MNm9E?=
 =?utf-8?B?MVNQaGUrZUJTUWFnRVd4UlA2K3BCQzhUTVNhWHVqRmhzTnNkbGRsVnRVUGdT?=
 =?utf-8?B?dzNaT2F6ckhMVHArWFZ3NnRlYXR4b1VrdWw1cDJqNU05TGJEY0pCcUdheDYz?=
 =?utf-8?B?T011K0prYUhqMXhVeC9udGJPa1VZeVUwZ2t4ckFvMURiaVhITlI2UEl4TkEy?=
 =?utf-8?B?TnN2UmliM3pqRmdtQzJsYTRrNCtsT3drek1pU3VrZWFxeXBHK0JxRU5UbzFW?=
 =?utf-8?B?UFNLQ295aHUxM0JrK1pQKzRrTmdOUElTYjN2Und0bThGaGY0UTlCb2tpMFBu?=
 =?utf-8?Q?QDE4OZigbWMZztCo843ZvYExGV07/WMaWa3NT4h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9dc026-c8a1-4066-d3ae-08d8fea4e669
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:52:26.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnoNCUadZVtuFrdqvLKZ8u7L2lcCQaffy1Jt0YCV98ZGoyytEoTI6od+ERNvqVIjoLLi+WhD1W2FLr+pVaC/PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4559
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130120
X-Proofpoint-GUID: UyxQk31d15SvI77aYaZbdfPfTHmf7GW5
X-Proofpoint-ORIG-GUID: UyxQk31d15SvI77aYaZbdfPfTHmf7GW5
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 3:47 AM, Oscar Salvador wrote:
> Currently, isolate_migratepages_{range,block} and their callers use
> a pfn == 0 vs pfn != 0 scheme to let the caller know whether there was
> any error during isolation.
> This does not work as soon as we need to start reporting different error
> codes and make sure we pass them down the chain, so they are properly
> interpreted by functions like e.g: alloc_contig_range.
> 
> Let us rework isolate_migratepages_{range,block} so we can report error
> codes.
> Since isolate_migratepages_block will stop returning the next pfn to be
> scanned, we reuse the cc->migrate_pfn field to keep track of that.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
