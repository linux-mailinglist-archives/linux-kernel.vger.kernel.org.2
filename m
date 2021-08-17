Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECA3EE490
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 04:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhHQCpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 22:45:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:24734 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233528AbhHQCpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:45:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="216014117"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="log'?scan'208";a="216014117"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 19:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="log'?scan'208";a="520265668"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2021 19:45:01 -0700
Date:   Tue, 17 Aug 2021 10:45:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Koutn?? <mkoutny@suse.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        andi.kleen@intel.com
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <20210817024500.GC72770@shbuild999.sh.intel.com>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
 <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRrbpRsvdDoom9iG@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 16, 2021 at 05:41:57PM -0400, Johannes Weiner wrote:
> On Mon, Aug 16, 2021 at 11:28:55AM +0800, Feng Tang wrote:
> > On Thu, Aug 12, 2021 at 11:19:10AM +0800, Feng Tang wrote:
> > > On Tue, Aug 10, 2021 at 07:59:53PM -1000, Linus Torvalds wrote:
> > [SNIP]
> > 
> > > And seems there is some cache false sharing when accessing mem_cgroup
> > > member: 'struct cgroup_subsys_state', from the offset (0x0 and 0x10 here)
> > > and the calling sites, the cache false sharing could happen between:
> > > 
> > >     cgroup_rstat_updated (read memcg->css.cgroup, offset 0x0)
> > > and 
> > >     get_mem_cgroup_from_mm
> > > 	css_tryget(&memcg->css) (read/write memcg->css.refcnt, offset 0x10)
> > > 
> > > (This could be wrong as many of the functions are inlined, and the
> > > exact calling site isn't shown)
> 
> Thanks for digging more into this.
> 
> The offset 0x0 access is new in the page instantiation path with the
> bisected patch, so that part makes sense. The new sequence is this:
> 
> 	shmem_add_to_page_cache()
> 	  mem_cgroup_charge()
> 	    get_mem_cgroup_from_mm()
> 	      css_tryget()			# touches memcg->css.refcnt
> 	  xas_store()
> 	  __mod_lruvec_page_state()
> 	    __mod_lruvec_state()
> 	      __mod_memcg_lruvec_state()
> 	        __mod_memcg_state()
> 	          __this_cpu_add()
> 	          cgroup_rstat_updated()	# touches memcg->css.cgroup
> 
> whereas before, __mod_memcg_state() would just do stuff inside memcg.
 
Yes, the perf record/report also show these two are hotspots, one takes
about 6% cpu cycles, the other takes 10%.

> However, css.refcnt is a percpu-refcount. We should see a read-only
> lookup of the base pointer inside this cacheline, with the write
> occuring in percpu memory elsewhere. Even if it were in atomic/shared
> mode, which it shouldn't be for the root cgroup, the shared atomic_t
> is also located in an auxiliary allocation and shouldn't overlap with
> the cgroup pointer in any way.
> 
> The css itself is embedded inside struct mem_cgroup, which does see
> modifications. But the closest of those is 3 cachelines down (struct
> page_counter memory), so that doesn't make sense, either.
> 
> Does this theory require writes? Because I don't actually see any (hot
> ones, anyway) inside struct cgroup_subsys_state for this workload.
 
You are right. the access to 'css.refcnt' is a read, and false sharing
is kind of interference between read and write. I presumed it's a global
reference count, and the try_get is a write operation. 

Initially from the perf-c2c data, the in-cacheline hotspots are only
0x0, and 0x10, and if we extends to 2 cachelines, there is one more
offset 0x54 (css.flags), but still I can't figure out which member
inside the 128 bytes range is written frequenty.

/* pah info for cgroup_subsys_state */
struct cgroup_subsys_state {
	struct cgroup *            cgroup;               /*     0     8 */
	struct cgroup_subsys *     ss;                   /*     8     8 */
	struct percpu_ref          refcnt;               /*    16    16 */
	struct list_head           sibling;              /*    32    16 */
	struct list_head           children;             /*    48    16 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct list_head           rstat_css_node;       /*    64    16 */
	int                        id;                   /*    80     4 */
	unsigned int               flags;                /*    84     4 */
	u64                        serial_nr;            /*    88     8 */
	atomic_t                   online_cnt;           /*    96     4 */

	/* XXX 4 bytes hole, try to pack */

	struct work_struct         destroy_work;         /*   104    32 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */

Since the test run implies this is cacheline related, and I'm not very
familiar with the mem_cgroup code, the original perf-c2c log is attached
which may give more hints.

Thanks,
Feng

> > > And to verify this, we did a test by adding padding between
> > > memcg->css.cgroup and memcg->css.refcnt to push them into 2
> > > different cache lines, and the performance are partly restored:
> > > 
> > > dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 73371bf27a8a8ea68df2fbf456b 
> > > ---------------- --------------------------- --------------------------- 
> > >   65523232 ±  4%     -40.8%   38817332 ±  5%     -19.6%   52701654 ±  3%  vm-scalability.throughput
> > >
> > > We are still checking more, and will update if there is new data. 
> > 
> > Seems this is the second case to hit 'adjacent cacheline prefetch",
> > the first time we saw it is also related with mem_cgroup
> > https://lore.kernel.org/lkml/20201125062445.GA51005@shbuild999.sh.intel.com/
> > 
> > In previous debug patch, the 'css.cgroup' and 'css.refcnt' is
> > separated to 2 cache lines, which are still adjacent (2N and 2N+1)
> > cachelines. And with more padding (add 128 bytes padding in between),
> > the performance is restored, and even better (test run 3 times):
> > 
> > dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 2e34d6daf5fbab0fb286dcdb3bc 
> > ---------------- --------------------------- --------------------------- 
> >   65523232 ±  4%     -40.8%   38817332 ±  5%     +23.4%   80862243 ±  3%  vm-scalability.throughput
> > 
> > The debug patch is:
> > --- a/include/linux/cgroup-defs.h
> > +++ b/include/linux/cgroup-defs.h
> > @@ -142,6 +142,8 @@ struct cgroup_subsys_state {
> >  	/* PI: the cgroup subsystem that this css is attached to */
> >  	struct cgroup_subsys *ss;
> >  
> > +	unsigned long pad[16];
> > +
> >  	/* reference count - access via css_[try]get() and css_put() */
> >  	struct percpu_ref refcnt;
> 
> We aren't particularly space-constrained in this structure, so padding
> should generally be acceptable here.

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="perf-c2c-2d146aa3.log"

=================================================
            Trace Event Information              
=================================================
  Total records                     :    1851005
  Locked Load/Store Operations      :     235067
  Load Operations                   :     698805
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :       1787
  Loads - no mapping                :        437
  Load Fill Buffer Hit              :      73889
  Load L1D hit                      :     527264
  Load L2D hit                      :      18044
  Load LLC hit                      :      69139
  Load Local HITM                   :      18470
  Load Remote HITM                  :       1085
  Load Remote HIT                   :          0
  Load Local DRAM                   :       1485
  Load Remote DRAM                  :       6760
  Load MESI State Exclusive         :       6760
  Load MESI State Shared            :       1485
  Load LLC Misses                   :       9330
  Load access blocked by data       :          0
  Load access blocked by address    :          0
  LLC Misses to Local DRAM          :       15.9%
  LLC Misses to Remote DRAM         :       72.5%
  LLC Misses to Remote cache (HIT)  :        0.0%
  LLC Misses to Remote cache (HITM) :       11.6%
  Store Operations                  :    1152200
  Store - uncacheable               :          0
  Store - no mapping                :        192
  Store L1D Hit                     :    1149048
  Store L1D Miss                    :       2960
  No Page Map Rejects               :    1374324
  Unable to parse data source       :          0

=================================================
    Global Shared Cache Line Event Information   
=================================================
  Total Shared Cache Lines          :       2850
  Load HITs on shared lines         :     123446
  Fill Buffer Hits on shared lines  :      40159
  L1D hits on shared lines          :       9796
  L2D hits on shared lines          :        543
  LLC hits on shared lines          :      64802
  Locked Access on shared lines     :       5237
  Blocked Access on shared lines    :          0
  Store HITs on shared lines        :      11483
  Store L1D hits on shared lines    :      10909
  Total Merged records              :      31038

=================================================
                 c2c details                     
=================================================
  Events                            : cpu/mem-loads,ldlat=30/P
                                    : cpu/mem-stores/P
                                    : dummy:HG
  Cachelines sort on                : Total HITMs
  Cacheline data grouping           : offset,iaddr

=================================================
           Shared Data Cache Line Table          
=================================================
#
#        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
# Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
#
      0  0xffff8881c0642000     0   10444   10.41%     2036     2036        0    23172    23172        0        0        0     6461        9       37     12863     2036         0        0        89      1677
      1  0xffff888135089c40     0     381   10.02%     1959     1955        4     2621     2485      136      129        7      195      256        0        71     1955         0        4         0         4
      2  0xffff88b06cac2c40     3     344    8.18%     1599     1599        0     2149     2030      119      110        9      161      214        0        56     1599         0        0         0         0
      3  0xffff888c9c388840     1     310    6.85%     1340     1340        0     1899     1755      144      139        5      152      204        0        59     1340         0        0         0         0
      4  0xffff8898baa67440     2     275    6.41%     1254     1253        1     1762     1631      131      125        6      137      184        0        55     1253         0        1         0         1
      5  0xffff8881c0642040     0       1    6.24%     1220     1220        0     9700     9700        0        0        0     1807        3        7      5828     1220         0        0        64       771
      6  0xffff8881c0642f80     0    4536    4.74%      927      927        0     6551     6551        0        0        0      711        9        0      4102      927         0        0         0       802
      7  0xffff888135089c80     0    6295    2.27%      443      438        5    10500    10473       27       27        0     7229       39        2      2733      438         0        5         2        25
      8  0xffff888135089ec0     0       1    2.00%      392      392        0     3022     3022        0        0        0      171        3        1      2430      392         0        0         4        21
      9  0xffff88b06cac2c80     3    5443    1.71%      334      333        1     8997     8975       22       22        0     6440       40        1      2152      333         0        1         0         8
     10  0xffff88b06cac2ec0     3       1    1.59%      311      311        0     2441     2441        0        0        0      221        2        5      1897      311         0        0         0         5
     11  0xffff8881c0642100     0     452    1.32%      258      258        0     1185     1185        0        0        0      306        4        4       258      258         0        0        31       324
     12  0xffff888135089e00     0       1    1.30%      255      255        0      730      527      203       65      138      271        1        0         0      255         0        0         0         0
     13  0xffff88b06cac2e00     3      13    1.01%      197      197        0      644      444      200       91      109      245        1        0         1      197         0        0         0         0
     14  0xffff8881c06420c0     0     655    0.54%      106       70       36      966      775      191      191        0      349      133        1        31       70         0       36         5       150
     15  0xffff8881c0642f40     0       1    0.53%      104      104        0     1122     1122        0        0        0       69        3        0       829      104         0        0        13       104
     16  0xffff8881c0642140     0     890    0.48%       93       70       23     1208     1060      148      148        0      620      132        0        39       70         0       23         4       172
     17  0xffff888c9c388a00     1       1    0.47%       91       91        0      331      205      126       76       50      112        2        0         0       91         0        0         0         0
     18  0xffff88b07f3d4100     3     294    0.44%       87       87        0      687      687        0        0        0      268       24        1       191       87         0        0         9       107
     19  0xffff8898baa67600     2       1    0.43%       84       84        0      298      186      112       74       38      102        0        0         0       84         0        0         0         0
     20  0xffff888110d10d80     0    2018    0.40%       78       63       15     2991     2986        5        5        0     1954       30       11       845       63         0       15         7        61
     21  0xffff88810c93d100     0     123    0.37%       73       73        0      559      559        0        0        0      173        2        3       184       73         0        0        13       111
     22  0xffff888c9c388880     1    2336    0.36%       71       71        0     3793     3772       21       21        0     2716       43        0       942       71         0        0         0         0
     23      0x7f4a046a6400   0-3     213    0.36%       70       19       51      266      249       17       16        1       83       20       20         4       19         0       51         0        52
     24  0xffff88b07f3d4140     3     577    0.35%       68       39       29      793      743       50       50        0      413      122        0        16       39         0       29         2       122
     25  0xffff8898baa67480     2    2378    0.34%       66       66        0     3933     3902       31       31        0     2817       42        0       976       66         0        0         0         1
     26  0xffff888c7ffd6200     0       1    0.33%       64       64        0      667      667        0        0        0        6        0        2       595       64         0        0         0         0
     27  0xffff8881c0642180     0     486    0.31%       61       51       10      654      589       65       65        0      362       33        0        36       51         0       10         6        91
     28  0xffff88b07f3d40c0     3     426    0.30%       58       33       25      616      575       41       41        0      329      127        0         3       33         0       25         0        58
     29  0xffff8881c0642e00     0     532    0.28%       54       54        0     5115     5115        0        0        0      554     3505        0       950       54         0        0         4        48
     30  0xffff888c7ffd62c0     0      37    0.28%       54       54        0      735      726        9        9        0        2       21        9       640       54         0        0         0         0
     31  0xffff88987ffd62c0     1      50    0.27%       53       53        0      690      684        6        6        0        6       16        9       600       53         0        0         0         0
     32  0xffff88b07ffd1200     3       1    0.27%       53       53        0      527      527        0        0        0        2        0        0       472       53         0        0         0         0
     33  0xffff88b07ffd12c0     3      30    0.27%       53       53        0      624      614       10       10        0        1       20        5       535       53         0        0         0         0
     34  0xffff88810c93d0c0     0     217    0.27%       52       23       29      500      450       50       50        0      142      189        0         8       23         0       29         2        57
     35  0xffff8898baa67400     2       1    0.27%       52       52        0      219      208       11       10        1      122        0        1        33       52         0        0         0         0
     36  0xffff888135089c00     0       1    0.26%       51       51        0      390      380       10        9        1      276        2        3        48       51         0        0         0         0
     37  0xffff88a47ffd6200     2       1    0.23%       44       44        0      548      548        0        0        0        2        0        2       500       44         0        0         0         0
     38  0xffff88987ffd6200     1       1    0.21%       42       42        0      639      639        0        0        0        3        0        4       590       42         0        0         0         0
     39  0xffff88a47ffd62c0     2      29    0.21%       42       42        0      622      614        8        8        0        2       17       15       538       42         0        0         0         0
     40  0xffff888c9c388800     1       1    0.20%       39       39        0      254      250        4        4        0      164        2        4        41       39         0        0         0         0
     41  0xffff88810c93d140     0     232    0.19%       38       23       15      468      423       45       45        0      157      142        0         8       23         0       15         3        75
     42  0xffff8898aa4b4b00     2     128    0.19%       38       38        0      192      152       40       40        0       66       44        0         4       38         0        0         0         0
     43  0xffff888110d10dc0     0       5    0.19%       37       37        0      655      655        0        0        0        8        3       47       536       37         0        0         4        20
     44  0xffff88b07f3d4180     3     275    0.17%       34       23       11      385      365       20       20        0      233       46        1         5       23         0       11         3        43
     45  0xffffffff83590800     3       7    0.17%       33        7       26      263       60      203      182       21        0        1        0         0        7         0       26         0        26
     46  0xffff88b06cac2c00     3       5    0.17%       33       33        0      302      299        3        3        0      212        0        0        54       33         0        0         0         0
     47  0xffff8898aa4b4dc0     2      78    0.15%       30       30        0      124       87       37       37        0       39       17        0         1       30         0        0         0         0
     48  0xffff88b07ffd0dc0     3     173    0.15%       30       30        0      972       40      932      928        4        6        0        0         4       30         0        0         0         0
     49  0xffff8898a989b200     2     109    0.15%       29       29        0      154      135       19       19        0       69       35        0         2       29         0        0         0         0
     50  0xffff88810c93d180     0     193    0.14%       27       21        6      293      269       24       24        0      147       50        0         6       21         0        6         6        33
     51  0xffff888c9c388ac0     1       1    0.14%       27       27        0      531      531        0        0        0       64        8        3       429       27         0        0         0         0
     52  0xffff88987ffff240     1      26    0.13%       26       24        2      300      294        6        6        0       23       12        1       230       24         0        2         0         2
     53  0xffff88b071197d00     3     108    0.13%       26        0       26      187      137       50       50        0       31       28        0         0        0         0       26         3        49
     54  0xffff8881c0642d80     0       1    0.12%       24       24        0       96       96        0        0        0        1        0        0        53       24         0        0         0        18
     55  0xffff88a47ffd5dc0     2     148    0.12%       23       23        0      982       38      944      941        3        4        5        0         6       23         0        0         0         0
     56  0xffff88a47ffff240     2      49    0.12%       23       23        0      359      345       14       14        0       42       22        0       256       23         0        0         0         2
     57  0xffff888c7ffff240     0      51    0.11%       22       20        2      379      365       14       14        0       21       16        0       298       20         0        2         0         8

=================================================
      Shared Cache Line Distribution Pareto      
=================================================
#
#        ----- HITM -----  -- Store Refs --  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                                             Shared                             
#   Num  RmtHitm  LclHitm   L1 Hit  L1 Miss              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load  records       cnt                          Symbol             Object            Source:Line  Node
# .....  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ..............................  .................  .....................  ....
#
  -------------------------------------------------------------
      0        0     2036        0        0  0xffff8881c0642000
  -------------------------------------------------------------
           0.00%   45.58%    0.00%    0.00%                 0x0     0       1  0xffffffff8137071c         0      2877      3221     8969       191  [k] __mod_memcg_state           [kernel.kallsyms]  memcontrol.c:772        0  1  2  3
           0.00%   20.92%    0.00%    0.00%                 0x0     0       1  0xffffffff8137091c         0      3027      2841     6626       188  [k] __count_memcg_events        [kernel.kallsyms]  memcontrol.c:920        0  1  2  3
           0.00%   17.88%    0.00%    0.00%                0x10     0       1  0xffffffff8136d7ad         0      3047      3326     3820       187  [k] get_mem_cgroup_from_mm      [kernel.kallsyms]  percpu-refcount.h:174   0  1  2  3
           0.00%    8.94%    0.00%    0.00%                0x10     0       1  0xffffffff81375374         0      3192      3041     2067       187  [k] mem_cgroup_charge           [kernel.kallsyms]  percpu-refcount.h:174   0  1  2  3
           0.00%    6.53%    0.00%    0.00%                0x10     0       1  0xffffffff8137534f         0      3405      3050     1628       186  [k] mem_cgroup_charge           [kernel.kallsyms]  percpu-refcount.h:174   0  1  2  3
           0.00%    0.05%    0.00%    0.00%                0x10     0       1  0xffffffff81373c3f         0      2456      2858       10        11  [k] __memcg_kmem_uncharge_page  [kernel.kallsyms]  percpu-refcount.h:174   0  1  2  3
           0.00%    0.05%    0.00%    0.00%                0x10     0       1  0xffffffff81373d8a         0       540      6490       11        11  [k] obj_cgroup_charge           [kernel.kallsyms]  percpu-refcount.h:174   0  1  2  3
           0.00%    0.05%    0.00%    0.00%                0x10     0       1  0xffffffff81375379         0     29925     20398        3         3  [k] mem_cgroup_charge           [kernel.kallsyms]  percpu-refcount.h:182   0  1

  -------------------------------------------------------------
      1        4     1955      129        7  0xffff888135089c40
  -------------------------------------------------------------
         100.00%   98.93%    0.00%    0.00%                0x10     0       1  0xffffffff8115f7e0       548       205       149     2071        49  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:511   0  2  3
           0.00%    0.46%    0.00%    0.00%                0x10     0       1  0xffffffff8115f71a         0       285       292       10         8  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:382   0
           0.00%    0.15%    0.00%    0.00%                0x10     0       1  0xffffffff8115f7a3         0       449       275      122        39  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  atomic.h:29       0
           0.00%    0.05%   39.53%    0.00%                0x10     0       1  0xffffffff81cfd399         0       645       234      191        47  [k] _raw_spin_lock_irqsave      [kernel.kallsyms]  atomic.h:202      0
           0.00%    0.00%    3.88%  100.00%                0x10     0       1  0xffffffff8115f7f3         0         0         0       12        11  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:263   0
           0.00%    0.00%    1.55%    0.00%                0x10     0       1  0xffffffff81cfd045         0         0         0        2         2  [k] _raw_spin_unlock_irqrestor  [kernel.kallsyms]  paravirt.h:590    0
           0.00%    0.41%   55.04%    0.00%                0x12     0       1  0xffffffff8115f7cf         0       577       431      208        48  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:182   0  2

  -------------------------------------------------------------
      2        0     1599      110        9  0xffff88b06cac2c40
  -------------------------------------------------------------
           0.00%   98.06%    0.00%    0.00%                0x10     3       1  0xffffffff8115f7e0         0       217       159     1652        48  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:511    3
           0.00%    1.06%    0.00%    0.00%                0x10     3       1  0xffffffff8115f71a         0       214       312       24        17  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:382    3
           0.00%    0.25%    0.00%    0.00%                0x10     3       1  0xffffffff8115f7a3         0       464       286      112        42  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  atomic.h:29        3
           0.00%    0.13%   35.45%    0.00%                0x10     3       1  0xffffffff81cfd399         0       488       249      152        46  [k] _raw_spin_lock_irqsave      [kernel.kallsyms]  atomic.h:202       3
           0.00%    0.00%    7.27%  100.00%                0x10     3       1  0xffffffff8115f7f3         0         0         0       17        14  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:263    3
           0.00%    0.00%    0.91%    0.00%                0x10     3       1  0xffffffff81cfd045         0         0         0        1         1  [k] _raw_spin_unlock_irqrestor  [kernel.kallsyms]  paravirt.h:590     3
           0.00%    0.50%   53.64%    0.00%                0x12     3       1  0xffffffff8115f7cf         0       633       487      170        45  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:182    3
           0.00%    0.00%    2.73%    0.00%                0x28     3       1  0xffffffff812f3445         0         0       259       14         1  [k] workingset_age_nonresident  [kernel.kallsyms]  atomic64_64.h:46   3

  -------------------------------------------------------------
      3        0     1340      139        5  0xffff888c9c388840
  -------------------------------------------------------------
           0.00%   96.72%    0.00%    0.00%                0x10     1       1  0xffffffff8115f7e0         0       208       248     1383        47  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:511    1
           0.00%    2.16%    0.00%    0.00%                0x10     1       1  0xffffffff8115f71a         0       210       281       36        18  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:382    1
           0.00%    0.30%    0.00%    0.00%                0x10     1       1  0xffffffff8115f7a3         0       665       287      104        41  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  atomic.h:29        1
           0.00%    0.15%   46.04%    0.00%                0x10     1       1  0xffffffff81cfd399         0       462       246      185        47  [k] _raw_spin_lock_irqsave      [kernel.kallsyms]  atomic.h:202       1  2  3
           0.00%    0.07%    0.00%    0.00%                0x10     1       1  0xffffffff8115f6f1         0       429       273        2         2  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.h:23     1
           0.00%    0.00%    0.00%   40.00%                0x10     1       1  0xffffffff8115f725         0         0         0        2         2  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:163    1
           0.00%    0.00%    5.76%   60.00%                0x10     1       1  0xffffffff8115f7f3         0         0         0       11         8  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:263    1
           0.00%    0.00%    0.72%    0.00%                0x10     1       1  0xffffffff81cfd045         0         0         0        1         1  [k] _raw_spin_unlock_irqrestor  [kernel.kallsyms]  paravirt.h:590     1
           0.00%    0.60%   47.48%    0.00%                0x12     1       1  0xffffffff8115f7cf         0       642       502      167        46  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:182    1

  -------------------------------------------------------------
      4        1     1253      125        6  0xffff8898baa67440
  -------------------------------------------------------------
         100.00%   97.37%    0.00%    0.00%                0x10     2       1  0xffffffff8115f7e0       538       201       154     1305        48  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:511   0  2
           0.00%    1.84%    0.00%    0.00%                0x10     2       1  0xffffffff8115f71a         0       209       266       26        15  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:382   2
           0.00%    0.40%    0.00%    0.00%                0x10     2       1  0xffffffff8115f7a3         0       511       264       96        41  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  atomic.h:29       2
           0.00%    0.08%   46.40%    0.00%                0x10     2       1  0xffffffff81cfd399         0       541       258      159        47  [k] _raw_spin_lock_irqsave      [kernel.kallsyms]  atomic.h:202      2  3
           0.00%    0.00%    1.60%    0.00%                0x10     2       1  0xffffffff8115f6f1         0         0         0        2         2  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.h:23    2
           0.00%    0.00%    9.60%  100.00%                0x10     2       1  0xffffffff8115f7f3         0         0         0       18        13  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:263   2
           0.00%    0.00%    0.80%    0.00%                0x10     2       1  0xffffffff8115f86c         0         0       170        3         3  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  atomic.h:202      2
           0.00%    0.00%    1.60%    0.00%                0x10     2       1  0xffffffff81cfd045         0         0         0        2         2  [k] _raw_spin_unlock_irqrestor  [kernel.kallsyms]  paravirt.h:590    2
           0.00%    0.32%   40.00%    0.00%                0x12     2       1  0xffffffff8115f7cf         0       632       471      150        45  [k] native_queued_spin_lock_sl  [kernel.kallsyms]  qspinlock.c:182   2

  -------------------------------------------------------------
      5        0     1220        0        0  0xffff8881c0642040
  -------------------------------------------------------------
           0.00%   47.87%    0.00%    0.00%                0x14     0       1  0xffffffff8136d779         0      2216      2113     4328       187  [k] get_mem_cgroup_from_mm      [kernel.kallsyms]  cgroup.h:353   0  1  2  3
           0.00%   30.74%    0.00%    0.00%                0x14     0       1  0xffffffff8137524a         0      2214      2145     3132       188  [k] mem_cgroup_charge           [kernel.kallsyms]  cgroup.h:323   0  1  2  3
           0.00%   20.90%    0.00%    0.00%                0x14     0       1  0xffffffff81375277         0      2317      2170     2205       188  [k] mem_cgroup_charge           [kernel.kallsyms]  cgroup.h:403   0  1  2  3
           0.00%    0.25%    0.00%    0.00%                0x14     0       1  0xffffffff81373c32         0      1264      2898       12        12  [k] __memcg_kmem_uncharge_page  [kernel.kallsyms]  cgroup.h:403   0  1  2  3
           0.00%    0.16%    0.00%    0.00%                0x14     0       1  0xffffffff81373cc8         0       931      1884        9        10  [k] obj_cgroup_charge           [kernel.kallsyms]  cgroup.h:353   0  1  2  3
           0.00%    0.08%    0.00%    0.00%                0x14     0       1  0xffffffff81373d36         0       631      4035       12        13  [k] obj_cgroup_charge           [kernel.kallsyms]  cgroup.h:403   0  1  2  3

  -------------------------------------------------------------
      6        0      927        0        0  0xffff8881c0642f80
  -------------------------------------------------------------
           0.00%   32.90%    0.00%    0.00%                 0x0     0       1  0xffffffff813708b9         0       724       553     2201        47  [k] __mod_lruvec_page_state   [kernel.kallsyms]  memcontrol.h:642   1
           0.00%    0.76%    0.00%    0.00%                 0x0     0       1  0xffffffff81372d39         0       963      1896       18        17  [k] lock_page_lruvec_irqsave  [kernel.kallsyms]  memcontrol.h:642   1
           0.00%    0.22%    0.00%    0.00%                 0x0     0       1  0xffffffff81353db2         0      1112       498        6         4  [k] kmem_cache_free           [kernel.kallsyms]  memcontrol.h:642   1
           0.00%    0.11%    0.00%    0.00%                 0x0     0       1  0xffffffff813508ec         0       375       227       10        10  [k] kmem_cache_alloc          [kernel.kallsyms]  memcontrol.h:642   1
           0.00%   30.74%    0.00%    0.00%                 0x8     0       1  0xffffffff813708b9         0       894       596     2086        47  [k] __mod_lruvec_page_state   [kernel.kallsyms]  memcontrol.h:642   2
           0.00%    0.43%    0.00%    0.00%                 0x8     0       1  0xffffffff813508ec         0       335       746       18        18  [k] kmem_cache_alloc          [kernel.kallsyms]  memcontrol.h:642   0  2  3
           0.00%    0.22%    0.00%    0.00%                 0x8     0       1  0xffffffff81353db2         0       800       440        3         3  [k] kmem_cache_free           [kernel.kallsyms]  memcontrol.h:642   2  3
           0.00%    0.22%    0.00%    0.00%                 0x8     0       1  0xffffffff81372d39         0       338       601       20        14  [k] lock_page_lruvec_irqsave  [kernel.kallsyms]  memcontrol.h:642   2
           0.00%   33.33%    0.00%    0.00%                0x10     0       1  0xffffffff813708b9         0       791       552     2135        48  [k] __mod_lruvec_page_state   [kernel.kallsyms]  memcontrol.h:642   3
           0.00%    0.54%    0.00%    0.00%                0x10     0       1  0xffffffff81372d39         0       781      1042       16        16  [k] lock_page_lruvec_irqsave  [kernel.kallsyms]  memcontrol.h:642   3
           0.00%    0.43%    0.00%    0.00%                0x10     0       1  0xffffffff813508ec         0       763       928       19        15  [k] kmem_cache_alloc          [kernel.kallsyms]  memcontrol.h:642   0  2  3
           0.00%    0.11%    0.00%    0.00%                0x10     0       1  0xffffffff812f398c         0      2174       689       10         1  [k] workingset_activation     [kernel.kallsyms]  memcontrol.h:642   3

  -------------------------------------------------------------
      7        5      438       27        0  0xffff888135089c80
  -------------------------------------------------------------
          20.00%   47.49%    0.00%    0.00%                 0x8     0       1  0xffffffff813708c1       387       217       123     2669        49  [k] __mod_lruvec_page_state   [kernel.kallsyms]  memcontrol.h:649   0  1
           0.00%   12.33%    0.00%    0.00%                 0x8     0       1  0xffffffff81370856         0       240       127     2877        49  [k] __mod_lruvec_state        [kernel.kallsyms]  memcontrol.c:857   0  2
           0.00%   11.19%    0.00%    0.00%                 0x8     0       1  0xffffffff812c99e7         0       222       196      169        45  [k] __pagevec_lru_add         [kernel.kallsyms]  mm_inline.h:31     0
           0.00%    2.28%    0.00%    0.00%                 0x8     0       1  0xffffffff812c9aff         0       256       394       33        22  [k] __pagevec_lru_add         [kernel.kallsyms]  memcontrol.h:683   0
          40.00%    0.46%    0.00%    0.00%                 0x8     0       1  0xffffffff813508f4       420       369       102       37        31  [k] kmem_cache_alloc          [kernel.kallsyms]  memcontrol.h:649   0  1  2  3
           0.00%    0.91%    0.00%    0.00%                 0x8     0       1  0xffffffff81372d41         0       209       305       10         8  [k] lock_page_lruvec_irqsave  [kernel.kallsyms]  memcontrol.h:649   0
          20.00%    0.46%    0.00%    0.00%                 0x8     0       1  0xffffffff81353dba       552       160       405        5         8  [k] kmem_cache_free           [kernel.kallsyms]  memcontrol.h:649   0  1  2  3
          20.00%   22.15%    0.00%    0.00%                0x10     0       1  0xffffffff81370765       496       213       118     2448        56  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:826   0  1  2  3
           0.00%    2.05%    0.00%    0.00%                0x18     0       1  0xffffffff81370804         0       184       253       87        41  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.h:785   0
           0.00%    0.68%    0.00%    0.00%                0x18     0       1  0xffffffff8137077e         0       205       129     2085        54  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:831   0  1  2  3
           0.00%    0.00%  100.00%    0.00%                0x20     0       1  0xffffffff813707e5         0         0      1532       78        40  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  atomic64_64.h:46   0

  -------------------------------------------------------------
      8        0      392        0        0  0xffff888135089ec0
  -------------------------------------------------------------
           0.00%   94.90%    0.00%    0.00%                0x20     0       1  0xffffffff8137074f         0       212       106     2944        59  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:823   0  1  2  3
           0.00%    2.55%    0.00%    0.00%                0x20     0       1  0xffffffff812c9d1e         0       180       183       44        27  [k] __pagevec_lru_add         [kernel.kallsyms]  memcontrol.h:683   0
           0.00%    2.55%    0.00%    0.00%                0x20     0       1  0xffffffff813707ea         0       187       166       34        26  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:806   0

  -------------------------------------------------------------
      9        1      333       22        0  0xffff88b06cac2c80
  -------------------------------------------------------------
           0.00%   37.54%    0.00%    0.00%                 0x8     3       1  0xffffffff813708c1         0       231       112     2294        48  [k] __mod_lruvec_page_state     [kernel.kallsyms]  memcontrol.h:649    3
           0.00%   18.32%    0.00%    0.00%                 0x8     3       1  0xffffffff81370856         0       205       121     2337        48  [k] __mod_lruvec_state          [kernel.kallsyms]  memcontrol.c:857    3
           0.00%   13.51%    0.00%    0.00%                 0x8     3       1  0xffffffff812c99e7         0       227       181      134        41  [k] __pagevec_lru_add           [kernel.kallsyms]  mm_inline.h:31      3
           0.00%    1.80%    0.00%    0.00%                 0x8     3       1  0xffffffff81372d41         0       217       214       14        12  [k] lock_page_lruvec_irqsave    [kernel.kallsyms]  memcontrol.h:649    3
           0.00%    0.90%    0.00%    0.00%                 0x8     3       1  0xffffffff812c9aff         0       211       166       21        17  [k] __pagevec_lru_add           [kernel.kallsyms]  memcontrol.h:683    3
         100.00%    0.60%    0.00%    0.00%                 0x8     3       1  0xffffffff81353dba       386       187       444        6         4  [k] kmem_cache_free             [kernel.kallsyms]  memcontrol.h:649    0  1  2  3
           0.00%    0.30%    0.00%    0.00%                 0x8     3       1  0xffffffff812f346f         0       178       125       12         1  [k] workingset_age_nonresident  [kernel.kallsyms]  memcontrol.h:1409   3
           0.00%    0.30%    0.00%    0.00%                 0x8     3       1  0xffffffff813508f4         0       207       225       15        14  [k] kmem_cache_alloc            [kernel.kallsyms]  memcontrol.h:649    2  3
           0.00%   23.42%    0.00%    0.00%                0x10     3       1  0xffffffff81370765         0       215       109     2110        51  [k] __mod_memcg_lruvec_state    [kernel.kallsyms]  memcontrol.c:826    1  2  3
           0.00%    3.30%    0.00%    0.00%                0x18     3       1  0xffffffff81370804         0       180       267       62        34  [k] __mod_memcg_lruvec_state    [kernel.kallsyms]  memcontrol.h:785    3
           0.00%    0.00%  100.00%    0.00%                0x20     3       1  0xffffffff813707e5         0         0       769       63        36  [k] __mod_memcg_lruvec_state    [kernel.kallsyms]  atomic64_64.h:46    3

  -------------------------------------------------------------
     10        0      311        0        0  0xffff88b06cac2ec0
  -------------------------------------------------------------
           0.00%   91.96%    0.00%    0.00%                0x20     3       1  0xffffffff8137074f         0       199        95     2345        50  [k] __mod_memcg_lruvec_state    [kernel.kallsyms]  memcontrol.c:823   1  2  3
           0.00%    5.14%    0.00%    0.00%                0x20     3       1  0xffffffff812c9d1e         0       184       128       43        26  [k] __pagevec_lru_add           [kernel.kallsyms]  memcontrol.h:683   3
           0.00%    2.25%    0.00%    0.00%                0x20     3       1  0xffffffff813707ea         0       216       118       41        27  [k] __mod_memcg_lruvec_state    [kernel.kallsyms]  memcontrol.c:806   3
           0.00%    0.64%    0.00%    0.00%                0x20     3       1  0xffffffff812f344f         0       156        70       12         1  [k] workingset_age_nonresident  [kernel.kallsyms]  memcontrol.h:773   3

  -------------------------------------------------------------
     11        0      258        0        0  0xffff8881c0642100
  -------------------------------------------------------------
           0.00%    3.10%    0.00%    0.00%                 0x0     0       1  0xffffffff8136a462         0       668       571       86        78  [k] propagate_protected_usage   [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
           0.00%    1.55%    0.00%    0.00%                0x18     0       1  0xffffffff8136a457         0       505       510       80        66  [k] propagate_protected_usage   [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
           0.00%   70.16%    0.00%    0.00%                0x38     0       1  0xffffffff813707f8         0       645       682      611       175  [k] __mod_memcg_lruvec_state    [kernel.kallsyms]  memcontrol.c:806     0  1  2  3
           0.00%   13.18%    0.00%    0.00%                0x38     0       1  0xffffffff81371e04         0       638       743       89        80  [k] try_charge                  [kernel.kallsyms]  memcontrol.c:2846    0  1  2  3
           0.00%    7.75%    0.00%    0.00%                0x38     0       1  0xffffffff8136a405         0       445       570      110        86  [k] propagate_protected_usage   [kernel.kallsyms]  page_counter.c:23    0  1  2  3
           0.00%    2.33%    0.00%    0.00%                0x38     0       1  0xffffffff8136ce05         0       750       840       34        33  [k] memcg_check_events          [kernel.kallsyms]  memcontrol.c:4150    0  1  2  3
           0.00%    1.16%    0.00%    0.00%                0x38     0       1  0xffffffff812f345b         0       465       488       18         2  [k] workingset_age_nonresident  [kernel.kallsyms]  memcontrol.h:1406    1  3
           0.00%    0.78%    0.00%    0.00%                0x38     0       1  0xffffffff8136ceb3         0       912       642        4         4  [k] memcg_check_events          [kernel.kallsyms]  memcontrol.c:686     2  3

  -------------------------------------------------------------
     12        0      255       65      138  0xffff888135089e00
  -------------------------------------------------------------
           0.00%   88.24%    0.00%    0.00%                0x28     0       1  0xffffffff81372d9f         0       248       165      276        47  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1391   0
           0.00%   11.76%  100.00%  100.00%                0x28     0       1  0xffffffff81372db3         0       174       184      454        48  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1403   0

  -------------------------------------------------------------
     13        0      197       91      109  0xffff88b06cac2e00
  -------------------------------------------------------------
           0.00%   83.25%    0.00%    0.00%                0x28     3       1  0xffffffff81372d9f         0       172       148      204        46  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1391   3
           0.00%   15.74%   98.90%   99.08%                0x28     3       1  0xffffffff81372db3         0       182       171      434        48  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1403   3
           0.00%    0.51%    0.00%    0.00%                0x30     3       1  0xffffffff81372d9f         0       177         0        1         1  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1391   3
           0.00%    0.51%    1.10%    0.92%                0x30     3       1  0xffffffff81372db3         0       160       143        5         1  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1403   3

  -------------------------------------------------------------
     14       36       70      191        0  0xffff8881c06420c0
  -------------------------------------------------------------
          33.33%   21.43%    0.00%    0.00%                0x10     0       1  0xffffffff81371db1       791       765       798      120        82  [k] try_charge                 [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
          16.67%   15.71%   95.81%    0.00%                0x10     0       1  0xffffffff8136a588      2155      1851      1855      378       156  [k] page_counter_try_charge    [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           2.78%    7.14%    0.00%    0.00%                0x10     0       1  0xffffffff8136ced8       810       462       583       11        10  [k] memcg_check_events         [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
           0.00%    0.00%    4.19%    0.00%                0x10     0       1  0xffffffff8136a48c         0         0        42        9         5  [k] page_counter_cancel        [kernel.kallsyms]  atomic64_64.h:160    1  2  3
          27.78%   25.71%    0.00%    0.00%                0x18     0       1  0xffffffff8136a40c       677       653      1139      131        93  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:26    0  1  2  3
           2.78%   14.29%    0.00%    0.00%                0x20     0       1  0xffffffff8136a431      1706       625       892      120        87  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:35    0  1  2  3
           8.33%    8.57%    0.00%    0.00%                0x28     0       1  0xffffffff81371db9       522       351       956       90        73  [k] try_charge                 [kernel.kallsyms]  memcontrol.c:2819    0  1  2  3
           8.33%    7.14%    0.00%    0.00%                0x30     0       1  0xffffffff8136a595       483      1446       933      107        80  [k] page_counter_try_charge    [kernel.kallsyms]  page_counter.c:117   0  1  2  3

  -------------------------------------------------------------
     15        0      104        0        0  0xffff8881c0642f40
  -------------------------------------------------------------
           0.00%   96.15%    0.00%    0.00%                0x38     0       1  0xffffffff813708b9         0       427       242     1101        49  [k] __mod_lruvec_page_state   [kernel.kallsyms]  memcontrol.h:642   0  1  2
           0.00%    1.92%    0.00%    0.00%                0x38     0       1  0xffffffff81372d39         0       274        69        7         7  [k] lock_page_lruvec_irqsave  [kernel.kallsyms]  memcontrol.h:642   0  2
           0.00%    0.96%    0.00%    0.00%                0x38     0       1  0xffffffff813508ec         0       155       280       12        13  [k] kmem_cache_alloc          [kernel.kallsyms]  memcontrol.h:642   0  1  2  3
           0.00%    0.96%    0.00%    0.00%                0x38     0       1  0xffffffff81353db2         0       195       313        2         3  [k] kmem_cache_free           [kernel.kallsyms]  memcontrol.h:642   1  2

  -------------------------------------------------------------
     16       23       70      148        0  0xffff8881c0642140
  -------------------------------------------------------------
          39.13%   48.57%    0.00%    0.00%                 0x0     0       1  0xffffffff81371dc8      1162       582       750      122        97  [k] try_charge                 [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
          21.74%   22.86%   95.27%    0.00%                 0x0     0       1  0xffffffff8136a588      2193      3242      1974      375       162  [k] page_counter_try_charge    [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           0.00%    0.00%    4.05%    0.00%                 0x0     0       1  0xffffffff8136a48c         0         0        57       21         2  [k] page_counter_cancel        [kernel.kallsyms]  atomic64_64.h:160    0  3
           0.00%    0.00%    0.68%    0.00%                 0x0     0       1  0xffffffff8136a4d7         0         0         0        1         1  [k] page_counter_charge        [kernel.kallsyms]  atomic64_64.h:160    1
          30.43%   20.00%    0.00%    0.00%                 0x8     0       1  0xffffffff8136a40c       929       680       815      142        92  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:26    0  1  2  3
           4.35%    0.00%    0.00%    0.00%                0x10     0       1  0xffffffff8136a431       446         0       922      132        93  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:35    0  1  2  3
           0.00%    2.86%    0.00%    0.00%                0x18     0       1  0xffffffff81371dd0         0      1436       841      130        91  [k] try_charge                 [kernel.kallsyms]  memcontrol.c:2821    0  1  2  3
           4.35%    4.29%    0.00%    0.00%                0x20     0       1  0xffffffff8136a595       974       405      1109      142        95  [k] page_counter_try_charge    [kernel.kallsyms]  page_counter.c:117   0  1  2  3
           0.00%    1.43%    0.00%    0.00%                0x30     0       1  0xffffffff8136a462         0      2012       858      143        95  [k] propagate_protected_usage  [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3

  -------------------------------------------------------------
     17        0       91       76       50  0xffff888c9c388a00
  -------------------------------------------------------------
           0.00%   90.11%    0.00%    0.00%                0x28     1       1  0xffffffff81372d9f         0       184       170       96        41  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1391   1
           0.00%    9.89%  100.00%  100.00%                0x28     1       1  0xffffffff81372db3         0       187       190      235        47  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1403   1

  -------------------------------------------------------------
     18        0       87        0        0  0xffff88b07f3d4100
  -------------------------------------------------------------
           0.00%    2.30%    0.00%    0.00%                 0x0     3       1  0xffffffff8136a462         0       321       309       59        50  [k] propagate_protected_usage   [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
           0.00%    1.15%    0.00%    0.00%                0x18     3       1  0xffffffff8136a457         0       415       381       59        50  [k] propagate_protected_usage   [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
           0.00%   72.41%    0.00%    0.00%                0x38     3       1  0xffffffff813707f8         0       219       230      358       149  [k] __mod_memcg_lruvec_state    [kernel.kallsyms]  memcontrol.c:806     0  1  2  3
           0.00%   12.64%    0.00%    0.00%                0x38     3       1  0xffffffff8136a405         0       374       280       57        52  [k] propagate_protected_usage   [kernel.kallsyms]  page_counter.c:23    0  1  2  3
           0.00%    4.60%    0.00%    0.00%                0x38     3       1  0xffffffff81371e04         0       423       533       18        20  [k] try_charge                  [kernel.kallsyms]  memcontrol.c:2846    0  1  2  3
           0.00%    3.45%    0.00%    0.00%                0x38     3       1  0xffffffff8136ce05         0       412       174       29        28  [k] memcg_check_events          [kernel.kallsyms]  memcontrol.c:4150    0  1  2  3
           0.00%    2.30%    0.00%    0.00%                0x38     3       1  0xffffffff812f345b         0       230       231        8         2  [k] workingset_age_nonresident  [kernel.kallsyms]  memcontrol.h:1406    3
           0.00%    1.15%    0.00%    0.00%                0x38     3       1  0xffffffff8136ceb3         0       149         0        1         1  [k] memcg_check_events          [kernel.kallsyms]  memcontrol.c:686     3

  -------------------------------------------------------------
     19        0       84       74       38  0xffff8898baa67600
  -------------------------------------------------------------
           0.00%   84.52%    0.00%    0.00%                0x28     2       1  0xffffffff81372d9f         0       181       173       88        40  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1391   2
           0.00%   15.48%  100.00%  100.00%                0x28     2       1  0xffffffff81372db3         0       176       177      210        47  [k] mem_cgroup_update_lru_size  [kernel.kallsyms]  memcontrol.c:1403   2

  -------------------------------------------------------------
     20       15       63        5        0  0xffff888110d10d80
  -------------------------------------------------------------
         100.00%   98.41%    0.00%    0.00%                 0x0     0       1  0xffffffff812d695c       688       550       190     1020       182  [k] shmem_alloc_and_acct_page  [kernel.kallsyms]  shmem.c:224            0  1  2  3
           0.00%    0.00%  100.00%    0.00%                 0x8     0       1  0xffffffff81cfd399         0         0       781       29        25  [k] _raw_spin_lock_irqsave     [kernel.kallsyms]  atomic.h:202           0  1  2  3
           0.00%    1.59%    0.00%    0.00%                0x10     0       1  0xffffffff8165080a         0       154       229      962       183  [k] __percpu_counter_compare   [kernel.kallsyms]  percpu_counter.c:225   0  1  2  3

  -------------------------------------------------------------
     21        0       73        0        0  0xffff88810c93d100
  -------------------------------------------------------------
           0.00%   79.45%    0.00%    0.00%                0x38     0       1  0xffffffff813707f8         0       313       271      337       151  [k] __mod_memcg_lruvec_state    [kernel.kallsyms]  memcontrol.c:806     0  1  2  3
           0.00%    9.59%    0.00%    0.00%                0x38     0       1  0xffffffff8136a405         0       439       411       49        47  [k] propagate_protected_usage   [kernel.kallsyms]  page_counter.c:23    0  1  2  3
           0.00%    6.85%    0.00%    0.00%                0x38     0       1  0xffffffff81371e04         0       575       534       18        18  [k] try_charge                  [kernel.kallsyms]  memcontrol.c:2846    0  1  2  3
           0.00%    2.74%    0.00%    0.00%                0x38     0       1  0xffffffff812f345b         0       334       296        6         2  [k] workingset_age_nonresident  [kernel.kallsyms]  memcontrol.h:1406    3
           0.00%    1.37%    0.00%    0.00%                0x38     0       1  0xffffffff8136ce05         0       418       204       20        22  [k] memcg_check_events          [kernel.kallsyms]  memcontrol.c:4150    0  1  2  3

  -------------------------------------------------------------
     22        0       71       21        0  0xffff888c9c388880
  -------------------------------------------------------------
           0.00%   35.21%    0.00%    0.00%                 0x8     1       1  0xffffffff813708c1         0       195        88      990        48  [k] __mod_lruvec_page_state   [kernel.kallsyms]  memcontrol.h:649   1
           0.00%   26.76%    0.00%    0.00%                 0x8     1       1  0xffffffff81370856         0       192        91      990        47  [k] __mod_lruvec_state        [kernel.kallsyms]  memcontrol.c:857   1
           0.00%    5.63%    0.00%    0.00%                 0x8     1       1  0xffffffff812c99e7         0       208        76       49        32  [k] __pagevec_lru_add         [kernel.kallsyms]  mm_inline.h:31     1
           0.00%    2.82%    0.00%    0.00%                 0x8     1       1  0xffffffff81372d41         0       215         0        2         2  [k] lock_page_lruvec_irqsave  [kernel.kallsyms]  memcontrol.h:649   1
           0.00%   25.35%    0.00%    0.00%                0x10     1       1  0xffffffff81370765         0       199        83      848        48  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:826   1  3
           0.00%    2.82%    0.00%    0.00%                0x18     1       1  0xffffffff81370804         0       184       182       39        25  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.h:785   1
           0.00%    1.41%    0.00%    0.00%                0x18     1       1  0xffffffff8137077e         0       207        84      774        47  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:831   1
           0.00%    0.00%  100.00%    0.00%                0x20     1       1  0xffffffff813707e5         0         0       955       82        38  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  atomic64_64.h:46   1  3

  -------------------------------------------------------------
     23       51       19       16        1      0x7f4a046a6400
  -------------------------------------------------------------
          98.04%   94.74%    0.00%    0.00%                 0x0   0-3     100      0x562cfe68b57a       401       202       129      151         2  [.] 0x00000000003f257a  perf              perf[3f257a]   3
           1.96%    5.26%    0.00%    0.00%                 0x0   0-3      96      0x562cfe68b651       702       183       262       98         2  [.] 0x00000000003f2651  perf              perf[3f2651]   3
           0.00%    0.00%  100.00%  100.00%                 0x8   0-3      17      0x562cfe68b5c4         0         0         0       17         1  [.] 0x00000000003f25c4  perf              perf[3f25c4]   3

  -------------------------------------------------------------
     24       29       39       50        0  0xffff88b07f3d4140
  -------------------------------------------------------------
          34.48%   33.33%   86.00%    0.00%                 0x0     3       1  0xffffffff8136a588      2539      2198      1558      243       138  [k] page_counter_try_charge    [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
          34.48%   33.33%    0.00%    0.00%                 0x0     3       1  0xffffffff81371dc8       703       303       479       86        66  [k] try_charge                 [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
           0.00%    0.00%   12.00%    0.00%                 0x0     3       1  0xffffffff8136a48c         0         0        73       22         4  [k] page_counter_cancel        [kernel.kallsyms]  atomic64_64.h:160    1  2  3
           0.00%    0.00%    2.00%    0.00%                 0x0     3       1  0xffffffff8136a4d7         0         0         0        1         1  [k] page_counter_charge        [kernel.kallsyms]  atomic64_64.h:160    3
          13.79%   10.26%    0.00%    0.00%                 0x8     3       1  0xffffffff8136a40c      1151       360       556       92        75  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:26    0  1  2  3
           0.00%    2.56%    0.00%    0.00%                0x10     3       1  0xffffffff8136a431         0       266       484       94        76  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:35    0  1  2  3
           6.90%    7.69%    0.00%    0.00%                0x18     3       1  0xffffffff81371dd0       864       369       583       68        53  [k] try_charge                 [kernel.kallsyms]  memcontrol.c:2821    0  1  2  3
          10.34%   10.26%    0.00%    0.00%                0x20     3       1  0xffffffff8136a595       428       489       464       83        66  [k] page_counter_try_charge    [kernel.kallsyms]  page_counter.c:117   0  1  2  3
           0.00%    2.56%    0.00%    0.00%                0x30     3       1  0xffffffff8136a462         0       746       516      104        73  [k] propagate_protected_usage  [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3

  -------------------------------------------------------------
     25        0       66       31        0  0xffff8898baa67480
  -------------------------------------------------------------
           0.00%   40.91%    0.00%    0.00%                 0x8     2       1  0xffffffff813708c1         0       182        82     1002        45  [k] __mod_lruvec_page_state   [kernel.kallsyms]  memcontrol.h:649   2
           0.00%   24.24%    0.00%    0.00%                 0x8     2       1  0xffffffff81370856         0       189        90     1057        48  [k] __mod_lruvec_state        [kernel.kallsyms]  memcontrol.c:857   2
           0.00%    1.52%    0.00%    0.00%                 0x8     2       1  0xffffffff812c99e7         0       205        74       50        30  [k] __pagevec_lru_add         [kernel.kallsyms]  mm_inline.h:31     2
           0.00%    1.52%    0.00%    0.00%                 0x8     2       1  0xffffffff81372d41         0       202       232        3         3  [k] lock_page_lruvec_irqsave  [kernel.kallsyms]  memcontrol.h:649   2
           0.00%   25.76%    0.00%    0.00%                0x10     2       1  0xffffffff81370765         0       175        80      888        49  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:826   0  1  2  3
           0.00%    3.03%    0.00%    0.00%                0x18     2       1  0xffffffff8137077e         0       238        85      788        48  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:831   1  2
           0.00%    3.03%    0.00%    0.00%                0x18     2       1  0xffffffff81370804         0       191       216       46        29  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.h:785   2
           0.00%    0.00%  100.00%    0.00%                0x20     2       1  0xffffffff813707e5         0         0      1441       71        38  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  atomic64_64.h:46   2  3

  -------------------------------------------------------------
     26        0       64        0        0  0xffff888c7ffd6200
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x38     0       1  0xffffffff81321c91         0       179        82      667        47  [k] rmqueue  [kernel.kallsyms]  bitops.h:207   0

  -------------------------------------------------------------
     27       10       51       65        0  0xffff8881c0642180
  -------------------------------------------------------------
           0.00%   11.76%    0.00%    0.00%                 0x8     0       1  0xffffffff8136a457         0       725       499       96        76  [k] propagate_protected_usage  [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
          60.00%   72.55%    0.00%    0.00%                0x28     0       1  0xffffffff8136a405       864       698       654      124        91  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:23    0  1  2  3
           0.00%    5.88%   69.23%    0.00%                0x30     0       1  0xffffffff8136a588         0      1952      1525       95        73  [k] page_counter_try_charge    [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           0.00%    1.96%   30.77%    0.00%                0x30     0       1  0xffffffff8136a48c         0      6729      1648       36        32  [k] page_counter_cancel        [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
          40.00%    7.84%    0.00%    0.00%                0x38     0       1  0xffffffff8136a40c       505       886       538       45        43  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:26    0  1  2  3

  -------------------------------------------------------------
     28       25       33       41        0  0xffff88b07f3d40c0
  -------------------------------------------------------------
          40.00%   48.48%    0.00%    0.00%                0x10     3       1  0xffffffff81371db1       583       356       676       58        44  [k] try_charge                 [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
          28.00%   21.21%   87.80%    0.00%                0x10     3       1  0xffffffff8136a588      1165      1103       871      181       122  [k] page_counter_try_charge    [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           0.00%    9.09%    0.00%    0.00%                0x10     3       1  0xffffffff8136ced8         0       283       502        5         5  [k] memcg_check_events         [kernel.kallsyms]  atomic64_64.h:22     0  2  3
           0.00%    0.00%    9.76%    0.00%                0x10     3       1  0xffffffff8136a48c         0         0        34       23         3  [k] page_counter_cancel        [kernel.kallsyms]  atomic64_64.h:160    3
           0.00%    0.00%    2.44%    0.00%                0x10     3       1  0xffffffff8136a4d7         0         0         0        1         1  [k] page_counter_charge        [kernel.kallsyms]  atomic64_64.h:160    1
          20.00%    6.06%    0.00%    0.00%                0x18     3       1  0xffffffff8136a40c       661       170       418      104        79  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:26    0  1  2  3
           4.00%    0.00%    0.00%    0.00%                0x20     3       1  0xffffffff8136a431       518         0       506       85        70  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:35    0  1  2  3
           4.00%    3.03%    0.00%    0.00%                0x28     3       1  0xffffffff81371db9       589       170       525       66        56  [k] try_charge                 [kernel.kallsyms]  memcontrol.c:2819    0  1  2  3
           4.00%   12.12%    0.00%    0.00%                0x30     3       1  0xffffffff8136a595       507       194       455       93        73  [k] page_counter_try_charge    [kernel.kallsyms]  page_counter.c:117   0  1  2  3

  -------------------------------------------------------------
     29        0       54        0        0  0xffff8881c0642e00
  -------------------------------------------------------------
           0.00%   11.11%    0.00%    0.00%                 0x0     0       1  0xffffffff8136ae30         0       316       538      192       124  [k] lock_page_memcg             [kernel.kallsyms]  atomic.h:29         0  1  2  3
           0.00%    7.41%    0.00%    0.00%                 0x8     0       1  0xffffffff8136b213         0       750       425       80        64  [k] __unlock_page_memcg         [kernel.kallsyms]  memcontrol.c:2169   0  1  2  3
           0.00%   38.89%    0.00%    0.00%                0x10     0       1  0xffffffff8137070a         0       778       199     2266       185  [k] __mod_memcg_state           [kernel.kallsyms]  memcontrol.c:771    0  1  2  3
           0.00%   38.89%    0.00%    0.00%                0x10     0       1  0xffffffff8137090a         0      1433      2130     1374       181  [k] __count_memcg_events        [kernel.kallsyms]  memcontrol.c:919    0  1  2  3
           0.00%    3.70%    0.00%    0.00%                0x10     0       1  0xffffffff8137095c         0       524       394      181       117  [k] mem_cgroup_charge_statisti  [kernel.kallsyms]  memcontrol.c:950    0  1  2  3

  -------------------------------------------------------------
     30        0       54        9        0  0xffff888c7ffd62c0
  -------------------------------------------------------------
           0.00%   88.89%    0.00%    0.00%                 0x0     0       1  0xffffffff81323d2a         0       175        81      689        47  [k] get_page_from_freelist    [kernel.kallsyms]  atomic64_64.h:22   0
           0.00%   11.11%    0.00%    0.00%                 0x0     0       1  0xffffffff813211d3         0       207        84       10         9  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  atomic64_64.h:22   0
           0.00%    0.00%   33.33%    0.00%                 0x0     0       1  0xffffffff812ded07         0         0       565       17        16  [k] __mod_zone_page_state     [kernel.kallsyms]  atomic64_64.h:46   0
           0.00%    0.00%   66.67%    0.00%                 0x8     0       1  0xffffffff812ded07         0         0      1166       19        16  [k] __mod_zone_page_state     [kernel.kallsyms]  atomic64_64.h:46   0

  -------------------------------------------------------------
     31        0       53        6        0  0xffff88987ffd62c0
  -------------------------------------------------------------
           0.00%   88.68%    0.00%    0.00%                 0x0     1       1  0xffffffff81323d2a         0       179        72      643        47  [k] get_page_from_freelist    [kernel.kallsyms]  atomic64_64.h:22   1
           0.00%   11.32%    0.00%    0.00%                 0x0     1       1  0xffffffff813211d3         0       188       147       10        10  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  atomic64_64.h:22   1
           0.00%    0.00%   33.33%    0.00%                 0x0     1       1  0xffffffff812ded07         0         0       870       11         9  [k] __mod_zone_page_state     [kernel.kallsyms]  atomic64_64.h:46   1  3
           0.00%    0.00%   50.00%    0.00%                 0x8     1       1  0xffffffff812ded07         0         0      2094       25        21  [k] __mod_zone_page_state     [kernel.kallsyms]  atomic64_64.h:46   1  3
           0.00%    0.00%   16.67%    0.00%                0x10     1       1  0xffffffff812def35         0         0         0        1         1  [k] refresh_cpu_vm_stats      [kernel.kallsyms]  atomic64_64.h:46   1

  -------------------------------------------------------------
     32        0       53        0        0  0xffff88b07ffd1200
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x38     3       1  0xffffffff81321c91         0       174        79      527        47  [k] rmqueue  [kernel.kallsyms]  bitops.h:207   3

  -------------------------------------------------------------
     33        0       53       10        0  0xffff88b07ffd12c0
  -------------------------------------------------------------
           0.00%   73.58%    0.00%    0.00%                 0x0     3       1  0xffffffff81323d2a         0       166        72      571        48  [k] get_page_from_freelist    [kernel.kallsyms]  atomic64_64.h:22   3
           0.00%   26.42%    0.00%    0.00%                 0x0     3       1  0xffffffff813211d3         0       189        54       16        13  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  atomic64_64.h:22   3
           0.00%    0.00%   50.00%    0.00%                 0x0     3       1  0xffffffff812ded07         0         0       433       22        22  [k] __mod_zone_page_state     [kernel.kallsyms]  atomic64_64.h:46   3
           0.00%    0.00%   50.00%    0.00%                 0x8     3       1  0xffffffff812ded07         0         0      1259       14        11  [k] __mod_zone_page_state     [kernel.kallsyms]  atomic64_64.h:46   3

  -------------------------------------------------------------
     34       29       23       50        0  0xffff88810c93d0c0
  -------------------------------------------------------------
          48.28%   52.17%    0.00%    0.00%                0x10     0       1  0xffffffff81371db1       565       594       852       74        53  [k] try_charge               [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
           3.45%    8.70%   94.00%    0.00%                0x10     0       1  0xffffffff8136a588      1289      1074       645      225       132  [k] page_counter_try_charge  [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           3.45%    4.35%    0.00%    0.00%                0x10     0       1  0xffffffff8136ced8       363       206       503        4         3  [k] memcg_check_events       [kernel.kallsyms]  atomic64_64.h:22     1  2
           0.00%    0.00%    6.00%    0.00%                0x10     0       1  0xffffffff8136a48c         0         0        50       29         2  [k] page_counter_cancel      [kernel.kallsyms]  atomic64_64.h:160    1  3
          10.34%    8.70%    0.00%    0.00%                0x28     0       1  0xffffffff81371db9       820       324       648       56        49  [k] try_charge               [kernel.kallsyms]  memcontrol.c:2819    0  1  2  3
          34.48%   26.09%    0.00%    0.00%                0x30     0       1  0xffffffff8136a595       708       924       594      112        77  [k] page_counter_try_charge  [kernel.kallsyms]  page_counter.c:117   0  1  2  3

  -------------------------------------------------------------
     35        0       52       10        1  0xffff8898baa67400
  -------------------------------------------------------------
           0.00%   94.23%    0.00%    0.00%                 0x0     2       1  0xffffffff812c9a87         0       202       159       90        39  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:86         2
           0.00%    5.77%    0.00%    0.00%                 0x0     2       1  0xffffffff81632410         0       160       156      118        42  [k] __list_add_valid   [kernel.kallsyms]  list_debug.c:26   2
           0.00%    0.00%  100.00%  100.00%                 0x0     2       1  0xffffffff812c9aa6         0         0         0       11         9  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:73         2

  -------------------------------------------------------------
     36        0       51        9        1  0xffff888135089c00
  -------------------------------------------------------------
           0.00%   98.04%    0.00%    0.00%                 0x0     0       1  0xffffffff812c9a87         0       191       148      134        42  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:86         0
           0.00%    1.96%    0.00%    0.00%                 0x0     0       1  0xffffffff81632410         0       165       159      246        46  [k] __list_add_valid   [kernel.kallsyms]  list_debug.c:26   0
           0.00%    0.00%  100.00%  100.00%                 0x0     0       1  0xffffffff812c9aa6         0         0         0       10         9  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:73         0

  -------------------------------------------------------------
     37        0       44        0        0  0xffff88a47ffd6200
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x38     2       1  0xffffffff81321c91         0       241        84      548        46  [k] rmqueue  [kernel.kallsyms]  bitops.h:207   2

  -------------------------------------------------------------
     38        0       42        0        0  0xffff88987ffd6200
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x38     1       1  0xffffffff81321c91         0       187        78      639        47  [k] rmqueue  [kernel.kallsyms]  bitops.h:207   1

  -------------------------------------------------------------
     39        0       42        8        0  0xffff88a47ffd62c0
  -------------------------------------------------------------
           0.00%   76.19%    0.00%    0.00%                 0x0     2       1  0xffffffff81323d2a         0       175        77      574        46  [k] get_page_from_freelist    [kernel.kallsyms]  atomic64_64.h:22   2
           0.00%   23.81%    0.00%    0.00%                 0x0     2       1  0xffffffff813211d3         0       245        98       14        11  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  atomic64_64.h:22   2
           0.00%    0.00%   62.50%    0.00%                 0x0     2       1  0xffffffff812ded07         0         0       664       20        17  [k] __mod_zone_page_state     [kernel.kallsyms]  atomic64_64.h:46   2  3
           0.00%    0.00%   37.50%    0.00%                 0x8     2       1  0xffffffff812ded07         0         0       931       14        10  [k] __mod_zone_page_state     [kernel.kallsyms]  atomic64_64.h:46   2  3

  -------------------------------------------------------------
     40        0       39        4        0  0xffff888c9c388800
  -------------------------------------------------------------
           0.00%   94.87%    0.00%    0.00%                 0x0     1       1  0xffffffff812c9a87         0       214       156       91        39  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:86         1
           0.00%    5.13%    0.00%    0.00%                 0x0     1       1  0xffffffff81632410         0       204       160      159        44  [k] __list_add_valid   [kernel.kallsyms]  list_debug.c:26   1
           0.00%    0.00%  100.00%    0.00%                 0x0     1       1  0xffffffff812c9aa6         0         0         0        4         2  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:73         1

  -------------------------------------------------------------
     41       15       23       45        0  0xffff88810c93d140
  -------------------------------------------------------------
          40.00%   43.48%    0.00%    0.00%                 0x0     0       1  0xffffffff81371dc8       452       548       636       71        55  [k] try_charge               [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
          46.67%   21.74%   93.33%    0.00%                 0x0     0       1  0xffffffff8136a588      1926      2026      1324      213       127  [k] page_counter_try_charge  [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           0.00%    0.00%    6.67%    0.00%                 0x0     0       1  0xffffffff8136a48c         0         0        86       23         1  [k] page_counter_cancel      [kernel.kallsyms]  atomic64_64.h:160    3
           0.00%   13.04%    0.00%    0.00%                0x18     0       1  0xffffffff81371dd0         0       284       550       71        60  [k] try_charge               [kernel.kallsyms]  memcontrol.c:2821    0  1  2  3
          13.33%   21.74%    0.00%    0.00%                0x20     0       1  0xffffffff8136a595       454       305       584       90        73  [k] page_counter_try_charge  [kernel.kallsyms]  page_counter.c:117   0  1  2  3

  -------------------------------------------------------------
     42        0       38       40        0  0xffff8898aa4b4b00
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x8     2       1  0xffffffff812da2fe         0       163        73       39         1  [k] shmem_fault                [kernel.kallsyms]  shmem.c:2066     2
           0.00%    0.00%    5.00%    0.00%                0x18     2       1  0xffffffff812d9b44         0         0         0        2         1  [k] shmem_getpage_gfp          [kernel.kallsyms]  paravirt.h:590   2
           0.00%    0.00%   95.00%    0.00%                0x18     2       1  0xffffffff81cfd114         0         0       219       84         1  [k] _raw_spin_lock_irq         [kernel.kallsyms]  atomic.h:202     2

  -------------------------------------------------------------
     43        0       37        0        0  0xffff888110d10dc0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x6     0       1  0xffffffff812d9d5a         0       626       150      653       177  [k] shmem_getpage_gfp  [kernel.kallsyms]  shmem.c:1867   0  1  2  3

  -------------------------------------------------------------
     44       11       23       20        0  0xffff88b07f3d4180
  -------------------------------------------------------------
           9.09%    0.00%    0.00%    0.00%                 0x8     3       1  0xffffffff8136a457       757         0       402       73        58  [k] propagate_protected_usage  [kernel.kallsyms]  atomic64_64.h:22     0  1  2  3
           0.00%    4.35%    0.00%    0.00%                0x18     3       1  0xffffffff8136a56f         0       199       407       67        55  [k] page_counter_try_charge    [kernel.kallsyms]  page_counter.c:134   0  1  2  3
          63.64%   91.30%    0.00%    0.00%                0x28     3       1  0xffffffff8136a405       527       323       365       81        61  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:23    0  1  2  3
           9.09%    4.35%    0.00%    0.00%                0x28     3       1  0xffffffff8136a57c       375       179       389       65        53  [k] page_counter_try_charge    [kernel.kallsyms]  page_counter.c:100   0  1  2  3
           9.09%    0.00%   45.00%    0.00%                0x30     3       1  0xffffffff8136a588      1097         0       684       46        39  [k] page_counter_try_charge    [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           0.00%    0.00%   55.00%    0.00%                0x30     3       1  0xffffffff8136a48c         0         0       571       25        22  [k] page_counter_cancel        [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           9.09%    0.00%    0.00%    0.00%                0x38     3       1  0xffffffff8136a40c       716         0       481       28        24  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:26    0  1  2  3

  -------------------------------------------------------------
     45       26        7      182       21  0xffffffff83590800
  -------------------------------------------------------------
           0.00%    0.00%    1.10%    0.00%                0x30     3       1  0xffffffff81cfd593         0         0       692        3         2  [k] _raw_spin_lock       [kernel.kallsyms]  atomic.h:202    0  2
         100.00%  100.00%   98.90%  100.00%                0x34     3       1  0xffffffff8107e764       533       180         0      260       128  [k] __native_set_fixmap  [kernel.kallsyms]  pgtable.c:650   0  1  2  3

  -------------------------------------------------------------
     46        0       33        3        0  0xffff88b06cac2c00
  -------------------------------------------------------------
           0.00%   90.91%    0.00%    0.00%                 0x0     3       1  0xffffffff812c9a87         0       234       135      115        41  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:86         3
           0.00%    6.06%    0.00%    0.00%                 0x0     3       1  0xffffffff81632410         0       154       170      182        46  [k] __list_add_valid   [kernel.kallsyms]  list_debug.c:26   3
           0.00%    0.00%  100.00%    0.00%                 0x0     3       1  0xffffffff812c9aa6         0         0         0        3         3  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:73         3
           0.00%    3.03%    0.00%    0.00%                0x10     3       1  0xffffffff812c9a87         0       167       133        2         1  [k] __pagevec_lru_add  [kernel.kallsyms]  list.h:86         3

  -------------------------------------------------------------
     47        0       30       37        0  0xffff8898aa4b4dc0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x10     2       1  0xffffffff812da2fe         0       173         0       30         1  [k] shmem_fault         [kernel.kallsyms]  shmem.c:2066     2
           0.00%    0.00%    2.70%    0.00%                0x20     2       1  0xffffffff812d9b44         0         0         0        1         1  [k] shmem_getpage_gfp   [kernel.kallsyms]  paravirt.h:590   2
           0.00%    0.00%   97.30%    0.00%                0x20     2       1  0xffffffff81cfd114         0         0       345       54         1  [k] _raw_spin_lock_irq  [kernel.kallsyms]  atomic.h:202     2

  -------------------------------------------------------------
     48        0       30      928        4  0xffff88b07ffd0dc0
  -------------------------------------------------------------
           0.00%   96.67%    0.00%    0.00%                0x10     3       1  0xffffffff81320f9d         0       195        76       33        26  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  mmzone.h:104      3
           0.00%    3.33%    0.00%    0.00%                0x10     3       1  0xffffffff813210af         0       189         0        1         1  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:86         3
           0.00%    0.00%    4.85%    0.00%                0x10     3       1  0xffffffff81320fee         0         0         0       45        29  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:113        3
           0.00%    0.00%    0.97%    0.00%                0x10     3       1  0xffffffff813210e2         0         0         0        9         8  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:73         3
           0.00%    0.00%   44.61%   50.00%                0x18     3       1  0xffffffff81320fea         0         0         0      416        48  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:112        3
           0.00%    0.00%   49.57%   50.00%                0x18     3       1  0xffffffff813210d4         0         0         0      462        48  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:70         3

  -------------------------------------------------------------
     49        0       29       19        0  0xffff8898a989b200
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x0     2       1  0xffffffff812da2fe         0       197         0       29         1  [k] shmem_fault                [kernel.kallsyms]  shmem.c:2066   2
           0.00%    0.00%  100.00%    0.00%                0x10     2       1  0xffffffff81cfd114         0         0       165       54         1  [k] _raw_spin_lock_irq         [kernel.kallsyms]  atomic.h:202   2

  -------------------------------------------------------------
     50        6       21       24        0  0xffff88810c93d180
  -------------------------------------------------------------
           0.00%    9.52%    0.00%    0.00%                0x18     0       1  0xffffffff8136a56f         0       161       476       65        55  [k] page_counter_try_charge    [kernel.kallsyms]  page_counter.c:134   0  1  2  3
          83.33%   71.43%    0.00%    0.00%                0x28     0       1  0xffffffff8136a405       572       350       442       79        65  [k] propagate_protected_usage  [kernel.kallsyms]  page_counter.c:23    0  1  2  3
          16.67%   14.29%    0.00%    0.00%                0x28     0       1  0xffffffff8136a57c       617       183       372       71        58  [k] page_counter_try_charge    [kernel.kallsyms]  page_counter.c:100   0  1  2  3
           0.00%    4.76%   70.83%    0.00%                0x30     0       1  0xffffffff8136a588         0       419       614       62        49  [k] page_counter_try_charge    [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3
           0.00%    0.00%   29.17%    0.00%                0x30     0       1  0xffffffff8136a48c         0         0       346       15        15  [k] page_counter_cancel        [kernel.kallsyms]  atomic64_64.h:160    0  1  2  3

  -------------------------------------------------------------
     51        0       27        0        0  0xffff888c9c388ac0
  -------------------------------------------------------------
           0.00%   81.48%    0.00%    0.00%                0x20     1       1  0xffffffff8137074f         0       240        89      515        47  [k] __mod_memcg_lruvec_state  [kernel.kallsyms]  memcontrol.c:823   1
           0.00%   18.52%    0.00%    0.00%                0x20     1       1  0xffffffff812c9d1e         0       188       135       11        11  [k] __pagevec_lru_add         [kernel.kallsyms]  memcontrol.h:683   1

  -------------------------------------------------------------
     52        2       24        6        0  0xffff88987ffff240
  -------------------------------------------------------------
         100.00%  100.00%    0.00%    0.00%                 0x0     1       1  0xffffffff812ded4b       436       203        91      284        48  [k] __mod_node_page_state  [kernel.kallsyms]  vmstat.c:339       1  3
           0.00%    0.00%  100.00%    0.00%                 0x8     1       1  0xffffffff812ded98         0         0       557       15        13  [k] __mod_node_page_state  [kernel.kallsyms]  atomic64_64.h:46   1

  -------------------------------------------------------------
     53       26        0       50        0  0xffff88b071197d00
  -------------------------------------------------------------
         100.00%    0.00%    0.00%    0.00%                0x18     3       1  0xffffffff812da2fe       534         0       578       57         1  [k] shmem_fault                [kernel.kallsyms]  shmem.c:2066     3
           0.00%    0.00%   24.00%    0.00%                0x28     3       1  0xffffffff812d9b44         0         0         0       12         1  [k] shmem_getpage_gfp          [kernel.kallsyms]  paravirt.h:590   2
           0.00%    0.00%   76.00%    0.00%                0x28     3       1  0xffffffff81cfd114         0         0       551       67         1  [k] _raw_spin_lock_irq         [kernel.kallsyms]  atomic.h:202     2

  -------------------------------------------------------------
     54        0       24        0        0  0xffff8881c0642d80
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x38     0       1  0xffffffff8137389a         0       205       203       96        79  [k] get_obj_cgroup_from_curren  [kernel.kallsyms]  memcontrol.c:2975   0  1  2  3

  -------------------------------------------------------------
     55        0       23      941        3  0xffff88a47ffd5dc0
  -------------------------------------------------------------
           0.00%   95.65%    0.00%    0.00%                0x10     2       1  0xffffffff81320f9d         0       187        83       31        20  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  mmzone.h:104      2
           0.00%    4.35%    0.00%    0.00%                0x10     2       1  0xffffffff813210af         0       143        43        2         2  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:86         2
           0.00%    0.00%    0.43%    0.00%                0x10     2       1  0xffffffff8131fad3         0         0         0        4         1  [k] free_pcppages_bulk        [kernel.kallsyms]  list.h:113        3
           0.00%    0.00%    2.98%    0.00%                0x10     2       1  0xffffffff81320fee         0         0         0       28        22  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:113        2
           0.00%    0.00%    1.28%    0.00%                0x10     2       1  0xffffffff813210e2         0         0         0       12        10  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:73         2
           0.00%    0.00%    0.11%    0.00%                0x18     2       1  0xffffffff8131facf         0         0         0        1         1  [k] free_pcppages_bulk        [kernel.kallsyms]  list.h:112        3
           0.00%    0.00%    0.11%    0.00%                0x18     2       1  0xffffffff8131fc44         0         0         0        1         1  [k] free_pcppages_bulk        [kernel.kallsyms]  list.h:70         3
           0.00%    0.00%   45.48%    0.00%                0x18     2       1  0xffffffff81320fea         0         0         0      428        48  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:112        2
           0.00%    0.00%   49.63%  100.00%                0x18     2       1  0xffffffff813210d4         0         0         0      470        48  [k] rmqueue_bulk.constprop.0  [kernel.kallsyms]  list.h:70         2

  -------------------------------------------------------------
     56        0       23       14        0  0xffff88a47ffff240
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x0     2       1  0xffffffff812ded4b         0       196        91      330        46  [k] __mod_node_page_state  [kernel.kallsyms]  vmstat.c:339       2
           0.00%    0.00%  100.00%    0.00%                 0x8     2       1  0xffffffff812ded98         0         0       702       29        22  [k] __mod_node_page_state  [kernel.kallsyms]  atomic64_64.h:46   2

  -------------------------------------------------------------
     57        2       20       14        0  0xffff888c7ffff240
  -------------------------------------------------------------
          50.00%  100.00%    0.00%    0.00%                 0x0     0       1  0xffffffff812ded4b       408       232       101      348        48  [k] __mod_node_page_state  [kernel.kallsyms]  vmstat.c:339       0  3
          50.00%    0.00%    0.00%    0.00%                 0x0     0       1  0xffffffff812de98d       397         0         0        2         1  [k] mod_node_page_state    [kernel.kallsyms]  vmstat.c:555       3
           0.00%    0.00%  100.00%    0.00%                 0x8     0       1  0xffffffff812ded98         0         0       839       28        22  [k] __mod_node_page_state  [kernel.kallsyms]  atomic64_64.h:46   0

--dDRMvlgZJXvWKvBx--
