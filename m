Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5154C321B48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhBVPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:22:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57222 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhBVPPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MFAdlA156062;
        Mon, 22 Feb 2021 15:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PL49800XynB1ag+q4I5efdc0o9QPeM6LPA0FAfW9WhM=;
 b=TXDRru/mxaeJnUPHvA110P2WmdL0fpz0ShgErosn2EuIzt13Rp9F03DzJpizytqWbQ+G
 gz1E+vdhjul3FwrmhLnnqdBKSP6/mhm5RoXM3tZTzWpzqDLjupCrp1QIgGDxAIUe0B5p
 DKdDkd/hHauj1nctxim/XeYyI3tCm9PiH3/MaKoMOfECigKOckLYGfRRTMoWpeUUiUhl
 +guzT0nRFjcDQk6SFjty7W1yixkuWzhoB9dJ1JE71eWGdhRH/Z6BFLHdpCw4x/YhQ4BN
 7PMdczHR5/FFkc4ug2nhReq3yZmNKsYqp4NW41Q7669fO7AC2olk4392Ua9oXh2ZDS31 GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36ugq3atw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 15:13:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MFAA5K082831;
        Mon, 22 Feb 2021 15:13:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 36uc6qfrrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 15:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqTAJCzSklmVnvFcuQb5PGBMTbXgFkDgbnu6P/pFb/qvxFSaCezHsdoUUnZSlc30lgWK1e1mGd3kKd077sHKerhNgyW/a2V2eZ+FhbtBWo+UQs3W5C38RNuhdit70W+ryTQ2eOKT37hPFDqaQl2yhunBhFvPHO/ZgsSI41itLS1yt4hHt74MYlP5q09EMuLztjbKHI/5rFrgQzhfyvBtNdC4Ms4rX8D2IYFjyvdAt0uTOya9PWbhAOTTNfRu/xW9GXdP4HK8eJOqUxsQe6LN3TgVme0oS3X6BBWjw88Z95VhJLREtSRXUg/uff4xZfmLlCPZlXNG7MrYDPTsjPPhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL49800XynB1ag+q4I5efdc0o9QPeM6LPA0FAfW9WhM=;
 b=Mnsg4i0t2Lm2OUsKuLnyM7t3NAY+EdnUwnmxYY0cju8in1uTFzfelpU5xJLBevwhRmlbDouaH/kFkNz4M7Nu0hngSW2WODKJuHCsEh2cauVh+Zhae+HKYHchNME+LlV+mllO57RmRUWfCKXYQ2hSzJZmHJnGMWLxKPofvmCkG4/vUMuziUhUkp/gRASajU+jIvbA+z5N9RDh4OY7/YjoF0bdz7YW7VuveqlQmomf7nisBnDTRuvQMFWiYF3uzuusGwTRUOSRsuoW6Gv1XE6t8BwtHNDfqdtZeG+K0R6nT4bvaYbwSzlFzpZ/KFXo03fMCnKEL0OV3dbUMXH6ffHupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL49800XynB1ag+q4I5efdc0o9QPeM6LPA0FAfW9WhM=;
 b=hUPUcc76Y0UWXD4h3lBNiSg2SOSIl2eLmO9tYWM1Qx8wAZbauSNGE8ktqhV35tk7kAc3tY1C65fleIN8BkTMf+fKCS7UQ8StldsHsk2wiYivZzcjWhhZcqW6E/5339GDmcol4NFNepeCJgxVKildVDCeeaaw1ohAeGXHDECY9rk=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB2827.namprd10.prod.outlook.com (2603:10b6:5:6e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 15:13:30 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 15:13:30 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
 <d11bf144-669b-0fe1-4fa4-001a014db32a@oracle.com>
 <CAAeHK+y_SmP5yAeSM3Cp6V3WH9uj4737hDuVGA7U=xA42ek3Lw@mail.gmail.com>
 <c7166cae-bf89-8bdd-5849-72b5949fc6cc@oracle.com>
 <797fae72-e3ea-c0b0-036a-9283fa7f2317@oracle.com>
 <1ac78f02-d0af-c3ff-cc5e-72d6b074fc43@redhat.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <bd7510b5-d325-b516-81a8-fbdc81a27138@oracle.com>
Date:   Mon, 22 Feb 2021 10:13:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <1ac78f02-d0af-c3ff-cc5e-72d6b074fc43@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: CY4PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:903:102::28) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by CY4PR16CA0018.namprd16.prod.outlook.com (2603:10b6:903:102::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 15:13:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd2739f0-f04e-4703-8e79-08d8d744696e
X-MS-TrafficTypeDiagnostic: DM6PR10MB2827:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB282764A7A4DC9F366D773D7DE6819@DM6PR10MB2827.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkxBa8ptfutkt77k8WBYdgwWqjVLx+p8Rm2vbFHT9r2MdK5BmMJAD7XSrOKWFLUSFt7TchCwR371RnnQbjmVR4YYaba6y6qkVppZ9KCT4wyw9m1WC9hCeMNuL1JKmuRereTF+8xUj6tzThk67We4xGHbGl+EiWgu5U9C1/B9jLNgq5hAM8heU54w+942ZmIiubgAuKdJaOp4b+XuvwqHNgbz8O+pYI3y6JtytBiza9A6+Ami0QT1wOXHdoMJ2Mdi/tpFmuVehXKIxn6ux7J+J5APFGfaL3Tu18EXxcGAs4ZhKc0vhEvDaWQXPvjcOtKptB5xsxt8Jnv7E+WmWW3oD0DEwsFd1hc9P7itbwZ3F2Ngd4wOmxQNbs3hULDvsqfOlFAx75vRjAyi8G4QDxtsiZbU/RKQ16VTs8R7V+XHZXYHGEpPWKsaPWMDmFSeSxHqdHpVi/Wj2QOve5mcN+pKJGREmh+JU8xFTJb5v8sdcvjLedpjR78k/WVsMMx5H5d79e3Coy+6I9DeCjd4XdELhHxf0td58XgPOfZdeMSN/rMTVr9rd46SQr+BkYsDnXcBd3LUtN1iy2qLRm11R7mo2uj7EYVoyhKY1DRIEc9fTWelE967rSHI9bkrCvCf/AQ6ROf6qwLIGIH1ScGq1AH/eyL7gDIHEGQcl3aVMW2tuOe+IB5smVwmOTH5kjDQUejXJSfS/ZmPg5vT4mSYdbx3ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(7416002)(16526019)(186003)(44832011)(2616005)(53546011)(54906003)(26005)(2906002)(107886003)(956004)(110136005)(16576012)(6666004)(4326008)(6486002)(316002)(45080400002)(8936002)(86362001)(478600001)(83380400001)(36916002)(66476007)(31696002)(31686004)(8676002)(36756003)(66946007)(5660300002)(66556008)(966005)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGlKR25SQXF5TGk3NU5taDcraHQxYnZQU2FmWmJyNXhnS21UaStsNExHVFk0?=
 =?utf-8?B?T3YxVitnVjdaZHpQaENvRk9iZlZiZkVrQjMyL21iREZMT2NJblArdjBpMC9I?=
 =?utf-8?B?eWlvbyt3cThFZWdnbGRWUlBONm4ybm9oN1Z4UDBUTitTbG9TRnhDZkNWTXJC?=
 =?utf-8?B?RFpJYmNGcGdiTmh2aS9MTDhIaTRpMG1CRGhXV2RCWFhQV0pTMHllbFBjYTBH?=
 =?utf-8?B?SWwvZkNmUEdleUlyZ0JVTjRsMll4QkVWSHB2cTRSSjRGaGZJSW5jMzZNbzl6?=
 =?utf-8?B?NTVoRlovQUx0dnAyRGRlVllmRVFqa3NwcE1kTlRHNGRXRjFtYjdabmxWTFRB?=
 =?utf-8?B?VVcrS3dSUldrU3hlUE1EVnQ0Y3hKS0d1WkZ1Q21aZjBKMndiZ0x2VU1UdXNL?=
 =?utf-8?B?NUY4cUVKRXNLbzhjdlVJL0p5ZUJyZDFhZ0d5RXZxUGRYT05qeEd2N29xMjJ1?=
 =?utf-8?B?MWNLWHc0WDNqMFdEb0p5aGN2aUJYWHRLbE9zSlNaSFc2Sk82S2Qwem43Rkp6?=
 =?utf-8?B?b21KeU4ySHdRRXZkTWtUb3phV3FoUGdYOFVBeHd3cXZqSGVCaDZUYVk0T29o?=
 =?utf-8?B?MDZnZUIwMElXWFVXT05RWXhIb0YxdWNwTlNtTCtWcU9TVHZNN2dxOElOY01h?=
 =?utf-8?B?MUtFOTVycThISDIrcEhScnRYc1Q0c0dtZ3NhVk5DWUw1K3ZXS3VFemJ1Qjcr?=
 =?utf-8?B?WEtZYjNCWDFiQ1RuVnBKTFo3aDZGaFdoSnE5K01xa0FmQzB3MVFqVExiOEp0?=
 =?utf-8?B?WXZBSi9GT2lLcCtMcjlWa0RlOWtaRms5RUJZeUgvN2dmbWZMRVczSDZuVW5B?=
 =?utf-8?B?SnZUVFVlWlVSNEV3UXdKcVhkbXBkeTltMk5nWjFpZEd1YWJ6SDg3d1VLbVQv?=
 =?utf-8?B?N1Q0Y2NtRGlBWHY1U3hvdmxVY0xkbERjQWlmemlTS1RIaWh3ZEJzd1dXeUlF?=
 =?utf-8?B?bWQ1SHh1MG11TndFL3NFWm1pZHpHOWhUTENZdlI3MDlwRStlNDFsZUpqdlJ2?=
 =?utf-8?B?SFBSQnNrNkxmK0tNOWl6NnhERStCamZENGhydmlza2tubmJZcmEreDU5OVBL?=
 =?utf-8?B?dFBHOTEzRFBOQmNVUjB0UnNteWtZdEhKZHBsMkVSZ2JJMGRJNkRRYVBqTmdr?=
 =?utf-8?B?RGYvRmlHMW5jVlBCRHcrb2tWUGZFMHJSaHBTUmxTcllSVDZkQzRzR0xHc3Ez?=
 =?utf-8?B?WE1wUytObnJoNi9IclFCVTUzSTYxbWRNbFlDaExFeXZJblk3WmNpREdoT0F3?=
 =?utf-8?B?SDc0S284WVV3NmtUQ2hXR0R6UWdtN2VsRmkwOXFyUGJ2a2hDY2xGREVUUFov?=
 =?utf-8?B?dHY0ekpxRitYVnZKeTBLNkFHWkxENFRWUzdiUG0wcy9nQVVYNXZmTHhpUExv?=
 =?utf-8?B?Y3B6Z3ZxMWlzNEtpUjJZei9KSWZjeGJhM3pxSEUwQzBId25MTVpRRGp6OVhX?=
 =?utf-8?B?SDJPd1FNK2xRa1FxT3Jmd3N2T0E0SnhzYXdzS1kwcTVOeFdtRy83YTRHa2lF?=
 =?utf-8?B?T05hUWxwUHROM05hUS90ZFhpeExBVStadDRzTmd1ZCtGSTVUM0tZYWlsdFJa?=
 =?utf-8?B?Zk51VjlNQTlkV3ZQTnNlcS8zSHJrajFNVnU0eXkzS0xGcVZGeGZNelBqOU1D?=
 =?utf-8?B?dW8rYlgvSmVIRG9ndFZBaGZIbEVHS1BXU1k2ZXFNWVJ6TVBORGk3eHZIdFhV?=
 =?utf-8?B?NStrc1dnSXhDRHg2a0dEMXI3RzdLeWFYWDVXbjdUMUVZM2pITVhaNEZXMDhk?=
 =?utf-8?Q?Ii+FF1aZNUHf8NViETzp5pgtSBxguprGZVH9UNv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2739f0-f04e-4703-8e79-08d8d744696e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 15:13:30.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqVLG4Ck0X7uwtc+muctIJFlR4MJaCDm2ke/acX6efwISTa49jjJLgE1myR6rpEAM2NiFmOCIANVDK4//phXUCJRabxyR8vey48jPC734vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2827
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/2021 4:52 AM, David Hildenbrand wrote:
> On 20.02.21 00:04, George Kennedy wrote:
>>
>>
>> On 2/19/2021 11:45 AM, George Kennedy wrote:
>>>
>>>
>>> On 2/18/2021 7:09 PM, Andrey Konovalov wrote:
>>>> On Fri, Feb 19, 2021 at 1:06 AM George Kennedy
>>>> <george.kennedy@oracle.com> wrote:
>>>>>
>>>>>
>>>>> On 2/18/2021 3:55 AM, David Hildenbrand wrote:
>>>>>> On 17.02.21 21:56, Andrey Konovalov wrote:
>>>>>>> During boot, all non-reserved memblock memory is exposed to the 
>>>>>>> buddy
>>>>>>> allocator. Poisoning all that memory with KASAN lengthens boot 
>>>>>>> time,
>>>>>>> especially on systems with large amount of RAM. This patch makes
>>>>>>> page_alloc to not call kasan_free_pages() on all new memory.
>>>>>>>
>>>>>>> __free_pages_core() is used when exposing fresh memory during 
>>>>>>> system
>>>>>>> boot and when onlining memory during hotplug. This patch adds a new
>>>>>>> FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() 
>>>>>>> through
>>>>>>> free_pages_prepare() from __free_pages_core().
>>>>>>>
>>>>>>> This has little impact on KASAN memory tracking.
>>>>>>>
>>>>>>> Assuming that there are no references to newly exposed pages
>>>>>>> before they
>>>>>>> are ever allocated, there won't be any intended (but buggy)
>>>>>>> accesses to
>>>>>>> that memory that KASAN would normally detect.
>>>>>>>
>>>>>>> However, with this patch, KASAN stops detecting wild and large
>>>>>>> out-of-bounds accesses that happen to land on a fresh memory page
>>>>>>> that
>>>>>>> was never allocated. This is taken as an acceptable trade-off.
>>>>>>>
>>>>>>> All memory allocated normally when the boot is over keeps getting
>>>>>>> poisoned as usual.
>>>>>>>
>>>>>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>>>>>> Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
>>>>>> Not sure this is the right thing to do, see
>>>>>>
>>>>>> https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com 
>>>>>>
>>>>>>
>>>>>>
>>>>>> Reversing the order in which memory gets allocated + used during 
>>>>>> boot
>>>>>> (in a patch by me) might have revealed an invalid memory access 
>>>>>> during
>>>>>> boot.
>>>>>>
>>>>>> I suspect that that issue would no longer get detected with your
>>>>>> patch, as the invalid memory access would simply not get detected.
>>>>>> Now, I cannot prove that :)
>>>>> Since David's patch we're having trouble with the iBFT ACPI table,
>>>>> which
>>>>> is mapped in via kmap() - see acpi_map() in "drivers/acpi/osl.c". 
>>>>> KASAN
>>>>> detects that it is being used after free when ibft_init() accesses 
>>>>> the
>>>>> iBFT table, but as of yet we can't find where it get's freed (we've
>>>>> instrumented calls to kunmap()).
>>>> Maybe it doesn't get freed, but what you see is a wild or a large
>>>> out-of-bounds access. Since KASAN marks all memory as freed during the
>>>> memblock->page_alloc transition, such bugs can manifest as
>>>> use-after-frees.
>>>
>>> It gets freed and re-used. By the time the iBFT table is accessed by
>>> ibft_init() the page has been over-written.
>>>
>>> Setting page flags like the following before the call to kmap()
>>> prevents the iBFT table page from being freed:
>>
>> Cleaned up version:
>>
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 0418feb..8f0a8e7 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -287,9 +287,12 @@ static void __iomem *acpi_map(acpi_physical_address
>> pg_off, unsigned long pg_sz)
>>
>>        pfn = pg_off >> PAGE_SHIFT;
>>        if (should_use_kmap(pfn)) {
>> +        struct page *page = pfn_to_page(pfn);
>> +
>>            if (pg_sz > PAGE_SIZE)
>>                return NULL;
>> -        return (void __iomem __force *)kmap(pfn_to_page(pfn));
>> +        SetPageReserved(page);
>> +        return (void __iomem __force *)kmap(page);
>>        } else
>>            return acpi_os_ioremap(pg_off, pg_sz);
>>    }
>> @@ -299,9 +302,12 @@ static void acpi_unmap(acpi_physical_address
>> pg_off, void __iomem *vaddr)
>>        unsigned long pfn;
>>
>>        pfn = pg_off >> PAGE_SHIFT;
>> -    if (should_use_kmap(pfn))
>> -        kunmap(pfn_to_page(pfn));
>> -    else
>> +    if (should_use_kmap(pfn)) {
>> +        struct page *page = pfn_to_page(pfn);
>> +
>> +        ClearPageReserved(page);
>> +        kunmap(page);
>> +    } else
>>            iounmap(vaddr);
>>    }
>>
>> David, the above works, but wondering why it is now necessary. kunmap()
>> is not hit. What other ways could a page mapped via kmap() be unmapped?
>>
>
> Let me look into the code ... I have little experience with ACPI 
> details, so bear with me.
>
> I assume that acpi_map()/acpi_unmap() map some firmware blob that is 
> provided via firmware/bios/... to us.
>
> should_use_kmap() tells us whether
> a) we have a "struct page" and should kmap() that one
> b) we don't have a "struct page" and should ioremap.
>
> As it is a blob, the firmware should always reserve that memory region 
> via memblock (e.g., memblock_reserve()), such that we either
> 1) don't create a memmap ("struct page") at all (-> case b) )
> 2) if we have to create e memmap, we mark the page PG_reserved and
>    *never* expose it to the buddy (-> case a) )
>
>
> Are you telling me that in this case we might have a memmap for the HW 
> blob that is *not* PG_reserved? In that case it most probably got 
> exposed to the buddy where it can happily get allocated/freed.
>
> The latent BUG would be that that blob gets exposed to the system like 
> ordinary RAM, and not reserved via memblock early during boot. 
> Assuming that blob has a low physical address, with my patch it will 
> get allocated/used a lot earlier - which would mean we trigger this 
> latent BUG now more easily.
>
> There have been similar latent BUGs on ARM boards that my patch 
> discovered where special RAM regions did not get marked as reserved 
> via the device tree properly.
>
> Now, this is just a wild guess :) Can you dump the page when mapping 
> (before PageReserved()) and when unmapping, to see what the state of 
> that memmap is?

Thank you David for the explanation and your help on this,

dump_page() before PageReserved and before kmap() in the above patch:

[    1.116480] ACPI: Core revision 20201113
[    1.117628] XXX acpi_map: about to call kmap()...
[    1.118561] page:ffffea0002f914c0 refcount:0 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0xbe453
[    1.120381] flags: 0xfffffc0000000()
[    1.121116] raw: 000fffffc0000000 ffffea0002f914c8 ffffea0002f914c8 
0000000000000000
[    1.122638] raw: 0000000000000000 0000000000000000 00000000ffffffff 
0000000000000000
[    1.124146] page dumped because: acpi_map pre SetPageReserved

I also added dump_page() before unmapping, but it is not hit. The 
following for the same pfn now shows up I believe as a result of setting 
PageReserved:

[   28.098208] BUG: Bad page state in process modprobe  pfn:be453
[   28.098394] page:ffffea0002f914c0 refcount:0 mapcount:0 
mapping:0000000000000000 index:0x1 pfn:0xbe453
[   28.098394] flags: 0xfffffc0001000(reserved)
[   28.098394] raw: 000fffffc0001000 dead000000000100 dead000000000122 
0000000000000000
[   28.098394] raw: 0000000000000001 0000000000000000 00000000ffffffff 
0000000000000000
[   28.098394] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
[   28.098394] page_owner info is not present (never set?)
[   28.098394] Modules linked in:
[   28.098394] CPU: 2 PID: 204 Comm: modprobe Not tainted 5.11.0-3dbd5e3 #66
[   28.098394] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 0.0.0 02/06/2015
[   28.098394] Call Trace:
[   28.098394]  dump_stack+0xdb/0x120
[   28.098394]  bad_page.cold.108+0xc6/0xcb
[   28.098394]  check_new_page_bad+0x47/0xa0
[   28.098394]  get_page_from_freelist+0x30cd/0x5730
[   28.098394]  ? __isolate_free_page+0x4f0/0x4f0
[   28.098394]  ? init_object+0x7e/0x90
[   28.098394]  __alloc_pages_nodemask+0x2d8/0x650
[   28.098394]  ? write_comp_data+0x2f/0x90
[   28.098394]  ? __alloc_pages_slowpath.constprop.103+0x2110/0x2110
[   28.098394]  ? __sanitizer_cov_trace_pc+0x21/0x50
[   28.098394]  alloc_pages_vma+0xe2/0x560
[   28.098394]  do_fault+0x194/0x12c0
[   28.098394]  ? write_comp_data+0x2f/0x90
[   28.098394]  __handle_mm_fault+0x1650/0x26c0
[   28.098394]  ? copy_page_range+0x1350/0x1350
[   28.098394]  ? write_comp_data+0x2f/0x90
[   28.098394]  ? write_comp_data+0x2f/0x90
[   28.098394]  handle_mm_fault+0x1f9/0x810
[   28.098394]  ? write_comp_data+0x2f/0x90
[   28.098394]  do_user_addr_fault+0x6f7/0xca0
[   28.098394]  exc_page_fault+0xaf/0x1a0
[   28.098394]  asm_exc_page_fault+0x1e/0x30
[   28.098394] RIP: 0010:__clear_user+0x30/0x60

What would be  the correct way to reserve the page so that the above 
would not be hit?

BTW, this is running with Konrad's patch that pairs acpi_get_table & 
acpi_put_table for the iBFT table which should result in an eventual 
call to acpi_unmap() and kunmap(), though that does not occur. Could be 
a possible acpi page refcount issue that will have to be looked into.

George

