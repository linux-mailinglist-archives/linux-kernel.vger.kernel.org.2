Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCBF34C0AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 02:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhC2AtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 20:49:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:44945 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhC2Asv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 20:48:51 -0400
IronPort-SDR: RljLLF4EAXIRwzHBKgLkPkKLxZSLDb5rL3x6Iahs67+ML0C35dkKZ9Y4gFfm0wwCFCbphpF8M5
 QmiaV3nHF3Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="170852866"
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="170852866"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 17:48:51 -0700
IronPort-SDR: v+H1tmwQq6B3SNEOJq0gIb5vPsMC+1nVqxfLh4/NUQ+WZPcyfTFf70BSZ51PLdUw7OdnFevYhJ
 JRT3Go0/Wxhw==
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="417416322"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 17:48:50 -0700
Date:   Mon, 29 Mar 2021 08:47:59 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: fs/gfs2/rgrp.c:1772:53: warning: Possible null pointer dereference:
 minext [nullPointer]
Message-ID: <20210329004759.GH4176174@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0f4498cef9f5cd18d7c6639a2a902ec1edc5be4e
commit: f38e998fbbb5da6a097ecd4b2700ba95eabab0c9 gfs2: Also reflect single-block allocations in rgd->rd_extfail_pt
compiler: sparc64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> fs/gfs2/rgrp.c:1772:53: warning: Possible null pointer dereference: minext [nullPointer]
     ret = gfs2_reservation_check_and_update(rbm, ip, *minext,
                                                       ^
   fs/gfs2/rgrp.c:1846:52: note: Calling function 'gfs2_rbm_find', 3rd argument 'NULL' value is 0
     error = gfs2_rbm_find(&rbm, GFS2_BLKST_UNLINKED, NULL, NULL,
                                                      ^
   fs/gfs2/rgrp.c:1772:53: note: Null pointer dereference
     ret = gfs2_reservation_check_and_update(rbm, ip, *minext,
                                                       ^

vim +1772 fs/gfs2/rgrp.c

5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1711  
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1712  /**
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1713   * gfs2_rbm_find - Look for blocks of a particular state
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1714   * @rbm: Value/result starting position and final position
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1715   * @state: The state which we want to find
f38e998fbbb5da Andreas Gruenbacher 2020-10-05  1716   * @minext: Pointer to the requested extent length
5ce13431dd3365 Bob Peterson        2013-11-06  1717   *          This is updated to be the actual reservation size.
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1718   * @ip: If set, check for reservations
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1719   * @nowrap: Stop looking at the end of the rgrp, rather than wrapping
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1720   *          around until we've reached the starting point.
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1721   *
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1722   * Side effects:
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1723   * - If looking for free blocks, we set GBF_FULL on each bitmap which
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1724   *   has no free blocks in it.
5ea5050cec9c02 Bob Peterson        2013-11-25  1725   * - If looking for free blocks, we set rd_extfail_pt on each rgrp which
5ea5050cec9c02 Bob Peterson        2013-11-25  1726   *   has come up short on a free block search.
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1727   *
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1728   * Returns: 0 on success, -ENOSPC if there is no block of the requested state
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1729   */
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1730  
5ce13431dd3365 Bob Peterson        2013-11-06  1731  static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 state, u32 *minext,
8381e602275586 Bob Peterson        2016-05-02  1732  			 const struct gfs2_inode *ip, bool nowrap)
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1733  {
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1734  	bool scan_from_start = rbm->bii == 0 && rbm->offset == 0;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1735  	struct buffer_head *bh;
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1736  	int last_bii;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1737  	u32 offset;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1738  	u8 *buffer;
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1739  	bool wrapped = false;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1740  	int ret;
e579ed4f446e64 Bob Peterson        2013-09-17  1741  	struct gfs2_bitmap *bi;
5ce13431dd3365 Bob Peterson        2013-11-06  1742  	struct gfs2_extent maxext = { .rbm.rgd = rbm->rgd, };
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1743  
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1744  	/*
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1745  	 * Determine the last bitmap to search.  If we're not starting at the
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1746  	 * beginning of a bitmap, we need to search that bitmap twice to scan
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1747  	 * the entire resource group.
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1748  	 */
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1749  	last_bii = rbm->bii - (rbm->offset == 0);
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1750  
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1751  	while(1) {
e579ed4f446e64 Bob Peterson        2013-09-17  1752  		bi = rbm_bi(rbm);
2fdc2fa21bc72e Andreas Gruenbacher 2020-10-06  1753  		if (test_bit(GBF_FULL, &bi->bi_flags) &&
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1754  		    (state == GFS2_BLKST_FREE))
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1755  			goto next_bitmap;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1756  
e579ed4f446e64 Bob Peterson        2013-09-17  1757  		bh = bi->bi_bh;
e579ed4f446e64 Bob Peterson        2013-09-17  1758  		buffer = bh->b_data + bi->bi_offset;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1759  		WARN_ON(!buffer_uptodate(bh));
e579ed4f446e64 Bob Peterson        2013-09-17  1760  		if (state != GFS2_BLKST_UNLINKED && bi->bi_clone)
e579ed4f446e64 Bob Peterson        2013-09-17  1761  			buffer = bi->bi_clone + bi->bi_offset;
281b4952d185a3 Andreas Gruenbacher 2018-09-26  1762  		offset = gfs2_bitfit(buffer, bi->bi_bytes, rbm->offset, state);
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1763  		if (offset == BFITNOENT) {
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1764  			if (state == GFS2_BLKST_FREE && rbm->offset == 0)
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1765  				set_bit(GBF_FULL, &bi->bi_flags);
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1766  			goto next_bitmap;
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1767  		}
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1768  		rbm->offset = offset;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1769  		if (ip == NULL)
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1770  			return 0;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1771  
f38e998fbbb5da Andreas Gruenbacher 2020-10-05 @1772  		ret = gfs2_reservation_check_and_update(rbm, ip, *minext,
5ce13431dd3365 Bob Peterson        2013-11-06  1773  							&maxext);
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1774  		if (ret == 0)
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1775  			return 0;
71921ef85928e9 Andreas Gruenbacher 2019-03-14  1776  		if (ret > 0)
8d8b752a0f5528 Bob Peterson        2012-08-07  1777  			goto next_iter;
5d50d5324612d2 Steven Whitehouse   2012-08-07  1778  		if (ret == -E2BIG) {
e579ed4f446e64 Bob Peterson        2013-09-17  1779  			rbm->bii = 0;
5d50d5324612d2 Steven Whitehouse   2012-08-07  1780  			rbm->offset = 0;
5d50d5324612d2 Steven Whitehouse   2012-08-07  1781  			goto res_covered_end_of_rgrp;
5d50d5324612d2 Steven Whitehouse   2012-08-07  1782  		}
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1783  		return ret;
5b924ae2dcb1cc Steven Whitehouse   2012-08-01  1784  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
