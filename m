Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4426323341
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhBWV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:28:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56834 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhBWV2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:28:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NLOF2K017441;
        Tue, 23 Feb 2021 21:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3IFCYmp2MdeYaWolaKlzWLWK9zGRCfUrgBd8VdIPItY=;
 b=bESHsz9FrJIyYYNY3wMoZJkqGdquKCFrdc0LAhYBCxMSim7OdGoRwMjCHr/V1rEX12Au
 NbZCkX1ZGd+5sy6jUvEvYbZJ+j5gINj1JwF+Pj2my4LbUNaFdbjrPOjwpX/sHtqLHMgm
 05oWpHRqU+UDU7BNl4Ms0PExcDEx3TiFkaTNZK/FMSLInfArcu+nCY+S9i7j7OEj0GPP
 26l49EvwXqfASfxGn6Gt05gCxY1RxVL9w4lY37Yd1qwlWbQN2C0Gc+XhQbX3rwJoT8Tw
 JNoHgCjXMPKDGsXCswHsSRHb5H8FWQ36HqoS21mXFgL0Ph/SuzNpxTZk4dD2uDMTL7V2 Wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ttcm8w3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 21:26:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NLOkG2026543;
        Tue, 23 Feb 2021 21:26:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by userp3030.oracle.com with ESMTP id 36ucby1q2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 21:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1y3XX20HQMDTtfQtOGqYT7UcHsRW5AujJ1z+XnwQ1R7VQW3sCv3CQbL9ZTtLi1SuD2gE/IAUwma5lvYeOcMz9bP8/v+ctNSf9jegE3Yx7OWN4C+kVcOFxDQ9STI4YpzMrk8utX5b+c34IUVv/AurghNcvxRpEN5cytFm0GR/iEEsj98x5ue5S840ygBXXGf/3ccCEwvVPwOBeWLmM8BsYLgDoeOy+q561z3eclPDkQZ39+MFJS5CEAbAo7LuAkucZiiav/IQ65p3nE7dwjOOB2TEflc11c5F88eNAyg2NZh3py8eWcyEN/S5ImpXTogqigGQTDE2efTSBx19m7fZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IFCYmp2MdeYaWolaKlzWLWK9zGRCfUrgBd8VdIPItY=;
 b=Q/AqwXym7zNdiL4yAdxSzwur+f1DNc7lCQ92t7ZjRHdZg/UTG6D2UOiYiL5aUbuY5l4F6e+up9EOwWQB/KQAqnI6fnvnVX+zLtSNON5R6OwWJI2fkObkEdgI9cRklI40Tmv39suHBN+TkoIijCH276Ef5LRe2/K0cSsleiwg1TGOQcp1ldxY35A/gVWtaNwuzLCTGMU4cf17MLwW1ROyC8ZxfNgFqx/qA1/CiP7d7Qu2mWsKzSb+R8aTHthy+smi7WcXLD5vbzsukBqvm7A0CRw2lTo88Mg6BccV4w0VECHt1kHKLZK5c8FoJiaCBj2ALFdaq0AmDTJkm9pmntj6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IFCYmp2MdeYaWolaKlzWLWK9zGRCfUrgBd8VdIPItY=;
 b=JIrpjWkuyyhoiAGWcqf2WIbhQLNGpTO7RMQKk38TczGAED9Nwf4/0ICyqwdJn64BihcSEio9Uo7NgKi9r4BQ0gjv24ibzYGv2s0FG25NhnfS1xU6xL0+ZbxD5Wh5hCeDTgYGWB3O2N+e+H4h6g64l7C935ChwMkEz1oVXdo35fg=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB3116.namprd10.prod.outlook.com (2603:10b6:5:1ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 21:26:46 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 21:26:45 +0000
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
References: <1ac78f02-d0af-c3ff-cc5e-72d6b074fc43@redhat.com>
 <bd7510b5-d325-b516-81a8-fbdc81a27138@oracle.com>
 <56c97056-6d8b-db0e-e303-421ee625abe3@redhat.com>
 <cb8564e8-3535-826b-2d42-b273a0d793fb@oracle.com>
 <20210222215502.GB1741768@linux.ibm.com>
 <9773282a-2854-25a4-9faa-9da5dd34e371@oracle.com>
 <20210223103321.GD1741768@linux.ibm.com>
 <3ef9892f-d657-207f-d4cf-111f98dcb55c@oracle.com>
 <20210223154758.GF1741768@linux.ibm.com>
 <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
 <20210223200914.GH1741768@linux.ibm.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <e2cc19f0-5b09-d661-e7a5-ab94d0ec819b@oracle.com>
Date:   Tue, 23 Feb 2021 16:26:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210223200914.GH1741768@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.20.187.119) by SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 23 Feb 2021 21:26:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecee3d71-6514-4392-4a98-08d8d841b8b4
X-MS-TrafficTypeDiagnostic: DM6PR10MB3116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3116A0CC900DBF8F7A5266EFE6809@DM6PR10MB3116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wo3Knajp9W8+UfG+L+HUpW3OLhcQK/pKc3MDnzDlEksDECUsXjCsLc3CZk8EtevFbgq10v6mPYwlt2yKp1hWff9v48tvzNNz6FeCMHVsol7eUpV/p67u8+5a5SHXv74CszdLEUFW3YTeT81zpGlW/Gwa3YaxJ41wbGAsY9ESFZ/Mx1jLODwAXFhJov8bpfbAL+MGf2Y4dKOnGXkuYgzmqPScw1069DZy+UkJeoMb0wZIV87V0+aIMaQYD7CwnsNNaMMk5dP/agNdPQoRWlM6i97CX8JGrrxxgbjTHkIXQcqyP85oYCen0rYSzN6k9JuZ4xoVvOo4pwhyT9ND+k2s24x3ndeddjB0f3wYNRkq65GC4fT6LxiLUyeKYAV7VUDFm7xYGMdNuiDAp4jgkOut/k2NU4Kfk39WZNu7SK1GdSlIIO0QMOlN/kEQJZLGdtuf/y7I2T2/eU0zWYbXv210aI0R+1jLT6mDgGUAmTKx805Mcxo+vhuN3ptXnAjfDrVIRGDF3HpYePaipnZIRkSUbMAqWpOxayKJM+sDQ0na8PY2o49Qy1Nezqlmqv/1nvKaTgSNFoaQSNwT48CNQjVcFCKlBFpt6wD0I+fcdcimGcAhjYDb83ML+a8bWBsKRwRS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(366004)(376002)(39860400002)(31686004)(16576012)(83380400001)(2906002)(36756003)(44832011)(6486002)(53546011)(478600001)(31696002)(6916009)(316002)(86362001)(107886003)(7416002)(66556008)(8676002)(2616005)(5660300002)(956004)(36916002)(4326008)(8936002)(186003)(6666004)(66476007)(54906003)(16526019)(66946007)(26005)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UytJY3FLSmRkQW9jdzlKOEJXbzlibEwwY0ZLTFNnUXJxK1d6TnVHRnZwcytH?=
 =?utf-8?B?Sk5iSVIzN3RaVEt0QUFoaXVqdVRmMWxHbEFZUHBueFMwYkdQRjdlOFdpVWF1?=
 =?utf-8?B?cU1IL0YxWkdhcm01bVA1eGhYMEpicnpOc3lGdSs3SEJoemllV2NpcGFBeTla?=
 =?utf-8?B?OFlBN0RkRlBPUEpOeHU1NHIzM0lYRW8razNPU3R6eW1senkwS3pCbVYxTmc3?=
 =?utf-8?B?anpGQjF5cVFReTlIc2laVTRtd2pKYUVDbVJVNnRQcTQyRm03YXZNV1o1a3Bq?=
 =?utf-8?B?Qk9qbkc2RGUzR0twVWtJZ1dIMjNyejNRVXRpczV6YWJ4MEZZQ1haMDhVcU9a?=
 =?utf-8?B?aHRXZHpiVk9QZ2hYdWR3RTFFMDRESHYxYTFCOEY2Qmw3Y0dhbEpsMzJJdmdn?=
 =?utf-8?B?ZzhJNDhFWlRUdGNzUHF2VGY2bnBiNUNlazUxbFRDTmNQZHJvTmR4cHdXYk5R?=
 =?utf-8?B?S1RGcEFTd0lYQUkxVExUVzRwdlY1ZGVTdXpiTkNCbTBndVNyRGU1dDJXRVl2?=
 =?utf-8?B?NkpqRlBLclFxaUtTdFYrRVpDNDRCNDhtUHZiK0o2dzVYUlY2TE0vVVpTZnpm?=
 =?utf-8?B?Mk5qY21aNkVmbmRXT3pqZFBzaHJENVVNaE1YaUJ1RVBaYUl1VWJEZHJqc0lC?=
 =?utf-8?B?TGE1VktwMXNTK0JGVU00cWszSHpJYzdRbFlOMmM1dCsrUzhxZUlrK0ZTM0hZ?=
 =?utf-8?B?RVF6NnBrQUNHUytlaDExbTgxVnlUM3ozRlRWTmtkZnZzdmRjOUJyU1h4TVRS?=
 =?utf-8?B?MUZNT1IySEt1TnA5RFVTNmRGaksvcWIwTHZIbHlsTHBIaG1zTzdQQkRYTlZO?=
 =?utf-8?B?TWxEZGZaZ3ltYnI3N25LZmlrTHJqdFR1cGorR2FWMWVObW1zRld4N1J1OEs1?=
 =?utf-8?B?Q2lqbGZCOG4vNUp5aG1yaVo0dWNpUFMvWWVtZFgrREhKR3FGY25leTZZci9r?=
 =?utf-8?B?akM2RkFEQysrcXUwR0V1S1hlU2luRUp5REY1eFY0Ujl2S2tBaGtBcWhtNmdi?=
 =?utf-8?B?clJVVDBOdSt4ZnBPYmhrby80cUdXb3E0YlIxb1FWSzZQOUNydktteVhSME93?=
 =?utf-8?B?VXJiNHFVR29lK3JjdlNUNEVwall0YktibFVuU2VlQlkxQ3BjUXYySnhmc2I2?=
 =?utf-8?B?VzNVTkloUXhNMGVSczBVMng2bmcvQlpmWnJqV016eWxBMGorMGpDQ1BzWHJB?=
 =?utf-8?B?bXo4S0NzWUtLQ3pTNk9yUzRwVDhkcDVFNXBPZ3h5dmI5cmswQUpEcGdYN21w?=
 =?utf-8?B?cm8zUUthci95YkJ6enlPSFVuc2pVRSt4WVJvbWlBa201YjNacVhTVUNTVVVN?=
 =?utf-8?B?UnMrWlFHdFhOMXRzWkM0WFI5WU5VSmZKNjNTMUhkSjNtNjdnaUVyTjJ2V3hK?=
 =?utf-8?B?ZFl1RVJjZFRHM0N1TUIvcGo1bllCNEltdUNuNVZOQzBiZm5Hd3dFayt5V0xk?=
 =?utf-8?B?czdEL0VtUk15VFZDYzdKQkduUzcrM0FFcGcxNm52WkZWeUNxYjFPS3QxeUtZ?=
 =?utf-8?B?TjNUMEdjLzBjTFJlWm1LbURmbXJCSU9pQlFmUUpOWFFNV05qbWZFMG1nTHlu?=
 =?utf-8?B?M2RodytpZVdsTCtYZlp6aVE3QnRpaCtKTkF5OWhtbHR0YXBzUVpBc0RsWTRw?=
 =?utf-8?B?alE3NWN2SzZzSGwrQ3hucXVuam9NVnltRk5PWUwvZnZFdm0yOVgrZFVVN3g1?=
 =?utf-8?B?cTRZZVRRWHRiVkdLU3hGekNtWGhNTnhRcC84Vy9YOHAyZ0Nxa1JmaW5WQ29Q?=
 =?utf-8?Q?TQo373LbAQMcv0MP6RypGrPkk1DuWGt+0dm6o7C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecee3d71-6514-4392-4a98-08d8d841b8b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 21:26:45.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+WmcjjZttr967lCiAK1WZrBG0YamZujjLcKBkMXGjKIvcITprfJ/wUWXF20BQ5i8BR0h9p5dIUI4mNsR+6LgRmC+tUgs+e9Nkm6wc1vPE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230181
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2021 3:09 PM, Mike Rapoport wrote:
> On Tue, Feb 23, 2021 at 01:05:05PM -0500, George Kennedy wrote:
>> On 2/23/2021 10:47 AM, Mike Rapoport wrote:
>>
>> It now crashes here:
>>
>> [    0.051019] ACPI: Early table checksum verification disabled
>> [    0.056721] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
>> [    0.057874] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP
>> 00000001      01000013)
>> [    0.059590] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP
>> 00000001 BXPC 00000001)
>> [    0.061306] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT
>> 00000001 BXPC 00000001)
>> [    0.063006] ACPI: FACS 0x00000000BFBFD000 000040
>> [    0.063938] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC
>> 00000001 BXPC 00000001)
>> [    0.065638] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET
>> 00000001 BXPC 00000001)
>> [    0.067335] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2
>> 00000002      01000013)
>> [    0.069030] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP
>> 00000000      00000000)
>> [    0.070734] XXX acpi_find_ibft_region:
>> [    0.071468] XXX iBFT, status=0
>> [    0.072073] XXX about to call acpi_put_table()...
>> ibft_addr=ffffffffff240000
>> [    0.073449] XXX acpi_find_ibft_region(EXIT):
>> PANIC: early exception 0x0e IP 10:ffffffff9259f439 error 0 cr2
>> 0xffffffffff240004
> Right, I've missed the dereference of the ibft_addr after
> acpi_find_ibft_region().
>
> With this change to iscsi_ibft_find.c instead of the previous one it should
> be better:
>
> diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
> index 64bb94523281..1be7481d5c69 100644
> --- a/drivers/firmware/iscsi_ibft_find.c
> +++ b/drivers/firmware/iscsi_ibft_find.c
> @@ -80,6 +80,27 @@ static int __init find_ibft_in_mem(void)
>   done:
>   	return len;
>   }
> +
> +static void __init acpi_find_ibft_region(unsigned long *sizep)
> +{
> +	int i;
> +	struct acpi_table_header *table = NULL;
> +	acpi_status status;
> +
> +	if (acpi_disabled)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
> +		status = acpi_get_table(ibft_signs[i].sign, 0, &table);
> +		if (ACPI_SUCCESS(status)) {
> +			ibft_addr = (struct acpi_table_ibft *)table;
> +			*sizep = PAGE_ALIGN(ibft_addr->header.length);
> +			acpi_put_table(table);
> +			break;
> +		}
> +	}
> +}
> +
>   /*
>    * Routine used to find the iSCSI Boot Format Table. The logical
>    * kernel address is set in the ibft_addr global variable.
> @@ -91,14 +112,16 @@ unsigned long __init find_ibft_region(unsigned long *sizep)
>   	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
>   	 * only use ACPI for this */
>   
> -	if (!efi_enabled(EFI_BOOT))
> +	if (!efi_enabled(EFI_BOOT)) {
>   		find_ibft_in_mem();
> -
> -	if (ibft_addr) {
>   		*sizep = PAGE_ALIGN(ibft_addr->header.length);
> -		return (u64)virt_to_phys(ibft_addr);
> +	} else {
> +		acpi_find_ibft_region(sizep);
>   	}
>   
> +	if (ibft_addr)
> +		return (u64)virt_to_phys(ibft_addr);
> +
>   	*sizep = 0;
>   	return 0;
>   }
Mike,

No luck. Back to the original KASAN ibft_init crash.

I ran with only the above patch from you. Was that what you wanted? Your 
previous patch had a section defined out by #if 0. Was that supposed to 
be in there as well?

If you need the console output let me know. Got bounced because it was 
too large.

[   30.124650] iBFT detected.
[   30.125228] 
==================================================================
[   30.126201] BUG: KASAN: use-after-free in ibft_init+0x134/0xc33
[   30.126201] Read of size 4 at addr ffff8880be453004 by task swapper/0/1
[   30.126201]
[   30.126201] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.11.0-f9593a0 #9
[   30.126201] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 0.0.0 02/06/2015
[   30.126201] Call Trace:
[   30.126201]  dump_stack+0xdb/0x120
[   30.126201]  ? ibft_init+0x134/0xc33
[   30.126201]  print_address_description.constprop.7+0x41/0x60
[   30.126201]  ? ibft_init+0x134/0xc33
[   30.126201]  ? ibft_init+0x134/0xc33
[   30.126201]  kasan_report.cold.10+0x78/0xd1
[   30.126201]  ? ibft_init+0x134/0xc33
[   30.126201]  __asan_report_load_n_noabort+0xf/0x20
[   30.126201]  ibft_init+0x134/0xc33
[   30.126201]  ? write_comp_data+0x2f/0x90
[   30.126201]  ? ibft_check_initiator_for+0x159/0x159
[   30.126201]  ? write_comp_data+0x2f/0x90
[   30.126201]  ? ibft_check_initiator_for+0x159/0x159
[   30.126201]  do_one_initcall+0xc4/0x3e0
[   30.126201]  ? perf_trace_initcall_level+0x3e0/0x3e0
[   30.126201]  ? unpoison_range+0x14/0x40
[   30.126201]  ? ____kasan_kmalloc.constprop.5+0x8f/0xc0
[   30.126201]  ? kernel_init_freeable+0x420/0x652
[   30.126201]  ? __kasan_kmalloc+0x9/0x10
[   30.126201]  ? __sanitizer_cov_trace_pc+0x21/0x50
[   30.126201]  kernel_init_freeable+0x596/0x652
[   30.126201]  ? console_on_rootfs+0x7d/0x7d
[   30.126201]  ? __sanitizer_cov_trace_pc+0x21/0x50
[   30.126201]  ? rest_init+0xf0/0xf0
[   30.126201]  kernel_init+0x16/0x1d0
[   30.126201]  ? rest_init+0xf0/0xf0
[   30.126201]  ret_from_fork+0x22/0x30
[   30.126201]
[   30.126201] The buggy address belongs to the page:
[   30.126201] page:0000000091b8f2b4 refcount:0 mapcount:0 
mapping:0000000000000000 index:0x1 pfn:0xbe453
[   30.126201] flags: 0xfffffc0000000()
[   30.126201] raw: 000fffffc0000000 ffffea0002fac708 ffffea0002fac748 
0000000000000000
[   30.126201] raw: 0000000000000001 0000000000000000 00000000ffffffff 
0000000000000000
[   30.126201] page dumped because: kasan: bad access detected
[   30.126201] page_owner tracks the page as freed
[   30.126201] page last allocated via order 0, migratetype Movable, 
gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 204, ts 27975563827
[   30.126201]  prep_new_page+0xfb/0x140
[   30.126201]  get_page_from_freelist+0x3503/0x5730
[   30.126201]  __alloc_pages_nodemask+0x2d8/0x650
[   30.126201]  alloc_pages_vma+0xe2/0x560
[   30.126201]  __handle_mm_fault+0x930/0x26c0
[   30.126201]  handle_mm_fault+0x1f9/0x810
[   30.126201]  do_user_addr_fault+0x6f7/0xca0
[   30.126201]  exc_page_fault+0xaf/0x1a0
[   30.126201]  asm_exc_page_fault+0x1e/0x30
[   30.126201] page last free stack trace:
[   30.126201]  free_pcp_prepare+0x122/0x290
[   30.126201]  free_unref_page_list+0xe6/0x490
[   30.126201]  release_pages+0x2ed/0x1270
[   30.126201]  free_pages_and_swap_cache+0x245/0x2e0
[   30.126201]  tlb_flush_mmu+0x11e/0x680
[   30.126201]  tlb_finish_mmu+0xa6/0x3e0
[   30.126201]  exit_mmap+0x2b3/0x540
[   30.126201]  mmput+0x11d/0x450
[   30.126201]  do_exit+0xaa6/0x2d40
[   30.126201]  do_group_exit+0x128/0x340
[   30.126201]  __x64_sys_exit_group+0x43/0x50
[   30.126201]  do_syscall_64+0x37/0x50
[   30.126201]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   30.126201]
[   30.126201] Memory state around the buggy address:
[   30.126201]  ffff8880be452f00: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.126201]  ffff8880be452f80: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.126201] >ffff8880be453000: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.126201]                    ^
[   30.126201]  ffff8880be453080: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.126201]  ffff8880be453100: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   30.126201] 
==================================================================


This is all I ran with:

# git diff
diff --git a/drivers/firmware/iscsi_ibft_find.c 
b/drivers/firmware/iscsi_ibft_find.c
index 64bb945..1be7481 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -80,6 +80,27 @@ static int __init find_ibft_in_mem(void)
  done:
         return len;
  }
+
+static void __init acpi_find_ibft_region(unsigned long *sizep)
+{
+       int i;
+       struct acpi_table_header *table = NULL;
+       acpi_status status;
+
+       if (acpi_disabled)
+               return;
+
+       for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
+               status = acpi_get_table(ibft_signs[i].sign, 0, &table);
+               if (ACPI_SUCCESS(status)) {
+                       ibft_addr = (struct acpi_table_ibft *)table;
+                       *sizep = PAGE_ALIGN(ibft_addr->header.length);
+                       acpi_put_table(table);
+                       break;
+               }
+       }
+}
+
  /*
   * Routine used to find the iSCSI Boot Format Table. The logical
   * kernel address is set in the ibft_addr global variable.
@@ -91,14 +112,16 @@ unsigned long __init find_ibft_region(unsigned long 
*sizep)
         /* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
          * only use ACPI for this */

-       if (!efi_enabled(EFI_BOOT))
+       if (!efi_enabled(EFI_BOOT)) {
                 find_ibft_in_mem();
-
-       if (ibft_addr) {
                 *sizep = PAGE_ALIGN(ibft_addr->header.length);
-               return (u64)virt_to_phys(ibft_addr);
+       } else {
+               acpi_find_ibft_region(sizep);
         }

+       if (ibft_addr)
+               return (u64)virt_to_phys(ibft_addr);
+
         *sizep = 0;
         return 0;
  }


Thank you,
George
>> [    0.075711] CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-34a2105 #8
>> [    0.076983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 0.0.0 02/06/2015
>> [    0.078579] RIP: 0010:find_ibft_region+0x470/0x577

