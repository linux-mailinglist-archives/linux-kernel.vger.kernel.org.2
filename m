Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A51741199A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242381AbhITQTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:19:42 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:47690 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233273AbhITQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:18:57 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KESVp5009416
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:17:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=to : from :
 subject : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=PPS06212021;
 bh=Pi/NgEinCyK7aDbnIg+txUG6UU/X/K8xwBomEHN0Oj4=;
 b=Zsqv8kMAdjzyB4yDHsosqVmA/vAw5PnhK3a/cqooE2IvBU3VVCCtWPkFevfJ7Mqnzjw/
 ExDYhu0pbSJXa3FwIPidfJ438h3P0TITm/GKwF+S2xwkV0S738A4R5JYUhROweo123rh
 8ZypgTCfUxCKxgd/W9zyi8vDl2dNHXn8/J0znqYKSygsBkPrAhYjcCZi9Unu6vBYGzk5
 Ae56/1xLuBDgC4Y+QoM1uXsVvUuN3qd0HNewVHNKw2QYSBK+q0E61D8/utD/39FKDrc+
 rsWMZoU6vfcT5QPFxqnK9rX2qhqX5NHhp7mRtnJCxL5T2/CPqCkKH/tIBbUzET/VMvwZ 2Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com with ESMTP id 3b6byerk3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItErykPOs8TZjQ128UgfBXiB+yu+6THRHzh7BEBoBlTBU2bdFkblwPOLZK47xVkWOOu2uu6q5gU/RFoMqpkj+UaLLZlyY/I3IHLhVc8ipMiTEphhu9Qr9FUT7aZkrJtTav6iP2Sfe+J9r2DePebifqVLQ0VifSDG9R4DY88YKjsj+VpOLQEWKgPYScdSx1Li/eJYrx3SkcaCFQiSRpnFe3/ZR5HTY55iSZNn95PtTJRJt8Xt4A4Kc8KzecWQSiKtP8lnKZVkghGBcjKNhxrv5ozT5CJjp6U89OEiGoqa2ESR4XyFThZR4fehOG5hN+TPaF9RWD9++eWGimcGuBTYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Pi/NgEinCyK7aDbnIg+txUG6UU/X/K8xwBomEHN0Oj4=;
 b=HIKYFeZyMfJjQFbSW1nJcanfbYzzcZ22B35mPAK+LrA+HXigWD9omUviGP4aQPuiH1wm7t09biBddrfN8FdzSRjoAQPpjhqBeQCs4IJcvtDmoXDYxWYVV8OsxfZLl2zSSp8epkRsCN5RjhzJ2XJUCL/4Tl6QVB4F5rbjbumMt798RQ3ioIzwC+W+k5iwMJiqh+sLjkYeM3KurTuHCFDb32UAPMcC4oQS+0ZQgBkylIyE4aQnhUgbI4U9XvtD5AtopMt38vg8cNFw9JW30ARfxaqMgP8hLoEBLP8Kgr7wFS/fW2A+xFGEjUTl29M7YD8wnfS6OWdhet/80wWREg5/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 16:17:21 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c5b3:68f5:53ae:d6cd]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c5b3:68f5:53ae:d6cd%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 16:17:21 +0000
To:     LKML <linux-kernel@vger.kernel.org>
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: [X86] question about mapping from physical core ID to CPU number
Message-ID: <013f9e36-194a-36c9-d2c9-79b80526bd28@windriver.com>
Date:   Mon, 20 Sep 2021 10:17:07 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
Received: from [192.168.2.4] (70.64.73.216) by SJ0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:33a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 16:17:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba688d8-19de-42eb-10f5-08d97c5219e1
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5151:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB51510E0EB190D269DEF18811F6A09@SJ0PR11MB5151.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Q2HjDLgWor8tPS27F9THucERyGljpb9dPQtZ3DyPIrIsle6OJQxv+MkQ4324lCXzPBkw1VltZOAePFxCBhe7nXY1BsyDICi7S/9kQP08KQxNPvSFQHijkMXlqWdkue0KoiVENLhAS6v9UolhHMRRtwQ8NuPoOKQnzfEl67jU0myzdtHzhgOZwOd/954yGP0WaMhGxKxDac4YxaE3ki1TqifX0YbvlWIzdO/fzytHRO2XBcI3U6zqr7QRPwf1IxrwXvFV1Gp7P4e14lT+1MsWYlNPs7nULaJwkTRmmPBAM5h1xYicqqNor5g+kkJrMDC3NKslyVeCtsLRtI+j4Wf2mdTkOsiBnF3u7Ip9S9ZofgQrAEc/SQRZp9cHrn43sFA0KtPev7x3hkn62u8rriXfChUNhDWdhTsd5KOGi5q7E3Llzb+VUjXYxj7Q12xuJ8aARMNc92wYGnFWVXlpCtAGg/feH19/yi2lXvR1ij7Q2RilnPx4V6S7AhcscZFVLKiygoWGqSiclTTXrFFPN9F3Ouo3u9iF+PjOGmM4AiKrnsMehe9jNowSdfQPPDtMahQcP6+A+mI9CoEi2iDuTf0JjBxY9WOLxd3qua61tlntpGs6G9BWLWUdapwASS0nDj0nkBqIhtKa/1th+z+7A5M7TsoMkRfbeaX0b8Br0hDEyswVlpLbkw/cu4Y2oKf7JTWyNzvZ4k00heftiLJm7CA7fPTqr+VLY9+K5oh/LtYK0iLwHva+vIjXwvCZ/RbTfbznql47o08BAoE4IZTRN2PKXFGqe7g6pJeHxGIOmcnGxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(16576012)(2906002)(31686004)(66556008)(26005)(8936002)(2616005)(186003)(86362001)(316002)(36756003)(30864003)(52116002)(5660300002)(44832011)(83380400001)(956004)(6486002)(31696002)(6666004)(38350700002)(38100700002)(66476007)(8676002)(508600001)(66946007)(43740500002)(45980500001)(559001)(579004)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUI1QjdvUHV1Z2dwTllxbDRxSkh6K0xHNE1nS1htcktJT2VlcVdiZnZSV2kw?=
 =?utf-8?B?R09naHZUanBkeFVnSXZ1akdYM2VGakgvVmJCV3lOeC9yM3ladW9HRzZjOUlE?=
 =?utf-8?B?OVdUdnBZdUMvbkswVEw0MStiUit2L2ppRGxSNFNpNXJ0eVlkTlVoL3RqYWZ2?=
 =?utf-8?B?WkJJUlNqRytESjdWZmtTL0Y4d0NUK1MvRlFWNHRLeUpjeEZHZno4S3hsUGx3?=
 =?utf-8?B?aEJPajZ2T3hBelZRMWQrelRtY2lwWWdGRmZpdlFRZzRuWFJpTzdHZkhSb0ZV?=
 =?utf-8?B?cERpUzgrVm55RzJWN2wzM2pkRU5aZ3NJNjhkUk5YUTFKcERMRENLL29LNXBI?=
 =?utf-8?B?UXZDT3hSYVVkbHg5N1RBTk01Mm9BYkVUbGIrakwvUi92cHJjY21XOFYwdmFW?=
 =?utf-8?B?YU5wYks1SkFZdGFVVzJFUC9ORG5KYTVXdWVxY2IvQkxVK0kvVGtzM0pseWVv?=
 =?utf-8?B?Z296c0N0dmkwRFlmS0NseTlsL0Urb09oOWhoS1MyQ2tqMDhJVEIvek9TQkU0?=
 =?utf-8?B?NzgyRmJhOHl6cGlRVnQyeXZScGtvN1Q4aTk3V1FuR1R0ZGtpKzcwNkUrTFUr?=
 =?utf-8?B?RWF5UW1ucjVJWG83Nnp5UzBmTkJTZ0wweWpmeW1ZWkFZNjVyREw5SlQ5dVov?=
 =?utf-8?B?TEJHcDZ1bUY0WjVBandnM205RW1sWlhGUG9VTGpCSUNLTTBJL0k2OWFkVzhL?=
 =?utf-8?B?Z0VqdjJVaUN1ZFJOZ1Y0ZEhrQWFmUDFMNDRmSlJJK2p6VXJJL1RIUkVIQWxB?=
 =?utf-8?B?U211UmwwTi9ZYjRtOGxUU0pOSjVDaEVFN1NhTVVoeVRvY0gxTG9UQ2FySXhn?=
 =?utf-8?B?RFVKRkFmNHJ2Tk82MDdoZ3ViUVp5bVBDSERtWUtVakI5eDM5bkpkZFNudExN?=
 =?utf-8?B?TjhaQzBjeG9oTzNWcS9FU2gvTnRkMDhZU0hBOGtLcklCd2F3N3BCVkJyQnk1?=
 =?utf-8?B?TDR4SWZHVjBCTGVKZExlV0VoaDFnT0tFTVUwZythWDhXcDd1UEFYaGpPcTFI?=
 =?utf-8?B?VC92cS9MUjhjLzMwaTI1a1ZpbFJ2Z1pGR21SQlBOdUlKeVFxb3JRdm1DRW5Q?=
 =?utf-8?B?dnVrNUJKM0NTbUNhZHFnN3N1NkNtZG1FUGpRaENkRmQzVForZnlPVWZ5T1Vr?=
 =?utf-8?B?dFBHd25VZDREcWduR01jK21ILzZIOUwva0hsdHFVTGVvSElha0dPMlVScHVV?=
 =?utf-8?B?c2V5UHg5OURqZ0lrOGEwQk5yNHdGRW9XbnBwQ1dzaG5pY0RoT0FPN29nVXlR?=
 =?utf-8?B?QU9Ma3FFQVNST1ZQNHhINDhnRFIvb2p6MkZ1a0tCOWhVYXJ5Qzg5ZnJlSk1U?=
 =?utf-8?B?ci94ZHlEMk9qb1k0L1pBTElCekdpRlUrazBYa1ZwVWExWDMyVkxHOXFxMm12?=
 =?utf-8?B?OHdqVVh4WUtKR0d6T3dOQTlVczg5aGVubzlKTE9rWlZvRU1aOEdtazJjZzhO?=
 =?utf-8?B?WmZxaGxQYS9mMi94SXc1MjF1OWZiTEJTS0J5T3Nxa1ozQjRwaUlzbUdvYnpY?=
 =?utf-8?B?TEUvUWRVN0g4cU1ZTzFqcHhwYjVjUVMrNGhMRzQwSlYxYUZ6eEZpVmdySDhk?=
 =?utf-8?B?WjZzeFhubkF6NmNIOWJ6S1pDOU5NUVBqVTgxMzJwOHlac1Z0ZXBQLythcStH?=
 =?utf-8?B?NnBjcU5FQW1iZW4ya2MzeXZsZE5RU2JFd1hPQ0lJd0tzTjRpeUthcXZmU05G?=
 =?utf-8?B?WW02bStKWnVENFdlM3FoK05FYytMYlBiRzBqZWZlMHloaTBValpZSWpkZm9B?=
 =?utf-8?Q?+f8JhR0BrL2ZEYWdMNUvTLnjU9+KqS0Y/wnsDNK?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba688d8-19de-42eb-10f5-08d97c5219e1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 16:17:21.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kogl5j7GadLQ3/wGIl8ZQ26e0Qyesdlt3NXiZpWYZjDBHoRedn/DKWqfzZ/lviWe+03YBcvmzhaB/qnvdCwIRYdsXqchjGoTWpRZlcd55lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-Proofpoint-GUID: sCeSdbJkxN7NZJrUKIkh1b2ygKhn_uCI
X-Proofpoint-ORIG-GUID: sCeSdbJkxN7NZJrUKIkh1b2ygKhn_uCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=905 clxscore=1011
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got someone asking me about an X86 system that is kind of weird, 
where the kernel reports that CPU0 actually has a "core id" of 16. 
Other supposedly-identical systems do not show this behaviour.

/proc/cpuinfo shows the following (I've included the full output below, 
but there is no entry with a core id of 0):

processor	: 0
core id		: 16
processor	: 36
core id		: 16

Oddly, "lscpu -e" shows something different (I've included the full 
output below):
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE
0   0    0      0    0:0:0:0       yes
16  0    0      16   16:16:16:0    yes
36  0    0      0    0:0:0:0       yes
40  0    0      16   16:16:16:0    yes

Can anyone explain why /proc/cpuinfo and lscpu don't align?

This is a single-NUMA-node system, with 24 physical cores and SMT 
enabled.  On the "normal" systems we see CPUs 0-23 representing the 
first thread on cores 0-23, then CPUs 24-47 represent the other thread 
on cores 0-23.

I'm looking for information on how the CPU numbers are determined at 
early boot, and for information on what would cause the wonky numbering 
seen above in /proc/cpuinfo where CPU0 is not core ID 0.  Is there 
something I could look for in the ACPI tables, for example?

Also, what determines which core is the "boot CPU"?  Is logical CPU 0 
always the boot CPU or would it be ?

Thanks,
Chris


cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 16
cpu cores	: 24
apicid		: 32
initial apicid	: 32
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 1
cpu cores	: 24
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 2
cpu cores	: 24
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 3
cpu cores	: 24
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 4
cpu cores	: 24
apicid		: 8
initial apicid	: 8
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 5
cpu cores	: 24
apicid		: 10
initial apicid	: 10
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 6
cpu cores	: 24
apicid		: 12
initial apicid	: 12
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 8
cpu cores	: 24
apicid		: 16
initial apicid	: 16
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 8
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 9
cpu cores	: 24
apicid		: 18
initial apicid	: 18
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 9
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 10
cpu cores	: 24
apicid		: 20
initial apicid	: 20
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 10
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 11
cpu cores	: 24
apicid		: 22
initial apicid	: 22
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 11
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 12
cpu cores	: 24
apicid		: 24
initial apicid	: 24
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 12
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 13
cpu cores	: 24
apicid		: 26
initial apicid	: 26
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 13
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 17
cpu cores	: 24
apicid		: 34
initial apicid	: 34
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 14
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 18
cpu cores	: 24
apicid		: 36
initial apicid	: 36
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 15
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 19
cpu cores	: 24
apicid		: 38
initial apicid	: 38
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 16
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 20
cpu cores	: 24
apicid		: 40
initial apicid	: 40
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 17
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 21
cpu cores	: 24
apicid		: 42
initial apicid	: 42
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 18
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 24
cpu cores	: 24
apicid		: 48
initial apicid	: 48
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 19
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 25
cpu cores	: 24
apicid		: 50
initial apicid	: 50
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 20
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 26
cpu cores	: 24
apicid		: 52
initial apicid	: 52
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 21
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 27
cpu cores	: 24
apicid		: 54
initial apicid	: 54
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 22
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 28
cpu cores	: 24
apicid		: 56
initial apicid	: 56
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 23
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 29
cpu cores	: 24
apicid		: 58
initial apicid	: 58
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 24
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 1
cpu cores	: 24
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 25
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 2
cpu cores	: 24
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 26
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 3
cpu cores	: 24
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 27
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 4
cpu cores	: 24
apicid		: 9
initial apicid	: 9
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 28
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 5
cpu cores	: 24
apicid		: 11
initial apicid	: 11
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 29
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 6
cpu cores	: 24
apicid		: 13
initial apicid	: 13
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 30
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 8
cpu cores	: 24
apicid		: 17
initial apicid	: 17
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 31
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 9
cpu cores	: 24
apicid		: 19
initial apicid	: 19
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 32
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 10
cpu cores	: 24
apicid		: 21
initial apicid	: 21
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 33
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 11
cpu cores	: 24
apicid		: 23
initial apicid	: 23
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 34
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 12
cpu cores	: 24
apicid		: 25
initial apicid	: 25
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 35
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 13
cpu cores	: 24
apicid		: 27
initial apicid	: 27
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 36
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 16
cpu cores	: 24
apicid		: 33
initial apicid	: 33
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 37
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 17
cpu cores	: 24
apicid		: 35
initial apicid	: 35
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 38
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 18
cpu cores	: 24
apicid		: 37
initial apicid	: 37
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 39
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 19
cpu cores	: 24
apicid		: 39
initial apicid	: 39
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 40
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 20
cpu cores	: 24
apicid		: 41
initial apicid	: 41
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 41
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 21
cpu cores	: 24
apicid		: 43
initial apicid	: 43
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 42
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 24
cpu cores	: 24
apicid		: 49
initial apicid	: 49
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 43
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 25
cpu cores	: 24
apicid		: 51
initial apicid	: 51
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 44
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 26
cpu cores	: 24
apicid		: 53
initial apicid	: 53
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 45
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 27
cpu cores	: 24
apicid		: 55
initial apicid	: 55
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 46
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 28
cpu cores	: 24
apicid		: 57
initial apicid	: 57
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 47
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
stepping	: 7
microcode	: 0x500002c
cpu MHz		: 1500.000
cache size	: 36608 KB
physical id	: 0
siblings	: 48
core id		: 29
cpu cores	: 24
apicid		: 59
initial apicid	: 59
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 invpcid_single intel_ppin 
intel_pt ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt 
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc 
cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku 
ospke avx512_vnni md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
bogomips	: 3000.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

lscpu -e
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE
0   0    0      0    0:0:0:0       yes
1   0    0      1    1:1:1:0       yes
2   0    0      2    2:2:2:0       yes
3   0    0      3    3:3:3:0       yes
4   0    0      4    4:4:4:0       yes
5   0    0      5    5:5:5:0       yes
6   0    0      6    6:6:6:0       yes
7   0    0      7    7:7:7:0       yes
8   0    0      8    8:8:8:0       yes
9   0    0      9    9:9:9:0       yes
10  0    0      10   10:10:10:0    yes
11  0    0      11   11:11:11:0    yes
12  0    0      12   12:12:12:0    yes
13  0    0      13   13:13:13:0    yes
14  0    0      14   14:14:14:0    yes
15  0    0      15   15:15:15:0    yes
16  0    0      16   16:16:16:0    yes
17  0    0      17   17:17:17:0    yes
18  0    0      18   18:18:18:0    yes
19  0    0      19   19:19:19:0    yes
20  0    0      20   20:20:20:0    yes
21  0    0      21   21:21:21:0    yes
22  0    0      22   22:22:22:0    yes
23  0    0      23   23:23:23:0    yes
24  0    0      1    1:1:1:0       yes
25  0    0      2    2:2:2:0       yes
26  0    0      3    3:3:3:0       yes
27  0    0      4    4:4:4:0       yes
28  0    0      5    5:5:5:0       yes
29  0    0      6    6:6:6:0       yes
30  0    0      7    7:7:7:0       yes
31  0    0      8    8:8:8:0       yes
32  0    0      9    9:9:9:0       yes
33  0    0      10   10:10:10:0    yes
34  0    0      11   11:11:11:0    yes
35  0    0      12   12:12:12:0    yes
36  0    0      0    0:0:0:0       yes
37  0    0      13   13:13:13:0    yes
38  0    0      14   14:14:14:0    yes
39  0    0      15   15:15:15:0    yes
40  0    0      16   16:16:16:0    yes
41  0    0      17   17:17:17:0    yes
42  0    0      18   18:18:18:0    yes
43  0    0      19   19:19:19:0    yes
44  0    0      20   20:20:20:0    yes
45  0    0      21   21:21:21:0    yes
46  0    0      22   22:22:22:0    yes
47  0    0      23   23:23:23:0    yes
