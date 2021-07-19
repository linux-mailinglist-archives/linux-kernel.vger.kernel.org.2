Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A23CD630
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhGSNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:14:41 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:21829
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239352AbhGSNOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:14:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkLLPLnJ6nR/cFWcNUWgGH6AM1ApWq0Aui28Iu/G9WLTKiW3D2ktVNhXD3KZT2Yo/GuUF+kFbbQmpMR3voOogJQsu11mpxehLHw/NLAQHPJbJiocZGqoq4sSVt4Yo5oJNHNG0404uV7aUF4c3lLw3sff0sKzAPp1EUm7skKt5D2Dg4hDauL6rDdJncGrkS7g0ZxD04LuszfG3HeYjxTHUyGK2TMEnJoDKOGoulsk6UZ6SoGoSgwTv7WEw1KnguSpD5H8Fp/YNXTU+ylVoGiUkVo7splrRGI4wfSCIQPc/XgUiKPrA4Mcn9K22ewL11A5Xdwq9wsNKVuNfwmpyZugHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhA+64X7K9UpLKPDOulPrcaTSir8XoR6TaszeiqnluY=;
 b=SlBK+TU6jXCNbHc5UmqJIMW1mgSgysGPEEXrHvSCgCN78B0758BzU+OFTF3j3yAIfOtPQmrH8k5L5BgLYc1vrKWNz1YtMHi0S3/PWcZUDMtx1uEmuhczpVm7APaYwyTz7GWxYOmtj+8ST6O4eNDK7nApy7gWiH7bHxuQEhzwW4Z34gIzzzE4QN8ykvLWl+dKSwFQZcwTomslR7GNOxaVTWyu+YngDbmsm4J5ppcVDaRaPVxxzJPDkKuFBqO4b7vxeZ2aoOrCXzoo/ZXUdiKXINki7vjZ11iL93vn05ncjQL0xF/Za7PGqQbIl3NSJ3Vl6UXrkCRMqbtk5h2iYCKG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhA+64X7K9UpLKPDOulPrcaTSir8XoR6TaszeiqnluY=;
 b=O+t6mR6ZQ6hXm9bkXilvD9RfvDYASGRu52Ix2lrTGKUWOjSA7EzZrO5qEswZrYM7oJazo9o/o4lKXYmoiULuzIRnXqYMjN1WJxL5uftFku6CMwP7TMMTNZOb4+BFdaydIej40BwlMybnhCjw2+g2gS8M+BAbTxSFxkjkkXx8FTg=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB8PR03MB6092.eurprd03.prod.outlook.com (2603:10a6:10:ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 13:55:13 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::254c:af9d:3060:2201]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::254c:af9d:3060:2201%8]) with mapi id 15.20.4242.023; Mon, 19 Jul 2021
 13:55:13 +0000
Subject: Re: [PATCH 5/7] mm: free user PTE page table pages
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-6-zhengqi.arch@bytedance.com>
 <9c3c87d5-e64e-f13f-ef36-b438e4de1e66@nextfour.com>
 <80b7d7fc-9d6d-0d1b-a333-b0ccd856e7c1@bytedance.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <7fe2dd75-9b48-9685-8986-27a4cecc840f@nextfour.com>
Date:   Mon, 19 Jul 2021 16:55:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <80b7d7fc-9d6d-0d1b-a333-b0ccd856e7c1@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0202CA0011.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::21) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1PR0202CA0011.eurprd02.prod.outlook.com (2603:10a6:3:8c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 13:55:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aede0621-f398-4ae8-39ec-08d94abcd4e3
X-MS-TrafficTypeDiagnostic: DB8PR03MB6092:
X-Microsoft-Antispam-PRVS: <DB8PR03MB6092CB67B6C9A6D8E678B71583E19@DB8PR03MB6092.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gT2CGORNO6xf8lE4Z3qOyh+kzCp4p2cFTuftyOJW6//xfMYCTApWvsqmbPs6zDbv4VxrtyDyOAt+zjVcFeublHvcYpzRuI8HDRioGL3BXWwunANO7yxreSifrKu8XQ2/bVvTvd/o2Ukhb3X80VLtyqnWAFk4fq2opt4F0pyIXYyNkuxRh3yXAf6MHDKtxq9+kXGOcqTLqdqTj8/nFhmoGgCWZKxuoHDKfHyUE6j1UAGizGvHPre14nx0OyUVgd1me6EjsMYGHcZ2MaqiEWXoFJa+tns5Tj/YoVzhF2t4xhU/7amdfMerPfmdq8cUaIex+ZP7HwgxbgviH2bP51wjbeCHsLod1DzAF5w2UaD2oUpfUUwKig3vcZoQGX/BZKVxeq3fu80XQoGD5ueRFa/0X/G9SneekmQTANts2mVG/iJfZZfSSImzzx/rrZRk4VBpkTZqvHGsnPzjZ8/D6m5fcp/YHxGYRUrJ0Us0DoVTvqQ4ZVME8s8og+oSaYC4kQ0UJTZMurewOe8mXfnQEVqPV4GCfh0wmDe65b+jqVYhs4scdd8r1E98WyjagVn8fHEqJbY74x3Nh0aGrI5RBrQF/TpWmOgaXtLcpggf2bUYQ137+xHrdJocVNGEObXXDkqUx0ptasRbhIXl9xOuhihpbl0yhMawRtFR3s1t/CKUgknlrIGJtiP4lGpA5SiYNHKcXPExfq5OAI0/cz48gsJ7Ov+Z7ix+pZGjNVEbTvXINTANPPP+EtTcFi0wg1fS9f6ZGDeAckrR3FKf8Ko9cT0PnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39830400003)(136003)(396003)(36756003)(6486002)(66556008)(4326008)(478600001)(66946007)(26005)(66476007)(38100700002)(38350700002)(956004)(2616005)(83380400001)(186003)(2906002)(86362001)(31686004)(52116002)(5660300002)(31696002)(53546011)(7416002)(8676002)(16576012)(316002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hYeXkwOWd0Q1hEMUF2eUp2V1duQnNTdldRUHVTZUlPK2dqcmpsSUdlaWVt?=
 =?utf-8?B?amIxVTA0WUVaa1NaVDAyVDVObEc2WnNnejZ4aElsT2JCNVVEemx6VkkrbVVi?=
 =?utf-8?B?ZExJYlcrMXRLakpseVkrQnNBVEQxSCs0RFFRa3ZrdXptN0ZGRzBPWWtHQytx?=
 =?utf-8?B?QU1CMlMyQ3hzZmJLdjFNS2Qvblp5MlBncFlvYlRPMzlGU2IxZElVK0RHRFgw?=
 =?utf-8?B?OUFucXRjdE1qRTg0TFk4YnorQ3pndDFZMzY4bmJEVmtjQVdBVllDNHJkZmEr?=
 =?utf-8?B?UTN1TmlWNjBSbUs2UDRKZUdabmhUbm1QRWlLcHR0QWRyOGpNZFh5enQwbVVm?=
 =?utf-8?B?c1lPWjZzejNTRnF6a1ZacHZaZWthT0J1VERPZUlGM3RqODhaVGNFQmNoVmkv?=
 =?utf-8?B?N2pkTVNqTnovSWU2WWFhQjlWTUZSeW1qcHh5U3IvSkI3aWNNd21YVDhBNmw1?=
 =?utf-8?B?MDlUWWYzNGZuYjU3TlNqZ3M0UzhpaDNTWUtGT3BEZjd3QmtlOXhrZU5pRTBz?=
 =?utf-8?B?ZzNPTk5NbWE3TkhoV3NqL1RMRnN1c1Zzd3p5M29YamVvWHF0S21PcmJKa29X?=
 =?utf-8?B?Q0kvUGhqWDk2Zm52dnZ5TXhUL3VHN1dja0ttY1FFQnR3anJ2R2pFNjd4S3JC?=
 =?utf-8?B?V3RVOEExTlRDY2RIenRVSS9iSWhyTFpuR21EcEo4cDFYMGlQUmF6Q1ZuWUdq?=
 =?utf-8?B?azAyN0NkTDB3SjVzckpaN055MlFqdjRwcHFONUUzZVpnTnMvaGR0bk5XUzNB?=
 =?utf-8?B?L2pPeXZCcnltcGw5T2VCUit0eTF3SmxCeFB3TTY0T2JpcXl5QmRaS2ZxMy80?=
 =?utf-8?B?d29XUzFpSXBGTmR5MXAzUTR1aVhNbjgrNXVPN2tyb09oNWM4YVJZbnhCTHcx?=
 =?utf-8?B?eC9RRUE2bWN3RWh2YXhEbGJqandPTHZCT1d5OEw4eHJXbHJNc29yemNvSHJr?=
 =?utf-8?B?d09Rd0lqQzZhTE1GREczaXlJRFVjdmRUcE80d1o2MHFGSXdlVmRGbHZSOWFW?=
 =?utf-8?B?ZEMzelloSlJDVytrZ1hWWGhNM1pHczRvWmdZbUp6S1pkU1d4TGhxR0ZUWXlK?=
 =?utf-8?B?ZC8wam9UN1N3Z2R5dzNWZmRSb3FSODhEdlhEQjZUenVWemNJY09lV0FlNGM3?=
 =?utf-8?B?dHA1MTlVekFvN3haRmN6NGxXRGY0Sk8wa3ZQaTZkaTVHM0FybVFqcHg0Y2NQ?=
 =?utf-8?B?R01NekxWVFpXSmpKRk55Z3ExWlZTL3Noa2UyWllvSFdLOVZyckRRVGhIQnJ6?=
 =?utf-8?B?WGVpUVBaMlIwY0k1NXhHdlhtZkhEWWQ2OGpWRWZIbnFTci9KSjhGUHh5QVdq?=
 =?utf-8?B?VG4yaHVURmY5UmRNcnQyanVORmUxWEZ4SlRDSk9PQUN4aFNKUlJTdmZkZVYy?=
 =?utf-8?B?QXVVb1hBclFUU0pESUxRQ3I1S1VTb09HdzhFUGxpSW55R09EQ0JMZjBkUyt4?=
 =?utf-8?B?cVZvUXB6THNQSWd2dzgrSTFFalZ3djYyOUFVL25TQnZIRnIwdXFjU1hIMUE0?=
 =?utf-8?B?VUp1TVZ0RTVGNHEwRjZCNThwZ29BRFgweWdaelp6cHcrWkUvWndPZ3pLTUVK?=
 =?utf-8?B?NXFET0gzeGJoamtOQ1VyUy9SWlBkZW9WOUR2RDVzV1hrL1duMHJoUWZodVhr?=
 =?utf-8?B?emRMUXhxUWF6eTZKc2FLRGxndHNkazVqUEFPSHdMNGMwL3RIMXZzUWhtMG5G?=
 =?utf-8?B?T3pFaHdNNmZFRGdTNEJOWTQyRCt0SnNpT2R4bXVzNXI2dTFYUkRpN0NqUERw?=
 =?utf-8?Q?lpOSKSXVnqsB7DqHNSH8ZApU5anPeZqH/az7dT6?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aede0621-f398-4ae8-39ec-08d94abcd4e3
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 13:55:13.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADGNKn9+t04gJCgCS0ifUOD9LAt/hKqn34NRuUzRcO+RnyvYVe7sWDzyFC05CcD4Wb8SVeaytgGeXuszTPaXtRuxuZShkuivzAoi+0KmuIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.7.2021 15.56, Qi Zheng wrote:
> On 7/18/21 2:19 PM, Mika Penttilä wrote:
>
>>> +
>>> +/*
>>> + * returns true if the pmd has been populated with PTE page table,
>>> + * or false for all other cases.
>>> + */
>>> +bool pte_install_try_get(struct mm_struct *mm, pmd_t *pmd, 
>>> pgtable_t *pte)
>>> +{
>>> +    spinlock_t *ptl;
>>> +    bool retval = true;
>>> +
>>> +retry:
>>> +    ptl = pmd_lock(mm, pmd);
>>> +    if (likely(pmd_none(*pmd))) {
>>> +        __pte_install(mm, pmd, pte);
>>> +    } else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {
>>> +        retval = false;
>>> +    } else if (!pte_get_unless_zero(pmd)) {
>>> +        spin_unlock(ptl);
>>> +        goto retry;
>>> +    }
>>> +    spin_unlock(ptl);
>>> +    return retval;
>>> +}
>>> +
>>
>> Can pte_get_unless_zero() return true above? Can the pmd have been by 
>> populated by others? In that case the ref count is wrongly incremented.
>>
>
> Here we only have mmap_read_lock(mm), so the pmd can be populated with
> other PTE page table page after a page fault in a different thread B 
> of this mm. In this case, thread B already hold a pte_refcount of the 
> PTE page table page populated in the pmd, so pte_get_unless_zero() can
> return true above.
>

Yes but if thread B populates the page table page and pte, then we also 
increase the refcount with pte_get_unless_zero() , but dont decrease it 
when notice !pte_none().
And in the pte_none() case, the refcount is increased again, so double 
accounting. see finish_fault().

> Similarly, if THP is enabled, the pmd also can be populated with a THP 
> page, we can see more detail in comment in handle_pte_fault(). The
> pmd_leaf() above is to detect this situation.

