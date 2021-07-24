Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8353D4546
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhGXFuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 01:50:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34366 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGXFus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 01:50:48 -0400
Received: from [192.168.86.34] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8EA3A20B7178;
        Fri, 23 Jul 2021 23:31:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EA3A20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627108279;
        bh=5OoRqVILcgrbgv5nU8+RxvQlkznKP8dezNnu0hewlRE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mBs8K7QGQrDiWC6OCmR0goSstYB4APK0GgTcayvk0qTgk79EDDvfGh1yoq640Bqof
         /J3Uey4UjBSU5fCptJ5cFdH3CpwHfT7U5Wj2JOEWjePfiFmviD83dwy3E3sPrZI5Yu
         ZsILkUbhYjQIe9/AwKL3SHLctgnLqG7/F96qBQu4=
Subject: Re: [dm:for-next 9/10] drivers/md/dm-raid.c:3686:39: warning:
 variable 'recovery' is uninitialized when used here
To:     kernel test robot <lkp@intel.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <202107211307.WaOQR1zv-lkp@intel.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <0780ef71-77fd-f151-36c3-5981403ca31c@linux.microsoft.com>
Date:   Fri, 23 Jul 2021 23:31:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107211307.WaOQR1zv-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/20/21 10:51 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
> head:   e820ba87f9d15399fa565ceba4a92b902c879d29
> commit: fdac9de80c2e66d6df999ac810382c66b0cb2830 [9/10] dm: update target status functions to support IMA measurement
> config: x86_64-randconfig-a011-20210720 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project c781eb153bfbd1b52b03efe34f56bbeccbb8aba6)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install x86_64 cross compiling tool for clang build
>          # apt-get install binutils-x86-64-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?id=fdac9de80c2e66d6df999ac810382c66b0cb2830
>          git remote add dm https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
>          git fetch --no-tags dm for-next
>          git checkout fdac9de80c2e66d6df999ac810382c66b0cb2830
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/md/dm-raid.c:3686:39: warning: variable 'recovery' is uninitialized when used here [-Wuninitialized]
>                     state = decipher_sync_action(mddev, recovery);
Thanks Mike for fixing this warning in the latest patch in for-next with:

+     recovery = rs->md.recovery;
       state = decipher_sync_action(mddev, recovery);

Appreciate it.

Thanks,
Tushar
>                                                         ^~~~~~~~
>     drivers/md/dm-raid.c:3517:24: note: initialize the variable 'recovery' to silence this warning
>             unsigned long recovery;
>                                   ^
>                                    = 0
>     1 warning generated.
>
>
> vim +/recovery +3686 drivers/md/dm-raid.c
>
>    3509	
>    3510	static void raid_status(struct dm_target *ti, status_type_t type,
>    3511				unsigned int status_flags, char *result, unsigned int maxlen)
>    3512	{
>    3513		struct raid_set *rs = ti->private;
>    3514		struct mddev *mddev = &rs->md;
>    3515		struct r5conf *conf = mddev->private;
>    3516		int i, max_nr_stripes = conf ? conf->max_nr_stripes : 0;
>    3517		unsigned long recovery;
>    3518		unsigned int raid_param_cnt = 1; /* at least 1 for chunksize */
>    3519		unsigned int sz = 0;
>    3520		unsigned int rebuild_writemostly_count = 0;
>    3521		sector_t progress, resync_max_sectors, resync_mismatches;
>    3522		enum sync_state state;
>    3523		struct raid_type *rt;
>    3524	
>    3525		switch (type) {
>    3526		case STATUSTYPE_INFO:
>    3527			/* *Should* always succeed */
>    3528			rt = get_raid_type_by_ll(mddev->new_level, mddev->new_layout);
>    3529			if (!rt)
>    3530				return;
>    3531	
>    3532			DMEMIT("%s %d ", rt->name, mddev->raid_disks);
>    3533	
>    3534			/* Access most recent mddev properties for status output */
>    3535			smp_rmb();
>    3536			/* Get sensible max sectors even if raid set not yet started */
>    3537			resync_max_sectors = test_bit(RT_FLAG_RS_PRERESUMED, &rs->runtime_flags) ?
>    3538					      mddev->resync_max_sectors : mddev->dev_sectors;
>    3539			recovery = rs->md.recovery;
>    3540			state = decipher_sync_action(mddev, recovery);
>    3541			progress = rs_get_progress(rs, recovery, state, resync_max_sectors);
>    3542			resync_mismatches = (mddev->last_sync_action && !strcasecmp(mddev->last_sync_action, "check")) ?
>    3543					    atomic64_read(&mddev->resync_mismatches) : 0;
>    3544	
>    3545			/* HM FIXME: do we want another state char for raid0? It shows 'D'/'A'/'-' now */
>    3546			for (i = 0; i < rs->raid_disks; i++)
>    3547				DMEMIT(__raid_dev_status(rs, &rs->dev[i].rdev));
>    3548	
>    3549			/*
>    3550			 * In-sync/Reshape ratio:
>    3551			 *  The in-sync ratio shows the progress of:
>    3552			 *   - Initializing the raid set
>    3553			 *   - Rebuilding a subset of devices of the raid set
>    3554			 *  The user can distinguish between the two by referring
>    3555			 *  to the status characters.
>    3556			 *
>    3557			 *  The reshape ratio shows the progress of
>    3558			 *  changing the raid layout or the number of
>    3559			 *  disks of a raid set
>    3560			 */
>    3561			DMEMIT(" %llu/%llu", (unsigned long long) progress,
>    3562					     (unsigned long long) resync_max_sectors);
>    3563	
>    3564			/*
>    3565			 * v1.5.0+:
>    3566			 *
>    3567			 * Sync action:
>    3568			 *   See Documentation/admin-guide/device-mapper/dm-raid.rst for
>    3569			 *   information on each of these states.
>    3570			 */
>    3571			DMEMIT(" %s", sync_str(state));
>    3572	
>    3573			/*
>    3574			 * v1.5.0+:
>    3575			 *
>    3576			 * resync_mismatches/mismatch_cnt
>    3577			 *   This field shows the number of discrepancies found when
>    3578			 *   performing a "check" of the raid set.
>    3579			 */
>    3580			DMEMIT(" %llu", (unsigned long long) resync_mismatches);
>    3581	
>    3582			/*
>    3583			 * v1.9.0+:
>    3584			 *
>    3585			 * data_offset (needed for out of space reshaping)
>    3586			 *   This field shows the data offset into the data
>    3587			 *   image LV where the first stripes data starts.
>    3588			 *
>    3589			 * We keep data_offset equal on all raid disks of the set,
>    3590			 * so retrieving it from the first raid disk is sufficient.
>    3591			 */
>    3592			DMEMIT(" %llu", (unsigned long long) rs->dev[0].rdev.data_offset);
>    3593	
>    3594			/*
>    3595			 * v1.10.0+:
>    3596			 */
>    3597			DMEMIT(" %s", test_bit(__CTR_FLAG_JOURNAL_DEV, &rs->ctr_flags) ?
>    3598				      __raid_dev_status(rs, &rs->journal_dev.rdev) : "-");
>    3599			break;
>    3600	
>    3601		case STATUSTYPE_TABLE:
>    3602			/* Report the table line string you would use to construct this raid set */
>    3603	
>    3604			/*
>    3605			 * Count any rebuild or writemostly argument pairs and subtract the
>    3606			 * hweight count being added below of any rebuild and writemostly ctr flags.
>    3607			 */
>    3608			for (i = 0; i < rs->raid_disks; i++) {
>    3609				rebuild_writemostly_count += (test_bit(i, (void *) rs->rebuild_disks) ? 2 : 0) +
>    3610							     (test_bit(WriteMostly, &rs->dev[i].rdev.flags) ? 2 : 0);
>    3611			}
>    3612			rebuild_writemostly_count -= (test_bit(__CTR_FLAG_REBUILD, &rs->ctr_flags) ? 2 : 0) +
>    3613						     (test_bit(__CTR_FLAG_WRITE_MOSTLY, &rs->ctr_flags) ? 2 : 0);
>    3614			/* Calculate raid parameter count based on ^ rebuild/writemostly argument counts and ctr flags set. */
>    3615			raid_param_cnt += rebuild_writemostly_count +
>    3616					  hweight32(rs->ctr_flags & CTR_FLAG_OPTIONS_NO_ARGS) +
>    3617					  hweight32(rs->ctr_flags & CTR_FLAG_OPTIONS_ONE_ARG) * 2;
>    3618			/* Emit table line */
>    3619			/* This has to be in the documented order for userspace! */
>    3620			DMEMIT("%s %u %u", rs->raid_type->name, raid_param_cnt, mddev->new_chunk_sectors);
>    3621			if (test_bit(__CTR_FLAG_SYNC, &rs->ctr_flags))
>    3622				DMEMIT(" %s", dm_raid_arg_name_by_flag(CTR_FLAG_SYNC));
>    3623			if (test_bit(__CTR_FLAG_NOSYNC, &rs->ctr_flags))
>    3624				DMEMIT(" %s", dm_raid_arg_name_by_flag(CTR_FLAG_NOSYNC));
>    3625			if (test_bit(__CTR_FLAG_REBUILD, &rs->ctr_flags))
>    3626				for (i = 0; i < rs->raid_disks; i++)
>    3627					if (test_bit(i, (void *) rs->rebuild_disks))
>    3628						DMEMIT(" %s %u", dm_raid_arg_name_by_flag(CTR_FLAG_REBUILD), i);
>    3629			if (test_bit(__CTR_FLAG_DAEMON_SLEEP, &rs->ctr_flags))
>    3630				DMEMIT(" %s %lu", dm_raid_arg_name_by_flag(CTR_FLAG_DAEMON_SLEEP),
>    3631						  mddev->bitmap_info.daemon_sleep);
>    3632			if (test_bit(__CTR_FLAG_MIN_RECOVERY_RATE, &rs->ctr_flags))
>    3633				DMEMIT(" %s %d", dm_raid_arg_name_by_flag(CTR_FLAG_MIN_RECOVERY_RATE),
>    3634						 mddev->sync_speed_min);
>    3635			if (test_bit(__CTR_FLAG_MAX_RECOVERY_RATE, &rs->ctr_flags))
>    3636				DMEMIT(" %s %d", dm_raid_arg_name_by_flag(CTR_FLAG_MAX_RECOVERY_RATE),
>    3637						 mddev->sync_speed_max);
>    3638			if (test_bit(__CTR_FLAG_WRITE_MOSTLY, &rs->ctr_flags))
>    3639				for (i = 0; i < rs->raid_disks; i++)
>    3640					if (test_bit(WriteMostly, &rs->dev[i].rdev.flags))
>    3641						DMEMIT(" %s %d", dm_raid_arg_name_by_flag(CTR_FLAG_WRITE_MOSTLY),
>    3642						       rs->dev[i].rdev.raid_disk);
>    3643			if (test_bit(__CTR_FLAG_MAX_WRITE_BEHIND, &rs->ctr_flags))
>    3644				DMEMIT(" %s %lu", dm_raid_arg_name_by_flag(CTR_FLAG_MAX_WRITE_BEHIND),
>    3645						  mddev->bitmap_info.max_write_behind);
>    3646			if (test_bit(__CTR_FLAG_STRIPE_CACHE, &rs->ctr_flags))
>    3647				DMEMIT(" %s %d", dm_raid_arg_name_by_flag(CTR_FLAG_STRIPE_CACHE),
>    3648						 max_nr_stripes);
>    3649			if (test_bit(__CTR_FLAG_REGION_SIZE, &rs->ctr_flags))
>    3650				DMEMIT(" %s %llu", dm_raid_arg_name_by_flag(CTR_FLAG_REGION_SIZE),
>    3651						   (unsigned long long) to_sector(mddev->bitmap_info.chunksize));
>    3652			if (test_bit(__CTR_FLAG_RAID10_COPIES, &rs->ctr_flags))
>    3653				DMEMIT(" %s %d", dm_raid_arg_name_by_flag(CTR_FLAG_RAID10_COPIES),
>    3654						 raid10_md_layout_to_copies(mddev->layout));
>    3655			if (test_bit(__CTR_FLAG_RAID10_FORMAT, &rs->ctr_flags))
>    3656				DMEMIT(" %s %s", dm_raid_arg_name_by_flag(CTR_FLAG_RAID10_FORMAT),
>    3657						 raid10_md_layout_to_format(mddev->layout));
>    3658			if (test_bit(__CTR_FLAG_DELTA_DISKS, &rs->ctr_flags))
>    3659				DMEMIT(" %s %d", dm_raid_arg_name_by_flag(CTR_FLAG_DELTA_DISKS),
>    3660						 max(rs->delta_disks, mddev->delta_disks));
>    3661			if (test_bit(__CTR_FLAG_DATA_OFFSET, &rs->ctr_flags))
>    3662				DMEMIT(" %s %llu", dm_raid_arg_name_by_flag(CTR_FLAG_DATA_OFFSET),
>    3663						   (unsigned long long) rs->data_offset);
>    3664			if (test_bit(__CTR_FLAG_JOURNAL_DEV, &rs->ctr_flags))
>    3665				DMEMIT(" %s %s", dm_raid_arg_name_by_flag(CTR_FLAG_JOURNAL_DEV),
>    3666						__get_dev_name(rs->journal_dev.dev));
>    3667			if (test_bit(__CTR_FLAG_JOURNAL_MODE, &rs->ctr_flags))
>    3668				DMEMIT(" %s %s", dm_raid_arg_name_by_flag(CTR_FLAG_JOURNAL_MODE),
>    3669						 md_journal_mode_to_dm_raid(rs->journal_dev.mode));
>    3670			DMEMIT(" %d", rs->raid_disks);
>    3671			for (i = 0; i < rs->raid_disks; i++)
>    3672				DMEMIT(" %s %s", __get_dev_name(rs->dev[i].meta_dev),
>    3673						 __get_dev_name(rs->dev[i].data_dev));
>    3674			break;
>    3675	
>    3676		case STATUSTYPE_IMA:
>    3677			rt = get_raid_type_by_ll(mddev->new_level, mddev->new_layout);
>    3678			if (!rt)
>    3679				return;
>    3680	
>    3681			DMEMIT_TARGET_NAME_VERSION(ti->type);
>    3682			DMEMIT(",raid_type=%s,raid_disks=%d", rt->name, mddev->raid_disks);
>    3683	
>    3684			/* Access most recent mddev properties for status output */
>    3685			smp_rmb();
>> 3686			state = decipher_sync_action(mddev, recovery);
>    3687			DMEMIT(",raid_state=%s", sync_str(state));
>    3688	
>    3689			for (i = 0; i < rs->raid_disks; i++) {
>    3690				DMEMIT(",raid_device_%d_status=", i);
>    3691				DMEMIT(__raid_dev_status(rs, &rs->dev[i].rdev));
>    3692			}
>    3693	
>    3694			if (rt_is_raid456(rt)) {
>    3695				DMEMIT(",journal_dev_mode=");
>    3696				switch (rs->journal_dev.mode) {
>    3697				case R5C_JOURNAL_MODE_WRITE_THROUGH:
>    3698					DMEMIT("%s",
>    3699					       _raid456_journal_mode[R5C_JOURNAL_MODE_WRITE_THROUGH].param);
>    3700					break;
>    3701				case R5C_JOURNAL_MODE_WRITE_BACK:
>    3702					DMEMIT("%s",
>    3703					       _raid456_journal_mode[R5C_JOURNAL_MODE_WRITE_BACK].param);
>    3704					break;
>    3705				default:
>    3706					DMEMIT("invalid");
>    3707					break;
>    3708				}
>    3709			}
>    3710			DMEMIT(";");
>    3711			break;
>    3712		}
>    3713	}
>    3714	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
