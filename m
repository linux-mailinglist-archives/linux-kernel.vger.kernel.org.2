Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B121634F6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhCaCjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:39:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58818 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCaCiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:38:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V2UiQw162232;
        Wed, 31 Mar 2021 02:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=u3k8rY7fQQ9EL/pv0i5A8ViBRLw8qK4N7ek2wfRDoPw=;
 b=HX+a4Pnxwg2iGmO/WwBE0SAzF7ZVZQEmRvDXPJ1DPJAp4kV2/6811CvzF3PN6b9e5gfj
 flCerrRUTJyOC+tFsdnYMav4HDRdCh2/gxSkFq2vbfaIc7eiuyYoPkOaDIcEfpfG2/8m
 GlaMckj1IByumo4rYg7mPHa/o1mlaTZDg45UCh6r5jWK2IbBpOWFBHQUhhB/Rg+IV6WO
 8bIqrpOaQesq452S6qs1ecmG2zxlTW0ilnIitUL8BdYjCs+T170E5wXdEYQgYmS8S4BE
 qAVZS58MM6lG1UwRHNoe4GN1lJ9wSM+ghRwmHquH6ImehxtGNhFk7G5orAqcQkkR4cre Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37mab3gq4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 02:37:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V2Zb5T126010;
        Wed, 31 Mar 2021 02:37:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3030.oracle.com with ESMTP id 37mabnt9qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 02:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny6zzLWoB4x060mvrha7SKjsNgz+6nOejn3oRxUY/UQQP6gUzBiHuqTwOpM1TFVDBZbrA3EjbLx1F3TQzCjbxAFHwNU2cT2fXGqq2SOAzuw4eYMJPRrCng43ygU4/d2b/bSn9fPFbtyN9km12wD+0YmqJ2PlaLkXD3K55TLloJwzaQ6h0gPboeBjFPFGcLco9hkSbC4fiMUjEi64iJiJmkLjkqdKihbvtElYZYlBEf9s/sWu+WmExhUkIG+JBEVUSE0ZxTNFO7UngQab/rk5KK/DkVSekgE74kXrzyWTIdGBJTTD3/o3AUAC2BxdrWL2GpxpHODM902N4UyKGlYLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3k8rY7fQQ9EL/pv0i5A8ViBRLw8qK4N7ek2wfRDoPw=;
 b=WVqmhRZuITMi43bhsVpe2AmWyRnmiHSl3jq0uuKTw/DXzjg47BN9Sftv1oVwlZKtDuDlmd+YFLZHkYlJMmaVRLbJ1DLHsXO64MzQ/rOyoBniEjDLhehqdwwHpYeWG3nCwK4lpKMo1WC5IM4WC13qLibOgZ+qcEwoE+0WrVPY6ewm/YNuBhUwxn3bWcCThMCAnr0EKYoi2GFaNuCtBmLgIwwlBx/UotFisjcVJshq9uJuhdALU0jalIzsBex8LUkUctv7Z2ve80fvWOijZ8I2IEnYYKSUu/G0Qw6FjQ/xwd+QlSxbkPs8+fBxmmwItp+HL4ACyE1m8aRFx6VzDYe6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3k8rY7fQQ9EL/pv0i5A8ViBRLw8qK4N7ek2wfRDoPw=;
 b=LwuV+M3cKpj8taiM9rSAskZndk2LpxVjRdweL4ghNVVVzdphazjRcI94O/LtEcf6suRwlGi6zXa44kT2qEVZgrKsaXfPSWvC74462ungFdD8Tkb0kD6eORCw8gc58WYUwgfwqTuZS5MMXihJH1ISYlJZa5BjLRwUxS4QXvAumDU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3907.namprd10.prod.outlook.com (2603:10b6:a03:1fc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Wed, 31 Mar
 2021 02:37:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 02:37:43 +0000
Subject: Re: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-2-mike.kravetz@oracle.com>
 <YGLayMqYOrMMQ841@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fc2adcf6-f266-69d0-cd78-47cb44b78da6@oracle.com>
Date:   Tue, 30 Mar 2021 19:37:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YGLayMqYOrMMQ841@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:303:b8::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0181.namprd03.prod.outlook.com (2603:10b6:303:b8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 31 Mar 2021 02:37:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de521bf1-df58-4327-ee87-08d8f3edf5d7
X-MS-TrafficTypeDiagnostic: BY5PR10MB3907:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3907DB9A51C307A39B23A876E27C9@BY5PR10MB3907.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7dYGoKWYvGAR9mzelnZP6lhBAwrvvWroLc0Y6jw1WW/QxtsVZvOL1JvSkN/ngrdIL4+mUnHLk800n3Eq7MktpZ4JzJBo3u5EIkGm3yC2MTHLvfyvd27HRxQbzZZ68IXU1VUF8yYqzh4W05fbbT1qQAd/dKTH9ctgo+9knBDWqvX0HJrOMK1OJ6eSyVCLsr4Ua/HrXEBZ1noHIot4jImSwB03iZF6VuyShqNVW+kr7GhFWsUo5xXQZvcrzNS4fFx//egAz8rxR3iZ7eokzj6Qrbp7jCFD7tWf5r1bEZRq42kNtKccKRj/bIru3MVhGRpM7ExOX3B9BPfZGL85/y7lYSE+LbPg7iAzw/ezjJ9Y8Q3mkPkhCkK/51UTDd9P03jJJ9ihyt75dKd1hOx5TpSZvfeyHl7yY5UKjyknflb4EMrLBagICVRXEw6pNDvaeM4O5dOirM8URm+4JvIcr5j/j/n14UgwgEibsSAqhOfx6XzAyg0rzueCeuoSEGtxIOYkA7DlC7mU4/srIrx8Lux9nAAMjuCgiRwoezfply+zBPfhV89lanRgwc3JqD35GGIYvy31zLrH5FI5OZA1OrXS6ohgPKjnNqiEl0DEBGc++65s2IvlHk82bDWUOtBktStAEDpdDtwjnKXtJNWmmfCwV+PiBN/FXbACIzrXjutFAD0ytfDlkIx0F8+jKpBMBB2Hd4feNf4H7GptT0qQx+ekg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(396003)(39860400002)(5660300002)(66476007)(6916009)(38100700001)(8936002)(316002)(54906003)(4326008)(16576012)(478600001)(66556008)(7416002)(66946007)(8676002)(53546011)(52116002)(6486002)(83380400001)(36756003)(956004)(31686004)(2616005)(26005)(44832011)(86362001)(16526019)(6666004)(2906002)(31696002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGJRVlFaUGYvOTlrZ2htL2twb1ZzTHVNSlQ3UGJaZzFEWCtGY1VDbDVxY0Za?=
 =?utf-8?B?aGNqWCtpalFXalBJUlhuYnpybWNrSFcrVmdzb2wwRndwd3lFNUxSNmhOTGFx?=
 =?utf-8?B?ZWJpLzNiRGlLU2VtNm9OeXVCNHlxQlYzWmtEekRaQTE4bmluTHExS2wyOWhz?=
 =?utf-8?B?WmdhS0xVazgxS0xNWEEzSDJXR3lPWFV6RGRRd04ybnkzU3ZGM0VpdHlmVkRz?=
 =?utf-8?B?c1lidEwrMjg5WFRRSVdSTXpmd0sySUFqbCtUbzYzWVlHRmpnbVVlSGhpZmFF?=
 =?utf-8?B?dlZZd2V4M2R6NUF4MVpBUXlCLzRGbEd3bklGL1ZuS0lxektLTUdNMTdvWFhJ?=
 =?utf-8?B?MkFiSjNBQ1hwZjVLYnJtZ0RhNHdYd2dsL2dRQmhCUDY5T3dnaWt3Sm9tVFkv?=
 =?utf-8?B?T2RyWDRscDQxYmxSM1FBd2orWmJ1T2gvc2RzZ1MrVUJoekRKbEdiYkhrMFox?=
 =?utf-8?B?NjhpTEpqdnRFT1FYQVJXMFZWeVI1cHFleFJXTzU3M0pwYVVWMnUyZUU5aEgv?=
 =?utf-8?B?T3BSSXB3ODRTRWZUMHlhZFlyRWxHT3NDcUFnSCtvZDUzOHRoVDZQdnVjLytF?=
 =?utf-8?B?Wm5TQ1JoRWN2SWhkRE8xL2ZzTDZpQThlaVJ6UmtWeVRHSHdpUW95bU53N2c5?=
 =?utf-8?B?eS9pS05VTTlNcXlaM2s4cGhxZTAyM0VyeTN4bUQxQUd2djRHUmZQZGU2NUN5?=
 =?utf-8?B?VXVZb1lTTGZpdEJXUnJNZ3VLbDlEQWZOckRLVXFZRkd6RjVtaEo4dEV2UXo5?=
 =?utf-8?B?QTQ0WmtlS2QyY2k1aGx4YWdTQlNxYUJKRFM0UDNkeTYveG9pMlJnYVBOSElN?=
 =?utf-8?B?UityK0IvcnNxeVJJeGhJZEdCQ3pJakloR3AvYWVubmVldHZ0QnFDaWw1NHZ1?=
 =?utf-8?B?ZE84QUZsY29oWmtuNkpVOGFKbENYc0drd0FkemliS21SSVZIRkRwRnFweWtw?=
 =?utf-8?B?MkMvZms4VW1DZGhtWXZWOWVUWTFJbTI2OVM3dTlPMkxUQ0w2amtya280SmxC?=
 =?utf-8?B?M3NFd2xGeHowd3YrbEh6R2hTSVoxdkZ3dDVPendWV2lFSGo0Qjg4ZTlqOEdO?=
 =?utf-8?B?Z3E2c2VIR2NPSVJiWEtTYnpIazY1N1gvbzFzNHRaWWpIV2VuUm1OVUw5aVBG?=
 =?utf-8?B?OElPY0FsbVVmeWt6dlcvOW0wYW1GdlhYbTEydkpTRjFVbG0yeUVNUGZjckRB?=
 =?utf-8?B?V2o2czREYVJMRzlYYUxRQXhFN21uVlF3RXc2L2FhcE83anhBSTQxMkRySVZ5?=
 =?utf-8?B?aEIzVGdBK2tXVDk5N2pkNUF2ZzdTMHg0SjA1TTM4SWgwbWNXS0NMcEI1YUxI?=
 =?utf-8?B?eDlRNGdkMDhveWFubXh0Ty9INWZMM2UzYXBoZFRJSjhLbjJpckJwakVXUlBo?=
 =?utf-8?B?czJRMHlEMGw3R3lYYUVHcDI0dDlxYkFaN3hoYnVqWWdQcjVSUlZIamZRc3Rj?=
 =?utf-8?B?OUVoTWZkbUQvS1JoUElEcnpqZy9uaWVVZ1IzQk1teVFXQ3JXclpLRldqK3hk?=
 =?utf-8?B?ZFpES0poMlorZEpvT1hCNTN6S2hQcFp4aVBKbFFMU0ExNWN0KzJzYTZFUExT?=
 =?utf-8?B?bzdMbGN3QVo1Mm9ENlpFWWdlVXdSOHM0ZDg4a0VYVnZob24wNWxoNkxVQUVG?=
 =?utf-8?B?T3NWUmRNN2V2ZTZiUXQvMzRLYWFIR3ZwZ1Q1cGt3aytzaFRiUXhyVEhRVWZz?=
 =?utf-8?B?TzZDTHpFOU9BSnVvRVVZOGRUUi9pc3J6Wno4T3NnZDBPSlk5NDdPdW5BSGww?=
 =?utf-8?Q?7eWHnU2855HqOkxr+6L0hfmMpcx08JQTNue3ih6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de521bf1-df58-4327-ee87-08d8f3edf5d7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 02:37:43.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVhbRICwD0WX2md2BafNB5xfekSkBwcoadg/jR5tbSYkmwUBkg6wcbYBAk0CkYGfuff88iHA+JHfxMVeAInKGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3907
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310018
X-Proofpoint-ORIG-GUID: wbKgShOQzBtTFt3LMNY__d5yJ_Fvj6IK
X-Proofpoint-GUID: wbKgShOQzBtTFt3LMNY__d5yJ_Fvj6IK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 1:01 AM, Michal Hocko wrote:
> On Mon 29-03-21 16:23:55, Mike Kravetz wrote:
>> Ideally, cma_release could be called from any context.  However, that is
>> not possible because a mutex is used to protect the per-area bitmap.
>> Change the bitmap to an irq safe spinlock.
> 
> I would phrase the changelog slightly differerent
> "
> cma_release is currently a sleepable operatation because the bitmap
> manipulation is protected by cma->lock mutex. Hugetlb code which relies
> on cma_release for CMA backed (giga) hugetlb pages, however, needs to be
> irq safe.
> 
> The lock doesn't protect any sleepable operation so it can be changed to
> a (irq aware) spin lock. The bitmap processing should be quite fast in
> typical case but if cma sizes grow to TB then we will likely need to
> replace the lock by a more optimized bitmap implementation.
> "

That is better.  Thank you.

> 
> it seems that you are overusing irqsave variants even from context which
> are never called from the IRQ context so they do not need storing flags.
> 
> [...]

Yes.

>> @@ -391,8 +391,9 @@ static void cma_debug_show_areas(struct cma *cma)
>>  	unsigned long start = 0;
>>  	unsigned long nr_part, nr_total = 0;
>>  	unsigned long nbits = cma_bitmap_maxno(cma);
>> +	unsigned long flags;
>>  
>> -	mutex_lock(&cma->lock);
>> +	spin_lock_irqsave(&cma->lock, flags);
> 
> spin_lock_irq should be sufficient. This is only called from the
> allocation context and that is never called from IRQ context.
> 

I will change this and those below.

Thanks for your continued reviews and patience.
-- 
Mike Kravetz
