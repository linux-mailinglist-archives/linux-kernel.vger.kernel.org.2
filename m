Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B334DBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhC2Wcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:32:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37856 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhC2W23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:28:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TMPJth151286;
        Mon, 29 Mar 2021 22:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rGNxmNnySVmyk3DpSDGWux0DuhO9H2Vq/bdkO9krqPY=;
 b=Dsuv7cqO2+FjNi0nHjOXjYlAO4LfvU3sg+oIUDrnQK4z7b/a2KgmCoHrSmK6mxGETPES
 OL+f1aYbjaUUz5KKZFR8WQLcUkN5GJA8jGcQDKj8Tdoopos2Z3I9jnsNLhgxsKhv+87H
 DHAg38HNbJaz0my4XsQvtkyBRXHxeWlbJTYyCvAg4iGwUXtlMPsyBQGYQv3GG+32KcEx
 eYCCwaL0T7kXRGzeIsW7+C9zvXtCj2iPFtC51I4FT94o/dxiG/ZuVTRAZ6AsTTNGgenb
 DDszJ1Qwnc6qBxNQgFO8CXz/K/fxxNONkd687XPZqHGMZu2DxRssAwKwZNywItyMfdnY dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37hv4r55a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 22:27:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TMPP88132767;
        Mon, 29 Mar 2021 22:27:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 37jemwavh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 22:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg7z72DhL1oz5ZGE1IKbyaNib76lY3l9YgkKe4opaA8t8uXOnK0hT160YbxC2aQ2D1lsxfspdsSASvkJLLlMjTlKhktj9FI9lLE3eoZfZX6Y3UuRn46S3taDoBcdk/v+kaDjGMoUvLxjEIF7i0pA2hp3Snb8ftKf0G2bLpcoICIcz7vk4NjPMQwod+Mqs/lAb3vOQj0yUHQk4P6ZxSyaLfwCXidasZ1VxTWzUbBGirFj19W8peudbVUr7vEV8dsdsB+sDFuyaaMv4XoR5du+Wekw8get5mN7pflJo1rUw+ocZerIEH+UhjF7vhNQ0PyB1LjeMyrHFBagWqgbXMKE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGNxmNnySVmyk3DpSDGWux0DuhO9H2Vq/bdkO9krqPY=;
 b=j1cnUXaQF9XPu/rRsLApO/91vGlkNNOk4ryLUpIdW3APWizcHlL21c11/6bSLBTK4mhKJ5rugrBFTOYtNzSYOVtypTqCxYEprRyvNgqaWqEkQG/p5DYh8UAsiYLb4SBKVarQt1uwIPjoRUEnY0drAFica53nGQtLesgZQbtlZBcKU15Rjt6tCwhfRyAuhUoOGeoTS1UYIl2Gi0gNX5A7BPOz9J6888QKYJJb6QTsDuIXu5b5L0H2acjI5ja4DaWMISxcP7JBMYhGeTZdmI+f6euttyccUBzq3k9XNGrYv8L5DPlj6O8+4WtbJDYRMLcWtPGq6uf0G/MUz8Aml2vBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGNxmNnySVmyk3DpSDGWux0DuhO9H2Vq/bdkO9krqPY=;
 b=FHzpJZZh/hnqInQuzTRqvCOep9DL5YWXZq3CoHQmo1Gw9pJ1pxKVQtyLOEn4ioIFa2vAXKQN3MW5cDlx+uOiIqM1b7202prxgonTiACXXmHeBgMCDQU2S5uvXk2Smnc3MBpNOmMLVXGua5S9d5GN/g402y/dqLGdTZ7UO9dgpKw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3969.namprd10.prod.outlook.com (2603:10b6:a03:1f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 22:27:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 22:27:03 +0000
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
 <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
 <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
 <4bc3c5d8-f1a7-6439-8fee-582364a7c021@redhat.com>
 <YFzuw0S5S/aG7nVk@google.com> <YF0agS53iGkFo41Y@carbon.DHCP.thefacebook.com>
 <d1e712f3-c2f2-dcad-85c0-dc152bb8eecb@oracle.com>
 <0f7f3c4e-530a-5cd2-2719-259e509366e4@oracle.com>
 <YGGF4tFogzETutOR@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0b2afe77-f7fb-4c44-2861-bdf4085fe9e8@oracle.com>
Date:   Mon, 29 Mar 2021 15:27:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YGGF4tFogzETutOR@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:104:4::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0173.namprd04.prod.outlook.com (2603:10b6:104:4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 22:27:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48b0bc7a-78b4-413c-5bfe-08d8f301c745
X-MS-TrafficTypeDiagnostic: BY5PR10MB3969:
X-Microsoft-Antispam-PRVS: <BY5PR10MB39698898139FEB81E694F22CE27E9@BY5PR10MB3969.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwFJfUA6hry1RPT42tS+9PFc7HcSGPvj7cCzfdpNZ9OiQZ6cr72+UUKejov2h9WeSDoqnFrFHgVcoEB7+hgw5KBkshD/uoBb3LzNfGMdrcvqiT7A01+trENZ+RmxjOJNF55rupvweCGIeRAQzDRcQehfQaaHaq8bgmbyuLgZjz7JXXdlgFzn1Nkye0Nz3am+s9jh1+NmA2jE8kvGHCQGAm9GMSROhnaHQqiw8cfc3roTUbWHRtV1hJiF5rdEVHnyBKt5S3X/xKMMBteMTk556iNdeAKs3rucsVFENPVHZJRcw3MxbYnjFUr4Cj9Yjchis5wyzHTYUZq7VYc3k7hjqix1PKm7jaYd4v2DroFnktWJBiKQGzM7c0gdrx2kNxYRwtTRGECNQcw+nCMudlrdMlbzti5GhFcj+rixmAVmWt7ylcGTAJXJbrw9cucVheuWd3TbMKcsH4FeIfOBNU+iSSaVUYuGvPKR4FwoFc4WTLiFgSM74P46hoIAFc4EUriOEvR6xb5zJwRGA3LphBQq6Q3Zn+dRgst/BoPjyEpMR7ZB1FT00qzzXw66uNNaLuXTDMrxprUv6QC0KPqjPMT6qte43tjOSL62czGneWuhce4iKMUvSIj7vBvj4q0IFYoeSEdTFw6ocr273XItjZ5nMSuAsGMksgLxrLf3wAQ8/MlNy/KsrNNg6npAbSQQBQ6PvXQwIwTZBtllF/LP8VurYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(39860400002)(346002)(478600001)(36756003)(86362001)(53546011)(66946007)(66556008)(2906002)(186003)(83380400001)(16526019)(31696002)(52116002)(66476007)(26005)(8676002)(956004)(8936002)(4326008)(7416002)(6916009)(31686004)(5660300002)(38100700001)(54906003)(16576012)(4744005)(44832011)(2616005)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDhudlUranpzblYxcnZzbmt0SUFHMnZtSnFzeVFRSmNzTXZTcmRVYjdjalM5?=
 =?utf-8?B?TXlsdFk4RlR3WE8vVmt3eVRVdzY2anErVWluQjVqVVdsZHF2TCtaTTZlaDFU?=
 =?utf-8?B?bUN2TkszY3dBRnNEblRJNDRCRHNLRmphR2RtZEpXVHpRSkMrZFFmZ2JKTjQ5?=
 =?utf-8?B?dzd5QVJLTjZzRTBFdXRNOGFYa29Zd0lFVml5Sy9hUUt5VjIwV29WVExhN2Nk?=
 =?utf-8?B?WHpkcDFST1BRUEtXWStyNEFSZm94eWhFQlN5N3FsRHh0U0NzaW5aS1ZkTFJs?=
 =?utf-8?B?aGRyNTFxeVZlRWhMQlliaUM1R3k5cTh4ZERDWFF1TGJlcDFWNlBoQkRIQk1N?=
 =?utf-8?B?RE5RTldiUnZ1akgxbjZpczQ5YzJiUkZLck9yVXpTbVBqaHpGVDhIUUpCSy9M?=
 =?utf-8?B?QjlVY3pFZTNuT24xVmM3b1gwbG1WbTFmdk9EY0VDTDl4RlJJd0ZBOVNHT0l3?=
 =?utf-8?B?bW9CMWx0YnpVOFhvZG5PZjlFdWFGSkhPb2pqdG5ZRmlYVFpUNGVreitlK1l0?=
 =?utf-8?B?RDZCbmZKSm1JQ2ZuQXRhRnRWN2ZoaE92cnIzS1dKYWk4VW9QZk82UlRFQ05T?=
 =?utf-8?B?clNWOGNBRGd4eDRjZlFtaG1ZMlZnOHdQZndoWDdtZEVWZ1dyVHZtRnNiVEFr?=
 =?utf-8?B?Vjd6REhVbVRPYm5WOUY2QlhFTzBIc1FQZDlZV2R0M0pobW0rZExMUFdLWVB1?=
 =?utf-8?B?RHRZcTVVeDRXbjc4enlSaStldFVvUVJPTm91R0R2Z2FCcmNkbDY0ZGxWTzYv?=
 =?utf-8?B?ZHI3ZkRwdkdrNittM2FnVlJMaFg0UFZYbC9pbkNFQzdYQ1BqRFMwMWM0WG0x?=
 =?utf-8?B?cDFQcGdCbnhYSE9Sdy9PczlNT1pVeWtERXh1clUwQ0o1aUcxQjB3RWE4Rmhj?=
 =?utf-8?B?RGIwZzFlMS9kTXVuaUhxeURVSENxczNnWnFwQVMzM1llQ3ZHamVYekM2TWhi?=
 =?utf-8?B?em9uRGJIWlVlb0NYUDNDd0pMVjNoWExKbGVtKy9VWi90OURoRGFWSkloOWo3?=
 =?utf-8?B?cG1PS0Joajg1VXBobHJSRXFYY1ROUGtkYlpmYTF6RDBsK3RrQTljTzA4VGFL?=
 =?utf-8?B?dXdxcDRSblBRanF1MDlhZFlzc3Y4TkYySENtWXpESU9LdkwvNHZLK0xiTlQ5?=
 =?utf-8?B?NjY5eUFXWVhmTnZqRFhib295TnpOZlU0QTRWaGk1YkpWNmdmVWlIQnNrOEx6?=
 =?utf-8?B?dm1XUkRHUWQzUjlFNGF3aVNUNitZVFFURlhGMDV5SGtPNk5xRk1ZTkw4aWJQ?=
 =?utf-8?B?RTI4MmthUFJYWUpVcmFrbFVuTmlwS0JsWjJxZ0JTNUlwN1A5NHNBOE5kWldq?=
 =?utf-8?B?eGR2ejNVeHNEb3ZvT0xyUjlUdnJHTm52R0lzbjRjQVVFMFBWV1RlYTVrWDVS?=
 =?utf-8?B?MUNNZ2RhRy9NeDNZdTc5czZOQzZKaENEbzNoVzY3ZXMxRGlpK0k4ZzdIM3hm?=
 =?utf-8?B?UEFwV21ZTWMzUEN1SmY1WVpBNEZlWDlpKzNmYmdId09NZFlGeHJINWwrSnB0?=
 =?utf-8?B?UStkZGhuRkg1NC9YU2FMZTFqaUIyMEZQWUJ1QjBSVC91dlc4TmY3UTZ2OWNR?=
 =?utf-8?B?dExGUG1sMkF6MTZqbW1idzMzcWJpVkdoaGMrRURWeUxqaXl0U1VOSWR0bkFz?=
 =?utf-8?B?cEtab3BQNnJTekhUSzRSSU9Rc1hnZE5Eak9GSmd4M2ZRSkJwTUJKQlNMMklN?=
 =?utf-8?B?ZllOb1JNRzJXSVBjNzB2V2xUMCtSazJ2c3ZXMjQ1Tml2L3Y4ZFNUeXI0aXcz?=
 =?utf-8?Q?TxsuhG/8NORSoIZ2zOSBvpNh+pyJz6zFgkKAGp/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b0bc7a-78b4-413c-5bfe-08d8f301c745
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 22:27:03.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCiUfiXJTZzMUDNmHXN+C7rsWlaAfeKH9vo/E3mvWipfK/yUjbQcj5ceS6qONboC4VnkjA5BPHahR9RxY34f4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3969
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290165
X-Proofpoint-ORIG-GUID: ngFU8G5LDpM2G5Zu7Ksop03D_Td8RYPg
X-Proofpoint-GUID: ngFU8G5LDpM2G5Zu7Ksop03D_Td8RYPg
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 12:46 AM, Michal Hocko wrote:
> On Fri 26-03-21 14:32:01, Mike Kravetz wrote:
> [...]
>> - Just change the mutex to an irq safe spinlock.
> 
> Yes please.
> 
>>   AFAICT, the potential
>>   downsides could be:
>>   - Interrupts disabled during long bitmap scans
> 
> How large those bitmaps are in practice?
> 
>>   - Wasted cpu cycles (spinning) if there is much contention on lock
>>   Both of these would be more of an issue on small/embedded systems. I
>>   took a quick look at the callers of cma_alloc/cma_release and nothing
>>   stood out that could lead to high degrees of contention.  However, I
>>   could have missed something.
> 
> If this is really a practical concern then we can try a more complex
> solution based on some data.
> 

Ok, I will send v2 with this approach.  Adding Barry and Will on Cc: as
they were involved in adding more cma use cases for dma on arm.

-- 
Mike Kravetz
