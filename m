Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1873C42E8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhJOGX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:23:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:55236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhJOGX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:23:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="291343182"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="gz'50?scan'50,208,50";a="291343182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 23:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="gz'50?scan'50,208,50";a="481591961"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2021 23:21:18 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbGaj-0007LC-H8; Fri, 15 Oct 2021 06:21:17 +0000
Date:   Fri, 15 Oct 2021 14:20:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dhowells-fs:fscache-rewrite-indexing 71/75]
 include/linux/fscache.h:386: undefined reference to
 `__fscache_resize_cookie'
Message-ID: <202110151432.ZwJIPGzH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-rewrite-indexing
head:   96d4e1af98c26988d3c1b3cf688974c24de90fa9
commit: 8a43aeca4686a1f00f184392066f00da252797d0 [71/75] 9p: Use fscache indexing rewrite and reenable caching
config: i386-debian-10.3 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=8a43aeca4686a1f00f184392066f00da252797d0
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs fscache-rewrite-indexing
        git checkout 8a43aeca4686a1f00f184392066f00da252797d0
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: fs/9p/vfs_inode.o: in function `fscache_resize_cookie':
>> include/linux/fscache.h:386: undefined reference to `__fscache_resize_cookie'
   ld: fs/9p/vfs_inode.o: in function `fscache_relinquish_cookie':
>> include/linux/fscache.h:305: undefined reference to `__fscache_relinquish_cookie'
   ld: fs/9p/vfs_inode.o: in function `fscache_use_cookie':
>> include/linux/fscache.h:269: undefined reference to `__fscache_use_cookie'
   ld: fs/9p/vfs_inode_dotl.o: in function `fscache_use_cookie':
>> include/linux/fscache.h:269: undefined reference to `__fscache_use_cookie'
   ld: fs/9p/vfs_addr.o: in function `fscache_begin_read_operation':
>> include/linux/fscache.h:483: undefined reference to `__fscache_begin_read_operation'
   ld: fs/9p/vfs_file.o: in function `fscache_use_cookie':
>> include/linux/fscache.h:269: undefined reference to `__fscache_use_cookie'
   ld: fs/9p/vfs_dir.o: in function `fscache_unuse_cookie':
>> include/linux/fscache.h:286: undefined reference to `__fscache_unuse_cookie'
>> ld: include/linux/fscache.h:286: undefined reference to `__fscache_unuse_cookie'
   ld: fs/9p/v9fs.o: in function `fscache_relinquish_volume':
>> include/linux/fscache.h:221: undefined reference to `__fscache_relinquish_volume'
   ld: fs/9p/cache.o: in function `fscache_acquire_volume':
>> include/linux/fscache.h:202: undefined reference to `__fscache_acquire_volume'
   ld: fs/9p/cache.o: in function `fscache_acquire_cookie':
>> include/linux/fscache.h:250: undefined reference to `__fscache_acquire_cookie'


vim +386 include/linux/fscache.h

7f9fc1ee74adf2 David Howells         2020-09-22  183  
2d6fff63703739 David Howells         2009-04-03  184  /**
056daf803e87af David Howells         2020-02-06  185   * fscache_acquire_volume - Register a volume as desiring caching services
056daf803e87af David Howells         2020-02-06  186   * @volume_key: An identification string for the volume
056daf803e87af David Howells         2020-02-06  187   * @cache_name: The name of the cache to use (or NULL for the default)
056daf803e87af David Howells         2020-02-06  188   * @coherency_data: Piece of arbitrary coherency data to check
056daf803e87af David Howells         2020-02-06  189   *
056daf803e87af David Howells         2020-02-06  190   * Register a volume as desiring caching services if they're available.  The
056daf803e87af David Howells         2020-02-06  191   * caller must provide an identifier for the volume and may also indicate which
056daf803e87af David Howells         2020-02-06  192   * cache it should be in.  If a preexisting volume entry is found in the cache,
056daf803e87af David Howells         2020-02-06  193   * the coherency data must match otherwise the entry will be invalidated.
2d6fff63703739 David Howells         2009-04-03  194   */
2d6fff63703739 David Howells         2009-04-03  195  static inline
056daf803e87af David Howells         2020-02-06  196  struct fscache_volume *fscache_acquire_volume(const char *volume_key,
056daf803e87af David Howells         2020-02-06  197  					      const char *cache_name,
056daf803e87af David Howells         2020-02-06  198  					      u64 coherency_data)
2d6fff63703739 David Howells         2009-04-03  199  {
056daf803e87af David Howells         2020-02-06  200  	if (!fscache_available())
2d6fff63703739 David Howells         2009-04-03  201  		return NULL;
056daf803e87af David Howells         2020-02-06 @202  	return __fscache_acquire_volume(volume_key, cache_name, coherency_data);
2d6fff63703739 David Howells         2009-04-03  203  }
2d6fff63703739 David Howells         2009-04-03  204  
2d6fff63703739 David Howells         2009-04-03  205  /**
056daf803e87af David Howells         2020-02-06  206   * fscache_relinquish_volume - Cease caching a volume
056daf803e87af David Howells         2020-02-06  207   * @volume: The volume cookie
056daf803e87af David Howells         2020-02-06  208   * @coherency_data: Piece of arbitrary coherency data to set
056daf803e87af David Howells         2020-02-06  209   * @invalidate: True if the volume should be invalidated
056daf803e87af David Howells         2020-02-06  210   *
056daf803e87af David Howells         2020-02-06  211   * Indicate that a filesystem no longer desires caching services for a volume.
056daf803e87af David Howells         2020-02-06  212   * The caller must have relinquished all file cookies prior to calling this.
056daf803e87af David Howells         2020-02-06  213   * The coherency data stored is updated.
2d6fff63703739 David Howells         2009-04-03  214   */
2d6fff63703739 David Howells         2009-04-03  215  static inline
056daf803e87af David Howells         2020-02-06  216  void fscache_relinquish_volume(struct fscache_volume *volume,
056daf803e87af David Howells         2020-02-06  217  			       u64 coherency_data,
056daf803e87af David Howells         2020-02-06  218  			       bool invalidate)
2d6fff63703739 David Howells         2009-04-03  219  {
056daf803e87af David Howells         2020-02-06  220  	if (fscache_volume_valid(volume))
056daf803e87af David Howells         2020-02-06 @221  		__fscache_relinquish_volume(volume, coherency_data, invalidate);
2d6fff63703739 David Howells         2009-04-03  222  }
2d6fff63703739 David Howells         2009-04-03  223  
2d6fff63703739 David Howells         2009-04-03  224  /**
2d6fff63703739 David Howells         2009-04-03  225   * fscache_acquire_cookie - Acquire a cookie to represent a cache object
056daf803e87af David Howells         2020-02-06  226   * @volume: The volume in which to locate/create this cookie
d5c268fc7cd21a David Howells         2020-02-06  227   * @advice: Advice flags (FSCACHE_COOKIE_ADV_*)
402cb8dda949d9 David Howells         2018-04-04  228   * @index_key: The index key for this cookie
402cb8dda949d9 David Howells         2018-04-04  229   * @index_key_len: Size of the index key
402cb8dda949d9 David Howells         2018-04-04  230   * @aux_data: The auxiliary data for the cookie (may be NULL)
402cb8dda949d9 David Howells         2018-04-04  231   * @aux_data_len: Size of the auxiliary data buffer
ee1235a9a06813 David Howells         2018-04-04  232   * @object_size: The initial size of object
2d6fff63703739 David Howells         2009-04-03  233   *
056daf803e87af David Howells         2020-02-06  234   * Acquire a cookie to represent a data file within the given cache volume.
2d6fff63703739 David Howells         2009-04-03  235   *
efc930fa1d8448 Mauro Carvalho Chehab 2020-04-27  236   * See Documentation/filesystems/caching/netfs-api.rst for a complete
2d6fff63703739 David Howells         2009-04-03  237   * description.
2d6fff63703739 David Howells         2009-04-03  238   */
2d6fff63703739 David Howells         2009-04-03  239  static inline
056daf803e87af David Howells         2020-02-06  240  struct fscache_cookie *fscache_acquire_cookie(struct fscache_volume *volume,
d5c268fc7cd21a David Howells         2020-02-06  241  					      u8 advice,
402cb8dda949d9 David Howells         2018-04-04  242  					      const void *index_key,
402cb8dda949d9 David Howells         2018-04-04  243  					      size_t index_key_len,
402cb8dda949d9 David Howells         2018-04-04  244  					      const void *aux_data,
402cb8dda949d9 David Howells         2018-04-04  245  					      size_t aux_data_len,
056daf803e87af David Howells         2020-02-06  246  					      loff_t object_size)
2d6fff63703739 David Howells         2009-04-03  247  {
056daf803e87af David Howells         2020-02-06  248  	if (!fscache_volume_valid(volume))
056daf803e87af David Howells         2020-02-06  249  		return NULL;
056daf803e87af David Howells         2020-02-06 @250  	return __fscache_acquire_cookie(volume, advice,
402cb8dda949d9 David Howells         2018-04-04  251  					index_key, index_key_len,
402cb8dda949d9 David Howells         2018-04-04  252  					aux_data, aux_data_len,
056daf803e87af David Howells         2020-02-06  253  					object_size);
056daf803e87af David Howells         2020-02-06  254  }
056daf803e87af David Howells         2020-02-06  255  
056daf803e87af David Howells         2020-02-06  256  /**
056daf803e87af David Howells         2020-02-06  257   * fscache_use_cookie - Request usage of cookie attached to an object
056daf803e87af David Howells         2020-02-06  258   * @object: Object description
056daf803e87af David Howells         2020-02-06  259   * @will_modify: If cache is expected to be modified locally
056daf803e87af David Howells         2020-02-06  260   *
056daf803e87af David Howells         2020-02-06  261   * Request usage of the cookie attached to an object.  The caller should tell
056daf803e87af David Howells         2020-02-06  262   * the cache if the object's contents are about to be modified locally and then
056daf803e87af David Howells         2020-02-06  263   * the cache can apply the policy that has been set to handle this case.
056daf803e87af David Howells         2020-02-06  264   */
056daf803e87af David Howells         2020-02-06  265  static inline void fscache_use_cookie(struct fscache_cookie *cookie,
056daf803e87af David Howells         2020-02-06  266  				      bool will_modify)
056daf803e87af David Howells         2020-02-06  267  {
056daf803e87af David Howells         2020-02-06  268  	if (fscache_cookie_valid(cookie))
056daf803e87af David Howells         2020-02-06 @269  		__fscache_use_cookie(cookie, will_modify);
056daf803e87af David Howells         2020-02-06  270  }
056daf803e87af David Howells         2020-02-06  271  
056daf803e87af David Howells         2020-02-06  272  /**
056daf803e87af David Howells         2020-02-06  273   * fscache_unuse_cookie - Cease usage of cookie attached to an object
056daf803e87af David Howells         2020-02-06  274   * @object: Object description
056daf803e87af David Howells         2020-02-06  275   * @aux_data: Updated auxiliary data (or NULL)
056daf803e87af David Howells         2020-02-06  276   * @object_size: Revised size of the object (or NULL)
056daf803e87af David Howells         2020-02-06  277   *
056daf803e87af David Howells         2020-02-06  278   * Cease usage of the cookie attached to an object.  When the users count
056daf803e87af David Howells         2020-02-06  279   * reaches zero then the cookie relinquishment will be permitted to proceed.
056daf803e87af David Howells         2020-02-06  280   */
056daf803e87af David Howells         2020-02-06  281  static inline void fscache_unuse_cookie(struct fscache_cookie *cookie,
056daf803e87af David Howells         2020-02-06  282  					const void *aux_data,
056daf803e87af David Howells         2020-02-06  283  					const loff_t *object_size)
056daf803e87af David Howells         2020-02-06  284  {
056daf803e87af David Howells         2020-02-06  285  	if (fscache_cookie_valid(cookie))
056daf803e87af David Howells         2020-02-06 @286  		__fscache_unuse_cookie(cookie, aux_data, object_size);
2d6fff63703739 David Howells         2009-04-03  287  }
2d6fff63703739 David Howells         2009-04-03  288  
2d6fff63703739 David Howells         2009-04-03  289  /**
2d6fff63703739 David Howells         2009-04-03  290   * fscache_relinquish_cookie - Return the cookie to the cache, maybe discarding
2d6fff63703739 David Howells         2009-04-03  291   * it
2d6fff63703739 David Howells         2009-04-03  292   * @cookie: The cookie being returned
2d6fff63703739 David Howells         2009-04-03  293   * @retire: True if the cache object the cookie represents is to be discarded
2d6fff63703739 David Howells         2009-04-03  294   *
2d6fff63703739 David Howells         2009-04-03  295   * This function returns a cookie to the cache, forcibly discarding the
056daf803e87af David Howells         2020-02-06  296   * associated cache object if retire is set to true.
2d6fff63703739 David Howells         2009-04-03  297   *
efc930fa1d8448 Mauro Carvalho Chehab 2020-04-27  298   * See Documentation/filesystems/caching/netfs-api.rst for a complete
2d6fff63703739 David Howells         2009-04-03  299   * description.
2d6fff63703739 David Howells         2009-04-03  300   */
2d6fff63703739 David Howells         2009-04-03  301  static inline
056daf803e87af David Howells         2020-02-06  302  void fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
2d6fff63703739 David Howells         2009-04-03  303  {
ccc4fc3d11e914 David Howells         2009-04-03  304  	if (fscache_cookie_valid(cookie))
056daf803e87af David Howells         2020-02-06 @305  		__fscache_relinquish_cookie(cookie, retire);
2d6fff63703739 David Howells         2009-04-03  306  }
2d6fff63703739 David Howells         2009-04-03  307  
423c447e7489a3 David Howells         2020-11-25  308  /*
423c447e7489a3 David Howells         2020-11-25  309   * Find the auxiliary data on a cookie.
423c447e7489a3 David Howells         2020-11-25  310   */
423c447e7489a3 David Howells         2020-11-25  311  static inline void *fscache_get_aux(struct fscache_cookie *cookie)
423c447e7489a3 David Howells         2020-11-25  312  {
423c447e7489a3 David Howells         2020-11-25  313  	if (cookie->aux_len <= sizeof(cookie->inline_aux))
423c447e7489a3 David Howells         2020-11-25  314  		return cookie->inline_aux;
423c447e7489a3 David Howells         2020-11-25  315  	else
423c447e7489a3 David Howells         2020-11-25  316  		return cookie->aux;
423c447e7489a3 David Howells         2020-11-25  317  }
423c447e7489a3 David Howells         2020-11-25  318  
423c447e7489a3 David Howells         2020-11-25  319  /*
423c447e7489a3 David Howells         2020-11-25  320   * Update the auxiliary data on a cookie.
423c447e7489a3 David Howells         2020-11-25  321   */
423c447e7489a3 David Howells         2020-11-25  322  static inline
423c447e7489a3 David Howells         2020-11-25  323  void fscache_update_aux(struct fscache_cookie *cookie,
423c447e7489a3 David Howells         2020-11-25  324  			const void *aux_data, const loff_t *object_size)
423c447e7489a3 David Howells         2020-11-25  325  {
423c447e7489a3 David Howells         2020-11-25  326  	void *p = fscache_get_aux(cookie);
423c447e7489a3 David Howells         2020-11-25  327  
423c447e7489a3 David Howells         2020-11-25  328  	if (aux_data && p)
423c447e7489a3 David Howells         2020-11-25  329  		memcpy(p, aux_data, cookie->aux_len);
423c447e7489a3 David Howells         2020-11-25  330  	if (object_size)
423c447e7489a3 David Howells         2020-11-25  331  		cookie->object_size = *object_size;
423c447e7489a3 David Howells         2020-11-25  332  }
423c447e7489a3 David Howells         2020-11-25  333  
423c447e7489a3 David Howells         2020-11-25  334  #ifdef CONFIG_FSCACHE_STATS
423c447e7489a3 David Howells         2020-11-25  335  extern atomic_t fscache_n_updates;
423c447e7489a3 David Howells         2020-11-25  336  #endif
423c447e7489a3 David Howells         2020-11-25  337  
423c447e7489a3 David Howells         2020-11-25  338  static inline
423c447e7489a3 David Howells         2020-11-25  339  void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
423c447e7489a3 David Howells         2020-11-25  340  			     const loff_t *object_size)
423c447e7489a3 David Howells         2020-11-25  341  {
423c447e7489a3 David Howells         2020-11-25  342  #ifdef CONFIG_FSCACHE_STATS
423c447e7489a3 David Howells         2020-11-25  343  	atomic_inc(&fscache_n_updates);
423c447e7489a3 David Howells         2020-11-25  344  #endif
423c447e7489a3 David Howells         2020-11-25  345  	fscache_update_aux(cookie, aux_data, object_size);
423c447e7489a3 David Howells         2020-11-25  346  	smp_wmb();
423c447e7489a3 David Howells         2020-11-25  347  	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
423c447e7489a3 David Howells         2020-11-25  348  }
423c447e7489a3 David Howells         2020-11-25  349  
2d6fff63703739 David Howells         2009-04-03  350  /**
2d6fff63703739 David Howells         2009-04-03  351   * fscache_update_cookie - Request that a cache object be updated
2d6fff63703739 David Howells         2009-04-03  352   * @cookie: The cookie representing the cache object
402cb8dda949d9 David Howells         2018-04-04  353   * @aux_data: The updated auxiliary data for the cookie (may be NULL)
056daf803e87af David Howells         2020-02-06  354   * @object_size: The current size of the object (may be NULL)
2d6fff63703739 David Howells         2009-04-03  355   *
2d6fff63703739 David Howells         2009-04-03  356   * Request an update of the index data for the cache object associated with the
402cb8dda949d9 David Howells         2018-04-04  357   * cookie.  The auxiliary data on the cookie will be updated first if @aux_data
056daf803e87af David Howells         2020-02-06  358   * is set and the object size will be updated and the object possibly trimmed
056daf803e87af David Howells         2020-02-06  359   * if @object_size is set.
2d6fff63703739 David Howells         2009-04-03  360   *
efc930fa1d8448 Mauro Carvalho Chehab 2020-04-27  361   * See Documentation/filesystems/caching/netfs-api.rst for a complete
2d6fff63703739 David Howells         2009-04-03  362   * description.
2d6fff63703739 David Howells         2009-04-03  363   */
2d6fff63703739 David Howells         2009-04-03  364  static inline
056daf803e87af David Howells         2020-02-06  365  void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
056daf803e87af David Howells         2020-02-06  366  			   const loff_t *object_size)
2d6fff63703739 David Howells         2009-04-03  367  {
b4a0c0e0a13cea Jeff Layton           2020-07-30  368  	if (fscache_cookie_enabled(cookie))
056daf803e87af David Howells         2020-02-06  369  		__fscache_update_cookie(cookie, aux_data, object_size);
2d6fff63703739 David Howells         2009-04-03  370  }
2d6fff63703739 David Howells         2009-04-03  371  
9d8038c4821d31 David Howells         2020-02-06  372  /**
9d8038c4821d31 David Howells         2020-02-06  373   * fscache_resize_cookie - Request that a cache object be resized
9d8038c4821d31 David Howells         2020-02-06  374   * @cookie: The cookie representing the cache object
9d8038c4821d31 David Howells         2020-02-06  375   * @new_size: The new size of the object (may be NULL)
9d8038c4821d31 David Howells         2020-02-06  376   *
9d8038c4821d31 David Howells         2020-02-06  377   * Request that the size of an object be changed.
9d8038c4821d31 David Howells         2020-02-06  378   *
9d8038c4821d31 David Howells         2020-02-06  379   * See Documentation/filesystems/caching/netfs-api.txt for a complete
9d8038c4821d31 David Howells         2020-02-06  380   * description.
9d8038c4821d31 David Howells         2020-02-06  381   */
9d8038c4821d31 David Howells         2020-02-06  382  static inline
9d8038c4821d31 David Howells         2020-02-06  383  void fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
9d8038c4821d31 David Howells         2020-02-06  384  {
9d8038c4821d31 David Howells         2020-02-06  385  	if (fscache_cookie_enabled(cookie))
9d8038c4821d31 David Howells         2020-02-06 @386  		__fscache_resize_cookie(cookie, new_size);
9d8038c4821d31 David Howells         2020-02-06  387  }
9d8038c4821d31 David Howells         2020-02-06  388  
2d6fff63703739 David Howells         2009-04-03  389  /**
2d6fff63703739 David Howells         2009-04-03  390   * fscache_pin_cookie - Pin a data-storage cache object in its cache
2d6fff63703739 David Howells         2009-04-03  391   * @cookie: The cookie representing the cache object
2d6fff63703739 David Howells         2009-04-03  392   *
2d6fff63703739 David Howells         2009-04-03  393   * Permit data-storage cache objects to be pinned in the cache.
2d6fff63703739 David Howells         2009-04-03  394   *
efc930fa1d8448 Mauro Carvalho Chehab 2020-04-27  395   * See Documentation/filesystems/caching/netfs-api.rst for a complete
2d6fff63703739 David Howells         2009-04-03  396   * description.
2d6fff63703739 David Howells         2009-04-03  397   */
2d6fff63703739 David Howells         2009-04-03  398  static inline
2d6fff63703739 David Howells         2009-04-03  399  int fscache_pin_cookie(struct fscache_cookie *cookie)
2d6fff63703739 David Howells         2009-04-03  400  {
2d6fff63703739 David Howells         2009-04-03  401  	return -ENOBUFS;
2d6fff63703739 David Howells         2009-04-03  402  }
2d6fff63703739 David Howells         2009-04-03  403  
2d6fff63703739 David Howells         2009-04-03  404  /**
2d6fff63703739 David Howells         2009-04-03  405   * fscache_pin_cookie - Unpin a data-storage cache object in its cache
2d6fff63703739 David Howells         2009-04-03  406   * @cookie: The cookie representing the cache object
2d6fff63703739 David Howells         2009-04-03  407   *
2d6fff63703739 David Howells         2009-04-03  408   * Permit data-storage cache objects to be unpinned from the cache.
2d6fff63703739 David Howells         2009-04-03  409   *
efc930fa1d8448 Mauro Carvalho Chehab 2020-04-27  410   * See Documentation/filesystems/caching/netfs-api.rst for a complete
2d6fff63703739 David Howells         2009-04-03  411   * description.
2d6fff63703739 David Howells         2009-04-03  412   */
2d6fff63703739 David Howells         2009-04-03  413  static inline
2d6fff63703739 David Howells         2009-04-03  414  void fscache_unpin_cookie(struct fscache_cookie *cookie)
2d6fff63703739 David Howells         2009-04-03  415  {
2d6fff63703739 David Howells         2009-04-03  416  }
2d6fff63703739 David Howells         2009-04-03  417  
ef778e7ae67cd4 David Howells         2012-12-20  418  /**
ef778e7ae67cd4 David Howells         2012-12-20  419   * fscache_invalidate - Notify cache that an object needs invalidation
ef778e7ae67cd4 David Howells         2012-12-20  420   * @cookie: The cookie representing the cache object
d8d6f8e68e17cd David Howells         2020-02-06  421   * @aux_data: The updated auxiliary data for the cookie (may be NULL)
6b97c8850f9876 David Howells         2021-10-04  422   * @size: The revised size of the object.
d8d6f8e68e17cd David Howells         2020-02-06  423   * @flags: Invalidation flags (FSCACHE_INVAL_*)
ef778e7ae67cd4 David Howells         2012-12-20  424   *
ef778e7ae67cd4 David Howells         2012-12-20  425   * Notify the cache that an object is needs to be invalidated and that it
ef778e7ae67cd4 David Howells         2012-12-20  426   * should abort any retrievals or stores it is doing on the cache.  The object
ef778e7ae67cd4 David Howells         2012-12-20  427   * is then marked non-caching until such time as the invalidation is complete.
ef778e7ae67cd4 David Howells         2012-12-20  428   *
d8d6f8e68e17cd David Howells         2020-02-06  429   * FSCACHE_INVAL_LIGHT indicates that if the object has been invalidated and
d8d6f8e68e17cd David Howells         2020-02-06  430   * replaced by a temporary object, the temporary object need not be replaced
d8d6f8e68e17cd David Howells         2020-02-06  431   * again.  This is primarily intended for use with FSCACHE_ADV_SINGLE_CHUNK.
d8d6f8e68e17cd David Howells         2020-02-06  432   *
d8d6f8e68e17cd David Howells         2020-02-06  433   * FSCACHE_INVAL_DIO_WRITE indicates that this is due to a direct I/O write and
d8d6f8e68e17cd David Howells         2020-02-06  434   * may cause caching to be suspended on this cookie.
ef778e7ae67cd4 David Howells         2012-12-20  435   *
efc930fa1d8448 Mauro Carvalho Chehab 2020-04-27  436   * See Documentation/filesystems/caching/netfs-api.rst for a complete
ef778e7ae67cd4 David Howells         2012-12-20  437   * description.
ef778e7ae67cd4 David Howells         2012-12-20  438   */
ef778e7ae67cd4 David Howells         2012-12-20  439  static inline
d8d6f8e68e17cd David Howells         2020-02-06  440  void fscache_invalidate(struct fscache_cookie *cookie,
d8d6f8e68e17cd David Howells         2020-02-06  441  			const void *aux_data, loff_t size, unsigned int flags)
ef778e7ae67cd4 David Howells         2012-12-20  442  {
b4a0c0e0a13cea Jeff Layton           2020-07-30  443  	if (fscache_cookie_enabled(cookie))
d8d6f8e68e17cd David Howells         2020-02-06  444  		__fscache_invalidate(cookie, aux_data, size, flags);
ef778e7ae67cd4 David Howells         2012-12-20  445  }
ef778e7ae67cd4 David Howells         2012-12-20  446  
ef778e7ae67cd4 David Howells         2012-12-20  447  /**
056daf803e87af David Howells         2020-02-06  448   * fscache_operation_valid - Return true if operations resources are usable
056daf803e87af David Howells         2020-02-06  449   * @cres: The resources to check.
ef778e7ae67cd4 David Howells         2012-12-20  450   *
056daf803e87af David Howells         2020-02-06  451   * Returns a pointer to the operations table if usable or NULL if not.
ef778e7ae67cd4 David Howells         2012-12-20  452   */
ef778e7ae67cd4 David Howells         2012-12-20  453  static inline
056daf803e87af David Howells         2020-02-06  454  const struct netfs_cache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
ef778e7ae67cd4 David Howells         2012-12-20  455  {
056daf803e87af David Howells         2020-02-06  456  	return fscache_resources_valid(cres) ? cres->ops : NULL;
ef778e7ae67cd4 David Howells         2012-12-20  457  }
ef778e7ae67cd4 David Howells         2012-12-20  458  
26aaeffcafe6cb David Howells         2021-02-22  459  #ifdef FSCACHE_USE_NEW_IO_API
26aaeffcafe6cb David Howells         2021-02-22  460  
26aaeffcafe6cb David Howells         2021-02-22  461  /**
26aaeffcafe6cb David Howells         2021-02-22  462   * fscache_begin_read_operation - Begin a read operation for the netfs lib
a2872465a68c9b David Howells         2021-09-14  463   * @cres: The cache resources for the read being performed
26aaeffcafe6cb David Howells         2021-02-22  464   * @cookie: The cookie representing the cache object
26aaeffcafe6cb David Howells         2021-02-22  465   *
a2872465a68c9b David Howells         2021-09-14  466   * Begin a read operation on behalf of the netfs helper library.  @cres
a2872465a68c9b David Howells         2021-09-14  467   * indicates the cache resources to which the operation state should be
a2872465a68c9b David Howells         2021-09-14  468   * attached; @cookie indicates the cache object that will be accessed.
26aaeffcafe6cb David Howells         2021-02-22  469   *
26aaeffcafe6cb David Howells         2021-02-22  470   * This is intended to be called from the ->begin_cache_operation() netfs lib
26aaeffcafe6cb David Howells         2021-02-22  471   * operation as implemented by the network filesystem.
26aaeffcafe6cb David Howells         2021-02-22  472   *
26aaeffcafe6cb David Howells         2021-02-22  473   * Returns:
26aaeffcafe6cb David Howells         2021-02-22  474   * * 0		- Success
26aaeffcafe6cb David Howells         2021-02-22  475   * * -ENOBUFS	- No caching available
26aaeffcafe6cb David Howells         2021-02-22  476   * * Other error code from the cache, such as -ENOMEM.
26aaeffcafe6cb David Howells         2021-02-22  477   */
26aaeffcafe6cb David Howells         2021-02-22  478  static inline
a2872465a68c9b David Howells         2021-09-14  479  int fscache_begin_read_operation(struct netfs_cache_resources *cres,
26aaeffcafe6cb David Howells         2021-02-22  480  				 struct fscache_cookie *cookie)
26aaeffcafe6cb David Howells         2021-02-22  481  {
b4a0c0e0a13cea Jeff Layton           2020-07-30  482  	if (fscache_cookie_enabled(cookie))
056daf803e87af David Howells         2020-02-06 @483  		return __fscache_begin_read_operation(cres, cookie);
26aaeffcafe6cb David Howells         2021-02-22  484  	return -ENOBUFS;
26aaeffcafe6cb David Howells         2021-02-22  485  }
26aaeffcafe6cb David Howells         2021-02-22  486  

:::::: The code at line 386 was first introduced by commit
:::::: 9d8038c4821d31fb8928f85f9f708ae7e831b775 fscache: Provide resize operation

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Ug8y5Mn/vhHr8evj2zvEaiarF9eXg5l7vxBGbhxbBUzNqSPLUgTBcu1ixKF4gvQb/5m2ji7u
0rEbSxJdz/pC4znWRz9lokc8HyPavbfaO0sX6T2xzU37eYH1szsdEbJLsRGxmLRvsAi8aaMv
FoE/hRpu54B4Srhz2djpu/kZO5PiKpZq2ulXRf4XG8+mY1sl9zHiGusuuyHEyLFHccPFvmHh
xLCelB8iOzD706q95G49DLHm5tefGfG8Ehv5ZVJod43UWRBdZOx4FlFMImuqZP5yHThYmZfW
p4tLMx1iYnivkOHtrawOjNMQGkz37amTowl5DWSUWk2om+lQUjWwJgnbbhb2yEoidHn0/Mlo
EbKlu6gR6tJJLHLdZG7gLTCiixLh1hNZwqzyf4odsT2BFkoZI+WQu+wwyKJueSWHF0zPwB7X
quFcdEDYS5taXtb9R1nDxTeLl9f3v2+YOHU9Pdx//f3w8vp4//WmGYf775Fc9OPmRJZMjDR3
sbCGX1mvTJdMPdGx2zSMxCnGXuGyXdx4np1pR12hVN0vlCKLLrHHCsyyhbXEsmOwcl2M1opq
o/TTMkMyRvZYX/pU68yw459fSzZ2n4p5E+BLmLvgxifMHfF//T99t4nAYhbbdZfeECS614TS
Mrx5+fr8oxOXfq+yzMxVELCtQ1RJLLXoriJZm2GC8CTqdc36E+vNny+vSgCYyB3e5nL30RoL
Rbh37WEDtM2EVtktL2lWk4Cq/9Ieh5Jop1ZEayrCWdKzRysPdtlkZAuivb+xJhSCmr1ciTnv
+ytL8ksv4kC7soawlOLdyViC1dazCrUv6yP3rHnFeFQ2bmIhkywpkr6/opcvX16+Sn9Cr3/e
Pzze/JoUq4XrOv/Cw1pbS+NiIgRVLiKjT0Rx+e3m5eX5DWLuiYHy+Pzy7ebr43+M4W6o5cTH
PL9rtwl6pUEp4chMdq/33/5+enibaqWynebIR/wAhy0WobEJeTwh+EuT1EeI00gqsrVJ4ym3
CBCV0KKd7FTJdptGiRFZXtpM7RpNGfO0Yy2rwwlBamjuqqOunQksfk4biIxXaqHSYz3ms/gh
396EfJYakDYWTXC8DPHqdcVO4MpgBjzJtnZUTQ10yHkXrf3DFyy5+ETOG4hSWmbl7q6tky2m
cwcJtlJzd3BzZhZVMctTUitFOrH1mp9TgCxhMjYkOLBMcuJDWcniVpxRY9AXyyEm7aRZoiQy
aU1jteipZvlYcxOJ0ndJ3vI9KPF13B9jCK7u/ftGrLbW1aCWgYwvvRfSnm9mrEJgZ46/tLtA
xmW/VPL+a0NEMJvg7CcYLUYWVUwl6tS5ccvaP3xrZPOrNYsTwtIY2GJyUsHkgV2Ux1PCjkQX
pxtnZbWSoLQyhn1b1WWYfPjllwk7YlVzrJM2qWvdFd7IL/OqTjgnAWAdWDVD135+/fL7k6Df
xI9/fP/rr6evfxkrY5/qLLOjewcwtN66CWnznFAyHHD8LJZi8NOlEpThxyRqCO3MSRqx0kSH
NmY/VZbdEVcJGLNFFpcpKivPYmKfwPlezSIVKfJKedX3T2HGikObnMRI+xl8fSzAdVpb4W8L
SHea3Vy9vvz5JOT43fenz4+fb8pv709iA70HPXZrKsM36+T2CJqvvb89kBYW0yErm73HOCgG
hp1yLyetXY68Sor4g5BKJsh9wuomTFgjd576xDKATXFimCd5NZZNyGETDOxHfR3CI787s7T5
EGDl42L516swAchIvlkKY/JYq9XfQdp9rn2NtXmX5PZaeBI7FTkGTvl5t8XiOMmFO2dGpAig
HePMJDDeWDvuju1cO9ntxUqmIrXBtm7SK1ZIMaQ7Crx9e77/cVPdf318frOXEAmlzATJGqtU
5zROIFoRb8/cXdrPzYNNhvF5vZhhncY7a/dUOQ8cowajrBq+Pn3+63FSGWVSlV7EPy7rwPaS
ZBVompuZWdIU7JRifpRk2UvRSGarR2ktRPH2Vsgg9vDZ5Y579IjHTwCoV6+YCIEKtpqA2l8C
b7XGnZP0mDRLNy7hoEXHeETsLB2zJEyEe0yeLtzAuyXcxHWgOqlYRYXg6zC8WVPmyBpk7a3o
fe4Ulhf5AEoidke85WTL3okiUn2dJTsW3dkCbhNvaZmodlzMKbds2MBZ2ONDTPeZoTGz8qQz
6djJ8l8wmWZlDcHa5YrZgktMeQRRz96v918eb/74/uefQkyLB7msy2ErzoB5DAFoxskraEXZ
pNs7naT9u5OVpeRspIpj7apS/JZOZk8JRwwn4btbsNPIslpIHRNGVFZ34htswkhz0RRhlppJ
uBD0h7y+WIwhL5sx5qV1IpSqrJN0V7Ri80xZgbR7/0XDyAcaINmKpTeJ27Q0ipeXcdJJ+9xg
NGkmCyCmxg7tsL/vXz//5/71EdPFgBaRCxU6cAS3ynGNHkh4JzYJl7KYFgBW4yIbsMQhQ7TL
/6XsWp4bx3n8ff8K13fYmjnMfn7EsbNbc5Ao2eJYr4iUH31RZdLuntSk41SSrp3+75cg9SAl
QO69dMfETxQFvgAQBIhgp9BFQpJEpanOsAgsilTCUHH4qQtsfoUb5zonjNQbwilJ0SJiLioS
BDiGW10k78Qs0OHeKLoxBlDUgu9JGl+huTOBsrYNs3VBtZUbhwe60Ln2qgrjcD1d2jlgoI+9
Qk2JDK6v6uhvTiPA3kC1MPFkkZFfPqKuweCQp96C2aOSDMddb4AyWP4cKrGowvChOygNMzX5
OTnGdyciRZyiLajtAl6ZZUGWkSNyL9e3RMAAWA2UrBTS84q61alnOlmpGgUJJy50KvI2zAid
CHibCFbSH6uEX3KQ+2qXPsqbJb3C1AF3yEEYqkGYZgnZODDHz9E82DD1tRTQG/RGNCM/VsAJ
Eu5FrHmx6jtZNr5d2A6rF2r/4fHv56evf31M/nMSs6C5b9/ZMNsXKGrFYk9AAsA9RxMT+B7b
xXwbSQfohEdtETsZzAlftg5ExRzpEDon4xXMPcuS6qAk3is44UUeEYDUemGQr9eEj10PRbgx
dyjwxltMr71Ro3D3dQuUr5dEJLkOREY2surZL+fTVYyHLexgfnA7IwaixYSCHVmaoiPyyriz
rMaQ8sM6XIiChDdyCLu8vF+Ukv251rKMBIKEhdjqGAYiiy0ZMgm6wk610ub/AdYpVv/HZZKK
39dTnF5kB/H7fNnO9cJLQr/cQITyQc0IUU0bqYTEKi+U9FecxrFFJhsTdLcUoHXWcp/0diHY
pnF323GGWotBtsWTtg9OQbpnRFamzhTUfRjxYNhhEbcOyNWPLuO4LMJ0KyMrxTEPCu/Q/S4H
z27DNCx0kgRzdvh6foQTSngxIrLCE94NRKlHR7cmM1Zqw8UIoijxyaip5JrVUjmue2q6IMRp
TSyVFoFvWJqNYbzjuGBkyGD92uC+3hrAt36YjiHgeKfAJShD5urXCD3TaW1H6OXWo8mJx7w4
Hqle+/vR5HxOXVPQZMVbySG8oD9dEvdDNO6kTe8kXQ3YbZYWXNCDIEzEGJfD2KN7ESIIZfi+
acj4HqBpn3Yhzb2NnBMbn5lmic+JYLaaviEMTpoYZwXPRgZ2lMUyxIVLIO+VNhMHeNxJXb+8
XS/ocaO+enxC7050X5UM7IC4nA70gxeraTXS9PAgsnSkgu2pGGRTcgCcUacGmipp2h+eT0g8
QJUHnkYjI20XpoKr5XikaTHT2ZwQYVFTQzczvS5Ksz09QoHVo4uz1pkSNZToj05UhxQjbU68
00bJr/Q71D6qpzBdA2dFBrluaEQGhxojky0pY8nHB2Uq6QGfKk0NP/gCalaMTabcSyGnlJqS
9GzOw1QxmdAEDUB68Smld8Fc7QQg+ZF0tcZBN3HidlGNOQk5Pjm0GEU3owAlbmT2FBljHv2Z
arcaY6XwElES6bc0PUzGnx/bLHVy+X7CPBchQ49edBU1jIWSjQgbk8aUaR6PrMtU/lW9bsGx
jidGNlyjA1fj01UoKVj+kZ1G26H2ZXrRUMuvCAn1T9MjtYrRfJJRUQqZKE2EOFnQuwCIoVVO
2Ig0Yr75FBI2G7NPjG3bB86TbGQlP3I1IUkqvHiUf59OgRJaR6aRyedYRSUeX0ELn3FOvyBR
wtUgp2lzVQwRyZvELriCAGG8BoJ+bhv7a4RxFnIq8y/q/fnb5ePyeHnGVAAdYszHh4uOHzYc
rvWHXHlFH+aEGASvFfdb25eC04tRK/qhtS2PF+fZhuC8xfqELGK8Aqu+Ug3NGYLLucFpCBT2
0/pCWQwqpdpqbP0Tyss45xWV4NlUlqZUfhCgewWLqsgTVcTcXnXfDzk8nEZ6aar2JRZWaXio
DVDtQZMbugF6YRDLUQe4qxPgwVkIF7L/aRtVMU+51FtHb+20ayFDEeoOkPimUNPA8ScomYw5
4XHS4AIudL7S8KgWpxQSm5ZYvqK6q4Tuq21Y6HRIJmipzbvOJcOkTv19/h/OuE8bJVqP4Mv7
B1gMGvfNAJ9J7HZ1nE6hG4l2HWEsQi9/cx/U5YG/ZWhkyBbRy+Jil6seSkNBZF/ogHV8OeIl
Yde8fmkBp4eK4ZXszRRNlRLGoFAacYBQkWbr8o3A1Xe7KWiT3aFxLOezaZT32e6AuMhns9vj
KGajBpmqaRSjxKvFzXw20sUZysOs/ZwhL7KxT7XXGWLwiHg9G7TIQRRrcJC+W42CoAU65l/S
kxHbWVCnwGTPD+/odXQ9r/o3wO0FrNDuTST9ENDPymSYmzNVQsJ/TzQLZFbAqdTn8yt4Ok8u
LxPBBJ/8+f1j4sc7WBwrEUy+Pfxo7iw+PL9fJn+eJy/n8+fz5/9RlZ6dmqLz86v2s/8GAXKf
Xr5c3IWzxg36whQPHQMRDJivlEDcDZS6QK9NedJfRtuqPeltPFw0sXEbJZJSUpaN4yIYhIFC
YOpvQjewUSIICiIpfB9GhMKxYX+USS6i7PprvdgrA1z2tmFZGtJqpg3ceUVyvbra+FWpDmHX
+0Otz1Xp386JYCp6hrvrdzvx+LcH8GvEwiXoRSlgY0FstYZOaV4KwEcyiOhdLUjFaBxf/RK9
hASEn4IWEg5EsrWaSMfABV84HoR0h8DqvnLtdS3vQB6kFqtSiNUcO/7X/aa0RTu/dVfWmtl/
ILR+nAWL5PGCgQSDE4vdwrkNatGMLRslsWhxM0Mph0ip21HoSZQKQdDBuh/G4VA4aurO1XZ4
xEn10E/WKDlM8nCLUjYy4IpHGUrcc6V3oRSee/c4AceHwZb+roboZNmz27ieze2bei5pucBZ
stVH+0TrD3h5WaLlu/Akci+t8sAbo+O0WOBftct8roYnw3mSMKm0duKr9ek/TsnEamXfzOzT
wGvZK4YKloVZ3xDPH0uyC1NvnxAMyOP5wo5UYZEyyW/XS3zI3jOvxDv2vvRi0AdRoshZvj4u
cZq3GQoIHUkxRunslBzZLidhUXgHXqiJaid/tCGnxM9i4kWu3RSbyH5Y/OGxHVr14UAwOcv1
SSxKSlIOceypxxjx3BHMLlWCP3jgIvKzFF86hSidm9F230l8RJd5sFpvpqvFlODbEbPj2+sn
CHi2iugq3MSGEyaciJNeU4nkO1qyDkpJnLSadu1FSCvacbjNZP94wkWM6AbNcs9OK0YkfTUw
MKbTIicPaPOn1sBgcyAP/DQT4MQ4UPu90thRkAZUyUZpl56QcIeOcFbTPONC/bcnHBM1U2ie
SPDkC/fcLyAVDP3N2cErCj6CIK/aGD1YhNLoZRt+hHtQI1IQuKJsDiTgpJ7GPLT0ez7pDjjO
+/MBdH71/3w5O9IybiQ4gz8WSyJaqQ26oYJSa4bzdFepztVRnkb4ono2E70T3HYu5n/9eH96
fHiexA8/nMu2bRVplutqjizkeJx8oILNrtqPmfZA8lwQNzRGWtJ7jacEEuwqpzzloeXErX9W
kuXONZq2lGFLvaFuoG/ssBumuGTCtUao3xVjqOIKJDfFcP1inbNyfRw2KQoWQvTjSPcwQqqW
zXq5edt+lD9ez78xE4rn9fn8z/nt38HZ+jUR//v08fgXZkc21UMOlJwv9Ncv+xEVrW76/76o
30Lv+eP89vLwcZ4kl8+oe7hpD1ztjWXfwII1hajRnrIFODuZe8b9SQskUV9jBsMf0qGJHckk
gSzQcWZLAW1RY9WdL9sLzjrBROn1EkGpB/pT1spZYdJW/IQhFeqhzCdAE0HEuNtOXVRBnhil
0AiR2X79HT3vP6ZUuCzSjEDQ9Vh3mlXXE8sNvscB5uALIssx8IdvkmqETuYTVTTmr6j8soq6
15mpEiJDs0aUEMCGJJciop8t1ZfzWzWqMGVZN+4+YgN2ReKe5kQmIu7r7D8kJpG4zSIJE6Hk
yB3SFjgJAeN/16P6KED76NoGta60ov0fLJB2UWBZnGFiocb5Bey+KUhJ0QG2p3SrjeEmgGeI
OuDpBz3iOrUm6iy7eKd1dFyibOi3RIIHTYcMjL0KbDJsgHavmjohhzS+g7d0IkdgTV9Oiasc
NcfDPeRW4vjpQNduwgm4BdwSGZ01IPDYbH4jpkSsa1PJAbPFa1KXD7fPHj+Yr4kMD5puVmUh
biirq2GSXCyJHAHmcIt5kMdwBBCz5d1sjM8wdpb/0PRM9lrYG8raPP7n89PL37/MftV7V7H1
J7Xv+fcXCEmAnHZPfuncEH4dTAYf5D98cdX0JD6ynBDKG0BBqEGaDpeyaWrK2Wrtj/DMZECv
j4cHvDFxZSE/hry8KXHBnfYt++Tb09evTvQX+7yyv3Y1x5hwG9sydjk0pRmDnZygKn1pR1Ta
3jwnHm093Ak6y8vBstrQPCb5nrt3jDBcvcigLa+Pp7vT2KfXDwjK9T75MEzsxlp6/vjyBFIT
xNn58vR18gvw+uPh7ev541ec1VqHE3BXk/o8nWmSIOZeqm3A+NenoQxCXLXo1QLu3ti9RpeZ
kKZqsNa034Fy2UhD3Oex6gUr5s1sdlLblVpf49Dy0m88xh/+/v4KLNTe8e+v5/PjX07Sizz0
dmXPx7NzbsGebl7M1b+p2vRT63C0K9NTUy37I0TzQSMPh4kdxKclZilEooO/cm9rLncOQV4Q
1APiCrkyxI0jUFjIREYMtyhYIHbc+vgeaoF4ERDHUGqZu7GQ1yrKGFmThdqbm8T5vg9GWpZn
3LeHY59WMWzrHKCMGQ3no4XQh57j9YkiRweGKpdUQ6m9oIfBrRAWqJAFiC2cui7Yh6o696ij
cKikkkpJFeBMI1hRWhe9NWngqwSlPYy5VQ9Xot0RqomUYlUTGVyNTphjtdakbYQ6/5j26nhd
3/plKzsIqi4MV8fjsGw575fx9Xy9WubD0rvVcoB1g5vWZfNhWbiYDUuPi3Uft7wZPrtyU062
jbztI4v1/Hb4+BJp4nKGvGZhlxVS9SW3RgAUJGx2c7uerYeURsWxiiKmtKwTXthcWPzX28fj
9F82QBFlFjH3qbqw91Q7RgBCDa36O6pdCY5kYCFwvzHdm2Xb5NiTSgltAohYAhIAleC8aYd1
vzwvMoYU9wKo2eVVyUMd1wydsvqLij1u0QAfRGgpotI1z3m+v/wUEi6yHSjMPuHeEh3kuKby
29aQQJA3ZW0Ikd3IgtyuiByuNSTxjrd3VFr3GlOIJVtcqYeLeEYlfHIxRMbzBnRUEFx9axA5
26yXVFJ4GzMljjUc0OJnQD+DIfI2toy+mUkiSVMD8e8XcyKtcI0Qi+Xijrhx22A2yWJGmBfa
DlXjj7A7WZDlmsgybNVCBM9pIGGymBL5+9pa9goyPm4AQhhEOsh6TRxTtLwL1IxaD+Y9mOeu
zHvoOkJvdyBXJ+OCsCE4kHGOAoTIROhArq8dROIzZ2GY4UeXLdfvVlQm6naM3FwdRrC6EKnD
3FVqnHlqEs5nV5aFhOUrN0OYvYnMlYwD0mXe3tCGwQGq/09sDoFYzK8MUtPCn5gOd4TjVMfV
215uVN2i/Pnh48vl7Vuvqb2HWZKJ/v5Zj4k5EVfKglApLG0IERfB3pXWy2rjJZy462ohV4Sl
s4PMb4ijx3biy91sJb0rI+xmLa98PUAW47MTIESqvhYiktv5lY/y728oc2M7BPIluzL3YCQN
B8nl5TeWl9dG80aqv6bIGAOrnzDprK5Usc3iYMNdM3wNUapod7WhfbArHcqdJrad0mAH8bVU
YRWmWye+FpTVwU+01T4NY+FS9UmQ9W5w0i081TlbSk0GAy9XRFstylkEtdmaVR4fK0ot14E8
IqikSrYJrlZ2GIxvB6ibVa7qUpfarWiA1EmMoodUK2saPIsFSYlEqb/ZYp5QojptigDGxT1y
253s+en88mF1pydOKavksf8O9RMV21W5X26GF2F0NRseO+FbxEGXow0t65pQlmhSlWT7sA7c
NgYbCSBrAE0sViJWnQFFoUdcR2tqAa2pguujeB7cHmessV4ex7xtcgh3h3R86Th48qxifOOc
UauiXE/8MOUFfkoImAACMw8xFsKzHSSgQIQFy8TCLYQLMl1sDIuQhvI4aFhRCvSmk6IlG7Ug
u1VEe6vqtqL9Br3upT6k8k+5PlL0Um9rW/RhFVKrId87ZwAQf3FbGq25rV1p0kWmljKl9O9R
w4yJYOrWXfMh5v6gPAnT0nplC8YrGIRtbIh4cO+a6kOIcNv3ry7naV7KYYsS19xtFTcxEpsr
b/QrYWkSkQexYEyMGKfGIMfWzX2UCVnxTMY2m6Cw97PPNF3mOD6aIsFsh1xTthfG16JrjC6G
m/SivqRYs3mwiCVPj2+X98uXj0n04/X89tt+8vX7+f0DCSzTBN1yftfHSD96paXksRhguy6z
UkKPv777pG0RnijXKbVxhUQIC7VIgYke6Znj+ra9ImVdd2xWKrVLV4fEYrX6UflJ5iw8Uekd
Qo1DXpAck7qGboELvfs+uiUeuZclg8o6BvCt559kSLzNY2ERBU7roKhqfH2JR/ot9JJATTx8
n/ICJdEe/FL2wlY0ZO0ruU1sv2cIuVPFXi6zvFc49EE2xTbLdUnqu4VhGOZsUKcp7X2M28Vm
KYTrmdgesyn/4FIJGP2Km3IJVy2s2bjNFaPUtAulUiesZSjKzT0Iux3Nt1ZRJntOht1TzkdK
prSsqVsGYfcKaV0hMRfLVa2BZ8cqhcPwXe4FA58jh2BkhY3H4DiPimOAPPETuDLV/uhwpIh8
qovVsYC7aecSDbsUm+PY3h9aUIzOBLTXeyk/jGyoj0ZEPlfCg3rIPTdy6DHqV9+vxPGjrP0y
vAL+mk3vcJ2qRu1i+GtxQ1g6DSpPGH2zykBgjRJ+XG0O4JLuEUEPOqyMyjQICz+LMX9Rg9PR
jfbOobYh7H2Z9svUv9PpdF7t+64+hswiGYDbWpUfCvX02Mdq8z7PGdmuQgxapONdqJLUiRSc
CD5Yh5nR27S7FOauVEcfGawGTfm9Hcy1cT7zZVVsdtxO0dSQIjNDuyFcl1NruRr8LMkdETBu
WoM8oARnT0dC6hrc7YAnIcNkdTuIgdA2JVebZIE8CVYp7amm2KsgqeTUiEqU6jly3bgeGy4L
6i5jJakqWgi6bpgVMAXt2cuiIoMMD/VT+NqWqH3AS7PRhouyUCukVZOj0hnigtyxm6cX1XDP
REA63FOV5UW4paLyNOBtjvdDQ1cLZx6jx2ftFxVZ0yxnsNRkb6vkrW3/JkKzWSktoWKx5QTU
lEBKidyzU+0Y16YabWw1z5fHv22fL0geU5y/nN/OL4/nyefz+9PXF8eswxnhuQ9vFPm6f57Q
hGT8uRdZMyzZTW/WhCW1+xAwCd/dEI5+FkzwJRW9v4da/gyK8JG0QCxg4WqKWxJtmE5ZVjE8
sJoFpGLIHpXIkB6rPcM9TaODyHkKvt4DbcN0ibh8f3s8D83E6p2i0Efhy4U1guJduJf9Uv2z
0j7mNtKPgxbZGwi9t1oLgcdjP8NusnDFi1JtEVagFFPUOU6YBGbnF8j6ONHESf7w9ay9yibC
ukjQRPm8ArVGvX6TkdLwFaxBGKc2rZ3KgjN0Kx9AY++To3S7CDApSLWKllvcl7le0fVHIAuE
0fc0GVHsB4+Zs/rzt8vH+fXt8oiadkOI4QTH8uhcRx42lb5+e/+K1pcnomkQXqPzpLVCQixW
EOiHx3mqbb+IH+8f52+T7GXC/np6/RV81h6fvqgOD1zHTe/b8+WrKhYX15LdJNRCyCbq9Nvl
4fPj5Rv1IEo34S2O+b83b+fz++ODGm/3lzd+T1VyDWpcJ/8rOVIVDGiaGL7ooR4/fZwN1f/+
9Ay+li2TkKp+/iH91P33h2f1+SR/ULrdu6x3x1U/fHx6fnr5h6oTo7Y+jD81KDphBiwRmyK8
b5PqmJ+T7UUBXy5OjkdDqrbZvg4TUGWpcUx0DPIWTE1LEGPgpiFu37WxII4ItbFfRYKzpMi9
n6lTLSt8P5w6zVci93c6lhgtBFluwiMI/Y1Lb/jPx+PlpYkug9Ro4JV3zOdr/GSuRmyEp/Z5
/Ky6hpBxwWt6qxUtbu7wjbkGQiSgBRHDpIbkMl3OiHAfNaSQ67vVAj8OqSEiWS6JA74a0VxV
vIJREwUuwqEBLxK1Whfu9kLUl0r8Guheye89c18zIA6WV676MXRNhELaVqGpB0yvBEqcC0dL
acr6SsqAXGsI/Wf1xRFXVjQ+X8W9zqvoXDZsYtL1aRYb1TTbkdHhihBu96ofssji2HUJ/b/K
nmy5bWTXX3Hl6d6qnBkvimPfqjy0SEriiJu5SHJeWIqtSVwT2ykvdZLz9RdAd5O9oOmch4lH
ANj7AqCxyGf61TVwGl+e6TwaTxL14IA5Nd0wQdkyRzA/kqvrPhKFNGNGz9eA/es8yvt1WQhy
/J0srdqJ/vSiyMm5920qLC9IpZ7/oP2J58emBtoejmFO8eCLROVqi2pRZc7754iwJNsYjuK0
wIyL/InYurkH9bax4/7IKTs8oWHFHkWW+8eHu5fHJ27NTJENZhjCDaY386oTD7dPj3e35nkJ
90ldpjE7gppcV5Gl82ITp2Z0Cx0wC59zRmgRI8L6HWUiNbY2UrSGGmduhoqLxU6p9iyY8QNq
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
RU6yjF5kKWlg+f8XozkxtW8CAA==

--VbJkn9YxBvnuCH5J--
