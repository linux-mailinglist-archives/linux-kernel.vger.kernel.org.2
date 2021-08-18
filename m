Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A73F04CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhHRN2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:28:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:29426 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238123AbhHRN1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:27:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203517915"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="gz'50?scan'50,208,50";a="203517915"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 06:26:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="gz'50?scan'50,208,50";a="681037485"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2021 06:26:53 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGLan-000Swg-8C; Wed, 18 Aug 2021 13:26:53 +0000
Date:   Wed, 18 Aug 2021 21:25:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof-next:20210817-add-disk-error-handling-next 2/89]
 drivers/scsi/st.c:3830:38: error: 'struct scsi_tape' has no member named
 'disk'
Message-ID: <202108182124.WmAPrJzH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210817-add-disk-error-handling-next
head:   3d00c210d7fd616243af9cf41829f4a56f116ba8
commit: 7692839b26192b737a64c87970b6589e6a909d38 [2/89] st: do not allocate a gendisk
config: x86_64-randconfig-a006-20210816 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=7692839b26192b737a64c87970b6589e6a909d38
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20210817-add-disk-error-handling-next
        git checkout 7692839b26192b737a64c87970b6589e6a909d38
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/scsi/st.c: In function 'st_ioctl':
>> drivers/scsi/st.c:3830:38: error: 'struct scsi_tape' has no member named 'disk'
    3830 |  retval = scsi_ioctl(STp->device, STp->disk, file->f_mode, cmd_in, p);
         |                                      ^~


vim +3830 drivers/scsi/st.c

8038e6456a3e6f Kai Makisara      2016-02-09  3348  
8038e6456a3e6f Kai Makisara      2016-02-09  3349  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3350  /* Partition the tape into two partitions if size > 0 or one partition if
^1da177e4c3f41 Linus Torvalds    2005-04-16  3351     size == 0.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3352  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3353     The block descriptors are read and written because Sony SDT-7000 does not
^1da177e4c3f41 Linus Torvalds    2005-04-16  3354     work without this (suggestion from Michael Schaefer <Michael.Schaefer@dlr.de>).
^1da177e4c3f41 Linus Torvalds    2005-04-16  3355  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3356     My HP C1533A drive returns only one partition size field. This is used to
^1da177e4c3f41 Linus Torvalds    2005-04-16  3357     set the size of partition 1. There is no size field for the default partition.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3358     Michael Schaefer's Sony SDT-7000 returns two descriptors and the second is
^1da177e4c3f41 Linus Torvalds    2005-04-16  3359     used to set the size of partition 1 (this is what the SCSI-3 standard specifies).
^1da177e4c3f41 Linus Torvalds    2005-04-16  3360     The following algorithm is used to accommodate both drives: if the number of
^1da177e4c3f41 Linus Torvalds    2005-04-16  3361     partition size fields is greater than the maximum number of additional partitions
^1da177e4c3f41 Linus Torvalds    2005-04-16  3362     in the mode page, the second field is used. Otherwise the first field is used.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3363  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3364     For Seagate DDS drives the page length must be 8 when no partitions is defined
^1da177e4c3f41 Linus Torvalds    2005-04-16  3365     and 10 when 1 partition is defined (information from Eric Lee Green). This is
^1da177e4c3f41 Linus Torvalds    2005-04-16  3366     is acceptable also to some other old drives and enforced if the first partition
^1da177e4c3f41 Linus Torvalds    2005-04-16  3367     size field is used for the first additional partition size.
8038e6456a3e6f Kai Makisara      2016-02-09  3368  
8038e6456a3e6f Kai Makisara      2016-02-09  3369     For drives that advertize SCSI-3 or newer, use the SSC-3 methods.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3370   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3371  static int partition_tape(struct scsi_tape *STp, int size)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3372  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3373  	int result;
8038e6456a3e6f Kai Makisara      2016-02-09  3374  	int target_partition;
8038e6456a3e6f Kai Makisara      2016-02-09  3375  	bool scsi3 = STp->device->scsi_level >= SCSI_3, needs_format = false;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3376  	int pgo, psd_cnt, psdo;
8038e6456a3e6f Kai Makisara      2016-02-09  3377  	int psum = PP_MSK_PSUM_MB, units = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3378  	unsigned char *bp;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3379  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3380  	result = read_mode_page(STp, PART_PAGE, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3381  	if (result) {
b30d8bca5b525b Hannes Reinecke   2014-06-25  3382  		DEBC_printk(STp, "Can't read partition mode page.\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  3383  		return result;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3384  	}
8038e6456a3e6f Kai Makisara      2016-02-09  3385  	target_partition = 1;
8038e6456a3e6f Kai Makisara      2016-02-09  3386  	if (size < 0) {
8038e6456a3e6f Kai Makisara      2016-02-09  3387  		target_partition = 0;
8038e6456a3e6f Kai Makisara      2016-02-09  3388  		size = -size;
8038e6456a3e6f Kai Makisara      2016-02-09  3389  	}
8038e6456a3e6f Kai Makisara      2016-02-09  3390  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3391  	/* The mode page is in the buffer. Let's modify it and write it. */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3392  	bp = (STp->buffer)->b_data;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3393  	pgo = MODE_HEADER_LENGTH + bp[MH_OFF_BDESCS_LENGTH];
b30d8bca5b525b Hannes Reinecke   2014-06-25  3394  	DEBC_printk(STp, "Partition page length is %d bytes.\n",
b30d8bca5b525b Hannes Reinecke   2014-06-25  3395  		    bp[pgo + MP_OFF_PAGE_LENGTH] + 2);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3396  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3397  	psd_cnt = (bp[pgo + MP_OFF_PAGE_LENGTH] + 2 - PART_PAGE_FIXED_LENGTH) / 2;
8038e6456a3e6f Kai Makisara      2016-02-09  3398  
8038e6456a3e6f Kai Makisara      2016-02-09  3399  	if (scsi3) {
8038e6456a3e6f Kai Makisara      2016-02-09  3400  		needs_format = (bp[pgo + PP_OFF_FLAGS] & PP_MSK_POFM) != 0;
8038e6456a3e6f Kai Makisara      2016-02-09  3401  		if (needs_format && size == 0) {
8038e6456a3e6f Kai Makisara      2016-02-09  3402  			/* No need to write the mode page when clearing
8038e6456a3e6f Kai Makisara      2016-02-09  3403  			 *  partitioning
8038e6456a3e6f Kai Makisara      2016-02-09  3404  			 */
8038e6456a3e6f Kai Makisara      2016-02-09  3405  			DEBC_printk(STp, "Formatting tape with one partition.\n");
8038e6456a3e6f Kai Makisara      2016-02-09  3406  			result = format_medium(STp, 0);
8038e6456a3e6f Kai Makisara      2016-02-09  3407  			goto out;
8038e6456a3e6f Kai Makisara      2016-02-09  3408  		}
8038e6456a3e6f Kai Makisara      2016-02-09  3409  		if (needs_format)  /* Leave the old value for HP DATs claiming SCSI_3 */
8038e6456a3e6f Kai Makisara      2016-02-09  3410  			psd_cnt = 2;
8038e6456a3e6f Kai Makisara      2016-02-09  3411  		if ((bp[pgo + PP_OFF_FLAGS] & PP_MSK_PSUM_UNITS) == PP_MSK_PSUM_UNITS) {
8038e6456a3e6f Kai Makisara      2016-02-09  3412  			/* Use units scaling for large partitions if the device
8038e6456a3e6f Kai Makisara      2016-02-09  3413  			 * suggests it and no precision lost. Required for IBM
8038e6456a3e6f Kai Makisara      2016-02-09  3414  			 * TS1140/50 drives that don't support MB units.
8038e6456a3e6f Kai Makisara      2016-02-09  3415  			 */
8038e6456a3e6f Kai Makisara      2016-02-09  3416  			if (size >= 1000 && (size % 1000) == 0) {
8038e6456a3e6f Kai Makisara      2016-02-09  3417  				size /= 1000;
8038e6456a3e6f Kai Makisara      2016-02-09  3418  				psum = PP_MSK_PSUM_UNITS;
8038e6456a3e6f Kai Makisara      2016-02-09  3419  				units = 9; /* GB */
8038e6456a3e6f Kai Makisara      2016-02-09  3420  			}
8038e6456a3e6f Kai Makisara      2016-02-09  3421  		}
8038e6456a3e6f Kai Makisara      2016-02-09  3422  		/* Try it anyway if too large to specify in MB */
8038e6456a3e6f Kai Makisara      2016-02-09  3423  		if (psum == PP_MSK_PSUM_MB && size >= 65534) {
8038e6456a3e6f Kai Makisara      2016-02-09  3424  			size /= 1000;
8038e6456a3e6f Kai Makisara      2016-02-09  3425  			psum = PP_MSK_PSUM_UNITS;
8038e6456a3e6f Kai Makisara      2016-02-09  3426  			units = 9;  /* GB */
8038e6456a3e6f Kai Makisara      2016-02-09  3427  		}
8038e6456a3e6f Kai Makisara      2016-02-09  3428  	}
8038e6456a3e6f Kai Makisara      2016-02-09  3429  
8038e6456a3e6f Kai Makisara      2016-02-09  3430  	if (size >= 65535 ||  /* Does not fit into two bytes */
8038e6456a3e6f Kai Makisara      2016-02-09  3431  	    (target_partition == 0 && psd_cnt < 2)) {
8038e6456a3e6f Kai Makisara      2016-02-09  3432  		result = -EINVAL;
8038e6456a3e6f Kai Makisara      2016-02-09  3433  		goto out;
8038e6456a3e6f Kai Makisara      2016-02-09  3434  	}
8038e6456a3e6f Kai Makisara      2016-02-09  3435  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3436  	psdo = pgo + PART_PAGE_FIXED_LENGTH;
8038e6456a3e6f Kai Makisara      2016-02-09  3437  	/* The second condition is for HP DDS which use only one partition size
8038e6456a3e6f Kai Makisara      2016-02-09  3438  	 * descriptor
8038e6456a3e6f Kai Makisara      2016-02-09  3439  	 */
8038e6456a3e6f Kai Makisara      2016-02-09  3440  	if (target_partition > 0 &&
8038e6456a3e6f Kai Makisara      2016-02-09  3441  	    (psd_cnt > bp[pgo + PP_OFF_MAX_ADD_PARTS] ||
8038e6456a3e6f Kai Makisara      2016-02-09  3442  	     bp[pgo + PP_OFF_MAX_ADD_PARTS] != 1)) {
8038e6456a3e6f Kai Makisara      2016-02-09  3443  		bp[psdo] = bp[psdo + 1] = 0xff;  /* Rest to partition 0 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3444  		psdo += 2;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3445  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3446  	memset(bp + psdo, 0, bp[pgo + PP_OFF_NBR_ADD_PARTS] * 2);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3447  
b30d8bca5b525b Hannes Reinecke   2014-06-25  3448  	DEBC_printk(STp, "psd_cnt %d, max.parts %d, nbr_parts %d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3449  		    psd_cnt, bp[pgo + PP_OFF_MAX_ADD_PARTS],
b30d8bca5b525b Hannes Reinecke   2014-06-25  3450  		    bp[pgo + PP_OFF_NBR_ADD_PARTS]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3451  
8038e6456a3e6f Kai Makisara      2016-02-09  3452  	if (size == 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3453  		bp[pgo + PP_OFF_NBR_ADD_PARTS] = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3454  		if (psd_cnt <= bp[pgo + PP_OFF_MAX_ADD_PARTS])
^1da177e4c3f41 Linus Torvalds    2005-04-16  3455  		    bp[pgo + MP_OFF_PAGE_LENGTH] = 6;
b30d8bca5b525b Hannes Reinecke   2014-06-25  3456  		DEBC_printk(STp, "Formatting tape with one partition.\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  3457  	} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3458  		bp[psdo] = (size >> 8) & 0xff;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3459  		bp[psdo + 1] = size & 0xff;
8038e6456a3e6f Kai Makisara      2016-02-09  3460  		if (target_partition == 0)
8038e6456a3e6f Kai Makisara      2016-02-09  3461  			bp[psdo + 2] = bp[psdo + 3] = 0xff;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3462  		bp[pgo + 3] = 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3463  		if (bp[pgo + MP_OFF_PAGE_LENGTH] < 8)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3464  		    bp[pgo + MP_OFF_PAGE_LENGTH] = 8;
8038e6456a3e6f Kai Makisara      2016-02-09  3465  		DEBC_printk(STp,
8038e6456a3e6f Kai Makisara      2016-02-09  3466  			    "Formatting tape with two partitions (%i = %d MB).\n",
8038e6456a3e6f Kai Makisara      2016-02-09  3467  			    target_partition, units > 0 ? size * 1000 : size);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3468  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3469  	bp[pgo + PP_OFF_PART_UNITS] = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3470  	bp[pgo + PP_OFF_RESERVED] = 0;
8038e6456a3e6f Kai Makisara      2016-02-09  3471  	if (size != 1 || units != 0) {
8038e6456a3e6f Kai Makisara      2016-02-09  3472  		bp[pgo + PP_OFF_FLAGS] = PP_BIT_IDP | psum |
8038e6456a3e6f Kai Makisara      2016-02-09  3473  			(bp[pgo + PP_OFF_FLAGS] & 0x07);
8038e6456a3e6f Kai Makisara      2016-02-09  3474  		bp[pgo + PP_OFF_PART_UNITS] = units;
8038e6456a3e6f Kai Makisara      2016-02-09  3475  	} else
8038e6456a3e6f Kai Makisara      2016-02-09  3476  		bp[pgo + PP_OFF_FLAGS] = PP_BIT_FDP |
8038e6456a3e6f Kai Makisara      2016-02-09  3477  			(bp[pgo + PP_OFF_FLAGS] & 0x1f);
8038e6456a3e6f Kai Makisara      2016-02-09  3478  	bp[pgo + MP_OFF_PAGE_LENGTH] = 6 + psd_cnt * 2;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3479  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3480  	result = write_mode_page(STp, PART_PAGE, 1);
8038e6456a3e6f Kai Makisara      2016-02-09  3481  
8038e6456a3e6f Kai Makisara      2016-02-09  3482  	if (!result && needs_format)
8038e6456a3e6f Kai Makisara      2016-02-09  3483  		result = format_medium(STp, 1);
8038e6456a3e6f Kai Makisara      2016-02-09  3484  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3485  	if (result) {
b30d8bca5b525b Hannes Reinecke   2014-06-25  3486  		st_printk(KERN_INFO, STp, "Partitioning of tape failed.\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  3487  		result = (-EIO);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3488  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3489  
8038e6456a3e6f Kai Makisara      2016-02-09  3490  out:
^1da177e4c3f41 Linus Torvalds    2005-04-16  3491  	return result;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3492  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  3493  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3494  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3495  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3496  /* The ioctl command */
dba7688fc9037c Christoph Hellwig 2021-07-24  3497  static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3498  {
dba7688fc9037c Christoph Hellwig 2021-07-24  3499  	void __user *p = (void __user *)arg;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3500  	int i, cmd_nr, cmd_type, bt;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3501  	int retval = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3502  	unsigned int blk;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3503  	struct scsi_tape *STp = file->private_data;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3504  	struct st_modedef *STm;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3505  	struct st_partstat *STps;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3506  
28f85009e0cf6a Matthias Kaehlcke 2007-07-29  3507  	if (mutex_lock_interruptible(&STp->lock))
^1da177e4c3f41 Linus Torvalds    2005-04-16  3508  		return -ERESTARTSYS;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3509  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3510  	DEB(
^1da177e4c3f41 Linus Torvalds    2005-04-16  3511  	if (debugging && !STp->in_use) {
b30d8bca5b525b Hannes Reinecke   2014-06-25  3512  		st_printk(ST_DEB_MSG, STp, "Incorrect device.\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  3513  		retval = (-EIO);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3514  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3515  	} ) /* end DEB */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3516  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3517  	STm = &(STp->modes[STp->current_mode]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3518  	STps = &(STp->ps[STp->partition]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3519  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3520  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  3521  	 * If we are in the middle of error recovery, don't let anyone
^1da177e4c3f41 Linus Torvalds    2005-04-16  3522  	 * else try and use this device.  Also, if error recovery fails, it
^1da177e4c3f41 Linus Torvalds    2005-04-16  3523  	 * may try and take the device offline, in which case all further
^1da177e4c3f41 Linus Torvalds    2005-04-16  3524  	 * access to the device is prohibited.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3525  	 */
906d15fbd23c12 Christoph Hellwig 2014-10-11  3526  	retval = scsi_ioctl_block_when_processing_errors(STp->device, cmd_in,
83ff6fe8580a7c Al Viro           2008-03-02  3527  			file->f_flags & O_NDELAY);
906d15fbd23c12 Christoph Hellwig 2014-10-11  3528  	if (retval)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3529  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3530  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3531  	cmd_type = _IOC_TYPE(cmd_in);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3532  	cmd_nr = _IOC_NR(cmd_in);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3533  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3534  	if (cmd_type == _IOC_TYPE(MTIOCTOP) && cmd_nr == _IOC_NR(MTIOCTOP)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3535  		struct mtop mtc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3536  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3537  		if (_IOC_SIZE(cmd_in) != sizeof(mtc)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3538  			retval = (-EINVAL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3539  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3540  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3541  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3542  		i = copy_from_user(&mtc, p, sizeof(struct mtop));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3543  		if (i) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3544  			retval = (-EFAULT);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3545  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3546  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3547  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3548  		if (mtc.mt_op == MTSETDRVBUFFER && !capable(CAP_SYS_ADMIN)) {
b30d8bca5b525b Hannes Reinecke   2014-06-25  3549  			st_printk(KERN_WARNING, STp,
b30d8bca5b525b Hannes Reinecke   2014-06-25  3550  				  "MTSETDRVBUFFER only allowed for root.\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  3551  			retval = (-EPERM);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3552  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3553  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3554  		if (!STm->defined &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3555  		    (mtc.mt_op != MTSETDRVBUFFER &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3556  		     (mtc.mt_count & MT_ST_OPTIONS) == 0)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3557  			retval = (-ENXIO);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3558  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3559  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3560  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3561  		if (!STp->pos_unknown) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3562  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3563  			if (STps->eof == ST_FM_HIT) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3564  				if (mtc.mt_op == MTFSF || mtc.mt_op == MTFSFM ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3565                                      mtc.mt_op == MTEOM) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3566  					mtc.mt_count -= 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3567  					if (STps->drv_file >= 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3568  						STps->drv_file += 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3569  				} else if (mtc.mt_op == MTBSF || mtc.mt_op == MTBSFM) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3570  					mtc.mt_count += 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3571  					if (STps->drv_file >= 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3572  						STps->drv_file += 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3573  				}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3574  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3575  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3576  			if (mtc.mt_op == MTSEEK) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3577  				/* Old position must be restored if partition will be
^1da177e4c3f41 Linus Torvalds    2005-04-16  3578                                     changed */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3579  				i = !STp->can_partitions ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3580  				    (STp->new_partition != STp->partition);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3581  			} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3582  				i = mtc.mt_op == MTREW || mtc.mt_op == MTOFFL ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3583  				    mtc.mt_op == MTRETEN || mtc.mt_op == MTEOM ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3584  				    mtc.mt_op == MTLOCK || mtc.mt_op == MTLOAD ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3585  				    mtc.mt_op == MTFSF || mtc.mt_op == MTFSFM ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3586  				    mtc.mt_op == MTBSF || mtc.mt_op == MTBSFM ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3587  				    mtc.mt_op == MTCOMPRESSION;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3588  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3589  			i = flush_buffer(STp, i);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3590  			if (i < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3591  				retval = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3592  				goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3593  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3594  			if (STps->rw == ST_WRITING &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3595  			    (mtc.mt_op == MTREW || mtc.mt_op == MTOFFL ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3596  			     mtc.mt_op == MTSEEK ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3597  			     mtc.mt_op == MTBSF || mtc.mt_op == MTBSFM)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3598  				i = st_int_ioctl(STp, MTWEOF, 1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3599  				if (i < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3600  					retval = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3601  					goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3602  				}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3603  				if (mtc.mt_op == MTBSF || mtc.mt_op == MTBSFM)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3604  					mtc.mt_count++;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3605  				STps->rw = ST_IDLE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3606  			     }
^1da177e4c3f41 Linus Torvalds    2005-04-16  3607  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3608  		} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3609  			/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  3610  			 * If there was a bus reset, block further access
^1da177e4c3f41 Linus Torvalds    2005-04-16  3611  			 * to this device.  If the user wants to rewind the tape,
^1da177e4c3f41 Linus Torvalds    2005-04-16  3612  			 * then reset the flag and allow access again.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3613  			 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3614  			if (mtc.mt_op != MTREW &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3615  			    mtc.mt_op != MTOFFL &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3616  			    mtc.mt_op != MTRETEN &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3617  			    mtc.mt_op != MTERASE &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3618  			    mtc.mt_op != MTSEEK &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3619  			    mtc.mt_op != MTEOM) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3620  				retval = (-EIO);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3621  				goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3622  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3623  			reset_state(STp);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3624  			/* remove this when the midlevel properly clears was_reset */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3625  			STp->device->was_reset = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3626  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3627  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3628  		if (mtc.mt_op != MTNOP && mtc.mt_op != MTSETBLK &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3629  		    mtc.mt_op != MTSETDENSITY && mtc.mt_op != MTWSM &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3630  		    mtc.mt_op != MTSETDRVBUFFER && mtc.mt_op != MTSETPART)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3631  			STps->rw = ST_IDLE;	/* Prevent automatic WEOF and fsf */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3632  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3633  		if (mtc.mt_op == MTOFFL && STp->door_locked != ST_UNLOCKED)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3634  			do_door_lock(STp, 0);	/* Ignore result! */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3635  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3636  		if (mtc.mt_op == MTSETDRVBUFFER &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3637  		    (mtc.mt_count & MT_ST_OPTIONS) != 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3638  			retval = st_set_options(STp, mtc.mt_count);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3639  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3640  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3641  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3642  		if (mtc.mt_op == MTSETPART) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3643  			if (!STp->can_partitions ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3644  			    mtc.mt_count < 0 || mtc.mt_count >= ST_NBR_PARTITIONS) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3645  				retval = (-EINVAL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3646  				goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3647  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3648  			if (mtc.mt_count >= STp->nbr_partitions &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3649  			    (STp->nbr_partitions = nbr_partitions(STp)) < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3650  				retval = (-EIO);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3651  				goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3652  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3653  			if (mtc.mt_count >= STp->nbr_partitions) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3654  				retval = (-EINVAL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3655  				goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3656  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3657  			STp->new_partition = mtc.mt_count;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3658  			retval = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3659  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3660  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3661  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3662  		if (mtc.mt_op == MTMKPART) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3663  			if (!STp->can_partitions) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3664  				retval = (-EINVAL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3665  				goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3666  			}
8038e6456a3e6f Kai Makisara      2016-02-09  3667  			i = do_load_unload(STp, file, 1);
8038e6456a3e6f Kai Makisara      2016-02-09  3668  			if (i < 0) {
8038e6456a3e6f Kai Makisara      2016-02-09  3669  				retval = i;
8038e6456a3e6f Kai Makisara      2016-02-09  3670  				goto out;
8038e6456a3e6f Kai Makisara      2016-02-09  3671  			}
8038e6456a3e6f Kai Makisara      2016-02-09  3672  			i = partition_tape(STp, mtc.mt_count);
8038e6456a3e6f Kai Makisara      2016-02-09  3673  			if (i < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3674  				retval = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3675  				goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3676  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3677  			for (i = 0; i < ST_NBR_PARTITIONS; i++) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3678  				STp->ps[i].rw = ST_IDLE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3679  				STp->ps[i].at_sm = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3680  				STp->ps[i].last_block_valid = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3681  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3682  			STp->partition = STp->new_partition = 0;
8038e6456a3e6f Kai Makisara      2016-02-09  3683  			STp->nbr_partitions = mtc.mt_count != 0 ? 2 : 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3684  			STps->drv_block = STps->drv_file = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3685  			retval = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3686  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3687  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3688  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3689  		if (mtc.mt_op == MTSEEK) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3690  			i = set_location(STp, mtc.mt_count, STp->new_partition, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3691  			if (!STp->can_partitions)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3692  				STp->ps[0].rw = ST_IDLE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3693  			retval = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3694  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3695  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3696  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3697  		if (mtc.mt_op == MTUNLOAD || mtc.mt_op == MTOFFL) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3698  			retval = do_load_unload(STp, file, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3699  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3700  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3701  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3702  		if (mtc.mt_op == MTLOAD) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3703  			retval = do_load_unload(STp, file, max(1, mtc.mt_count));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3704  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3705  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3706  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3707  		if (mtc.mt_op == MTLOCK || mtc.mt_op == MTUNLOCK) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3708  			retval = do_door_lock(STp, (mtc.mt_op == MTLOCK));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3709  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3710  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3711  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3712  		if (STp->can_partitions && STp->ready == ST_READY &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3713  		    (i = switch_partition(STp)) < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3714  			retval = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3715  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3716  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3717  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3718  		if (mtc.mt_op == MTCOMPRESSION)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3719  			retval = st_compression(STp, (mtc.mt_count & 1));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3720  		else
^1da177e4c3f41 Linus Torvalds    2005-04-16  3721  			retval = st_int_ioctl(STp, mtc.mt_op, mtc.mt_count);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3722  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3723  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3724  	if (!STm->defined) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3725  		retval = (-ENXIO);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3726  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3727  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3728  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3729  	if ((i = flush_buffer(STp, 0)) < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3730  		retval = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3731  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3732  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3733  	if (STp->can_partitions &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  3734  	    (i = switch_partition(STp)) < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3735  		retval = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3736  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3737  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3738  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3739  	if (cmd_type == _IOC_TYPE(MTIOCGET) && cmd_nr == _IOC_NR(MTIOCGET)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3740  		struct mtget mt_status;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3741  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3742  		if (_IOC_SIZE(cmd_in) != sizeof(struct mtget)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3743  			 retval = (-EINVAL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3744  			 goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3745  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3746  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3747  		mt_status.mt_type = STp->tape_type;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3748  		mt_status.mt_dsreg =
^1da177e4c3f41 Linus Torvalds    2005-04-16  3749  		    ((STp->block_size << MT_ST_BLKSIZE_SHIFT) & MT_ST_BLKSIZE_MASK) |
^1da177e4c3f41 Linus Torvalds    2005-04-16  3750  		    ((STp->density << MT_ST_DENSITY_SHIFT) & MT_ST_DENSITY_MASK);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3751  		mt_status.mt_blkno = STps->drv_block;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3752  		mt_status.mt_fileno = STps->drv_file;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3753  		if (STp->block_size != 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3754  			if (STps->rw == ST_WRITING)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3755  				mt_status.mt_blkno +=
^1da177e4c3f41 Linus Torvalds    2005-04-16  3756  				    (STp->buffer)->buffer_bytes / STp->block_size;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3757  			else if (STps->rw == ST_READING)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3758  				mt_status.mt_blkno -=
^1da177e4c3f41 Linus Torvalds    2005-04-16  3759                                          ((STp->buffer)->buffer_bytes +
^1da177e4c3f41 Linus Torvalds    2005-04-16  3760                                           STp->block_size - 1) / STp->block_size;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3761  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3762  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3763  		mt_status.mt_gstat = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3764  		if (STp->drv_write_prot)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3765  			mt_status.mt_gstat |= GMT_WR_PROT(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3766  		if (mt_status.mt_blkno == 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3767  			if (mt_status.mt_fileno == 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3768  				mt_status.mt_gstat |= GMT_BOT(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3769  			else
^1da177e4c3f41 Linus Torvalds    2005-04-16  3770  				mt_status.mt_gstat |= GMT_EOF(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3771  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3772  		mt_status.mt_erreg = (STp->recover_reg << MT_ST_SOFTERR_SHIFT);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3773  		mt_status.mt_resid = STp->partition;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3774  		if (STps->eof == ST_EOM_OK || STps->eof == ST_EOM_ERROR)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3775  			mt_status.mt_gstat |= GMT_EOT(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3776  		else if (STps->eof >= ST_EOM_OK)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3777  			mt_status.mt_gstat |= GMT_EOD(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3778  		if (STp->density == 1)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3779  			mt_status.mt_gstat |= GMT_D_800(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3780  		else if (STp->density == 2)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3781  			mt_status.mt_gstat |= GMT_D_1600(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3782  		else if (STp->density == 3)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3783  			mt_status.mt_gstat |= GMT_D_6250(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3784  		if (STp->ready == ST_READY)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3785  			mt_status.mt_gstat |= GMT_ONLINE(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3786  		if (STp->ready == ST_NO_TAPE)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3787  			mt_status.mt_gstat |= GMT_DR_OPEN(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3788  		if (STps->at_sm)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3789  			mt_status.mt_gstat |= GMT_SM(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3790  		if (STm->do_async_writes ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3791                      (STm->do_buffer_writes && STp->block_size != 0) ||
^1da177e4c3f41 Linus Torvalds    2005-04-16  3792  		    STp->drv_buffer != 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3793  			mt_status.mt_gstat |= GMT_IM_REP_EN(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3794  		if (STp->cleaning_req)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3795  			mt_status.mt_gstat |= GMT_CLN(0xffffffff);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3796  
1207045da5a7c9 Arnd Bergmann     2018-09-07  3797  		retval = put_user_mtget(p, &mt_status);
1207045da5a7c9 Arnd Bergmann     2018-09-07  3798  		if (retval)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3799  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3800  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3801  		STp->recover_reg = 0;		/* Clear after read */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3802  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3803  	}			/* End of MTIOCGET */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3804  	if (cmd_type == _IOC_TYPE(MTIOCPOS) && cmd_nr == _IOC_NR(MTIOCPOS)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3805  		struct mtpos mt_pos;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3806  		if (_IOC_SIZE(cmd_in) != sizeof(struct mtpos)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3807  			 retval = (-EINVAL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3808  			 goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3809  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3810  		if ((i = get_location(STp, &blk, &bt, 0)) < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3811  			retval = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3812  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3813  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3814  		mt_pos.mt_blkno = blk;
1207045da5a7c9 Arnd Bergmann     2018-09-07  3815  		retval = put_user_mtpos(p, &mt_pos);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3816  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3817  	}
28f85009e0cf6a Matthias Kaehlcke 2007-07-29  3818  	mutex_unlock(&STp->lock);
d320a9551e394c Arnd Bergmann     2019-03-15  3819  
dba7688fc9037c Christoph Hellwig 2021-07-24  3820  	switch (cmd_in) {
dba7688fc9037c Christoph Hellwig 2021-07-24  3821  	case SG_IO:
dba7688fc9037c Christoph Hellwig 2021-07-24  3822  	case SCSI_IOCTL_SEND_COMMAND:
dba7688fc9037c Christoph Hellwig 2021-07-24  3823  	case CDROM_SEND_PACKET:
dba7688fc9037c Christoph Hellwig 2021-07-24  3824  		if (!capable(CAP_SYS_RAWIO))
dba7688fc9037c Christoph Hellwig 2021-07-24  3825  			return -EPERM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3826  	default:
^1da177e4c3f41 Linus Torvalds    2005-04-16  3827  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3828  	}
dba7688fc9037c Christoph Hellwig 2021-07-24  3829  
2e27f576abc6f0 Christoph Hellwig 2021-07-24 @3830  	retval = scsi_ioctl(STp->device, STp->disk, file->f_mode, cmd_in, p);
dba7688fc9037c Christoph Hellwig 2021-07-24  3831  	if (!retval && cmd_in == SCSI_IOCTL_STOP_UNIT) {
dba7688fc9037c Christoph Hellwig 2021-07-24  3832  		/* unload */
dba7688fc9037c Christoph Hellwig 2021-07-24  3833  		STp->rew_at_close = 0;
dba7688fc9037c Christoph Hellwig 2021-07-24  3834  		STp->ready = ST_NO_TAPE;
dba7688fc9037c Christoph Hellwig 2021-07-24  3835  	}
dba7688fc9037c Christoph Hellwig 2021-07-24  3836  	return retval;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3837  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3838   out:
28f85009e0cf6a Matthias Kaehlcke 2007-07-29  3839  	mutex_unlock(&STp->lock);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3840  	return retval;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3841  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  3842  

:::::: The code at line 3830 was first introduced by commit
:::::: 2e27f576abc6f056e63ef207b9911b1a04d07020 scsi: scsi_ioctl: Call scsi_cmd_ioctl() from scsi_ioctl()

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--EeQfGwPcQSOJBaQU--
