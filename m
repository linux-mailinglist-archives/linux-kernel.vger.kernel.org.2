Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4895B3CD66D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbhGSNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:37:11 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:60910
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239393AbhGSNhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV2cimKDPtght81ZfZ7AVqv1AFeTRz9s3eS/+IIxbvmNgX8Hb2tYmI5f5HXNgTqn1PkD9/G1cr8nDIbMc6cUgqK0XJTaU1PEvZLvgEN1hJUsoWispAwIsqq4nrnGYvaFM/Y8omrlT1RxtIzrUw+94efXNy+9IQ+BbbHD7isUyaPbUNET9HMnd1UA1kr1W5Fxaf9V9x1AK0SlSSUsUHMhvK4+jlbN5FXETjJzfuCDcO8DMjZXTqh/yHZF7pv0gsthQpNPZhJzisg+79Pw2sh/+jmfngSgiFVtIf6CZ0jIa1VFfQxNaa/E2YKDhwf6tzrzBX0oyNRe1TmHg03YpVedVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfwvvMYYul9LFhJI+gus8JU9PBpp82382KRfz0izzwo=;
 b=HxkqEh5fpDv5FQTJrRvkSbhGYfas4H+Qdd/Vc9I4RvVUlcaZQxRVD3YAkzaR9grn8ZjTn04/jk0JssX/RT4mnjy+8Kpo9Fs72W7dxNZK95adc5tUuCLTyvEGSaVmtNJDkW4+Nww1UBfsj4/0R66pssevMdXCUog12khxTG2jcl1HuXkmqZb+uIy1KSQ55Zk+6I6j03EN0XTrV6BC6PhcLWScW0oygvxBFbJgPCuqrkOkEL01FicJiOqBAmKev51w2Ov7oca/pGsv6hb293siNZ1tlXaMXDrykNBYLfm3dalLGSmrwyPb9Pxuf31qHnz7DwSdpatz+AxY8RwnKaD2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfwvvMYYul9LFhJI+gus8JU9PBpp82382KRfz0izzwo=;
 b=dKc9M9rp3MwgyGkKSiV1IOYJYHXHXAU5QwY+5cxnuUdWIHZZAhTFro6CBCxXzPADB4/42tbkCCRjt8U/hUmmI217edllpTlENFJaxZiHSbRFjJBMi4sHmFcbdUp5Cepw5GQVdBDkKkla+OAxp56Lk4z5EO2Kn29KKoYsbNuu95g=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB9PR03MB7194.eurprd03.prod.outlook.com (2603:10a6:10:22c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 14:17:47 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::254c:af9d:3060:2201]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::254c:af9d:3060:2201%8]) with mapi id 15.20.4242.023; Mon, 19 Jul 2021
 14:17:47 +0000
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
 <7fe2dd75-9b48-9685-8986-27a4cecc840f@nextfour.com>
 <5ffff30c-59d7-fbb0-e3c2-fe9e47fc4658@bytedance.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <ad00037e-cddb-1de5-bd77-1ade053952ed@nextfour.com>
Date:   Mon, 19 Jul 2021 17:17:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <5ffff30c-59d7-fbb0-e3c2-fe9e47fc4658@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0368.eurprd05.prod.outlook.com
 (2603:10a6:7:94::27) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1PR05CA0368.eurprd05.prod.outlook.com (2603:10a6:7:94::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Mon, 19 Jul 2021 14:17:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1004a77c-0049-4925-41a7-08d94abffbcd
X-MS-TrafficTypeDiagnostic: DB9PR03MB7194:
X-Microsoft-Antispam-PRVS: <DB9PR03MB71948D7ECF48F7DF367ABF6483E19@DB9PR03MB7194.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeJ/R3qj/7x6P418sG2gd2h0PjofVCajMq9dv85/SWOfxbXfTe4X9tDuHhagZ0m/up6HC9o+C6hm0JQK/spPsbY1AkyHRjGoA0sgCjv0OjePajt4zLO6RY3PWxYV509sWjZvbBv8Cx6xCQznYoVvkKh2i12DXyww339ssM1atZfO1/0xzGfbrrBNln/iKJXddG6ZXti1EAfsSiFjb1FIoNBvxwXh1ZtOFx8DMNX4eUQfnBJLJ4P8rFi/WICgvJIbZgiO8QFvSVnxeg+L1Px4yk/57d9e1DMjA2BpS5VCYfvpBwGvcAqBBRbqx9I9BEUPJt9j1Pt+lB/68w8dYdkKgRf2L4XdS24dCZ6J42h3VC8fYKXHARO2n4Hm3AoNTYkFbsVZ/jcmwMEHsnU97fwA+Dyn4bOvFdHujo5R80rpYBeWw+9Bx14+7lq9H2Dusi+K0i8yFKE+os4ZdrgnNcyelamuMfayn6jtoDOetw5axKK8ucIskHgSZ9YjoyYE0NdI3yYEC07MN6qUDpOxkJSj3LcXhW+NDFv9ldWm2THWqMVrOlixw7wbmSAtTdzOEqOmVZNq5mZvcd1hKGdf4LhcBVlYAQNqrLJYcZ7EGE/aHLcRJZZlGUNqfs4seV5GfT/lvDHksV+XzUhy1yul8u5Bh7B0sxiHqAzGo3R3O9byPJu6E1P2VBiZ04nAit+Sok4nv6Dx071o2eCHVHYRcLDKEvKlv918WFqmcEsE2ed8eNmrn8+1yoZZcNmjXei3T1V+Y5y/SuMriGWryH3PDxQH4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(346002)(136003)(376002)(366004)(8936002)(956004)(2616005)(8676002)(4326008)(6486002)(316002)(83380400001)(16576012)(5660300002)(7416002)(186003)(31696002)(38100700002)(66556008)(31686004)(36756003)(86362001)(478600001)(66946007)(66476007)(38350700002)(2906002)(26005)(53546011)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzkxZXRxYWljcGR3bUtvOG5wbXpTc0UrRWhEbXIyQWUvWi8xdWlkdFFyWWdL?=
 =?utf-8?B?L1ZoSDZVQVFHeHRNelpoV1pGeXNWT0c1Rk44K3RlR2xWcVllcjBqUWdGYytx?=
 =?utf-8?B?MElzb1JHcm1ObEdGMTdPaDZpeHREaTBDV2tZVEtPc2t1SmxZbjA0SEtYeUlY?=
 =?utf-8?B?SHdEZ0VuSE00QnpOaWZEcU4rZ0x1Q0gvSFYzbnhxdkFnc21vUHJYZGlIMld1?=
 =?utf-8?B?MlZxY21lT3YrUEpBRUdNZnZhMUhJOWxQSjBPaWIrZzZXMmxMdjdEOFlQNjR2?=
 =?utf-8?B?WERjRElpMHZBSjZUdTdYdDNma0UvWUR1dEhhUFhFb3o4OWNxekVRMEpacVdV?=
 =?utf-8?B?c0dMeU1DUVNFSG40YjRhb2IweER3dmZraGk3U0dhUlZWZHVZZjBCZXBsVnBq?=
 =?utf-8?B?c2EyM1VTWGovWmZ2Zlk4a3ptTVZTa0xJTG1uMWVLUnlBUnJSRTZuOXZaSjlY?=
 =?utf-8?B?TTVYY0d5eUxtSlQzSnp4UTZjMzJJN3VUWHh5anFJcXZxbXAySi9FaEY0Wkkx?=
 =?utf-8?B?Umc0dnpUSFhsUkQwUTNKOTVqY3h6b3A5c2NWRTFXck9YLzc3OTFaY2pMSU8r?=
 =?utf-8?B?QnJLQ2FCOFB4OHpvWGFPS0xQSSsrWTJsc2o0LzZhS0dYM2x5b2RMcjNlMDJL?=
 =?utf-8?B?emQvNzhoY2VzRzgyeTJGRFYxZksrTzJuOXhmd1gyWk9nbWV3UDI5blpuUkhU?=
 =?utf-8?B?MGlSaVdMS1FXOUJsVlFtWm5ZelBYWFByaXJaOVNwV2RVUWRrdEhqVDRiQ3ND?=
 =?utf-8?B?S2F1aGdSM2NRZGE4VWdBekptbTBrM0hlVU54OHBXNUppOWVuc2cvVXF1emRE?=
 =?utf-8?B?czhqM3hiRVhHSk5nNFVLamlkazRtYXI1TDNmaXBVN2FsYmVIWEFvS3RNR1h5?=
 =?utf-8?B?ckdXU1JuL2kvM25iZE1rRmEycG41TTdmeXpSdzE2blhuMDdJRloreldxT3Bn?=
 =?utf-8?B?NXJpUzZvaUdNdm5SYUgrZk1QK3JsWWJicjlrc2lFa04wV0FRcGdRc3ZSSGx4?=
 =?utf-8?B?Ky9teS81VHpHc2RYSHQyRUpOWHlJTUJvZyt2RFIwUWFNR21DRVBCWGxJNENK?=
 =?utf-8?B?dm4zSlB2Qmx2dWxDUWR4SEtCQVlDRWN4TEVnaEZGR1B5UmRnUWxVaGRUNFhi?=
 =?utf-8?B?NGdRSFFhcElhdG9lSVNqdVRmRzBrOFFGTk0yZUJDUDkwSzBZOUZrbVBGVEdC?=
 =?utf-8?B?amNxUExaOHU4Z0JWT2JidFVJbG1VWk4yaU0va01EU0ZWYjdKYjFRUmhmaUlO?=
 =?utf-8?B?WUZBWWU2NUhneVNsU2RmbFNsQlNSV0h6UmtEWm1BdDBWNCtkMEZlSzMrRW9q?=
 =?utf-8?B?bjZnZmJjWU1DV3NEVlJsbkVCUnczLzlnbkhKY0xpcmxCd1NxcGVZV3V6M1M4?=
 =?utf-8?B?b1gzTW5lank5SjZweW9HMjlaRysxRDRlZkpaRzE5ckhGcGpDbkNYUTZjQnFR?=
 =?utf-8?B?WmNSNnVTOFd3OXdZdzRVY1R2TCsyUVRDQkhjSDAxVTRISDE1ZHR3TDVKTENv?=
 =?utf-8?B?QTBNMU5zeTVzcU4vcmwxUFo3UGZTekVZT1RvZW1hd3ZBblh2d0ZYTUk5ajRs?=
 =?utf-8?B?aEJMVmFGTS9RMEljTXl0aWRBenNtS25Yc1JubjBjbUN4eWNsM3dyQmZyQkV4?=
 =?utf-8?B?QlYwYnpwanVTbXlERTQ3MEdMUVNSVFpHeFNxZm0yT2dvaEJkd3JFVzREZ1E0?=
 =?utf-8?B?NkdlK3c3V1F2TTk3TkZmdEpXblNrRHdzRU8wbE53dDdqYXBmZ3VrbncxYUE5?=
 =?utf-8?Q?b7xFkViCl5en3stidz3u1hp9apwOH4MCQnBh97p?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1004a77c-0049-4925-41a7-08d94abffbcd
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 14:17:47.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db9Oiy0TCqW2tHdfJ3OWv4V5ENvAoHTEoSRxtwhLJXVLMlH5idEHBY/fggBYvo+IfhpubQBqD6S3vL9TKQU53DZcR/hBeolMvKuvgrmChfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.7.2021 17.12, Qi Zheng wrote:
> On 7/19/21 9:55 PM, Mika Penttilä wrote:
>>
>>
>> On 19.7.2021 15.56, Qi Zheng wrote:
>>> On 7/18/21 2:19 PM, Mika Penttilä wrote:
>>>
>>>>> +
>>>>> +/*
>>>>> + * returns true if the pmd has been populated with PTE page table,
>>>>> + * or false for all other cases.
>>>>> + */
>>>>> +bool pte_install_try_get(struct mm_struct *mm, pmd_t *pmd, 
>>>>> pgtable_t *pte)
>>>>> +{
>>>>> +    spinlock_t *ptl;
>>>>> +    bool retval = true;
>>>>> +
>>>>> +retry:
>>>>> +    ptl = pmd_lock(mm, pmd);
>>>>> +    if (likely(pmd_none(*pmd))) {
>>>>> +        __pte_install(mm, pmd, pte);
>>>>> +    } else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {
>>>>> +        retval = false;
>>>>> +    } else if (!pte_get_unless_zero(pmd)) {
>>>>> +        spin_unlock(ptl);
>>>>> +        goto retry;
>>>>> +    }
>>>>> +    spin_unlock(ptl);
>>>>> +    return retval;
>>>>> +}
>>>>> +
>>>>
>>>> Can pte_get_unless_zero() return true above? Can the pmd have been 
>>>> by populated by others? In that case the ref count is wrongly 
>>>> incremented.
>>>>
>>>
>>> Here we only have mmap_read_lock(mm), so the pmd can be populated with
>>> other PTE page table page after a page fault in a different thread B 
>>> of this mm. In this case, thread B already hold a pte_refcount of 
>>> the PTE page table page populated in the pmd, so 
>>> pte_get_unless_zero() can
>>> return true above.
>>>
>>
>> Yes but if thread B populates the page table page and pte, then we 
>> also increase the refcount with pte_get_unless_zero() , but dont 
>> decrease it when notice !pte_none().
>> And in the pte_none() case, the refcount is increased again, so 
>> double accounting. see finish_fault().
>
> The semantics of this function is to hold the pte_refcount count when it
> returns 1, and its caller is responsible for decrease the pte_refcount
> by calling pte_put(), like the following pattern:
>
>     do_anonymous_page()
>
>     --> pte_alloc_try_get()
>
>         do something about pte
>
>         pte_put()
>
> Similarly in finish_fault().
>
> Thanks,
>
> Qi

Ok I didn't notice the added pte_put()'s at the end of these funcs.

Thanks,
Mika



>
>>
>>> Similarly, if THP is enabled, the pmd also can be populated with a 
>>> THP page, we can see more detail in comment in handle_pte_fault(). The
>>> pmd_leaf() above is to detect this situation.
>>

