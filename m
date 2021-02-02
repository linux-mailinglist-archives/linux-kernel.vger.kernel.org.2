Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FAA30CFE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 00:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhBBXc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 18:32:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:18041 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233149AbhBBXcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 18:32:24 -0500
IronPort-SDR: rrmLPZ4/CPGt4fndNyNJebChU7Sjb/0lXtZyPieEjPV2qFO9oTveKo9DzCfML9Fsuhg2SGSWd2
 A4I/SL+RuQ2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181027686"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="gz'50?scan'50,208,50";a="181027686"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:31:42 -0800
IronPort-SDR: vqOcXkJymR9ZC9KROcTrCykUd/LCbTS9uOG4q/KDV5TmB46vjI2OFo5WmzZiDK/FswR43bIt/U
 YQDOrbme5n3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="gz'50?scan'50,208,50";a="413775468"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2021 15:31:40 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7591-0009kb-96; Tue, 02 Feb 2021 23:31:39 +0000
Date:   Wed, 3 Feb 2021 07:30:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [rcu:willy-maple 125/202] lib/maple_tree.c:3273:6: warning: no
 previous prototype for 'mas_is_span_wr'
Message-ID: <202102030733.ToNwP3su-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git willy-maple
head:   7e346d2845b4bd77663394f39fa70456e0084c86
commit: 824aa5e4af0be646da193e90e3383651b93f1c8d [125/202] Maple Tree: Add new data structure
config: alpha-defconfig (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=824aa5e4af0be646da193e90e3383651b93f1c8d
        git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags rcu willy-maple
        git checkout 824aa5e4af0be646da193e90e3383651b93f1c8d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/maple_tree.c:3273:6: warning: no previous prototype for 'mas_is_span_wr' [-Wmissing-prototypes]
    3273 | bool mas_is_span_wr(struct ma_state *mas, unsigned long piv,
         |      ^~~~~~~~~~~~~~
>> lib/maple_tree.c:3373:6: warning: no previous prototype for 'mas_wr_walk' [-Wmissing-prototypes]
    3373 | bool mas_wr_walk(struct ma_state *mas, unsigned long *range_min,
         |      ^~~~~~~~~~~
>> lib/maple_tree.c:5633:5: warning: no previous prototype for 'mtree_store' [-Wmissing-prototypes]
    5633 | int mtree_store(struct maple_tree *mt, unsigned long index, void *entry,
         |     ^~~~~~~~~~~
>> lib/maple_tree.c:5692:5: warning: no previous prototype for 'mtree_alloc_range' [-Wmissing-prototypes]
    5692 | int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
         |     ^~~~~~~~~~~~~~~~~
>> lib/maple_tree.c:5727:5: warning: no previous prototype for 'mtree_alloc_rrange' [-Wmissing-prototypes]
    5727 | int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
         |     ^~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:31:28: warning: 'mt_max' defined but not used [-Wunused-const-variable=]
      31 | static const unsigned long mt_max[] = {
         |                            ^~~~~~


vim +/mas_is_span_wr +3273 lib/maple_tree.c

  3259	
  3260	/*
  3261	 * mas_is_span_wr() - Check if the write needs to be treated as a write that
  3262	 * spans the node.
  3263	 * @mas: The maple state
  3264	 * @piv: The pivot value being written
  3265	 * @type: The maple node type
  3266	 * @entry: The data to write
  3267	 *
  3268	 * Spanning writes are writes that start in one node and end in another OR if
  3269	 * the write of a %NULL will cause the node to end with a %NULL.
  3270	 *
  3271	 * Return: True if this is a spanning write, false otherwise.
  3272	 */
> 3273	bool mas_is_span_wr(struct ma_state *mas, unsigned long piv,
  3274					  enum maple_type type, void *entry)
  3275	{
  3276		unsigned long max;
  3277		unsigned long last = mas->last;
  3278	
  3279		if (piv > last) // Contained in this pivot
  3280			return false;
  3281	
  3282		max = mas->max;
  3283		if (unlikely(ma_is_leaf(type))) {
  3284			if (last < max) // Fits in the node, but may span slots.
  3285				return false;
  3286	
  3287			if ((last == max) && entry) // Writes to the end of the node but not null.
  3288				return false;
  3289		} else if ((piv == last) && entry) {
  3290			return false;
  3291		}
  3292	
  3293		/* Writing ULONG_MAX is not a spanning write regardless of the value
  3294		 * being written as long as the range fits in the node.
  3295		 */
  3296		if ((last == ULONG_MAX) && (last == max))
  3297			return false;
  3298	
  3299		trace_mas_is_span_wr(mas, piv, entry);
  3300	
  3301		return true;
  3302	}
  3303	
  3304	/*
  3305	 * mas_node_walk() - Walk a maple node to offset of the index.
  3306	 * @mas: The maple state
  3307	 * @type: The maple node type
  3308	 * @*range_min: Pointer to store the minimum range of the offset
  3309	 * @*range_max: Pointer to store the maximum range of the offset
  3310	 *
  3311	 * The offset will be stored in the maple state.
  3312	 *
  3313	 */
  3314	static inline void mas_node_walk(struct ma_state *mas, enum maple_type type,
  3315			unsigned long *range_min, unsigned long *range_max)
  3316	{
  3317		unsigned long *pivots = ma_pivots(mas_mn(mas), type);
  3318		unsigned char offset, count;
  3319		unsigned long min, max, index;
  3320	
  3321		if (unlikely(ma_is_dense(type))) {
  3322			(*range_max) = (*range_min) = mas->index;
  3323			mas->offset = mas->index = mas->min;
  3324			return;
  3325		}
  3326	
  3327		offset = mas->offset;
  3328		min = mas_safe_min(mas, pivots, offset);
  3329		count = mt_pivots[type];
  3330		if (unlikely(offset == count))
  3331			goto max;
  3332	
  3333		index = mas->index;
  3334		max = pivots[offset];
  3335		if (unlikely(index <= max))
  3336			goto done;
  3337	
  3338		if (unlikely(!max && offset))
  3339			goto max;
  3340	
  3341		offset++;
  3342		min = max + 1;
  3343		while (offset < count) {
  3344			max = pivots[offset];
  3345			if (index <= max)
  3346				goto done;
  3347	
  3348			if (unlikely(!max))
  3349				break;
  3350	
  3351			min = max + 1;
  3352			offset++;
  3353		}
  3354	
  3355	max:
  3356		max = mas->max;
  3357	done:
  3358		*range_max = max;
  3359		*range_min = min;
  3360		mas->offset = offset;
  3361	}
  3362	
  3363	/*
  3364	 * mas_wr_walk(): Walk the tree for a write.
  3365	 * @range_min - pointer that will be set to the minimum of the slot range
  3366	 * @range_max - pointer that will be set to the maximum of the slot range
  3367	 * @entry - the value that will be written.
  3368	 *
  3369	 * Uses mas_slot_locked() and does not need to worry about dead nodes.
  3370	 *
  3371	 * Return: True if it's contained in a node, false on spanning write.
  3372	 */
> 3373	bool mas_wr_walk(struct ma_state *mas, unsigned long *range_min,
  3374			unsigned long *range_max, void *entry)
  3375	{
  3376		enum maple_type type;
  3377	
  3378		while (true) {
  3379			type = mte_node_type(mas->node);
  3380			mas->depth++;
  3381	
  3382			mas_node_walk(mas, type, range_min, range_max);
  3383			if (mas_is_span_wr(mas, *range_max, type, entry))
  3384				return false;
  3385	
  3386			if (ma_is_leaf(type))
  3387				return true;
  3388	
  3389			// Traverse.
  3390			mas->max = *range_max;
  3391			mas->min = *range_min;
  3392			mas->node = mas_slot_locked(mas, ma_slots(mas_mn(mas), type),
  3393					     mas->offset);
  3394			mas->offset = 0;
  3395		}
  3396		return true;
  3397	}
  3398	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
