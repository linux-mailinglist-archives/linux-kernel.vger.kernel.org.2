Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1706B308B87
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhA2R3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:29:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46164 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhA2R0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:26:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TH9YMk083829;
        Fri, 29 Jan 2021 17:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=356wpNAP4ucVosF05iyaywokeCpMh1haVTUw4FUS+8I=;
 b=NclziKo1E5V1ahUyYET83iZG6i7DodOgQv7ApRoCohV2DoExBE/C6LLzx2Xzp0srSSsq
 Cn258iVYD9ddM93s3unLX0oo6HQqJQ8yVQ/WZsPi7g93bdWAOGD6/FFo59dKFwicCTHx
 3wNkm00wgoKfx0zkPB82tD5BbHVYspdPhWW95LIgtvhY63W0/DHfWLvIfdNylG8lqVyL
 FzxsqSr0XvjUBqJqF2jqZoDBa/bpmaiHrY8Jb55WQ5uqWT5O75yCOOoxYYrvM530NAwS
 S7KnluIJD6xnvSXORhet0d7OprufBzqpEurbUNKvrrOB2VYa1KcZKPncAgc9A72OAve6 fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 3689ab2ktr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 17:24:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TH5tWK049721;
        Fri, 29 Jan 2021 17:22:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 36ceugxr2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 17:22:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai2SZs6m+X+x3uHaiR+SY0/KlbS3itBZ/aN6vcXmGfu36k76INZ5Uunzw707Uqw6JSujZrLWRMLQzpeej5TN2s+tncw9Dw7Npv5v7jOtBc3zf2bXo4y2wKuaWYbOCRWx2h7EUkmJCWkC9It7I8dMxnxtsHR9m/NKYs4PUPeOKiTmkWuIj+hJWgJ224IIVQ//2sYiD/iIjTQLxBNDdfndYVl4H0n+fR0/tfSgpPb8wpdyqSPdTNWs1RHtEJ0ukEH514SFGCF+16FME06fq3O4aFSf7B/rc7s8rKkXvL1CJERNSmpLG4FLp+sy3cx71IAq7ErV7kQimgKwPhYWj2FAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=356wpNAP4ucVosF05iyaywokeCpMh1haVTUw4FUS+8I=;
 b=Vol3k5Do/Kh/11ifODcPv+nmZJDGaIgW3jnDFHg8vPPj5JXTReWR93TzYPsmDWFq9v8f/fSwmZaMphKUUzfprEtXatkS0s5yQ6/tAJ7DsJ1BWUn9SCdn2+DO70jnkqzERgtMF3MlAnTB8hh5niHY+edB4tEDq0C4JOz/FUfrUKIjr6udtKmVinFJtWzIlD5/PHWLUYrHXBoIy6k36OOEBu8FAkLWwfHic07CtmYbWVuTL13Ez6baZEfnKNb+ItMoVWK/awcQKVuKMb4w4PFQGtc2OWpcxrwGV4NAG0g2aTu/qCSA45LDdQRo7m2k6gE5eYjMtK5TiJViEl5/GfPE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=356wpNAP4ucVosF05iyaywokeCpMh1haVTUw4FUS+8I=;
 b=tTzMUxuGMeKRAiqeuX9cLE+DLpmz1SwNk69i6thqegIpxsZ1RI4sGzNSm0BRX3vCDZ6ozI5wqBaVXjWslAqZTsfy25fWdXSjsUJYbsh0jGGHfLycZtNI/72lGVG+kE5grJrOgtf+K9X16M4pAHvFm4BonWSLtqCzlR40Iga7GoE=
Authentication-Results: namei.org; dkim=none (message not signed)
 header.d=none;namei.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4065.namprd10.prod.outlook.com (2603:10b6:a03:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 29 Jan
 2021 17:22:47 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.019; Fri, 29 Jan 2021
 17:22:47 +0000
Subject: Re: dax alignment problem on arm64 (and other achitectures)
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        James Morris <jmorris@namei.org>
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com>
 <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <CAPcyv4gxJa2YJuSjtBDYccfgsxhor8qFzpNck9kmabDo3nidpQ@mail.gmail.com>
 <CA+CK2bBJmnTVF8ZfwLyLqgjgo63G-rVQTYwUqgmx8wXFtRH9-g@mail.gmail.com>
 <c5fe4330-55e2-48b8-1961-ca9eb879354e@oracle.com>
 <CA+CK2bABVxwaw4yfgZ-Opg+aQ2ShZSt81X7cubCQJ50vZaBiyg@mail.gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <43cf3221-1797-dd17-153e-7dda003376ef@oracle.com>
Date:   Fri, 29 Jan 2021 17:22:38 +0000
In-Reply-To: <CA+CK2bABVxwaw4yfgZ-Opg+aQ2ShZSt81X7cubCQJ50vZaBiyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:189::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 17:22:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1f3cc4d-1aea-4560-769e-08d8c47a7f24
X-MS-TrafficTypeDiagnostic: BY5PR10MB4065:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4065AC818F81512E3B7286D0BBB99@BY5PR10MB4065.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYGd5qyZfkoGgAU4F2fXhpfj0KTTsc8fdSXYKV4PaGI9LfvbPuPWRi/wtVaRDQfJ6dUuXUTp+F90efPTZ0+YRJwPHN/t1lTJIFKlBo8y2Jgccr81Gs2luovp5DXzLyDVlZHPkDKNrMyoPg7LfkJKKZgRmsMBbsb+YVmD5xiZpLWW6sjs5k0dzwfq5483+aBqm/XN4JG/U3IbBI4PVyTsJ4mFYUJiFEa9T/gR5PqOxucV3iD2nyR0FTb2P7fMY2IYnILvV4SQlwbPubFC14/9AHfC7jY3yqVciZ+9q8uQRcP3TpCpfeppYAc95D+gHG/jr6r0DBdyasvxcei61Z8eGchdfI2fUZDhwaX5ztEmaDm4P27YDEXAmg9ZZaot5Cp+17bIHwokl/Ahqq61RdrpXP+D8MCl6/2hYq+qg5F1eL0Xj4mtT8Eq/WQqN+hBL4CuPfuKRhSs+3WatT7sxsbH7DAjB/e1iewtTwZE+sf+msMP4PWnxdjipLs/cEPMxkcOPRVBTrvEm13zrtA8MVDFOxz+a/B9kN51p9u5RLNnu/kA/Fm67CGwNaeBF1l6cOcIZttGB71Ec8Z/xH3Zfu9OvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(26005)(8936002)(66476007)(8676002)(66556008)(54906003)(316002)(2616005)(956004)(186003)(16526019)(5660300002)(66946007)(2906002)(31686004)(6916009)(478600001)(16576012)(6486002)(4326008)(7416002)(6666004)(53546011)(36756003)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cC9oOUhGK3BhUStDdHFhdzBBb3F3NlFIVUJJSDBlQ0xKL2EvNEkvZVJnUUJ2?=
 =?utf-8?B?bHhhL0hBckxjRFdiTi9PUis1eEhSOHVpZ1lmNjkrb0JmaEdJeWZqbGJSS2wr?=
 =?utf-8?B?TmFqdFpQdnRDNk9sWnhHSWlacW41enlqSEVrQjBSc2dqS1FsejJJdEI4YW1W?=
 =?utf-8?B?Vi85dlVRbjcvcm9McUpaSlJXdUxBSk9tdzlBWGhjV0FxMFFqRm9QbWdSVUF1?=
 =?utf-8?B?US9EUW1tc2plMmErN0c2dmpXRlBudTM1K1VEdEYyWVhrdTR1czdibHZiSzBU?=
 =?utf-8?B?enhONFF5ODZWVUdIdnl0ajlRRnRqQXhXancyVGNjanNLZmdrN0pNR3k5MHln?=
 =?utf-8?B?QUlyTElpY1pKU20wc3p0UlE4Qjk3cHRtQk0yUjZJeEdlTGlWYmxERE9oK1kw?=
 =?utf-8?B?MFF6NXJjVzd5TWRGaTJyZVhhTW9OV0p3MkQxOTlodkZ3dDhmREd3R2xsMzZB?=
 =?utf-8?B?VTBWRXJlNmpTb0ZLajZkSFBEUXB5N0dRTGkzTFFEQ2F4V01WMWZycmQrVkJq?=
 =?utf-8?B?VThCKzNWSWFYeFcvemlaUjl4Ny9jd1JDdm8wSUkwVkcxMmdrWkZwZ0dHSDk1?=
 =?utf-8?B?eG5mdnRCZnA5MVMwaFRyQk1UakxXY2o5MlF1bGRhU3BqU1p1YjIvcHE3Y0NX?=
 =?utf-8?B?VjBKRzdFczJrQTBOTFJIcE43bnBRbDFPY0tCYTREbzhnZmg2YzQ0bFFoeVVK?=
 =?utf-8?B?UHBxOVBvbGtaenRHbGROVGRySUhxRFh0K2EzeUlxUkNNQmNnMGFqSERiYXRV?=
 =?utf-8?B?SzFhaEpJeUswMW5ZSWFUYjlyQVVhUDJ0RWFocWtsSDJxbEwwc3Z6ajIwbVZX?=
 =?utf-8?B?OUU5RWgxYkV2RWJNTDNycVBVM0JtUkRmMjFQbVUwMGplb1MxUTgxZ21wckw3?=
 =?utf-8?B?MXBBdE8wa3lqMkhGNHdQWHppQi8xTGZpYStoc0svY0xEMktzWHd2SVVabVZZ?=
 =?utf-8?B?OE9abDhjSXVPMUZHNVpuQTY4N2M4QlpSSGpIWm5jVWpFb1B3WFIwWU9WTnpR?=
 =?utf-8?B?b01lRDFEOXVNbksvV000d2hJNXBsbThkQnhlZzJ2c1BvQ1lLdEcyRVFtZ3c3?=
 =?utf-8?B?OGhmbkxjakxoUytrMjBEaGRSWldsUEJldW9ES25wT2NzRG4wcWluRkNpMHZH?=
 =?utf-8?B?ckxKYzdPOUxyQWhBTHMxLzVzbXFYV3gvSUFQNGdQTEE5NURxcFNwaFFuQWti?=
 =?utf-8?B?dkxxS0U2Zm1Hdk96MUlrTWpMT2lFSnZ4T1MzbTBqazZIZmhWeUpNWlZLeS9V?=
 =?utf-8?B?ODB1NEZwaDVFK0lPNi9NYUtiUzlncE5wcGxYa09zL21KNjdXVTZXQVlOT3dV?=
 =?utf-8?B?MWNmdjVGQksySFdud1dUdHZqMkd4bjNDVXMzam1scXZDbjUvbzRmTi94VlQ3?=
 =?utf-8?B?Y2dhS0xnK2U5cnFTaWo2QVRhNDkzVVliUjFVQWkwekQ2QUd4Zmlpbnl4OHdW?=
 =?utf-8?Q?6Pl5lWz+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f3cc4d-1aea-4560-769e-08d8c47a7f24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 17:22:47.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5DLWhxui2axYEFR4bR3CGqPE74I3SrCRwPqGKIW9hl2zLNEMEpATBbGXicJMXs2QeVSe4i+rCOq+zwMx7M/q2DhvT8YsKWxi+U1QMhrvwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4065
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290084
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 4:32 PM, Pavel Tatashin wrote:
> On Fri, Jan 29, 2021 at 9:51 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Hey Pavel,
>>
>> On 1/29/21 1:50 PM, Pavel Tatashin wrote:
>>>> Since we last talked about this the enabling for EFI "Special Purpose"
>>>> / Soft Reserved Memory has gone upstream and instantiates device-dax
>>>> instances for address ranges marked with EFI_MEMORY_SP attribute.
>>>> Critically this way of declaring device-dax removes the consideration
>>>> of it as persistent memory and as such no metadata reservation. So, if
>>>> you are willing to maintain the metadata external to the device (which
>>>> seems reasonable for your environment) and have your platform firmware
>>>> / kernel command line mark it as EFI_CONVENTIONAL_MEMORY +
>>>> EFI_MEMORY_SP, then these reserve-free dax-devices will surface.
>>>
>>> Hi Dan,
>>>
>>> This is cool. Does it allow conversion between devdax and fsdax so DAX
>>> aware filesystem can be installed and data can be put there to be
>>> preserved across the reboot?
>>>
>>
>> fwiw wrt to the 'preserved across kexec' part, you are going to need
>> something conceptually similar to snippet below the scissors mark.
>> Alternatively, we could fix kexec userspace to add conventional memory
>> ranges (without the SP attribute part) when it sees a Soft-Reserved region.
>> But can't tell which one is the right thing to do.
> 
> Hi Joao,
> 
> Is not it just a matter of appending arguments to the kernel parameter
> during kexec reboot with Soft-Reserved region specified, or am I
> missing something? I understand with fileload kexec syscall we might
> accidently load segments onto reserved region, but with the original
> kexec syscall, where we can specify destinations for each segment that
> should not be a problem with today's kexec tools.
> 
efi_fake_mem only works with EFI_MEMMAP conventional memory ranges, thus
not having a EFI_MEMMAP with RAM ranges means it's a nop for the soft-reserved
regions. Unless, you trying to suggest something like:

	memmap=<start>%<size>+0xefffffff

... To mark soft reserved on top an existing RAM? Sadly don't know if there's
an equivalent for ARM.


> I agree that preserving it automatically as you are proposing, would
> make more sense, instead of fiddling with kernel parameters and
> segment destinations.
> 
> Thank you,
> Pasha
> 
>>
>> At the moment, HMAT ranges (or those defined with efi_fake_mem=) aren't
>> preserved not because of anything special with HMAT, but simply because
>> the EFI memmap conventional ram ranges are not preserved (only runtime
>> services). And HMAT/efi_fake_mem expects these to based on EFI memmap.
>>

[snip]
