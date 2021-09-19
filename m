Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD57410A24
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 07:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhISFjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 01:39:40 -0400
Received: from mail-dm6nam08on2058.outbound.protection.outlook.com ([40.107.102.58]:3009
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229558AbhISFjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 01:39:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KME/asKNhAqmFqA64vGHF7rR4lCmL/39FvacYr+nthnXNe4FJ7niO9x2ATjn3F3XA987de+TrQ3/jWBrieKJPcJWI2RRXUxA25Jlv2ZMGrM1QxH4312lBYPlUfiWYHFc41BK2XWF2uzllMb0Z6oLFVIoAdiLSLS9ax3/xSTW8DyoontV+5mmJOtYN0M+r/meZvUoaOrhTkBS/Lj61EaMAe8fdY+gENJUI2eAeBj7s7pjvlLUNBLVzxka390WMqZ4v2eqxiwu1yBbIRnUdhJ0omDhWLQ1Q2Zvxb3RiQ4HrpYV8LlHbMTEPvkM7ontiaavYum6MCEfpful3APziA3Q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=a44xLc72LA9fszVSF1INlFZAoGCITAW3L7u1jklVsYg=;
 b=SONDqvDA2N+BB96k6j1SHKonzXBso6c0qZ1DYxlT9f81w0Js9nISGhbJMf15TqXdALQ1XEpnXIox5k/xfkYnI7llDOpgKYpk/xxqgGC7Bct7tHz2lqHTNnN8H/qzOtoFRhF0FXZiUKMzrZg1D6wBKSFd9ZiWvDhWIogxymuByDlzWfEkdSPCRqZuAxF4/KmbcWT/3Zki7gydCqMrGOuFwAMYzSGtae2A+o7Ueu+1xxM0vLvWQPWX7/+9xSXXjcPYk4ehenwHEhZsuyL2DtRS8dWwXwektV1pwTXsERCWGhYyq2RebIk1N18ecmjuGxssLVptW7ugVJORmCmBs0Dd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a44xLc72LA9fszVSF1INlFZAoGCITAW3L7u1jklVsYg=;
 b=drh9tMZPUDIEDomAivZXXjmZVp2cnzHVoFp8icAApJp1PIV7WbczOtlmkld3nZHbHjkg1LgY7LfwEc6KjMzO9jjM3EGaqym9jNKlldhpkzKJcvnhDknt8bbHqKor8+hjSX4jRHD0U0fNh2lUPjlV5MCrmXWU8cjmeDBd9bB0Ea2jAK9w5b+k6npLedB+k5boky3p3Gb9cRFrLtmHdGKOUjppNzhr5d133VbuXWjtnoTYZ12SDJ2/HWkWFJyZRJxr/BRJjZqizAcH92yQGjRA5i948UokW9abkH4GNUfDV3V9Zo8xoHFmrnVDxGeM34sk6TcRoKDVuiAqQ3Bz3AHcLA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3972.namprd12.prod.outlook.com (2603:10b6:a03:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Sun, 19 Sep
 2021 05:38:12 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%9]) with mapi id 15.20.4523.018; Sun, 19 Sep 2021
 05:38:12 +0000
Content-Type: multipart/mixed; boundary="------------6JJJW1UqstnyHETYV7hjMYnp"
Message-ID: <cec9a286-f7b6-c80a-c518-480db65152fc@nvidia.com>
Date:   Sat, 18 Sep 2021 22:38:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
Content-Language: en-US
To:     Weizhao Ouyang <o451686892@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210917061432.323777-1-o451686892@gmail.com>
 <871r5nptt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <89a06743-b37a-b85a-1c04-5d863a1d2cb4@gmail.com>
 <3cf9bb7f-618e-4e4b-32d6-4d3c207b9a9a@nvidia.com>
 <b4123610-bddf-03b9-2190-7b0cda55b57c@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <b4123610-bddf-03b9-2190-7b0cda55b57c@gmail.com>
X-ClientProxiedBy: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.48.243] (216.228.112.22) by BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sun, 19 Sep 2021 05:38:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24625584-bbdd-4001-9768-08d97b2fab6b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB397295F60F353BCC33908281A8DF9@BY5PR12MB3972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ci9RJiH7zzMQHytL6idj69c4VqS+qnOXgaMNAnAIrdj2KvsdQqm6WaMzfQWI4o2ED9ZfvgLnt8RwBpSevS9IKKq1nO7B2HqWM5P4ItNZtvj1R2vOyL4FvSJtD6zC0ytFCDFf35xKrt5Qhh29Lz1pE57c8Sas9W/K+7vgojTQjscoP7rcDvuywUzBIn/yPnvsH+4LB18KJwx2idlLq807o7QaGADdF5wM4wRn/F+W6SoGxQJ1XtS5acy2ie85bFe4McQvnnO7upyQKBx7oh2j7BC0cXpL+6t+wgEioRevF6h+0Gj+HoVOcjEvxWAV/3KdUGlpCqgny98pDTnaAD+YcSwBqTPuKCKzlISAGibOAXdBbSt8ZkkgW0QfXDb0FJj17YDtyyQ5hANaIHYjSTmY1FXvkYkACsPRTpE2NIhSuYXBn2OomdWlbPPtdX8OVXI5uYcnFhF8lbVPEK8mKHQn05vydOY0pnje3/+mTrXH4XuM1udRs4T23qmRD5p085efK4scJPjdfZ9u3nVjCgKCh17yoT55lQuV1cNPLFYQdbHIcA8+T3I2E10LnVTTTv7obVeUwQM6dOHWaTY470M9PXEpSWwWuPomoyUNbXAmkgDQB+/r4rIXZj0MYKMJIGcAhNms4TC4ZLS7Ju0U+VCVZsk5FNgfFQ2ELfY7UyWpFFbLetoRJVKnLH3YZAtSiKWbXKWzWeIu8G7rJgSnvREKWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(31696002)(33964004)(83380400001)(38100700002)(66616009)(31686004)(235185007)(186003)(66946007)(110136005)(66476007)(6486002)(5660300002)(66556008)(2906002)(36756003)(316002)(86362001)(4326008)(2616005)(54906003)(8936002)(16576012)(26005)(478600001)(956004)(8676002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9TaXpuSnJRMklqVkZmRUdlZTRHME5uNDU0WVpqMmp4RmpKZEJBSzZoaE5t?=
 =?utf-8?B?MDVpV2Q5TFRtN09oeXltRG5WSXYwQzF1U1JrcTdiNGpINnFDWGpTWCtDdTFp?=
 =?utf-8?B?ZzVaVnhYQldQR2RvalRjVUw5UVpEeFVYQ0tsTlh3UVhtZXJJNERzYnBETktD?=
 =?utf-8?B?OWNjRiszSHhEUXY0bnlTQjc3Y2hUR3luNUE1SHQwc0tmVUVrckUxSmV0c2VT?=
 =?utf-8?B?MnQ1NWU2RzdXaVVDOHlGMkxFRmhZZkc4V2xFdWNGby9Nc1JRdWpDeDNjNGll?=
 =?utf-8?B?My9xNzBRMmhlUjkyMWh1RTB1dGk4cEc0aVBuaEZWMUF6b0ZaSGdUNlp3cyta?=
 =?utf-8?B?YkQvZGJjemJRcThGSnY5VFlxQ3k5L0liWUQvcEZBMmZuektFdUxnQm9mdEZR?=
 =?utf-8?B?dUNHOTZUWDdncEJROWNVdys0SjhnNXpBTld1dFJKajNvVU5PdmU3M1N4OFhD?=
 =?utf-8?B?SUoyWHgwQ3V1MUhCemRNTklCRmMvVmplcUcwVC9FekhwaExqREc1VEJ2NjVT?=
 =?utf-8?B?UWF0Yk10SExrc3RjVG1YU01XZHhRajVyMjVLdDRjQnJEYWJSWVkxU25vY1Jo?=
 =?utf-8?B?Wmx6eUx5ZGNIb051RFlVTlJyKzhDNmxzWnN3dGY2S2JGeEVnbmhpaXBTZEFl?=
 =?utf-8?B?TzJmM1Z0VEJNaDZteXpsT241clVoM3NRdDVoVk8xb1pFb0JsR1hQSjFweEM5?=
 =?utf-8?B?ZGFxek5jSHY3RkV2SHhhQkxRbkRRdnp2ZXRzOE05Z2puR3ZDaDhxSnQ3NXFX?=
 =?utf-8?B?Q2U1RmhkWnkrMHBiZWw3M04xMHZVYUV6RWFacmZUK0htd0k4Y1NVekc3Um5M?=
 =?utf-8?B?K0xROXZNSGMwOXFJSUFWYVJpb3NZNXFSWWdCeWpkSEl6MmMzM1BZZWNiRlpR?=
 =?utf-8?B?RW9RMm9PVjh2VE5mYndXcUN3cXBkNHByVDczdC9TQUJCS0VaSU1rb3NrNTlN?=
 =?utf-8?B?UCtSTGR6cTE3VDRvVHZkM3RybFRxTFBlU080MjJudzYrdTNQZFpLeEF5ZDZR?=
 =?utf-8?B?eklVeVNpUzdkQk1WNmJ3NTNNSjNoMFNaVURUYWcxaVcxcEtNS09MVFFpNjBD?=
 =?utf-8?B?YjV4VGR1THUxMXV0cXBhZFczWEk3Z2ZLMHhSTzVvQ1ppRStUK3VpWDZCMy9S?=
 =?utf-8?B?ZXVaczdIVFRyUUxSSjFhOVFRTXBEM3BhczhDSHFQQitnSi9RTFRhN1YwMHg1?=
 =?utf-8?B?eE4rSjhYNXAvZFNlRnRUY3MwOTJQV1Zwdno4UFVxTFhoN3JZaHh6RDBhQm8y?=
 =?utf-8?B?ZC9VMlM0QUd2ai9ZTmpuVDVRSGJXNmlPZkQyNFphQzlMQjNHOHV5ZVp4YjVD?=
 =?utf-8?B?eVJkbmtoNzBHTStsL1hXWTFHaFYrQ3VxQTRNamNZOWNMNVdJcmpmd2h5NVF4?=
 =?utf-8?B?bWV3TzVUcU5BeE1OeVduRDd4L2wvdWZUQWZlN2FsVlpHTnlQTFZxSnhnMWRP?=
 =?utf-8?B?eEQ3TUVBbUFSVlF6UlZuWjk2cVhXQytnMzFmdTQxSkQzbXBiZlJSYXFFTXlt?=
 =?utf-8?B?bE9xdmpqM2dOU2RCUSs1ZTFtYmtoNTJoTll2c2hoUTVVdHdId2MrT2xEWVQz?=
 =?utf-8?B?R05vSWcyaUZDUU9EdFZVYjlGSEN0M1lLb3RxZ1g5citxc09reUVHdTh6cWpk?=
 =?utf-8?B?a1FEWEJwdDIxUk9BTGE3Mlk3UmhmUkoyUjIrZEsxbGNVVjZscCtpTmtFK2NB?=
 =?utf-8?B?NnAyQXBNNlNEekgza2ZaZ2pPWS9NOURDOXMwRlA5YUx2eGJBNXRyYURCODF6?=
 =?utf-8?Q?GCJQxdJxm1mXZAZUqahBrcPrS0cQMyAs7AVx6iE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24625584-bbdd-4001-9768-08d97b2fab6b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 05:38:12.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOwF8Aq+AqiSojAlIXEy8eISKAa4BGjEjwv1bnfUWBZi9DQ0ogDSLFNUhwnmOh+WtOxkJ9MoCPYnqKpGXRhTmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3972
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------6JJJW1UqstnyHETYV7hjMYnp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/21 00:03, Weizhao Ouyang wrote:
...
>   
> Anyway, I didn't find a simply way the build the "everywhere" relationship behind
> the packaged TRACE_DEFINE_ENUM , what do you think.
> 
It's actually pretty easy, unless I'm unknowingly violating some rule
here. But I did review tracing a bit before diving in, and I think this
is reasonable.

The trace macros EM(), EMe(), and MIGRATE_REASON are flexible enough to
get whatever you want, out of them. So, the trace header can be the one
location for the definition of the enum-to-string mapping.

The key is to move the enum to a common header file that both the trace
system (trace/events/migrate.h) and the migrate header
(include/linux/migrate.h) can include. Fortunately, that's already been
started for enum migrate_mode: there is migrate_mode.h.

So it all works approximately like this, below. (I'll attach a
white-space-correct diff that you can apply directly, too). I've
compiled tested and rebooted with it, but haven't checked much more
than that yet.

---
  include/linux/migrate.h      | 16 ++--------------
  include/linux/migrate_mode.h | 13 +++++++++++++
  mm/debug.c                   | 19 ++++++++++++-------
  3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 326250996b4e..cb62fbc3d8d6 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -6,6 +6,7 @@
  #include <linux/mempolicy.h>
  #include <linux/migrate_mode.h>
  #include <linux/hugetlb.h>
+#include <linux/migrate_mode.h>

  typedef struct page *new_page_t(struct page *page, unsigned long private);
  typedef void free_page_t(struct page *page, unsigned long private);
@@ -19,20 +20,7 @@ struct migration_target_control;
   */
  #define MIGRATEPAGE_SUCCESS		0

-enum migrate_reason {
-	MR_COMPACTION,
-	MR_MEMORY_FAILURE,
-	MR_MEMORY_HOTPLUG,
-	MR_SYSCALL,		/* also applies to cpusets */
-	MR_MEMPOLICY_MBIND,
-	MR_NUMA_MISPLACED,
-	MR_CONTIG_RANGE,
-	MR_LONGTERM_PIN,
-	MR_DEMOTION,
-	MR_TYPES
-};
-
-/* In mm/debug.c; also keep sync with include/trace/events/migrate.h */
+/* In mm/debug.c */
  extern const char *migrate_reason_names[MR_TYPES];

  #ifdef CONFIG_MIGRATION
diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index 883c99249033..f37cc03f9369 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -19,4 +19,17 @@ enum migrate_mode {
  	MIGRATE_SYNC_NO_COPY,
  };

+enum migrate_reason {
+	MR_COMPACTION,
+	MR_MEMORY_FAILURE,
+	MR_MEMORY_HOTPLUG,
+	MR_SYSCALL,		/* also applies to cpusets */
+	MR_MEMPOLICY_MBIND,
+	MR_NUMA_MISPLACED,
+	MR_CONTIG_RANGE,
+	MR_LONGTERM_PIN,
+	MR_DEMOTION,
+	MR_TYPES
+};
+
  #endif		/* MIGRATE_MODE_H_INCLUDED */
diff --git a/mm/debug.c b/mm/debug.c
index e73fe0a8ec3d..51152ffc1f29 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -17,14 +17,19 @@

  #include "internal.h"

+#include <trace/events/migrate.h>
+
+/*
+ * Define EM() and EMe() so that MIGRATE_REASON from trace/events/migrate.h can
+ * be used to populate migrate_reason_names[].
+ */
+#undef EM
+#undef EMe
+#define EM(a, b)	b,
+#define EMe(a, b)	b
+
  const char *migrate_reason_names[MR_TYPES] = {
-	"compaction",
-	"memory_failure",
-	"memory_hotplug",
-	"syscall_or_cpuset",
-	"mempolicy_mbind",
-	"numa_misplaced",
-	"cma",
+	MIGRATE_REASON
  };

  const struct trace_print_flags pageflag_names[] = {
-- 
2.33.0

thanks,
-- 
John Hubbard
NVIDIA
--------------6JJJW1UqstnyHETYV7hjMYnp
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Use-one-definition-of-MIGRATE_REASON-strings-everywh.patch"
Content-Disposition: attachment;
 filename*0="0001-Use-one-definition-of-MIGRATE_REASON-strings-everywh.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3YjEwNDE5YTFkZTliZTM1MjUzOWIzOGUyY2E3MGNjNWIxNDY4N2Q5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+CkRh
dGU6IFNhdCwgMTggU2VwIDIwMjEgMjI6MDc6MjAgLTA3MDAKU3ViamVjdDogW1BBVENIXSBVc2Ug
b25lIGRlZmluaXRpb24gb2YgTUlHUkFURV9SRUFTT04gc3RyaW5ncywgZXZlcnl3aGVyZQpYLU5W
Q29uZmlkZW50aWFsaXR5OiBwdWJsaWMKQ2M6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlh
LmNvbT4KCihDb21waWxlZC10ZXN0ZWQgb25seSwgc28gbm8gc2lnbmVkIG9mZiBieSB0YWcuKQot
LS0KIGluY2x1ZGUvbGludXgvbWlncmF0ZS5oICAgICAgfCAxNiArKy0tLS0tLS0tLS0tLS0tCiBp
bmNsdWRlL2xpbnV4L21pZ3JhdGVfbW9kZS5oIHwgMTMgKysrKysrKysrKysrKwogbW0vZGVidWcu
YyAgICAgICAgICAgICAgICAgICB8IDE5ICsrKysrKysrKysrKy0tLS0tLS0KIDMgZmlsZXMgY2hh
bmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9taWdyYXRlLmggYi9pbmNsdWRlL2xpbnV4L21pZ3JhdGUuaAppbmRleCAzMjYy
NTA5OTZiNGUuLmNiNjJmYmMzZDhkNiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9taWdyYXRl
LmgKKysrIGIvaW5jbHVkZS9saW51eC9taWdyYXRlLmgKQEAgLTYsNiArNiw3IEBACiAjaW5jbHVk
ZSA8bGludXgvbWVtcG9saWN5Lmg+CiAjaW5jbHVkZSA8bGludXgvbWlncmF0ZV9tb2RlLmg+CiAj
aW5jbHVkZSA8bGludXgvaHVnZXRsYi5oPgorI2luY2x1ZGUgPGxpbnV4L21pZ3JhdGVfbW9kZS5o
PgogCiB0eXBlZGVmIHN0cnVjdCBwYWdlICpuZXdfcGFnZV90KHN0cnVjdCBwYWdlICpwYWdlLCB1
bnNpZ25lZCBsb25nIHByaXZhdGUpOwogdHlwZWRlZiB2b2lkIGZyZWVfcGFnZV90KHN0cnVjdCBw
YWdlICpwYWdlLCB1bnNpZ25lZCBsb25nIHByaXZhdGUpOwpAQCAtMTksMjAgKzIwLDcgQEAgc3Ry
dWN0IG1pZ3JhdGlvbl90YXJnZXRfY29udHJvbDsKICAqLwogI2RlZmluZSBNSUdSQVRFUEFHRV9T
VUNDRVNTCQkwCiAKLWVudW0gbWlncmF0ZV9yZWFzb24gewotCU1SX0NPTVBBQ1RJT04sCi0JTVJf
TUVNT1JZX0ZBSUxVUkUsCi0JTVJfTUVNT1JZX0hPVFBMVUcsCi0JTVJfU1lTQ0FMTCwJCS8qIGFs
c28gYXBwbGllcyB0byBjcHVzZXRzICovCi0JTVJfTUVNUE9MSUNZX01CSU5ELAotCU1SX05VTUFf
TUlTUExBQ0VELAotCU1SX0NPTlRJR19SQU5HRSwKLQlNUl9MT05HVEVSTV9QSU4sCi0JTVJfREVN
T1RJT04sCi0JTVJfVFlQRVMKLX07Ci0KLS8qIEluIG1tL2RlYnVnLmM7IGFsc28ga2VlcCBzeW5j
IHdpdGggaW5jbHVkZS90cmFjZS9ldmVudHMvbWlncmF0ZS5oICovCisvKiBJbiBtbS9kZWJ1Zy5j
ICovCiBleHRlcm4gY29uc3QgY2hhciAqbWlncmF0ZV9yZWFzb25fbmFtZXNbTVJfVFlQRVNdOwog
CiAjaWZkZWYgQ09ORklHX01JR1JBVElPTgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9taWdy
YXRlX21vZGUuaCBiL2luY2x1ZGUvbGludXgvbWlncmF0ZV9tb2RlLmgKaW5kZXggODgzYzk5MjQ5
MDMzLi5mMzdjYzAzZjkzNjkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbWlncmF0ZV9tb2Rl
LmgKKysrIGIvaW5jbHVkZS9saW51eC9taWdyYXRlX21vZGUuaApAQCAtMTksNCArMTksMTcgQEAg
ZW51bSBtaWdyYXRlX21vZGUgewogCU1JR1JBVEVfU1lOQ19OT19DT1BZLAogfTsKIAorZW51bSBt
aWdyYXRlX3JlYXNvbiB7CisJTVJfQ09NUEFDVElPTiwKKwlNUl9NRU1PUllfRkFJTFVSRSwKKwlN
Ul9NRU1PUllfSE9UUExVRywKKwlNUl9TWVNDQUxMLAkJLyogYWxzbyBhcHBsaWVzIHRvIGNwdXNl
dHMgKi8KKwlNUl9NRU1QT0xJQ1lfTUJJTkQsCisJTVJfTlVNQV9NSVNQTEFDRUQsCisJTVJfQ09O
VElHX1JBTkdFLAorCU1SX0xPTkdURVJNX1BJTiwKKwlNUl9ERU1PVElPTiwKKwlNUl9UWVBFUwor
fTsKKwogI2VuZGlmCQkvKiBNSUdSQVRFX01PREVfSF9JTkNMVURFRCAqLwpkaWZmIC0tZ2l0IGEv
bW0vZGVidWcuYyBiL21tL2RlYnVnLmMKaW5kZXggZTczZmUwYThlYzNkLi41MTE1MmZmYzFmMjkg
MTAwNjQ0Ci0tLSBhL21tL2RlYnVnLmMKKysrIGIvbW0vZGVidWcuYwpAQCAtMTcsMTQgKzE3LDE5
IEBACiAKICNpbmNsdWRlICJpbnRlcm5hbC5oIgogCisjaW5jbHVkZSA8dHJhY2UvZXZlbnRzL21p
Z3JhdGUuaD4KKworLyoKKyAqIERlZmluZSBFTSgpIGFuZCBFTWUoKSBzbyB0aGF0IE1JR1JBVEVf
UkVBU09OIGZyb20gdHJhY2UvZXZlbnRzL21pZ3JhdGUuaCBjYW4KKyAqIGJlIHVzZWQgdG8gcG9w
dWxhdGUgbWlncmF0ZV9yZWFzb25fbmFtZXNbXS4KKyAqLworI3VuZGVmIEVNCisjdW5kZWYgRU1l
CisjZGVmaW5lIEVNKGEsIGIpCWIsCisjZGVmaW5lIEVNZShhLCBiKQliCisKIGNvbnN0IGNoYXIg
Km1pZ3JhdGVfcmVhc29uX25hbWVzW01SX1RZUEVTXSA9IHsKLQkiY29tcGFjdGlvbiIsCi0JIm1l
bW9yeV9mYWlsdXJlIiwKLQkibWVtb3J5X2hvdHBsdWciLAotCSJzeXNjYWxsX29yX2NwdXNldCIs
Ci0JIm1lbXBvbGljeV9tYmluZCIsCi0JIm51bWFfbWlzcGxhY2VkIiwKLQkiY21hIiwKKwlNSUdS
QVRFX1JFQVNPTgogfTsKIAogY29uc3Qgc3RydWN0IHRyYWNlX3ByaW50X2ZsYWdzIHBhZ2VmbGFn
X25hbWVzW10gPSB7Ci0tIAoyLjMzLjAKCg==

--------------6JJJW1UqstnyHETYV7hjMYnp--
