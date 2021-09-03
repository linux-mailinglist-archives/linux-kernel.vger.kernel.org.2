Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250D4400325
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349586AbhICQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:22:12 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:42792 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbhICQWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:22:11 -0400
IronPort-SDR: V/99org6QJvRbJ/RPi4v7e3i/ztnrVD96uScDIhBEPPHH0AFrpQWV3jc3Ak+eOSmux9AV0AL/W
 JqIF5w7gfrTyUtCCjlTjB3tp0WVcPv45rUV47P9e9Rf2uIS2Y6yyQFNkHBlwPowLP7ALIawcIQ
 YKzdZ+4m5uQlSIwfRA2T21uap5lrVVNbJyEJIb0tg9LLHSv7l5VEWf24ww5FSXiKA4nZdRHr5x
 4aJeZSjg4w4AIbSH4lpdT58nkBOtXENdk+q6/xqiwGpFJJj1bCqddT3SPgunSTYvtDpcHfoKFl
 VHCPs8PhwQX+fUcRgX70MKKH
X-IronPort-AV: E=Sophos;i="5.85,265,1624348800"; 
   d="scan'208";a="67964015"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 03 Sep 2021 08:21:11 -0800
IronPort-SDR: EiRm+vVriDL0HlQRSHAKHMNqH3WbtiCC2tIBDfgcz5OezJ6xINm9yhBx/p1N16cZgJ62mmYu7W
 rNJvpAwpiMY4XsZ63EUDhLpULXnIoU0gbuTMpwIlNyIRbNjFApBfnjfZzchBMJRIKdNBW9bm4V
 1Gxnra9WHzns8qGdoX/V7mpIWLBNLjZBR5g6PkvM10nbaLGiN+ehKF0Oc6uEOnUbzruUG/WZqf
 fol7n/6WifIv/Zzav41Emz+EfhjUYSb4RZLSzN7BSI9WmCK9OSMXCeZRnhc61q/eTsWWNAE75m
 2Zo=
Date:   Fri, 3 Sep 2021 12:21:02 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>
Subject: Re: [RFC][PATCH] mm/page_isolation: tracing: trace all
 test_pages_isolated failures
Message-ID: <20210903162102.GA10039@mam-gdavis-dt>
References: <20210823202823.13765-1-george_davis@mentor.com>
 <4f680b5a-9076-3ba4-caea-bdd6eafeb899@redhat.com>
 <20210902222152.GA25844@mam-gdavis-dt>
 <8dca5a34-2c5c-bc49-b2ad-f3e5e0fdbba3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8dca5a34-2c5c-bc49-b2ad-f3e5e0fdbba3@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 11:31:01AM +0200, David Hildenbrand wrote:
> On 03.09.21 00:21, George G. Davis wrote:
> > On Tue, Aug 31, 2021 at 04:53:31PM +0200, David Hildenbrand wrote:
> > > On 23.08.21 22:28, George G. Davis wrote:
> > > > From: "George G. Davis" <davis.george@siemens.com>
> > > > 
> > > > Some test_pages_isolated failure conditions don't include trace points.
> > > > For debugging issues caused by "pinned" pages, make sure to trace all
> > > > calls whether they succeed or fail. In this case, a failure case did not
> > > > result in a trace point. So add the missing failure case in
> > > > test_pages_isolated traces.
> > > 
> > > In which setups did you actually run into these cases?
> > 
> > Good question!
> > 
> > Although I'm not 100% certain that this specific failure condition has
> > occurred in my recent testing, I'm able to reproduce cma_alloc -EBUSY
> > faiure conditions when testing latest/recent master on arm64 based
> > Renesas R-Car Starter Kit [1] using defconfig with
> > CONFIG_CMA_SIZE_MBYTES=384 while running the following test case:
> 
> Okay, I think you are not hitting the path you touched in this patch,
> because I assume it will never ever really trigger ...

I didn't have any confidence that this path was triggered but if for
some reason it does occur there would be no trace point for this case,
hence this patch.

> > trace-cmd record -N 192.168.1.87:12345 -b 4096 -e cma -e page_isolation -e compaction -e migrate &
> > sleep 10
> > while true; do a=$(( ( RANDOM % 10000 ) + 1 )); echo $a > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $a; echo $a > /sys/kernel/debug/cma/cma-reserved/free); done &
> > while true; do b=$(( ( RANDOM % 10000 ) + 1 )); echo $b > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $b; echo $b > /sys/kernel/debug/cma/cma-reserved/free); done &
> > while true; do c=$(( ( RANDOM % 10000 ) + 1 )); echo $c > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $c; echo $c > /sys/kernel/debug/cma/cma-reserved/free); done &
> > while true; do d=$(( ( RANDOM % 10000 ) + 1 )); echo $d > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $d; echo $d > /sys/kernel/debug/cma/cma-reserved/free); done &
> > while true; do e=$(( ( RANDOM % 10000 ) + 1 )); echo $e > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $e; echo $e > /sys/kernel/debug/cma/cma-reserved/free); done &
> > /selftests/vm/transhuge-stress &
> > 
> > The cma_alloc -EBUSY failures are caused by THP compound pages allocated
> > from the CMA region where migration does not seem to work for compound
> > THP pages. The work around is to disable CONFIG_TRANSPARENT_HUGEPAGE
> > since it seems incompatible with the intended use of the CMA region.
> 
> 
> Oh, that sounds broken, THP should not block CMA allocation or page
> migration for other purposes.

Yup, CMA+THP is not well behaved based on my observations.

> a) Are these temporary or permanent allocation errors? If they are
> permanent, they will also break memory unplug.

It's difficult for me to understand but, with encouragement from Eugeniu
Rosca, I was able to create a simplified test case which I believe
demonstrates the problem that we're also observing during normal system
operation w/o the use of synthetic, possibly bogus, test cases. See
below for the possibly bogus synthetic test case...

> b) Did you reproduce on other architectures as well?

I've only tested arm64 based Renesas R-Car Starter Kit on v4.14 and
master based kernels where the same problem is easily reproducible.

> c) Did it use to work but is now broken? IOW, did you try bisecting?

I have not identified any versions where this is/was known to work but
there is a lot of anecdotal evidence that problems such as this have
been an ongoing concern, e.g. [1][2][3].

 [1] https://lwn.net/Articles/636234/
 [2] https://lwn.net/Articles/619865/
 [3] https://lwn.net/Articles/684611/

To demonstrate the cma_alloc -EBUSY failure case for THP compound pages,
test_pages_isolated and transhuge-stress are modified as follows:

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index fff55bb830f9..c38607dcc304 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -316,5 +316,8 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 out:
 	trace_test_pages_isolated(start_pfn, end_pfn, pfn);
 
+	if (ret)
+		dump_page(pfn_to_page(pfn), "test_pages_isolated: -EBUSY");
+
 	return ret;
 }
diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
index 5e4c036f6ad3..4c5bf35fafb4 100644
--- a/tools/testing/selftests/vm/transhuge-stress.c
+++ b/tools/testing/selftests/vm/transhuge-stress.c
@@ -113,6 +113,9 @@ int main(int argc, char **argv)
 
 			if (pfn < 0) {
 				nr_failed++;
+			} else if (pfn == 516096) {
+				warnx("Got pfn==0x%lx, please proceed with testing of ~64MiB allocation at end of default CMA region now. Meanwhile, we will wait here in a loop to hold the THP mapping in CMA default region", pfn);
+				do { } while (1);
 			} else {
 				size_t idx = pfn >> (HPAGE_SHIFT - PAGE_SHIFT);
 
With the above changes, the goal of the test case is to leave a large
~320MiB region free at the start of the CMA default region, which can be
allocated for CMA use via a large ~320MiB allocation, then execute
transhuge-stress to allocate THP mappings at the halfway mark within the
final ~64MiB region of the default CMA region, followed by an attempt to
allocate a ~64MiB CMA allocation that is expected to fail due to the THP
mapping, e.g.:

root@rcar-gen3:~# cat /sys/kernel/debug/cma/cma-reserved/base_pfn
425984
root@rcar-gen3:~# cat /sys/kernel/debug/cma/cma-reserved/maxchunk
97182
root@rcar-gen3:~# echo 81920 > /sys/kernel/debug/cma/cma-reserved/alloc
root@rcar-gen3:~# /selftests/vm/transhuge-stress
transhuge-stress: allocate 1874 transhuge pages, using 3749 MiB virtual memory and 14 MiB of ram
transhuge-stress: Got pfn==0x7e000, please proceed with testing of ~64MiB allocation at end of default CMA region now. Meanwhile, we will wait here in a loop to hold the THP mapping in CMA default region
^Z
[2]+  Stopped(SIGTSTP)        /selftests/vm/transhuge-stress
root@rcar-gen3:~# bg
[2] /selftests/vm/transhuge-stress &
root@rcar-gen3:~# cat /sys/kernel/debug/cma/cma-reserved/maxchunk
15262
root@rcar-gen3:~# echo 15262 > /sys/kernel/debug/cma/cma-reserved/alloc 
[  365.002327] page:fffffc0000f18000 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff6ba00 pfn:0x7c600
[  365.012865] head:fffffc0000f18000 order:9 compound_mapcount:0 compound_pincount:0
[  365.020707] memcg:ffff0004cc8a2000
[  365.024380] anon flags: 0x3fffc000009001c(uptodate|dirty|lru|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
[  365.034741] raw: 03fffc000009001c fffffc0000828008 fffffc0000830008 ffff0004c8e33001
[  365.042703] raw: 0000000ffff6ba00 0000000000000000 00000001ffffffff ffff0004cc8a2000
[  365.050708] page dumped because: test_pages_isolated: -EBUSY
[  365.056554] page_owner tracks the page as allocated
[  365.061649] page last allocated via order 9, migratetype Movable, gfp_mask 0x13d24ca(GFP_TRANSHUGE|__GFP_NORETRY|__GFP_THISNODE), pid 783, ts 344253286264, free_ts 330526665485
[  365.077846]  post_alloc_hook+0x14c/0x218
[  365.081941]  prep_new_page+0x28/0x68
[  365.085595]  get_page_from_freelist+0x1ec8/0x2560
[  365.090370]  __alloc_pages+0x270/0x388
[  365.094186]  alloc_pages_vma+0x1d4/0x278
[  365.098176]  do_huge_pmd_anonymous_page+0x124/0xb50
[  365.103120]  __handle_mm_fault+0x5d8/0xdd8
[  365.107285]  handle_mm_fault+0xc8/0x200
[  365.111187]  do_page_fault+0x1f4/0x4c8
[  365.115005]  do_translation_fault+0x90/0xc0
[  365.119254]  do_mem_abort+0x40/0xb0
[  365.122808]  el0_da+0x70/0x200
[  365.125881]  el0t_64_sync_handler+0x68/0xb8
[  365.130124]  el0t_64_sync+0x180/0x184
[  365.133849] page last free stack trace:
[  365.137753]  free_pcp_prepare+0x200/0x4c8
[  365.141853]  free_unref_page+0x28/0x200
[  365.145777]  __free_pages+0x114/0x158
[  365.149526]  free_contig_range+0x68/0xc0
[  365.153534]  alloc_contig_range+0x368/0x418
[  365.157803]  cma_alloc+0x270/0x868
[  365.161297]  cma_alloc_write+0x50/0x98
[  365.165131]  simple_attr_write+0x10c/0x1c8
[  365.169315]  debugfs_attr_write+0x50/0x78
[  365.173414]  full_proxy_write+0x64/0x98
[  365.177336]  vfs_write+0xc8/0x570
[  365.180733]  ksys_write+0x6c/0x100
[  365.184229]  __arm64_sys_write+0x1c/0x28
[  365.188273]  invoke_syscall+0x44/0x100
[  365.192124]  el0_svc_common+0x100/0x120
[  365.196048]  do_el0_svc+0x28/0x90
[  365.200114] cma: cma_alloc: reserved: alloc failed, req-size: 15262 pages, ret: -16
-sh: echo: write error: Cannot allocate memory
root@rcar-gen3:~# fg
/selftests/vm/transhuge-stress
^C
root@rcar-gen3:~# echo 15262 > /sys/kernel/debug/cma/cma-reserved/alloc 
root@rcar-gen3:~# echo 15262 > /sys/kernel/debug/cma/cma-reserved/free
root@rcar-gen3:~# echo 81920 > /sys/kernel/debug/cma/cma-reserved/free

In the above test results, the second CMA allocation fails due to the
presence of THP mappings within the final ~64MiB of the default CMA
memory region.

This may not be an entirely realistic test case but I believe that it
demonstrates the same failure case that we've observed under normal
runtime conditions where we observe the same cma_alloc -EBUSY failure
conditions when THP is enabled.

I have a rather ugly test_pages_isolated trace point patch that emulates
dump_page support where it has shown the same page struct information as
the above synthetic test case results during normal runtime conditions
where the same problem has been observed, i.e. THP compound page
mappings are blocking CMA allocations, which is rather unfortunate bad
behavior.

Thanks!

> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Regards,
George
