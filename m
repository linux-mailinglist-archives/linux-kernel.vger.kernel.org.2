Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1018332538C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhBYQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:32:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBYQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:32:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PGOn43068735;
        Thu, 25 Feb 2021 16:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=y9Uxf+ovDt8dVG1i2gdd43HkzuCNT6PPStUcel9/K+s=;
 b=KgyUdtNgV/BxtzfmmKRMHqLK/q1+IO5KJFv+80deFI8d0ThKcnOaw9cJ73bvKzpBlOBR
 YIeKv6PqhijFjC8deNlG/PA2/eYBi/ClCv6CE6wE02WNYcxMkNjPYOnqLAvi4KqnuXKA
 lQGZ15e66AUL23zrqo3rVlsHb6T4ftCs6SjBUL8qYEvxsAuRberLWkRQukN9/E5yb4p9
 6Ij1l3zl1kT13F3T88+SybLwx9+aeO/Rn/dlcvxr8DLIatTw1n/OBNPQuVuXjrK6dAe8
 McQDj+i7Jz8UdC+EaPWcKOfEw+ygqu6HenuKprDI4fFeGokYGrNwq7OTT6VwbEUroC1y Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36ugq3nxv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 16:31:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PGKJrB086970;
        Thu, 25 Feb 2021 16:31:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 36uc6upum4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 16:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz6PBdBUD+QL04TvFeRj9ZgGnQCI2fD/Vh4JzNzSJi1V0Zvh3H0gMAspPp+f0+RukRy21IGlyC5kYPv8aABJdpuPRjSiQGsLI8A61ci2uRdvmoWNjxJSfAT2Vm1LK2U44pGp4TYo53RVIYk+5OS6nOnhE4wNrYpP6NtIBlQua0fyYDlV2O+OvaBEoNY5oGPe9hHLdwt4NBSA4ZianEJMxDG5HfJpnAQ8tHdEuhGPADWlFvcH/9pVCe+/rEo/XDgVCNYHIsCqSPqcNlGVJioQhPsRAiu8Lyja87graqMOuCwgWHaLG9ZuB14AmLR9gWLNWb/327dcyIGl8mdtLJNpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9Uxf+ovDt8dVG1i2gdd43HkzuCNT6PPStUcel9/K+s=;
 b=oTmaTTB7aFO5zYWiolzqUy3wWbdcV/tEMo7Lz8rczfNC/2/2S9WESkcNKQG8xSGRinWw9DLfqvudU2gmgekC3ZWdcJc5BXmmy7bFf+SUIoIs80YX5Zq9dkGzegsyhw1X+k+cro6CNi3nsAUWqXuU7AZXvTY8uvDVXwThlXBFyEZT+cdH1gjqoQX7sLxwzwuzVCB8r5lNGVurTnInxchl6Hvjm+Bu7IXHasi0zeXHas+xL3ufMdbj4u8/o3Hu46/MMBjwqAC4UWTyDP4m0il/C/qRCeiol28cnYG4jhWzXPCN3C3u9UYHgiTfkOoUnxG7Ab0FdZsjpBDVyyee6z7K5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9Uxf+ovDt8dVG1i2gdd43HkzuCNT6PPStUcel9/K+s=;
 b=K0koCRUN3Hw4jVfqAvhdAlBeK6V5U4cBgiUqoi5Sr0lxtSXDlxfqrQQTpiW6sDvUf5RlSdZ5ZKr7NfdWp4e4rs5U+GDBsf981O90JElkrQv4/8BGQ+8ILjkRGFQXGWjP4tsneoMsZf3A1PQ9Ov2dWSnbsWSUhuBHMg/qgcnVk88=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 16:31:08 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 16:31:08 +0000
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
References: <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <dcf821e8-768f-1992-e275-2f1ade405025@oracle.com>
Date:   Thu, 25 Feb 2021 11:31:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210225160706.GD1854360@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: SN4PR0201CA0004.namprd02.prod.outlook.com
 (2603:10b6:803:2b::14) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by SN4PR0201CA0004.namprd02.prod.outlook.com (2603:10b6:803:2b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 16:31:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: add4ed1f-7fc8-422e-9c8b-08d8d9aac0fb
X-MS-TrafficTypeDiagnostic: DM6PR10MB4249:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB4249DDF1C3E6A09DA6F5090AE69E9@DM6PR10MB4249.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcD7NAmqYqWpeD4Mo855Mc+f4SqztlXpfdtfHejUn7J45YhYVav35Rg832kFfwra94WVd9/x4Z3b1v1bWMSIlZPr6eblUlaPIWsXARb9ZTGS6KfNnx+BzguNEOvzMZyG3Yiox2ssgNJTBd72C8D1LYEObhyckW0tIUfmhgd0Ypedx24ER5zXdCjgrGVsvmxNxWjRhDz9F8lv8A2GzD4cAaC1V+JoAqCM84NYhoi8HqoSMhjS8bbBLNJH+AN92UsIM0S6XZnYAVgQNuR+jKgtjDd3mr38dcXJPfi6Ypnpt+1mSDfs58mGVbIhHh464S8hKFw3aYljOCvh66/tWN7/9Lb7GgLdCFs56EjbymJw5tqyvSlpXOtHdeH7RXXoih0gy1VeW+ZSjXiKkAv1jdS2lSlsHvS6BSfuBmKn3XgYjH2jmD39vQeySDY1cieBMVlLFxXMY9MFo8fI7ao1De3goVJwvOFf+Dc810hgTrLqR8nph91XsghevAr4oqfTy7VFL3PN7QSnDr5g+I//bSaAx5UA9RIq9NYOW06AhdFa/n5gZABpXsdjPhtJrI0lEbo9CqrmNAR3Kp+Y9GSAY71Zomc11odqXCnKaFpzt1xkEEe6is0h5QwkfClsMBMjvYuc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(4326008)(478600001)(6486002)(31696002)(107886003)(86362001)(66946007)(36756003)(66476007)(31686004)(66556008)(16576012)(36916002)(956004)(54906003)(2906002)(8676002)(8936002)(6916009)(83380400001)(53546011)(7416002)(5660300002)(44832011)(2616005)(26005)(16526019)(186003)(316002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UXlkL1U3RzN4eWlMeHA0dVdHblN4aVJFbUtOTEk3eTJOd0xKa3J6YnFoeEcy?=
 =?utf-8?B?WDFlWU5iOFhBazVlL3VIUEQ1M3pnVWxpYTRHYkNIM0FYcDRZelh3Y0pHdVds?=
 =?utf-8?B?RDRPQSt1ZzZlaUJQRzdoV1VWOEw0NXFkNXQwR0xHaDIycXhWYldyaUcxcFhz?=
 =?utf-8?B?K0JiVVYyMnFrOEtVU2VSb1BzWE5PTTUxU2svWWRpdDFSL0tJaks5VXpjWFlq?=
 =?utf-8?B?UTJqdGlLSGs1Z3l4eGxxTFpVMWE5YU1mK1NLMS84R1dVbmRER1puSFM3dWcw?=
 =?utf-8?B?QzhHaXBtVkZaVDhWKytZeHZDRFJONU1xUDJZeDg1d0pTUGRmSUhraWRuYkFn?=
 =?utf-8?B?cExXbVFHZmw0MkU5QzlIRG9XUStpcE9KcEFZRlhoanRXWUpTS056YWcra1ZE?=
 =?utf-8?B?WG1oK0sxL0RyUmNpWlR0OGpFejN0cCthVjlUNUhxUWRnMjcwaXFBTEZ3ZHd2?=
 =?utf-8?B?d2FjbkhJUzg5WEo3cTA5THlqMnBsQ3haWVA4MzVIWFBwUnBXZ1Jkb1V6enMx?=
 =?utf-8?B?cFIyRERWUjhxK2tmMUUxL2doaXVkblJIZ3Z1K3VoaGgrTUxTNXpmSVdGNWJv?=
 =?utf-8?B?bml0WUpCUUFEaGJ0Vkl0SEtQYVBMRHlabUUweFRCU3dhazdJTWxWa1p5MUVZ?=
 =?utf-8?B?WUlSQk9KenA1VkdDaUdCZ3dzTmhQT0tzNUpIYmp1SjhITkJsL0RnWTdXRUt5?=
 =?utf-8?B?UXhZcHF5aEtmbll4TnY3dUZITURsZUZ4VHF2UU9DdEpObnpPSWpjTTJCcWZN?=
 =?utf-8?B?ZUU2Yk91RHA1VTF4Q1RjU2dqT0RXTWpZY2c3NWFmMnl6QnQ0OWRuK2UvWXRD?=
 =?utf-8?B?cG8vNUdxeHFGWlFVUSs1dGpBc0pXaHBTU0xpQjdIc2FLbys4K1g3aXE3NDVB?=
 =?utf-8?B?bThrRm9pSDhTMHY5dFJ1RUJwOThOV1F2UExzLy9PSXluUWNhVTFiTGlMYmNO?=
 =?utf-8?B?ejVRaERsakJVUUZFMTJvekVCb0tkWVl2U1ZTV3V6OSt0enBqc2lxMzhQTUp0?=
 =?utf-8?B?SkdFblJHM2IxQWtkNnpQSjFTMnR6bkxRbjd5YVVvc2R4eGtDVW9FSU9QYksz?=
 =?utf-8?B?b1lLdEdqQ2hlVU5Uek4yRjltdHVlZ2dXWnlpVzZsUUtHa1RWRmEvWktsNFlJ?=
 =?utf-8?B?M0RXNlNiMFhLclhjY29FSGcvUHBISzVnM3REcmtJZlhORWpaS3Z0LzZhQUFo?=
 =?utf-8?B?aE1scmdQdVJaTlVYNnBrdDcyMGRFalFha1hINHN1ZWlTOVA4VVN0UkxUeWpa?=
 =?utf-8?B?cWdwcFJXT3dxakQ5VnIxR2k0ZkVabGtLYlJTSjV6SGw1bkFQVHVXL3BGUFBL?=
 =?utf-8?B?T0dIRnVLVHpuTmU4YUFTZ2MyOFJQZXNXTGgydnYxOVhZS00vMmxWZWQxdnQv?=
 =?utf-8?B?dnVVUWtmVmJWVVljR3NZTENVNlgyMC8yMkIrRnhDb016ejRMckY0eWRqVHZP?=
 =?utf-8?B?aDNnL21ibW5HZkFMZTQwbnNTbzBRSXZ4Z0xXZmpFQzNGclRtQitHZ0xCbG9B?=
 =?utf-8?B?L2hnWmFGTllLQWVkaGZ4aDByTGpmUHpZMkppQlJYdXBKWURFZnRETzE0NEhs?=
 =?utf-8?B?VitvWWtrRWFFNHdRekRwdkx0UGF2WlJyQXBXaVZocUZiNmNERmxORlJDUnlw?=
 =?utf-8?B?cnVzZnNjNFBrWGhrc0ZSSmtEckJwTWUvVitPNnZ3TDJ2RjVaZm5odEdXK0Jq?=
 =?utf-8?B?ZWRqd2RIMlFmaGJtTE9QalF2a0ZtalRrQnBGaXMydEpzd3B2Mm1paFFDWE1r?=
 =?utf-8?Q?7PLxEc7HIzhKXDVe+m48EEkf8bSG8TcV7RezoGM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add4ed1f-7fc8-422e-9c8b-08d8d9aac0fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 16:31:08.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Os136eSQwwAMHahiE+52c+Afmie+2JlWNFdqkDZqbxTV+PITBb70wWc9Xdz8w5mUNcl6zrv5k29pIW67990qfcxaAFHgVb1sb0x1iihEFTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2021 11:07 AM, Mike Rapoport wrote:
> On Thu, Feb 25, 2021 at 10:22:44AM -0500, George Kennedy wrote:
>>>>>> On 2/24/2021 5:37 AM, Mike Rapoport wrote:
>> Applied just your latest patch, but same failure.
>>
>> I thought there was an earlier comment (which I can't find now) that stated
>> that memblock_reserve() wouldn't reserve the page, which is what's needed
>> here.
> Actually, I think that memblock_reserve() should be just fine, but it seems
> I'm missing something in address calculation each time.
>
> What would happen if you stuck
>
> 	memblock_reserve(0xbe453000, PAGE_SIZE);
>
> say, at the beginning of find_ibft_region()?

Added debug to your patch and this is all that shows up. Looks like the 
patch is in the wrong place as acpi_tb_parse_root_table() is only called 
for the RSDP address.

[    0.064317] ACPI: Early table checksum verification disabled
[    0.065437] XXX acpi_tb_parse_root_table: rsdp_address=bfbfa014
[    0.066612] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
[    0.067759] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP 
00000001      01000013)
[    0.069470] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP 
00000001 BXPC 00000001)
[    0.071183] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT 
00000001 BXPC 00000001)
[    0.072876] ACPI: FACS 0x00000000BFBFD000 000040
[    0.073806] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC 
00000001 BXPC 00000001)
[    0.075501] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET 
00000001 BXPC 00000001)
[    0.077194] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2     
00000002      01000013)
[    0.078880] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP 
00000000      00000000)
[    0.080588] ACPI: Local APIC address 0xfee00000

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index dfe1ac3..603b3a8 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -7,6 +7,8 @@
   *
*****************************************************************************/

+#include <linux/memblock.h>
+
  #include <acpi/acpi.h>
  #include "accommon.h"
  #include "actables.h"
@@ -232,6 +234,8 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 
table_index)
      acpi_status status;
      u32 table_index;

+printk(KERN_ERR "XXX acpi_tb_parse_root_table: rsdp_address=%llx\n", 
rsdp_address);
+
      ACPI_FUNCTION_TRACE(tb_parse_root_table);

      /* Map the entire RSDP and extract the address of the RSDT or XSDT */
@@ -339,6 +343,22 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 
table_index)
              acpi_tb_parse_fadt();
          }

+        if (ACPI_SUCCESS(status) &&
+            ACPI_COMPARE_NAMESEG(&acpi_gbl_root_table_list.
+                     tables[table_index].signature,
+                     ACPI_SIG_IBFT)) {
+            struct acpi_table_header *ibft;
+            struct acpi_table_desc *desc;
+
+            desc = &acpi_gbl_root_table_list.tables[table_index];
+            status = acpi_tb_get_table(desc, &ibft);
+            if (ACPI_SUCCESS(status)) {
+printk(KERN_ERR "XXX acpi_tb_parse_root_table(calling 
memblock_reserve()): addres=%llx, ibft->length=%x\n", address, 
ibft->length);
+                memblock_reserve(address, ibft->length);
+                acpi_tb_put_table(desc);
+            }
+        }
+
  next_table:

          table_entry += table_entry_size;


>   
>> [   30.308229] iBFT detected..
>> [   30.308796]
>> ==================================================================
>> [   30.308890] BUG: KASAN: use-after-free in ibft_init+0x134/0xc33
>> [   30.308890] Read of size 4 at addr ffff8880be453004 by task swapper/0/1
>> [   30.308890]
>> [   30.308890] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-f9593a0 #12
>> [   30.308890] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 0.0.0 02/06/2015
>> [   30.308890] Call Trace:
>> [   30.308890]  dump_stack+0xdb/0x120
>> [   30.308890]  ? ibft_init+0x134/0xc33
>> [   30.308890]  print_address_description.constprop.7+0x41/0x60
>> [   30.308890]  ? ibft_init+0x134/0xc33
>> [   30.308890]  ? ibft_init+0x134/0xc33
>> [   30.308890]  kasan_report.cold.10+0x78/0xd1
>> [   30.308890]  ? ibft_init+0x134/0xc33
>> [   30.308890]  __asan_report_load_n_noabort+0xf/0x20
>> [   30.308890]  ibft_init+0x134/0xc33
>> [   30.308890]  ? write_comp_data+0x2f/0x90
>> [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
>> [   30.308890]  ? write_comp_data+0x2f/0x90
>> [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
>> [   30.308890]  do_one_initcall+0xc4/0x3e0
>> [   30.308890]  ? perf_trace_initcall_level+0x3e0/0x3e0
>> [   30.308890]  ? unpoison_range+0x14/0x40
>> [   30.308890]  ? ____kasan_kmalloc.constprop.5+0x8f/0xc0
>> [   30.308890]  ? kernel_init_freeable+0x420/0x652
>> [   30.308890]  ? __kasan_kmalloc+0x9/0x10
>> [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
>> [   30.308890]  kernel_init_freeable+0x596/0x652
>> [   30.308890]  ? console_on_rootfs+0x7d/0x7d
>> [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
>> [   30.308890]  ? rest_init+0xf0/0xf0
>> [   30.308890]  kernel_init+0x16/0x1d0
>> [   30.308890]  ? rest_init+0xf0/0xf0
>> [   30.308890]  ret_from_fork+0x22/0x30
>> [   30.308890]
>> [   30.308890] The buggy address belongs to the page:
>> [   30.308890] page:0000000001b7b17c refcount:0 mapcount:0
>> mapping:0000000000000000 index:0x1 pfn:0xbe453
>> [   30.308890] flags: 0xfffffc0000000()
>> [   30.308890] raw: 000fffffc0000000 ffffea0002ef9788 ffffea0002f91488
>> 0000000000000000
>> [   30.308890] raw: 0000000000000001 0000000000000000 00000000ffffffff
>> 0000000000000000
>> [   30.308890] page dumped because: kasan: bad access detected
>> [   30.308890] page_owner tracks the page as freed
>> [   30.308890] page last allocated via order 0, migratetype Movable,
>> gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 204, ts 28121288605
>> [   30.308890]  prep_new_page+0xfb/0x140
>> [   30.308890]  get_page_from_freelist+0x3503/0x5730
>> [   30.308890]  __alloc_pages_nodemask+0x2d8/0x650
>> [   30.308890]  alloc_pages_vma+0xe2/0x560
>> [   30.308890]  __handle_mm_fault+0x930/0x26c0
>> [   30.308890]  handle_mm_fault+0x1f9/0x810
>> [   30.308890]  do_user_addr_fault+0x6f7/0xca0
>> [   30.308890]  exc_page_fault+0xaf/0x1a0
>> [   30.308890]  asm_exc_page_fault+0x1e/0x30
>> [   30.308890] page last free stack trace:
>> [   30.308890]  free_pcp_prepare+0x122/0x290
>> [   30.308890]  free_unref_page_list+0xe6/0x490
>> [   30.308890]  release_pages+0x2ed/0x1270
>> [   30.308890]  free_pages_and_swap_cache+0x245/0x2e0
>> [   30.308890]  tlb_flush_mmu+0x11e/0x680
>> [   30.308890]  tlb_finish_mmu+0xa6/0x3e0
>> [   30.308890]  exit_mmap+0x2b3/0x540
>> [   30.308890]  mmput+0x11d/0x450
>> [   30.308890]  do_exit+0xaa6/0x2d40
>> [   30.308890]  do_group_exit+0x128/0x340
>> [   30.308890]  __x64_sys_exit_group+0x43/0x50
>> [   30.308890]  do_syscall_64+0x37/0x50
>> [   30.308890]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   30.308890]
>> [   30.308890] Memory state around the buggy address:
>> [   30.308890]  ffff8880be452f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ff ff
>> [   30.308890]  ffff8880be452f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ff ff
>> [   30.308890] >ffff8880be453000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ff ff
>> [   30.308890]                    ^
>> [   30.308890]  ffff8880be453080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ff ff
>> [   30.308890]  ffff8880be453100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ff ff
>> [   30.308890]
>> ==================================================================
>>
>> George
>>

