Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE837325492
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBYRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:35:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51670 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBYRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:35:14 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PHTlBV133752;
        Thu, 25 Feb 2021 17:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NUsO3bKMxcKeT2aKEXs1iORskqoHff330Fz9OOoniIE=;
 b=WiKzgCI8G4befFoQqAy9vEfpK9sf26k//gypraXaqgKxpq3CMZXaZ4iWgNWds3/UfbsV
 jniYxYQsr1fmkvpQhPdkzX8gVSwyf0VWV0bBnG5MNkWSoiqXHiYqeN+CC5DLreQo7kco
 9v0M85+vEzPEtihQEw5c2A8DAehlu5dx/sgyxFzyqFlBVbHiEBn/bVO3laot4osHwyEW
 GimnrD7dm5MkRtKqLyBtZyk1wfbB26GBJO6ZVuBPNzCe1sy+19wT+bBn0/9fJ1zM+d+6
 YpcJkzMeHO9CTXukDfWG7V+xpv+qD4PJ474KMoQ8Fv/ocCDKUhc1AOoCuw83byuWNzp5 uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36vr629n4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 17:33:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PHUhfH175232;
        Thu, 25 Feb 2021 17:33:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 36ucb2b6p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 17:33:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2O8Q5GvfetAEdZdbs7uOeIjCS3HX7I021L/CpDAzDDpHlYX9FHkUnrOhZNsl1m2yyJ0HUMKhtQsQ077RuBESuhs4YGXP4OOktXR2qs4gSUbF7GKCEZN/JnTvXXLUXbWAwg5NbT1Jgq+03j9xgoWz8TDjK/kWPKLJ1bwAX8tPHZjpZYQzLwbThmcJdHJq8t/A/GPCllw0Nc9hVDydltQCR/Dgxb/9/iX0ZhR7LbKBEA86DMvYm9o+BOKiAo+m5DimiSdJY0bUvApovc3apwhsrSMiZwlFtmnuRm4Fzl3i/pWALcO4VhX3hkFZPqzGYPxK0aJYjJrrIeQcdk8c23TXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUsO3bKMxcKeT2aKEXs1iORskqoHff330Fz9OOoniIE=;
 b=i+YznFemBOHsPR7h2aQeaB8nn8ISq1Zp6j7/xeUL5FzknWLKJPuxca1gbqgeiZtweMOWuKkQoMcee1fw3g48gkCqRjGpR4SEyMQSHBj67cdZ4Y0BWMy47NwN53IgphYh//DQRMYSQp87FHz4eTNta5Zw8Zsz9pn6NNN1wCj6oufh8Z/W8IpGU5z5270SQnC/7832AO0Fc8To1VPCAz2vqXazUaiu4kktDtpwsMfoRLLRJAepW8zqJ5DJegfk63Of4DnTRHquLL4Tz/Kx6dksOy8DoVYucm0nMl8IRImpAKuC+iczS9Rc2GaFd253Taz8opPmLor38rvXxFPQx9jkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUsO3bKMxcKeT2aKEXs1iORskqoHff330Fz9OOoniIE=;
 b=yaZ0wlKC6+O9pIs8Rg1yYVcopOtBOpPsx88XoD+pYjrljE6vqAdWlok+jihjvWXfH4UCXstKGBQm8FmZZt2Pblov8aiW7v2vqSZIxW1BAIRfO7JwWFqxzlfojW23lAfapXYcvuFihPL1bLdHQ7frPR36xNIFZ9xp88VTiUgPbuw=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB4330.namprd10.prod.outlook.com (2603:10b6:5:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 17:33:43 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 17:33:43 +0000
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
Message-ID: <6000e7fd-bf8b-b9b0-066d-23661da8a51d@oracle.com>
Date:   Thu, 25 Feb 2021 12:33:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210225160706.GD1854360@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19)
 To DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 17:33:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 215014bc-e5cd-4bc3-c3a0-08d8d9b37f37
X-MS-TrafficTypeDiagnostic: DM6PR10MB4330:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB433090C2927626158D145983E69E9@DM6PR10MB4330.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dzt6DySAhzvMmLQo+KieS7LD+H3gMa2vrbRz7U8e3xOX2w+A4g1wGLjT+gy+zRHSdkffqxs5S+HW/uATnjixNcmEB59eOPAvDPL0JHKitOMNb0WUpOCHTia3Wh5tNLKix+T122R4WZqR/ufHbFwzrxw/oEkpN1w88JA1E6RA5GCSiDOi30Ti/nP9WPzdq9ltoI3XjHUqJFOXpf8lQ9GUF2ocGJEot71XNf20UuFrXVjgJrqbH91pv2r8tluEdYrT9GhEeozwzUFPiujJR2faSmWk2kPRYEWcPgCxkK0haX3eRQbX2GEsaATTWNsypTMYwYbieJd+WrV27EPvzuhgGUds+48KfIBtTiOPIV0vtzRHdEyEuA8unsgPAB0VAcMVL2zLEBwNtD8lfLcQnPEbVfaSaurn/T2y+cXbhH114AYDF7L2YId4IpCPVZ5qVGlYSuTLKtcuwWxnzb9ab4S9dFttpt1xa6yC1YXhWYGOxn1g7IfdZ/VODKXLleVFAclqQf55+mtOYDU3CbzlMz5ImFpKU+ptvDEjen9vBMx2et6uNNPDBHezbN1luamhkyxsPDJHl1+/0IjMqBUv9vxZagkS1PoCLHFIJ7t6QGzXbLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(107886003)(31696002)(66556008)(2616005)(83380400001)(2906002)(6916009)(26005)(478600001)(186003)(86362001)(66476007)(16526019)(53546011)(8936002)(36756003)(6486002)(31686004)(30864003)(54906003)(44832011)(16576012)(316002)(7416002)(5660300002)(956004)(36916002)(4326008)(66946007)(6666004)(8676002)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SlVFQVV2SDI3M2JpdVlCK3J1VituazkrUzVadDBhYkxrRjRyRldoTVEyWWx2?=
 =?utf-8?B?dWFndFBmT0RzTFNRRlN6VFdEMmNnbVF6RDBLRW5FQnh5STJOcVJ1aG04NGlr?=
 =?utf-8?B?YmdIaHdLMnlBRHRTUEcyaTJ1T1NLVjBzYSt4cHBLckhQekl4dnBwRnVRU3Bp?=
 =?utf-8?B?SjZXSW5SWXNvZng5YkFsM25qYnd2K29HNUxkWUo4NDdTMWNQcW5SL0U0dEM3?=
 =?utf-8?B?SWRPUHM4MUdaWS9QKzNNeldEWVk0TGdoZjMwalJOUiszVVdQUFhpdGY5K0ZX?=
 =?utf-8?B?QjlJYjJkUjNxSVZDWFdmRlh1WHBxaUpBMllhS1o3Y25EN09keVgwWForVW53?=
 =?utf-8?B?OXo2SG9qN0hqM1d2Q0JnelhYZXVqdHVOcGdSemNPdmtDQ3h3eUlUZmJEK1R6?=
 =?utf-8?B?WGFoRGc0RWNiWEdTaWc2d2Mzc2JDbWgxM2hzMFhmc1dIanhoYXlMN0ZuazZm?=
 =?utf-8?B?cHgra1Y5cTl5KzBNRlVkTnpLNStNNG8zOWJKQ2p3TGtkcHlHM2p4cFh2enpK?=
 =?utf-8?B?WHNBMng1bzBwSnNCblE3NGgwYXdDUkUzUkI1S1N1V2kzYVduNWMvRHBrSWc3?=
 =?utf-8?B?Q2N5dGRpbmk1MXpzYTlTYlJGbnkzanNvV2M2WmdsbGFTS2QvRTM4S2d0OEJz?=
 =?utf-8?B?WWtJY0granpYRVFIb3VPS3o2Um43RlVaMUEra2pRZ0J1MDBBYk9kZm85bUlo?=
 =?utf-8?B?RjdEdU1FSUZuMjZrNExtQ0ZQT0Yxd25hc2hkbDFBZEhnbkZ6OU4xQnJwa1dj?=
 =?utf-8?B?OEMyY0UvU0wvbzkwYXA2eEVRd3JTVkVnUEg3MWVLRngzeTJQMkpqVERFVzRK?=
 =?utf-8?B?bzBYVmlBMnFuRDkwNnRab3lkZ0hJRnU4YldrUDBQUC9VVFdiaVBqNEVvY3pF?=
 =?utf-8?B?cko2UFhuMzNwOGZlNmpld1phZlpjbndocmFMYTlNU1VRanIvdDZGaFNENjNw?=
 =?utf-8?B?b2VLY2tDK2I5QjlnVndYK2pkejNxZFEvMWJBM0VxUjVzMmhFMUpqRGExMVRM?=
 =?utf-8?B?NkN6bk1DeTFSWUQ0WklRbGd3S1E1ZW5OTElKMGtBbmNUNFpLYUdvSHRoTDcv?=
 =?utf-8?B?RzVSU1dFK1g4eE9aV3dWemcxY2E4dGhSMnowUE9HQkg0Z0VGRUpuZGhhV3dF?=
 =?utf-8?B?a1NDL2NuZlhtQ2VRbzE3a1o4amM3aUJwdEVYWEdrdjI4V0JmMnV2NW1KWW1D?=
 =?utf-8?B?VHlmV1pvMTZnVVB4d2syNEN6ZGs3NVBTNFhOTjJJRS9MK0dEVVpjeFBtWDBj?=
 =?utf-8?B?YjZJdlFrZWFwTnRIQjNEa2swZ1I2TEFEcUQxOWpyenlKYUxlejdpd0RXRDJT?=
 =?utf-8?B?WFRLZGRENUk5cHZYQy9NaUtsUm5RT1hvY3pSU0dMQkNpWE1kSjJ6dlhLM3Ex?=
 =?utf-8?B?aXpGWWU0N3FDeWRhMkRWRGQ1WFQzYjdnZkJLMll3Zk9VT0hRbG5Hemt4di9o?=
 =?utf-8?B?UU5uSFRldm94bGxvV2RvTTYrNm4xRndLRG5GRUVWamtBaFNMTTRPaTIvSzc0?=
 =?utf-8?B?SHUwWk04SGxiYi9Ua1Uzd0N6SDEybVBab0Znd3RMeHJUUmJBaEdzMnM4WU5P?=
 =?utf-8?B?dFFLK3pMQlpBb292cDE4VGR2NjlhSlBvZTRPMEtla2dJbk5nSTE4K3h5Q2NG?=
 =?utf-8?B?SWZPNFV4WDdzVjlXSEdlRTExVVgzclp4RVo0YnpmRy9zUnFQdTNzWGQ1K1JV?=
 =?utf-8?B?ZXJrWlB4RHFjS1UyNHB4SkFmRkwxODlNcFpleGkyMC84Y2UyYkI4QUNRN05D?=
 =?utf-8?Q?BkZSw9lJ11+69TpKJ8mElguYAHysz1MnTaMr9XD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215014bc-e5cd-4bc3-c3a0-08d8d9b37f37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 17:33:43.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRa/IpqRAk46xQl50mwVQzap9ld6cEjBunKRJl1xMSBeCZe+MidgnYyBaxUBd0bOmhQLobqMhyLup6n45J5sNjpLZiyPUJQ/+E9Opz+5Aic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4330
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250132
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

Good news Mike!

The above hack in yesterday's last patch works - 10 successful reboots. 
See: "BE453" below for the hack.

I'll modify the patch to use "table_desc->address" instead, which is the 
physical address of the table.

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7bdc023..c118dd5 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
      if (acpi_disabled)
          return;

+#if 0
      /*
       * Initialize the ACPI boot-time table parser.
       */
@@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
          disable_acpi();
          return;
      }
+#endif

      acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 740f3bdb..b045ab2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -571,16 +571,6 @@ void __init reserve_standard_io_resources(void)

  }

-static __init void reserve_ibft_region(void)
-{
-    unsigned long addr, size = 0;
-
-    addr = find_ibft_region(&size);
-
-    if (size)
-        memblock_reserve(addr, size);
-}
-
  static bool __init snb_gfx_workaround_needed(void)
  {
  #ifdef CONFIG_PCI
@@ -1033,6 +1023,12 @@ void __init setup_arch(char **cmdline_p)
       */
      find_smp_config();

+    /*
+     * Initialize the ACPI boot-time table parser.
+     */
+    if (acpi_table_init())
+        disable_acpi();
+
      reserve_ibft_region();

      early_alloc_pgt_buf();
diff --git a/drivers/firmware/iscsi_ibft_find.c 
b/drivers/firmware/iscsi_ibft_find.c
index 64bb945..95fc1a6 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -47,7 +47,25 @@
  #define VGA_MEM 0xA0000 /* VGA buffer */
  #define VGA_SIZE 0x20000 /* 128kB */

-static int __init find_ibft_in_mem(void)
+static void __init *acpi_find_ibft_region(void)
+{
+    int i;
+    struct acpi_table_header *table = NULL;
+    acpi_status status;
+
+    if (acpi_disabled)
+        return NULL;
+
+    for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
+        status = acpi_get_table(ibft_signs[i].sign, 0, &table);
+        if (ACPI_SUCCESS(status))
+            return table;
+    }
+
+    return NULL;
+}
+
+static void __init *find_ibft_in_mem(void)
  {
      unsigned long pos;
      unsigned int len = 0;
@@ -70,35 +88,52 @@ static int __init find_ibft_in_mem(void)
                  /* if the length of the table extends past 1M,
                   * the table cannot be valid. */
                  if (pos + len <= (IBFT_END-1)) {
-                    ibft_addr = (struct acpi_table_ibft *)virt;
                      pr_info("iBFT found at 0x%lx.\n", pos);
-                    goto done;
+                    return virt;
                  }
              }
          }
      }
-done:
-    return len;
+
+    return NULL;
  }
+
+static void __init *find_ibft(void)
+{
+    /* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
+     * only use ACPI for this */
+    if (!efi_enabled(EFI_BOOT))
+        return find_ibft_in_mem();
+    else
+        return acpi_find_ibft_region();
+}
+
  /*
   * Routine used to find the iSCSI Boot Format Table. The logical
   * kernel address is set in the ibft_addr global variable.
   */
-unsigned long __init find_ibft_region(unsigned long *sizep)
+void __init reserve_ibft_region(void)
  {
-    ibft_addr = NULL;
+    struct acpi_table_ibft *table;
+    unsigned long size;

-    /* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
-     * only use ACPI for this */
+    table = find_ibft();
+    if (!table)
+        return;

-    if (!efi_enabled(EFI_BOOT))
-        find_ibft_in_mem();
-
-    if (ibft_addr) {
-        *sizep = PAGE_ALIGN(ibft_addr->header.length);
-        return (u64)virt_to_phys(ibft_addr);
-    }
+    size = PAGE_ALIGN(table->header.length);
+#if 0
+printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, 
virt_to_phys(table)=%llx, size=%lx\n",
+    (u64)table, virt_to_phys(table), size);
+    memblock_reserve(virt_to_phys(table), size);
+#else
+printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, 
0x00000000BE453000, size=%lx\n",
+    (u64)table, size);
+    memblock_reserve(0x00000000BE453000, size);
+#endif

-    *sizep = 0;
-    return 0;
+    if (efi_enabled(EFI_BOOT))
+        acpi_put_table(&table->header);
+    else
+        ibft_addr = table;
  }
diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
index b7b45ca..da813c8 100644
--- a/include/linux/iscsi_ibft.h
+++ b/include/linux/iscsi_ibft.h
@@ -26,13 +26,9 @@
   * mapped address is set in the ibft_addr variable.
   */
  #ifdef CONFIG_ISCSI_IBFT_FIND
-unsigned long find_ibft_region(unsigned long *sizep);
+void reserve_ibft_region(void);
  #else
-static inline unsigned long find_ibft_region(unsigned long *sizep)
-{
-    *sizep = 0;
-    return 0;
-}
+static inline void reserve_ibft_region(void) {}
  #endif

  #endif /* ISCSI_IBFT_H */


Debug from the above:

[    0.020293] last_pfn = 0xbfedc max_arch_pfn = 0x400000000
[    0.050778] ACPI: Early table checksum verification disabled
[    0.056475] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
[    0.057628] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP 
00000001      01000013)
[    0.059341] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP 
00000001 BXPC 00000001)
[    0.061043] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT 
00000001 BXPC 00000001)
[    0.062740] ACPI: FACS 0x00000000BFBFD000 000040
[    0.063673] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC 
00000001 BXPC 00000001)
[    0.065369] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET 
00000001 BXPC 00000001)
[    0.067061] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2     
00000002      01000013)
[    0.068761] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP 
00000000      00000000)
[    0.070461] XXX reserve_ibft_region: table=ffffffffff240000, 
0x00000000BE453000, size=1000
[    0.072231] check: Scanning 1 areas for low memory corruption

George
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

