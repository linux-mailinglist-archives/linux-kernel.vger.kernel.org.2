Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85C357291
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354450AbhDGRAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:00:51 -0400
Received: from mail-eopbgr700058.outbound.protection.outlook.com ([40.107.70.58]:45536
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354443AbhDGRAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV8nDkyxLIGV+VmNFFWjNWHHUztHmAE4muZg2QYgiTxBDc/+dPBOlDwvFIiA6G15Z2/eOwqkc3BU8F77Gq488F1TT29iYJ8LPYbBvlM/aTXxb6Lu/xxltmbJsOLCF5vNReIWQ6qjMOzkZdGIHDCvc2gjjkTpQ+Pmvnc6Y5TAtpGXK3QrhP/amqTSn0Jg/nvyFoNFpDeMd7JxenIYqN45mgIebUwKr/Q3rjbHkZbMAZcH+S6ct/caqf+Y1zxg2Vy3l72FoNQDf5Lf0lBE6WXNGBVIGOcAPfk1rAasYwpKfYVpya3dfI6TnMUnWppXbyiakmYxAaCDOL9rgiV+fQ/pAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLCJZB9K+k0MFv+3Ihd4/WBMz7II6iPHvJBFeDfXrEI=;
 b=LpMFI51bVAz8+MyE8itsce/haF5jXVw0pXORcwtOMLEWiDOkfeSb7Z/eBYLvZCsNagyGnn8LMswodCAw7SXxH+6QjUc4iGJaLqZLH9ZRosJRia5VDx+ydkwmsnEp1pdB85e6jFfaUcybrCTJ3qjr3XZ3o+ywMhks+SoeS1JoIn4xdrBD2M87BRLdquedQNh5nNEwkx3qd7bQ6Uab3ZIp8qLa5T1mdKItBCG5a4sMkwIyCviHp4BzJKSWfcsGIXE+3NoD7Ua2d+ePz3oYIc6CUmQsjVbb1djbH2TU5VWzD6kH/df+Q1fxqfmMYUxDKLvHggXd599J0G9CsF783QcQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLCJZB9K+k0MFv+3Ihd4/WBMz7II6iPHvJBFeDfXrEI=;
 b=Le97RzQjYUyQYHElKEhCfe0gFy7zRyjz8Jaiu5NPMB3jI0Nf6QHlHiV1Ul0e5iyOK8imiggJJKSTbz7iOujOpi6LTW/LhLqtNHZuhKky3FXJRZTTE1+jJpi3eWfwwIGpRIp3hAxEYOPmtuSwRNnk+YfAHlsFkn1b1cYNvlcDhLE=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=vmware.com;
Received: from MN2PR05MB6624.namprd05.prod.outlook.com (2603:10b6:208:d8::18)
 by MN2PR05MB6111.namprd05.prod.outlook.com (2603:10b6:208:c1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8; Wed, 7 Apr
 2021 17:00:37 +0000
Received: from MN2PR05MB6624.namprd05.prod.outlook.com
 ([fe80::603b:4954:dbec:c02]) by MN2PR05MB6624.namprd05.prod.outlook.com
 ([fe80::603b:4954:dbec:c02%7]) with mapi id 15.20.4020.016; Wed, 7 Apr 2021
 17:00:37 +0000
Subject: Re: [PATCH] arm64/mm: Fix mapping_dirty_helpers with arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210331182344.47987-1-zackr@vmware.com>
 <20210402112657.GB29774@arm.com>
From:   Zack Rusin <zackr@vmware.com>
Message-ID: <a44e78dc-0761-cdf4-fbf9-f2395b40aa55@vmware.com>
Date:   Wed, 7 Apr 2021 13:00:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210402112657.GB29774@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [108.36.85.85]
X-ClientProxiedBy: BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) To MN2PR05MB6624.namprd05.prod.outlook.com
 (2603:10b6:208:d8::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (108.36.85.85) by BL0PR1501CA0009.namprd15.prod.outlook.com (2603:10b6:207:17::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 17:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b46ebcbc-bb81-487e-ca6c-08d8f9e6aaa2
X-MS-TrafficTypeDiagnostic: MN2PR05MB6111:
X-Microsoft-Antispam-PRVS: <MN2PR05MB611177EF1911CE67D9BCF405CE759@MN2PR05MB6111.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KY4D82wnEXpgamVONugg8hI6xUNzcqrhDERf7QtQgHunTZfLKXKWU+X5kS9ZAhDbqLlBghcj6b29qDhp/50cfDpVOvxZj0mjx9UL2/mcQRCe4Y3Qfcc1rjxhC0Im5DHZRDni/KuJesFsUVFM1DzVD5fDZSMuwlX8DrsGSfelX0yEd98KhHlXF95pmfUywdxODMaVS//5Hw8mfAXNnd2neKEmp2ThejmJdr8lTi93Qmjzp44lg++fghSQtFX0jrrVPF8ZsYYWBOddfrwyU73IXuP3a2HdPGkGSHYuhRIbV/waSlEYXdLhSO67loYKYrCMYfj7R9j+Z7DYa4cCJC3WRTE8xhlWLMpthaXKtxhnPfx0mRSGvKfCSEn5jyI4U5z+l+K2AorJnkzcWGEMNitTLOVD0looSPW5YyrDaVtG0n/PBGyuhtCDeI6ltNqzuLkZ8sRc9Ka2lnFhD+GG183rVX3GK1Hr4HSjBq7+x6ss5stRpDWkk+DmfIfNRIzle3fmbl2RUDsLbqdk0Qy4ejv/DOIi6rN42I6bse4sOD8Q/38r3y05A1wqv0+0jKEnUEcu1Et+R9FiDmDGbMQk3V4yO1y8c4YLv5JNTS3/VPRgs1Ihs0CjZYlFx0BAbs67cVWH2s2iVQ29zkZGy/2KxMon3O9oqAHsQkYRzRDIQ2TMrJufgUm+kh/Ks1cbdAz+T4EjK9/FOeQjixeNJIF4eYV0JFPntvP3j7XJcLEOf0WaqqglQpgH8dGN2jR6uWhtmqpo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR05MB6624.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(54906003)(31696002)(8936002)(16576012)(36756003)(38100700001)(4326008)(66946007)(478600001)(53546011)(86362001)(6916009)(8676002)(83380400001)(26005)(66556008)(16526019)(956004)(186003)(316002)(5660300002)(2616005)(31686004)(2906002)(66476007)(6486002)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QktaQUhSaVJoclQ4NGFzQStpK1g3blAxUHBFVmhzbW5LUWRqclE2Y0Q3QUNI?=
 =?utf-8?B?cUpqTmVGcXh3ZnRHY0hMWVMwNlJXNXlrakdVQ01uRU90M0tsRHU2c3V0Q0NM?=
 =?utf-8?B?TkJMVThudlE1UGxPK29xOGFwSE1mM0dtZWpXa3ZFU3FxMGJwS1VSS3pxdDh2?=
 =?utf-8?B?T2RNRktMd05pQm5vcjNreERnbDZIb1hicW8yaVYrQkJTUmFHdk1SaGRTVW15?=
 =?utf-8?B?dWVicWFTeDZqclBmMVFjeWxYdVRPMWFKbW5iUU0wOEhZOEl1cVRjTDdwS1ZT?=
 =?utf-8?B?WklmV3pxQk9FeVJCVDFCOUFROWpZRk4vdmNFZFJIbzM1U1R5Vmx5TDVxa1VG?=
 =?utf-8?B?M1lUMHh0L0pidVlXRlM3UFd2R1NZMlQzSm12WktKWUJieXRicHRHNzdyVklF?=
 =?utf-8?B?SEZBNENVVWc5bS9JaVVHTEw2eGM1dHV0OTkzc3FzVDBFT3F5UFhiUU5yQkpH?=
 =?utf-8?B?MSs1YUJvK0tYbGJhU2hBRnc5Slh5a0Z6QWd4OEcyaXdSY0E4Y21XK2tVWTdi?=
 =?utf-8?B?andNdnluSW5mTE1aSWFXanB0NVRTSEtmOVU0dFFVNldsUnloYkV2Ym5BOU1I?=
 =?utf-8?B?ODM3NVN2MHcrVFVKOXA1SkdrblZJemVWOCtmUEE4SkRMeWVUblZiS2lTcEVY?=
 =?utf-8?B?VkEzTHdmN1VTMElzR2RrTGV6RHJZaktFM2wyUDFHcGp0a29pSTU4QWVxYnpv?=
 =?utf-8?B?WXlITlVnVGlIUGc0RDFJZm5mNnVUL0tZc2hPU2FCRlJ6dmVJMk4xN0Fyei9p?=
 =?utf-8?B?UkNjQXRGWU1jcXRIOHN2clE1U1B0OUcxYlYreTBqZU8vMFpUYTczVmhoa3BT?=
 =?utf-8?B?K2tucGdJNjVhNlBYb2ZIZ04zTEVsVml1a1AvQzViYWMxZDBRaVJJWFNWMXg5?=
 =?utf-8?B?citpeFJHUW5BcHdYdVErKy9lbHlFQ2QzaHM2QmdhdWo5NVlrcEg5VUZiZFA1?=
 =?utf-8?B?b0hHRFZaNzk5Nm55eTRwUGplWnhKZHNMSWlyaU5iaWRyNExZWEJ5QmIvalgw?=
 =?utf-8?B?S01VZFVhZVlvNm9TSTZyS3ZzN0hJOXZqbUlNQisyVTFyZGgwWWdjZnZqM09s?=
 =?utf-8?B?TVBYZmQzRXBhUG1xOC9wWXhrc2J5OGhYWXl1VS9Kd05IREdvT3ZzdjhNbTJE?=
 =?utf-8?B?VGozdnhiQVZFN0x0TktNcGF2bDUzNmhrTlNYSTFxZ1hVaEhkT2lDejE0UDhW?=
 =?utf-8?B?V0ZzZEtsYmxSaXByZWJDKzBaYm5IV0UyZHVZWmZGbHBHNGhCNWpTWTBmKzkz?=
 =?utf-8?B?L1BWMUE5TU0xVm00eHFNOXp3b09UTXJvTVVjVmNwK0djYzV5eVhUZUhsSmdZ?=
 =?utf-8?B?V1VzSjFjYWJVYkVSd2hRZ0oyOStFaWlwM21pZGQwV1kzZFNNSVZpcDNtWUFM?=
 =?utf-8?B?VkNZZ2tLSGprbGlCL3IwdFp2U0RSYjJibU9wR2FpbTFDczVmMFR3aTR6ZEdj?=
 =?utf-8?B?S29rSlJlZmFEelVzL25FN1k4YUxiOFh0dEd4alJkeGE0WlRYY1JkUThMdmZ1?=
 =?utf-8?B?eGRpV3dMeUVtTU1wUjNzSkI0SDk1d0JTM1R2bU5ITmRNVkJVSnpKVFVRazdL?=
 =?utf-8?B?WkxpeGVnQmt3SUJBVzZHbTFPbmx3Q0kzUytObFp1cUdWWEUzd3BCdDlsSVEz?=
 =?utf-8?B?SXVEeUFDNmwvSWlDT1BKZmpmd2d1alBuQjVPcjNlUXV4ZDAyMkhQUzNscnlU?=
 =?utf-8?B?eDhVQXBUM2N2Ti9Dbk9STGlXZzg3ZlBubXNSNEV2Y1FzYkRNMXNBWTVkYWIr?=
 =?utf-8?Q?zvmrbI8MSZPhDznfJ5aprlRhqtQVzWsp53R9dwc?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46ebcbc-bb81-487e-ca6c-08d8f9e6aaa2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR05MB6624.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 17:00:37.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cnwv+WbmL3ZbfBmR+WYlLyDncPhFW1GkBwcSbzFZsgSa0ayjFbbpcIVcAhHHXg52BM9wIdwnh5G9ir31Zm+Cjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 7:26 AM, Catalin Marinas wrote:
> On Wed, Mar 31, 2021 at 02:23:44PM -0400, Zack Rusin wrote:
>> The pagetable walk callbacks in mm/mapping_dirty_helpers.c depend
>> on a set of helpers from which pud_dirty(pud) was missing. I'm
>> assuming mapping_dirty_helpers weren't used on ARM64 before
>> because the missing pud_dirty is causing a compilation error.
>>
>> The drivers/gpu/drm/vmwgfx code uses mapping_dirty_helpers and
>> has been ported to ARM64 but it depends on this code getting in
>> first in order to compile/work.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Zack Rusin <zackr@vmware.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 47027796c2f9..ecd80f87a996 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -451,6 +451,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>>   #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>>   #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
>>   
>> +#define pud_dirty(pud)		pte_dirty(pud_pte(pud))
>>   #define pud_young(pud)		pte_young(pud_pte(pud))
>>   #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
>>   #define pud_write(pud)		pte_write(pud_pte(pud))
> 
> I think pud_dirty() should only be defined if
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD which is not the case on
> arm64. Well, the pud_young/mkyoung/write should probably also be removed
> until we have pud pages on arm64.

Agreed. I got confused by pud_young and co being defined here even 
though they're all shielded by CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD 
when they're used and incorrectly assumed the practice was to define 
them for arm64 here whether CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD 
was defined or not.

I'll go ahead and shield the pud_dirty with 
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD in mapping_dirty_helpers.c 
instead.

z
