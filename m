Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8763A42C4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhJMPiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:38:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840BEC061570;
        Wed, 13 Oct 2021 08:36:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c16so13529299lfb.3;
        Wed, 13 Oct 2021 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laE1f+3EaUhOMnrMJMGyAdS8Chc7gokKeJHVvu+KLIA=;
        b=nRDum5674La/3kqlhxzFdEyjWhpmm0gH4EQHvvabQPByBvGnjdEfVNTz4StXxqAl3W
         SClvdpy94S5SuqKwoktFF6XWeTwqg1lhk3qUIAUGSNCSNfc/9muu/9cE3Lli7YDyfAl6
         rW7a5JnBSiS/k6ZHhIwsfGV18Qdfgbr7soOr43XwznNOcv6wcuCUsUbJQIhKSeblK4tr
         fpjVaEeOiMXDOHUN4SHJlBmuJAoghbgA8nnaGJoQ5/OwavfTnrODsYdBTMlges+se/YD
         C7HjYPNfBCCYhINbwCGNCIfRf4VlP0F3Tbl9JXEf407F7VWockVepL7etxSL3agr3vUN
         5zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laE1f+3EaUhOMnrMJMGyAdS8Chc7gokKeJHVvu+KLIA=;
        b=rjYcHSkMhvMehQjocZDCefRVuTbwLcAKxx89oOE55SrU+HBG32xTY5GfvOl13DN9w8
         fcoGo5abb6JYTXRBS2/cB1E863g8m/RitBvT/QejrzjW5a14JI4tA3cP/eVVYonv8uxL
         z9baVpen8/lbZnrfP2BaZiHA49J9LoYpFi5QAQboXLi8nAXDktJgSLl9+5lsKmO9MNne
         TG6nc5MzJnF1CtakxkJ3U/SuyN9MxAdhHlFaXOoIxZCPW9vQnfHZZzCfKg2yBxkfpaqS
         DIF9kgnXeJ1682XjX8bnbZFlsLmW6XFA4SciDuCM1CaS86599hoZu0gXYc5ph7s3btmV
         7rnQ==
X-Gm-Message-State: AOAM533XgELussoNZwIWdnitlEtTVWA70nP6b2gV08E4PYPocOJWkItE
        0UZFZRggR8099E9+4RWg1kURfG8bKo4yoUfgI+yObqqwJVQ=
X-Google-Smtp-Source: ABdhPJysMDhWLkrHSN92UdKpdHy/g6PJUlecaOsfnpQFuhnNdNAHSH0JIf4e0yoqN3QMO43OkydkX8q2UY5bi3oGOF4=
X-Received: by 2002:a2e:9c94:: with SMTP id x20mr48731lji.5.1634139364670;
 Wed, 13 Oct 2021 08:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <1634095759-4625-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1634095759-4625-1-git-send-email-wangqing@vivo.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 14 Oct 2021 00:35:52 +0900
Message-ID: <CAKFNMo=zrmJKHAUMwVgc3onKADEcgASO4K_D4RzdvNU9rHHxRw@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: replace snprintf in show functions with sysfs_emit
To:     Qing Wang <wangqing@vivo.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 12:29 PM Qing Wang <wangqing@vivo.com> wrote:
>
> coccicheck complains about the use of snprintf() in sysfs show functions.
>
> Fix the coccicheck warning:
> WARNING: use scnprintf or sprintf.
>
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>
> Signed-off-by: Qing Wang <wangqing@vivo.com>

Thank you for the patch.

Looks good to me.  Will apply.

Ryusuke Konishi

> ---
>  fs/nilfs2/sysfs.c | 76 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> index 68e8d61..cdb935f 100644
> --- a/fs/nilfs2/sysfs.c
> +++ b/fs/nilfs2/sysfs.c
> @@ -97,7 +97,7 @@ static ssize_t
>  nilfs_snapshot_inodes_count_show(struct nilfs_snapshot_attr *attr,
>                                  struct nilfs_root *root, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%llu\n",
> +       return sysfs_emit(buf, "%llu\n",
>                         (unsigned long long)atomic64_read(&root->inodes_count));
>  }
>
> @@ -105,7 +105,7 @@ static ssize_t
>  nilfs_snapshot_blocks_count_show(struct nilfs_snapshot_attr *attr,
>                                  struct nilfs_root *root, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%llu\n",
> +       return sysfs_emit(buf, "%llu\n",
>                         (unsigned long long)atomic64_read(&root->blocks_count));
>  }
>
> @@ -118,7 +118,7 @@ static ssize_t
>  nilfs_snapshot_README_show(struct nilfs_snapshot_attr *attr,
>                             struct nilfs_root *root, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, snapshot_readme_str);
> +       return sysfs_emit(buf, snapshot_readme_str);
>  }
>
>  NILFS_SNAPSHOT_RO_ATTR(inodes_count);
> @@ -219,7 +219,7 @@ static ssize_t
>  nilfs_mounted_snapshots_README_show(struct nilfs_mounted_snapshots_attr *attr,
>                                     struct the_nilfs *nilfs, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, mounted_snapshots_readme_str);
> +       return sysfs_emit(buf, mounted_snapshots_readme_str);
>  }
>
>  NILFS_MOUNTED_SNAPSHOTS_RO_ATTR(README);
> @@ -257,7 +257,7 @@ nilfs_checkpoints_checkpoints_number_show(struct nilfs_checkpoints_attr *attr,
>
>         ncheckpoints = cpstat.cs_ncps;
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", ncheckpoints);
> +       return sysfs_emit(buf, "%llu\n", ncheckpoints);
>  }
>
>  static ssize_t
> @@ -280,7 +280,7 @@ nilfs_checkpoints_snapshots_number_show(struct nilfs_checkpoints_attr *attr,
>
>         nsnapshots = cpstat.cs_nsss;
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", nsnapshots);
> +       return sysfs_emit(buf, "%llu\n", nsnapshots);
>  }
>
>  static ssize_t
> @@ -294,7 +294,7 @@ nilfs_checkpoints_last_seg_checkpoint_show(struct nilfs_checkpoints_attr *attr,
>         last_cno = nilfs->ns_last_cno;
>         spin_unlock(&nilfs->ns_last_segment_lock);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
> +       return sysfs_emit(buf, "%llu\n", last_cno);
>  }
>
>  static ssize_t
> @@ -308,7 +308,7 @@ nilfs_checkpoints_next_checkpoint_show(struct nilfs_checkpoints_attr *attr,
>         cno = nilfs->ns_cno;
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
> +       return sysfs_emit(buf, "%llu\n", cno);
>  }
>
>  static const char checkpoints_readme_str[] =
> @@ -324,7 +324,7 @@ static ssize_t
>  nilfs_checkpoints_README_show(struct nilfs_checkpoints_attr *attr,
>                                 struct the_nilfs *nilfs, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, checkpoints_readme_str);
> +       return sysfs_emit(buf, checkpoints_readme_str);
>  }
>
>  NILFS_CHECKPOINTS_RO_ATTR(checkpoints_number);
> @@ -355,7 +355,7 @@ nilfs_segments_segments_number_show(struct nilfs_segments_attr *attr,
>                                      struct the_nilfs *nilfs,
>                                      char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_nsegments);
> +       return sysfs_emit(buf, "%lu\n", nilfs->ns_nsegments);
>  }
>
>  static ssize_t
> @@ -363,7 +363,7 @@ nilfs_segments_blocks_per_segment_show(struct nilfs_segments_attr *attr,
>                                         struct the_nilfs *nilfs,
>                                         char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_blocks_per_segment);
> +       return sysfs_emit(buf, "%lu\n", nilfs->ns_blocks_per_segment);
>  }
>
>  static ssize_t
> @@ -377,7 +377,7 @@ nilfs_segments_clean_segments_show(struct nilfs_segments_attr *attr,
>         ncleansegs = nilfs_sufile_get_ncleansegs(nilfs->ns_sufile);
>         up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%lu\n", ncleansegs);
> +       return sysfs_emit(buf, "%lu\n", ncleansegs);
>  }
>
>  static ssize_t
> @@ -397,7 +397,7 @@ nilfs_segments_dirty_segments_show(struct nilfs_segments_attr *attr,
>                 return err;
>         }
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", sustat.ss_ndirtysegs);
> +       return sysfs_emit(buf, "%llu\n", sustat.ss_ndirtysegs);
>  }
>
>  static const char segments_readme_str[] =
> @@ -413,7 +413,7 @@ nilfs_segments_README_show(struct nilfs_segments_attr *attr,
>                             struct the_nilfs *nilfs,
>                             char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, segments_readme_str);
> +       return sysfs_emit(buf, segments_readme_str);
>  }
>
>  NILFS_SEGMENTS_RO_ATTR(segments_number);
> @@ -450,7 +450,7 @@ nilfs_segctor_last_pseg_block_show(struct nilfs_segctor_attr *attr,
>         last_pseg = nilfs->ns_last_pseg;
>         spin_unlock(&nilfs->ns_last_segment_lock);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n",
> +       return sysfs_emit(buf, "%llu\n",
>                         (unsigned long long)last_pseg);
>  }
>
> @@ -465,7 +465,7 @@ nilfs_segctor_last_seg_sequence_show(struct nilfs_segctor_attr *attr,
>         last_seq = nilfs->ns_last_seq;
>         spin_unlock(&nilfs->ns_last_segment_lock);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", last_seq);
> +       return sysfs_emit(buf, "%llu\n", last_seq);
>  }
>
>  static ssize_t
> @@ -479,7 +479,7 @@ nilfs_segctor_last_seg_checkpoint_show(struct nilfs_segctor_attr *attr,
>         last_cno = nilfs->ns_last_cno;
>         spin_unlock(&nilfs->ns_last_segment_lock);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
> +       return sysfs_emit(buf, "%llu\n", last_cno);
>  }
>
>  static ssize_t
> @@ -493,7 +493,7 @@ nilfs_segctor_current_seg_sequence_show(struct nilfs_segctor_attr *attr,
>         seg_seq = nilfs->ns_seg_seq;
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", seg_seq);
> +       return sysfs_emit(buf, "%llu\n", seg_seq);
>  }
>
>  static ssize_t
> @@ -507,7 +507,7 @@ nilfs_segctor_current_last_full_seg_show(struct nilfs_segctor_attr *attr,
>         segnum = nilfs->ns_segnum;
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", segnum);
> +       return sysfs_emit(buf, "%llu\n", segnum);
>  }
>
>  static ssize_t
> @@ -521,7 +521,7 @@ nilfs_segctor_next_full_seg_show(struct nilfs_segctor_attr *attr,
>         nextnum = nilfs->ns_nextnum;
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", nextnum);
> +       return sysfs_emit(buf, "%llu\n", nextnum);
>  }
>
>  static ssize_t
> @@ -535,7 +535,7 @@ nilfs_segctor_next_pseg_offset_show(struct nilfs_segctor_attr *attr,
>         pseg_offset = nilfs->ns_pseg_offset;
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%lu\n", pseg_offset);
> +       return sysfs_emit(buf, "%lu\n", pseg_offset);
>  }
>
>  static ssize_t
> @@ -549,7 +549,7 @@ nilfs_segctor_next_checkpoint_show(struct nilfs_segctor_attr *attr,
>         cno = nilfs->ns_cno;
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
> +       return sysfs_emit(buf, "%llu\n", cno);
>  }
>
>  static ssize_t
> @@ -577,7 +577,7 @@ nilfs_segctor_last_seg_write_time_secs_show(struct nilfs_segctor_attr *attr,
>         ctime = nilfs->ns_ctime;
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", ctime);
> +       return sysfs_emit(buf, "%llu\n", ctime);
>  }
>
>  static ssize_t
> @@ -605,7 +605,7 @@ nilfs_segctor_last_nongc_write_time_secs_show(struct nilfs_segctor_attr *attr,
>         nongc_ctime = nilfs->ns_nongc_ctime;
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", nongc_ctime);
> +       return sysfs_emit(buf, "%llu\n", nongc_ctime);
>  }
>
>  static ssize_t
> @@ -619,7 +619,7 @@ nilfs_segctor_dirty_data_blocks_count_show(struct nilfs_segctor_attr *attr,
>         ndirtyblks = atomic_read(&nilfs->ns_ndirtyblks);
>         up_read(&nilfs->ns_segctor_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%u\n", ndirtyblks);
> +       return sysfs_emit(buf, "%u\n", ndirtyblks);
>  }
>
>  static const char segctor_readme_str[] =
> @@ -656,7 +656,7 @@ static ssize_t
>  nilfs_segctor_README_show(struct nilfs_segctor_attr *attr,
>                           struct the_nilfs *nilfs, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, segctor_readme_str);
> +       return sysfs_emit(buf, segctor_readme_str);
>  }
>
>  NILFS_SEGCTOR_RO_ATTR(last_pseg_block);
> @@ -725,7 +725,7 @@ nilfs_superblock_sb_write_time_secs_show(struct nilfs_superblock_attr *attr,
>         sbwtime = nilfs->ns_sbwtime;
>         up_read(&nilfs->ns_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", sbwtime);
> +       return sysfs_emit(buf, "%llu\n", sbwtime);
>  }
>
>  static ssize_t
> @@ -739,7 +739,7 @@ nilfs_superblock_sb_write_count_show(struct nilfs_superblock_attr *attr,
>         sbwcount = nilfs->ns_sbwcount;
>         up_read(&nilfs->ns_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%u\n", sbwcount);
> +       return sysfs_emit(buf, "%u\n", sbwcount);
>  }
>
>  static ssize_t
> @@ -753,7 +753,7 @@ nilfs_superblock_sb_update_frequency_show(struct nilfs_superblock_attr *attr,
>         sb_update_freq = nilfs->ns_sb_update_freq;
>         up_read(&nilfs->ns_sem);
>
> -       return snprintf(buf, PAGE_SIZE, "%u\n", sb_update_freq);
> +       return sysfs_emit(buf, "%u\n", sb_update_freq);
>  }
>
>  static ssize_t
> @@ -801,7 +801,7 @@ static ssize_t
>  nilfs_superblock_README_show(struct nilfs_superblock_attr *attr,
>                                 struct the_nilfs *nilfs, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, sb_readme_str);
> +       return sysfs_emit(buf, sb_readme_str);
>  }
>
>  NILFS_SUPERBLOCK_RO_ATTR(sb_write_time);
> @@ -836,7 +836,7 @@ ssize_t nilfs_dev_revision_show(struct nilfs_dev_attr *attr,
>         u32 major = le32_to_cpu(sbp[0]->s_rev_level);
>         u16 minor = le16_to_cpu(sbp[0]->s_minor_rev_level);
>
> -       return snprintf(buf, PAGE_SIZE, "%d.%d\n", major, minor);
> +       return sysfs_emit(buf, "%d.%d\n", major, minor);
>  }
>
>  static
> @@ -844,7 +844,7 @@ ssize_t nilfs_dev_blocksize_show(struct nilfs_dev_attr *attr,
>                                  struct the_nilfs *nilfs,
>                                  char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%u\n", nilfs->ns_blocksize);
> +       return sysfs_emit(buf, "%u\n", nilfs->ns_blocksize);
>  }
>
>  static
> @@ -855,7 +855,7 @@ ssize_t nilfs_dev_device_size_show(struct nilfs_dev_attr *attr,
>         struct nilfs_super_block **sbp = nilfs->ns_sbp;
>         u64 dev_size = le64_to_cpu(sbp[0]->s_dev_size);
>
> -       return snprintf(buf, PAGE_SIZE, "%llu\n", dev_size);
> +       return sysfs_emit(buf, "%llu\n", dev_size);
>  }
>
>  static
> @@ -866,7 +866,7 @@ ssize_t nilfs_dev_free_blocks_show(struct nilfs_dev_attr *attr,
>         sector_t free_blocks = 0;
>
>         nilfs_count_free_blocks(nilfs, &free_blocks);
> -       return snprintf(buf, PAGE_SIZE, "%llu\n",
> +       return sysfs_emit(buf, "%llu\n",
>                         (unsigned long long)free_blocks);
>  }
>
> @@ -877,7 +877,7 @@ ssize_t nilfs_dev_uuid_show(struct nilfs_dev_attr *attr,
>  {
>         struct nilfs_super_block **sbp = nilfs->ns_sbp;
>
> -       return snprintf(buf, PAGE_SIZE, "%pUb\n", sbp[0]->s_uuid);
> +       return sysfs_emit(buf, "%pUb\n", sbp[0]->s_uuid);
>  }
>
>  static
> @@ -905,7 +905,7 @@ static ssize_t nilfs_dev_README_show(struct nilfs_dev_attr *attr,
>                                      struct the_nilfs *nilfs,
>                                      char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, dev_readme_str);
> +       return sysfs_emit(buf, dev_readme_str);
>  }
>
>  NILFS_DEV_RO_ATTR(revision);
> @@ -1051,7 +1051,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
>  static ssize_t nilfs_feature_revision_show(struct kobject *kobj,
>                                             struct attribute *attr, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%d.%d\n",
> +       return sysfs_emit(buf, "%d.%d\n",
>                         NILFS_CURRENT_REV, NILFS_MINOR_REV);
>  }
>
> @@ -1064,7 +1064,7 @@ static ssize_t nilfs_feature_README_show(struct kobject *kobj,
>                                          struct attribute *attr,
>                                          char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, features_readme_str);
> +       return sysfs_emit(buf, features_readme_str);
>  }
>
>  NILFS_FEATURE_RO_ATTR(revision);
> --
> 2.7.4
>
