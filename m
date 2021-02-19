Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC05A31F33F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBSAIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:08:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:08:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J05FBi139027;
        Fri, 19 Feb 2021 00:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=b99Xm/o60RbWeUa14qUatLkWLv5uUeGb7gTw4ufo3pg=;
 b=A5GKai9nNdoVJEHR5PTEo4C/c9EwDCSzSwU0RWGu01TUlLKSJ43z2IdHlWWYEhXgeyL9
 9iYJ2+jNM8hnUxXxuldMXm6fuyCV43XL4NBz1LTiPfQ2EnZ7/e9hShF9bKhv3fktQXXQ
 UrouKIcmaDpoqahn3J5jmMCDt5L77+gFZTc1dlqOACAZlS1YTkMwVJOLD6tc13wu/MyP
 NLCtnKCUjVTWyOExwQ+KhuAS+nWpuNJssAiMSTxYuq1/a1UHEKecmc3sAVzBlJQKoWYf
 hsbd05dA+T539Ec28HguXDpErU1TfCMNYqsu8nKs8mFZWCC4DEuHRXJgWHxVCIgxUgSk oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36p66r7scy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 00:06:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J05iiU067666;
        Fri, 19 Feb 2021 00:06:42 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by userp3020.oracle.com with ESMTP id 36prhuxdn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 00:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfmAqVH11iwGV3pFPJrLnwFpLTyM+RF8NYBZwTsZr9HHFStLb/VdyI5and9OQVIFj1bmAV+QaQRuv6Bco9wfracLl12n6rofIFhnfBQkb7xqjB8Egtk0LHkGG1K/DJgsaaXU+mNctetCqt/DiTIhEMV/Hg1XyYcej1u+nsUbHQaic2A6dgOkcPR+bKG7jlHdbGoBR+mA/u+ul8jpwxW2kyW2BavKfHF8TRnfBf7enne9HQKp+2LxAY26UvvKvQa++9I2fprHM606UAAPMCk2vpAdOh0WadGGnyYbfyxx/24Ic+t6mFWwolssoXEOP8jTbQEKi6Yl/nas6kVvTVPI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b99Xm/o60RbWeUa14qUatLkWLv5uUeGb7gTw4ufo3pg=;
 b=NT57TbCjw1Ri09ZenGwMVcI+Pcc67bTRwLGLS/YqXAKklu5dxdqQHiyloqu1dsUL5SvPbqulCZHxIGszWkCvTJ1VxjpHUJGb1h5EbY5RqOZxXbymKLX512tEOfZ1jFjRHE22cuTZG9sV0/WBsTqJQRdlNAbaUXc+Kf5H2xuxKXgmq3Z4Jxk6UCIX8beG5qmXtVTxOjTLV0PanNiImd9eGMsbh5+/pJ3E7CkfZf89glm1Li0GwiFtHHrp9u9xo3uUWqyHWQXFNpnci7nk0fCMuZlzyRvAVZGm1pDqIL0qzFE9gqqkAuGGAhfrV2YzRdo9ZfDr8Md7NQlN5SUwuo9vGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b99Xm/o60RbWeUa14qUatLkWLv5uUeGb7gTw4ufo3pg=;
 b=wGhZLM67paCbpTN2YHqGwpTI8P9S1hbkk1i7rHhfI0M/N074Kwn8Iz5fwsE5aVIwvN6PwkYK/rm1toHPqu0a3iw3QXWwwShGbiA9aRZfFIZdwWidxd5e1sDOPg7dyrOkkftIfTg8ullob18YgthPJikYx5BszrDRwv21FKeT5xQ=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 00:06:39 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 00:06:39 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <d11bf144-669b-0fe1-4fa4-001a014db32a@oracle.com>
Date:   Thu, 18 Feb 2021 19:06:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: CY1PR07CA0027.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::37) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.20.187.119) by CY1PR07CA0027.namprd07.prod.outlook.com (2a01:111:e400:c60a::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 00:06:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae5195ec-1f48-46c9-0581-08d8d46a3ad3
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB4313E48ACF23C6D21BC83B8AE6849@DM6PR10MB4313.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xt4zQ+qJ8l4S40OqGR3D6YTnfoBCJ1kLh5jDRvWK9TNc46WhN5NGfR2nLc1ndQqdEFng/9ipfF0zLyJEljfWDEjzyY5rL9mNbDjGv/Du/xqSWqwORuPPoKQ+/sIaoSPPxRFlkIvIPpQdWCl/ZRMZPJXouWfSGffa0TsWfqlT2ZSrwvT4Gn14E1CgxM7FgwKcYQGJg0Mo27Luz6lsd8TEapVlX0BZAvKUiDnyFGegv/2VQr3K172WydKAHakNXdRpiElQgtQGMZlBSuZ7pqcxisbDKBAuK963y7oV2uUVag8Tv+Cyy7akUQ9R3bCA1BvyeibrP6bTJ7x8fYrG1zTWNxTFE9ScEHTkjU84EKyTt3qMiU5ZYAn4j/+vmlP4xldGoetPrtyl95ogYPLijxjuPFLISJis+u1ptZDLOCRrjXtdIXm8xcYYPIJFkmRP/XV1AzmL0eRebktLwiQlz1yrSnggfSrQNN4dzqVuhA7Apk1X9KQzEYizHm2X/C+Nn8si4ikbJ5D9e84Brd57ZCj2naZrcY8G+DgNRNCn1Vi+h8IrwW0i835en9UKf4JYFbdbvZsUPltJYwWg10fmBgYtD/Ch4PJlQT9OJe4PWp4OEoR6NayI6RLsYr40Kd/W05i9YKy0I8mxZ/d2Pgkfw/nDxTZHJnL2DR22Cm5OSAN7jbCvemSjQtUAS0X1nvcufVJC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(31686004)(44832011)(107886003)(956004)(186003)(8936002)(36916002)(83380400001)(66476007)(86362001)(478600001)(31696002)(26005)(2616005)(110136005)(5660300002)(8676002)(966005)(54906003)(7416002)(316002)(16576012)(2906002)(66556008)(6666004)(66946007)(53546011)(36756003)(4326008)(16526019)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFArNFFuYnl1ejNjeFdTdjJhVVVGelBhRXJFK2RoZ2tzSHYzRE9INzVTQUZz?=
 =?utf-8?B?QjJDUWJ1WThqRGRFL0ZpMThnTzJVSUFiL2JUWkdVN2QzNG14YWFublJ3UXBa?=
 =?utf-8?B?Q0o1RDRyd3NEVEFMSEJITVBhcDgzK0IwaTRReHRWWTc1bGRYU21tZ05meFJk?=
 =?utf-8?B?aWRzSnVaRkU4MEk5YTZwMjlaWHY3QklBTlNyVTh3dUhjNWRtMGZyTFY2d05W?=
 =?utf-8?B?eERGOG1qdjdMNDdhRnhSWHVpU2F2TmwyN0ppZHdNQnhVb0hTV3B6Yk5hNU16?=
 =?utf-8?B?YzR1bjZvTGZaQXhOaER3U2RWMm1GdjY3bXVkekxNK2tDV3hEMy9reTVzUFl5?=
 =?utf-8?B?TGQyN1VtZHpsWXNqTXJMMGhTOC84NTZYVUFaN1RUekdSNCtSWHZHNXdGVEw5?=
 =?utf-8?B?RzhQb0R6Z050TkdPcVlJRDQydGI5bTRmSWVyVnpjOGRVVEozTkNXdWd3M1U0?=
 =?utf-8?B?WlNreXFPZVF0dW5BNENUQmoySVNnSXlkQktiVFJobEttWGh2SHhERGZzWVJS?=
 =?utf-8?B?SWZoQkE3aWtZSTFIeVhiZi9vWXFjQ1hYa05qckd2SUFWVExNcFhOTnpxZXdY?=
 =?utf-8?B?RHJ1ZjkvYXRSdHd6VkZpZlZQdUlFMFBlbzRPdmphN3UwNndqRnlwbmRUYVVt?=
 =?utf-8?B?TmkydFRWSjIwZzg0eURrbFdsM3Nidjl3RzB4OHlkU3NMcjFrb0FNZ2dhR2pP?=
 =?utf-8?B?S3FqV3FsT2dzR2pSdGk4UGtyZnpvRk9vZWR2VDhZZktYbG9vZHJTSEx2NzBX?=
 =?utf-8?B?aGJ1bVB1MTFoZ3dwcTF4ZVA3TGhTRTZFdSt4TS9OY3hTa2ttR2h4OEhkZDJs?=
 =?utf-8?B?VXJaUVRFOG5MN2ljMStsOXAvYktZOXIvaVpsczVBMTFhaGhoRzc1YnYrdHUx?=
 =?utf-8?B?ODVITnliK2ZOMmFHQmdJVzkwdGZLK2JkM1p1MkQ0bW5QOVpGZDgzbk9Zdkpa?=
 =?utf-8?B?RVRjWnlyZnZXblRVUDF6eDFOaU1Ic3pCTFVGb3hRY3VDMUFFMzZlRXBjeHNv?=
 =?utf-8?B?QnRFMWYwY0l2OFBFd1RJYmVqS1ZWbkpGS2g2SE1GaURnaGNlOFFLeWZMUzNm?=
 =?utf-8?B?V0w1RE9TdXdWdldPSnFaeWVzbFBkcGpQeVArV3AwNjVvblVZcG41R1pxWGtm?=
 =?utf-8?B?ajFVcVd4MEVLMWV6bUJFWTBIVWJsMllvcFVmd1JPb1N5bUJuT0Z3cm00eGpT?=
 =?utf-8?B?cU5IL3pXYzlndVFEVnllWC9aSnFkU0JFcnRRTnh1RC93VXFMb2JWVGpvZTlk?=
 =?utf-8?B?RHk4R2oyRkQxQ3hQYmhNQWYzbnhQWi94c2JnSzk4Zjl1dVJCNElZVEFrcndx?=
 =?utf-8?B?THZvRFZRRkFoSmZLakZ3WE5BM1hndUw3K3YwVGxiVHNsalUxWFR0NitNVVFQ?=
 =?utf-8?B?ZkRJRjVhNWRJK0g2bXB0eVFsOHNCOWdZUGRBRGdyUGVhTnN4RUpEellCdWtj?=
 =?utf-8?B?OGVuU3hiQzcza0pibkw4Zkd5UG5RK3h1NStFdC9zaE5wYjUwOTA1eDIrSk1U?=
 =?utf-8?B?Z1hsOFVubzFlTktyYU9NR012QzNHVHZHMGJpZWUzZUJERWdpZjhydkI1WXF0?=
 =?utf-8?B?a1VuZEVCdnk2RzZ4TkhMUjlLVmMrVVdHbjVSYnhSYUxjaVdIOEExRWFPT2JK?=
 =?utf-8?B?MGhmNHFYYlVKaTdNT0wrQ3g1dkxmNkRqSlEzWXFQdlZsS0ZLclZkWHQ0NUJl?=
 =?utf-8?B?M1llRlEwcWdJZzJVU0xEWFRvUVRmU3RSS2JHTjE5RjI1MDNWWUlTWGZsK0JV?=
 =?utf-8?Q?ziql/oWPzUurbcEGBlNLSE6VipKlO9cBw8WGs2s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5195ec-1f48-46c9-0581-08d8d46a3ad3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 00:06:39.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vuz5wCTBLQ/e6UxdQs65iVFYa2Yr5BZgxmQQp00EkklF/6IYnJX6Fu1DIvMrji9wog7HN2VGnv/zjZevuSWorD1VXAtGG+ABQQoCdNRZIJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4313
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180204
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180204
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2021 3:55 AM, David Hildenbrand wrote:
> On 17.02.21 21:56, Andrey Konovalov wrote:
>> During boot, all non-reserved memblock memory is exposed to the buddy
>> allocator. Poisoning all that memory with KASAN lengthens boot time,
>> especially on systems with large amount of RAM. This patch makes
>> page_alloc to not call kasan_free_pages() on all new memory.
>>
>> __free_pages_core() is used when exposing fresh memory during system
>> boot and when onlining memory during hotplug. This patch adds a new
>> FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() through
>> free_pages_prepare() from __free_pages_core().
>>
>> This has little impact on KASAN memory tracking.
>>
>> Assuming that there are no references to newly exposed pages before they
>> are ever allocated, there won't be any intended (but buggy) accesses to
>> that memory that KASAN would normally detect.
>>
>> However, with this patch, KASAN stops detecting wild and large
>> out-of-bounds accesses that happen to land on a fresh memory page that
>> was never allocated. This is taken as an acceptable trade-off.
>>
>> All memory allocated normally when the boot is over keeps getting
>> poisoned as usual.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
>
> Not sure this is the right thing to do, see
>
> https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com
>
> Reversing the order in which memory gets allocated + used during boot 
> (in a patch by me) might have revealed an invalid memory access during 
> boot.
>
> I suspect that that issue would no longer get detected with your 
> patch, as the invalid memory access would simply not get detected. 
> Now, I cannot prove that :)

Since David's patch we're having trouble with the iBFT ACPI table, which 
is mapped in via kmap() - see acpi_map() in "drivers/acpi/osl.c". KASAN 
detects that it is being used after free when ibft_init() accesses the 
iBFT table, but as of yet we can't find where it get's freed (we've 
instrumented calls to kunmap()).

Thank you,
George

