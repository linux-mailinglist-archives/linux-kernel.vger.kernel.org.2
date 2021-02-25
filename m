Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9FC325267
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBYP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:27:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58898 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBYPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:24:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PFAQUI189681;
        Thu, 25 Feb 2021 15:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DnZhDcF/Yhv1/n/TsZ9VslUdsKEberWaV4J516G/AHc=;
 b=KB/7pCX415TI581IdlsqFA7OBuV4pq3i+4rrypvK9KgiSOITGFOX2YXDcS5m5jZSSbsk
 Gm4vq2w3+bIRd6W2LXf66DNPOQ+zcrhWX3TU4zwdOZ5J2Iq1tk0IMXdwOE4s45evvqmE
 IDyZGnIWgAgVsxSdh4biwzJDW+Wpg67FWj3BeM49uDgAOrZZAVyQt4J2aMgdF8rHi07Y
 +qt5gSjJ1XMY3E0pSBkWFWMhZfaThwZ46TMnHZB7Dkl0nwHCtG22YOlORoFgiwyfHBNM
 rtnUUpFQCY0ulLOSBcNM9mnZn6Jt8fUQFhYTcvi0uhlonu3EZsyd1gLtxNnzAkMiYgh4 bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ttcmesus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 15:22:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PFAgF7061347;
        Thu, 25 Feb 2021 15:22:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3020.oracle.com with ESMTP id 36ucb260pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 15:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEvXbLFk0wjWNrStf81r3+fJLYmQk0owaY2VdkkFDa6IExaWYsYdHD7ZXg53+ZsIZuofQy/qENcgX3Wjr1wCssk+fnS+BAdSZIijTLWtwLkWUAtCXZC00SduLdMLbccQE632ZL7lRKlKf1t6YXDik9/0jSwZfyUDuINKRxqoXX8suSls9MUsEHfv0HL+fWj4d3bRIOdcwIs9nznBwV/U/m8QAlgUaKk/7RySLBdx81mS2KSBSmqrb0auXJ6Dsk6zwqPpp9xK/v29CbPgS+hH/iaKzSdCD3w/ILfv6RV+uB/x8yb26JXi0/JppnNgrw9bKR/DEZLRCbeEIHGtIY5Igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnZhDcF/Yhv1/n/TsZ9VslUdsKEberWaV4J516G/AHc=;
 b=CeidRxjg3gu6kQOuRdBSL5d7g+3sPk4VgoDRtnhlO5xI+to23LNpbYh4pmQmmpfhIx2vcwSS74kCfzIb0WRrsjxcW5g+coLTu0eJQ9ve/hrafnfyKRgfYWrepCA636EbMIEFOvJVSPfmgLQW80zhYQry/uSP+g5ak/sGIXLu//FpPX9A1q8FhwPQwaIDQryClZ+lIaCAYnP1q0Hhr0Fsx6F8oJ8RnOvoE3s+rCwXIu9nq6UOgtJ5JebC3x+5mABPOIVBW5Cw98jHl8LQXTE4pPQVnoKu5c6SS3LhraNR7tZg82Foz6Gz95+UFJC6svgbUGvBMuYCYhKG9Z12lMHGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnZhDcF/Yhv1/n/TsZ9VslUdsKEberWaV4J516G/AHc=;
 b=hHCfMohg3iROvX0HrDdYNA8ptvkWGSt7UvGpey6ryCzIaZ6jH2u+skkZi9c9Amp1IeoG8OxQdvMvQMhc1JKtywXszhhKzARx6jgcgmZ4t1Ru1XHNLHU8lmUTzaAXd0EGmdCH7iuUmRSF7lJSBGzRxNF6LaD6AatAhO48h/3ibNE=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM5PR10MB1660.namprd10.prod.outlook.com (2603:10b6:4:6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Thu, 25 Feb 2021 15:22:50 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 15:22:50 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
References: <20210223154758.GF1741768@linux.ibm.com>
 <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
 <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
Date:   Thu, 25 Feb 2021 10:22:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210225145700.GC1854360@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: SN4PR0801CA0005.namprd08.prod.outlook.com
 (2603:10b6:803:29::15) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by SN4PR0801CA0005.namprd08.prod.outlook.com (2603:10b6:803:29::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 15:22:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a0ab9b6-ab9b-4315-f30d-08d8d9a13688
X-MS-TrafficTypeDiagnostic: DM5PR10MB1660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1660D777AD330495CD228CE5E69E9@DM5PR10MB1660.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w43y6O6fMJjN8sVOvbSe+1XJtziYt/bpPC+qKg57TV0SQWPCGdtyr7kRR213Fccw8LW1jg+q5XNZcXIRllT+fBGc8+xVayroERoEk2/DjZJ6wJboMk8PdioQFrgMNh3gqyCznymyBilUjHeQJrSTut/X4OflKKtfL8u4Sno0x4hdo61UW+IUvF8BrqT/Xc6R+xemBNpIysas2eSZcLMNFFbapDcyWWUKesUuv0voVNy4R9Bp8JcO4VSaH2ieEnmlkpd008FCGu20ZxgSNLfqHinu/H20PQO6ERRmcD3bEJJ84co10ln0Cx49YSWCZlq2smOcLi9yr5ZWAxZOiMHAYTrhyRbOzSAj/iLF5VnjJiD4yRxuo5XUKwX7tZP1lrUh6PBu8bU6mtRr3JCExhVQJfFNIJSFkuwEimezQdeA98duKS9LJnryOG+6+bIN5ZogxF13TBHcklUgBMKqLyeR3hOJCpMJ4+UeXuuIMtSABYa9h5i9h5a2ZAzj8IvJf6nnlGF3li3kxkpfp1vM6vCFLltHI4pEhYyLHG3SGEwtBKL7beHdGuvg+i0kqHGIVFwOZ1Zml3f+4oLFNL4HOwGu8pREkv+jHLKfJVvF3tbInpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(366004)(136003)(346002)(30864003)(956004)(4326008)(5660300002)(2616005)(478600001)(107886003)(6486002)(36916002)(86362001)(31686004)(16576012)(7416002)(31696002)(53546011)(44832011)(6666004)(316002)(6916009)(54906003)(8676002)(26005)(36756003)(2906002)(66556008)(66476007)(186003)(83380400001)(66946007)(16526019)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qyt2YkVDNTFVK2Yvbk5IczdPSi92bko4b2p5TmlZM1dUVmlUbHZDdVpnRnVT?=
 =?utf-8?B?TGNXSm9KWEpBdnFrVytrcDZyWXdUcjUwTnZ5am1YM2oreEVFdmRScTduVmc2?=
 =?utf-8?B?c29hdk1WVXR1NVhsYUNMUm4zTGwyYWJtSUp3OWdaZ2ZhRG95K3NpNnhzc2tP?=
 =?utf-8?B?anBxb2xEVWk3dC9JTnNKc0FqMzB6MWRuR1dyZFkwZFVRYVZNNW1aK2xNeGE2?=
 =?utf-8?B?bXlqdk1vbkR0Z3IyZ3I4Q0RXbndma0N2SzhoVlFyaU1wWWdBVk1ZaDMzL3Bt?=
 =?utf-8?B?UVI3ZkxiUWNEaW5kek5NRElVNFh3MjJOTE51RWozZndxOFdySXhlWGFKaW93?=
 =?utf-8?B?NXNWajFwVGQyb0JTcENRd0J3TzI2S0tPb0xEeDh1SDh3dTAyeS9jaXVWcTBI?=
 =?utf-8?B?dWpYRjZmR095VlBlRk0vUG1sWjJZMW9xZ3g1MC9pRVN2NWRPUnJaMUJzajZ6?=
 =?utf-8?B?b2wxTzcxM3lxUHdSbjFyNzBKMjl1cHZVSGpkdDhPaVdJNDVJa3B2b3JUYndQ?=
 =?utf-8?B?dXFKbWNzV3ZqeGwwNSt2aHhqQm9zQW45RzkxRGdQckJFMFNVVDFjb3ZSK053?=
 =?utf-8?B?bWhlZ0NYYUd0WEJNSE1YcHArY3g0NnR0VG9jNm9EWHFKL3pOb3RmWUhQOXJn?=
 =?utf-8?B?dHhMTnpqNVQzbUxGTlQ0OEl6QW9zR1YyTklrMW5rN2FONTB4NDlUQXZ6aTVO?=
 =?utf-8?B?cC93STYvKzBpZUFjK3ZpS25WWFhCT0xiNFRLL09XS3FDLzR1dWFiQkxLcHd4?=
 =?utf-8?B?bTZieHZyMlplQTdtdHhjR2I5M3Fha0JhdVJpWFdZcjloR3pVY1d5Mk1LM2lV?=
 =?utf-8?B?ZG1ZeGZZTmpSVGVNeXhIUGREMU9DNyszWlNZbVJRVVFGTWRHUkFOOWM4V3lz?=
 =?utf-8?B?N08xQ1puMG9hcVNHcHBXVkoxZ3d6TVVPR1p0eEo5eGdXUUVBQnNmcFBjMmR0?=
 =?utf-8?B?azVnMHVjcEQ3K3JnUVExNklJa1FvRDRPeWVsMzloNUd6NHlXOVd3QVdzNmox?=
 =?utf-8?B?YTgzVVBsMVFhdTEvMXVkVUZWYmRkaUt2Q0V4YXZuZGtoZ0dEanZTOUo3WVQx?=
 =?utf-8?B?bWFVNVFKbWgxYVM0NGVCMzNaaFJBekltVitKNWRaUWxiazFNMXd1YnpGQ0tW?=
 =?utf-8?B?NGt2aWlQcG9ickdtV2F6V1M0NVlMUHROZFRkaGNOZ0RQRGR3bStjTDVBWmZz?=
 =?utf-8?B?SnFLS1ZRMW05NUFwRExmQ0p5STBjOWZMbnVpaHV0R1VIK1d4aWcyRW1UcGsw?=
 =?utf-8?B?dHdMMko5RW5ncFJxMkJ0R2JKamZBTEwyQlRiRzB0b3RFWnVRZGdYalc4SXNs?=
 =?utf-8?B?NFNka2dyWGlGV2t5aUJ6VUNmT3Q5NVU1eHdrMDIxcWxjSFpoZlV3dkg5ekFM?=
 =?utf-8?B?THZRa0NvNVByaDQ0dkxvRmltaDg0cVNFM2RGS0wrZEFDeS9wQUJ2eUkvT2Fl?=
 =?utf-8?B?NTgwUXl4b0owbGdaZGF5RHp2TU9Gb3NDbHV4YW9LMGtmOGI2U1hZNHFNUWRN?=
 =?utf-8?B?aFhwR0paL0N5QklHNWwvVzA0UUVtUS9FYnRGUUp2WVB5ejdCajNiQUg2NHcz?=
 =?utf-8?B?dktKWW9rQW4rZUlETDVmalN6VVR2WXhLWU5hV3NjcVZvRGJjbXpIS0tySmdx?=
 =?utf-8?B?dm9LaTVxc0NremtKdnFWNGtmcmQ2azlhWlVEa05TSjgrbFBLK2NrYnZLekZ0?=
 =?utf-8?B?dytySkF5dTc0TEFjdnpMdE8yZ0IzVHZOcHFCalRYSkNqRFoyZFdCZVFaWTg2?=
 =?utf-8?Q?xRtP6yxk1wduWIPq1oxdIjhwAvtw+xuSCU+EeC+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0ab9b6-ab9b-4315-f30d-08d8d9a13688
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 15:22:50.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm0GgdaDqrl+74uQ3ajHxNW08kpHSHES0ROYdvVZ7A8feDSirqYfT9e8yjYnVjzrsRgMejxtrdd/e/uDyc+2fRe3iFeeanxiBgaAn0+9rgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1660
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2021 9:57 AM, Mike Rapoport wrote:
> On Thu, Feb 25, 2021 at 07:38:19AM -0500, George Kennedy wrote:
>> On 2/25/2021 3:53 AM, Mike Rapoport wrote:
>>> Hi George,
>>>
>>>> On 2/24/2021 5:37 AM, Mike Rapoport wrote:
>>>>> On Tue, Feb 23, 2021 at 04:46:28PM -0500, George Kennedy wrote:
>>>>>> Mike,
>>>>>>
>>>>>> Still no luck.
>>>>>>
>>>>>> [   30.193723] iscsi: registered transport (iser)
>>>>>> [   30.195970] iBFT detected.
>>>>>> [   30.196571] BUG: unable to handle page fault for address: ffffffffff240004
>>>>> Hmm, we cannot set ibft_addr to early pointer to the ACPI table.
>>>>> Let's try something more disruptive and move the reservation back to
>>>>> iscsi_ibft_find.c.
>>>>>
>>>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>>>>> index 7bdc0239a943..c118dd54a747 100644
>>>>> --- a/arch/x86/kernel/acpi/boot.c
>>>>> +++ b/arch/x86/kernel/acpi/boot.c
>>>>> @@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
>>>>>     	if (acpi_disabled)
>>>>>     		return;
>>>>> +#if 0
>>>>>     	/*
>>>>>     	 * Initialize the ACPI boot-time table parser.
>>>>>     	 */
>>>>> @@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
>>>>>     		disable_acpi();
>>>>>     		return;
>>>>>     	}
>>>>> +#endif
>>>>>     	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>>>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>>>> index d883176ef2ce..c615ce96c9a2 100644
>>>>> --- a/arch/x86/kernel/setup.c
>>>>> +++ b/arch/x86/kernel/setup.c
>>>>> @@ -570,16 +570,6 @@ void __init reserve_standard_io_resources(void)
>>>>>     }
>>>>> -static __init void reserve_ibft_region(void)
>>>>> -{
>>>>> -	unsigned long addr, size = 0;
>>>>> -
>>>>> -	addr = find_ibft_region(&size);
>>>>> -
>>>>> -	if (size)
>>>>> -		memblock_reserve(addr, size);
>>>>> -}
>>>>> -
>>>>>     static bool __init snb_gfx_workaround_needed(void)
>>>>>     {
>>>>>     #ifdef CONFIG_PCI
>>>>> @@ -1032,6 +1022,12 @@ void __init setup_arch(char **cmdline_p)
>>>>>     	 */
>>>>>     	find_smp_config();
>>>>> +	/*
>>>>> +	 * Initialize the ACPI boot-time table parser.
>>>>> +	 */
>>>>> +	if (acpi_table_init())
>>>>> +		disable_acpi();
>>>>> +
>>>>>     	reserve_ibft_region();
>>>>>     	early_alloc_pgt_buf();
>>>>> diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
>>>>> index 64bb94523281..01be513843d6 100644
>>>>> --- a/drivers/firmware/iscsi_ibft_find.c
>>>>> +++ b/drivers/firmware/iscsi_ibft_find.c
>>>>> @@ -47,7 +47,25 @@ static const struct {
>>>>>     #define VGA_MEM 0xA0000 /* VGA buffer */
>>>>>     #define VGA_SIZE 0x20000 /* 128kB */
>>>>> -static int __init find_ibft_in_mem(void)
>>>>> +static void __init *acpi_find_ibft_region(void)
>>>>> +{
>>>>> +	int i;
>>>>> +	struct acpi_table_header *table = NULL;
>>>>> +	acpi_status status;
>>>>> +
>>>>> +	if (acpi_disabled)
>>>>> +		return NULL;
>>>>> +
>>>>> +	for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
>>>>> +		status = acpi_get_table(ibft_signs[i].sign, 0, &table);
>>>>> +		if (ACPI_SUCCESS(status))
>>>>> +			return table;
>>>>> +	}
>>>>> +
>>>>> +	return NULL;
>>>>> +}
>>>>> +
>>>>> +static void __init *find_ibft_in_mem(void)
>>>>>     {
>>>>>     	unsigned long pos;
>>>>>     	unsigned int len = 0;
>>>>> @@ -70,35 +88,44 @@ static int __init find_ibft_in_mem(void)
>>>>>     				/* if the length of the table extends past 1M,
>>>>>     				 * the table cannot be valid. */
>>>>>     				if (pos + len <= (IBFT_END-1)) {
>>>>> -					ibft_addr = (struct acpi_table_ibft *)virt;
>>>>>     					pr_info("iBFT found at 0x%lx.\n", pos);
>>>>> -					goto done;
>>>>> +					return virt;
>>>>>     				}
>>>>>     			}
>>>>>     		}
>>>>>     	}
>>>>> -done:
>>>>> -	return len;
>>>>> +
>>>>> +	return NULL;
>>>>>     }
>>>>> +
>>>>> +static void __init *find_ibft(void)
>>>>> +{
>>>>> +	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
>>>>> +	 * only use ACPI for this */
>>>>> +	if (!efi_enabled(EFI_BOOT))
>>>>> +		return find_ibft_in_mem();
>>>>> +	else
>>>>> +		return acpi_find_ibft_region();
>>>>> +}
>>>>> +
>>>>>     /*
>>>>>      * Routine used to find the iSCSI Boot Format Table. The logical
>>>>>      * kernel address is set in the ibft_addr global variable.
>>>>>      */
>>>>> -unsigned long __init find_ibft_region(unsigned long *sizep)
>>>>> +void __init reserve_ibft_region(void)
>>>>>     {
>>>>> -	ibft_addr = NULL;
>>>>> +	struct acpi_table_ibft *table;
>>>>> +	unsigned long size;
>>>>> -	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
>>>>> -	 * only use ACPI for this */
>>>>> +	table = find_ibft();
>>>>> +	if (!table)
>>>>> +		return;
>>>>> -	if (!efi_enabled(EFI_BOOT))
>>>>> -		find_ibft_in_mem();
>>>>> -
>>>>> -	if (ibft_addr) {
>>>>> -		*sizep = PAGE_ALIGN(ibft_addr->header.length);
>>>>> -		return (u64)virt_to_phys(ibft_addr);
>>>>> -	}
>>>>> +	size = PAGE_ALIGN(table->header.length);
>>>>> +	memblock_reserve(virt_to_phys(table), size);
>>>>> -	*sizep = 0;
>>>>> -	return 0;
>>>>> +	if (efi_enabled(EFI_BOOT))
>>>>> +		acpi_put_table(&table->header);
>>>>> +	else
>>>>> +		ibft_addr = table;
>>>>>     }
>>>>> diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
>>>>> index b7b45ca82bea..da813c891990 100644
>>>>> --- a/include/linux/iscsi_ibft.h
>>>>> +++ b/include/linux/iscsi_ibft.h
>>>>> @@ -26,13 +26,9 @@ extern struct acpi_table_ibft *ibft_addr;
>>>>>      * mapped address is set in the ibft_addr variable.
>>>>>      */
>>>>>     #ifdef CONFIG_ISCSI_IBFT_FIND
>>>>> -unsigned long find_ibft_region(unsigned long *sizep);
>>>>> +void reserve_ibft_region(void);
>>>>>     #else
>>>>> -static inline unsigned long find_ibft_region(unsigned long *sizep)
>>>>> -{
>>>>> -	*sizep = 0;
>>>>> -	return 0;
>>>>> -}
>>>>> +static inline void reserve_ibft_region(void) {}
>>>>>     #endif
>>>>>     #endif /* ISCSI_IBFT_H */
>>>> Still no luck Mike,
>>>>
>>>> We're back to the original problem where the only thing that worked was to
>>>> run "SetPageReserved(page)" before calling "kmap(page)". The page is being
>>>> "freed" before ibft_init() is called as a result of the recent buddy page
>>>> freeing changes.
>>> I keep missing some little details each time :(
>> No worries. Thanks for all your help. Does this patch go on top of your
>> previous patch or is it standalone?
> This is standalone.
>   
>> George
>>> Ok, let's try from the different angle.
>>>
>>> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
>>> index 4b9b329a5a92..ec43e1447336 100644
>>> --- a/drivers/acpi/acpica/tbutils.c
>>> +++ b/drivers/acpi/acpica/tbutils.c
>>> @@ -7,6 +7,8 @@
>>>     *
>>>     *****************************************************************************/
>>> +#include <linux/memblock.h>
>>> +
>>>    #include <acpi/acpi.h>
>>>    #include "accommon.h"
>>>    #include "actables.h"
>>> @@ -339,6 +341,21 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
>>>    			acpi_tb_parse_fadt();
>>>    		}
>>> +		if (ACPI_SUCCESS(status) &&
>>> +		    ACPI_COMPARE_NAMESEG(&acpi_gbl_root_table_list.
>>> +					 tables[table_index].signature,
>>> +					 ACPI_SIG_IBFT)) {
>>> +			struct acpi_table_header *ibft;
>>> +			struct acpi_table_desc *desc;
>>> +
>>> +			desc = &acpi_gbl_root_table_list.tables[table_index];
>>> +			status = acpi_tb_get_table(desc, &ibft);
>>> +			if (ACPI_SUCCESS(status)) {
>>> +				memblock_reserve(address, ibft->length);
>>> +				acpi_tb_put_table(desc);
>>> +		
>>> +		}
>>> +
>>>    next_table:
>>>    		table_entry += table_entry_size;
>>>
>>>
Applied just your latest patch, but same failure.

I thought there was an earlier comment (which I can't find now) that 
stated that memblock_reserve() wouldn't reserve the page, which is 
what's needed here.

[   30.308229] iBFT detected..
[   30.308796] 
==================================================================
[   30.308890] BUG: KASAN: use-after-free in ibft_init+0x134/0xc33
[   30.308890] Read of size 4 at addr ffff8880be453004 by task swapper/0/1
[   30.308890]
[   30.308890] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-f9593a0 #12
[   30.308890] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 0.0.0 02/06/2015
[   30.308890] Call Trace:
[   30.308890]  dump_stack+0xdb/0x120
[   30.308890]  ? ibft_init+0x134/0xc33
[   30.308890]  print_address_description.constprop.7+0x41/0x60
[   30.308890]  ? ibft_init+0x134/0xc33
[   30.308890]  ? ibft_init+0x134/0xc33
[   30.308890]  kasan_report.cold.10+0x78/0xd1
[   30.308890]  ? ibft_init+0x134/0xc33
[   30.308890]  __asan_report_load_n_noabort+0xf/0x20
[   30.308890]  ibft_init+0x134/0xc33
[   30.308890]  ? write_comp_data+0x2f/0x90
[   30.308890]  ? ibft_check_initiator_for+0x159/0x159
[   30.308890]  ? write_comp_data+0x2f/0x90
[   30.308890]  ? ibft_check_initiator_for+0x159/0x159
[   30.308890]  do_one_initcall+0xc4/0x3e0
[   30.308890]  ? perf_trace_initcall_level+0x3e0/0x3e0
[   30.308890]  ? unpoison_range+0x14/0x40
[   30.308890]  ? ____kasan_kmalloc.constprop.5+0x8f/0xc0
[   30.308890]  ? kernel_init_freeable+0x420/0x652
[   30.308890]  ? __kasan_kmalloc+0x9/0x10
[   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
[   30.308890]  kernel_init_freeable+0x596/0x652
[   30.308890]  ? console_on_rootfs+0x7d/0x7d
[   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
[   30.308890]  ? rest_init+0xf0/0xf0
[   30.308890]  kernel_init+0x16/0x1d0
[   30.308890]  ? rest_init+0xf0/0xf0
[   30.308890]  ret_from_fork+0x22/0x30
[   30.308890]
[   30.308890] The buggy address belongs to the page:
[   30.308890] page:0000000001b7b17c refcount:0 mapcount:0 
mapping:0000000000000000 index:0x1 pfn:0xbe453
[   30.308890] flags: 0xfffffc0000000()
[   30.308890] raw: 000fffffc0000000 ffffea0002ef9788 ffffea0002f91488 
0000000000000000
[   30.308890] raw: 0000000000000001 0000000000000000 00000000ffffffff 
0000000000000000
[   30.308890] page dumped because: kasan: bad access detected
[   30.308890] page_owner tracks the page as freed
[   30.308890] page last allocated via order 0, migratetype Movable, 
gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 204, ts 28121288605
[   30.308890]  prep_new_page+0xfb/0x140
[   30.308890]  get_page_from_freelist+0x3503/0x5730
[   30.308890]  __alloc_pages_nodemask+0x2d8/0x650
[   30.308890]  alloc_pages_vma+0xe2/0x560
[   30.308890]  __handle_mm_fault+0x930/0x26c0
[   30.308890]  handle_mm_fault+0x1f9/0x810
[   30.308890]  do_user_addr_fault+0x6f7/0xca0
[   30.308890]  exc_page_fault+0xaf/0x1a0
[   30.308890]  asm_exc_page_fault+0x1e/0x30
[   30.308890] page last free stack trace:
[   30.308890]  free_pcp_prepare+0x122/0x290
[   30.308890]  free_unref_page_list+0xe6/0x490
[   30.308890]  release_pages+0x2ed/0x1270
[   30.308890]  free_pages_and_swap_cache+0x245/0x2e0
[   30.308890]  tlb_flush_mmu+0x11e/0x680
[   30.308890]  tlb_finish_mmu+0xa6/0x3e0
[   30.308890]  exit_mmap+0x2b3/0x540
[   30.308890]  mmput+0x11d/0x450
[   30.308890]  do_exit+0xaa6/0x2d40
[   30.308890]  do_group_exit+0x128/0x340
[   30.308890]  __x64_sys_exit_group+0x43/0x50
[   30.308890]  do_syscall_64+0x37/0x50
[   30.308890]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   30.308890]
[   30.308890] Memory state around the buggy address:
[   30.308890]  ffff8880be452f00: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.308890]  ffff8880be452f80: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.308890] >ffff8880be453000: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.308890]                    ^
[   30.308890]  ffff8880be453080: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.308890]  ffff8880be453100: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.308890] 
==================================================================

George

