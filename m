Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01A3EAEEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 05:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhHMDZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 23:25:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:16959 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238464AbhHMDZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 23:25:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="237534921"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="gz'50?scan'50,208,50";a="237534921"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 20:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="gz'50?scan'50,208,50";a="639702100"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2021 20:25:09 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mENoh-000NHy-IZ; Fri, 13 Aug 2021 03:25:07 +0000
Date:   Fri, 13 Aug 2021 11:24:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:xfs-5.15-merge-next 39/58] fs/ext4/super.c:5843:6:
 error: variable 'enable_quota' set but not used
Message-ID: <202108131141.jBLEfcfw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git xfs-5.15-merge-next
head:   f63862d45f0c08bf8e32883decfacd2150c74a1b
commit: 7f47a994841800acc1f0d7a9c897065e2c4d86ac [39/58] xfs: don't crash with assfail
config: parisc-randconfig-r034-20210811 (attached as .config)
compiler: hppa-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=7f47a994841800acc1f0d7a9c897065e2c4d86ac
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs xfs-5.15-merge-next
        git checkout 7f47a994841800acc1f0d7a9c897065e2c4d86ac
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/ext4/super.c: In function 'ext4_remount':
>> fs/ext4/super.c:5843:6: error: variable 'enable_quota' set but not used [-Werror=unused-but-set-variable]
    5843 |  int enable_quota = 0;
         |      ^~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/enable_quota +5843 fs/ext4/super.c

673c610033a820 Theodore Ts'o      2010-12-15  5836  
617ba13b31fbf5 Mingming Cao       2006-10-11  5837  static int ext4_remount(struct super_block *sb, int *flags, char *data)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5838  {
617ba13b31fbf5 Mingming Cao       2006-10-11  5839  	struct ext4_super_block *es;
617ba13b31fbf5 Mingming Cao       2006-10-11  5840  	struct ext4_sb_info *sbi = EXT4_SB(sb);
f25391ebb475d3 Lukas Czerner      2020-07-23  5841  	unsigned long old_sb_flags, vfs_flags;
617ba13b31fbf5 Mingming Cao       2006-10-11  5842  	struct ext4_mount_options old_opts;
c79d967de3741c Christoph Hellwig  2010-05-19 @5843  	int enable_quota = 0;
8a266467b8c484 Theodore Ts'o      2008-07-26  5844  	ext4_group_t g;
c5e06d101aaf72 Johann Lombardi    2011-05-24  5845  	int err = 0;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5846  #ifdef CONFIG_QUOTA
03dafb5f59bd31 Chen Gang          2013-01-24  5847  	int i, j;
33458eaba4dfe7 Theodore Ts'o      2018-10-12  5848  	char *to_free[EXT4_MAXQUOTAS];
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5849  #endif
d4c402d9fd97a5 Curt Wohlgemuth    2010-05-16  5850  	char *orig_data = kstrdup(data, GFP_KERNEL);
b237e3044450fc Harshad Shirwadkar 2021-04-01  5851  	struct ext4_parsed_options parsed_opts;
b237e3044450fc Harshad Shirwadkar 2021-04-01  5852  
b237e3044450fc Harshad Shirwadkar 2021-04-01  5853  	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
b237e3044450fc Harshad Shirwadkar 2021-04-01  5854  	parsed_opts.journal_devnum = 0;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5855  
21ac738ede0b49 Chengguang Xu      2018-07-29  5856  	if (data && !orig_data)
21ac738ede0b49 Chengguang Xu      2018-07-29  5857  		return -ENOMEM;
21ac738ede0b49 Chengguang Xu      2018-07-29  5858  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5859  	/* Store the original options */
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5860  	old_sb_flags = sb->s_flags;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5861  	old_opts.s_mount_opt = sbi->s_mount_opt;
a2595b8aa67011 Theodore Ts'o      2010-12-15  5862  	old_opts.s_mount_opt2 = sbi->s_mount_opt2;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5863  	old_opts.s_resuid = sbi->s_resuid;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5864  	old_opts.s_resgid = sbi->s_resgid;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5865  	old_opts.s_commit_interval = sbi->s_commit_interval;
30773840c19cea Theodore Ts'o      2009-01-03  5866  	old_opts.s_min_batch_time = sbi->s_min_batch_time;
30773840c19cea Theodore Ts'o      2009-01-03  5867  	old_opts.s_max_batch_time = sbi->s_max_batch_time;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5868  #ifdef CONFIG_QUOTA
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5869  	old_opts.s_jquota_fmt = sbi->s_jquota_fmt;
a2d4a646e61954 Jan Kara           2014-09-11  5870  	for (i = 0; i < EXT4_MAXQUOTAS; i++)
03dafb5f59bd31 Chen Gang          2013-01-24  5871  		if (sbi->s_qf_names[i]) {
33458eaba4dfe7 Theodore Ts'o      2018-10-12  5872  			char *qf_name = get_qf_name(sb, sbi, i);
33458eaba4dfe7 Theodore Ts'o      2018-10-12  5873  
33458eaba4dfe7 Theodore Ts'o      2018-10-12  5874  			old_opts.s_qf_names[i] = kstrdup(qf_name, GFP_KERNEL);
03dafb5f59bd31 Chen Gang          2013-01-24  5875  			if (!old_opts.s_qf_names[i]) {
03dafb5f59bd31 Chen Gang          2013-01-24  5876  				for (j = 0; j < i; j++)
03dafb5f59bd31 Chen Gang          2013-01-24  5877  					kfree(old_opts.s_qf_names[j]);
3e36a16375eee3 Wei Yongjun        2013-03-02  5878  				kfree(orig_data);
03dafb5f59bd31 Chen Gang          2013-01-24  5879  				return -ENOMEM;
03dafb5f59bd31 Chen Gang          2013-01-24  5880  			}
03dafb5f59bd31 Chen Gang          2013-01-24  5881  		} else
03dafb5f59bd31 Chen Gang          2013-01-24  5882  			old_opts.s_qf_names[i] = NULL;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5883  #endif
b3881f74b31b7d Theodore Ts'o      2009-01-05  5884  	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
b237e3044450fc Harshad Shirwadkar 2021-04-01  5885  		parsed_opts.journal_ioprio =
b237e3044450fc Harshad Shirwadkar 2021-04-01  5886  			sbi->s_journal->j_task->io_context->ioprio;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5887  
f25391ebb475d3 Lukas Czerner      2020-07-23  5888  	/*
f25391ebb475d3 Lukas Czerner      2020-07-23  5889  	 * Some options can be enabled by ext4 and/or by VFS mount flag
f25391ebb475d3 Lukas Czerner      2020-07-23  5890  	 * either way we need to make sure it matches in both *flags and
f25391ebb475d3 Lukas Czerner      2020-07-23  5891  	 * s_flags. Copy those selected flags from *flags to s_flags
f25391ebb475d3 Lukas Czerner      2020-07-23  5892  	 */
f25391ebb475d3 Lukas Czerner      2020-07-23  5893  	vfs_flags = SB_LAZYTIME | SB_I_VERSION;
f25391ebb475d3 Lukas Czerner      2020-07-23  5894  	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
f25391ebb475d3 Lukas Czerner      2020-07-23  5895  
b237e3044450fc Harshad Shirwadkar 2021-04-01  5896  	if (!parse_options(data, sb, &parsed_opts, 1)) {
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5897  		err = -EINVAL;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5898  		goto restore_opts;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5899  	}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5900  
6b992ff2565836 Darrick J. Wong    2014-10-30  5901  	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
c6d3d56dd0ef6c Darrick J. Wong    2014-11-25  5902  	    test_opt(sb, JOURNAL_CHECKSUM)) {
c6d3d56dd0ef6c Darrick J. Wong    2014-11-25  5903  		ext4_msg(sb, KERN_ERR, "changing journal_checksum "
2d5b86e048780c Eric Sandeen       2015-02-12  5904  			 "during remount not supported; ignoring");
2d5b86e048780c Eric Sandeen       2015-02-12  5905  		sbi->s_mount_opt ^= EXT4_MOUNT_JOURNAL_CHECKSUM;
6b992ff2565836 Darrick J. Wong    2014-10-30  5906  	}
6b992ff2565836 Darrick J. Wong    2014-10-30  5907  
6ae6514b33f941 Piotr Sarna        2013-08-08  5908  	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
6ae6514b33f941 Piotr Sarna        2013-08-08  5909  		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
6ae6514b33f941 Piotr Sarna        2013-08-08  5910  			ext4_msg(sb, KERN_ERR, "can't mount with "
6ae6514b33f941 Piotr Sarna        2013-08-08  5911  				 "both data=journal and delalloc");
6ae6514b33f941 Piotr Sarna        2013-08-08  5912  			err = -EINVAL;
6ae6514b33f941 Piotr Sarna        2013-08-08  5913  			goto restore_opts;
6ae6514b33f941 Piotr Sarna        2013-08-08  5914  		}
6ae6514b33f941 Piotr Sarna        2013-08-08  5915  		if (test_opt(sb, DIOREAD_NOLOCK)) {
6ae6514b33f941 Piotr Sarna        2013-08-08  5916  			ext4_msg(sb, KERN_ERR, "can't mount with "
6ae6514b33f941 Piotr Sarna        2013-08-08  5917  				 "both data=journal and dioread_nolock");
6ae6514b33f941 Piotr Sarna        2013-08-08  5918  			err = -EINVAL;
6ae6514b33f941 Piotr Sarna        2013-08-08  5919  			goto restore_opts;
6ae6514b33f941 Piotr Sarna        2013-08-08  5920  		}
ab04df78181b27 Jan Kara           2016-12-03  5921  	} else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA) {
ab04df78181b27 Jan Kara           2016-12-03  5922  		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
ab04df78181b27 Jan Kara           2016-12-03  5923  			ext4_msg(sb, KERN_ERR, "can't mount with "
ab04df78181b27 Jan Kara           2016-12-03  5924  				"journal_async_commit in data=ordered mode");
ab04df78181b27 Jan Kara           2016-12-03  5925  			err = -EINVAL;
ab04df78181b27 Jan Kara           2016-12-03  5926  			goto restore_opts;
ab04df78181b27 Jan Kara           2016-12-03  5927  		}
923ae0ff925043 Ross Zwisler       2015-02-16  5928  	}
923ae0ff925043 Ross Zwisler       2015-02-16  5929  
cdb7ee4c632759 Tahsin Erdogan     2017-06-22  5930  	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_NO_MBCACHE) {
cdb7ee4c632759 Tahsin Erdogan     2017-06-22  5931  		ext4_msg(sb, KERN_ERR, "can't enable nombcache during remount");
cdb7ee4c632759 Tahsin Erdogan     2017-06-22  5932  		err = -EINVAL;
cdb7ee4c632759 Tahsin Erdogan     2017-06-22  5933  		goto restore_opts;
cdb7ee4c632759 Tahsin Erdogan     2017-06-22  5934  	}
cdb7ee4c632759 Tahsin Erdogan     2017-06-22  5935  
9b5f6c9b83d912 Harshad Shirwadkar 2020-11-05  5936  	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
54d3adbc29f0c7 Theodore Ts'o      2020-03-28  5937  		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5938  
1751e8a6cb935e Linus Torvalds     2017-11-27  5939  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
1751e8a6cb935e Linus Torvalds     2017-11-27  5940  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5941  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5942  	es = sbi->s_es;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5943  
b3881f74b31b7d Theodore Ts'o      2009-01-05  5944  	if (sbi->s_journal) {
617ba13b31fbf5 Mingming Cao       2006-10-11  5945  		ext4_init_journal_params(sb, sbi->s_journal);
b237e3044450fc Harshad Shirwadkar 2021-04-01  5946  		set_task_ioprio(sbi->s_journal->j_task, parsed_opts.journal_ioprio);
b3881f74b31b7d Theodore Ts'o      2009-01-05  5947  	}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5948  
c92dc856848f32 Jan Kara           2020-11-27  5949  	/* Flush outstanding errors before changing fs state */
c92dc856848f32 Jan Kara           2020-11-27  5950  	flush_work(&sbi->s_error_work);
c92dc856848f32 Jan Kara           2020-11-27  5951  
1751e8a6cb935e Linus Torvalds     2017-11-27  5952  	if ((bool)(*flags & SB_RDONLY) != sb_rdonly(sb)) {
9b5f6c9b83d912 Harshad Shirwadkar 2020-11-05  5953  		if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED)) {
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5954  			err = -EROFS;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5955  			goto restore_opts;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5956  		}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5957  
1751e8a6cb935e Linus Torvalds     2017-11-27  5958  		if (*flags & SB_RDONLY) {
38c03b34391dd2 Theodore Ts'o      2014-03-13  5959  			err = sync_filesystem(sb);
38c03b34391dd2 Theodore Ts'o      2014-03-13  5960  			if (err < 0)
38c03b34391dd2 Theodore Ts'o      2014-03-13  5961  				goto restore_opts;
0f0dd62fddcbd0 Christoph Hellwig  2010-05-19  5962  			err = dquot_suspend(sb, -1);
0f0dd62fddcbd0 Christoph Hellwig  2010-05-19  5963  			if (err < 0)
c79d967de3741c Christoph Hellwig  2010-05-19  5964  				goto restore_opts;
c79d967de3741c Christoph Hellwig  2010-05-19  5965  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5966  			/*
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5967  			 * First of all, the unconditional stuff we have to do
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5968  			 * to disable replay of the journal when we next remount
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5969  			 */
1751e8a6cb935e Linus Torvalds     2017-11-27  5970  			sb->s_flags |= SB_RDONLY;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5971  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5972  			/*
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5973  			 * OK, test if we are remounting a valid rw partition
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5974  			 * readonly, and if so set the rdonly flag and then
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5975  			 * mark the partition as valid again.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5976  			 */
617ba13b31fbf5 Mingming Cao       2006-10-11  5977  			if (!(es->s_state & cpu_to_le16(EXT4_VALID_FS)) &&
617ba13b31fbf5 Mingming Cao       2006-10-11  5978  			    (sbi->s_mount_state & EXT4_VALID_FS))
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5979  				es->s_state = cpu_to_le16(sbi->s_mount_state);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5980  
11215630aada28 Jan Kara           2020-07-10  5981  			if (sbi->s_journal) {
11215630aada28 Jan Kara           2020-07-10  5982  				/*
11215630aada28 Jan Kara           2020-07-10  5983  				 * We let remount-ro finish even if marking fs
11215630aada28 Jan Kara           2020-07-10  5984  				 * as clean failed...
11215630aada28 Jan Kara           2020-07-10  5985  				 */
617ba13b31fbf5 Mingming Cao       2006-10-11  5986  				ext4_mark_recovery_complete(sb, es);
11215630aada28 Jan Kara           2020-07-10  5987  			}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5988  		} else {
a13fb1a4533f26 Eric Sandeen       2009-08-18  5989  			/* Make sure we can mount this feature set readwrite */
e2b911c53584a9 Darrick J. Wong    2015-10-17  5990  			if (ext4_has_feature_readonly(sb) ||
2cb5cc8b09c939 Darrick J. Wong    2015-02-12  5991  			    !ext4_feature_set_ok(sb, 0)) {
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5992  				err = -EROFS;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5993  				goto restore_opts;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5994  			}
8a266467b8c484 Theodore Ts'o      2008-07-26  5995  			/*
8a266467b8c484 Theodore Ts'o      2008-07-26  5996  			 * Make sure the group descriptor checksums
0b8e58a140cae2 Andreas Dilger     2009-06-03  5997  			 * are sane.  If they aren't, refuse to remount r/w.
8a266467b8c484 Theodore Ts'o      2008-07-26  5998  			 */
8a266467b8c484 Theodore Ts'o      2008-07-26  5999  			for (g = 0; g < sbi->s_groups_count; g++) {
8a266467b8c484 Theodore Ts'o      2008-07-26  6000  				struct ext4_group_desc *gdp =
8a266467b8c484 Theodore Ts'o      2008-07-26  6001  					ext4_get_group_desc(sb, g, NULL);
8a266467b8c484 Theodore Ts'o      2008-07-26  6002  
feb0ab32a57e4e Darrick J. Wong    2012-04-29  6003  				if (!ext4_group_desc_csum_verify(sb, g, gdp)) {
b31e15527a9bb7 Eric Sandeen       2009-06-04  6004  					ext4_msg(sb, KERN_ERR,
b31e15527a9bb7 Eric Sandeen       2009-06-04  6005  	       "ext4_remount: Checksum for group %u failed (%u!=%u)",
e2b911c53584a9 Darrick J. Wong    2015-10-17  6006  		g, le16_to_cpu(ext4_group_desc_csum(sb, g, gdp)),
8a266467b8c484 Theodore Ts'o      2008-07-26  6007  					       le16_to_cpu(gdp->bg_checksum));
6a797d27378389 Darrick J. Wong    2015-10-17  6008  					err = -EFSBADCRC;
8a266467b8c484 Theodore Ts'o      2008-07-26  6009  					goto restore_opts;
8a266467b8c484 Theodore Ts'o      2008-07-26  6010  				}
8a266467b8c484 Theodore Ts'o      2008-07-26  6011  			}
8a266467b8c484 Theodore Ts'o      2008-07-26  6012  
ead6596b9e776a Eric Sandeen       2007-02-10  6013  			/*
ead6596b9e776a Eric Sandeen       2007-02-10  6014  			 * If we have an unprocessed orphan list hanging
ead6596b9e776a Eric Sandeen       2007-02-10  6015  			 * around from a previously readonly bdev mount,
ead6596b9e776a Eric Sandeen       2007-02-10  6016  			 * require a full umount/remount for now.
ead6596b9e776a Eric Sandeen       2007-02-10  6017  			 */
ead6596b9e776a Eric Sandeen       2007-02-10  6018  			if (es->s_last_orphan) {
b31e15527a9bb7 Eric Sandeen       2009-06-04  6019  				ext4_msg(sb, KERN_WARNING, "Couldn't "
ead6596b9e776a Eric Sandeen       2007-02-10  6020  				       "remount RDWR because of unprocessed "
ead6596b9e776a Eric Sandeen       2007-02-10  6021  				       "orphan inode list.  Please "
b31e15527a9bb7 Eric Sandeen       2009-06-04  6022  				       "umount/remount instead");
ead6596b9e776a Eric Sandeen       2007-02-10  6023  				err = -EINVAL;
ead6596b9e776a Eric Sandeen       2007-02-10  6024  				goto restore_opts;
ead6596b9e776a Eric Sandeen       2007-02-10  6025  			}
ead6596b9e776a Eric Sandeen       2007-02-10  6026  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6027  			/*
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6028  			 * Mounting a RDONLY partition read-write, so reread
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6029  			 * and store the current valid flag.  (It may have
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6030  			 * been changed by e2fsck since we originally mounted
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6031  			 * the partition.)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6032  			 */
11215630aada28 Jan Kara           2020-07-10  6033  			if (sbi->s_journal) {
11215630aada28 Jan Kara           2020-07-10  6034  				err = ext4_clear_journal_err(sb, es);
11215630aada28 Jan Kara           2020-07-10  6035  				if (err)
11215630aada28 Jan Kara           2020-07-10  6036  					goto restore_opts;
11215630aada28 Jan Kara           2020-07-10  6037  			}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6038  			sbi->s_mount_state = le16_to_cpu(es->s_state);
c89128a0083814 Jaegeuk Kim        2018-05-13  6039  
c89128a0083814 Jaegeuk Kim        2018-05-13  6040  			err = ext4_setup_super(sb, es, 0);
c89128a0083814 Jaegeuk Kim        2018-05-13  6041  			if (err)
c89128a0083814 Jaegeuk Kim        2018-05-13  6042  				goto restore_opts;
c89128a0083814 Jaegeuk Kim        2018-05-13  6043  
1751e8a6cb935e Linus Torvalds     2017-11-27  6044  			sb->s_flags &= ~SB_RDONLY;
e2b911c53584a9 Darrick J. Wong    2015-10-17  6045  			if (ext4_has_feature_mmp(sb))
c5e06d101aaf72 Johann Lombardi    2011-05-24  6046  				if (ext4_multi_mount_protect(sb,
c5e06d101aaf72 Johann Lombardi    2011-05-24  6047  						le64_to_cpu(es->s_mmp_block))) {
c5e06d101aaf72 Johann Lombardi    2011-05-24  6048  					err = -EROFS;
c5e06d101aaf72 Johann Lombardi    2011-05-24  6049  					goto restore_opts;
c5e06d101aaf72 Johann Lombardi    2011-05-24  6050  				}
c79d967de3741c Christoph Hellwig  2010-05-19  6051  			enable_quota = 1;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6052  		}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6053  	}
bfff68738f1cb5 Lukas Czerner      2010-10-27  6054  
bfff68738f1cb5 Lukas Czerner      2010-10-27  6055  	/*
bfff68738f1cb5 Lukas Czerner      2010-10-27  6056  	 * Reinitialize lazy itable initialization thread based on
bfff68738f1cb5 Lukas Czerner      2010-10-27  6057  	 * current settings
bfff68738f1cb5 Lukas Czerner      2010-10-27  6058  	 */
bc98a42c1f7d0f David Howells      2017-07-17  6059  	if (sb_rdonly(sb) || !test_opt(sb, INIT_INODE_TABLE))
bfff68738f1cb5 Lukas Czerner      2010-10-27  6060  		ext4_unregister_li_request(sb);
bfff68738f1cb5 Lukas Czerner      2010-10-27  6061  	else {
bfff68738f1cb5 Lukas Czerner      2010-10-27  6062  		ext4_group_t first_not_zeroed;
bfff68738f1cb5 Lukas Czerner      2010-10-27  6063  		first_not_zeroed = ext4_has_uninit_itable(sb);
bfff68738f1cb5 Lukas Czerner      2010-10-27  6064  		ext4_register_li_request(sb, first_not_zeroed);
bfff68738f1cb5 Lukas Czerner      2010-10-27  6065  	}
bfff68738f1cb5 Lukas Czerner      2010-10-27  6066  
0f5bde1db174f6 Jan Kara           2020-07-28  6067  	/*
0f5bde1db174f6 Jan Kara           2020-07-28  6068  	 * Handle creation of system zone data early because it can fail.
0f5bde1db174f6 Jan Kara           2020-07-28  6069  	 * Releasing of existing data is done when we are sure remount will
0f5bde1db174f6 Jan Kara           2020-07-28  6070  	 * succeed.
0f5bde1db174f6 Jan Kara           2020-07-28  6071  	 */
dd0db94f305c9f Chunguang Xu       2020-09-24  6072  	if (test_opt(sb, BLOCK_VALIDITY) && !sbi->s_system_blks) {
d176b1f62f242a Jan Kara           2020-07-28  6073  		err = ext4_setup_system_zone(sb);
d176b1f62f242a Jan Kara           2020-07-28  6074  		if (err)
d176b1f62f242a Jan Kara           2020-07-28  6075  			goto restore_opts;
0f5bde1db174f6 Jan Kara           2020-07-28  6076  	}
d176b1f62f242a Jan Kara           2020-07-28  6077  
c89128a0083814 Jaegeuk Kim        2018-05-13  6078  	if (sbi->s_journal == NULL && !(old_sb_flags & SB_RDONLY)) {
4392fbc4bab57d Jan Kara           2020-12-16  6079  		err = ext4_commit_super(sb);
c89128a0083814 Jaegeuk Kim        2018-05-13  6080  		if (err)
c89128a0083814 Jaegeuk Kim        2018-05-13  6081  			goto restore_opts;
c89128a0083814 Jaegeuk Kim        2018-05-13  6082  	}
0390131ba84fd3 Frank Mayhar       2009-01-07  6083  

:::::: The code at line 5843 was first introduced by commit
:::::: c79d967de3741ceb60c5bbbf1b6f97eab9a89838 quota: move remount handling into the filesystem

:::::: TO: Christoph Hellwig <hch@infradead.org>
:::::: CC: Jan Kara <jack@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--YZ5djTAD1cGYuMQK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
J2jYFZwOnLYs5P8BHIo9lB3DAQA=

--YZ5djTAD1cGYuMQK--
