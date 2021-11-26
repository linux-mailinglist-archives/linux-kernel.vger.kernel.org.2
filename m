Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1314B45F731
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 00:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhKZX2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 18:28:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:44102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232489AbhKZX0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:26:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="321958420"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="321958420"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 15:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="476022029"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2021 15:23:20 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqkYq-0008l7-2q; Fri, 26 Nov 2021 23:23:20 +0000
Date:   Sat, 27 Nov 2021 07:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [brauner:fs.fixes.ceph 1/1] fs/ceph/file.c:613:24: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202111270700.JpIS0kPB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.fixes.ceph
head:   5eb2c57bf8928aecfe8c06fbeaf09e1ab0741337
commit: 5eb2c57bf8928aecfe8c06fbeaf09e1ab0741337 [1/1] ceph: fix up non-directory creation in SGID directories
config: x86_64-randconfig-s021-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270700.JpIS0kPB-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?id=5eb2c57bf8928aecfe8c06fbeaf09e1ab0741337
        git remote add brauner https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
        git fetch --no-tags brauner fs.fixes.ceph
        git checkout 5eb2c57bf8928aecfe8c06fbeaf09e1ab0741337
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ceph/file.c:613:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] gid @@     got unsigned int @@
   fs/ceph/file.c:613:24: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] gid
   fs/ceph/file.c:613:24: sparse:     got unsigned int
   fs/ceph/file.c:623:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] gid @@     got unsigned int @@
   fs/ceph/file.c:623:24: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] gid
   fs/ceph/file.c:623:24: sparse:     got unsigned int

vim +613 fs/ceph/file.c

   568	
   569	static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
   570					    struct file *file, umode_t mode,
   571					    struct ceph_mds_request *req,
   572					    struct ceph_acl_sec_ctx *as_ctx,
   573					    struct ceph_file_layout *lo)
   574	{
   575		int ret;
   576		char xattr_buf[4];
   577		struct ceph_mds_reply_inode in = { };
   578		struct ceph_mds_reply_info_in iinfo = { .in = &in };
   579		struct ceph_inode_info *ci = ceph_inode(dir);
   580		struct inode *inode;
   581		struct timespec64 now;
   582		struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
   583		struct ceph_vino vino = { .ino = req->r_deleg_ino,
   584					  .snap = CEPH_NOSNAP };
   585	
   586		ktime_get_real_ts64(&now);
   587	
   588		inode = ceph_get_inode(dentry->d_sb, vino);
   589		if (IS_ERR(inode))
   590			return PTR_ERR(inode);
   591	
   592		iinfo.inline_version = CEPH_INLINE_NONE;
   593		iinfo.change_attr = 1;
   594		ceph_encode_timespec64(&iinfo.btime, &now);
   595	
   596		iinfo.xattr_len = ARRAY_SIZE(xattr_buf);
   597		iinfo.xattr_data = xattr_buf;
   598		memset(iinfo.xattr_data, 0, iinfo.xattr_len);
   599	
   600		in.ino = cpu_to_le64(vino.ino);
   601		in.snapid = cpu_to_le64(CEPH_NOSNAP);
   602		in.version = cpu_to_le64(1);	// ???
   603		in.cap.caps = in.cap.wanted = cpu_to_le32(CEPH_CAP_ALL_FILE);
   604		in.cap.cap_id = cpu_to_le64(1);
   605		in.cap.realm = cpu_to_le64(ci->i_snap_realm->ino);
   606		in.cap.flags = CEPH_CAP_FLAG_AUTH;
   607		in.ctime = in.mtime = in.atime = iinfo.btime;
   608		in.truncate_seq = cpu_to_le32(1);
   609		in.truncate_size = cpu_to_le64(-1ULL);
   610		in.xattr_version = cpu_to_le64(1);
   611		in.uid = cpu_to_le32(from_kuid(&init_user_ns, current_fsuid()));
   612		if (dir->i_mode & S_ISGID) {
 > 613			in.gid = from_kgid(&init_user_ns, dir->i_gid);
   614	
   615			/* Directories always inherit the setgid bit. */
   616			if (S_ISDIR(mode))
   617				mode |= S_ISGID;
   618			else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
   619				 !in_group_p(dir->i_gid) &&
   620				 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
   621				mode &= ~S_ISGID;
   622		} else {
   623			in.gid = from_kgid(&init_user_ns, current_fsgid());
   624		}
   625		in.mode = cpu_to_le32((u32)mode);
   626	
   627		in.nlink = cpu_to_le32(1);
   628		in.max_size = cpu_to_le64(lo->stripe_unit);
   629	
   630		ceph_file_layout_to_legacy(lo, &in.layout);
   631	
   632		down_read(&mdsc->snap_rwsem);
   633		ret = ceph_fill_inode(inode, NULL, &iinfo, NULL, req->r_session,
   634				      req->r_fmode, NULL);
   635		up_read(&mdsc->snap_rwsem);
   636		if (ret) {
   637			dout("%s failed to fill inode: %d\n", __func__, ret);
   638			ceph_dir_clear_complete(dir);
   639			if (!d_unhashed(dentry))
   640				d_drop(dentry);
   641			if (inode->i_state & I_NEW)
   642				discard_new_inode(inode);
   643		} else {
   644			struct dentry *dn;
   645	
   646			dout("%s d_adding new inode 0x%llx to 0x%llx/%s\n", __func__,
   647				vino.ino, ceph_ino(dir), dentry->d_name.name);
   648			ceph_dir_clear_ordered(dir);
   649			ceph_init_inode_acls(inode, as_ctx);
   650			if (inode->i_state & I_NEW) {
   651				/*
   652				 * If it's not I_NEW, then someone created this before
   653				 * we got here. Assume the server is aware of it at
   654				 * that point and don't worry about setting
   655				 * CEPH_I_ASYNC_CREATE.
   656				 */
   657				ceph_inode(inode)->i_ceph_flags = CEPH_I_ASYNC_CREATE;
   658				unlock_new_inode(inode);
   659			}
   660			if (d_in_lookup(dentry) || d_really_is_negative(dentry)) {
   661				if (!d_unhashed(dentry))
   662					d_drop(dentry);
   663				dn = d_splice_alias(inode, dentry);
   664				WARN_ON_ONCE(dn && dn != dentry);
   665			}
   666			file->f_mode |= FMODE_CREATED;
   667			ret = finish_open(file, dentry, ceph_open);
   668		}
   669		return ret;
   670	}
   671	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
