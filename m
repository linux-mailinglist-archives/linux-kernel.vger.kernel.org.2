Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8183FD39F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242488AbhIAF6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:58:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:9972 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242444AbhIAF6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:58:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218690386"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="gz'50?scan'50,208,50";a="218690386"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 22:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="gz'50?scan'50,208,50";a="541393579"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2021 22:57:34 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLJFd-0007cK-Qv; Wed, 01 Sep 2021 05:57:33 +0000
Date:   Wed, 1 Sep 2021 13:57:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: fs/ntfs/file.c:1727:16: warning: stack frame size (4352) exceeds
 limit (2048) in function 'ntfs_perform_write'
Message-ID: <202109011355.OGEYctXZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9e9fb7655ed585da8f468e29221f0ba194a5f613
commit: 97e4910232fa1f81e806aa60c25a0450276d99a2 linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
date:   6 months ago
config: mips-randconfig-r026-20210829 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 510e106fa8635e7f9c51c896180b971de6309b2f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=97e4910232fa1f81e806aa60c25a0450276d99a2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 97e4910232fa1f81e806aa60c25a0450276d99a2
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=mips SHELL=/bin/bash block/ fs/ntfs/ fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ntfs/file.c:1727:16: warning: stack frame size (4352) exceeds limit (2048) in function 'ntfs_perform_write'
   static ssize_t ntfs_perform_write(struct file struct iov_iter
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 133, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: lld $0, $1
   and $0, $2
   scd $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 4b1fde8a2b681dad2ce0c082a5d6422caa06b0bc)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-4b1fde8a2b/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers fs include kernel mm net nr_bisected scripts source usr


vim +/ntfs_perform_write +1727 fs/ntfs/file.c

9014da7525dffe Marco Stornelli    2012-12-15  1720  
98b270362bb9ea Anton Altaparmakov 2005-10-11  1721  /**
a632f559304130 Anton Altaparmakov 2015-03-11  1722   * ntfs_perform_write - perform buffered write to a file
a632f559304130 Anton Altaparmakov 2015-03-11  1723   * @file:	file to write to
a632f559304130 Anton Altaparmakov 2015-03-11  1724   * @i:		iov_iter with data to write
a632f559304130 Anton Altaparmakov 2015-03-11  1725   * @pos:	byte offset in file at which to begin writing to
98b270362bb9ea Anton Altaparmakov 2005-10-11  1726   */
a632f559304130 Anton Altaparmakov 2015-03-11 @1727  static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
a632f559304130 Anton Altaparmakov 2015-03-11  1728  		loff_t pos)
98b270362bb9ea Anton Altaparmakov 2005-10-11  1729  {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1730  	struct address_space *mapping = file->f_mapping;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1731  	struct inode *vi = mapping->host;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1732  	ntfs_inode *ni = NTFS_I(vi);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1733  	ntfs_volume *vol = ni->vol;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1734  	struct page *pages[NTFS_MAX_PAGES_PER_CLUSTER];
98b270362bb9ea Anton Altaparmakov 2005-10-11  1735  	struct page *cached_page = NULL;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1736  	VCN last_vcn;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1737  	LCN lcn;
a632f559304130 Anton Altaparmakov 2015-03-11  1738  	size_t bytes;
a632f559304130 Anton Altaparmakov 2015-03-11  1739  	ssize_t status, written = 0;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1740  	unsigned nr_pages;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1741  
a632f559304130 Anton Altaparmakov 2015-03-11  1742  	ntfs_debug("Entering for i_ino 0x%lx, attribute type 0x%x, pos "
a632f559304130 Anton Altaparmakov 2015-03-11  1743  			"0x%llx, count 0x%lx.", vi->i_ino,
a632f559304130 Anton Altaparmakov 2015-03-11  1744  			(unsigned)le32_to_cpu(ni->type),
a632f559304130 Anton Altaparmakov 2015-03-11  1745  			(unsigned long long)pos,
a632f559304130 Anton Altaparmakov 2015-03-11  1746  			(unsigned long)iov_iter_count(i));
98b270362bb9ea Anton Altaparmakov 2005-10-11  1747  	/*
98b270362bb9ea Anton Altaparmakov 2005-10-11  1748  	 * If a previous ntfs_truncate() failed, repeat it and abort if it
98b270362bb9ea Anton Altaparmakov 2005-10-11  1749  	 * fails again.
98b270362bb9ea Anton Altaparmakov 2005-10-11  1750  	 */
98b270362bb9ea Anton Altaparmakov 2005-10-11  1751  	if (unlikely(NInoTruncateFailed(ni))) {
a632f559304130 Anton Altaparmakov 2015-03-11  1752  		int err;
a632f559304130 Anton Altaparmakov 2015-03-11  1753  
bd5fe6c5eb9c54 Christoph Hellwig  2011-06-24  1754  		inode_dio_wait(vi);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1755  		err = ntfs_truncate(vi);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1756  		if (err || NInoTruncateFailed(ni)) {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1757  			if (!err)
98b270362bb9ea Anton Altaparmakov 2005-10-11  1758  				err = -EIO;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1759  			ntfs_error(vol->sb, "Cannot perform write to inode "
98b270362bb9ea Anton Altaparmakov 2005-10-11  1760  					"0x%lx, attribute type 0x%x, because "
98b270362bb9ea Anton Altaparmakov 2005-10-11  1761  					"ntfs_truncate() failed (error code "
98b270362bb9ea Anton Altaparmakov 2005-10-11  1762  					"%i).", vi->i_ino,
98b270362bb9ea Anton Altaparmakov 2005-10-11  1763  					(unsigned)le32_to_cpu(ni->type), err);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1764  			return err;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1765  		}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1766  	}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1767  	/*
98b270362bb9ea Anton Altaparmakov 2005-10-11  1768  	 * Determine the number of pages per cluster for non-resident
98b270362bb9ea Anton Altaparmakov 2005-10-11  1769  	 * attributes.
98b270362bb9ea Anton Altaparmakov 2005-10-11  1770  	 */
98b270362bb9ea Anton Altaparmakov 2005-10-11  1771  	nr_pages = 1;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1772  	if (vol->cluster_size > PAGE_SIZE && NInoNonResident(ni))
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1773  		nr_pages = vol->cluster_size >> PAGE_SHIFT;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1774  	last_vcn = -1;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1775  	do {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1776  		VCN vcn;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1777  		pgoff_t idx, start_idx;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1778  		unsigned ofs, do_pages, u;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1779  		size_t copied;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1780  
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1781  		start_idx = idx = pos >> PAGE_SHIFT;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1782  		ofs = pos & ~PAGE_MASK;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1783  		bytes = PAGE_SIZE - ofs;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1784  		do_pages = 1;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1785  		if (nr_pages > 1) {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1786  			vcn = pos >> vol->cluster_size_bits;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1787  			if (vcn != last_vcn) {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1788  				last_vcn = vcn;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1789  				/*
98b270362bb9ea Anton Altaparmakov 2005-10-11  1790  				 * Get the lcn of the vcn the write is in.  If
98b270362bb9ea Anton Altaparmakov 2005-10-11  1791  				 * it is a hole, need to lock down all pages in
98b270362bb9ea Anton Altaparmakov 2005-10-11  1792  				 * the cluster.
98b270362bb9ea Anton Altaparmakov 2005-10-11  1793  				 */
98b270362bb9ea Anton Altaparmakov 2005-10-11  1794  				down_read(&ni->runlist.lock);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1795  				lcn = ntfs_attr_vcn_to_lcn_nolock(ni, pos >>
c49c31115067bc Richard Knutsson   2006-09-30  1796  						vol->cluster_size_bits, false);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1797  				up_read(&ni->runlist.lock);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1798  				if (unlikely(lcn < LCN_HOLE)) {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1799  					if (lcn == LCN_ENOMEM)
98b270362bb9ea Anton Altaparmakov 2005-10-11  1800  						status = -ENOMEM;
a632f559304130 Anton Altaparmakov 2015-03-11  1801  					else {
a632f559304130 Anton Altaparmakov 2015-03-11  1802  						status = -EIO;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1803  						ntfs_error(vol->sb, "Cannot "
98b270362bb9ea Anton Altaparmakov 2005-10-11  1804  							"perform write to "
98b270362bb9ea Anton Altaparmakov 2005-10-11  1805  							"inode 0x%lx, "
98b270362bb9ea Anton Altaparmakov 2005-10-11  1806  							"attribute type 0x%x, "
98b270362bb9ea Anton Altaparmakov 2005-10-11  1807  							"because the attribute "
98b270362bb9ea Anton Altaparmakov 2005-10-11  1808  							"is corrupt.",
98b270362bb9ea Anton Altaparmakov 2005-10-11  1809  							vi->i_ino, (unsigned)
98b270362bb9ea Anton Altaparmakov 2005-10-11  1810  							le32_to_cpu(ni->type));
a632f559304130 Anton Altaparmakov 2015-03-11  1811  					}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1812  					break;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1813  				}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1814  				if (lcn == LCN_HOLE) {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1815  					start_idx = (pos & ~(s64)
98b270362bb9ea Anton Altaparmakov 2005-10-11  1816  							vol->cluster_size_mask)
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1817  							>> PAGE_SHIFT;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1818  					bytes = vol->cluster_size - (pos &
98b270362bb9ea Anton Altaparmakov 2005-10-11  1819  							vol->cluster_size_mask);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1820  					do_pages = nr_pages;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1821  				}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1822  			}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1823  		}
a632f559304130 Anton Altaparmakov 2015-03-11  1824  		if (bytes > iov_iter_count(i))
a632f559304130 Anton Altaparmakov 2015-03-11  1825  			bytes = iov_iter_count(i);
a632f559304130 Anton Altaparmakov 2015-03-11  1826  again:
98b270362bb9ea Anton Altaparmakov 2005-10-11  1827  		/*
98b270362bb9ea Anton Altaparmakov 2005-10-11  1828  		 * Bring in the user page(s) that we will copy from _first_.
98b270362bb9ea Anton Altaparmakov 2005-10-11  1829  		 * Otherwise there is a nasty deadlock on copying from the same
98b270362bb9ea Anton Altaparmakov 2005-10-11  1830  		 * page(s) as we are writing to, without it/them being marked
98b270362bb9ea Anton Altaparmakov 2005-10-11  1831  		 * up-to-date.  Note, at present there is nothing to stop the
98b270362bb9ea Anton Altaparmakov 2005-10-11  1832  		 * pages being swapped out between us bringing them into memory
98b270362bb9ea Anton Altaparmakov 2005-10-11  1833  		 * and doing the actual copying.
98b270362bb9ea Anton Altaparmakov 2005-10-11  1834  		 */
4bce9f6ee8f84f Al Viro            2016-09-17  1835  		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
a632f559304130 Anton Altaparmakov 2015-03-11  1836  			status = -EFAULT;
a632f559304130 Anton Altaparmakov 2015-03-11  1837  			break;
a632f559304130 Anton Altaparmakov 2015-03-11  1838  		}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1839  		/* Get and lock @do_pages starting at index @start_idx. */
98b270362bb9ea Anton Altaparmakov 2005-10-11  1840  		status = __ntfs_grab_cache_pages(mapping, start_idx, do_pages,
4c99000ac47cbd Minchan Kim        2010-05-24  1841  				pages, &cached_page);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1842  		if (unlikely(status))
98b270362bb9ea Anton Altaparmakov 2005-10-11  1843  			break;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1844  		/*
98b270362bb9ea Anton Altaparmakov 2005-10-11  1845  		 * For non-resident attributes, we need to fill any holes with
98b270362bb9ea Anton Altaparmakov 2005-10-11  1846  		 * actual clusters and ensure all bufferes are mapped.  We also
98b270362bb9ea Anton Altaparmakov 2005-10-11  1847  		 * need to bring uptodate any buffers that are only partially
98b270362bb9ea Anton Altaparmakov 2005-10-11  1848  		 * being written to.
98b270362bb9ea Anton Altaparmakov 2005-10-11  1849  		 */
98b270362bb9ea Anton Altaparmakov 2005-10-11  1850  		if (NInoNonResident(ni)) {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1851  			status = ntfs_prepare_pages_for_non_resident_write(
98b270362bb9ea Anton Altaparmakov 2005-10-11  1852  					pages, do_pages, pos, bytes);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1853  			if (unlikely(status)) {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1854  				do {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1855  					unlock_page(pages[--do_pages]);
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1856  					put_page(pages[do_pages]);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1857  				} while (do_pages);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1858  				break;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1859  			}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1860  		}
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1861  		u = (pos >> PAGE_SHIFT) - pages[0]->index;
a632f559304130 Anton Altaparmakov 2015-03-11  1862  		copied = ntfs_copy_from_user_iter(pages + u, do_pages - u, ofs,
a632f559304130 Anton Altaparmakov 2015-03-11  1863  					i, bytes);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1864  		ntfs_flush_dcache_pages(pages + u, do_pages - u);
a632f559304130 Anton Altaparmakov 2015-03-11  1865  		status = 0;
a632f559304130 Anton Altaparmakov 2015-03-11  1866  		if (likely(copied == bytes)) {
a632f559304130 Anton Altaparmakov 2015-03-11  1867  			status = ntfs_commit_pages_after_write(pages, do_pages,
a632f559304130 Anton Altaparmakov 2015-03-11  1868  					pos, bytes);
a632f559304130 Anton Altaparmakov 2015-03-11  1869  			if (!status)
a632f559304130 Anton Altaparmakov 2015-03-11  1870  				status = bytes;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1871  		}
98b270362bb9ea Anton Altaparmakov 2005-10-11  1872  		do {
98b270362bb9ea Anton Altaparmakov 2005-10-11  1873  			unlock_page(pages[--do_pages]);
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1874  			put_page(pages[do_pages]);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1875  		} while (do_pages);
a632f559304130 Anton Altaparmakov 2015-03-11  1876  		if (unlikely(status < 0))
98b270362bb9ea Anton Altaparmakov 2005-10-11  1877  			break;
a632f559304130 Anton Altaparmakov 2015-03-11  1878  		copied = status;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1879  		cond_resched();
a632f559304130 Anton Altaparmakov 2015-03-11  1880  		if (unlikely(!copied)) {
a632f559304130 Anton Altaparmakov 2015-03-11  1881  			size_t sc;
a632f559304130 Anton Altaparmakov 2015-03-11  1882  
a632f559304130 Anton Altaparmakov 2015-03-11  1883  			/*
a632f559304130 Anton Altaparmakov 2015-03-11  1884  			 * We failed to copy anything.  Fall back to single
a632f559304130 Anton Altaparmakov 2015-03-11  1885  			 * segment length write.
a632f559304130 Anton Altaparmakov 2015-03-11  1886  			 *
a632f559304130 Anton Altaparmakov 2015-03-11  1887  			 * This is needed to avoid possible livelock in the
a632f559304130 Anton Altaparmakov 2015-03-11  1888  			 * case that all segments in the iov cannot be copied
a632f559304130 Anton Altaparmakov 2015-03-11  1889  			 * at once without a pagefault.
a632f559304130 Anton Altaparmakov 2015-03-11  1890  			 */
a632f559304130 Anton Altaparmakov 2015-03-11  1891  			sc = iov_iter_single_seg_count(i);
a632f559304130 Anton Altaparmakov 2015-03-11  1892  			if (bytes > sc)
a632f559304130 Anton Altaparmakov 2015-03-11  1893  				bytes = sc;
a632f559304130 Anton Altaparmakov 2015-03-11  1894  			goto again;
a632f559304130 Anton Altaparmakov 2015-03-11  1895  		}
a632f559304130 Anton Altaparmakov 2015-03-11  1896  		iov_iter_advance(i, copied);
a632f559304130 Anton Altaparmakov 2015-03-11  1897  		pos += copied;
a632f559304130 Anton Altaparmakov 2015-03-11  1898  		written += copied;
a632f559304130 Anton Altaparmakov 2015-03-11  1899  		balance_dirty_pages_ratelimited(mapping);
a632f559304130 Anton Altaparmakov 2015-03-11  1900  		if (fatal_signal_pending(current)) {
a632f559304130 Anton Altaparmakov 2015-03-11  1901  			status = -EINTR;
a632f559304130 Anton Altaparmakov 2015-03-11  1902  			break;
a632f559304130 Anton Altaparmakov 2015-03-11  1903  		}
a632f559304130 Anton Altaparmakov 2015-03-11  1904  	} while (iov_iter_count(i));
98b270362bb9ea Anton Altaparmakov 2005-10-11  1905  	if (cached_page)
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1906  		put_page(cached_page);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1907  	ntfs_debug("Done.  Returning %s (written 0x%lx, status %li).",
98b270362bb9ea Anton Altaparmakov 2005-10-11  1908  			written ? "written" : "status", (unsigned long)written,
98b270362bb9ea Anton Altaparmakov 2005-10-11  1909  			(long)status);
98b270362bb9ea Anton Altaparmakov 2005-10-11  1910  	return written ? written : status;
98b270362bb9ea Anton Altaparmakov 2005-10-11  1911  }
98b270362bb9ea Anton Altaparmakov 2005-10-11  1912  

:::::: The code at line 1727 was first introduced by commit
:::::: a632f5593041305c8adbf4727bc1ccdf0b45178b NTFS: Version 2.1.32 - Update file write from aio_write to write_iter.

:::::: TO: Anton Altaparmakov <anton@tuxera.com>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Qxx1br4bt0+wmkIi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
kXdikZNnmirlxd+l4hyD/h+RXVXuMtgBAA==

--Qxx1br4bt0+wmkIi--
