Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037DE44DBE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 19:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhKKS7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 13:59:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:46510 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhKKS7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:59:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="213719777"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="gz'50?scan'50,208,50";a="213719777"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 10:56:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="gz'50?scan'50,208,50";a="492651335"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 10:56:49 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlFFg-000GtZ-Du; Thu, 11 Nov 2021 18:56:48 +0000
Date:   Fri, 12 Nov 2021 02:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [dhowells-fs:netfs-folio 3/4] fs/netfs/read_helper.c:435:25: error:
 implicit declaration of function 'flush_dcache_folio'; did you mean
 'flush_dcache_page'?
Message-ID: <202111120230.m1Qpwp5c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-folio
head:   255ed63638da190e2485d32c0f696cd04d34fbc0
commit: 78525c74d9e7d1a6ce69bd4388f045f6e474a20b [3/4] netfs, 9p, afs, ceph: Use folios
config: csky-defconfig (attached as .config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=78525c74d9e7d1a6ce69bd4388f045f6e474a20b
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs netfs-folio
        git checkout 78525c74d9e7d1a6ce69bd4388f045f6e474a20b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=csky 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/netfs/read_helper.c: In function 'netfs_rreq_unlock':
>> fs/netfs/read_helper.c:435:25: error: implicit declaration of function 'flush_dcache_folio'; did you mean 'flush_dcache_page'? [-Werror=implicit-function-declaration]
     435 |                         flush_dcache_folio(folio);
         |                         ^~~~~~~~~~~~~~~~~~
         |                         flush_dcache_page
   cc1: some warnings being treated as errors


vim +435 fs/netfs/read_helper.c

   368	
   369	/*
   370	 * Unlock the folios in a read operation.  We need to set PG_fscache on any
   371	 * folios we're going to write back before we unlock them.
   372	 */
   373	static void netfs_rreq_unlock(struct netfs_read_request *rreq)
   374	{
   375		struct netfs_read_subrequest *subreq;
   376		struct folio *folio;
   377		unsigned int iopos, account = 0;
   378		pgoff_t start_page = rreq->start / PAGE_SIZE;
   379		pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
   380		bool subreq_failed = false;
   381	
   382		XA_STATE(xas, &rreq->mapping->i_pages, start_page);
   383	
   384		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
   385			__clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
   386			list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
   387				__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
   388			}
   389		}
   390	
   391		/* Walk through the pagecache and the I/O request lists simultaneously.
   392		 * We may have a mixture of cached and uncached sections and we only
   393		 * really want to write out the uncached sections.  This is slightly
   394		 * complicated by the possibility that we might have huge pages with a
   395		 * mixture inside.
   396		 */
   397		subreq = list_first_entry(&rreq->subrequests,
   398					  struct netfs_read_subrequest, rreq_link);
   399		iopos = 0;
   400		subreq_failed = (subreq->error < 0);
   401	
   402		trace_netfs_rreq(rreq, netfs_rreq_trace_unlock);
   403	
   404		rcu_read_lock();
   405		xas_for_each(&xas, folio, last_page) {
   406			unsigned int pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
   407			unsigned int pgend = pgpos + folio_size(folio);
   408			bool pg_failed = false;
   409	
   410			for (;;) {
   411				if (!subreq) {
   412					pg_failed = true;
   413					break;
   414				}
   415				if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
   416					folio_start_fscache(folio);
   417				pg_failed |= subreq_failed;
   418				if (pgend < iopos + subreq->len)
   419					break;
   420	
   421				account += subreq->transferred;
   422				iopos += subreq->len;
   423				if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
   424					subreq = list_next_entry(subreq, rreq_link);
   425					subreq_failed = (subreq->error < 0);
   426				} else {
   427					subreq = NULL;
   428					subreq_failed = false;
   429				}
   430				if (pgend == iopos)
   431					break;
   432			}
   433	
   434			if (!pg_failed) {
 > 435				flush_dcache_folio(folio);
   436				folio_mark_uptodate(folio);
   437			}
   438	
   439			if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
   440				if (folio_index(folio) == rreq->no_unlock_folio &&
   441				    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
   442					_debug("no unlock");
   443				else
   444					folio_unlock(folio);
   445			}
   446		}
   447		rcu_read_unlock();
   448	
   449		task_io_account_read(account);
   450		if (rreq->netfs_ops->done)
   451			rreq->netfs_ops->done(rreq);
   452	}
   453	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
lML4P6Xirla2oAAA

--LZvS9be/3tNcYl/X--
