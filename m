Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5A93F686B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbhHXRx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:53:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:23559 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237909AbhHXRws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:52:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="197612197"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="gz'50?scan'50,208,50";a="197612197"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:52:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="gz'50?scan'50,208,50";a="685515225"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2021 10:52:02 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIaaf-0000j6-W7; Tue, 24 Aug 2021 17:52:02 +0000
Date:   Wed, 25 Aug 2021 01:51:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt-size 33/40] fs/ceph/mds_client.c:2731:17:
 error: implicit declaration of function 'ceph_fscrypt_auth_len'
Message-ID: <202108250114.xZIK7Eld-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt-size
head:   a17ec2cafbd2fc0e04e8787810bec64849190db2
commit: e1f497d75bf9fea8856174467d488557f8060e28 [33/40] ceph: align data in pages in ceph_sync_write
config: i386-randconfig-a006-20210824 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=e1f497d75bf9fea8856174467d488557f8060e28
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt-size
        git checkout e1f497d75bf9fea8856174467d488557f8060e28
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ceph/super.h:29,
                    from fs/ceph/super.c:20:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   In file included from fs/ceph/super.c:23:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   fs/ceph/super.c: In function 'ceph_put_super':
>> fs/ceph/super.c:48:2: error: implicit declaration of function 'ceph_fscrypt_free_dummy_policy'; did you mean 'fscrypt_free_dummy_policy'? [-Werror=implicit-function-declaration]
      48 |  ceph_fscrypt_free_dummy_policy(fsc);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  fscrypt_free_dummy_policy
   fs/ceph/super.c: In function 'ceph_set_super':
>> fs/ceph/super.c:1180:2: error: implicit declaration of function 'ceph_fscrypt_set_ops'; did you mean 'fscrypt_set_ops'? [-Werror=implicit-function-declaration]
    1180 |  ceph_fscrypt_set_ops(s);
         |  ^~~~~~~~~~~~~~~~~~~~
         |  fscrypt_set_ops
   cc1: some warnings being treated as errors
--
   In file included from fs/ceph/super.h:29,
                    from fs/ceph/inode.c:19:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   In file included from fs/ceph/inode.c:22:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   fs/ceph/inode.c: In function 'ceph_new_inode':
>> fs/ceph/inode.c:94:8: error: implicit declaration of function 'ceph_fscrypt_prepare_context' [-Werror=implicit-function-declaration]
      94 |  err = ceph_fscrypt_prepare_context(dir, inode, as_ctx);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ceph/inode.c: In function 'ceph_as_ctx_to_req':
>> fs/ceph/inode.c:110:2: error: implicit declaration of function 'ceph_fscrypt_as_ctx_to_req'; did you mean 'ceph_as_ctx_to_req'? [-Werror=implicit-function-declaration]
     110 |  ceph_fscrypt_as_ctx_to_req(req, as_ctx);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |  ceph_as_ctx_to_req
   fs/ceph/inode.c: In function 'ceph_fill_trace':
>> fs/ceph/inode.c:1466:10: error: implicit declaration of function 'ceph_fname_alloc_buffer'; did you mean 'fscrypt_fname_alloc_buffer'? [-Werror=implicit-function-declaration]
    1466 |    err = ceph_fname_alloc_buffer(dir, &oname);
         |          ^~~~~~~~~~~~~~~~~~~~~~~
         |          fscrypt_fname_alloc_buffer
>> fs/ceph/inode.c:1472:10: error: implicit declaration of function 'ceph_fname_to_usr' [-Werror=implicit-function-declaration]
    1472 |    err = ceph_fname_to_usr(&fname, NULL, &oname, &is_nokey);
         |          ^~~~~~~~~~~~~~~~~
>> fs/ceph/inode.c:1475:5: error: implicit declaration of function 'ceph_fname_free_buffer'; did you mean 'fscrypt_fname_free_buffer'? [-Werror=implicit-function-declaration]
    1475 |     ceph_fname_free_buffer(dir, &oname);
         |     ^~~~~~~~~~~~~~~~~~~~~~
         |     fscrypt_fname_free_buffer
   cc1: some warnings being treated as errors
--
   In file included from fs/ceph/super.h:29,
                    from fs/ceph/dir.c:10:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   In file included from fs/ceph/dir.c:12:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   fs/ceph/dir.c: In function 'ceph_readdir':
>> fs/ceph/dir.c:372:8: error: implicit declaration of function 'ceph_fname_alloc_buffer'; did you mean 'fscrypt_fname_alloc_buffer'? [-Werror=implicit-function-declaration]
     372 |  err = ceph_fname_alloc_buffer(inode, &tname);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
         |        fscrypt_fname_alloc_buffer
>> fs/ceph/dir.c:545:9: error: implicit declaration of function 'ceph_fname_to_usr' [-Werror=implicit-function-declaration]
     545 |   err = ceph_fname_to_usr(&fname, &tname, &oname, NULL);
         |         ^~~~~~~~~~~~~~~~~
>> fs/ceph/dir.c:618:2: error: implicit declaration of function 'ceph_fname_free_buffer'; did you mean 'fscrypt_fname_free_buffer'? [-Werror=implicit-function-declaration]
     618 |  ceph_fname_free_buffer(inode, &tname);
         |  ^~~~~~~~~~~~~~~~~~~~~~
         |  fscrypt_fname_free_buffer
   cc1: some warnings being treated as errors
--
   In file included from fs/ceph/super.h:29,
                    from fs/ceph/export.c:8:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   In file included from fs/ceph/export.c:10:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   fs/ceph/export.c: In function 'ceph_get_name':
>> fs/ceph/export.c:568:9: error: implicit declaration of function 'ceph_fname_alloc_buffer'; did you mean 'fscrypt_fname_alloc_buffer'? [-Werror=implicit-function-declaration]
     568 |   err = ceph_fname_alloc_buffer(dir, &oname);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         fscrypt_fname_alloc_buffer
>> fs/ceph/export.c:572:9: error: implicit declaration of function 'ceph_fname_to_usr' [-Werror=implicit-function-declaration]
     572 |   err = ceph_fname_to_usr(&fname, NULL, &oname, NULL);
         |         ^~~~~~~~~~~~~~~~~
>> fs/ceph/export.c:577:3: error: implicit declaration of function 'ceph_fname_free_buffer'; did you mean 'fscrypt_fname_free_buffer'? [-Werror=implicit-function-declaration]
     577 |   ceph_fname_free_buffer(dir, &oname);
         |   ^~~~~~~~~~~~~~~~~~~~~~
         |   fscrypt_fname_free_buffer
   cc1: some warnings being treated as errors
--
   In file included from fs/ceph/super.h:29,
                    from fs/ceph/caps.c:13:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   In file included from fs/ceph/caps.c:16:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   fs/ceph/caps.c: In function 'ceph_encode_dentry_release':
>> fs/ceph/caps.c:4566:15: error: implicit declaration of function 'ceph_encode_encrypted_fname'; did you mean 'ceph_encode_dentry_release'? [-Werror=implicit-function-declaration]
    4566 |    int ret2 = ceph_encode_encrypted_fname(dir, dentry, *p);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               ceph_encode_dentry_release
   cc1: some warnings being treated as errors
--
   In file included from fs/ceph/super.h:29,
                    from fs/ceph/mds_client.c:16:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   In file included from fs/ceph/mds_client.c:17:
   fs/ceph/crypto.h:6: error: unterminated #ifndef
       6 | #ifndef _CEPH_CRYPTO_H
         | 
   fs/ceph/mds_client.c: In function 'ceph_mdsc_build_path':
>> fs/ceph/mds_client.c:2584:11: error: implicit declaration of function 'ceph_encode_encrypted_fname'; did you mean 'ceph_encode_dentry_release'? [-Werror=implicit-function-declaration]
    2584 |     len = ceph_encode_encrypted_fname(d_inode(parent), cur, buf);
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |           ceph_encode_dentry_release
   fs/ceph/mds_client.c: In function 'encode_mclientrequest_tail':
>> fs/ceph/mds_client.c:2731:17: error: implicit declaration of function 'ceph_fscrypt_auth_len' [-Werror=implicit-function-declaration]
    2731 |   u32 authlen = ceph_fscrypt_auth_len(req->r_fscrypt_auth);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ceph_fscrypt_auth_len +2731 fs/ceph/mds_client.c

977c54fbce4178 Jeff Layton    2021-01-14  2498  
630f27427d391d Jeff Layton    2020-08-07  2499  /**
630f27427d391d Jeff Layton    2020-08-07  2500   * ceph_mdsc_build_path - build a path string to a given dentry
630f27427d391d Jeff Layton    2020-08-07  2501   * @dentry: dentry to which path should be built
630f27427d391d Jeff Layton    2020-08-07  2502   * @plen: returned length of string
630f27427d391d Jeff Layton    2020-08-07  2503   * @pbase: returned base inode number
630f27427d391d Jeff Layton    2020-08-07  2504   * @for_wire: is this path going to be sent to the MDS?
630f27427d391d Jeff Layton    2020-08-07  2505   *
630f27427d391d Jeff Layton    2020-08-07  2506   * Build a string that represents the path to the dentry. This is mostly called
630f27427d391d Jeff Layton    2020-08-07  2507   * for two different purposes:
2f2dc053404feb Sage Weil      2009-10-06  2508   *
630f27427d391d Jeff Layton    2020-08-07  2509   * 1) we need to build a path string to send to the MDS (for_wire == true)
630f27427d391d Jeff Layton    2020-08-07  2510   * 2) we need a path string for local presentation (e.g. debugfs) (for_wire == false)
630f27427d391d Jeff Layton    2020-08-07  2511   *
630f27427d391d Jeff Layton    2020-08-07  2512   * The path is built in reverse, starting with the dentry. Walk back up toward
630f27427d391d Jeff Layton    2020-08-07  2513   * the root, building the path until the first non-snapped inode is reached (for_wire)
630f27427d391d Jeff Layton    2020-08-07  2514   * or the root inode is reached (!for_wire).
2f2dc053404feb Sage Weil      2009-10-06  2515   *
2f2dc053404feb Sage Weil      2009-10-06  2516   * Encode hidden .snap dirs as a double /, i.e.
2f2dc053404feb Sage Weil      2009-10-06  2517   *   foo/.snap/bar -> foo//bar
2f2dc053404feb Sage Weil      2009-10-06  2518   */
630f27427d391d Jeff Layton    2020-08-07  2519  char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase, int for_wire)
2f2dc053404feb Sage Weil      2009-10-06  2520  {
7797b721db4bdb Jeff Layton    2020-08-05  2521  	struct dentry *cur;
7797b721db4bdb Jeff Layton    2020-08-05  2522  	struct inode *inode;
2f2dc053404feb Sage Weil      2009-10-06  2523  	char *path;
f77f21bb28367d Jeff Layton    2019-04-29  2524  	int pos;
1b71fe2efa31cd Al Viro        2011-07-16  2525  	unsigned seq;
69a10fb3f4b876 Jeff Layton    2019-04-26  2526  	u64 base;
2f2dc053404feb Sage Weil      2009-10-06  2527  
d37b1d9943d513 Markus Elfring 2017-08-20  2528  	if (!dentry)
2f2dc053404feb Sage Weil      2009-10-06  2529  		return ERR_PTR(-EINVAL);
2f2dc053404feb Sage Weil      2009-10-06  2530  
f77f21bb28367d Jeff Layton    2019-04-29  2531  	path = __getname();
d37b1d9943d513 Markus Elfring 2017-08-20  2532  	if (!path)
2f2dc053404feb Sage Weil      2009-10-06  2533  		return ERR_PTR(-ENOMEM);
f77f21bb28367d Jeff Layton    2019-04-29  2534  retry:
f77f21bb28367d Jeff Layton    2019-04-29  2535  	pos = PATH_MAX - 1;
f77f21bb28367d Jeff Layton    2019-04-29  2536  	path[pos] = '\0';
f77f21bb28367d Jeff Layton    2019-04-29  2537  
f77f21bb28367d Jeff Layton    2019-04-29  2538  	seq = read_seqbegin(&rename_lock);
7797b721db4bdb Jeff Layton    2020-08-05  2539  	cur = dget(dentry);
f77f21bb28367d Jeff Layton    2019-04-29  2540  	for (;;) {
630f27427d391d Jeff Layton    2020-08-07  2541  		struct dentry *parent;
2f2dc053404feb Sage Weil      2009-10-06  2542  
7797b721db4bdb Jeff Layton    2020-08-05  2543  		spin_lock(&cur->d_lock);
7797b721db4bdb Jeff Layton    2020-08-05  2544  		inode = d_inode(cur);
2f2dc053404feb Sage Weil      2009-10-06  2545  		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
104648ad3f2ebe Sage Weil      2010-03-18  2546  			dout("build_path path+%d: %p SNAPDIR\n",
7797b721db4bdb Jeff Layton    2020-08-05  2547  			     pos, cur);
630f27427d391d Jeff Layton    2020-08-07  2548  			spin_unlock(&cur->d_lock);
630f27427d391d Jeff Layton    2020-08-07  2549  			parent = dget_parent(cur);
630f27427d391d Jeff Layton    2020-08-07  2550  		} else if (for_wire && inode && dentry != cur && ceph_snap(inode) == CEPH_NOSNAP) {
7797b721db4bdb Jeff Layton    2020-08-05  2551  			spin_unlock(&cur->d_lock);
d6b8bd679c9c88 Jeff Layton    2019-05-09  2552  			pos++; /* get rid of any prepended '/' */
2f2dc053404feb Sage Weil      2009-10-06  2553  			break;
630f27427d391d Jeff Layton    2020-08-07  2554  		} else if (!for_wire || !IS_ENCRYPTED(d_inode(cur->d_parent))) {
7797b721db4bdb Jeff Layton    2020-08-05  2555  			pos -= cur->d_name.len;
1b71fe2efa31cd Al Viro        2011-07-16  2556  			if (pos < 0) {
7797b721db4bdb Jeff Layton    2020-08-05  2557  				spin_unlock(&cur->d_lock);
2f2dc053404feb Sage Weil      2009-10-06  2558  				break;
1b71fe2efa31cd Al Viro        2011-07-16  2559  			}
7797b721db4bdb Jeff Layton    2020-08-05  2560  			memcpy(path + pos, cur->d_name.name, cur->d_name.len);
630f27427d391d Jeff Layton    2020-08-07  2561  			spin_unlock(&cur->d_lock);
630f27427d391d Jeff Layton    2020-08-07  2562  			parent = dget_parent(cur);
630f27427d391d Jeff Layton    2020-08-07  2563  		} else {
630f27427d391d Jeff Layton    2020-08-07  2564  			int len, ret;
630f27427d391d Jeff Layton    2020-08-07  2565  			char buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
630f27427d391d Jeff Layton    2020-08-07  2566  
630f27427d391d Jeff Layton    2020-08-07  2567  			/*
630f27427d391d Jeff Layton    2020-08-07  2568  			 * Proactively copy name into buf, in case we need to present
630f27427d391d Jeff Layton    2020-08-07  2569  			 * it as-is.
630f27427d391d Jeff Layton    2020-08-07  2570  			 */
630f27427d391d Jeff Layton    2020-08-07  2571  			memcpy(buf, cur->d_name.name, cur->d_name.len);
630f27427d391d Jeff Layton    2020-08-07  2572  			len = cur->d_name.len;
630f27427d391d Jeff Layton    2020-08-07  2573  			spin_unlock(&cur->d_lock);
630f27427d391d Jeff Layton    2020-08-07  2574  			parent = dget_parent(cur);
630f27427d391d Jeff Layton    2020-08-07  2575  
630f27427d391d Jeff Layton    2020-08-07  2576  			ret = __fscrypt_prepare_readdir(d_inode(parent));
630f27427d391d Jeff Layton    2020-08-07  2577  			if (ret < 0) {
630f27427d391d Jeff Layton    2020-08-07  2578  				dput(parent);
630f27427d391d Jeff Layton    2020-08-07  2579  				dput(cur);
630f27427d391d Jeff Layton    2020-08-07  2580  				return ERR_PTR(ret);
630f27427d391d Jeff Layton    2020-08-07  2581  			}
630f27427d391d Jeff Layton    2020-08-07  2582  
630f27427d391d Jeff Layton    2020-08-07  2583  			if (fscrypt_has_encryption_key(d_inode(parent))) {
630f27427d391d Jeff Layton    2020-08-07 @2584  				len = ceph_encode_encrypted_fname(d_inode(parent), cur, buf);
630f27427d391d Jeff Layton    2020-08-07  2585  				if (len < 0) {
630f27427d391d Jeff Layton    2020-08-07  2586  					dput(parent);
630f27427d391d Jeff Layton    2020-08-07  2587  					dput(cur);
630f27427d391d Jeff Layton    2020-08-07  2588  					return ERR_PTR(len);
2f2dc053404feb Sage Weil      2009-10-06  2589  				}
630f27427d391d Jeff Layton    2020-08-07  2590  			}
630f27427d391d Jeff Layton    2020-08-07  2591  			pos -= len;
630f27427d391d Jeff Layton    2020-08-07  2592  			if (pos < 0) {
630f27427d391d Jeff Layton    2020-08-07  2593  				dput(parent);
630f27427d391d Jeff Layton    2020-08-07  2594  				break;
630f27427d391d Jeff Layton    2020-08-07  2595  			}
630f27427d391d Jeff Layton    2020-08-07  2596  			memcpy(path + pos, buf, len);
630f27427d391d Jeff Layton    2020-08-07  2597  		}
630f27427d391d Jeff Layton    2020-08-07  2598  		dput(cur);
630f27427d391d Jeff Layton    2020-08-07  2599  		cur = parent;
f77f21bb28367d Jeff Layton    2019-04-29  2600  
f77f21bb28367d Jeff Layton    2019-04-29  2601  		/* Are we at the root? */
7797b721db4bdb Jeff Layton    2020-08-05  2602  		if (IS_ROOT(cur))
f77f21bb28367d Jeff Layton    2019-04-29  2603  			break;
f77f21bb28367d Jeff Layton    2019-04-29  2604  
f77f21bb28367d Jeff Layton    2019-04-29  2605  		/* Are we out of buffer? */
f77f21bb28367d Jeff Layton    2019-04-29  2606  		if (--pos < 0)
f77f21bb28367d Jeff Layton    2019-04-29  2607  			break;
f77f21bb28367d Jeff Layton    2019-04-29  2608  
f77f21bb28367d Jeff Layton    2019-04-29  2609  		path[pos] = '/';
2f2dc053404feb Sage Weil      2009-10-06  2610  	}
7797b721db4bdb Jeff Layton    2020-08-05  2611  	inode = d_inode(cur);
7797b721db4bdb Jeff Layton    2020-08-05  2612  	base = inode ? ceph_ino(inode) : 0;
7797b721db4bdb Jeff Layton    2020-08-05  2613  	dput(cur);
f5946bcc5e7903 Jeff Layton    2019-10-16  2614  
f5946bcc5e7903 Jeff Layton    2019-10-16  2615  	if (read_seqretry(&rename_lock, seq))
f5946bcc5e7903 Jeff Layton    2019-10-16  2616  		goto retry;
f5946bcc5e7903 Jeff Layton    2019-10-16  2617  
f5946bcc5e7903 Jeff Layton    2019-10-16  2618  	if (pos < 0) {
f5946bcc5e7903 Jeff Layton    2019-10-16  2619  		/*
f5946bcc5e7903 Jeff Layton    2019-10-16  2620  		 * A rename didn't occur, but somehow we didn't end up where
f5946bcc5e7903 Jeff Layton    2019-10-16  2621  		 * we thought we would. Throw a warning and try again.
f5946bcc5e7903 Jeff Layton    2019-10-16  2622  		 */
630f27427d391d Jeff Layton    2020-08-07  2623  		pr_warn("build_path did not end path lookup where expected (pos = %d)\n", pos);
2f2dc053404feb Sage Weil      2009-10-06  2624  		goto retry;
2f2dc053404feb Sage Weil      2009-10-06  2625  	}
2f2dc053404feb Sage Weil      2009-10-06  2626  
69a10fb3f4b876 Jeff Layton    2019-04-26  2627  	*pbase = base;
f77f21bb28367d Jeff Layton    2019-04-29  2628  	*plen = PATH_MAX - 1 - pos;
104648ad3f2ebe Sage Weil      2010-03-18  2629  	dout("build_path on %p %d built %llx '%.*s'\n",
f77f21bb28367d Jeff Layton    2019-04-29  2630  	     dentry, d_count(dentry), base, *plen, path + pos);
f77f21bb28367d Jeff Layton    2019-04-29  2631  	return path + pos;
2f2dc053404feb Sage Weil      2009-10-06  2632  }
2f2dc053404feb Sage Weil      2009-10-06  2633  
fd36a71762f3b0 Jeff Layton    2016-12-15  2634  static int build_dentry_path(struct dentry *dentry, struct inode *dir,
2f2dc053404feb Sage Weil      2009-10-06  2635  			     const char **ppath, int *ppathlen, u64 *pino,
1bcb344086f3ec Jeff Layton    2019-04-15  2636  			     bool *pfreepath, bool parent_locked)
2f2dc053404feb Sage Weil      2009-10-06  2637  {
2f2dc053404feb Sage Weil      2009-10-06  2638  	char *path;
2f2dc053404feb Sage Weil      2009-10-06  2639  
c6b0b656ca24ed Jeff Layton    2016-12-15  2640  	rcu_read_lock();
fd36a71762f3b0 Jeff Layton    2016-12-15  2641  	if (!dir)
c6b0b656ca24ed Jeff Layton    2016-12-15  2642  		dir = d_inode_rcu(dentry->d_parent);
630f27427d391d Jeff Layton    2020-08-07  2643  	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP && !IS_ENCRYPTED(dir)) {
c6b0b656ca24ed Jeff Layton    2016-12-15  2644  		*pino = ceph_ino(dir);
c6b0b656ca24ed Jeff Layton    2016-12-15  2645  		rcu_read_unlock();
2f2dc053404feb Sage Weil      2009-10-06  2646  		*ppath = dentry->d_name.name;
2f2dc053404feb Sage Weil      2009-10-06  2647  		*ppathlen = dentry->d_name.len;
2f2dc053404feb Sage Weil      2009-10-06  2648  		return 0;
2f2dc053404feb Sage Weil      2009-10-06  2649  	}
c6b0b656ca24ed Jeff Layton    2016-12-15  2650  	rcu_read_unlock();
2f2dc053404feb Sage Weil      2009-10-06  2651  	path = ceph_mdsc_build_path(dentry, ppathlen, pino, 1);
2f2dc053404feb Sage Weil      2009-10-06  2652  	if (IS_ERR(path))
2f2dc053404feb Sage Weil      2009-10-06  2653  		return PTR_ERR(path);
2f2dc053404feb Sage Weil      2009-10-06  2654  	*ppath = path;
1bcb344086f3ec Jeff Layton    2019-04-15  2655  	*pfreepath = true;
2f2dc053404feb Sage Weil      2009-10-06  2656  	return 0;
2f2dc053404feb Sage Weil      2009-10-06  2657  }
2f2dc053404feb Sage Weil      2009-10-06  2658  
2f2dc053404feb Sage Weil      2009-10-06  2659  static int build_inode_path(struct inode *inode,
2f2dc053404feb Sage Weil      2009-10-06  2660  			    const char **ppath, int *ppathlen, u64 *pino,
1bcb344086f3ec Jeff Layton    2019-04-15  2661  			    bool *pfreepath)
2f2dc053404feb Sage Weil      2009-10-06  2662  {
2f2dc053404feb Sage Weil      2009-10-06  2663  	struct dentry *dentry;
2f2dc053404feb Sage Weil      2009-10-06  2664  	char *path;
2f2dc053404feb Sage Weil      2009-10-06  2665  
2f2dc053404feb Sage Weil      2009-10-06  2666  	if (ceph_snap(inode) == CEPH_NOSNAP) {
2f2dc053404feb Sage Weil      2009-10-06  2667  		*pino = ceph_ino(inode);
2f2dc053404feb Sage Weil      2009-10-06  2668  		*ppathlen = 0;
2f2dc053404feb Sage Weil      2009-10-06  2669  		return 0;
2f2dc053404feb Sage Weil      2009-10-06  2670  	}
2f2dc053404feb Sage Weil      2009-10-06  2671  	dentry = d_find_alias(inode);
2f2dc053404feb Sage Weil      2009-10-06  2672  	path = ceph_mdsc_build_path(dentry, ppathlen, pino, 1);
2f2dc053404feb Sage Weil      2009-10-06  2673  	dput(dentry);
2f2dc053404feb Sage Weil      2009-10-06  2674  	if (IS_ERR(path))
2f2dc053404feb Sage Weil      2009-10-06  2675  		return PTR_ERR(path);
2f2dc053404feb Sage Weil      2009-10-06  2676  	*ppath = path;
1bcb344086f3ec Jeff Layton    2019-04-15  2677  	*pfreepath = true;
2f2dc053404feb Sage Weil      2009-10-06  2678  	return 0;
2f2dc053404feb Sage Weil      2009-10-06  2679  }
2f2dc053404feb Sage Weil      2009-10-06  2680  
2f2dc053404feb Sage Weil      2009-10-06  2681  /*
2f2dc053404feb Sage Weil      2009-10-06  2682   * request arguments may be specified via an inode *, a dentry *, or
2f2dc053404feb Sage Weil      2009-10-06  2683   * an explicit ino+path.
2f2dc053404feb Sage Weil      2009-10-06  2684   */
2f2dc053404feb Sage Weil      2009-10-06  2685  static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
fd36a71762f3b0 Jeff Layton    2016-12-15  2686  				  struct inode *rdiri, const char *rpath,
fd36a71762f3b0 Jeff Layton    2016-12-15  2687  				  u64 rino, const char **ppath, int *pathlen,
1bcb344086f3ec Jeff Layton    2019-04-15  2688  				  u64 *ino, bool *freepath, bool parent_locked)
2f2dc053404feb Sage Weil      2009-10-06  2689  {
2f2dc053404feb Sage Weil      2009-10-06  2690  	int r = 0;
2f2dc053404feb Sage Weil      2009-10-06  2691  
2f2dc053404feb Sage Weil      2009-10-06  2692  	if (rinode) {
2f2dc053404feb Sage Weil      2009-10-06  2693  		r = build_inode_path(rinode, ppath, pathlen, ino, freepath);
2f2dc053404feb Sage Weil      2009-10-06  2694  		dout(" inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
2f2dc053404feb Sage Weil      2009-10-06  2695  		     ceph_snap(rinode));
2f2dc053404feb Sage Weil      2009-10-06  2696  	} else if (rdentry) {
fd36a71762f3b0 Jeff Layton    2016-12-15  2697  		r = build_dentry_path(rdentry, rdiri, ppath, pathlen, ino,
1bcb344086f3ec Jeff Layton    2019-04-15  2698  					freepath, parent_locked);
2f2dc053404feb Sage Weil      2009-10-06  2699  		dout(" dentry %p %llx/%.*s\n", rdentry, *ino, *pathlen,
2f2dc053404feb Sage Weil      2009-10-06  2700  		     *ppath);
795858dbd25346 Sage Weil      2011-08-15  2701  	} else if (rpath || rino) {
2f2dc053404feb Sage Weil      2009-10-06  2702  		*ino = rino;
2f2dc053404feb Sage Weil      2009-10-06  2703  		*ppath = rpath;
b000056a5a8d3f David Zafman   2012-10-25  2704  		*pathlen = rpath ? strlen(rpath) : 0;
2f2dc053404feb Sage Weil      2009-10-06  2705  		dout(" path %.*s\n", *pathlen, rpath);
2f2dc053404feb Sage Weil      2009-10-06  2706  	}
2f2dc053404feb Sage Weil      2009-10-06  2707  
2f2dc053404feb Sage Weil      2009-10-06  2708  	return r;
2f2dc053404feb Sage Weil      2009-10-06  2709  }
2f2dc053404feb Sage Weil      2009-10-06  2710  
6f322d1adf7096 Jeff Layton    2021-05-13  2711  static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *req)
60267ba35c744d Ilya Dryomov   2020-12-16  2712  {
60267ba35c744d Ilya Dryomov   2020-12-16  2713  	struct ceph_timespec ts;
60267ba35c744d Ilya Dryomov   2020-12-16  2714  	int i;
60267ba35c744d Ilya Dryomov   2020-12-16  2715  
60267ba35c744d Ilya Dryomov   2020-12-16  2716  	ceph_encode_timespec64(&ts, &req->r_stamp);
60267ba35c744d Ilya Dryomov   2020-12-16  2717  	ceph_encode_copy(p, &ts, sizeof(ts));
60267ba35c744d Ilya Dryomov   2020-12-16  2718  
977c54fbce4178 Jeff Layton    2021-01-14  2719  	/* v4: gid_list */
60267ba35c744d Ilya Dryomov   2020-12-16  2720  	ceph_encode_32(p, req->r_cred->group_info->ngroups);
60267ba35c744d Ilya Dryomov   2020-12-16  2721  	for (i = 0; i < req->r_cred->group_info->ngroups; i++)
60267ba35c744d Ilya Dryomov   2020-12-16  2722  		ceph_encode_64(p, from_kgid(&init_user_ns,
60267ba35c744d Ilya Dryomov   2020-12-16  2723  					    req->r_cred->group_info->gid[i]));
6f322d1adf7096 Jeff Layton    2021-05-13  2724  
977c54fbce4178 Jeff Layton    2021-01-14  2725  	/* v5: altname */
977c54fbce4178 Jeff Layton    2021-01-14  2726  	ceph_encode_32(p, req->r_altname_len);
977c54fbce4178 Jeff Layton    2021-01-14  2727  	ceph_encode_copy(p, req->r_altname, req->r_altname_len);
6f322d1adf7096 Jeff Layton    2021-05-13  2728  
6f322d1adf7096 Jeff Layton    2021-05-13  2729  	/* v6: fscrypt_auth and fscrypt_file */
6f322d1adf7096 Jeff Layton    2021-05-13  2730  	if (req->r_fscrypt_auth) {
589d14dcb54206 Jeff Layton    2020-09-08 @2731  		u32 authlen = ceph_fscrypt_auth_len(req->r_fscrypt_auth);
6f322d1adf7096 Jeff Layton    2021-05-13  2732  
6f322d1adf7096 Jeff Layton    2021-05-13  2733  		ceph_encode_32(p, authlen);
6f322d1adf7096 Jeff Layton    2021-05-13  2734  		ceph_encode_copy(p, req->r_fscrypt_auth, authlen);
6f322d1adf7096 Jeff Layton    2021-05-13  2735  	} else {
6f322d1adf7096 Jeff Layton    2021-05-13  2736  		ceph_encode_32(p, 0);
6f322d1adf7096 Jeff Layton    2021-05-13  2737  	}
6f322d1adf7096 Jeff Layton    2021-05-13  2738  	ceph_encode_32(p, 0); // fscrypt_file for now
60267ba35c744d Ilya Dryomov   2020-12-16  2739  }
60267ba35c744d Ilya Dryomov   2020-12-16  2740  

:::::: The code at line 2731 was first introduced by commit
:::::: 589d14dcb542060a0f1a3c154401c4379339db3c ceph: implement -o test_dummy_encryption mount option

:::::: TO: Jeff Layton <jlayton@kernel.org>
:::::: CC: Jeff Layton <jlayton@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k+w/mQv8wyuph6w0--
