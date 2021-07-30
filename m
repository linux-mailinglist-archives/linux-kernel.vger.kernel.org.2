Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46CC3DB831
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhG3MFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:05:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:64431 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238724AbhG3MFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:05:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="234994792"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="gz'50?scan'50,208,50";a="234994792"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 05:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="gz'50?scan'50,208,50";a="667222914"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2021 05:05:40 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9RGl-0009xh-Ix; Fri, 30 Jul 2021 12:05:39 +0000
Date:   Fri, 30 Jul 2021 20:05:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hch-misc:dax-support-cleanups 6/7] fs/ext4/super.c:4438:6: error:
 implicit declaration of function 'bdev_dax_supported'; did you mean
 'dax_supported'?
Message-ID: <202107302022.mR7SHMkg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.infradead.org/users/hch/misc.git dax-support-cleanups
head:   109fe091fac0e3958ba459e292f22f6b60eb39f0
commit: 6ee1cc412315e2a92aa1b6b57e349f84ec4b1168 [6/7] dax: pass the dax_device to bdev_dax_supported
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
reproduce (this is a W=1 build):
        git remote add hch-misc git://git.infradead.org/users/hch/misc.git
        git fetch --no-tags hch-misc dax-support-cleanups
        git checkout 6ee1cc412315e2a92aa1b6b57e349f84ec4b1168
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ext4/super.c:41:
   include/linux/dax.h:153:39: error: unknown type name 'truct'; did you mean 'struct'?
     153 | static inline bool bdev_dax_supported(truct dax_device *dax_dev,
         |                                       ^~~~~
         |                                       struct
   fs/ext4/super.c: In function 'ext4_fill_super':
>> fs/ext4/super.c:4438:6: error: implicit declaration of function 'bdev_dax_supported'; did you mean 'dax_supported'? [-Werror=implicit-function-declaration]
    4438 |  if (bdev_dax_supported(dax_dev, sb->s_bdev, blocksize))
         |      ^~~~~~~~~~~~~~~~~~
         |      dax_supported
   cc1: some warnings being treated as errors


vim +4438 fs/ext4/super.c

  4332	
  4333		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
  4334			printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!\n");
  4335			/* can't mount with both data=journal and dioread_nolock. */
  4336			clear_opt(sb, DIOREAD_NOLOCK);
  4337			clear_opt2(sb, JOURNAL_FAST_COMMIT);
  4338			if (test_opt2(sb, EXPLICIT_DELALLOC)) {
  4339				ext4_msg(sb, KERN_ERR, "can't mount with "
  4340					 "both data=journal and delalloc");
  4341				goto failed_mount;
  4342			}
  4343			if (test_opt(sb, DAX_ALWAYS)) {
  4344				ext4_msg(sb, KERN_ERR, "can't mount with "
  4345					 "both data=journal and dax");
  4346				goto failed_mount;
  4347			}
  4348			if (ext4_has_feature_encrypt(sb)) {
  4349				ext4_msg(sb, KERN_WARNING,
  4350					 "encrypted files will use data=ordered "
  4351					 "instead of data journaling mode");
  4352			}
  4353			if (test_opt(sb, DELALLOC))
  4354				clear_opt(sb, DELALLOC);
  4355		} else {
  4356			sb->s_iflags |= SB_I_CGROUPWB;
  4357		}
  4358	
  4359		sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
  4360			(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
  4361	
  4362		if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
  4363		    (ext4_has_compat_features(sb) ||
  4364		     ext4_has_ro_compat_features(sb) ||
  4365		     ext4_has_incompat_features(sb)))
  4366			ext4_msg(sb, KERN_WARNING,
  4367			       "feature flags set on rev 0 fs, "
  4368			       "running e2fsck is recommended");
  4369	
  4370		if (es->s_creator_os == cpu_to_le32(EXT4_OS_HURD)) {
  4371			set_opt2(sb, HURD_COMPAT);
  4372			if (ext4_has_feature_64bit(sb)) {
  4373				ext4_msg(sb, KERN_ERR,
  4374					 "The Hurd can't support 64-bit file systems");
  4375				goto failed_mount;
  4376			}
  4377	
  4378			/*
  4379			 * ea_inode feature uses l_i_version field which is not
  4380			 * available in HURD_COMPAT mode.
  4381			 */
  4382			if (ext4_has_feature_ea_inode(sb)) {
  4383				ext4_msg(sb, KERN_ERR,
  4384					 "ea_inode feature is not supported for Hurd");
  4385				goto failed_mount;
  4386			}
  4387		}
  4388	
  4389		if (IS_EXT2_SB(sb)) {
  4390			if (ext2_feature_set_ok(sb))
  4391				ext4_msg(sb, KERN_INFO, "mounting ext2 file system "
  4392					 "using the ext4 subsystem");
  4393			else {
  4394				/*
  4395				 * If we're probing be silent, if this looks like
  4396				 * it's actually an ext[34] filesystem.
  4397				 */
  4398				if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
  4399					goto failed_mount;
  4400				ext4_msg(sb, KERN_ERR, "couldn't mount as ext2 due "
  4401					 "to feature incompatibilities");
  4402				goto failed_mount;
  4403			}
  4404		}
  4405	
  4406		if (IS_EXT3_SB(sb)) {
  4407			if (ext3_feature_set_ok(sb))
  4408				ext4_msg(sb, KERN_INFO, "mounting ext3 file system "
  4409					 "using the ext4 subsystem");
  4410			else {
  4411				/*
  4412				 * If we're probing be silent, if this looks like
  4413				 * it's actually an ext4 filesystem.
  4414				 */
  4415				if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
  4416					goto failed_mount;
  4417				ext4_msg(sb, KERN_ERR, "couldn't mount as ext3 due "
  4418					 "to feature incompatibilities");
  4419				goto failed_mount;
  4420			}
  4421		}
  4422	
  4423		/*
  4424		 * Check feature flags regardless of the revision level, since we
  4425		 * previously didn't change the revision level when setting the flags,
  4426		 * so there is a chance incompat flags are set on a rev 0 filesystem.
  4427		 */
  4428		if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
  4429			goto failed_mount;
  4430	
  4431		if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (blocksize / 4)) {
  4432			ext4_msg(sb, KERN_ERR,
  4433				 "Number of reserved GDT blocks insanely large: %d",
  4434				 le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks));
  4435			goto failed_mount;
  4436		}
  4437	
> 4438		if (bdev_dax_supported(dax_dev, sb->s_bdev, blocksize))
  4439			set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
  4440	
  4441		if (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) {
  4442			if (ext4_has_feature_inline_data(sb)) {
  4443				ext4_msg(sb, KERN_ERR, "Cannot use DAX on a filesystem"
  4444						" that may contain inline data");
  4445				goto failed_mount;
  4446			}
  4447			if (!test_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags)) {
  4448				ext4_msg(sb, KERN_ERR,
  4449					"DAX unsupported by block device.");
  4450				goto failed_mount;
  4451			}
  4452		}
  4453	
  4454		if (ext4_has_feature_encrypt(sb) && es->s_encryption_level) {
  4455			ext4_msg(sb, KERN_ERR, "Unsupported encryption level %d",
  4456				 es->s_encryption_level);
  4457			goto failed_mount;
  4458		}
  4459	
  4460		if (sb->s_blocksize != blocksize) {
  4461			/*
  4462			 * bh must be released before kill_bdev(), otherwise
  4463			 * it won't be freed and its page also. kill_bdev()
  4464			 * is called by sb_set_blocksize().
  4465			 */
  4466			brelse(bh);
  4467			/* Validate the filesystem blocksize */
  4468			if (!sb_set_blocksize(sb, blocksize)) {
  4469				ext4_msg(sb, KERN_ERR, "bad block size %d",
  4470						blocksize);
  4471				bh = NULL;
  4472				goto failed_mount;
  4473			}
  4474	
  4475			logical_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
  4476			offset = do_div(logical_sb_block, blocksize);
  4477			bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
  4478			if (IS_ERR(bh)) {
  4479				ext4_msg(sb, KERN_ERR,
  4480				       "Can't read superblock on 2nd try");
  4481				ret = PTR_ERR(bh);
  4482				bh = NULL;
  4483				goto failed_mount;
  4484			}
  4485			es = (struct ext4_super_block *)(bh->b_data + offset);
  4486			sbi->s_es = es;
  4487			if (es->s_magic != cpu_to_le16(EXT4_SUPER_MAGIC)) {
  4488				ext4_msg(sb, KERN_ERR,
  4489				       "Magic mismatch, very weird!");
  4490				goto failed_mount;
  4491			}
  4492		}
  4493	
  4494		has_huge_files = ext4_has_feature_huge_file(sb);
  4495		sbi->s_bitmap_maxbytes = ext4_max_bitmap_size(sb->s_blocksize_bits,
  4496							      has_huge_files);
  4497		sb->s_maxbytes = ext4_max_size(sb->s_blocksize_bits, has_huge_files);
  4498	
  4499		sbi->s_desc_size = le16_to_cpu(es->s_desc_size);
  4500		if (ext4_has_feature_64bit(sb)) {
  4501			if (sbi->s_desc_size < EXT4_MIN_DESC_SIZE_64BIT ||
  4502			    sbi->s_desc_size > EXT4_MAX_DESC_SIZE ||
  4503			    !is_power_of_2(sbi->s_desc_size)) {
  4504				ext4_msg(sb, KERN_ERR,
  4505				       "unsupported descriptor size %lu",
  4506				       sbi->s_desc_size);
  4507				goto failed_mount;
  4508			}
  4509		} else
  4510			sbi->s_desc_size = EXT4_MIN_DESC_SIZE;
  4511	
  4512		sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
  4513		sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
  4514	
  4515		sbi->s_inodes_per_block = blocksize / EXT4_INODE_SIZE(sb);
  4516		if (sbi->s_inodes_per_block == 0)
  4517			goto cantfind_ext4;
  4518		if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
  4519		    sbi->s_inodes_per_group > blocksize * 8) {
  4520			ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
  4521				 sbi->s_inodes_per_group);
  4522			goto failed_mount;
  4523		}
  4524		sbi->s_itb_per_group = sbi->s_inodes_per_group /
  4525						sbi->s_inodes_per_block;
  4526		sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
  4527		sbi->s_sbh = bh;
  4528		sbi->s_mount_state = le16_to_cpu(es->s_state);
  4529		sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
  4530		sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
  4531	
  4532		for (i = 0; i < 4; i++)
  4533			sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
  4534		sbi->s_def_hash_version = es->s_def_hash_version;
  4535		if (ext4_has_feature_dir_index(sb)) {
  4536			i = le32_to_cpu(es->s_flags);
  4537			if (i & EXT2_FLAGS_UNSIGNED_HASH)
  4538				sbi->s_hash_unsigned = 3;
  4539			else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
  4540	#ifdef __CHAR_UNSIGNED__
  4541				if (!sb_rdonly(sb))
  4542					es->s_flags |=
  4543						cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
  4544				sbi->s_hash_unsigned = 3;
  4545	#else
  4546				if (!sb_rdonly(sb))
  4547					es->s_flags |=
  4548						cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
  4549	#endif
  4550			}
  4551		}
  4552	
  4553		/* Handle clustersize */
  4554		clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
  4555		if (ext4_has_feature_bigalloc(sb)) {
  4556			if (clustersize < blocksize) {
  4557				ext4_msg(sb, KERN_ERR,
  4558					 "cluster size (%d) smaller than "
  4559					 "block size (%d)", clustersize, blocksize);
  4560				goto failed_mount;
  4561			}
  4562			sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
  4563				le32_to_cpu(es->s_log_block_size);
  4564			sbi->s_clusters_per_group =
  4565				le32_to_cpu(es->s_clusters_per_group);
  4566			if (sbi->s_clusters_per_group > blocksize * 8) {
  4567				ext4_msg(sb, KERN_ERR,
  4568					 "#clusters per group too big: %lu",
  4569					 sbi->s_clusters_per_group);
  4570				goto failed_mount;
  4571			}
  4572			if (sbi->s_blocks_per_group !=
  4573			    (sbi->s_clusters_per_group * (clustersize / blocksize))) {
  4574				ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
  4575					 "clusters per group (%lu) inconsistent",
  4576					 sbi->s_blocks_per_group,
  4577					 sbi->s_clusters_per_group);
  4578				goto failed_mount;
  4579			}
  4580		} else {
  4581			if (clustersize != blocksize) {
  4582				ext4_msg(sb, KERN_ERR,
  4583					 "fragment/cluster size (%d) != "
  4584					 "block size (%d)", clustersize, blocksize);
  4585				goto failed_mount;
  4586			}
  4587			if (sbi->s_blocks_per_group > blocksize * 8) {
  4588				ext4_msg(sb, KERN_ERR,
  4589					 "#blocks per group too big: %lu",
  4590					 sbi->s_blocks_per_group);
  4591				goto failed_mount;
  4592			}
  4593			sbi->s_clusters_per_group = sbi->s_blocks_per_group;
  4594			sbi->s_cluster_bits = 0;
  4595		}
  4596		sbi->s_cluster_ratio = clustersize / blocksize;
  4597	
  4598		/* Do we have standard group size of clustersize * 8 blocks ? */
  4599		if (sbi->s_blocks_per_group == clustersize << 3)
  4600			set_opt2(sb, STD_GROUP_SIZE);
  4601	
  4602		/*
  4603		 * Test whether we have more sectors than will fit in sector_t,
  4604		 * and whether the max offset is addressable by the page cache.
  4605		 */
  4606		err = generic_check_addressable(sb->s_blocksize_bits,
  4607						ext4_blocks_count(es));
  4608		if (err) {
  4609			ext4_msg(sb, KERN_ERR, "filesystem"
  4610				 " too large to mount safely on this system");
  4611			goto failed_mount;
  4612		}
  4613	
  4614		if (EXT4_BLOCKS_PER_GROUP(sb) == 0)
  4615			goto cantfind_ext4;
  4616	
  4617		/* check blocks count against device size */
  4618		blocks_count = sb->s_bdev->bd_inode->i_size >> sb->s_blocksize_bits;
  4619		if (blocks_count && ext4_blocks_count(es) > blocks_count) {
  4620			ext4_msg(sb, KERN_WARNING, "bad geometry: block count %llu "
  4621			       "exceeds size of device (%llu blocks)",
  4622			       ext4_blocks_count(es), blocks_count);
  4623			goto failed_mount;
  4624		}
  4625	
  4626		/*
  4627		 * It makes no sense for the first data block to be beyond the end
  4628		 * of the filesystem.
  4629		 */
  4630		if (le32_to_cpu(es->s_first_data_block) >= ext4_blocks_count(es)) {
  4631			ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
  4632				 "block %u is beyond end of filesystem (%llu)",
  4633				 le32_to_cpu(es->s_first_data_block),
  4634				 ext4_blocks_count(es));
  4635			goto failed_mount;
  4636		}
  4637		if ((es->s_first_data_block == 0) && (es->s_log_block_size == 0) &&
  4638		    (sbi->s_cluster_ratio == 1)) {
  4639			ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
  4640				 "block is 0 with a 1k block and cluster size");
  4641			goto failed_mount;
  4642		}
  4643	
  4644		blocks_count = (ext4_blocks_count(es) -
  4645				le32_to_cpu(es->s_first_data_block) +
  4646				EXT4_BLOCKS_PER_GROUP(sb) - 1);
  4647		do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
  4648		if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
  4649			ext4_msg(sb, KERN_WARNING, "groups count too large: %llu "
  4650			       "(block count %llu, first data block %u, "
  4651			       "blocks per group %lu)", blocks_count,
  4652			       ext4_blocks_count(es),
  4653			       le32_to_cpu(es->s_first_data_block),
  4654			       EXT4_BLOCKS_PER_GROUP(sb));
  4655			goto failed_mount;
  4656		}
  4657		sbi->s_groups_count = blocks_count;
  4658		sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
  4659				(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
  4660		if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
  4661		    le32_to_cpu(es->s_inodes_count)) {
  4662			ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
  4663				 le32_to_cpu(es->s_inodes_count),
  4664				 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
  4665			ret = -EINVAL;
  4666			goto failed_mount;
  4667		}
  4668		db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
  4669			   EXT4_DESC_PER_BLOCK(sb);
  4670		if (ext4_has_feature_meta_bg(sb)) {
  4671			if (le32_to_cpu(es->s_first_meta_bg) > db_count) {
  4672				ext4_msg(sb, KERN_WARNING,
  4673					 "first meta block group too large: %u "
  4674					 "(group descriptor block count %u)",
  4675					 le32_to_cpu(es->s_first_meta_bg), db_count);
  4676				goto failed_mount;
  4677			}
  4678		}
  4679		rcu_assign_pointer(sbi->s_group_desc,
  4680				   kvmalloc_array(db_count,
  4681						  sizeof(struct buffer_head *),
  4682						  GFP_KERNEL));
  4683		if (sbi->s_group_desc == NULL) {
  4684			ext4_msg(sb, KERN_ERR, "not enough memory");
  4685			ret = -ENOMEM;
  4686			goto failed_mount;
  4687		}
  4688	
  4689		bgl_lock_init(sbi->s_blockgroup_lock);
  4690	
  4691		/* Pre-read the descriptors into the buffer cache */
  4692		for (i = 0; i < db_count; i++) {
  4693			block = descriptor_loc(sb, logical_sb_block, i);
  4694			ext4_sb_breadahead_unmovable(sb, block);
  4695		}
  4696	
  4697		for (i = 0; i < db_count; i++) {
  4698			struct buffer_head *bh;
  4699	
  4700			block = descriptor_loc(sb, logical_sb_block, i);
  4701			bh = ext4_sb_bread_unmovable(sb, block);
  4702			if (IS_ERR(bh)) {
  4703				ext4_msg(sb, KERN_ERR,
  4704				       "can't read group descriptor %d", i);
  4705				db_count = i;
  4706				ret = PTR_ERR(bh);
  4707				goto failed_mount2;
  4708			}
  4709			rcu_read_lock();
  4710			rcu_dereference(sbi->s_group_desc)[i] = bh;
  4711			rcu_read_unlock();
  4712		}
  4713		sbi->s_gdb_count = db_count;
  4714		if (!ext4_check_descriptors(sb, logical_sb_block, &first_not_zeroed)) {
  4715			ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
  4716			ret = -EFSCORRUPTED;
  4717			goto failed_mount2;
  4718		}
  4719	
  4720		timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
  4721		spin_lock_init(&sbi->s_error_lock);
  4722		INIT_WORK(&sbi->s_error_work, flush_stashed_error_work);
  4723	
  4724		/* Register extent status tree shrinker */
  4725		if (ext4_es_register_shrinker(sbi))
  4726			goto failed_mount3;
  4727	
  4728		sbi->s_stripe = ext4_get_stripe_size(sbi);
  4729		sbi->s_extent_max_zeroout_kb = 32;
  4730	
  4731		/*
  4732		 * set up enough so that it can read an inode
  4733		 */
  4734		sb->s_op = &ext4_sops;
  4735		sb->s_export_op = &ext4_export_ops;
  4736		sb->s_xattr = ext4_xattr_handlers;
  4737	#ifdef CONFIG_FS_ENCRYPTION
  4738		sb->s_cop = &ext4_cryptops;
  4739	#endif
  4740	#ifdef CONFIG_FS_VERITY
  4741		sb->s_vop = &ext4_verityops;
  4742	#endif
  4743	#ifdef CONFIG_QUOTA
  4744		sb->dq_op = &ext4_quota_operations;
  4745		if (ext4_has_feature_quota(sb))
  4746			sb->s_qcop = &dquot_quotactl_sysfile_ops;
  4747		else
  4748			sb->s_qcop = &ext4_qctl_operations;
  4749		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
  4750	#endif
  4751		memcpy(&sb->s_uuid, es->s_uuid, sizeof(es->s_uuid));
  4752	
  4753		INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
  4754		mutex_init(&sbi->s_orphan_lock);
  4755	
  4756		/* Initialize fast commit stuff */
  4757		atomic_set(&sbi->s_fc_subtid, 0);
  4758		atomic_set(&sbi->s_fc_ineligible_updates, 0);
  4759		INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_MAIN]);
  4760		INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_STAGING]);
  4761		INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_MAIN]);
  4762		INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
  4763		sbi->s_fc_bytes = 0;
  4764		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
  4765		ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
  4766		spin_lock_init(&sbi->s_fc_lock);
  4767		memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
  4768		sbi->s_fc_replay_state.fc_regions = NULL;
  4769		sbi->s_fc_replay_state.fc_regions_size = 0;
  4770		sbi->s_fc_replay_state.fc_regions_used = 0;
  4771		sbi->s_fc_replay_state.fc_regions_valid = 0;
  4772		sbi->s_fc_replay_state.fc_modified_inodes = NULL;
  4773		sbi->s_fc_replay_state.fc_modified_inodes_size = 0;
  4774		sbi->s_fc_replay_state.fc_modified_inodes_used = 0;
  4775	
  4776		sb->s_root = NULL;
  4777	
  4778		needs_recovery = (es->s_last_orphan != 0 ||
  4779				  ext4_has_feature_journal_needs_recovery(sb));
  4780	
  4781		if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
  4782			if (ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block)))
  4783				goto failed_mount3a;
  4784	
  4785		/*
  4786		 * The first inode we look at is the journal inode.  Don't try
  4787		 * root first: it may be modified in the journal!
  4788		 */
  4789		if (!test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb)) {
  4790			err = ext4_load_journal(sb, es, parsed_opts.journal_devnum);
  4791			if (err)
  4792				goto failed_mount3a;
  4793		} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
  4794			   ext4_has_feature_journal_needs_recovery(sb)) {
  4795			ext4_msg(sb, KERN_ERR, "required journal recovery "
  4796			       "suppressed and not mounted read-only");
  4797			goto failed_mount_wq;
  4798		} else {
  4799			/* Nojournal mode, all journal mount options are illegal */
  4800			if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
  4801				ext4_msg(sb, KERN_ERR, "can't mount with "
  4802					 "journal_checksum, fs mounted w/o journal");
  4803				goto failed_mount_wq;
  4804			}
  4805			if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
  4806				ext4_msg(sb, KERN_ERR, "can't mount with "
  4807					 "journal_async_commit, fs mounted w/o journal");
  4808				goto failed_mount_wq;
  4809			}
  4810			if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
  4811				ext4_msg(sb, KERN_ERR, "can't mount with "
  4812					 "commit=%lu, fs mounted w/o journal",
  4813					 sbi->s_commit_interval / HZ);
  4814				goto failed_mount_wq;
  4815			}
  4816			if (EXT4_MOUNT_DATA_FLAGS &
  4817			    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
  4818				ext4_msg(sb, KERN_ERR, "can't mount with "
  4819					 "data=, fs mounted w/o journal");
  4820				goto failed_mount_wq;
  4821			}
  4822			sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
  4823			clear_opt(sb, JOURNAL_CHECKSUM);
  4824			clear_opt(sb, DATA_FLAGS);
  4825			clear_opt2(sb, JOURNAL_FAST_COMMIT);
  4826			sbi->s_journal = NULL;
  4827			needs_recovery = 0;
  4828			goto no_journal;
  4829		}
  4830	
  4831		if (ext4_has_feature_64bit(sb) &&
  4832		    !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
  4833					       JBD2_FEATURE_INCOMPAT_64BIT)) {
  4834			ext4_msg(sb, KERN_ERR, "Failed to set 64-bit journal feature");
  4835			goto failed_mount_wq;
  4836		}
  4837	
  4838		if (!set_journal_csum_feature_set(sb)) {
  4839			ext4_msg(sb, KERN_ERR, "Failed to set journal checksum "
  4840				 "feature set");
  4841			goto failed_mount_wq;
  4842		}
  4843	
  4844		if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
  4845			!jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
  4846						  JBD2_FEATURE_INCOMPAT_FAST_COMMIT)) {
  4847			ext4_msg(sb, KERN_ERR,
  4848				"Failed to set fast commit journal feature");
  4849			goto failed_mount_wq;
  4850		}
  4851	
  4852		/* We have now updated the journal if required, so we can
  4853		 * validate the data journaling mode. */
  4854		switch (test_opt(sb, DATA_FLAGS)) {
  4855		case 0:
  4856			/* No mode set, assume a default based on the journal
  4857			 * capabilities: ORDERED_DATA if the journal can
  4858			 * cope, else JOURNAL_DATA
  4859			 */
  4860			if (jbd2_journal_check_available_features
  4861			    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
  4862				set_opt(sb, ORDERED_DATA);
  4863				sbi->s_def_mount_opt |= EXT4_MOUNT_ORDERED_DATA;
  4864			} else {
  4865				set_opt(sb, JOURNAL_DATA);
  4866				sbi->s_def_mount_opt |= EXT4_MOUNT_JOURNAL_DATA;
  4867			}
  4868			break;
  4869	
  4870		case EXT4_MOUNT_ORDERED_DATA:
  4871		case EXT4_MOUNT_WRITEBACK_DATA:
  4872			if (!jbd2_journal_check_available_features
  4873			    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
  4874				ext4_msg(sb, KERN_ERR, "Journal does not support "
  4875				       "requested data journaling mode");
  4876				goto failed_mount_wq;
  4877			}
  4878			break;
  4879		default:
  4880			break;
  4881		}
  4882	
  4883		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA &&
  4884		    test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
  4885			ext4_msg(sb, KERN_ERR, "can't mount with "
  4886				"journal_async_commit in data=ordered mode");
  4887			goto failed_mount_wq;
  4888		}
  4889	
  4890		set_task_ioprio(sbi->s_journal->j_task, parsed_opts.journal_ioprio);
  4891	
  4892		sbi->s_journal->j_submit_inode_data_buffers =
  4893			ext4_journal_submit_inode_data_buffers;
  4894		sbi->s_journal->j_finish_inode_data_buffers =
  4895			ext4_journal_finish_inode_data_buffers;
  4896	
  4897	no_journal:
  4898		if (!test_opt(sb, NO_MBCACHE)) {
  4899			sbi->s_ea_block_cache = ext4_xattr_create_cache();
  4900			if (!sbi->s_ea_block_cache) {
  4901				ext4_msg(sb, KERN_ERR,
  4902					 "Failed to create ea_block_cache");
  4903				goto failed_mount_wq;
  4904			}
  4905	
  4906			if (ext4_has_feature_ea_inode(sb)) {
  4907				sbi->s_ea_inode_cache = ext4_xattr_create_cache();
  4908				if (!sbi->s_ea_inode_cache) {
  4909					ext4_msg(sb, KERN_ERR,
  4910						 "Failed to create ea_inode_cache");
  4911					goto failed_mount_wq;
  4912				}
  4913			}
  4914		}
  4915	
  4916		if (ext4_has_feature_verity(sb) && blocksize != PAGE_SIZE) {
  4917			ext4_msg(sb, KERN_ERR, "Unsupported blocksize for fs-verity");
  4918			goto failed_mount_wq;
  4919		}
  4920	
  4921		if (DUMMY_ENCRYPTION_ENABLED(sbi) && !sb_rdonly(sb) &&
  4922		    !ext4_has_feature_encrypt(sb)) {
  4923			ext4_set_feature_encrypt(sb);
  4924			ext4_commit_super(sb);
  4925		}
  4926	
  4927		/*
  4928		 * Get the # of file system overhead blocks from the
  4929		 * superblock if present.
  4930		 */
  4931		if (es->s_overhead_clusters)
  4932			sbi->s_overhead = le32_to_cpu(es->s_overhead_clusters);
  4933		else {
  4934			err = ext4_calculate_overhead(sb);
  4935			if (err)
  4936				goto failed_mount_wq;
  4937		}
  4938	
  4939		/*
  4940		 * The maximum number of concurrent works can be high and
  4941		 * concurrency isn't really necessary.  Limit it to 1.
  4942		 */
  4943		EXT4_SB(sb)->rsv_conversion_wq =
  4944			alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
  4945		if (!EXT4_SB(sb)->rsv_conversion_wq) {
  4946			printk(KERN_ERR "EXT4-fs: failed to create workqueue\n");
  4947			ret = -ENOMEM;
  4948			goto failed_mount4;
  4949		}
  4950	
  4951		/*
  4952		 * The jbd2_journal_load will have done any necessary log recovery,
  4953		 * so we can safely mount the rest of the filesystem now.
  4954		 */
  4955	
  4956		root = ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL);
  4957		if (IS_ERR(root)) {
  4958			ext4_msg(sb, KERN_ERR, "get root inode failed");
  4959			ret = PTR_ERR(root);
  4960			root = NULL;
  4961			goto failed_mount4;
  4962		}
  4963		if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
  4964			ext4_msg(sb, KERN_ERR, "corrupt root inode, run e2fsck");
  4965			iput(root);
  4966			goto failed_mount4;
  4967		}
  4968	
  4969		sb->s_root = d_make_root(root);
  4970		if (!sb->s_root) {
  4971			ext4_msg(sb, KERN_ERR, "get root dentry failed");
  4972			ret = -ENOMEM;
  4973			goto failed_mount4;
  4974		}
  4975	
  4976		ret = ext4_setup_super(sb, es, sb_rdonly(sb));
  4977		if (ret == -EROFS) {
  4978			sb->s_flags |= SB_RDONLY;
  4979			ret = 0;
  4980		} else if (ret)
  4981			goto failed_mount4a;
  4982	
  4983		ext4_set_resv_clusters(sb);
  4984	
  4985		if (test_opt(sb, BLOCK_VALIDITY)) {
  4986			err = ext4_setup_system_zone(sb);
  4987			if (err) {
  4988				ext4_msg(sb, KERN_ERR, "failed to initialize system "
  4989					 "zone (%d)", err);
  4990				goto failed_mount4a;
  4991			}
  4992		}
  4993		ext4_fc_replay_cleanup(sb);
  4994	
  4995		ext4_ext_init(sb);
  4996	
  4997		/*
  4998		 * Enable optimize_scan if number of groups is > threshold. This can be
  4999		 * turned off by passing "mb_optimize_scan=0". This can also be
  5000		 * turned on forcefully by passing "mb_optimize_scan=1".
  5001		 */
  5002		if (parsed_opts.mb_optimize_scan == 1)
  5003			set_opt2(sb, MB_OPTIMIZE_SCAN);
  5004		else if (parsed_opts.mb_optimize_scan == 0)
  5005			clear_opt2(sb, MB_OPTIMIZE_SCAN);
  5006		else if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
  5007			set_opt2(sb, MB_OPTIMIZE_SCAN);
  5008	
  5009		err = ext4_mb_init(sb);
  5010		if (err) {
  5011			ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
  5012				 err);
  5013			goto failed_mount5;
  5014		}
  5015	
  5016		/*
  5017		 * We can only set up the journal commit callback once
  5018		 * mballoc is initialized
  5019		 */
  5020		if (sbi->s_journal)
  5021			sbi->s_journal->j_commit_callback =
  5022				ext4_journal_commit_callback;
  5023	
  5024		block = ext4_count_free_clusters(sb);
  5025		ext4_free_blocks_count_set(sbi->s_es,
  5026					   EXT4_C2B(sbi, block));
  5027		err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
  5028					  GFP_KERNEL);
  5029		if (!err) {
  5030			unsigned long freei = ext4_count_free_inodes(sb);
  5031			sbi->s_es->s_free_inodes_count = cpu_to_le32(freei);
  5032			err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
  5033						  GFP_KERNEL);
  5034		}
  5035		if (!err)
  5036			err = percpu_counter_init(&sbi->s_dirs_counter,
  5037						  ext4_count_dirs(sb), GFP_KERNEL);
  5038		if (!err)
  5039			err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
  5040						  GFP_KERNEL);
  5041		if (!err)
  5042			err = percpu_counter_init(&sbi->s_sra_exceeded_retry_limit, 0,
  5043						  GFP_KERNEL);
  5044		if (!err)
  5045			err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
  5046	
  5047		if (err) {
  5048			ext4_msg(sb, KERN_ERR, "insufficient memory");
  5049			goto failed_mount6;
  5050		}
  5051	
  5052		if (ext4_has_feature_flex_bg(sb))
  5053			if (!ext4_fill_flex_info(sb)) {
  5054				ext4_msg(sb, KERN_ERR,
  5055				       "unable to initialize "
  5056				       "flex_bg meta info!");
  5057				ret = -ENOMEM;
  5058				goto failed_mount6;
  5059			}
  5060	
  5061		err = ext4_register_li_request(sb, first_not_zeroed);
  5062		if (err)
  5063			goto failed_mount6;
  5064	
  5065		err = ext4_register_sysfs(sb);
  5066		if (err)
  5067			goto failed_mount7;
  5068	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
B7w51WcPlQAA

--+HP7ph2BbKc20aGI--
