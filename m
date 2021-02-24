Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8493732408F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbhBXPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:13:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40912 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbhBXOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:24:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OEIhcc040965;
        Wed, 24 Feb 2021 14:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Drt9g51HOHLYGCY6HhvE95GF1jthc3F2ZzA51HizCSQ=;
 b=XLk1lBMXM4TG1G14ONsx+bYf/Dxl95wMDCuN0XOer5qOwwV11BfUJPgA9IUvvOioRCIa
 +zETQMtQmpytD++PJ7kwB8XS1vsk2sFT65fOJmgsw7HTO3C21PPc0ZA9SwHvi31pM1qo
 zxAvGRKWPOj0ZSjwERD07Ir9FDSNmtnrAQIU4tVEbu/BqLXs/DHl9gyYK+8oBC49KeVm
 9VbLOIOZbQFggkFMCv1y2FM1q+jlq/bijADx9QKxs8hS99rTYQuQXbr71+3EFYviTDaR
 apSyY5XZWMaOG+xo6qssEtRqQuCIy/Hd6jgSFRXyh6Z5KfJo0HweVdmQfM+BJGSl03kn YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36vr625dpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 14:23:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OEKWqv036135;
        Wed, 24 Feb 2021 14:23:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 36v9m60tf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 14:23:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJiZLs8X8lyeLpRoGbgEAyfkWAuTQJSZElhZkdxzzRw5xqZQBDXaTDHwXSQ7O26XHeOYurWiLRsQ9Adv5cTG4O+ITJi746YJUIZ4CK4ewNZAwXy1hnpEs08mm1aFId/ap4IkM8kqWFlAxi1QoGdHSB6qOv4SKFX32VuiQMf07uIpk01t6iaKiGh+XTV1RWZEPZT/SauwFBsftgVdEn/N5855pS2+AepaRGkWP6F1OS8qwQ2ztwSWE928va2rpWRAavUwQ7Ze389TDEcX3hj4TncdMo1MwKqCwZZkmgn6uth31vZsXa4Fft9D4G88GVJUK8GMbDoELJVNbPvnJ1vsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Drt9g51HOHLYGCY6HhvE95GF1jthc3F2ZzA51HizCSQ=;
 b=h0UcHO2aM186v8eG0i+ENmDKSsSgLfkyIIfPfrv+PrppSKEZysImQl5bWZiSex5ZpBzNU1dVf0y4fA12+a8UEyZBdt4H/BNVP6dB90IEdncGdKE/tPbKoG7KRNlaUQvwBUwUYNjAG0Ye+RYHXglsDTFMIFW+/MIe6lWItV50GdyGYA+H7VR/9iu0P8Oril35OiWI424AWE9cYLPFX3w5Yo8GiLnZe9+5ElidXIlSQT6iCi7rFnV4mouLDrsPGIQc9ndd2lyCzXalY/qQJcGPsCq1cFBlZ6aCwG0hlH2N/SSfBrfXn0/Gn3dZcbRf56X7VV1oHWPCZ68HXb7AgDMIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Drt9g51HOHLYGCY6HhvE95GF1jthc3F2ZzA51HizCSQ=;
 b=oT2k9oboUSRNXf21GxK7N3hBY2YqnLchZCqtT11LLcZJd/yf25BWAq/izUTukjEYFm1B3Phl1LQ2SdY67zHOBeSXzM2miZlrv61Dp/TbsWfG3YMFu8lHcVKY7NDhlDQs03CfgIODx24k+IQm8JMIqlGPQYcCGMiORIGfk7ddypc=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 14:23:07 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 14:23:07 +0000
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
References: <20210222215502.GB1741768@linux.ibm.com>
 <9773282a-2854-25a4-9faa-9da5dd34e371@oracle.com>
 <20210223103321.GD1741768@linux.ibm.com>
 <3ef9892f-d657-207f-d4cf-111f98dcb55c@oracle.com>
 <20210223154758.GF1741768@linux.ibm.com>
 <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
 <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
Date:   Wed, 24 Feb 2021 09:22:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210224103754.GA1854360@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: SA0PR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:806:d2::30) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by SA0PR11CA0085.namprd11.prod.outlook.com (2603:10b6:806:d2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 14:23:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecdd1f09-e064-4ecf-8143-08d8d8cfb485
X-MS-TrafficTypeDiagnostic: DS7PR10MB4895:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DS7PR10MB48958A7EA804190CA10DE670E69F9@DS7PR10MB4895.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA7cV6RejmhpRYwMxkEvIS6qZNhsuWRZNVupzE8ArDvkLYO935GnGWcSs0N/LdXj9LIP+gFLw3YY3bW7XJc43/QS/GFUvtos1CixrBE57QascuX9OLFDnMqmlhGCgjKqxWHaJHqtvWhbZMVpGEUIuwUTViZN2SYj9dKBzjmZSZE1i3ICICgFDuOmD31nikdXDkVee9RgJFouQYKud+hcsf0gppBxXSnr+jJYrRyRNi+synicCYYaHHy1glCz6cspm2I8S+0ubuLjDXj2dYoEIdxBGmhdvEJ6QFarAvz+5kPBG5RY4eK6mp1aad78i3NeokHeZNOf71e8b8nNCBOnmQmMzr0IvPNjbRrufyoJPcWdUxe4vnhEUwsc0mu6veO4i2WOAJz40c0llaZOMi4ct58CZ/6T+lSpHwN4BPJn5QdOt8h6EM5wIfdkkgnZPtQddugaYHkBaDpvsMvzDjq5Cqh43Yf41AK2t85eTiJlJnFNjA7rgyo7EqBuE10TGOnYXeJ4mRZvM3j55n3dn8RrrY9ZDDZOwYB9i2kPJt+M53dhi7B0Flw0UaWWror7xHBVBO2R7LryhXnYJ2cUj1MA2mkhA0HvtWnFfItpWKbpq3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(136003)(396003)(83380400001)(478600001)(54906003)(6916009)(36916002)(31686004)(5660300002)(44832011)(6666004)(956004)(2616005)(36756003)(2906002)(316002)(16576012)(31696002)(26005)(8676002)(186003)(107886003)(86362001)(6486002)(66476007)(66556008)(66946007)(16526019)(53546011)(7416002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?KzdWTVZ4c3lpdjhGUUoyNkxzeERCNW1keHArMEMxUVNqYVl3REt5KzEyRVZi?=
 =?utf-8?B?aUg5Y2JDTmVibVUzVXgwdnpjTWZtUndMUWNiNndIc1l1ZDF5MzRsNGRnVEF6?=
 =?utf-8?B?SzlmNXc0MlNOWDNoUm9kZXRtWUs5eTNUYlA2Y3NmU3RLYUZDWjAyWEtqM0Ey?=
 =?utf-8?B?dUpJMmpWQmFHQTJ1L0Q0QzByM1VlYjNQWXJ1RVdoTUpQd1pqQ25aS2xma1kr?=
 =?utf-8?B?dFMyTzJlV0tDTWpNaWVTcDhZL3pLYmV5Nk51ZEttUmVOeGRSMWJGcmRwazR3?=
 =?utf-8?B?emNXVjFRaXZwaUp6RUgxeithbjM2U3dEbllGQVY1THl5UWdGaTk3SzBYcXAy?=
 =?utf-8?B?bkxwRjZlSHVkeUNBTTI1NWZQWFp4M1N3UXB0TkRCeUFXd2ViNTQ3SjBHNGhp?=
 =?utf-8?B?MU5Gdmg4bUExc3UyeU45RGhTdTM2RlRPQ1ZSZGl5VVNkSFgwemcxWEsrN3ZB?=
 =?utf-8?B?N2ZXUTA0Z04wcis1VUh1ZkRYYks5N0kvV0FHeittQUNDbzdPVHNpUURTTUdY?=
 =?utf-8?B?WHhKZWtPZ0VZQitEeCswQ084K3gvM0FzaEdnOFpwVC9WKzZabUc2cWw5cW9Z?=
 =?utf-8?B?TzB6TWZjV3VCVmdRT1g1VXJoeE5IZ1JWN25OYmpTdmZUdkkxbDRZZTRXdWZP?=
 =?utf-8?B?bE9vV2dnK0VaWmtaZjJKWGJqQjV1S0w2YlBQT2VGcUxrT0lMOU1MUjFzNm1t?=
 =?utf-8?B?bU1EdFpkRjc0WGNLTEtzdnp3clZpVTAwdW1PQStXSnZWVEx3aU52OENFbXdV?=
 =?utf-8?B?NUxBeHJYZndERkZwRVo0R0ZUbzFwbDF4eThhTnVITDFiUXd1SHkyNnp4aHhh?=
 =?utf-8?B?cU5XRXN4Vi80VWtuQ1lENjlkcEREU0kzRlcrUjZzc1VQajNsVXdxZTNmNmZs?=
 =?utf-8?B?c2pLODg2bTdyWVRVcDFBcFVkd1ZUc1R1Tms5b3p3TGNVbzUraWdSNHVWSnFz?=
 =?utf-8?B?V2dXRWJ4bWk0YWI4VENGcDJtK2hnWHFhSjZNemFSSWZFNXNDYlNzQ21NdmFT?=
 =?utf-8?B?N0ZyODdQS25SaDhFT3ZhTGtpMi9YcnVCaURMdVJ1SnYzWlpBVyszeDI0bjRt?=
 =?utf-8?B?M2dXOTRHVEQ3UzdJYTBDOFpTcldzUFRZUE9mcDNJbC9NbnVsMVJINTdlMEx5?=
 =?utf-8?B?R1pObkx2NkYvYXZwMUdxR050L2owbW1kWVRCZ0oxSWQvSUhranlHTmQrQXRU?=
 =?utf-8?B?WVZHUE8xc2N5VEhIMFk4MkxsR1hSWmV2RDAvK3A1cUxBbzNoZzBCcjFnTUQr?=
 =?utf-8?B?WUNlZVRZSUtVZlFXK0xBWnZzdGRZbC9UTTBLUEpBREFKVUtXMVE1ak51TEN4?=
 =?utf-8?B?TzJxNWNNTDRvTTBRczl4dzJxeWQ2K1h0UHYxeitkRGZkQ2NXdnNXQXFDTmc0?=
 =?utf-8?B?WGF4VTdzc2kvYWViZjJHYVoybzVaQmlldVlkUzVyNWJrOEJ1L0I0THkwdGZk?=
 =?utf-8?B?SDUyakNxYnYyQjN5RnJHUXJlbk85eElvSFc3REVuTmo5TGc3MzNtZmdOa0dF?=
 =?utf-8?B?YmRJcjd3RXRXaEl1RFdmSThRRkJPdDNWeTg0K1lsNWZEMWNWZ2NWZ3ZzaElx?=
 =?utf-8?B?eGVBWDN0eGFlaXM2bXpFdFltYVhLU0RvbWVqVHBrcmt6K3lUdkgvOEdDR3Vi?=
 =?utf-8?B?dHlTWXlvMS9WWUUxdHd0ejZYOERKVUVSaHVwaTYwVHBISTIyeSt4NTNDUWZ5?=
 =?utf-8?B?QmZudUFzNEJseXRza2ZleVBwcWZnZjdzQlVFdFI5ZFRDaGQrQWphL21kejVO?=
 =?utf-8?Q?zX6N0S8DKA/53M49003dq+gl8QrO7FDLF3J/SdH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdd1f09-e064-4ecf-8143-08d8d8cfb485
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 14:23:07.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdwO/gG1FYVxxYJivCUicjTM54cRNCZ3fCYmxFN7yyCs24f0Lo8qX9W0zrgGWpkLWaLtGFxdde8NjfiB1vFlXWo+Ot7g036EuOALjWHTL2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240112
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2021 5:37 AM, Mike Rapoport wrote:
> On Tue, Feb 23, 2021 at 04:46:28PM -0500, George Kennedy wrote:
>> Mike,
>>
>> Still no luck.
>>
>> [   30.193723] iscsi: registered transport (iser)
>> [   30.195970] iBFT detected.
>> [   30.196571] BUG: unable to handle page fault for address: ffffffffff240004
> Hmm, we cannot set ibft_addr to early pointer to the ACPI table.
> Let's try something more disruptive and move the reservation back to
> iscsi_ibft_find.c.
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 7bdc0239a943..c118dd54a747 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
>   	if (acpi_disabled)
>   		return;
>   
> +#if 0
>   	/*
>   	 * Initialize the ACPI boot-time table parser.
>   	 */
> @@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
>   		disable_acpi();
>   		return;
>   	}
> +#endif
>   
>   	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>   
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d883176ef2ce..c615ce96c9a2 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -570,16 +570,6 @@ void __init reserve_standard_io_resources(void)
>   
>   }
>   
> -static __init void reserve_ibft_region(void)
> -{
> -	unsigned long addr, size = 0;
> -
> -	addr = find_ibft_region(&size);
> -
> -	if (size)
> -		memblock_reserve(addr, size);
> -}
> -
>   static bool __init snb_gfx_workaround_needed(void)
>   {
>   #ifdef CONFIG_PCI
> @@ -1032,6 +1022,12 @@ void __init setup_arch(char **cmdline_p)
>   	 */
>   	find_smp_config();
>   
> +	/*
> +	 * Initialize the ACPI boot-time table parser.
> +	 */
> +	if (acpi_table_init())
> +		disable_acpi();
> +
>   	reserve_ibft_region();
>   
>   	early_alloc_pgt_buf();
> diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
> index 64bb94523281..01be513843d6 100644
> --- a/drivers/firmware/iscsi_ibft_find.c
> +++ b/drivers/firmware/iscsi_ibft_find.c
> @@ -47,7 +47,25 @@ static const struct {
>   #define VGA_MEM 0xA0000 /* VGA buffer */
>   #define VGA_SIZE 0x20000 /* 128kB */
>   
> -static int __init find_ibft_in_mem(void)
> +static void __init *acpi_find_ibft_region(void)
> +{
> +	int i;
> +	struct acpi_table_header *table = NULL;
> +	acpi_status status;
> +
> +	if (acpi_disabled)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
> +		status = acpi_get_table(ibft_signs[i].sign, 0, &table);
> +		if (ACPI_SUCCESS(status))
> +			return table;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void __init *find_ibft_in_mem(void)
>   {
>   	unsigned long pos;
>   	unsigned int len = 0;
> @@ -70,35 +88,44 @@ static int __init find_ibft_in_mem(void)
>   				/* if the length of the table extends past 1M,
>   				 * the table cannot be valid. */
>   				if (pos + len <= (IBFT_END-1)) {
> -					ibft_addr = (struct acpi_table_ibft *)virt;
>   					pr_info("iBFT found at 0x%lx.\n", pos);
> -					goto done;
> +					return virt;
>   				}
>   			}
>   		}
>   	}
> -done:
> -	return len;
> +
> +	return NULL;
>   }
> +
> +static void __init *find_ibft(void)
> +{
> +	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
> +	 * only use ACPI for this */
> +	if (!efi_enabled(EFI_BOOT))
> +		return find_ibft_in_mem();
> +	else
> +		return acpi_find_ibft_region();
> +}
> +
>   /*
>    * Routine used to find the iSCSI Boot Format Table. The logical
>    * kernel address is set in the ibft_addr global variable.
>    */
> -unsigned long __init find_ibft_region(unsigned long *sizep)
> +void __init reserve_ibft_region(void)
>   {
> -	ibft_addr = NULL;
> +	struct acpi_table_ibft *table;
> +	unsigned long size;
>   
> -	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
> -	 * only use ACPI for this */
> +	table = find_ibft();
> +	if (!table)
> +		return;
>   
> -	if (!efi_enabled(EFI_BOOT))
> -		find_ibft_in_mem();
> -
> -	if (ibft_addr) {
> -		*sizep = PAGE_ALIGN(ibft_addr->header.length);
> -		return (u64)virt_to_phys(ibft_addr);
> -	}
> +	size = PAGE_ALIGN(table->header.length);
> +	memblock_reserve(virt_to_phys(table), size);
>   
> -	*sizep = 0;
> -	return 0;
> +	if (efi_enabled(EFI_BOOT))
> +		acpi_put_table(&table->header);
> +	else
> +		ibft_addr = table;
>   }
> diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
> index b7b45ca82bea..da813c891990 100644
> --- a/include/linux/iscsi_ibft.h
> +++ b/include/linux/iscsi_ibft.h
> @@ -26,13 +26,9 @@ extern struct acpi_table_ibft *ibft_addr;
>    * mapped address is set in the ibft_addr variable.
>    */
>   #ifdef CONFIG_ISCSI_IBFT_FIND
> -unsigned long find_ibft_region(unsigned long *sizep);
> +void reserve_ibft_region(void);
>   #else
> -static inline unsigned long find_ibft_region(unsigned long *sizep)
> -{
> -	*sizep = 0;
> -	return 0;
> -}
> +static inline void reserve_ibft_region(void) {}
>   #endif
>   
>   #endif /* ISCSI_IBFT_H */

Still no luck Mike,

We're back to the original problem where the only thing that worked was 
to run "SetPageReserved(page)" before calling "kmap(page)". The page is 
being "freed" before ibft_init() is called as a result of the recent 
buddy page freeing changes.

[   30.385207] iscsi: registered transport (iser)
[   30.387462] iBFT detected.
[   30.388042] 
==================================================================
[   30.388119] BUG: KASAN: use-after-free in ibft_init+0x134/0xc33
[   30.388119] Read of size 4 at addr ffff8880be453004 by task swapper/0/1
[   30.388119]
[   30.388119] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.11.0-f9593a0 #11
[   30.388119] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 0.0.0 02/06/2015
[   30.388119] Call Trace:
[   30.388119]  dump_stack+0xdb/0x120
[   30.388119]  ? ibft_init+0x134/0xc33
[   30.388119]  print_address_description.constprop.7+0x41/0x60
[   30.388119]  ? ibft_init+0x134/0xc33
[   30.388119]  ? ibft_init+0x134/0xc33
[   30.388119]  kasan_report.cold.10+0x78/0xd1
[   30.388119]  ? ibft_init+0x134/0xc33
[   30.388119]  __asan_report_load_n_noabort+0xf/0x20
[   30.388119]  ibft_init+0x134/0xc33
[   30.388119]  ? write_comp_data+0x2f/0x90
[   30.388119]  ? ibft_check_initiator_for+0x159/0x159
[   30.388119]  ? write_comp_data+0x2f/0x90
[   30.388119]  ? ibft_check_initiator_for+0x159/0x159
[   30.388119]  do_one_initcall+0xc4/0x3e0
[   30.388119]  ? perf_trace_initcall_level+0x3e0/0x3e0
[   30.388119]  ? unpoison_range+0x14/0x40
[   30.388119]  ? ____kasan_kmalloc.constprop.5+0x8f/0xc0
[   30.388119]  ? kernel_init_freeable+0x420/0x652

George

>

