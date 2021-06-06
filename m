Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3B39CE8E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 12:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFFKSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 06:18:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:54243 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFKSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 06:18:20 -0400
IronPort-SDR: 16Pqi9wNIe+SG0uQxZaVhB3weMgY4vaRLNlAOKdxzd5M2IL7CU8M+LUHfsgVCbk7OyGjcppgME
 0mrOmtpMn7Og==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="225827009"
X-IronPort-AV: E=Sophos;i="5.83,253,1616482800"; 
   d="log'?scan'208";a="225827009"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 03:16:30 -0700
IronPort-SDR: ZyQFvQogiO3vmzWoEdi1zmqF+tcnncsbsITqZBn21UoEM8SsMo44Tgv5CNOlTakUz/4PpE7E2W
 suf6XBqQIyyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,253,1616482800"; 
   d="log'?scan'208";a="484446194"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2021 03:16:24 -0700
Date:   Sun, 6 Jun 2021 18:16:23 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2%
 regression
Message-ID: <20210606101623.GA48020@shbuild999.sh.intel.com>
References: <20210525031636.GB7744@xsang-OptiPlex-9020>
 <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
 <20210604070411.GA8221@shbuild999.sh.intel.com>
 <20210604075220.GA40621@shbuild999.sh.intel.com>
 <CAHk-=wg=LX1WKioiA_Cn-5hp6Hce_kTZg23uksSjNWgV_Ofj1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg=LX1WKioiA_Cn-5hp6Hce_kTZg23uksSjNWgV_Ofj1Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 04, 2021 at 10:57:44AM -0700, Linus Torvalds wrote:
> On Fri, Jun 4, 2021 at 12:52 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > On Fri, Jun 04, 2021 at 03:04:11PM +0800, Feng Tang wrote:
> > > >
> > > > The perf data doesn't even mention any of the GUP paths, and on the
> > > > pure fork path the biggest impact would be:
> > > >
> > > >  (a) maybe "struct mm_struct" changed in size or had a different cache layout
> > >
> > > Yes, this seems to be the cause of the regression.
> > >
> > > The test case is many thread are doing map/unmap at the same time,
> > > so the process's rw_semaphore 'mmap_lock' is highly contended.
> > >
> > > Before the patch (with 0day's kconfig), the mmap_lock is separated
> > > into 2 cachelines, the 'count' is in one line, and the other members
> > > sit in the next line, so it luckily avoid some cache bouncing. After
> > > the patch, the 'mmap_lock' is pushed into one cacheline, which may
> > > cause the regression.
> 
> Ok, thanks for following up on this.
> 
> > We've tried some patch, which can restore the regerssion. As the
> > newly added member 'write_protect_seq' is 4 bytes long, and putting
> > it into an existing 4 bytes long hole can restore the regeression,
> > while not affecting most of other member's alignment. Please review
> > the following patch, thanks!
> 
> The patch looks fine to me.
> 
> At the same time, I do wonder if maybe it would be worth exploring if
> it's a good idea to perhaps move the 'mmap_sem' thing instead.
> 
> Or at least add a big comment. It's not clear to me exactly _which_
> other fields are the ones that are so hot that the contention on
> mmap_sem then causes even more cacheline bouncing.
>
> For example, is it either
> 
>  (a) we *want* the mmap_sem to be in the first 128-byte region,
> because then when we get the mmap_sem, the other fields in that same
> cacheline are hot
> 
> OR
> 
>  (b) we do *not* want mmap_sem to be in the *second* 128-byte region,
> because there is something *else* in that region that is touched
> independently of mmap_sem that is very very hot and now you get even
> more bouncing?
> 
> but I can't tell which one it is.

Yes, it's better to get more details of which fields are hottest, 
and following are some perf data details. Let me know if more info
is needed.

* perf-stat: we see more cache-misses

  32158577 ±  7%      +9.0%   35060321 ±  6%  perf-stat.ps.cache-misses
  69612918 ±  6%     +11.2%   77382336 ±  5%  perf-stat.ps.cache-references


* perf profile: the 'mmap_lock' are the hottest, though the ratio from
  map/unmap has some difference from 72:24 to 52:45, and this is the part
  that I don't understand
  
  - old kernel (without commit 57efa1fe59)

    96.60%     0.19%  [kernel.kallsyms]   [k] down_write_killable                           -      -            
72.46% down_write_killable;vm_mmap_pgoff;ksys_mmap_pgoff;do_syscall_64;entry_SYSCALL_64_after_hwframe;__mmap
24.14% down_write_killable;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;__munmap

  - new kernel 

    96.60%     0.16%  [kernel.kallsyms]    [k] down_write_killable                           -      -            
51.85% down_write_killable;vm_mmap_pgoff;ksys_mmap_pgoff;do_syscall_64;entry_SYSCALL_64_after_hwframe;__mmap
44.74% down_write_killable;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;__munmap


* perf-c2c: The hotspots(HITM) for 2 kernels are different due to the
  data structure change

  - old kernel

    - first cacheline
	mmap_lock->count (75%)
	mm->mapcount (14%)

    - second cacheline
	mmap_lock->owner (97%)

  - new kernel

    mainly in the cacheline of 'mmap_lock'     

    mmap_lock->count (~2%)
    mmap_lock->owner (95%)
    
I also attached the reduced pah and perf-c2c log for further
check. (The absolute HITM events number can be ignored, as the
recording time for new/old kernel may be different)


> It would be great to have a comment in the code - and in the commit
> message - about exactly which fields are the criticial ones. Because I
> doubt it is 'write_protect_seq' itself that matters at all.
> 
> If it's "mmap_sem should be close to other commonly used fields",
> maybe we should just move mmap_sem upwards in the structure?

Ok, will add more comments if the patch is still fine with
the above updated info.

Thanks,
Feng

>               Linus

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pah_new.log"


struct rw_semaphore {
	atomic_long_t              count;                /*     0     0 */

	/* XXX 8 bytes hole, try to pack */

	atomic_long_t              owner;                /*     8     0 */

	/* XXX 8 bytes hole, try to pack */

	struct optimistic_spin_queue osq;                /*    16     0 */

	/* XXX 4 bytes hole, try to pack */

	raw_spinlock_t             wait_lock;            /*    20     0 */

	/* XXX 4 bytes hole, try to pack */

	struct list_head           wait_list;            /*    24     0 */

	/* size: 40, cachelines: 1, members: 5 */
	/* padding: 16 */
	/* last cacheline: 40 bytes */
};

struct mm_struct {
	struct {
		struct vm_area_struct * mmap;            /*     0     8 */
		struct rb_root     mm_rb;                /*     8     8 */
		u64                vmacache_seqnum;      /*    16     8 */
		long unsigned int  (*get_unmapped_area)(struct file *, long unsigned int, long unsigned int, long unsigned int, long unsigned int); /*    24     8 */
		long unsigned int  mmap_base;            /*    32     8 */
		long unsigned int  mmap_legacy_base;     /*    40     8 */
		long unsigned int  mmap_compat_base;     /*    48     8 */
		long unsigned int  mmap_compat_legacy_base; /*    56     8 */
		/* --- cacheline 1 boundary (64 bytes) --- */
		long unsigned int  task_size;            /*    64     8 */
		long unsigned int  highest_vm_end;       /*    72     8 */
		pgd_t *            pgd;                  /*    80     8 */
		atomic_t           membarrier_state;     /*    88     4 */
		atomic_t           mm_users;             /*    92     4 */
		atomic_t           mm_count;             /*    96     4 */
		atomic_t           has_pinned;           /*   100     4 */
		seqcount_t         write_protect_seq;    /*   104     4 */

		/* XXX 4 bytes hole, try to pack */

		atomic_long_t      pgtables_bytes;       /*   112     8 */
		int                map_count;            /*   120     4 */
		spinlock_t         page_table_lock;      /*   124     4 */
		/* --- cacheline 2 boundary (128 bytes) --- */
		struct rw_semaphore mmap_lock;           /*   128    40 */
		struct list_head   mmlist;               /*   168    16 */
		long unsigned int  hiwater_rss;          /*   184     8 */
		/* --- cacheline 3 boundary (192 bytes) --- */
		long unsigned int  hiwater_vm;           /*   192     8 */
		long unsigned int  total_vm;             /*   200     8 */
		long unsigned int  locked_vm;            /*   208     8 */
		atomic64_t         pinned_vm;            /*   216     8 */
		long unsigned int  data_vm;              /*   224     8 */
		long unsigned int  exec_vm;              /*   232     8 */
		long unsigned int  stack_vm;             /*   240     8 */
		long unsigned int  def_flags;            /*   248     8 */
		/* --- cacheline 4 boundary (256 bytes) --- */
		spinlock_t         arg_lock;             /*   256     4 */

		/* XXX 4 bytes hole, try to pack */

		long unsigned int  start_code;           /*   264     8 */
		long unsigned int  end_code;             /*   272     8 */
		long unsigned int  start_data;           /*   280     8 */
		long unsigned int  end_data;             /*   288     8 */
		long unsigned int  start_brk;            /*   296     8 */
		long unsigned int  brk;                  /*   304     8 */
		long unsigned int  start_stack;          /*   312     8 */
		/* --- cacheline 5 boundary (320 bytes) --- */
		long unsigned int  arg_start;            /*   320     8 */
		long unsigned int  arg_end;              /*   328     8 */
		long unsigned int  env_start;            /*   336     8 */
		long unsigned int  env_end;              /*   344     8 */
		long unsigned int  saved_auxv[46];       /*   352   368 */
		/* --- cacheline 11 boundary (704 bytes) was 16 bytes ago --- */
		struct mm_rss_stat rss_stat;             /*   720    32 */
		struct linux_binfmt * binfmt;            /*   752     8 */
		mm_context_t       context;              /*   760   128 */
		/* --- cacheline 13 boundary (832 bytes) was 56 bytes ago --- */
		long unsigned int  flags;                /*   888     8 */
		/* --- cacheline 14 boundary (896 bytes) --- */
		struct core_state * core_state;          /*   896     8 */
		spinlock_t         ioctx_lock;           /*   904     4 */

		/* XXX 4 bytes hole, try to pack */

		struct kioctx_table * ioctx_table;       /*   912     8 */
		struct task_struct * owner;              /*   920     8 */
		struct user_namespace * user_ns;         /*   928     8 */
		struct file *      exe_file;             /*   936     8 */
		struct mmu_notifier_subscriptions * notifier_subscriptions; /*   944     8 */
		long unsigned int  numa_next_scan;       /*   952     8 */
		/* --- cacheline 15 boundary (960 bytes) --- */
		long unsigned int  numa_scan_offset;     /*   960     8 */
		int                numa_scan_seq;        /*   968     4 */
		atomic_t           tlb_flush_pending;    /*   972     4 */
		bool               tlb_flush_batched;    /*   976     1 */

		/* XXX 7 bytes hole, try to pack */

		struct uprobes_state uprobes_state;      /*   984     8 */
		atomic_long_t      hugetlb_usage;        /*   992     8 */
		struct work_struct async_put_work;       /*  1000    32 */
		/* --- cacheline 16 boundary (1024 bytes) was 8 bytes ago --- */
		u32                pasid;                /*  1032     4 */
	};                                               /*     0  1040 */

	/* XXX last struct has 4 bytes of padding */

	long unsigned int          cpu_bitmap[];         /*  1040     0 */

	/* size: 1040, cachelines: 17, members: 2 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 16 bytes */
};

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pah_old.log"


struct rw_semaphore {
	atomic_long_t              count;                /*     0     0 */

	/* XXX 8 bytes hole, try to pack */

	atomic_long_t              owner;                /*     8     0 */

	/* XXX 8 bytes hole, try to pack */

	struct optimistic_spin_queue osq;                /*    16     0 */

	/* XXX 4 bytes hole, try to pack */

	raw_spinlock_t             wait_lock;            /*    20     0 */

	/* XXX 4 bytes hole, try to pack */

	struct list_head           wait_list;            /*    24     0 */

	/* size: 40, cachelines: 1, members: 5 */
	/* padding: 16 */
	/* last cacheline: 40 bytes */
};

struct mm_struct {
	struct {
		struct vm_area_struct * mmap;            /*     0     8 */
		struct rb_root     mm_rb;                /*     8     8 */
		u64                vmacache_seqnum;      /*    16     8 */
		long unsigned int  (*get_unmapped_area)(struct file *, long unsigned int, long unsigned int, long unsigned int, long unsigned int); /*    24     8 */
		long unsigned int  mmap_base;            /*    32     8 */
		long unsigned int  mmap_legacy_base;     /*    40     8 */
		long unsigned int  mmap_compat_base;     /*    48     8 */
		long unsigned int  mmap_compat_legacy_base; /*    56     8 */
		/* --- cacheline 1 boundary (64 bytes) --- */
		long unsigned int  task_size;            /*    64     8 */
		long unsigned int  highest_vm_end;       /*    72     8 */
		pgd_t *            pgd;                  /*    80     8 */
		atomic_t           membarrier_state;     /*    88     4 */
		atomic_t           mm_users;             /*    92     4 */
		atomic_t           mm_count;             /*    96     4 */
		atomic_t           has_pinned;           /*   100     4 */
		atomic_long_t      pgtables_bytes;       /*   104     8 */
		int                map_count;            /*   112     4 */
		spinlock_t         page_table_lock;      /*   116     4 */
		struct rw_semaphore mmap_lock;           /*   120    40 */
		/* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
		struct list_head   mmlist;               /*   160    16 */
		long unsigned int  hiwater_rss;          /*   176     8 */
		long unsigned int  hiwater_vm;           /*   184     8 */
		/* --- cacheline 3 boundary (192 bytes) --- */
		long unsigned int  total_vm;             /*   192     8 */
		long unsigned int  locked_vm;            /*   200     8 */
		atomic64_t         pinned_vm;            /*   208     8 */
		long unsigned int  data_vm;              /*   216     8 */
		long unsigned int  exec_vm;              /*   224     8 */
		long unsigned int  stack_vm;             /*   232     8 */
		long unsigned int  def_flags;            /*   240     8 */
		spinlock_t         arg_lock;             /*   248     4 */

		/* XXX 4 bytes hole, try to pack */

		/* --- cacheline 4 boundary (256 bytes) --- */
		long unsigned int  start_code;           /*   256     8 */
		long unsigned int  end_code;             /*   264     8 */
		long unsigned int  start_data;           /*   272     8 */
		long unsigned int  end_data;             /*   280     8 */
		long unsigned int  start_brk;            /*   288     8 */
		long unsigned int  brk;                  /*   296     8 */
		long unsigned int  start_stack;          /*   304     8 */
		long unsigned int  arg_start;            /*   312     8 */
		/* --- cacheline 5 boundary (320 bytes) --- */
		long unsigned int  arg_end;              /*   320     8 */
		long unsigned int  env_start;            /*   328     8 */
		long unsigned int  env_end;              /*   336     8 */
		long unsigned int  saved_auxv[46];       /*   344   368 */
		/* --- cacheline 11 boundary (704 bytes) was 8 bytes ago --- */
		struct mm_rss_stat rss_stat;             /*   712    32 */
		struct linux_binfmt * binfmt;            /*   744     8 */
		mm_context_t       context;              /*   752   128 */
		/* --- cacheline 13 boundary (832 bytes) was 48 bytes ago --- */
		long unsigned int  flags;                /*   880     8 */
		struct core_state * core_state;          /*   888     8 */
		/* --- cacheline 14 boundary (896 bytes) --- */
		spinlock_t         ioctx_lock;           /*   896     4 */

		/* XXX 4 bytes hole, try to pack */

		struct kioctx_table * ioctx_table;       /*   904     8 */
		struct task_struct * owner;              /*   912     8 */
		struct user_namespace * user_ns;         /*   920     8 */
		struct file *      exe_file;             /*   928     8 */
		struct mmu_notifier_subscriptions * notifier_subscriptions; /*   936     8 */
		long unsigned int  numa_next_scan;       /*   944     8 */
		long unsigned int  numa_scan_offset;     /*   952     8 */
		/* --- cacheline 15 boundary (960 bytes) --- */
		int                numa_scan_seq;        /*   960     4 */
		atomic_t           tlb_flush_pending;    /*   964     4 */
		bool               tlb_flush_batched;    /*   968     1 */

		/* XXX 7 bytes hole, try to pack */

		struct uprobes_state uprobes_state;      /*   976     8 */
		atomic_long_t      hugetlb_usage;        /*   984     8 */
		struct work_struct async_put_work;       /*   992    32 */
		/* --- cacheline 16 boundary (1024 bytes) --- */
		u32                pasid;                /*  1024     4 */
	};                                               /*     0  1032 */

	/* XXX last struct has 4 bytes of padding */

	long unsigned int          cpu_bitmap[];         /*  1032     0 */

	/* size: 1032, cachelines: 17, members: 2 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 8 bytes */
};

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="c2c_new.log"

=================================================
            Trace Event Information              
=================================================
  Total records                     :     293248
  Locked Load/Store Operations      :       6171
  Load Operations                   :      52087
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :          0
  Loads - no mapping                :        467
  Load Fill Buffer Hit              :      14960
  Load L1D hit                      :      17949
  Load L2D hit                      :        377
  Load LLC hit                      :      11861
  Load Local HITM                   :       5926
  Load Remote HITM                  :       4183
  Load Remote HIT                   :          0
  Load Local DRAM                   :        580
  Load Remote DRAM                  :       5893
  Load MESI State Exclusive         :       5893
  Load MESI State Shared            :        580
  Load LLC Misses                   :      10656
  Load access blocked by data       :          0
  Load access blocked by address    :          0
  LLC Misses to Local DRAM          :        5.4%
  LLC Misses to Remote DRAM         :       55.3%
  LLC Misses to Remote cache (HIT)  :        0.0%
  LLC Misses to Remote cache (HITM) :       39.3%
  Store Operations                  :          0
  Store - uncacheable               :          0
  Store - no mapping                :          0
  Store L1D Hit                     :          0
  Store L1D Miss                    :          0
  No Page Map Rejects               :      50306
  Unable to parse data source       :     241161

=================================================
    Global Shared Cache Line Event Information   
=================================================
  Total Shared Cache Lines          :       1441
  Load HITs on shared lines         :      32608
  Fill Buffer Hits on shared lines  :      10597
  L1D hits on shared lines          :       4777
  L2D hits on shared lines          :         22
  LLC hits on shared lines          :      11030
  Locked Access on shared lines     :       4481
  Blocked Access on shared lines    :          0
  Store HITs on shared lines        :          0
  Store L1D hits on shared lines    :          0
  Total Merged records              :      10109

=================================================
                 c2c details                     
=================================================
  Events                            : cpu/mem-loads,ldlat=30/P
                                    : cpu/mem-stores/P
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
      0  0xff110002a24ffc00     0   10811   28.14%     2845     1535     1310    10447    10447        0        0        0     2307     2819        0       412     1535         0     1310       292      1772
      1  0xff110002a24ffb80     0     423    2.41%      244      136      108      722      722        0        0        0      328        3        0        38      136         0      108         0       109
      2  0xff1100209ae58b00     1    1125    2.36%      239      128      111     1268     1268        0        0        0      754       94        0        67      128         0      111         0       114
      3  0xff1100209ae58580     1    1227    2.20%      222       99      123     1029     1029        0        0        0      582       46        0        55       99         0      123         0       124
      4  0xff110002a24ffc40     0    1386    1.69%      171      169        2     1205     1205        0        0        0      714        0        0       195      169         0        2         3       122
      5  0xff11001fffeaba00     0     161    0.84%       85       44       41      237      237        0        0        0       46       19        0        42       44         0       41         2        43
      6  0xff11001ffff2ba00     0     169    0.78%       79       32       47      252      252        0        0        0       48       26        0        37       32         0       47         8        54
      7  0xff11003fdcc6ba00     1     116    0.78%       79       39       40      205      205        0        0        0       30       15        0        31       39         0       40         2        48
      8  0xff110002a24ffbc0     0      64    0.77%       78       36       42      393      393        0        0        0      132      119        2        20       36         0       42         0        42
      9  0xff11003fdc6eba00     1     144    0.76%       77       48       29      195      195        0        0        0       31       19        0        29       48         0       29         4        35
     10  0xff11001fffe2ba00     0     156    0.74%       75       36       39      226      226        0        0        0       50       24        0        31       36         0       39         3        43
     11  0xff11003fdc7aba00     1     137    0.74%       75       38       37      204      204        0        0        0       30       20        0        34       38         0       37         3        42
     12  0xff11001fffc2ba00     0     128    0.73%       74       44       30      182      182        0        0        0       31       16        0        23       44         0       30         1        37
     13  0xff110020001aba00     0     135    0.72%       73       41       32      198      198        0        0        0       28       20        0        33       41         0       32         4        40
     14  0xff1100200012ba00     0     151    0.71%       72       36       36      221      221        0        0        0       35       21        0        45       36         0       36         6        42
     15  0xff1100200002ba00     0     122    0.69%       70       41       29      184      184        0        0        0       31       16        0        32       41         0       29         3        32
     16  0xff11003fdc92ba00     1     142    0.69%       70       32       38      204      204        0        0        0       40       17        0        29       32         0       38         3        45
     17  0xff11003fdc96ba00     1     138    0.69%       70       37       33      207      207        0        0        0       33       18        0        43       37         0       33         4        39
     18  0xff11003fdcd2ba00     1     109    0.69%       70       31       39      184      184        0        0        0       28       18        0        22       31         0       39         0        46
     19  0xff11001ffff6ba00     0     141    0.68%       69       43       26      193      193        0        0        0       38       23        0        29       43         0       26         4        30
     20  0xff11001ffffaba00     0     142    0.68%       69       36       33      204      204        0        0        0       35       23        0        38       36         0       33         2        37
     21  0xff11001fffe6ba00     0     133    0.67%       68       42       26      195      195        0        0        0       39       18        0        38       42         0       26         2        30
     22  0xff1100200016ba00     0     117    0.65%       66       42       24      185      185        0        0        0       37       10        0        40       42         0       24         5        27
     23  0xff1100209ae58b40     1       1    0.65%       66       66        0      210      210        0        0        0        1        0        0        40       66         0        0        18        85
     24  0xff11003fdc8aba00     1     126    0.65%       66       32       34      192      192        0        0        0       37       17        0        30       32         0       34         3        39
     25  0xff11001fffceba00     0     160    0.64%       65       30       35      222      222        0        0        0       40       26        0        48       30         0       35         3        40
     26  0xff11003fdcdeba00     1     121    0.64%       65       37       28      182      182        0        0        0       34       11        0        34       37         0       28         3        35
     27  0xff11001fffdaba00     0      92    0.63%       64       38       26      170      170        0        0        0       29       11        0        30       38         0       26         4        32
     28  0xff110020000aba00     0     159    0.63%       64       37       27      189      189        0        0        0       43       17        0        30       37         0       27         2        33
     29  0xff11003fdc82ba00     1     137    0.62%       63       30       33      200      200        0        0        0       43       20        0        33       30         0       33         5        36
     30  0xff1100200006ba00     0     127    0.61%       62       34       28      184      184        0        0        0       33       20        0        34       34         0       28         3        32
     31  0xff11003fdcbaba00     1     139    0.61%       62       35       27      180      180        0        0        0       39       19        0        26       35         0       27         3        31
     32  0xff11001fffc6ba00     0     130    0.60%       61       37       24      185      185        0        0        0       41       23        0        30       37         0       24         3        27
     33  0xff11001fffd2ba00     0     106    0.60%       61       29       32      167      167        0        0        0       26       17        0        26       29         0       32         1        36
     34  0xff11001fffd6ba00     0      85    0.60%       61       31       30      166      166        0        0        0       29        7        0        33       31         0       30         1        35
     35  0xff11001fffbeba00     0     118    0.59%       60       44       16      161      161        0        0        0       38       13        0        28       44         0       16         6        16
     36  0xff11001ffffeba00     0     144    0.59%       60       41       19      194      194        0        0        0       35       23        0        46       41         0       19         4        26
     37  0xff110020000eba00     0     133    0.59%       60       36       24      180      180        0        0        0       34       18        0        32       36         0       24         5        31
     38  0xff11003fdcc2ba00     1     121    0.59%       60       29       31      188      188        0        0        0       37       13        0        37       29         0       31         6        35
     39  0xff11003fdcbeba00     1     119    0.58%       59       32       27      171      171        0        0        0       30       15        0        33       32         0       27         3        31
     40  0xff11003fdcd6ba00     1     116    0.58%       59       29       30      174      174        0        0        0       20       22        0        39       29         0       30         1        33
     41  0xff11003fdceeba00     1      79    0.58%       59       35       24      151      151        0        0        0       28        4        0        28       35         0       24         0        32
     42  0xff11003fdcfaba00     1     105    0.58%       59       34       25      155      155        0        0        0       26       13        0        29       34         0       25         0        28
     43  0xff11001fffeeba00     0     113    0.57%       58       31       27      172      172        0        0        0       32       16        0        37       31         0       27         1        28
     44  0xff11003fdcb6ba00     1     128    0.56%       57       32       25      177      177        0        0        0       43       14        0        32       32         0       25         2        29
     45  0xff11003fdcfeba00     1      88    0.56%       57       33       24      144      144        0        0        0       29        8        0        16       33         0       24         4        30
     46  0xff11003fdc42ba00     1      86    0.55%       56       28       28      159      159        0        0        0       34       12        0        23       28         0       28         3        31
     47  0xff11003fdcaeba00     1     107    0.54%       55       22       33      154      154        0        0        0       24       11        0        24       22         0       33         1        39
     48  0xff11001fffcaba00     0     111    0.53%       54       32       22      156      156        0        0        0       35       11        0        28       32         0       22         1        27
     49  0xff11003fdcaaba00     1      87    0.52%       53       29       24      141      141        0        0        0       21        9        0        26       29         0       24         3        29
     50  0xff11003fdc86ba00     1      89    0.49%       50       30       20      147      147        0        0        0       27       11        0        31       30         0       20         2        26
     51  0xff11001fffdeba00     0      96    0.47%       48       26       22      144      144        0        0        0       25       10        0        28       26         0       22         7        26
     52  0xff11003fdc46ba00     1      98    0.47%       48       30       18      127      127        0        0        0       21        8        0        27       30         0       18         1        22
     53  0xff11003fdc6aba00     1      80    0.41%       41       20       21      121      121        0        0        0       24        8        0        22       20         0       21         1        25
     54  0xff11003fdcb2ba00     1      92    0.40%       40       20       20      137      137        0        0        0       29       12        0        27       20         0       20         2        27
     55  0xff110020d9ecc000     1      37    0.31%       31       15       16       68       68        0        0        0        9        2        0         8       15         0       16         0        18
     56  0xff1100406e91c000     1      57    0.27%       27       16       11       80       80        0        0        0       17        4        0        21       16         0       11         0        11
     57  0xff1100406f884000     1      59    0.27%       27       12       15       76       76        0        0        0       17        4        0        13       12         0       15         0        15
     58  0xff110001e3bd9bc0     0     125    0.26%       26       10       16      269      269        0        0        0       19        1        0       207       10         0       16         0        16
     59  0xff110001085fd700     0     196    0.25%       25       15       10      316      316        0        0        0        7       39        0       235       15         0       10         0        10
     60  0xff11000154dd8000     0      58    0.25%       25       12       13       87       87        0        0        0       24        5        0        20       12         0       13         0        13
     61  0xff1100406a59c000     1      60    0.25%       25       11       14       81       81        0        0        0       21        4        0        17       11         0       14         0        14
     62  0xff1100406d9f0000     1      40    0.25%       25       16        9       58       58        0        0        0        8        4        0        11       16         0        9         0        10
     63  0xff11000156a24000     0      51    0.24%       24       10       14       71       71        0        0        0       18        3        0        12       10         0       14         0        14
     64  0xff110001b4044000     0      66    0.24%       24       17        7       78       78        0        0        0       27        2        0        17       17         0        7         0         8
     65  0xff11000212360000     0      69    0.24%       24        9       15      104      104        0        0        0       40        4        0        21        9         0       15         0        15
     66  0xff1100209d074000     1      56    0.23%       23       11       12       67       67        0        0        0       19        5        0         7       11         0       12         0        13
     67  0xff11004070a10000     1      47    0.23%       23       11       12       74       74        0        0        0       21        1        0        17       11         0       12         0        12
     68  0xff11000109248000     0      50    0.22%       22       13        9       77       77        0        0        0       20        2        0        24       13         0        9         0         9
     69  0xff1100012d114000     0      57    0.22%       22       16        6       76       76        0        0        0       30        3        0        15       16         0        6         0         6
     70  0xff110020d9614000     1      31    0.22%       22       16        6       55       55        0        0        0       13        0        0        14       16         0        6         0         6
     71  0xff1100406a600000     1      55    0.22%       22       10       12       75       75        0        0        0       24        4        0        11       10         0       12         0        14
     72  0xffffffff835477c0     1       1    0.21%       21        9       12       33       33        0        0        0        0        0        0         0        9         0       12         0        12
     73  0xff11000270708000     0      48    0.21%       21        9       12       64       64        0        0        0       15        6        0         9        9         0       12         0        13
     74  0xff11000117070000     0      66    0.20%       20        8       12       95       95        0        0        0       39        5        0        19        8         0       12         0        12
     75  0xff1100012dd18000     0      57    0.20%       20       12        8       75       75        0        0        0       22        4        0        21       12         0        8         0         8
     76  0xff11000242dbc000     0      64    0.20%       20       12        8       86       86        0        0        0       31        2        0        23       12         0        8         0        10
     77  0xff1100027104c000     0      58    0.20%       20        9       11       82       82        0        0        0       24        4        0        21        9         0       11         0        13
     78  0xff1100406bca4000     1      43    0.20%       20        5       15       56       56        0        0        0        8        2        0        11        5         0       15         0        15
     79  0xff110001091c4000     0      60    0.19%       19       12        7       77       77        0        0        0       17        4        0        29       12         0        7         0         8
     80  0xff1100012bab8000     0      69    0.19%       19        7       12       95       95        0        0        0       33        9        0        22        7         0       12         0        12
     81  0xff11000155a60000     0      58    0.19%       19        6       13       84       84        0        0        0       27        6        0        19        6         0       13         0        13
     82  0xff110001b4244000     0      49    0.19%       19       13        6       66       66        0        0        0       23        7        0        11       13         0        6         0         6
     83  0xff110001e207c000     0      56    0.19%       19       14        5       68       68        0        0        0       22        3        0        19       14         0        5         0         5
     84  0xff110002a24fff00     0       1    0.19%       19       19        0      197      197        0        0        0        8        0        0       160       19         0        0         0        10
     85  0xff110020b736c000     1      56    0.19%       19       13        6       70       70        0        0        0       26        4        0        15       13         0        6         0         6
     86  0xff110020ba320000     1      60    0.19%       19       11        8       68       68        0        0        0       18        3        0        20       11         0        8         0         8
     87  0xff110040755c4000     1      58    0.19%       19       12        7       73       73        0        0        0       20       10        0        16       12         0        7         0         8
     88  0xff110001092a0000     0      37    0.18%       18       12        6       56       56        0        0        0       16        0        0        15       12         0        6         0         7
     89  0xff1100015696c000     0      58    0.18%       18       10        8       77       77        0        0        0       29        3        0        19       10         0        8         0         8
     90  0xff110001866f8000     0      57    0.18%       18        7       11       84       84        0        0        0       35        4        0        16        7         0       11         0        11
     91  0xff11004072f84000     1      40    0.18%       18       12        6       56       56        0        0        0       15        4        0        13       12         0        6         0         6
     92  0xff110001163d8000     0      46    0.17%       17        4       13       63       63        0        0        0       18        1        0        13        4         0       13         0        14
     93  0xff1100406bca4040     1       1    0.17%       17       17        0       34       34        0        0        0        1        0        0         5       17         0        0         0        11
     94  0xff11004070424000     1      41    0.17%       17        8        9       64       64        0        0        0       20        5        0        13        8         0        9         0         9
     95  0xff11004079f7c000     1      52    0.17%       17       11        6       52       52        0        0        0        8        4        0        17       11         0        6         0         6
     96  0xff11000117b9c000     0      55    0.16%       16        5       11       76       76        0        0        0       26        7        0        16        5         0       11         0        11
     97  0xff110002408b8000     0      78    0.16%       16        6       10       86       86        0        0        0       38        9        0        13        6         0       10         0        10
     98  0xff110002a1a88000     0      48    0.16%       16        7        9       64       64        0        0        0       15        5        0        19        7         0        9         0         9
     99  0xff11004072594000     1      53    0.16%       16        8        8       58       58        0        0        0       17        4        0        12        8         0        8         0         9
    100  0xff11004073a30000     1      46    0.16%       16        9        7       61       61        0        0        0       21        4        0        12        9         0        7         0         8
    101  0xff11000117b9c040     0       1    0.15%       15       15        0       31       31        0        0        0        0        0        0         6       15         0        0         0        10
    102  0xff1100012f064000     0      63    0.15%       15       10        5       90       90        0        0        0       49        7        0        13       10         0        5         0         6
    103  0xff110020b736c040     1       1    0.15%       15       15        0       27       27        0        0        0        0        0        0         1       15         0        0         0        11
    104  0xff1100406f161bc0     1      32    0.15%       15       11        4      131      131        0        0        0       10        0        1       101       11         0        4         0         4
    105  0xff11000156a24040     0       3    0.14%       14       13        1       28       28        0        0        0        1        0        0         2       13         0        1         0        11
    106  0xff11000300658000     0      55    0.14%       14        9        5       65       65        0        0        0       24        3        0        19        9         0        5         0         5
    107  0xff1100406b92c040     1       1    0.14%       14       14        0       31       31        0        0        0        0        0        0         7       14         0        0         0        10
    108  0xff1100406d770000     1      36    0.14%       14        5        9       43       43        0        0        0        7        1        0        12        5         0        9         0         9
    109  0xff110001092a0040     0       1    0.13%       13       13        0       31       31        0        0        0        0        0        0         8       13         0        0         0        10
    110  0xff110020d7e88000     1      48    0.13%       13        9        4       44       44        0        0        0        9        3        0        15        9         0        4         0         4
    111  0xff1100406b92c000     1      40    0.13%       13        8        5       42       42        0        0        0       12        3        0         7        8         0        5         0         7
    112  0xff1100407419c000     1      48    0.13%       13       11        2       60       60        0        0        0       24        7        0        13       11         0        2         0         3
    113  0xff110001091c4040     0       1    0.12%       12       12        0       25       25        0        0        0        0        0        0         4       12         0        0         0         9
    114  0xff11000300658040     0       1    0.12%       12       12        0       22       22        0        0        0        0        0        0         4       12         0        0         0         6
    115  0xff110020ba320040     1       1    0.12%       12       12        0       33       33        0        0        0        2        0        0         3       12         0        0         0        16
    116  0xff11004070424040     1       5    0.12%       12       12        0       32       32        0        0        0        0        1        0         3       12         0        0         0        16
    117  0xff1100407bca8000     1      41    0.12%       12        8        4       42       42        0        0        0        8        4        0        13        8         0        4         0         5
    118  0xff11000155a60040     0       1    0.11%       11       11        0       29       29        0        0        0        0        0        0         6       11         0        0         0        12
    119  0xff110001e3bd9700     0      42    0.11%       11        5        6       82       82        0        0        0       43        0        0        22        5         0        6         0         6

=================================================
      Shared Cache Line Distribution Pareto      
=================================================
#
#        ----- HITM -----  -- Store Refs --  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                                             Shared                         
#   Num  RmtHitm  LclHitm   L1 Hit  L1 Miss              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load  records       cnt                          Symbol             Object        Source:Line  Node
# .....  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ..............................  .................  .................  ....
#
  -------------------------------------------------------------
      0     1310     1535        0        0  0xff110002a24ffc00
  -------------------------------------------------------------
           1.37%    0.20%    0.00%    0.00%                 0x0     0       1  0xffffffff81157a52       854       620       429      737        49  [k] rwsem_optimistic_spin       [kernel.kallsyms]  atomic64_64.h:190   0  1
           0.69%    0.65%    0.00%    0.00%                 0x0     0       1  0xffffffff81157a37       520       194       327      587        48  [k] rwsem_optimistic_spin       [kernel.kallsyms]  atomic64_64.h:22    0  1
           0.00%    0.13%    0.00%    0.00%                 0x0     0       1  0xffffffff81157e89         0       762       203        5         5  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  atomic64_64.h:22    0  1
          54.43%   58.18%    0.00%    0.00%                 0x8     0       1  0xffffffff81157958       474       237       435     2611        50  [k] rwsem_spin_on_owner         [kernel.kallsyms]  atomic64_64.h:22    0  1
          40.76%   39.28%    0.00%    0.00%                 0x8     0       1  0xffffffff811578c7       408       185       324     1831        49  [k] rwsem_spin_on_owner         [kernel.kallsyms]  atomic64_64.h:22    0  1
           0.23%    0.20%    0.00%    0.00%                 0x8     0       1  0xffffffff811578fe       376       189       270      774        48  [k] rwsem_spin_on_owner         [kernel.kallsyms]  atomic64_64.h:22    0  1
           0.00%    0.07%    0.00%    0.00%                 0x8     0       1  0xffffffff81157c28         0       157       332      547        48  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  atomic64_64.h:22    0  1
           1.22%    0.65%    0.00%    0.00%                0x10     0       1  0xffffffff811587b5      1775       740      1033      592        49  [k] osq_lock                    [kernel.kallsyms]  atomic.h:208        0  1
           1.07%    0.33%    0.00%    0.00%                0x10     0       1  0xffffffff811588d3      1065       396       443      703        49  [k] osq_unlock                  [kernel.kallsyms]  atomic.h:196        0  1
           0.08%    0.07%    0.00%    0.00%                0x14     0       1  0xffffffff81cb8d19      1502       437       583       17        34  [k] _raw_spin_lock_irqsave      [kernel.kallsyms]  atomic.h:202        0  1
           0.00%    0.20%    0.00%    0.00%                0x18     0       1  0xffffffff811573d6         0       248       623       10        10  [k] rwsem_mark_wake             [kernel.kallsyms]  rwsem.c:414         0  1
           0.00%    0.07%    0.00%    0.00%                0x18     0       1  0xffffffff81157e67         0       789         0        1         1  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem.c:1245        0
           0.15%    0.00%    0.00%    0.00%                0x38     0       1  0xffffffff812f72d4       458         0       186      305        48  [k] unmap_region                [kernel.kallsyms]  mm.h:1945           0  1

  -------------------------------------------------------------
      1      108      136        0        0  0xff110002a24ffb80
  -------------------------------------------------------------
          57.41%   51.47%    0.00%    0.00%                0x10     0       1  0xffffffff812e24a4       386       157        62      212        44  [k] vmacache_find      [kernel.kallsyms]  vmacache.c:49   0  1
          42.59%   48.53%    0.00%    0.00%                0x18     0       1  0xffffffff812f73cc       392       164        86      181        44  [k] get_unmapped_area  [kernel.kallsyms]  mmap.c:2270     0  1

  -------------------------------------------------------------
      2      111      128        0        0  0xff1100209ae58b00
  -------------------------------------------------------------
          21.62%   25.78%    0.00%    0.00%                0x20     1       1  0xffffffff812f80f9       410       166       146      106        39  [k] __vma_adjust           [kernel.kallsyms]  mmap.c:536               0  1
          16.22%   13.28%    0.00%    0.00%                0x20     1       1  0xffffffff812f7537       401       170       277       87        38  [k] find_vma               [kernel.kallsyms]  mmap.c:2321              0  1
          49.55%   53.12%    0.00%    0.00%                0x28     1       1  0xffffffff812f92bb       406       168        84      204        47  [k] vm_unmapped_area       [kernel.kallsyms]  mmap.c:2065              0  1
          10.81%    7.81%    0.00%    0.00%                0x28     1       1  0xffffffff812f92bf       399       162        61       49        26  [k] vm_unmapped_area       [kernel.kallsyms]  mmap.c:2065              0  1
           1.80%    0.00%    0.00%    0.00%                0x28     1       1  0xffffffff812f7b99       424         0         0        4         2  [k] __vma_link_rb          [kernel.kallsyms]  mmap.c:434               0  1

  -------------------------------------------------------------
      3      123       99        0        0  0xff1100209ae58580
  -------------------------------------------------------------
          63.41%   40.40%    0.00%    0.00%                 0x0     1       1  0xffffffff812f906b       391       199        94      233        46  [k] vm_unmapped_area          [kernel.kallsyms]  mmap.c:2060              0  1
          12.20%   14.14%    0.00%    0.00%                 0x0     1       1  0xffffffff812f810d       387       159       159       62        29  [k] __vma_adjust              [kernel.kallsyms]  mmap.c:542               0  1
           1.63%   15.15%    0.00%    0.00%                 0x0     1       1  0xffffffff812f7dd1       398       174        72       28        20  [k] __vma_adjust              [kernel.kallsyms]  mmap.c:756               0  1
           8.94%    5.05%    0.00%    0.00%                 0x0     1       1  0xffffffff812f7544       384       163       236       41        23  [k] find_vma                  [kernel.kallsyms]  mmap.c:2317              0  1
           0.81%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffffff812f79a3       365         0       147        6         5  [k] __vma_rb_erase            [kernel.kallsyms]  mmap.c:301               0  1
           0.00%    1.01%    0.00%    0.00%                 0x0     1       1  0xffffffff812f998a         0       160        87        9         9  [k] __do_munmap               [kernel.kallsyms]  mmap.c:301               0  1
           0.81%    0.00%    0.00%    0.00%                0x20     1       1  0xffffffff812f7b90       399         0       294       49        29  [k] __vma_link_rb             [kernel.kallsyms]  mmap.c:434               0  1
           0.00%    1.01%    0.00%    0.00%                0x28     1       1  0xffffffff812f80f9         0       184       193       42        23  [k] __vma_adjust              [kernel.kallsyms]  mmap.c:536               0  1
           8.94%    7.07%    0.00%    0.00%                0x30     1       1  0xffffffff812f7b99       378       167       126       34        16  [k] __vma_link_rb             [kernel.kallsyms]  mmap.c:434               0  1
           0.00%   13.13%    0.00%    0.00%                0x30     1       1  0xffffffff812f90a9         0       164       335       29        24  [k] vm_unmapped_area          [kernel.kallsyms]  mmap.c:2085              0  1
           3.25%    2.02%    0.00%    0.00%                0x30     1       1  0xffffffff812f9959       369       170       231       22        11  [k] __do_munmap               [kernel.kallsyms]  mmap.c:434               0  1
           0.00%    1.01%    0.00%    0.00%                0x30     1       1  0xffffffff812f796b         0       148       219        9         8  [k] __vma_rb_erase            [kernel.kallsyms]  mmap.c:434               0  1

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="c2c_old.log"

=================================================
            Trace Event Information              
=================================================
  Total records                     :     419820
  Locked Load/Store Operations      :       8851
  Load Operations                   :      73936
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :          0
  Loads - no mapping                :        650
  Load Fill Buffer Hit              :      19371
  Load L1D hit                      :      25362
  Load L2D hit                      :        621
  Load LLC hit                      :      16164
  Load Local HITM                   :       7915
  Load Remote HITM                  :       7527
  Load Remote HIT                   :          0
  Load Local DRAM                   :        795
  Load Remote DRAM                  :      10973
  Load MESI State Exclusive         :      10973
  Load MESI State Shared            :        795
  Load LLC Misses                   :      19295
  Load access blocked by data       :          0
  Load access blocked by address    :          0
  LLC Misses to Local DRAM          :        4.1%
  LLC Misses to Remote DRAM         :       56.9%
  LLC Misses to Remote cache (HIT)  :        0.0%
  LLC Misses to Remote cache (HITM) :       39.0%
  Store Operations                  :          0
  Store - uncacheable               :          0
  Store - no mapping                :          0
  Store L1D Hit                     :          0
  Store L1D Miss                    :          0
  No Page Map Rejects               :      71173
  Unable to parse data source       :     345884

=================================================
    Global Shared Cache Line Event Information   
=================================================
  Total Shared Cache Lines          :       1755
  Load HITs on shared lines         :      48124
  Fill Buffer Hits on shared lines  :      13949
  L1D hits on shared lines          :       7439
  L2D hits on shared lines          :         83
  LLC hits on shared lines          :      15246
  Locked Access on shared lines     :       6623
  Blocked Access on shared lines    :          0
  Store HITs on shared lines        :          0
  Store L1D hits on shared lines    :          0
  Total Merged records              :      15442

=================================================
                 c2c details                     
=================================================
  Events                            : cpu/mem-loads,ldlat=30/P
                                    : cpu/mem-stores/P
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
      0  0xff11004077f52280     1    6828   25.29%     3905     1988     1917    10654    10654        0        0        0     1804     1048        2       757     1988         0     1917       158      2980
      1  0xff11004077f52240     1    4806   18.11%     2796      909     1887     9484     9484        0        0        0     1020     2800        0       465      909         0     1887       223      2180
      2  0xff11004077f52200     1     459    1.28%      197      114       83      748      748        0        0        0      377        1        1        89      114         0       83         0        83
      3  0xff11004077f522c0     1    1929    1.13%      175      171        4     1704     1704        0        0        0     1117        0        1       209      171         0        4        13       189
      4  0xff110002d1012400     0     857    1.02%      158       78       80      817      817        0        0        0      413       96        0        67       78         0       80         3        80
      5  0xff1100407dadc980     1     724    0.93%      144       58       86      792      792        0        0        0      465       46        0        49       58         0       86         0        88
      6  0xff1100407dadcd40     1    1036    0.87%      134       60       74     1157     1157        0        0        0      828       59        0        62       60         0       74         0        74
      7  0xff11003fdcdaba00     1     200    0.66%      102       55       47      278      278        0        0        0       47       21        0        51       55         0       47         4        53
      8  0xff110002d10123c0     0     158    0.63%       97       46       51      577      577        0        0        0      147       18        0       256       46         0       51         0        59
      9  0xff11003fdca6ba00     1     147    0.58%       89       45       44      258      258        0        0        0       44       15        0        49       45         0       44         3        58
     10  0xff110020001aba00     0     174    0.56%       86       46       40      253      253        0        0        0       31       28        0        57       46         0       40         4        47
     11  0xff11001ffffaba00     0     155    0.54%       84       37       47      236      236        0        0        0       40       19        0        35       37         0       47         4        54
     12  0xff11001fffdaba00     0     152    0.54%       83       40       43      237      237        0        0        0       34       21        0        40       40         0       43         3        56
     13  0xff11003fdca2ba00     1     169    0.54%       83       52       31      237      237        0        0        0       48       22        0        45       52         0       31         3        36
     14  0xff11003fdcdeba00     1     158    0.54%       83       40       43      232      232        0        0        0       38       21        0        33       40         0       43         5        52
     15  0xff11001fffe2ba00     0     136    0.53%       82       43       39      210      210        0        0        0       32       14        0        25       43         0       39         9        48
     16  0xff11001fffe6ba00     0     145    0.52%       81       43       38      228      228        0        0        0       47       12        0        40       43         0       38         4        44
     17  0xff11003fdcb2ba00     1     133    0.52%       81       36       45      242      242        0        0        0       43       23        0        36       36         0       45         1        58
     18  0xff11003fdcd6ba00     1     153    0.52%       80       40       40      237      237        0        0        0       42       15        0        43       40         0       40         6        51
     19  0xff11001fffeaba00     0     138    0.51%       78       42       36      220      220        0        0        0       31       18        0        42       42         0       36         5        46
     20  0xff11003fdcc2ba00     1     142    0.51%       78       40       38      217      217        0        0        0       40       18        0        31       40         0       38         3        47
     21  0xff11001fffdeba00     0     143    0.50%       77       42       35      218      218        0        0        0       31       27        0        39       42         0       35         2        42
     22  0xff11001fffeeba00     0     154    0.50%       77       34       43      226      226        0        0        0       37       19        0        38       34         0       43         4        51
     23  0xff11004077f52580     1       1    0.50%       77       77        0      228      228        0        0        0       23        0        0        61       77         0        0         1        66
     24  0xff11001ffff2ba00     0     138    0.49%       76       41       35      223      223        0        0        0       37       17        0        40       41         0       35         5        48
     25  0xff11003fdcc6ba00     1     155    0.49%       76       44       32      224      224        0        0        0       44       23        0        37       44         0       32         4        40
     26  0xff11003fdccaba00     1     123    0.49%       76       48       28      195      195        0        0        0       31       20        0        29       48         0       28         2        37
     27  0xff11001fffd6ba00     0     155    0.48%       74       41       33      232      232        0        0        0       36       26        0        51       41         0       33         8        37
     28  0xff1100200002ba00     0     174    0.48%       74       34       40      240      240        0        0        0       42       21        0        49       34         0       40         0        54
     29  0xff11003fdcbaba00     1     158    0.48%       74       33       41      235      235        0        0        0       40       17        0        50       33         0       41         3        51
     30  0xff11003fdcd2ba00     1     167    0.48%       74       37       37      242      242        0        0        0       57       17        0        45       37         0       37         5        44
     31  0xff11001ffff6ba00     0     146    0.47%       73       33       40      215      215        0        0        0       35       26        0        32       33         0       40         4        45
     32  0xff11003fdcb6ba00     1     144    0.47%       73       32       41      217      217        0        0        0       46       13        0        33       32         0       41         4        48
     33  0xff110020000aba00     0     146    0.47%       72       29       43      220      220        0        0        0       33       22        0        39       29         0       43         6        48
     34  0xff11003fdceaba00     1     111    0.46%       71       36       35      189      189        0        0        0       18       18        0        38       36         0       35         3        41
     35  0xff11001fffc2ba00     0     138    0.45%       70       33       37      217      217        0        0        0       38       21        0        37       33         0       37         3        48
     36  0xff11001ffffeba00     0     152    0.45%       70       39       31      204      204        0        0        0       29       23        0        39       39         0       31         7        36
     37  0xff1100200016ba00     0     154    0.45%       70       36       34      241      241        0        0        0       47       29        0        39       36         0       34         6        50
     38  0xff11001fffceba00     0     129    0.44%       68       28       40      219      219        0        0        0       36       23        0        41       28         0       40         5        46
     39  0xff11003fdcf2ba00     1     118    0.44%       68       32       36      206      206        0        0        0       33       18        0        41       32         0       36         1        45
     40  0xff1100200012ba00     0     126    0.43%       67       37       30      203      203        0        0        0       27       25        0        37       37         0       30         8        39
     41  0xff11003fdcceba00     1     142    0.43%       67       28       39      223      223        0        0        0       42       23        0        41       28         0       39         2        48
     42  0xff11003fdcfaba00     1     119    0.43%       67       31       36      200      200        0        0        0       36       14        0        34       31         0       36         3        46
     43  0xff110020000eba00     0     106    0.42%       65       36       29      174      174        0        0        0       25       16        0        23       36         0       29         2        43
     44  0xff11003fdcaaba00     1     144    0.42%       65       32       33      216      216        0        0        0       46       23        0        36       32         0       33         2        44
     45  0xff110020001eba00     0     136    0.41%       64       24       40      223      223        0        0        0       44       17        0        39       24         0       40         4        55
     46  0xff11003fdceeba00     1     115    0.41%       63       32       31      200      200        0        0        0       37       12        0        46       32         0       31         4        38
     47  0xff11003fdcaeba00     1     134    0.40%       61       32       29      196      196        0        0        0       37       24        0        27       32         0       29         5        42
     48  0xff11003fdce6ba00     1     126    0.40%       61       36       25      184      184        0        0        0       24       19        0        49       36         0       25         3        28
     49  0xff11003fdcfeba00     1     107    0.39%       60       36       24      183      183        0        0        0       38        9        0        37       36         0       24         3        36
     50  0xff11003fdce2ba00     1     126    0.38%       58       33       25      187      187        0        0        0       38       13        0        37       33         0       25         8        33
     51  0xff11001fffd2ba00     0     108    0.36%       56       31       25      154      154        0        0        0       26       16        0        23       31         0       25         0        33
     52  0xff11004077f52540     1       1    0.36%       56       56        0      155      155        0        0        0        6        0        0        40       56         0        0         2        51
     53  0xff11001fffcaba00     0     100    0.36%       55       31       24      172      172        0        0        0       27       17        0        35       31         0       24         3        35
     54  0xff11003fdcf6ba00     1     105    0.35%       54       29       25      163      163        0        0        0       23       20        0        25       29         0       25         5        36
     55  0xff1100407dadcd80     1     183    0.34%       53       43       10      345      345        0        0        0      156       17        0        86       43         0       10         5        28
     56  0xff11001fffc6ba00     0     129    0.34%       52       20       32      201      201        0        0        0       48       18        0        36       20         0       32         3        44
     57  0xff1100200006ba00     0     152    0.34%       52       21       31      201      201        0        0        0       49       22        0        38       21         0       31         4        36
     58  0xff11004077f524c0     1     397    0.34%       52       52        0      626      626        0        0        0      445        0        0        63       52         0        0         1        65
     59  0xff11003fdcbeba00     1      82    0.32%       50       22       28      141      141        0        0        0       24       13        0        20       22         0       28         3        31
     60  0xff110020db958000     1      85    0.32%       49       18       31      129      129        0        0        0       25       13        0        11       18         0       31         0        31
     61  0xff110001b550c000     0     102    0.26%       40       15       25      131      131        0        0        0       23       20        0        23       15         0       25         0        25
     62  0xff11000185270000     0      96    0.24%       37       16       21      123      123        0        0        0       30       11        0        24       16         0       21         0        21
     63  0xff110040745f0000     1     100    0.24%       37       16       21      132      132        0        0        0       31       15        0        27       16         0       21         0        22
     64  0xff11000116e68000     0     102    0.23%       36       18       18      131      131        0        0        0       36       20        0        21       18         0       18         0        18
     65  0xff110002405e4000     0     100    0.23%       36       13       23      131      131        0        0        0       36       18        0        17       13         0       23         1        23
     66  0xff1100209ebfc000     1     117    0.23%       36       13       23      146      146        0        0        0       38       16        0        33       13         0       23         0        23
     67  0xff11004075200000     1      83    0.23%       36       15       21      132      132        0        0        0       34       18        0        23       15         0       21         0        21
     68  0xff1100209c38c000     1      98    0.23%       35       17       18      139      139        0        0        0       37       20        0        29       17         0       18         0        18
     69  0xff11003fdc5eba00     1      69    0.23%       35       20       15      104      104        0        0        0       21       14        0        10       20         0       15         2        22
     70  0xff1100407546c000     1     101    0.23%       35       17       18      147      147        0        0        0       54       19        0        20       17         0       18         0        19
     71  0xff1100012d434000     0     115    0.22%       34       17       17      147      147        0        0        0       43       22        0        29       17         0       17         0        19
     72  0xff110002704b4000     0      81    0.22%       34       17       17      116      116        0        0        0       29       14        0        21       17         0       17         0        18
     73  0xff110002d0b18000     0      90    0.22%       34       17       17      114      114        0        0        0       34       13        0        14       17         0       17         0        19
     74  0xff1100406c458000     1     105    0.22%       34       16       18      127      127        0        0        0       34       23        0        18       16         0       18         0        18
     75  0xff1100407eeb8000     1      97    0.22%       34       16       18      133      133        0        0        0       46       19        0        16       16         0       18         0        18
     76  0xff110020b69bc000     1     105    0.21%       33       16       17      134      134        0        0        0       45       16        0        22       16         0       17         0        18
     77  0xffffffff835477c0     1       1    0.21%       32       13       19       51       51        0        0        0        0        0        0         0       13         0       19         0        19
     78  0xff110001b2a1ba00     0     215    0.21%       32       19       13      330      330        0        0        0        4       37        0       244       19         0       13         0        13
     79  0xff110002720d8000     0      98    0.21%       32       15       17      129      129        0        0        0       33       20        0        27       15         0       17         0        17
     80  0xff1100209cf60000     1      92    0.21%       32       15       17      108      108        0        0        0       30       11        0        18       15         0       17         0        17
     81  0xff1100011628c000     0      95    0.20%       31       17       14      112      112        0        0        0       30       12        0        25       17         0       14         0        14
     82  0xff110020b5cac000     1      93    0.20%       31       14       17      133      133        0        0        0       49       13        0        22       14         0       17         0        18
     83  0xff11000156b04000     0      90    0.19%       30       15       15      100      100        0        0        0       27       13        0        15       15         0       15         0        15
     84  0xff110001570cc000     0     104    0.19%       30       18       12      106      106        0        0        0       24       19        0        21       18         0       12         0        12
     85  0xff1100407ed74000     1      70    0.19%       30       14       16       89       89        0        0        0       23        7        0        13       14         0       16         0        16
     86  0xff1100209d8fc000     1      87    0.19%       29        9       20      121      121        0        0        0       39       16        0        16        9         0       20         0        21
     87  0xff1100407db84000     1      78    0.19%       29       14       15      103      103        0        0        0       32        8        0        19       14         0       15         0        15
     88  0xff11000116638000     0      84    0.18%       28       15       13      116      116        0        0        0       32       17        0        26       15         0       13         0        13
     89  0xff110001b2fb4000     0      59    0.18%       28       15       13       79       79        0        0        0       15        7        0        16       15         0       13         0        13
     90  0xff1100010927c000     0      87    0.17%       27       13       14      134      134        0        0        0       60       15        0        17       13         0       14         0        15
     91  0xff11000185274000     0      88    0.17%       27       13       14      112      112        0        0        0       24       20        0        26       13         0       14         0        15
     92  0xff1100209a4f4000     1      91    0.17%       27       13       14      120      120        0        0        0       36       14        0        28       13         0       14         0        15
     93  0xff110001b343c000     0      96    0.17%       26        9       17      119      119        0        0        0       29       27        0        19        9         0       17         0        18
     94  0xff1100021189c000     0      87    0.17%       26       12       14      102      102        0        0        0       22       19        0        21       12         0       14         0        14
     95  0xff110001e3704000     0      78    0.16%       25       17        8       80       80        0        0        0       17       15        0        13       17         0        8         0        10
     96  0xff110002703b0000     0      95    0.16%       25       12       13      129      129        0        0        0       41       25        0        23       12         0       13         0        15
     97  0xff110020b5ef0000     1      91    0.16%       25       10       15      111      111        0        0        0       29       16        0        26       10         0       15         0        15
     98  0xff110020dd11c000     1      90    0.16%       24       12       12      106      106        0        0        0       32       15        0        22       12         0       12         1        12
     99  0xff11000116b38000     0      69    0.15%       23        9       14      103      103        0        0        0       30       20        0        16        9         0       14         0        14
    100  0xff11000211070000     0      85    0.15%       23        9       14      100      100        0        0        0       26       18        0        18        9         0       14         0        15
    101  0xff1100407303c000     1      90    0.15%       23        8       15      119      119        0        0        0       40       18        0        20        8         0       15         0        18
    102  0xff1100407db80000     1      84    0.15%       23       10       13      109      109        0        0        0       44        8        1        20       10         0       13         0        13
    103  0xff1100012df30000     0     102    0.14%       22       13        9      108      108        0        0        0       29       25        0        22       13         0        9         0        10
    104  0xff110020b69b8000     1      84    0.14%       21        9       12      117      117        0        0        0       43       19        0        21        9         0       12         0        13
    105  0xff110001e1ff0000     0      87    0.13%       20        9       11      110      110        0        0        0       42       21        0        14        9         0       11         0        13
    106  0xff1100407348c000     1      75    0.13%       20        9       11       98       98        0        0        0       27       19        0        20        9         0       11         0        12
    107  0xff11004075204000     1      81    0.13%       20        9       11      104      104        0        0        0       30       21        0        21        9         0       11         0        12
    108  0xff110020b7eb8000     1      64    0.12%       19        7       12       93       93        0        0        0       45        5        0        12        7         0       12         0        12
    109  0xff110001e47a0000     0      81    0.12%       18        5       13       93       93        0        0        0       24       21        0        16        5         0       13         0        14
    110  0xff1100010923c000     0      91    0.11%       17        9        8       92       92        0        0        0       30       17        0        18        9         0        8         0        10
    111  0xff110001b550c040     0       3    0.10%       16       16        0       40       40        0        0        0        4        0        0         2       16         0        0         0        18
    112  0xff110002d10124c0     0     428    0.10%       16       14        2      646      646        0        0        0      357        3        0       236       14         0        2         0        34
    113  0xff11003fdc6aba00     1      35    0.10%       16        9        7       47       47        0        0        0       10        8        0         3        9         0        7         0        10

=================================================
      Shared Cache Line Distribution Pareto      
=================================================
#
#        ----- HITM -----  -- Store Refs --  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                                             Shared                        
#   Num  RmtHitm  LclHitm   L1 Hit  L1 Miss              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load  records       cnt                          Symbol             Object       Source:Line  Node
# .....  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ..............................  .................  ................  ....
#
  -------------------------------------------------------------
      0     1917     1988        0        0  0xff11004077f52280
  -------------------------------------------------------------
          53.31%   49.04%    0.00%    0.00%                 0x0     1       1  0xffffffff81157918       497       277       465     3558        56  [k] rwsem_spin_on_owner         [kernel.kallsyms]  atomic64_64.h:22   0  1
          30.57%   35.87%    0.00%    0.00%                 0x0     1       1  0xffffffff81157887       413       228       392     2686        55  [k] rwsem_spin_on_owner         [kernel.kallsyms]  atomic64_64.h:22   0  1
          13.72%   12.02%    0.00%    0.00%                 0x0     1       1  0xffffffff81157be8       483       187       328      836        52  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  atomic64_64.h:22   0  1
           0.37%    0.55%    0.00%    0.00%                 0x0     1       1  0xffffffff811578be       411       213       309     1156        52  [k] rwsem_spin_on_owner         [kernel.kallsyms]  atomic64_64.h:22   0  1
           0.21%    0.60%    0.00%    0.00%                 0x0     1       1  0xffffffff81157a71       557       255       442       71        36  [k] rwsem_optimistic_spin       [kernel.kallsyms]  atomic64_64.h:22   0  1
           0.05%    0.15%    0.00%    0.00%                 0x0     1       1  0xffffffff811577e8       379       445       247      194        52  [k] downgrade_write             [kernel.kallsyms]  atomic64_64.h:22   0  1
           0.05%    0.05%    0.00%    0.00%                 0x0     1       1  0xffffffff81157760       386       172       300        5         4  [k] up_read                     [kernel.kallsyms]  atomic64_64.h:22   0  1
           1.10%    0.25%    0.00%    0.00%                 0x8     1       1  0xffffffff81158775      1059       580       939      617        54  [k] osq_lock                    [kernel.kallsyms]  atomic.h:208       0  1
           0.26%    0.40%    0.00%    0.00%                 0x8     1       1  0xffffffff81158893      1153       408       561      774        55  [k] osq_unlock                  [kernel.kallsyms]  atomic.h:196       0  1
           0.05%    0.00%    0.00%    0.00%                 0xc     1       1  0xffffffff81cb8d19       560         0       548       34        46  [k] _raw_spin_lock_irqsave      [kernel.kallsyms]  atomic.h:202       0  1
           0.05%    0.15%    0.00%    0.00%                0x10     1       1  0xffffffff81157396       796       234       436       42        30  [k] rwsem_mark_wake             [kernel.kallsyms]  rwsem.c:414        0  1
           0.16%    0.05%    0.00%    0.00%                0x10     1       1  0xffffffff811576ba       543       209       554       26        20  [k] rwsem_wake.isra.0           [kernel.kallsyms]  list.h:282         0  1
           0.10%    0.86%    0.00%    0.00%                0x38     1       1  0xffffffff812f96c2       408       166       146      158        46  [k] __do_munmap                 [kernel.kallsyms]  mm.h:1951          0  1

  -------------------------------------------------------------
      1     1887      909        0        0  0xff11004077f52240
  -------------------------------------------------------------
           0.58%    2.42%    0.00%    0.00%                 0x8     1       1  0xffffffff812f8eea       449       214       266       83        33  [k] vm_unmapped_area           [kernel.kallsyms]  mmap.c:2048         0  1
           0.00%    1.87%    0.00%    0.00%                0x10     1       1  0xffffffff812eaec3         0       172       130      124        48  [k] free_pgd_range             [kernel.kallsyms]  pgtable.h:106       0  1
           0.32%    0.22%    0.00%    0.00%                0x10     1       1  0xffffffff812ed581       410       320        86      156        46  [k] unmap_page_range           [kernel.kallsyms]  pgtable.h:106       0  1
           0.48%    0.44%    0.00%    0.00%                0x18     1       1  0xffffffff81125dab       407       332        96       24        13  [k] finish_task_switch         [kernel.kallsyms]  atomic.h:29         0  1
           0.00%    0.22%    0.00%    0.00%                0x20     1       1  0xffffffff81cb2ed4         0       749       388       11        15  [k] __schedule                 [kernel.kallsyms]  atomic.h:95         0  1
           0.00%    0.11%    0.00%    0.00%                0x20     1       1  0xffffffff81125cad         0      1506       641       11        14  [k] finish_task_switch         [kernel.kallsyms]  atomic.h:123        0  1
           7.53%    5.39%    0.00%    0.00%                0x30     1       1  0xffffffff812fb7d5       619       216       667      466        52  [k] do_mmap                    [kernel.kallsyms]  mmap.c:1445         0  1
           4.72%    2.53%    0.00%    0.00%                0x30     1       1  0xffffffff812f9533       459       172       184      250        50  [k] __do_munmap                [kernel.kallsyms]  mmap.c:2853         0  1
           2.17%    2.86%    0.00%    0.00%                0x30     1       1  0xffffffff812f800f       405       169       220      233        52  [k] __vma_adjust               [kernel.kallsyms]  mmap.c:719          0  1
           0.05%    1.21%    0.00%    0.00%                0x30     1       1  0xffffffff812f7f3d       421       165       302       41        42  [k] __vma_adjust               [kernel.kallsyms]  mmap.c:958          0  1
           0.11%    0.22%    0.00%    0.00%                0x30     1       1  0xffffffff812f964c       487       156       335      123        55  [k] __do_munmap                [kernel.kallsyms]  mmap.c:2697         0  1
          69.79%   75.91%    0.00%    0.00%                0x38     1       1  0xffffffff811579f7       436       177       342     3585        54  [k] rwsem_optimistic_spin      [kernel.kallsyms]  atomic64_64.h:22    0  1
          13.78%    5.28%    0.00%    0.00%                0x38     1       1  0xffffffff81157a12      1240       483       484     1354        55  [k] rwsem_optimistic_spin      [kernel.kallsyms]  atomic64_64.h:190   0  1
           0.16%    0.44%    0.00%    0.00%                0x38     1       1  0xffffffff81157794      1128       695       539      545        54  [k] up_write                   [kernel.kallsyms]  atomic64_64.h:172   0  1
           0.00%    0.55%    0.00%    0.00%                0x38     1       1  0xffffffff81157a7d         0       221       314      552        52  [k] rwsem_optimistic_spin      [kernel.kallsyms]  atomic64_64.h:22    0  1
           0.11%    0.11%    0.00%    0.00%                0x38     1       1  0xffffffff811577e3      1386       415       381      355        54  [k] downgrade_write            [kernel.kallsyms]  atomic64_64.h:172   0  1
           0.11%    0.00%    0.00%    0.00%                0x38     1       1  0xffffffff81cb6168      1250         0       502      930        55  [k] down_write_killable        [kernel.kallsyms]  atomic64_64.h:190   0  1
           0.00%    0.11%    0.00%    0.00%                0x38     1       1  0xffffffff81157c9c         0       146         0        1         1  [k] rwsem_down_write_slowpath  [kernel.kallsyms]  atomic64_64.h:22    0
           0.00%    0.11%    0.00%    0.00%                0x38     1       1  0xffffffff81157ce6         0       230      2218        2         2  [k] rwsem_down_write_slowpath  [kernel.kallsyms]  atomic64_64.h:22    0
           0.05%    0.00%    0.00%    0.00%                0x38     1       1  0xffffffff81157e2c       394         0         0        2         1  [k] rwsem_down_write_slowpath  [kernel.kallsyms]  atomic64_64.h:22    0
           0.05%    0.00%    0.00%    0.00%                0x38     1       1  0xffffffff81157e49       501         0        82        5         4  [k] rwsem_down_write_slowpath  [kernel.kallsyms]  atomic64_64.h:22    0  1

  -------------------------------------------------------------
      2       83      114        0        0  0xff11004077f52200
  -------------------------------------------------------------
          49.40%   41.23%    0.00%    0.00%                0x10     1       1  0xffffffff812e2464       391       166       141      173        46  [k] vmacache_find      [kernel.kallsyms]  vmacache.c:49   0  1
          50.60%   58.77%    0.00%    0.00%                0x18     1       1  0xffffffff812f728c       394       165        68      203        48  [k] get_unmapped_area  [kernel.kallsyms]  mmap.c:2270     0  1

  -------------------------------------------------------------
      3        4      171        0        0  0xff11004077f522c0
  -------------------------------------------------------------
           0.00%    5.85%    0.00%    0.00%                 0x0     1       1  0xffffffff812f96b0         0       170       247       90        39  [k] __do_munmap              [kernel.kallsyms]  mm.h:1951      0  1
           0.00%    4.68%    0.00%    0.00%                 0x0     1       1  0xffffffff812fb228         0       176       236       47        54  [k] mmap_region              [kernel.kallsyms]  mmap.c:3384    0  1
          25.00%    1.17%    0.00%    0.00%                 0x0     1       1  0xffffffff811f12f0       453       726       273       34        27  [k] __acct_update_integrals  [kernel.kallsyms]  tsacct.c:140   0  1
           0.00%    1.17%    0.00%    0.00%                 0x0     1       1  0xffffffff812fa195         0       200       210      361        53  [k] may_expand_vm            [kernel.kallsyms]  mmap.c:3359    0  1
           0.00%   22.22%    0.00%    0.00%                 0x8     1       1  0xffffffff812f959a         0       166       178      177        51  [k] __do_munmap              [kernel.kallsyms]  mmap.c:2889    0  1
           0.00%    0.58%    0.00%    0.00%                0x18     1       1  0xffffffff812fa1cf         0       177       208      306        52  [k] may_expand_vm            [kernel.kallsyms]  mmap.c:3363    0  1
          75.00%   64.33%    0.00%    0.00%                0x30     1       1  0xffffffff812fb836       371       234       237      329        51  [k] do_mmap                  [kernel.kallsyms]  mmap.c:1472    0  1

  -------------------------------------------------------------
      4       80       78        0        0  0xff110002d1012400
  -------------------------------------------------------------
           0.00%    2.56%    0.00%    0.00%                 0x0     0       1  0xffffffff812f8f1e         0       232       235       74        34  [k] vm_unmapped_area          [kernel.kallsyms]  mmap.c:2060              0  1
          22.50%    6.41%    0.00%    0.00%                0x10     0       1  0xffffffff812f7406       382       188       177       75        35  [k] find_vma                  [kernel.kallsyms]  mmap.c:2323              0  1
           1.25%    0.00%    0.00%    0.00%                0x10     0       1  0xffffffff812fb12f        71         0       101        6         4  [k] mmap_region               [kernel.kallsyms]  mmap.c:536               0  1
          76.25%   91.03%    0.00%    0.00%                0x20     0       1  0xffffffff812f917b       393       172        69      239        51  [k] vm_unmapped_area          [kernel.kallsyms]  mmap.c:2065              0  1

--tThc/1wpZn/ma/RB--
