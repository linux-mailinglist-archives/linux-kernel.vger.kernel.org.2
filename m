Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2E349D06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhCYXuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 19:50:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38068 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhCYXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:50:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNeU7s183230;
        Thu, 25 Mar 2021 23:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EjxEqp2bvq75uq5VJx5ewZSJ30OfcNuzuAP4U9YlJpQ=;
 b=TEtSZ3zcRHZZdSLBhowuTQb6lAv3GOaTGzPeV8MnHU9YNYKOd7NvzCO/HZjkDCsLchuw
 tg2NcXkIBRhFFVakd543ani2NT22yrurDp7MGN+XXNL0tMmJl1uSE4+aPquxCNsYcbsD
 POvylHHNnzYSbw7LRCqL2bbD0KmqExoVnUA6BSynCFB4JzfXB4lBpf45CLhPZ3vNuQp5
 +3KIiXSsR9OLD6vVCxlKnRXEURtlaOxhsYARsbKZGs8LY4klAxL7R8STIWcXsFCck2O4
 ARu/4FIXaCj+Hb/em4sQV7ehyDBd0n77tuYevaq7x6hzKVvSjq6BSJVOQ7iBzlXvnHrr dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37h13e8ff5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 23:49:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNj60g012377;
        Thu, 25 Mar 2021 23:49:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 37h13wxtp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 23:49:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMznOfK3ldzojbRKgBeqL55ERyL6h4VoeeIjKPzMk3PkBVRO+LrOFdh7bRCkXMwRfwRX6ATL9KGn0GIL2HGm7M9JDaN/IAgAT/JpuxGnHGB5XywGwbMn33/TtVFxxruiux0I1MkGkbDS0jPgz8OEeV6oe5pl0/hLwN85yv3bh0i7YvltPCzRdxiQk7nBZxvy7XEt5VxJxwQIcypTk/C8y95e8D7/93M3LIr7Ptbbd6p8M7pqfGv1mxdGGxnENgpyUSqOd0JhCqb56UFICF0h7DQxeK9QyGUdmx4hkAck/EwKQH6kgFcfebvwPc5g8VRiiag1pMEFFrkkdcbszOOZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjxEqp2bvq75uq5VJx5ewZSJ30OfcNuzuAP4U9YlJpQ=;
 b=irl1/Ek40QM28725F+v6BSNQtIS7+1nrHYTmOk2nqn+oT1GJXY7b7jjo9ichbQgxFf931QKZtcbBczAKoSzMCyDDj4X9bRZeuLBdpylutVWENGxdm5ne12/iZka0zSKNGqOKfnpOvux0jdutqtTVTo7UwXKMJek/2FArkc9tzSrgncleRVt3WAtcE1THpNeRuLjkN6XZi6tkHAOgaElOHmfhws+bwoMuYBVJ/7An9F5pU7uQX9meT0tf8d77JavY4guENtPdDk5o7J8PUWBNU3Uld7Tkv+NTyk9z8kwbIDQPfDeyQJTnvIW+u8UpRKeFfm2AcKW0lA/fxZURj6g2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjxEqp2bvq75uq5VJx5ewZSJ30OfcNuzuAP4U9YlJpQ=;
 b=zBC1faGDnWy4Wbi+zsRChxW2dV1oDfwvEdBdK7JRaExYYwYKyScuOD7DN63KxgdaherYGrM3qrxFJH4fIYbNOEYoQJpvIFesPeVkXW1RM/1MZ5mxdhLB11G2/1ELRTZteZDwz0DfL+WBcb9shLWrqwDAf6aWYu7u7v+QqCl9NdA=
Authentication-Results: lge.com; dkim=none (message not signed)
 header.d=none;lge.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3687.namprd10.prod.outlook.com (2603:10b6:a03:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 25 Mar
 2021 23:49:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:49:48 +0000
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
To:     Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
 <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
 <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
 <4bc3c5d8-f1a7-6439-8fee-582364a7c021@redhat.com>
 <YFzuw0S5S/aG7nVk@google.com> <YF0agS53iGkFo41Y@carbon.DHCP.thefacebook.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d1e712f3-c2f2-dcad-85c0-dc152bb8eecb@oracle.com>
Date:   Thu, 25 Mar 2021 16:49:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YF0agS53iGkFo41Y@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0292.namprd03.prod.outlook.com (2603:10b6:303:b5::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 23:49:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3781d9-4272-4837-f1cf-08d8efe8ac6e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3687:
X-Microsoft-Antispam-PRVS: <BYAPR10MB36877EF1CF109C4A55440A5BE2629@BYAPR10MB3687.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KSXAA5zDzg++6y7cjlJclABgcDBAeNEsH+HSmwgWHj2MqpSHha9Ie1iWO4M7TwG368b5vBE39Q5MJ83UGBqUy45uUaeR+2hFOBnn6oLcMLcA7uEPlEzs5YtIqMBGYmLMzG8khlZNL01P35hf01mSx+DJBgFOYF8GFZAHSm3+DoeTNm3bewxw9BHn2KJoM+lS2Sq0hon3Huop9NWbjbIbZuVUBp96p6v3COUcg13MLp0ewIvCtm/+fEwe5gSNWsBoolIsjTW/2zD6Ro97SjM+ro/BCYMeR3AsFc49D5hSW6w7NX74afkb6Vrm5TiAKtYIt6k9GK7SQxR8Ebednb0W16lFDIk2dJk3xaf/AV5oJP4x6R3PcRbCWTnQRuYXAZdCQMDjBJ7a3UgNO17Dr4ZAXPNz6JPdEWpYxetuHDaCaV07kC0MAVde57hTDUiFih45Sy4hsSNqvPzWNUDip7IUhlJM5CU+mHT5Oppr9gNT1V/5msOQni7fH4/aQIAXtueD1N7r/9CbGaXjQbtRDRaoeTC2KvZcE8qqcAOWS0F1cxCQP2FLKy6F1Fy65EHSZiz/Kuokb32nleiUkPCIArjYBXThtZTolfj6+GOpOoT/Ywlzm1jbFfImXsbMtyxJeCpNvWYT9LLOpS3OdL2ccJQMYCuEH7ThlpK0gXSUFDr5TXimdWLOJbljW5V1K+rqMxd8vIkiOFHjozsesWaswWqbech3EMnuwCjLvkcLHMr8LAWVaN6okpfSDhXOZzWwx1o4A6m+x4hYrvsAnP7vmLiGISaPQFHjcfXI+eHQL+lqDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(6486002)(966005)(31696002)(478600001)(4326008)(38100700001)(31686004)(316002)(956004)(2616005)(16576012)(8936002)(53546011)(110136005)(26005)(86362001)(36756003)(66476007)(66946007)(44832011)(8676002)(5660300002)(66556008)(54906003)(2906002)(83380400001)(186003)(52116002)(16526019)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?emZLK1ZGdWZFVUpnK0pkNk5EejZaL1M3azExclRpQUJWbm9WMjNjSlVTV2di?=
 =?utf-8?B?RStHem5jcjR3bXNwS1o2RFBTbUtqSkF3dmhOR29mbERoZytPclA1RW83aUJY?=
 =?utf-8?B?UTVWeHltM3E1SzhzeWh5NnVaRkRLbkhkZmlCTmMxWkNzT0UvSkRqQ3paRG5E?=
 =?utf-8?B?YU0rTm16RmNFaWw3UWN1RjNneFMyMUM5T2dZV3M0WmFlWmw5eVRHdGVubFgr?=
 =?utf-8?B?di9uY3hUZHFEUWNOcXludzJzcml5TlYwODNIcnVnekNHUnIxcGI5Q3RrMm1l?=
 =?utf-8?B?M3FiNzlqS1hiVWdKYzROankyM1NobHFDYnBIOUMvODZWeWQ3SUdDVzlKMUhI?=
 =?utf-8?B?dWJidEdZRDhBbDViSzljbVZqbHBMWmtic0k3dlQ4R3RPMTE5TGZLNXhYWmd6?=
 =?utf-8?B?T2E1TzJmWUViSzg0ZU43K3Nyb3NYVUc3NFpucjRiaHY2VDdaZ3dhTzhvenhq?=
 =?utf-8?B?TGtWZXB4WkY5T0xSajFuQXorNmxiVTlYcy9CM0NyWVBhTXVrR3lvUVdkTld2?=
 =?utf-8?B?YTdpSXZUdDlZRk5wNmFrcmZsMUJjS3R0M3V3a1dQcDgvWW85c2ZHQ0dvdGZ5?=
 =?utf-8?B?STVaSEQ5bmQ2S29lWHU4UE40UFZQc1h0OXNJTnFWMXYwdVNPWFlDM1loaVFN?=
 =?utf-8?B?K1ZTVWdlRVB4RTQ0K29yNTBFTEt3MkQzOWNZRDZtUnF1OHFReHk3T2kxdEtB?=
 =?utf-8?B?dGdBa2RHTlAwSmFOZG5DemNuUjE4aU54M2JUVmM0NzZTTGczeTMzZW9jS1NH?=
 =?utf-8?B?N2s2SkpES1IxamNzTldFVitPRGhVWUVFcndXWlBoamdZRStwenJ4bFQxVkh6?=
 =?utf-8?B?ZlVTTE9ibEc0djRkeEIzbkc2dUFqUlErQXg3eDRubmJTZUVzVXhyTlkyQ1hJ?=
 =?utf-8?B?YWxoL3pmVnRIdjJrajliWU9VSERDQVYwRXREMytBdzhCYUZVMHZ1V0F3Uis0?=
 =?utf-8?B?TStEMU9NNXdKbElpUHQ0Z1pNWkxTaE9WQlhrQ090QkppWS9ldzFRV0d5Vllj?=
 =?utf-8?B?RSs4cDgxcVowbENNUVdTSWlYZVJ2YjVsbVdJemNDVjVwSFdqcnZyYUpyM3hj?=
 =?utf-8?B?QTgvWEN4VzNTMjRHSlJuOFdpL3JQYUJRd2xsNGFheVgyMmVJM0M3ZDhpN2Rw?=
 =?utf-8?B?NDZCckV0djdzK2QxY0srbE5HTWVCY1psbkdTSEJtYkk5cFpGOCtJNit0c0ha?=
 =?utf-8?B?djBsOUI5RUo5M2dWUTh2cE5PT0pZcXFuVFNNMDVnUWNkVFA5dFNsa0cyWk05?=
 =?utf-8?B?STk2Q2VWVWhkOThnTUFXbHNMSGFFVWlGZzJobjYwTHFjbmhsRGxxRUZLcXRJ?=
 =?utf-8?B?Y1dZeDFWZE9qN0RJMmJzU1ppRFhEY1BHVXJ6SDFjQWM0WUxBM2p5Yzk4UVRH?=
 =?utf-8?B?bG51TVcyd3N0djhDdENnUWdMUk1RTnFncDNYQThpbEpVUDg4MTFKMFdhNVAv?=
 =?utf-8?B?L2NELzc1M3JRQkZCb2JSUlAvRWRpWWRMVFZoNGR5SHc1QmFCaGYvVnF4YlhE?=
 =?utf-8?B?Z3I4akZ3UlZGNUNmVlVFY21pdmlFdkZ0ZTUzUHhYckZlQVNPOWpMbW5oY1p3?=
 =?utf-8?B?WjhSSFRFd1VoUGMzdHUrNHl1Um84WGRLajlqMmRYQjdnam5nZEV2WHluaEpX?=
 =?utf-8?B?VU1BcXhaSU5LQ2kvbEUzR1NJWXNQblowRFduU09mdnpUYStaK3kxTGJzcnNy?=
 =?utf-8?B?RmZDckJUOXZPZkh6TGgzWitDTjlYNEFZSXdVaWJ2VCtoZjBkUUk2MWRNZTc5?=
 =?utf-8?Q?j/MMKWVukkbiHShwP1w3N/aO3lS/Pdrdop3eEid?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3781d9-4272-4837-f1cf-08d8efe8ac6e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:49:48.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDwq990ufAvylRjWyshYdoA2m+f6WpUMjfE+gBlvQlhpDQEYyn0nVdON8dW9EMjbamdOaSPQPpiSGIxyNKgVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250177
X-Proofpoint-ORIG-GUID: 6eQ-AL0a4AnG0Vu3v_c5XvrqBlyocXvb
X-Proofpoint-GUID: 6eQ-AL0a4AnG0Vu3v_c5XvrqBlyocXvb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 4:19 PM, Roman Gushchin wrote:
> On Thu, Mar 25, 2021 at 01:12:51PM -0700, Minchan Kim wrote:
>> On Thu, Mar 25, 2021 at 06:15:11PM +0100, David Hildenbrand wrote:
>>> On 25.03.21 17:56, Mike Kravetz wrote:
>>>> On 3/25/21 3:22 AM, Michal Hocko wrote:
>>>>> On Thu 25-03-21 10:56:38, David Hildenbrand wrote:
>>>>>> On 25.03.21 01:28, Mike Kravetz wrote:
>>>>>>> From: Roman Gushchin <guro@fb.com>
>>>>>>>
>>>>>>> cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
>>>>>>> It makes it a blocking function, which complicates its usage from
>>>>>>> non-blocking contexts. For instance, hugetlbfs code is temporarily
>>>>>>> dropping the hugetlb_lock spinlock to call cma_release().
>>>>>>>
>>>>>>> This patch introduces a non-blocking cma_release_nowait(), which
>>>>>>> postpones the cma bitmap clearance. It's done later from a work
>>>>>>> context. The first page in the cma allocation is used to store
>>>>>>> the work struct. Because CMA allocations and de-allocations are
>>>>>>> usually not that frequent, a single global workqueue is used.
>>>>>>>
>>>>>>> To make sure that subsequent cma_alloc() call will pass, cma_alloc()
>>>>>>> flushes the cma_release_wq workqueue. To avoid a performance
>>>>>>> regression in the case when only cma_release() is used, gate it
>>>>>>> by a per-cma area flag, which is set by the first call
>>>>>>> of cma_release_nowait().
>>>>>>>
>>>>>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>>>>>> [mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
>>>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>>>> ---
>>>>>>
>>>>>>
>>>>>> 1. Is there a real reason this is a mutex and not a spin lock? It seems to
>>>>>> only protect the bitmap. Are bitmaps that huge that we spend a significant
>>>>>> amount of time in there?
>>>>>
>>>>> Good question. Looking at the code it doesn't seem that there is any
>>>>> blockable operation or any heavy lifting done under the lock.
>>>>> 7ee793a62fa8 ("cma: Remove potential deadlock situation") has introduced
>>>>> the lock and there was a simple bitmat protection back then. I suspect
>>>>> the patch just followed the cma_mutex lead and used the same type of the
>>>>> lock. cma_mutex used to protect alloc_contig_range which is sleepable.
>>>>>
>>>>> This all suggests that there is no real reason to use a sleepable lock
>>>>> at all and we do not need all this heavy lifting.
>>>>>
>>>>
>>>> When Roman first proposed these patches, I brought up the same issue:
>>>>
>>>> https://lore.kernel.org/linux-mm/20201022023352.GC300658@carbon.dhcp.thefacebook.com/
>>>>
>>>> Previously, Roman proposed replacing the mutex with a spinlock but
>>>> Joonsoo was opposed.
>>>>
>>>> Adding Joonsoo on Cc:
>>>>
>>>
>>> There has to be a good reason not to. And if there is a good reason,
>>> lockless clearing might be one feasible alternative.
>>
>> I also don't think nowait variant is good idea. If the scanning of
>> bitmap is *really* significant, it might be signal that we need to
>> introduce different technique or data structure not bitmap rather
>> than a new API variant.
> 
> I'd also prefer to just replace the mutex with a spinlock rather than fiddling
> with a delayed release.
> 

I hope Joonsoo or someone else brings up specific concerns.  I do not
know enough about all CMA use cases.  Certainly, in this specific use
case converting to a spinlock would not be an issue.  Do note that we
would want to convert to an irq safe spinlock and disable irqs if that
makes any difference in the discussion.
-- 
Mike Kravetz
