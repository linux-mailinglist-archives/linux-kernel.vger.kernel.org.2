Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EAF42CD13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhJMVur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:50:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:19341 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJMVuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:50:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="288418396"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="288418396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 14:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="626591191"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 14:48:39 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mam75-0005Aj-9t; Wed, 13 Oct 2021 21:48:39 +0000
Date:   Thu, 14 Oct 2021 05:48:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     kbuild-all@lists.01.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [gfs2:for-next 4/38] fs/ntfs3/file.c:990:30: error: implicit
 declaration of function 'iov_iter_fault_in_readable'; did you mean
 'fault_in_readable'?
Message-ID: <202110140509.ibrcGepZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
head:   9d0084204c8a7e01f9b8ebe81402be61e0a67a62
commit: 4b03be65e2d7c2a3c7a83d28d5f9882e9dcf178d [4/38] iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable
config: nios2-randconfig-r003-20211013 (attached as .config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=4b03be65e2d7c2a3c7a83d28d5f9882e9dcf178d
        git remote add gfs2 https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
        git fetch --no-tags gfs2 for-next
        git checkout 4b03be65e2d7c2a3c7a83d28d5f9882e9dcf178d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/backing-dev.h:12,
                    from fs/ntfs3/file.c:10:
   fs/ntfs3/file.c: In function 'ntfs_compress_write':
>> fs/ntfs3/file.c:990:30: error: implicit declaration of function 'iov_iter_fault_in_readable'; did you mean 'fault_in_readable'? [-Werror=implicit-function-declaration]
     990 |                 if (unlikely(iov_iter_fault_in_readable(from, bytes))) {
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   cc1: some warnings being treated as errors


vim +990 fs/ntfs3/file.c

4342306f0f0d5f Konstantin Komarov 2021-08-13   863  
e8b8e97f91b80f Kari Argillander   2021-08-03   864  /*
e8b8e97f91b80f Kari Argillander   2021-08-03   865   * ntfs_compress_write - Helper for ntfs_file_write_iter() (compressed files).
e8b8e97f91b80f Kari Argillander   2021-08-03   866   */
4342306f0f0d5f Konstantin Komarov 2021-08-13   867  static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
4342306f0f0d5f Konstantin Komarov 2021-08-13   868  {
4342306f0f0d5f Konstantin Komarov 2021-08-13   869  	int err;
4342306f0f0d5f Konstantin Komarov 2021-08-13   870  	struct file *file = iocb->ki_filp;
4342306f0f0d5f Konstantin Komarov 2021-08-13   871  	size_t count = iov_iter_count(from);
4342306f0f0d5f Konstantin Komarov 2021-08-13   872  	loff_t pos = iocb->ki_pos;
4342306f0f0d5f Konstantin Komarov 2021-08-13   873  	struct inode *inode = file_inode(file);
4342306f0f0d5f Konstantin Komarov 2021-08-13   874  	loff_t i_size = inode->i_size;
4342306f0f0d5f Konstantin Komarov 2021-08-13   875  	struct address_space *mapping = inode->i_mapping;
4342306f0f0d5f Konstantin Komarov 2021-08-13   876  	struct ntfs_inode *ni = ntfs_i(inode);
4342306f0f0d5f Konstantin Komarov 2021-08-13   877  	u64 valid = ni->i_valid;
4342306f0f0d5f Konstantin Komarov 2021-08-13   878  	struct ntfs_sb_info *sbi = ni->mi.sbi;
4342306f0f0d5f Konstantin Komarov 2021-08-13   879  	struct page *page, **pages = NULL;
4342306f0f0d5f Konstantin Komarov 2021-08-13   880  	size_t written = 0;
4342306f0f0d5f Konstantin Komarov 2021-08-13   881  	u8 frame_bits = NTFS_LZNT_CUNIT + sbi->cluster_bits;
4342306f0f0d5f Konstantin Komarov 2021-08-13   882  	u32 frame_size = 1u << frame_bits;
4342306f0f0d5f Konstantin Komarov 2021-08-13   883  	u32 pages_per_frame = frame_size >> PAGE_SHIFT;
4342306f0f0d5f Konstantin Komarov 2021-08-13   884  	u32 ip, off;
4342306f0f0d5f Konstantin Komarov 2021-08-13   885  	CLST frame;
4342306f0f0d5f Konstantin Komarov 2021-08-13   886  	u64 frame_vbo;
4342306f0f0d5f Konstantin Komarov 2021-08-13   887  	pgoff_t index;
4342306f0f0d5f Konstantin Komarov 2021-08-13   888  	bool frame_uptodate;
4342306f0f0d5f Konstantin Komarov 2021-08-13   889  
4342306f0f0d5f Konstantin Komarov 2021-08-13   890  	if (frame_size < PAGE_SIZE) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   891  		/*
4342306f0f0d5f Konstantin Komarov 2021-08-13   892  		 * frame_size == 8K if cluster 512
4342306f0f0d5f Konstantin Komarov 2021-08-13   893  		 * frame_size == 64K if cluster 4096
4342306f0f0d5f Konstantin Komarov 2021-08-13   894  		 */
4342306f0f0d5f Konstantin Komarov 2021-08-13   895  		ntfs_inode_warn(inode, "page size is bigger than frame size");
4342306f0f0d5f Konstantin Komarov 2021-08-13   896  		return -EOPNOTSUPP;
4342306f0f0d5f Konstantin Komarov 2021-08-13   897  	}
4342306f0f0d5f Konstantin Komarov 2021-08-13   898  
345482bc431f64 Kari Argillander   2021-08-24   899  	pages = kmalloc_array(pages_per_frame, sizeof(struct page *), GFP_NOFS);
4342306f0f0d5f Konstantin Komarov 2021-08-13   900  	if (!pages)
4342306f0f0d5f Konstantin Komarov 2021-08-13   901  		return -ENOMEM;
4342306f0f0d5f Konstantin Komarov 2021-08-13   902  
4342306f0f0d5f Konstantin Komarov 2021-08-13   903  	current->backing_dev_info = inode_to_bdi(inode);
4342306f0f0d5f Konstantin Komarov 2021-08-13   904  	err = file_remove_privs(file);
4342306f0f0d5f Konstantin Komarov 2021-08-13   905  	if (err)
4342306f0f0d5f Konstantin Komarov 2021-08-13   906  		goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13   907  
4342306f0f0d5f Konstantin Komarov 2021-08-13   908  	err = file_update_time(file);
4342306f0f0d5f Konstantin Komarov 2021-08-13   909  	if (err)
4342306f0f0d5f Konstantin Komarov 2021-08-13   910  		goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13   911  
e8b8e97f91b80f Kari Argillander   2021-08-03   912  	/* Zero range [valid : pos). */
4342306f0f0d5f Konstantin Komarov 2021-08-13   913  	while (valid < pos) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   914  		CLST lcn, clen;
4342306f0f0d5f Konstantin Komarov 2021-08-13   915  
4342306f0f0d5f Konstantin Komarov 2021-08-13   916  		frame = valid >> frame_bits;
4342306f0f0d5f Konstantin Komarov 2021-08-13   917  		frame_vbo = valid & ~(frame_size - 1);
4342306f0f0d5f Konstantin Komarov 2021-08-13   918  		off = valid & (frame_size - 1);
4342306f0f0d5f Konstantin Komarov 2021-08-13   919  
4342306f0f0d5f Konstantin Komarov 2021-08-13   920  		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 0, &lcn,
4342306f0f0d5f Konstantin Komarov 2021-08-13   921  					  &clen, NULL);
4342306f0f0d5f Konstantin Komarov 2021-08-13   922  		if (err)
4342306f0f0d5f Konstantin Komarov 2021-08-13   923  			goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13   924  
4342306f0f0d5f Konstantin Komarov 2021-08-13   925  		if (lcn == SPARSE_LCN) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   926  			ni->i_valid = valid =
4342306f0f0d5f Konstantin Komarov 2021-08-13   927  				frame_vbo + ((u64)clen << sbi->cluster_bits);
4342306f0f0d5f Konstantin Komarov 2021-08-13   928  			continue;
4342306f0f0d5f Konstantin Komarov 2021-08-13   929  		}
4342306f0f0d5f Konstantin Komarov 2021-08-13   930  
e8b8e97f91b80f Kari Argillander   2021-08-03   931  		/* Load full frame. */
4342306f0f0d5f Konstantin Komarov 2021-08-13   932  		err = ntfs_get_frame_pages(mapping, frame_vbo >> PAGE_SHIFT,
4342306f0f0d5f Konstantin Komarov 2021-08-13   933  					   pages, pages_per_frame,
4342306f0f0d5f Konstantin Komarov 2021-08-13   934  					   &frame_uptodate);
4342306f0f0d5f Konstantin Komarov 2021-08-13   935  		if (err)
4342306f0f0d5f Konstantin Komarov 2021-08-13   936  			goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13   937  
4342306f0f0d5f Konstantin Komarov 2021-08-13   938  		if (!frame_uptodate && off) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   939  			err = ni_read_frame(ni, frame_vbo, pages,
4342306f0f0d5f Konstantin Komarov 2021-08-13   940  					    pages_per_frame);
4342306f0f0d5f Konstantin Komarov 2021-08-13   941  			if (err) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   942  				for (ip = 0; ip < pages_per_frame; ip++) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   943  					page = pages[ip];
4342306f0f0d5f Konstantin Komarov 2021-08-13   944  					unlock_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13   945  					put_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13   946  				}
4342306f0f0d5f Konstantin Komarov 2021-08-13   947  				goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13   948  			}
4342306f0f0d5f Konstantin Komarov 2021-08-13   949  		}
4342306f0f0d5f Konstantin Komarov 2021-08-13   950  
4342306f0f0d5f Konstantin Komarov 2021-08-13   951  		ip = off >> PAGE_SHIFT;
4342306f0f0d5f Konstantin Komarov 2021-08-13   952  		off = offset_in_page(valid);
4342306f0f0d5f Konstantin Komarov 2021-08-13   953  		for (; ip < pages_per_frame; ip++, off = 0) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   954  			page = pages[ip];
4342306f0f0d5f Konstantin Komarov 2021-08-13   955  			zero_user_segment(page, off, PAGE_SIZE);
4342306f0f0d5f Konstantin Komarov 2021-08-13   956  			flush_dcache_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13   957  			SetPageUptodate(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13   958  		}
4342306f0f0d5f Konstantin Komarov 2021-08-13   959  
4342306f0f0d5f Konstantin Komarov 2021-08-13   960  		ni_lock(ni);
4342306f0f0d5f Konstantin Komarov 2021-08-13   961  		err = ni_write_frame(ni, pages, pages_per_frame);
4342306f0f0d5f Konstantin Komarov 2021-08-13   962  		ni_unlock(ni);
4342306f0f0d5f Konstantin Komarov 2021-08-13   963  
4342306f0f0d5f Konstantin Komarov 2021-08-13   964  		for (ip = 0; ip < pages_per_frame; ip++) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   965  			page = pages[ip];
4342306f0f0d5f Konstantin Komarov 2021-08-13   966  			SetPageUptodate(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13   967  			unlock_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13   968  			put_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13   969  		}
4342306f0f0d5f Konstantin Komarov 2021-08-13   970  
4342306f0f0d5f Konstantin Komarov 2021-08-13   971  		if (err)
4342306f0f0d5f Konstantin Komarov 2021-08-13   972  			goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13   973  
4342306f0f0d5f Konstantin Komarov 2021-08-13   974  		ni->i_valid = valid = frame_vbo + frame_size;
4342306f0f0d5f Konstantin Komarov 2021-08-13   975  	}
4342306f0f0d5f Konstantin Komarov 2021-08-13   976  
e8b8e97f91b80f Kari Argillander   2021-08-03   977  	/* Copy user data [pos : pos + count). */
4342306f0f0d5f Konstantin Komarov 2021-08-13   978  	while (count) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   979  		size_t copied, bytes;
4342306f0f0d5f Konstantin Komarov 2021-08-13   980  
4342306f0f0d5f Konstantin Komarov 2021-08-13   981  		off = pos & (frame_size - 1);
4342306f0f0d5f Konstantin Komarov 2021-08-13   982  		bytes = frame_size - off;
4342306f0f0d5f Konstantin Komarov 2021-08-13   983  		if (bytes > count)
4342306f0f0d5f Konstantin Komarov 2021-08-13   984  			bytes = count;
4342306f0f0d5f Konstantin Komarov 2021-08-13   985  
4342306f0f0d5f Konstantin Komarov 2021-08-13   986  		frame = pos >> frame_bits;
4342306f0f0d5f Konstantin Komarov 2021-08-13   987  		frame_vbo = pos & ~(frame_size - 1);
4342306f0f0d5f Konstantin Komarov 2021-08-13   988  		index = frame_vbo >> PAGE_SHIFT;
4342306f0f0d5f Konstantin Komarov 2021-08-13   989  
4342306f0f0d5f Konstantin Komarov 2021-08-13  @990  		if (unlikely(iov_iter_fault_in_readable(from, bytes))) {
4342306f0f0d5f Konstantin Komarov 2021-08-13   991  			err = -EFAULT;
4342306f0f0d5f Konstantin Komarov 2021-08-13   992  			goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13   993  		}
4342306f0f0d5f Konstantin Komarov 2021-08-13   994  
e8b8e97f91b80f Kari Argillander   2021-08-03   995  		/* Load full frame. */
4342306f0f0d5f Konstantin Komarov 2021-08-13   996  		err = ntfs_get_frame_pages(mapping, index, pages,
4342306f0f0d5f Konstantin Komarov 2021-08-13   997  					   pages_per_frame, &frame_uptodate);
4342306f0f0d5f Konstantin Komarov 2021-08-13   998  		if (err)
4342306f0f0d5f Konstantin Komarov 2021-08-13   999  			goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1000  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1001  		if (!frame_uptodate) {
4342306f0f0d5f Konstantin Komarov 2021-08-13  1002  			loff_t to = pos + bytes;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1003  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1004  			if (off || (to < i_size && (to & (frame_size - 1)))) {
4342306f0f0d5f Konstantin Komarov 2021-08-13  1005  				err = ni_read_frame(ni, frame_vbo, pages,
4342306f0f0d5f Konstantin Komarov 2021-08-13  1006  						    pages_per_frame);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1007  				if (err) {
4342306f0f0d5f Konstantin Komarov 2021-08-13  1008  					for (ip = 0; ip < pages_per_frame;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1009  					     ip++) {
4342306f0f0d5f Konstantin Komarov 2021-08-13  1010  						page = pages[ip];
4342306f0f0d5f Konstantin Komarov 2021-08-13  1011  						unlock_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1012  						put_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1013  					}
4342306f0f0d5f Konstantin Komarov 2021-08-13  1014  					goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1015  				}
4342306f0f0d5f Konstantin Komarov 2021-08-13  1016  			}
4342306f0f0d5f Konstantin Komarov 2021-08-13  1017  		}
4342306f0f0d5f Konstantin Komarov 2021-08-13  1018  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1019  		WARN_ON(!bytes);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1020  		copied = 0;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1021  		ip = off >> PAGE_SHIFT;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1022  		off = offset_in_page(pos);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1023  
e8b8e97f91b80f Kari Argillander   2021-08-03  1024  		/* Copy user data to pages. */
4342306f0f0d5f Konstantin Komarov 2021-08-13  1025  		for (;;) {
4342306f0f0d5f Konstantin Komarov 2021-08-13  1026  			size_t cp, tail = PAGE_SIZE - off;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1027  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1028  			page = pages[ip];
4342306f0f0d5f Konstantin Komarov 2021-08-13  1029  			cp = copy_page_from_iter_atomic(page, off,
4342306f0f0d5f Konstantin Komarov 2021-08-13  1030  							min(tail, bytes), from);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1031  			flush_dcache_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1032  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1033  			copied += cp;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1034  			bytes -= cp;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1035  			if (!bytes || !cp)
4342306f0f0d5f Konstantin Komarov 2021-08-13  1036  				break;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1037  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1038  			if (cp < tail) {
4342306f0f0d5f Konstantin Komarov 2021-08-13  1039  				off += cp;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1040  			} else {
4342306f0f0d5f Konstantin Komarov 2021-08-13  1041  				ip++;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1042  				off = 0;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1043  			}
4342306f0f0d5f Konstantin Komarov 2021-08-13  1044  		}
4342306f0f0d5f Konstantin Komarov 2021-08-13  1045  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1046  		ni_lock(ni);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1047  		err = ni_write_frame(ni, pages, pages_per_frame);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1048  		ni_unlock(ni);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1049  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1050  		for (ip = 0; ip < pages_per_frame; ip++) {
4342306f0f0d5f Konstantin Komarov 2021-08-13  1051  			page = pages[ip];
4342306f0f0d5f Konstantin Komarov 2021-08-13  1052  			ClearPageDirty(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1053  			SetPageUptodate(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1054  			unlock_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1055  			put_page(page);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1056  		}
4342306f0f0d5f Konstantin Komarov 2021-08-13  1057  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1058  		if (err)
4342306f0f0d5f Konstantin Komarov 2021-08-13  1059  			goto out;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1060  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1061  		/*
4342306f0f0d5f Konstantin Komarov 2021-08-13  1062  		 * We can loop for a long time in here. Be nice and allow
4342306f0f0d5f Konstantin Komarov 2021-08-13  1063  		 * us to schedule out to avoid softlocking if preempt
4342306f0f0d5f Konstantin Komarov 2021-08-13  1064  		 * is disabled.
4342306f0f0d5f Konstantin Komarov 2021-08-13  1065  		 */
4342306f0f0d5f Konstantin Komarov 2021-08-13  1066  		cond_resched();
4342306f0f0d5f Konstantin Komarov 2021-08-13  1067  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1068  		pos += copied;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1069  		written += copied;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1070  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1071  		count = iov_iter_count(from);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1072  	}
4342306f0f0d5f Konstantin Komarov 2021-08-13  1073  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1074  out:
195c52bdd5d5ec Kari Argillander   2021-08-24  1075  	kfree(pages);
4342306f0f0d5f Konstantin Komarov 2021-08-13  1076  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1077  	current->backing_dev_info = NULL;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1078  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1079  	if (err < 0)
4342306f0f0d5f Konstantin Komarov 2021-08-13  1080  		return err;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1081  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1082  	iocb->ki_pos += written;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1083  	if (iocb->ki_pos > ni->i_valid)
4342306f0f0d5f Konstantin Komarov 2021-08-13  1084  		ni->i_valid = iocb->ki_pos;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1085  
4342306f0f0d5f Konstantin Komarov 2021-08-13  1086  	return written;
4342306f0f0d5f Konstantin Komarov 2021-08-13  1087  }
4342306f0f0d5f Konstantin Komarov 2021-08-13  1088  

:::::: The code at line 990 was first introduced by commit
:::::: 4342306f0f0d5ff4315a204d315c1b51b914fca5 fs/ntfs3: Add file operations and implementation

:::::: TO: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
:::::: CC: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+QahgC5+KEYLbs62
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+QahgC5+KEYLbs62--
