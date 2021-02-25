Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB1325316
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhBYQIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:08:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39636 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhBYQHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:07:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PG4mRW037678;
        Thu, 25 Feb 2021 16:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8KvJPZpTIgjGK4tVheW7e6iveNTfPdlkuBNzPnS1CCo=;
 b=naWpmAdche2Z5nv55Ph8ZSiPfMh53LYbAdG/ksQDU8a19Rm2X7PFKDrN0aeKItGnq35K
 RzAXfQDJ7WjDTWlS31Tgoxx8L0s+CZocSwXyW7+OMzXIfiURlI2LYEsYsIww8GF1j70a
 IuHwDVPIWqbr+XAFAdv7zgNDpDGFCdI4h29s2zn3YgeQf39WaKoZtnKkslowCyvmp/1d
 Il55xgWVuGHynS+Adl+/f3Y95YJUHnV4DAQcMi076gImnbzgzOIT64+rdQ3A+3RgDGQD
 yrrjY80x5oXdL4wL3CQBMiUDN7OfZgQk056WRjFIRdVsETTcg796P5kOpndV0ABl3Iqy +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36ugq3nv2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 16:06:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PFefvx011955;
        Thu, 25 Feb 2021 16:06:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 36ucb27qe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 16:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtemRBk3IchZ3/JyjK8AloMxpb9k0cp/nJIeEguq+GEDj+7pzMcH9TUlifqFlhiBsJAe1qmT+qK9Rb37rJq6Vx7n5LIOw+lksgZZIlRo5Wo53w4WzInxiHuJw4XphL92zb90xJItpQ2a3tahEe1+JyiF/TpdPBDVoCvLsHlLHtHrpKgnMI27oRSwW3oAX8xJ+FXgEoA7HDGs6C+7UcdxE2M1qpnvVK3269hxBuK/8mxSf0/iNZiWoXd0lr2mv6G9zbFaWS1igF6jW0vxrEnMNPL2g4uz/AvEc/jk/YQMDFkKM8k3JyvD5PhFLA23YNBFlGXQRfPNPjojGOV0EXlnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KvJPZpTIgjGK4tVheW7e6iveNTfPdlkuBNzPnS1CCo=;
 b=j3AobhmCykow54Sz+a4nu2DYWVME4Iz4EPihATmPdwaO/u1w28GkU4wlx7Axxu0ldYG3atQnGQk+w+9kMyxBV1EUj/bNRQvjepP/B/SNVGXGmLxLWmhgPuzi5nO7nlKLOZs7DYhG14nzJ3TIdRVxHu9oEjWwkUKw7hJkpvRP4ppkGoRDDGWmEKSN0bAbu4YfLYM+xOWP/ehYj3gji+RvAKGI9k1pSqA/EgkL8fn4/xkLUSghnatjvJnAQfHrfuSTQvn8gedNx8TsolPkUxVbQEitiUOS3cox2DQ43sx7a8ZxuMNaLdV142kjKhsC8g/Zso5ar0eqYtvY+0R4Cl0ZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KvJPZpTIgjGK4tVheW7e6iveNTfPdlkuBNzPnS1CCo=;
 b=eCFxsvu7jUNyvnTiIaEY9UCZRQPjVNV/NqlCfXB8Vhm5NQ+HV/R2NQP8WmgYA2XZC0vCa1ITOcadhDegsAjx9Y6h5LdVTRyXtTSOCB0ntVimxp07Jrm33NPOls8jeIENF59YHZ4MUpn3huMDkKPbYvenI+ggxWr5jOajrAJpSMc=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM5PR10MB1449.namprd10.prod.outlook.com (2603:10b6:3:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 16:06:20 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 16:06:20 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
From:   George Kennedy <george.kennedy@oracle.com>
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
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
Organization: Oracle Corporation
Message-ID: <a43179e8-b063-569c-f27d-dda84133322e@oracle.com>
Date:   Thu, 25 Feb 2021 11:06:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: SJ0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::28) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 16:06:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 363745d8-6182-4bda-bb00-08d8d9a74a49
X-MS-TrafficTypeDiagnostic: DM5PR10MB1449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB144985356B0051FFDA3C1043E69E9@DM5PR10MB1449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VlrQPwff9pBb6FXgl4tkogfC4Xv5A6EFYeF5jplhLyj/+7UolCh2mY2qXMRaNMTLYCt4A4PzgqolFMHKHXWhIfTHxAz6rPGBTpIN0zYhU6nmnm8ic4b7xuk02tzBzWURfNAyO/nR720YBSd+qcKlRr+f5S1V6z3QIHfXbCXno5PP1LHCddYncZ6RCAQ7fLzI6yoKSerB4AwhBrbZzpEFoVD3Y3tHH7/y4T56R/Y7J2NOwg9/gAzUMJMkVJEg7CVnJQDnTE0fmFbItCRZMid6HZSD6FDFSqvBajyUXn4flghTU5EkTNCWNWiMVm/xyBRjskEWuvR4/zCC0K1jLUVt37pCoVATO+IquLKAfqmXoY9Bpvsz199cp6ERm9V6i3ZA5NhH2Lsw5FidHpdtv07BkNgDKnQ/dfYu1NV7MiQID1mRx2IGIQZ4Z6IPLlRAfbKdwhOpfdUOucLXsATCA+iXIrnhumhCFPn8N3/GrU4sqTdyxGd9OKWo4a38FoUHH6pQ39AyKPadIkIEyvu75FWcLFKU6p9CBkgaIReyaqaiWecO3QYoW56hcvXBJ6W4QRWdykAfdZ3prDHgDyinRbKRHvP7x9SY7aHsJnUYwJ9Uwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(396003)(136003)(2616005)(316002)(6486002)(66556008)(956004)(16576012)(86362001)(44832011)(31686004)(8936002)(186003)(53546011)(31696002)(26005)(66476007)(16526019)(54906003)(66946007)(2906002)(6666004)(4326008)(30864003)(83380400001)(7416002)(36756003)(6916009)(107886003)(8676002)(5660300002)(36916002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Tk05NDh3Q212NnlRWmFSVy9QTlgyOTZUNmd4TlMwZGZZT0daQnBNczJGK0J4?=
 =?utf-8?B?NEdNSzNKUmllazlLNlhZdHpIYmQvUHJTZXZTWFJHZkkzK3RWb0RBejJHOHI0?=
 =?utf-8?B?a3BpK0tKV1cwaG9LK3NjSWJDNzJ5cWcwVWQvbkhlNXN0THBVVkFJS21kZmYy?=
 =?utf-8?B?Q0o5YTJESFlNY1dLTzhXNStROHppeHYxRWV4Wi9La2FyeStNZ2krVCtZRWNN?=
 =?utf-8?B?cjI0T2QzdlRRUElHVEJZQ20xS0lvOFhyOGxLenljQk5lOFY0SEg2MzJhZmcv?=
 =?utf-8?B?QnEvdExuR1lxS2lWdVJvZlJWQTBoejIwZUE4c2lRT2lzR3N4b3RrRUErWHY3?=
 =?utf-8?B?Z0lWcHVtbDkweHZSNnVqTXBCWFVuSjhySXFQc0c1cE9lQ2t3S0l2RVFHWmds?=
 =?utf-8?B?MWszMWY3NGNpcEY3NFVUWXpYdWVUY21ONUhoM1FmZHJZcnZIZDMwMTM4SW9E?=
 =?utf-8?B?YVI3MFVoN3JDSzNDT0VDU3VzZ2NQMXZuUXRqcWVyR05MTnJtUFI5NWlpMTFB?=
 =?utf-8?B?eHltWGZ6SERyNG05TkZRMmk2YTE1R2Q3aHhXNVhJM1dJeW1OdUphRFhMSkpP?=
 =?utf-8?B?R1JnZTJFaXBVUVlIS1R1RHExZG1JblF3MjhsUUhrV0FZcnhINnlxU0prMXZQ?=
 =?utf-8?B?MFZhT2RWVENKbVdDTEhPK1MxTGI0Z3BDRnVwMzkrS2JMeXlDcGpzdUZQQWZO?=
 =?utf-8?B?Y1ZLRXpmMkhYK0pBb1MycWxiUURha1Z2SG5odnR0WjJNOURXY25DMXZ3ajFm?=
 =?utf-8?B?RlJEWndqVG50dW9NekZvRnFmRVdhV090MnROcCsyeHQ1eVBHZU1rWFI1S2h5?=
 =?utf-8?B?MkY2RjFmWGlENU54eFd1RmQ4TkVOb0RoaUp6RG5uSHpKRFluSkNqSlpIRjJE?=
 =?utf-8?B?NkpmbDR4MkZKcGk4ZUZ3NmRZRXpXQUxVeGJ5eWpPU3RwVEJoaGp0YmJ6TlNs?=
 =?utf-8?B?Qm1hMmtuQ2FPbWsrTzc5am9VUi8rWmpkRE1BUytEQmErcFZ6U0xJR3cwRmww?=
 =?utf-8?B?OUpobXpLaTBQbHdSSllhWFgvcGRvNVlUdy9jWHV6c3kwcytsOEgyKzc2WlU1?=
 =?utf-8?B?R2FRajFSMXBBQldjaVo4U0Vza1FNcGFoc3hKSFpRaC9jM0ZYWS9CWEdKZXB4?=
 =?utf-8?B?bmtQUFFlLzhuRThkb0c0aUhmZlpkeENYVzNZa1JGL1BwcWVTUjVLTlN2SDlq?=
 =?utf-8?B?WnBRUVdjQmhwczMzZjhxS1c5ZTVhRERlMGpPMmJGemovWWJRQXMwdGt3OXlC?=
 =?utf-8?B?SnRNSzloaEJ4OTN5aElVbVkxNXYza3QrdEpxVFBvajd2MlpHNzRiTWJuSWg3?=
 =?utf-8?B?eDE1a2NERmRhRE4zYTE1cW16d0w1aEgrTXBMb2gyWHc2MGlkaHMrRUJhVTE1?=
 =?utf-8?B?Ni9wZkpibnJSak45dzhPNGR1V2k3VlhMNFQ0L3NJUnpPL2d0RWFEYWNYMTlH?=
 =?utf-8?B?V1B6RnpJL2VobDVKaFJJL2xsVlVWV0ZVdktGeEFRWGswTk9NM3V5L05PUmxO?=
 =?utf-8?B?RkIydkFqb3MwWjR5MktHOFdnQ0V2U3ZFMmJVakl2TFFnTDE2VkUwMHllaGh4?=
 =?utf-8?B?eU4yMkNXc3UvVTRwWVNoSnRlYXRnNDFDdUZqMGtFMWkzQ1d3SFJGODBhNzlh?=
 =?utf-8?B?RUtQbW82NjNtd3RKM1hpMm1CUFd0aExIOEF0enBYSVo0S2RhbGZRNUpkTW5u?=
 =?utf-8?B?ZnlWTlZTM1JaTlJlMmhmVEdTNHBITVk2ZjcxY0pjZkVvenpYd0JEY2NDNmJu?=
 =?utf-8?Q?+149P7/I8STRcvGAul3Zh7KmJh4044LdoDKJr3J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363745d8-6182-4bda-bb00-08d8d9a74a49
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 16:06:20.5544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFPMM5RC7F0OBNZQsSQY4eCFL+ZICaBQFBYneXYuHjQZxREOejlzcQBtMHto/ebaOYPO4Ue/yjxZ0mwTDsiyUdEKFsyyvd3WXUDBoQe2gZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1449
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250126
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2021 10:22 AM, George Kennedy wrote:
>
>
> On 2/25/2021 9:57 AM, Mike Rapoport wrote:
>> On Thu, Feb 25, 2021 at 07:38:19AM -0500, George Kennedy wrote:
>>> On 2/25/2021 3:53 AM, Mike Rapoport wrote:
>>>> Hi George,
>>>>
>>>>> On 2/24/2021 5:37 AM, Mike Rapoport wrote:
>>>>>> On Tue, Feb 23, 2021 at 04:46:28PM -0500, George Kennedy wrote:
>>>>>>> Mike,
>>>>>>>
>>>>>>> Still no luck.
>>>>>>>
>>>>>>> [   30.193723] iscsi: registered transport (iser)
>>>>>>> [   30.195970] iBFT detected.
>>>>>>> [   30.196571] BUG: unable to handle page fault for address: 
>>>>>>> ffffffffff240004
>>>>>> Hmm, we cannot set ibft_addr to early pointer to the ACPI table.
>>>>>> Let's try something more disruptive and move the reservation back to
>>>>>> iscsi_ibft_find.c.
>>>>>>
>>>>>> diff --git a/arch/x86/kernel/acpi/boot.c 
>>>>>> b/arch/x86/kernel/acpi/boot.c
>>>>>> index 7bdc0239a943..c118dd54a747 100644
>>>>>> --- a/arch/x86/kernel/acpi/boot.c
>>>>>> +++ b/arch/x86/kernel/acpi/boot.c
>>>>>> @@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
>>>>>>         if (acpi_disabled)
>>>>>>             return;
>>>>>> +#if 0
>>>>>>         /*
>>>>>>          * Initialize the ACPI boot-time table parser.
>>>>>>          */
>>>>>> @@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
>>>>>>             disable_acpi();
>>>>>>             return;
>>>>>>         }
>>>>>> +#endif
>>>>>>         acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>>>>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>>>>> index d883176ef2ce..c615ce96c9a2 100644
>>>>>> --- a/arch/x86/kernel/setup.c
>>>>>> +++ b/arch/x86/kernel/setup.c
>>>>>> @@ -570,16 +570,6 @@ void __init reserve_standard_io_resources(void)
>>>>>>     }
>>>>>> -static __init void reserve_ibft_region(void)
>>>>>> -{
>>>>>> -    unsigned long addr, size = 0;
>>>>>> -
>>>>>> -    addr = find_ibft_region(&size);
>>>>>> -
>>>>>> -    if (size)
>>>>>> -        memblock_reserve(addr, size);
>>>>>> -}
>>>>>> -
>>>>>>     static bool __init snb_gfx_workaround_needed(void)
>>>>>>     {
>>>>>>     #ifdef CONFIG_PCI
>>>>>> @@ -1032,6 +1022,12 @@ void __init setup_arch(char **cmdline_p)
>>>>>>          */
>>>>>>         find_smp_config();
>>>>>> +    /*
>>>>>> +     * Initialize the ACPI boot-time table parser.
>>>>>> +     */
>>>>>> +    if (acpi_table_init())
>>>>>> +        disable_acpi();
>>>>>> +
>>>>>>         reserve_ibft_region();
>>>>>>         early_alloc_pgt_buf();
>>>>>> diff --git a/drivers/firmware/iscsi_ibft_find.c 
>>>>>> b/drivers/firmware/iscsi_ibft_find.c
>>>>>> index 64bb94523281..01be513843d6 100644
>>>>>> --- a/drivers/firmware/iscsi_ibft_find.c
>>>>>> +++ b/drivers/firmware/iscsi_ibft_find.c
>>>>>> @@ -47,7 +47,25 @@ static const struct {
>>>>>>     #define VGA_MEM 0xA0000 /* VGA buffer */
>>>>>>     #define VGA_SIZE 0x20000 /* 128kB */
>>>>>> -static int __init find_ibft_in_mem(void)
>>>>>> +static void __init *acpi_find_ibft_region(void)
>>>>>> +{
>>>>>> +    int i;
>>>>>> +    struct acpi_table_header *table = NULL;
>>>>>> +    acpi_status status;
>>>>>> +
>>>>>> +    if (acpi_disabled)
>>>>>> +        return NULL;
>>>>>> +
>>>>>> +    for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
>>>>>> +        status = acpi_get_table(ibft_signs[i].sign, 0, &table);
>>>>>> +        if (ACPI_SUCCESS(status))
>>>>>> +            return table;
>>>>>> +    }
>>>>>> +
>>>>>> +    return NULL;
>>>>>> +}
>>>>>> +
>>>>>> +static void __init *find_ibft_in_mem(void)
>>>>>>     {
>>>>>>         unsigned long pos;
>>>>>>         unsigned int len = 0;
>>>>>> @@ -70,35 +88,44 @@ static int __init find_ibft_in_mem(void)
>>>>>>                     /* if the length of the table extends past 1M,
>>>>>>                      * the table cannot be valid. */
>>>>>>                     if (pos + len <= (IBFT_END-1)) {
>>>>>> -                    ibft_addr = (struct acpi_table_ibft *)virt;
>>>>>>                         pr_info("iBFT found at 0x%lx.\n", pos);
>>>>>> -                    goto done;
>>>>>> +                    return virt;
>>>>>>                     }
>>>>>>                 }
>>>>>>             }
>>>>>>         }
>>>>>> -done:
>>>>>> -    return len;
>>>>>> +
>>>>>> +    return NULL;
>>>>>>     }
>>>>>> +
>>>>>> +static void __init *find_ibft(void)
>>>>>> +{
>>>>>> +    /* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
>>>>>> +     * only use ACPI for this */
>>>>>> +    if (!efi_enabled(EFI_BOOT))
>>>>>> +        return find_ibft_in_mem();
>>>>>> +    else
>>>>>> +        return acpi_find_ibft_region();
>>>>>> +}
>>>>>> +
>>>>>>     /*
>>>>>>      * Routine used to find the iSCSI Boot Format Table. The logical
>>>>>>      * kernel address is set in the ibft_addr global variable.
>>>>>>      */
>>>>>> -unsigned long __init find_ibft_region(unsigned long *sizep)
>>>>>> +void __init reserve_ibft_region(void)
>>>>>>     {
>>>>>> -    ibft_addr = NULL;
>>>>>> +    struct acpi_table_ibft *table;
>>>>>> +    unsigned long size;
>>>>>> -    /* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
>>>>>> -     * only use ACPI for this */
>>>>>> +    table = find_ibft();
>>>>>> +    if (!table)
>>>>>> +        return;
>>>>>> -    if (!efi_enabled(EFI_BOOT))
>>>>>> -        find_ibft_in_mem();
>>>>>> -
>>>>>> -    if (ibft_addr) {
>>>>>> -        *sizep = PAGE_ALIGN(ibft_addr->header.length);
>>>>>> -        return (u64)virt_to_phys(ibft_addr);
>>>>>> -    }
>>>>>> +    size = PAGE_ALIGN(table->header.length);
>>>>>> +    memblock_reserve(virt_to_phys(table), size);
>>>>>> -    *sizep = 0;
>>>>>> -    return 0;
>>>>>> +    if (efi_enabled(EFI_BOOT))
>>>>>> +        acpi_put_table(&table->header);
>>>>>> +    else
>>>>>> +        ibft_addr = table;
>>>>>>     }
>>>>>> diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
>>>>>> index b7b45ca82bea..da813c891990 100644
>>>>>> --- a/include/linux/iscsi_ibft.h
>>>>>> +++ b/include/linux/iscsi_ibft.h
>>>>>> @@ -26,13 +26,9 @@ extern struct acpi_table_ibft *ibft_addr;
>>>>>>      * mapped address is set in the ibft_addr variable.
>>>>>>      */
>>>>>>     #ifdef CONFIG_ISCSI_IBFT_FIND
>>>>>> -unsigned long find_ibft_region(unsigned long *sizep);
>>>>>> +void reserve_ibft_region(void);
>>>>>>     #else
>>>>>> -static inline unsigned long find_ibft_region(unsigned long *sizep)
>>>>>> -{
>>>>>> -    *sizep = 0;
>>>>>> -    return 0;
>>>>>> -}
>>>>>> +static inline void reserve_ibft_region(void) {}
>>>>>>     #endif
>>>>>>     #endif /* ISCSI_IBFT_H */
>>>>> Still no luck Mike,
>>>>>
>>>>> We're back to the original problem where the only thing that 
>>>>> worked was to
>>>>> run "SetPageReserved(page)" before calling "kmap(page)". The page 
>>>>> is being
>>>>> "freed" before ibft_init() is called as a result of the recent 
>>>>> buddy page
>>>>> freeing changes.
>>>> I keep missing some little details each time :(
>>> No worries. Thanks for all your help. Does this patch go on top of your
>>> previous patch or is it standalone?
>> This is standalone.
>>> George
>>>> Ok, let's try from the different angle.
>>>>
>>>> diff --git a/drivers/acpi/acpica/tbutils.c 
>>>> b/drivers/acpi/acpica/tbutils.c
>>>> index 4b9b329a5a92..ec43e1447336 100644
>>>> --- a/drivers/acpi/acpica/tbutils.c
>>>> +++ b/drivers/acpi/acpica/tbutils.c
>>>> @@ -7,6 +7,8 @@
>>>>     *
>>>> *****************************************************************************/
>>>> +#include <linux/memblock.h>
>>>> +
>>>>    #include <acpi/acpi.h>
>>>>    #include "accommon.h"
>>>>    #include "actables.h"
>>>> @@ -339,6 +341,21 @@ acpi_tb_parse_root_table(acpi_physical_address 
>>>> rsdp_address)
>>>>                acpi_tb_parse_fadt();
>>>>            }
>>>> +        if (ACPI_SUCCESS(status) &&
>>>> + ACPI_COMPARE_NAMESEG(&acpi_gbl_root_table_list.
>>>> +                     tables[table_index].signature,
>>>> +                     ACPI_SIG_IBFT)) {
>>>> +            struct acpi_table_header *ibft;
>>>> +            struct acpi_table_desc *desc;
>>>> +
>>>> +            desc = &acpi_gbl_root_table_list.tables[table_index];
>>>> +            status = acpi_tb_get_table(desc, &ibft);
>>>> +            if (ACPI_SUCCESS(status)) {
>>>> +                memblock_reserve(address, ibft->length);
>>>> +                acpi_tb_put_table(desc);
>>>> +
>>>> +        }
>>>> +
>>>>    next_table:
>>>>            table_entry += table_entry_size;
>>>>
>>>>
> Applied just your latest patch, but same failure.
>
> I thought there was an earlier comment (which I can't find now) that 
> stated that memblock_reserve() wouldn't reserve the page, which is 
> what's needed here.
Mike,

Here was David's explanation of what he thinks is going on (or should be 
going on) from a few days ago:

QUOTE...
I assume that acpi_map()/acpi_unmap() map some firmware blob that is 
provided via firmware/bios/... to us.

should_use_kmap() tells us whether
a) we have a "struct page" and should kmap() that one
b) we don't have a "struct page" and should ioremap.

As it is a blob, the firmware should always reserve that memory region 
via memblock (e.g., memblock_reserve()), such that we either
1) don't create a memmap ("struct page") at all (-> case b) )
2) if we have to create e memmap, we mark the page PG_reserved and
*never* expose it to the buddy (-> case a) )


Are you telling me that in this case we might have a memmap for the HW 
blob that is *not* PG_reserved? In that case it most probably got 
exposed to the buddy where it can happily get allocated/freed.

The latent BUG would be that that blob gets exposed to the system like 
ordinary RAM, and not reserved via memblock early during boot. Assuming 
that blob has a low physical address, with my patch it will get 
allocated/used a lot earlier - which would mean we trigger this latent 
BUG now more easily.
...END_QUOTE

Your most recent patch has added the memblock_reserve(), but it's still 
missing the PG_reserved setting.

Thanks,
George

>
> [   30.308229] iBFT detected..
> [   30.308796] 
> ==================================================================
> [   30.308890] BUG: KASAN: use-after-free in ibft_init+0x134/0xc33
> [   30.308890] Read of size 4 at addr ffff8880be453004 by task 
> swapper/0/1
> [   30.308890]
> [   30.308890] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
> 5.11.0-f9593a0 #12
> [   30.308890] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS 0.0.0 02/06/2015
> [   30.308890] Call Trace:
> [   30.308890]  dump_stack+0xdb/0x120
> [   30.308890]  ? ibft_init+0x134/0xc33
> [   30.308890]  print_address_description.constprop.7+0x41/0x60
> [   30.308890]  ? ibft_init+0x134/0xc33
> [   30.308890]  ? ibft_init+0x134/0xc33
> [   30.308890]  kasan_report.cold.10+0x78/0xd1
> [   30.308890]  ? ibft_init+0x134/0xc33
> [   30.308890]  __asan_report_load_n_noabort+0xf/0x20
> [   30.308890]  ibft_init+0x134/0xc33
> [   30.308890]  ? write_comp_data+0x2f/0x90
> [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
> [   30.308890]  ? write_comp_data+0x2f/0x90
> [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
> [   30.308890]  do_one_initcall+0xc4/0x3e0
> [   30.308890]  ? perf_trace_initcall_level+0x3e0/0x3e0
> [   30.308890]  ? unpoison_range+0x14/0x40
> [   30.308890]  ? ____kasan_kmalloc.constprop.5+0x8f/0xc0
> [   30.308890]  ? kernel_init_freeable+0x420/0x652
> [   30.308890]  ? __kasan_kmalloc+0x9/0x10
> [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
> [   30.308890]  kernel_init_freeable+0x596/0x652
> [   30.308890]  ? console_on_rootfs+0x7d/0x7d
> [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
> [   30.308890]  ? rest_init+0xf0/0xf0
> [   30.308890]  kernel_init+0x16/0x1d0
> [   30.308890]  ? rest_init+0xf0/0xf0
> [   30.308890]  ret_from_fork+0x22/0x30
> [   30.308890]
> [   30.308890] The buggy address belongs to the page:
> [   30.308890] page:0000000001b7b17c refcount:0 mapcount:0 
> mapping:0000000000000000 index:0x1 pfn:0xbe453
> [   30.308890] flags: 0xfffffc0000000()
> [   30.308890] raw: 000fffffc0000000 ffffea0002ef9788 ffffea0002f91488 
> 0000000000000000
> [   30.308890] raw: 0000000000000001 0000000000000000 00000000ffffffff 
> 0000000000000000
> [   30.308890] page dumped because: kasan: bad access detected
> [   30.308890] page_owner tracks the page as freed
> [   30.308890] page last allocated via order 0, migratetype Movable, 
> gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 204, ts 
> 28121288605
> [   30.308890]  prep_new_page+0xfb/0x140
> [   30.308890]  get_page_from_freelist+0x3503/0x5730
> [   30.308890]  __alloc_pages_nodemask+0x2d8/0x650
> [   30.308890]  alloc_pages_vma+0xe2/0x560
> [   30.308890]  __handle_mm_fault+0x930/0x26c0
> [   30.308890]  handle_mm_fault+0x1f9/0x810
> [   30.308890]  do_user_addr_fault+0x6f7/0xca0
> [   30.308890]  exc_page_fault+0xaf/0x1a0
> [   30.308890]  asm_exc_page_fault+0x1e/0x30
> [   30.308890] page last free stack trace:
> [   30.308890]  free_pcp_prepare+0x122/0x290
> [   30.308890]  free_unref_page_list+0xe6/0x490
> [   30.308890]  release_pages+0x2ed/0x1270
> [   30.308890]  free_pages_and_swap_cache+0x245/0x2e0
> [   30.308890]  tlb_flush_mmu+0x11e/0x680
> [   30.308890]  tlb_finish_mmu+0xa6/0x3e0
> [   30.308890]  exit_mmap+0x2b3/0x540
> [   30.308890]  mmput+0x11d/0x450
> [   30.308890]  do_exit+0xaa6/0x2d40
> [   30.308890]  do_group_exit+0x128/0x340
> [   30.308890]  __x64_sys_exit_group+0x43/0x50
> [   30.308890]  do_syscall_64+0x37/0x50
> [   30.308890]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   30.308890]
> [   30.308890] Memory state around the buggy address:
> [   30.308890]  ffff8880be452f00: ff ff ff ff ff ff ff ff ff ff ff ff 
> ff ff ff ff
> [   30.308890]  ffff8880be452f80: ff ff ff ff ff ff ff ff ff ff ff ff 
> ff ff ff ff
> [   30.308890] >ffff8880be453000: ff ff ff ff ff ff ff ff ff ff ff ff 
> ff ff ff ff
> [   30.308890]                    ^
> [   30.308890]  ffff8880be453080: ff ff ff ff ff ff ff ff ff ff ff ff 
> ff ff ff ff
> [   30.308890]  ffff8880be453100: ff ff ff ff ff ff ff ff ff ff ff ff 
> ff ff ff ff
> [   30.308890] 
> ==================================================================
>
> George
>

