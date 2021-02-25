Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61BA324FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhBYMj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:39:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47930 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhBYMjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:39:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PCcXHr077360;
        Thu, 25 Feb 2021 12:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SPyLiHxQ6LgfBVvAFvBW2Hk1Wr65kiN89VSuYzX79Jg=;
 b=W64bVeEEpCgpjFD6gnekspG3yGi2PJcvuE06r6potdW/AwDnVA+V542RTV9ejDShWaxi
 w82FsNMXD7zlf8n14G1NI+lelHMcqhkkRp7Swgi6qvJRnFvjj1WUh0t5N1Pw509LYHh2
 FT23xXLwYQ4T/oORL7tzXKWB0t5rRhiT5ugLN+0jVtiMw6VYSZzwDLcasZV8sRN8Ihfo
 YmMPX4hY08+9WHwTNeSmWQGpd19BTUyVVJTpe12Rqbl4hXkTUVThFyd63YLjkrnF2QBn
 0E1+gQkEVbCNQU5kXnus8Zs0DHTkxYijLsUdnmbIeU+tLerMRzH6VsWbuXS47mKfxovA og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36ugq3n6e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 12:38:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PCKEMh129960;
        Thu, 25 Feb 2021 12:38:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 36uc6uecca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 12:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0p+T/4cKAVXX9RpbfyiUzEDhHeFLB23ASfCP/XMZiGo+W359Sr89yaWFd1SKwwTsdQQuJn9mYV1YDhNNkDyQ+xbq3har5EHtqgiDiffxWQtAD3xodZn6bzm8GOHJHW62KyBV/wJSzSWU5GRoZtc3kAOubB46cuZ76p0d6RW7KKc2wJFiUfPCxCpb1M0PfoyElkxEhRzGSBpeVAChWkC88Idu26gy3k3bnb/yB8yVd21k0zwL79BHj9VKwVgkkK7/VVZ/yllURx+upaOm96WK9ZguO+Vioo5MG+JCEFUm195wlKNX1cRTegT1Akm8SfySPCUpxTiYN98fZo/s3cwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPyLiHxQ6LgfBVvAFvBW2Hk1Wr65kiN89VSuYzX79Jg=;
 b=kMkvBDGBek67WctYpm1DHZN3HcggZr3HbpgCY7zUhccoEeMFDzloQSqlDG8xbJAPoceHuLSZ0927r/dXoCRmLrU5u2P9EMNHKCFIRyTL3foWrkrmwRh+mcGRU8MlSM1O7PWCmojOH1oInbmIA6dmuGnCdqyitZrelzYJXpypA6+UlWrNs9kXgH4U2KxR2sXXSv3cGrXhJxix9yxP6zGfnx6XQTAJ4eKRgTjL9imyLEa56KxHNz7GWAC7Z3IizrBLxxqmFO7bPaojzCsvqywPxei38UNhDjqw7rO+wgqkYCDJLjZsRV3xjxDI2EM8nZSYsn+3GI4SC6s5OrQhfXWgiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPyLiHxQ6LgfBVvAFvBW2Hk1Wr65kiN89VSuYzX79Jg=;
 b=RJ991ZjEo7W823uS+T+DWTTdIWVbBCF3bsYKBFbYpz1rKOn29y1dlv0pmAuoIaZ+O2L3nfnr2SP8c0mRjXPs9X09viO6HBknHNuxM6v9WsudJ5Yp3QYALmzcmSK+r2r0l0EvvlWeAoq/TzKwvzZP3T4Y0yyknoVt/qlY8rJV1fY=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DS7PR10MB4973.namprd10.prod.outlook.com (2603:10b6:5:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 12:38:24 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 12:38:24 +0000
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
References: <20210223103321.GD1741768@linux.ibm.com>
 <3ef9892f-d657-207f-d4cf-111f98dcb55c@oracle.com>
 <20210223154758.GF1741768@linux.ibm.com>
 <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
 <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
Date:   Thu, 25 Feb 2021 07:38:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210225085300.GB1854360@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: BYAPR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::40) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by BYAPR02CA0027.namprd02.prod.outlook.com (2603:10b6:a02:ee::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 12:38:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 489aa4f0-fdf8-4d0c-26b1-08d8d98a3e08
X-MS-TrafficTypeDiagnostic: DS7PR10MB4973:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DS7PR10MB497333E11C88D8C58693BEF0E69E9@DS7PR10MB4973.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NF77AAy06s9gGpYw61C4G4oF0lbm/Ub22yVKqR6HwOqNxqQk5LuT+DQAtZsN0w8wcUob8kiU94ckh9l6UY5aPhYhGLUuZz+LVoT6pVnOulsP8wOtAZaQCL+Tj+k0WWYTfJ7s+Gkec2o249CBrayJcNihb82ead5dnB5blPoz+G3MRbcR7PRzYL7DA6jwicgRhApsJg57bwGRMeYGDruGyK2cy69kyCLgVYJqvsMO0FKr4TYA0eSTaiR81PlgFdO4IiygyfvM2fpx3uiV0OoRCCaJtYD5shymytPVliUzTjWXrt+nxM1TuyrNTCmbbCmHM/U17UW/tXxxePjMHi5XK1mlX4QuhQFz8Hsj+C+5/eZh+LLcNInS6BKOIIKQIvUJwWP+BXIKSDrmMD7KnyX113k07lsO7rloge6OtjXXBmZeU3XxL0oH7xrJ+jtiBczjEWeOUBeGOTRd2hARske9+Ghwy0I/hcCM5obprvdn/zu9jXZrfJMVqfMBeeddsrwlR2flm2aep6rgKmRNO+sdlqpmMwbo3meEZ98QamgtB78o1UuZ5PXaTMevmEMhK8HC4AR3oDGe2LNdeugvUag0IBdfQHVt5Ag/WluBKk3zLOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(107886003)(54906003)(316002)(36916002)(5660300002)(8936002)(4326008)(478600001)(8676002)(83380400001)(31696002)(36756003)(956004)(16576012)(2616005)(26005)(6486002)(44832011)(7416002)(66556008)(6916009)(186003)(16526019)(2906002)(53546011)(31686004)(66476007)(86362001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VFpPbGpPdENUSFVSSG42RnJsN01jWXZxak1aK05SZmpwaDV1bkZ5WGFBRXB1?=
 =?utf-8?B?UDhLTkRWaGxjVURha29ON2c2MEhha1VnTmlXbFhlVFhBYnRzN1ZldTBPV2xt?=
 =?utf-8?B?ZmhYVE9MSlo4UUhjelR5Vk1wWXQyb2c5M0NIUmpaMUs3cEt4RUwreTA1MXZO?=
 =?utf-8?B?NmRCTWlpWm9zRkEwMmt5bG1CbXF2VkhsanZOZ0FCd041bGVKUytwSEd5VlNE?=
 =?utf-8?B?dXhER3FqdDExVUV0WWxJNlZNblpBK2VTTTdCNEtFeWVJNXJ1VW0zUitScXlP?=
 =?utf-8?B?cXFNYm45azk2eTBRU0NTd0YvMi9OdTBTUmJ3NmpRRUllNnp2ZzQ1TXFweVEy?=
 =?utf-8?B?SlNaMkNkcG85UE9qZ29EVkhwellhZTUzQWZUaGVOQW5McVZXWTFINXVKUjlH?=
 =?utf-8?B?SXlVc2VteDUrN0hoZzRYRnNQeVlVaGhSU1dYSTJXWFpKamJZd2dhRW82LzFK?=
 =?utf-8?B?OGZKQ3JtU2VmeUxIcDRscE82c2JnZXhld0dGWmRialRmdm8yQ0swY3FFQzlG?=
 =?utf-8?B?amdQTERNQXNwYjdWRXlXQnVldE0zbXJPblp2VW9qK0hScVVYalRkL0U5N3R6?=
 =?utf-8?B?TDR0MVpFTzNiaG42Q29EYmZIaHlLek04NFNPcDNidzJ3V09QL0F0bnc3RkQw?=
 =?utf-8?B?K2cxK2VqR04yMXdRYmtXN2J3cVVSS2hwUVdhNHgrK3NaQ1lTQXhnTnZUMmVJ?=
 =?utf-8?B?SWNDVEo5SlFrUENqdWMwNE40djg3V01NeHh0Wm04UlRKWTg2OHdpMGZLYlY3?=
 =?utf-8?B?ZjlPU1ZpZWFjNDBVUEk1U1lNOVphU2laRXhIM2lFR2FGSUY2TUN2aUVHSERp?=
 =?utf-8?B?TlJBaS9DTHlmL1czZGw2MHd3MUs3TElhUEcxNWVJcmtGN0Z0aXpkbnE0eDRG?=
 =?utf-8?B?cU1wYTl2cll1aEg2VVVsUHFpNllQMzJGRUNzcTBkSzVITk1mSWlyNlhKci9m?=
 =?utf-8?B?bkh5VlJsenZqYks0bk5JR1kvajN1ZmJqeFUxZnpZYytEMlZtUzI4NVlLRy9S?=
 =?utf-8?B?RkRxWE40Tmcza1RwVVBIRHo0czBEUUhOQXNpUlZpQU96TWFHbUxBdzk5NFA4?=
 =?utf-8?B?RHJ3RzFtQUczS1ZnSlRvYm1VR0VlMC85SzBLRVVHMDZvd0drWTduOVpDTDJM?=
 =?utf-8?B?a045bk12S0RTdnNvak1BRGdxU2tGcE5TNmwySHBnQ0NyZFF3WlFxdEZTclRh?=
 =?utf-8?B?dHNNSTBnb3FBa0Y5akZqZU5hRGtxQU1wdW5qRHFPVmdoSEkxc2d5VXorU3Bz?=
 =?utf-8?B?WjBkb3VORFNreUdnM3ZPclJHTnhleVpLZ0IvK1hqazVRTFJydEZBNXp3RElK?=
 =?utf-8?B?SzkyV0prYXRWbzdmenkzMUlxTG0yWG9QQ3lBcmhFR2NpNjR1MXlxcENXS0RS?=
 =?utf-8?B?bEl3RzFDNnRNTjBIMUx6bGFVd3RNTVVPY3FYdXN1L2NBZVdFRktZci9qdllQ?=
 =?utf-8?B?Zmphdzd3ZmVIL2Q0eFBjR295ZFI0a0Q5YXJxMnk3ZERuc0N1NG5xZ3NLOXVq?=
 =?utf-8?B?N2RiZ2ZSQmhYUmdtYTNZbkVtTkxxRGl2OC94a0Z1UkRVbnJvOGZaRnU3SklP?=
 =?utf-8?B?eVFDVjlyUkQ3SFZxOWVhQ2ZpR3pEMW9JbS9zU1NrSVMyUG9aTUxVb3k2Rmtm?=
 =?utf-8?B?Ull0cER5RnB0cDRXRmlqN0pEZnN1d0dOQkZuVkpScDMydGQ4em1OOGlFSHNo?=
 =?utf-8?B?b2hteS9FSm9KYXhsTU1NWWp6Mk4zTlkwSHA5WVd4aVIrTWE2S0hFY2xyVjhF?=
 =?utf-8?Q?MVKNrXkznwrI1Fy4TO0G18q+Vfj47v4V93zTbIS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489aa4f0-fdf8-4d0c-26b1-08d8d98a3e08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 12:38:24.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OilhTSwuRXK4vXPfYGUgtQm+iDyNXaJkMp+rCfjftAF1sWp/i4F8GLyaeAg5GS+kUUChpdFU5pCpEbICuRazkEORQK5ewnkyK59qPqi85M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2021 3:53 AM, Mike Rapoport wrote:
> Hi George,
>
>> On 2/24/2021 5:37 AM, Mike Rapoport wrote:
>>> On Tue, Feb 23, 2021 at 04:46:28PM -0500, George Kennedy wrote:
>>>> Mike,
>>>>
>>>> Still no luck.
>>>>
>>>> [   30.193723] iscsi: registered transport (iser)
>>>> [   30.195970] iBFT detected.
>>>> [   30.196571] BUG: unable to handle page fault for address: ffffffffff240004
>>> Hmm, we cannot set ibft_addr to early pointer to the ACPI table.
>>> Let's try something more disruptive and move the reservation back to
>>> iscsi_ibft_find.c.
>>>
>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>>> index 7bdc0239a943..c118dd54a747 100644
>>> --- a/arch/x86/kernel/acpi/boot.c
>>> +++ b/arch/x86/kernel/acpi/boot.c
>>> @@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
>>>    	if (acpi_disabled)
>>>    		return;
>>> +#if 0
>>>    	/*
>>>    	 * Initialize the ACPI boot-time table parser.
>>>    	 */
>>> @@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
>>>    		disable_acpi();
>>>    		return;
>>>    	}
>>> +#endif
>>>    	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>> index d883176ef2ce..c615ce96c9a2 100644
>>> --- a/arch/x86/kernel/setup.c
>>> +++ b/arch/x86/kernel/setup.c
>>> @@ -570,16 +570,6 @@ void __init reserve_standard_io_resources(void)
>>>    }
>>> -static __init void reserve_ibft_region(void)
>>> -{
>>> -	unsigned long addr, size = 0;
>>> -
>>> -	addr = find_ibft_region(&size);
>>> -
>>> -	if (size)
>>> -		memblock_reserve(addr, size);
>>> -}
>>> -
>>>    static bool __init snb_gfx_workaround_needed(void)
>>>    {
>>>    #ifdef CONFIG_PCI
>>> @@ -1032,6 +1022,12 @@ void __init setup_arch(char **cmdline_p)
>>>    	 */
>>>    	find_smp_config();
>>> +	/*
>>> +	 * Initialize the ACPI boot-time table parser.
>>> +	 */
>>> +	if (acpi_table_init())
>>> +		disable_acpi();
>>> +
>>>    	reserve_ibft_region();
>>>    	early_alloc_pgt_buf();
>>> diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
>>> index 64bb94523281..01be513843d6 100644
>>> --- a/drivers/firmware/iscsi_ibft_find.c
>>> +++ b/drivers/firmware/iscsi_ibft_find.c
>>> @@ -47,7 +47,25 @@ static const struct {
>>>    #define VGA_MEM 0xA0000 /* VGA buffer */
>>>    #define VGA_SIZE 0x20000 /* 128kB */
>>> -static int __init find_ibft_in_mem(void)
>>> +static void __init *acpi_find_ibft_region(void)
>>> +{
>>> +	int i;
>>> +	struct acpi_table_header *table = NULL;
>>> +	acpi_status status;
>>> +
>>> +	if (acpi_disabled)
>>> +		return NULL;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
>>> +		status = acpi_get_table(ibft_signs[i].sign, 0, &table);
>>> +		if (ACPI_SUCCESS(status))
>>> +			return table;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +static void __init *find_ibft_in_mem(void)
>>>    {
>>>    	unsigned long pos;
>>>    	unsigned int len = 0;
>>> @@ -70,35 +88,44 @@ static int __init find_ibft_in_mem(void)
>>>    				/* if the length of the table extends past 1M,
>>>    				 * the table cannot be valid. */
>>>    				if (pos + len <= (IBFT_END-1)) {
>>> -					ibft_addr = (struct acpi_table_ibft *)virt;
>>>    					pr_info("iBFT found at 0x%lx.\n", pos);
>>> -					goto done;
>>> +					return virt;
>>>    				}
>>>    			}
>>>    		}
>>>    	}
>>> -done:
>>> -	return len;
>>> +
>>> +	return NULL;
>>>    }
>>> +
>>> +static void __init *find_ibft(void)
>>> +{
>>> +	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
>>> +	 * only use ACPI for this */
>>> +	if (!efi_enabled(EFI_BOOT))
>>> +		return find_ibft_in_mem();
>>> +	else
>>> +		return acpi_find_ibft_region();
>>> +}
>>> +
>>>    /*
>>>     * Routine used to find the iSCSI Boot Format Table. The logical
>>>     * kernel address is set in the ibft_addr global variable.
>>>     */
>>> -unsigned long __init find_ibft_region(unsigned long *sizep)
>>> +void __init reserve_ibft_region(void)
>>>    {
>>> -	ibft_addr = NULL;
>>> +	struct acpi_table_ibft *table;
>>> +	unsigned long size;
>>> -	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
>>> -	 * only use ACPI for this */
>>> +	table = find_ibft();
>>> +	if (!table)
>>> +		return;
>>> -	if (!efi_enabled(EFI_BOOT))
>>> -		find_ibft_in_mem();
>>> -
>>> -	if (ibft_addr) {
>>> -		*sizep = PAGE_ALIGN(ibft_addr->header.length);
>>> -		return (u64)virt_to_phys(ibft_addr);
>>> -	}
>>> +	size = PAGE_ALIGN(table->header.length);
>>> +	memblock_reserve(virt_to_phys(table), size);
>>> -	*sizep = 0;
>>> -	return 0;
>>> +	if (efi_enabled(EFI_BOOT))
>>> +		acpi_put_table(&table->header);
>>> +	else
>>> +		ibft_addr = table;
>>>    }
>>> diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
>>> index b7b45ca82bea..da813c891990 100644
>>> --- a/include/linux/iscsi_ibft.h
>>> +++ b/include/linux/iscsi_ibft.h
>>> @@ -26,13 +26,9 @@ extern struct acpi_table_ibft *ibft_addr;
>>>     * mapped address is set in the ibft_addr variable.
>>>     */
>>>    #ifdef CONFIG_ISCSI_IBFT_FIND
>>> -unsigned long find_ibft_region(unsigned long *sizep);
>>> +void reserve_ibft_region(void);
>>>    #else
>>> -static inline unsigned long find_ibft_region(unsigned long *sizep)
>>> -{
>>> -	*sizep = 0;
>>> -	return 0;
>>> -}
>>> +static inline void reserve_ibft_region(void) {}
>>>    #endif
>>>    #endif /* ISCSI_IBFT_H */
>> Still no luck Mike,
>>
>> We're back to the original problem where the only thing that worked was to
>> run "SetPageReserved(page)" before calling "kmap(page)". The page is being
>> "freed" before ibft_init() is called as a result of the recent buddy page
>> freeing changes.
> I keep missing some little details each time :(
No worries. Thanks for all your help. Does this patch go on top of your 
previous patch or is it standalone?

George
> Ok, let's try from the different angle.
>
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> index 4b9b329a5a92..ec43e1447336 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -7,6 +7,8 @@
>    *
>    *****************************************************************************/
>   
> +#include <linux/memblock.h>
> +
>   #include <acpi/acpi.h>
>   #include "accommon.h"
>   #include "actables.h"
> @@ -339,6 +341,21 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
>   			acpi_tb_parse_fadt();
>   		}
>   
> +		if (ACPI_SUCCESS(status) &&
> +		    ACPI_COMPARE_NAMESEG(&acpi_gbl_root_table_list.
> +					 tables[table_index].signature,
> +					 ACPI_SIG_IBFT)) {
> +			struct acpi_table_header *ibft;
> +			struct acpi_table_desc *desc;
> +
> +			desc = &acpi_gbl_root_table_list.tables[table_index];
> +			status = acpi_tb_get_table(desc, &ibft);
> +			if (ACPI_SUCCESS(status)) {
> +				memblock_reserve(address, ibft->length);
> +				acpi_tb_put_table(desc);
> +			}
> +		}
> +
>   next_table:
>   
>   		table_entry += table_entry_size;
>   
>
>

