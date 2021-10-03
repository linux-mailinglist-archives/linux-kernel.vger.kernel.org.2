Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075114203D1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhJCUAS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Oct 2021 16:00:18 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:37498 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhJCUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:00:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7510B61B8F4C;
        Sun,  3 Oct 2021 21:58:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cbTNVwa62Y0x; Sun,  3 Oct 2021 21:58:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 54B8E608F449;
        Sun,  3 Oct 2021 21:58:25 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GhBvbZycOL_5; Sun,  3 Oct 2021 21:58:25 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27EB261B8F4C;
        Sun,  3 Oct 2021 21:58:25 +0200 (CEST)
Date:   Sun, 3 Oct 2021 21:58:25 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     schaecsn <schaecsn@gmx.net>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Schaeckeler <sschaeck@cisco.com>
Message-ID: <1815586081.32955.1633291105033.JavaMail.zimbra@nod.at>
In-Reply-To: <20210907214034.11676-2-schaecsn@gmx.net>
References: <20210907214034.11676-1-schaecsn@gmx.net> <20210907214034.11676-2-schaecsn@gmx.net>
Subject: Re: [PATCH 1/1] ubifs: ubifs to export filesystem error counters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF92 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: ubifs to export filesystem error counters
Thread-Index: R4HIb5yxzrB2cLTRigFILX4pEkVdpQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan,

----- Ursprüngliche Mail -----
> Von: "schaecsn" <schaecsn@gmx.net>
> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "schaecsn" <schaecsn@gmx.net>, "Stefan Schaeckeler" <sschaeck@cisco.com>
> Gesendet: Dienstag, 7. September 2021 23:40:34
> Betreff: [PATCH 1/1] ubifs: ubifs to export filesystem error counters

> Not all ubifs filesystem errors are propagated to userspace.
> 
> Export bad magic, bad node and crc errors via sysfs. This allows userspace
> to notice filesystem errors:
> 
> /sys/fs/ubifs/ubiX_Y/errors_magic
> /sys/fs/ubifs/ubiX_Y/errors_node
> /sys/fs/ubifs/ubiX_Y/errors_crc
> 
> The counters are reset to 0 with a remount. Writing anything into the
> counters also clears them.

I think this is a nice feature. Thanks for implementing it.
Please see some minor nits below.

Is there a specific reason why you didn't implement it via UBIFS's debugfs interface?
sysfs is ABI, so we cannot change much anymore.

> Signed-off-by: Stefan Schaeckeler <sschaeck@cisco.com>
> ---
> fs/ubifs/Makefile |   2 +-
> fs/ubifs/io.c     |   6 ++
> fs/ubifs/super.c  |  17 ++++-
> fs/ubifs/sysfs.c  | 187 ++++++++++++++++++++++++++++++++++++++++++++++
> fs/ubifs/sysfs.h  |  39 ++++++++++
> fs/ubifs/ubifs.h  |  11 +++
> 6 files changed, 260 insertions(+), 2 deletions(-)
> create mode 100644 fs/ubifs/sysfs.c
> create mode 100644 fs/ubifs/sysfs.h
> 
> diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
> index 5c4b845754a7..314c80b24a76 100644
> --- a/fs/ubifs/Makefile
> +++ b/fs/ubifs/Makefile
> @@ -5,7 +5,7 @@ ubifs-y += shrinker.o journal.o file.o dir.o super.o sb.o io.o
> ubifs-y += tnc.o master.o scan.o replay.o log.o commit.o gc.o orphan.o
> ubifs-y += budget.o find.o tnc_commit.o compress.o lpt.o lprops.o
> ubifs-y += recovery.o ioctl.o lpt_commit.o tnc_misc.o debug.o
> -ubifs-y += misc.o
> +ubifs-y += misc.o sysfs.o
> ubifs-$(CONFIG_FS_ENCRYPTION) += crypto.o
> ubifs-$(CONFIG_UBIFS_FS_XATTR) += xattr.o
> ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
> diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
> index 00b61dba62b7..0b158e420cc1 100644
> --- a/fs/ubifs/io.c
> +++ b/fs/ubifs/io.c
> @@ -238,6 +238,8 @@ int ubifs_check_node(const struct ubifs_info *c, const void
> *buf, int len,
> 		if (!quiet)
> 			ubifs_err(c, "bad magic %#08x, expected %#08x",
> 				  magic, UBIFS_NODE_MAGIC);
> +		if (c->stats)
> +			c->stats->magic_errors++;

Please wrap this into a helper function.

> 		err = -EUCLEAN;
> 		goto out;
> 	}
> @@ -246,6 +248,8 @@ int ubifs_check_node(const struct ubifs_info *c, const void
> *buf, int len,
> 	if (type < 0 || type >= UBIFS_NODE_TYPES_CNT) {
> 		if (!quiet)
> 			ubifs_err(c, "bad node type %d", type);
> +		if (c->stats)
> +			c->stats->node_errors++;

Same.

> 		goto out;
> 	}
> 
> @@ -270,6 +274,8 @@ int ubifs_check_node(const struct ubifs_info *c, const void
> *buf, int len,
> 		if (!quiet)
> 			ubifs_err(c, "bad CRC: calculated %#08x, read %#08x",
> 				  crc, node_crc);
> +		if (c->stats)
> +			c->stats->crc_errors++;

Same.

> 		err = -EUCLEAN;
> 		goto out;
> 	}
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index f0fb25727d96..50b934854a84 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -24,6 +24,7 @@
> #include <linux/mount.h>
> #include <linux/math64.h>
> #include <linux/writeback.h>
> +#include "sysfs.h"
> #include "ubifs.h"
> 
> static int ubifs_default_version_set(const char *val, const struct kernel_param
> *kp)
> @@ -1264,6 +1265,10 @@ static int mount_ubifs(struct ubifs_info *c)
> 	if (err)
> 		return err;
> 
> +	err = ubifs_sysfs_register(c);
> +	if (err)
> +		goto out_debugging;
> +
> 	err = check_volume_empty(c);
> 	if (err)
> 		goto out_free;
> @@ -1641,6 +1646,8 @@ static int mount_ubifs(struct ubifs_info *c)
> 	vfree(c->sbuf);
> 	kfree(c->bottom_up_buf);
> 	kfree(c->sup_node);
> +	ubifs_sysfs_unregister(c);
> +out_debugging:
> 	ubifs_debugging_exit(c);
> 	return err;
> }
> @@ -1684,6 +1691,7 @@ static void ubifs_umount(struct ubifs_info *c)
> 	kfree(c->bottom_up_buf);
> 	kfree(c->sup_node);
> 	ubifs_debugging_exit(c);
> +	ubifs_sysfs_unregister(c);
> }
> 
> /**
> @@ -2436,14 +2444,20 @@ static int __init ubifs_init(void)
> 
> 	dbg_debugfs_init();
> 
> +	err = ubifs_sysfs_init();
> +	if (err)
> +		goto out_dbg;
> +
> 	err = register_filesystem(&ubifs_fs_type);
> 	if (err) {
> 		pr_err("UBIFS error (pid %d): cannot register file system, error %d",
> 		       current->pid, err);
> -		goto out_dbg;
> +		goto out_sysfs;
> 	}
> 	return 0;
> 
> +out_sysfs:
> +	ubifs_sysfs_exit();
> out_dbg:
> 	dbg_debugfs_exit();
> 	ubifs_compressors_exit();
> @@ -2462,6 +2476,7 @@ static void __exit ubifs_exit(void)
> 	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) != 0);
> 
> 	dbg_debugfs_exit();
> +	ubifs_sysfs_exit();
> 	ubifs_compressors_exit();
> 	unregister_shrinker(&ubifs_shrinker_info);
> 
> diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
> new file mode 100644
> index 000000000000..bac53a0f0451
> --- /dev/null
> +++ b/fs/ubifs/sysfs.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This file is part of UBIFS.
> + *
> + * Copyright (C) 2021 Cisco Systems
> + *
> + * Author: Stefan Schaeckeler
> + */
> +
> +
> +#include <linux/fs.h>
> +
> +#include "sysfs.h"
> +#include "ubifs.h"
> +
> +
> +enum attr_id_t {
> +	attr_errors_magic,
> +	attr_errors_node,
> +	attr_errors_crc,
> +};
> +
> +struct ubifs_attr {
> +	struct attribute attr;
> +	enum attr_id_t attr_id;
> +};
> +
> +#define UBIFS_ATTR(_name, _mode, _id)					\
> +static struct ubifs_attr ubifs_attr_##_name = {				\
> +	.attr = {.name = __stringify(_name), .mode = _mode },		\
> +	.attr_id = attr_##_id,						\
> +}
> +
> +#define UBIFS_ATTR_FUNC(_name, _mode) UBIFS_ATTR(_name, _mode, _name)
> +
> +UBIFS_ATTR_FUNC(errors_magic, 0644);
> +UBIFS_ATTR_FUNC(errors_crc, 0644);
> +UBIFS_ATTR_FUNC(errors_node, 0644);

I'm not sure whether everyone should be allowed to read these stats.
dmesg is also restricted these days. An unprivileged user should not see the
errors he can indirectly trigger.

> +#define ATTR_LIST(name) (&ubifs_attr_##name.attr)
> +
> +static struct attribute *ubifs_attrs[] = {
> +	ATTR_LIST(errors_magic),
> +	ATTR_LIST(errors_node),
> +	ATTR_LIST(errors_crc),
> +	NULL,
> +};
> +
> +
> +static ssize_t ubifs_attr_show(struct kobject *kobj,
> +			       struct attribute *attr, char *buf)
> +{
> +	struct ubifs_info *sbi = container_of(kobj, struct ubifs_info,
> +					      kobj);
> +
> +	struct ubifs_attr *a = container_of(attr, struct ubifs_attr, attr);
> +
> +	switch (a->attr_id) {
> +	case attr_errors_magic:
> +		return snprintf(buf, PAGE_SIZE, "%u\n",
> +				sbi->stats->magic_errors);
> +	case attr_errors_node:
> +		return snprintf(buf, PAGE_SIZE, "%u\n",
> +				sbi->stats->node_errors);
> +	case attr_errors_crc:
> +		return snprintf(buf, PAGE_SIZE, "%u\n",
> +				sbi->stats->crc_errors);

Please use sysfs_emit().

> +	}
> +	return 0;
> +};
> +
> +
> +static ssize_t ubifs_attr_store(struct kobject *kobj,
> +			       struct attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct ubifs_info *sbi = container_of(kobj, struct ubifs_info,
> +					      kobj);
> +
> +	struct ubifs_attr *a = container_of(attr, struct ubifs_attr, attr);
> +
> +	switch (a->attr_id) {
> +	case attr_errors_magic:
> +		sbi->stats->magic_errors = 0;
> +		break;
> +	case attr_errors_node:
> +		sbi->stats->node_errors = 0;
> +		break;
> +	case attr_errors_crc:
> +		sbi->stats->crc_errors = 0;
> +		break;
> +	}
> +	return len;
> +}
> +
> +
> +static void ubifs_sb_release(struct kobject *kobj)
> +{
> +	struct ubifs_info *c = container_of(kobj, struct ubifs_info, kobj);
> +
> +	complete(&c->kobj_unregister);
> +}
> +
> +
> +static const struct sysfs_ops ubifs_attr_ops = {
> +	.show	= ubifs_attr_show,
> +	.store	= ubifs_attr_store,
> +};
> +
> +static struct kobj_type ubifs_sb_ktype = {
> +	.default_attrs	= ubifs_attrs,
> +	.sysfs_ops	= &ubifs_attr_ops,
> +	.release	= ubifs_sb_release,
> +};
> +
> +static struct kobj_type ubifs_ktype = {
> +	.sysfs_ops	= &ubifs_attr_ops,
> +};
> +
> +static struct kset ubifs_kset = {
> +	.kobj	= {.ktype = &ubifs_ktype},
> +};
> +
> +
> +int ubifs_sysfs_register(struct ubifs_info *c)
> +{
> +	int ret, n;
> +	char dfs_dir_name[UBIFS_DFS_DIR_LEN+1];
> +
> +	c->stats = kzalloc(sizeof(struct ubifs_stats_info), GFP_KERNEL);
> +	if (!c->stats) {
> +		ret = -ENOMEM;
> +		goto out_last;
> +	}
> +	n = snprintf(dfs_dir_name, UBIFS_DFS_DIR_LEN + 1, UBIFS_DFS_DIR_NAME,
> +		     c->vi.ubi_num, c->vi.vol_id);
> +
> +	if (n == UBIFS_DFS_DIR_LEN) {
> +		/* The array size is too small */
> +		ret = -EINVAL;
> +		goto out_last;

Where is c->stats released in case of an error?

> +	}
> +
> +	c->kobj.kset = &ubifs_kset;
> +	init_completion(&c->kobj_unregister);
> +
> +
> +	ret = kobject_init_and_add(&c->kobj, &ubifs_sb_ktype, NULL,
> +				   "%s", dfs_dir_name);
> +	if (ret)
> +		goto out_put;
> +
> +	return 0;
> +
> +out_put:
> +	kobject_put(&c->kobj);
> +	wait_for_completion(&c->kobj_unregister);
> +out_last:
> +	ubifs_err(c, "cannot create sysfs entry for ubifs%d_%d, error %d\n",
> +		  c->vi.ubi_num, c->vi.vol_id, ret);
> +	return ret;
> +}
> +
> +void ubifs_sysfs_unregister(struct ubifs_info *c)
> +{
> +	kobject_del(&c->kobj);
> +	kobject_put(&c->kobj);
> +	wait_for_completion(&c->kobj_unregister);
> +
> +	kfree(c->stats);
> +}
> +
> +int __init ubifs_sysfs_init(void)
> +{
> +	int ret;
> +
> +	kobject_set_name(&ubifs_kset.kobj, "ubifs");
> +	ubifs_kset.kobj.parent = fs_kobj;
> +	ret = kset_register(&ubifs_kset);
> +
> +	return ret;
> +}
> +
> +void ubifs_sysfs_exit(void)
> +{
> +	kset_unregister(&ubifs_kset);
> +}
> diff --git a/fs/ubifs/sysfs.h b/fs/ubifs/sysfs.h
> new file mode 100644
> index 000000000000..a10a82585af8
> --- /dev/null
> +++ b/fs/ubifs/sysfs.h

Do we really need a new header file?
Usually most run-time stuff of UBIFS is part of ubifs.h.

> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * This file is part of UBIFS.
> + *
> + * Copyright (C) 2021 Cisco Systems
> + *
> + * Author: Stefan Schaeckeler
> + */
> +
> +#ifndef __UBIFS_SYSFS_H__
> +#define __UBIFS_SYSFS_H__
> +
> +struct ubifs_info;
> +
> +/*
> + * The UBIFS sysfs directory name pattern and maximum name length (3 for "ubi"
> + * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
> + */
> +#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
> +#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
> +
> +/**
> + * ubifs_stats_info - per-FS statistics information.
> + * @magic_errors: number of bad magic numbers (will be reset with a new mount).
> + * @node_errors: number of bad nodes (will be reset with a new mount).
> + * @crc_errors: number of bad crcs (will be reset with a new mount).
> + */
> +struct ubifs_stats_info {
> +	unsigned int magic_errors;
> +	unsigned int node_errors;
> +	unsigned int crc_errors;
> +};
> +
> +int ubifs_sysfs_init(void);
> +void ubifs_sysfs_exit(void);
> +int ubifs_sysfs_register(struct ubifs_info *c);
> +void ubifs_sysfs_unregister(struct ubifs_info *c);
> +
> +#endif
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index c38066ce9ab0..bfc0f20b41a1 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -27,12 +27,15 @@
> #include <linux/security.h>
> #include <linux/xattr.h>
> #include <linux/random.h>
> +#include <linux/sysfs.h>
> +#include <linux/completion.h>
> #include <crypto/hash_info.h>
> #include <crypto/hash.h>
> #include <crypto/algapi.h>
> 
> #include <linux/fscrypt.h>
> 
> +#include "sysfs.h"
> #include "ubifs-media.h"
> 
> /* Version of this UBIFS implementation */
> @@ -1251,6 +1254,10 @@ struct ubifs_debug_info;
>  * @mount_opts: UBIFS-specific mount options
>  *
>  * @dbg: debugging-related information
> + * @stats: statistics exported over sysfs
> + *
> + * @kobj: kobject for /sys/fs/ubifs/
> + * @kobj_unregister: completion to unregister sysfs kobject
>  */
> struct ubifs_info {
> 	struct super_block *vfs_sb;
> @@ -1286,6 +1293,9 @@ struct ubifs_info {
> 	spinlock_t cs_lock;
> 	wait_queue_head_t cmt_wq;
> 
> +	struct kobject kobj;
> +	struct completion kobj_unregister;
> +
> 	unsigned int big_lpt:1;
> 	unsigned int space_fixup:1;
> 	unsigned int double_hash:1;
> @@ -1493,6 +1503,7 @@ struct ubifs_info {
> 	struct ubifs_mount_opts mount_opts;
> 
> 	struct ubifs_debug_info *dbg;
> +	struct ubifs_stats_info *stats;
> };
> 
> extern struct list_head ubifs_infos;
> --
> 2.32.0
