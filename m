Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D502427EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 06:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJJE0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 00:26:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:59945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJJE0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 00:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633839839;
        bh=zoB3awKwl7yGR9qqPV4bKFJwWlxjjGQsecyl+hMO49U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FeR8u6PfOWeQwy12CO6GzIy3XogSRXhldScub+Ibwf2Z0aJhQorn5ndR2M7xmBcwC
         jBmpiMHcV6KHMqUkjZGo39qG/e7qm7zu+jZ/iEaBTiKhBRh5H2bSnyi6YfWWjGjl4b
         K6jz8C2OCRc4txwsI/k44+FRYMsrh/5VwkIMe5RI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.131]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N4Qwg-1mioGG2Tpe-011OcA; Sun, 10 Oct 2021 06:23:59 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id AEA34899826; Sat,  9 Oct 2021 21:23:50 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Schaeckeler <schaecsn@gmx.net>,
        Stefan Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH v2] ubifs: ubifs to export filesystem error counters
Date:   Sat,  9 Oct 2021 21:22:39 -0700
Message-Id: <20211010042239.2888-1-schaecsn@gmx.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aY+ojOOe6oAhMJp3Srkg9n8xDOygYx4ucWhHYDfUft3VFckXhs6
 o1sN3GxUIkObJ7EbhiMV9z9bO/cr66rpggCjkfw9bf6DRDvdnLAG8SbXzzkTvuka6/IwMxj
 oy0al/OpySEDlJBjovmgP74n4Q3TnBiQlSJuioFa25uqsrsrfC/nznFEFDpdkhl3xgFHvhs
 sL8xDNNX7pD/UAo6V0kkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z76qK7X0m6I=:VfmalSbRd59EpgASNDjG2B
 JktUgZjx/NcWIO6ywqCd74/HQGkok9u2AVduaAqvIKR9cxJXt70KQbZCj6l4lujxAEi1aF3W4
 +ckRAIvuC3gl9N+o2qqh2N+byCHE+zb5SJLxM2r8VAroI3F97e4Ox9cyfW2e7PdNN9ej3QqEJ
 KicK2KS4eE31TIGNqHoeQAZCpLdeXfyKHxYB/XfYk9mavRqpvdD6oO7LWYFmGqyXwyd+2B7Bb
 98+vhqpL9SXgwEjHsHfUaA5HOrdCIbAsqiolx3KEqsMiUX/A6WcQCRL6qSRirel018pIQqbDf
 C/6GGkjQsHk1ZJDoduWLk66GjU4+G9+FbxTuSljHA1ZxZ55sfgszkPJXeLbJn7M05dnWOEyUt
 olRQe0bCy6CEX2mke2vJh59exLdtjhS/JZHYGawo4MiAigHAyF3Cfgv3RIcQQTSV/jXVkPnC2
 Bd0OtQQzaeYGabCr3zaBSvPRqMIwSCEH8yjCFwDQVcv2mk1HeroEC4Q2fLYn2CO0GvVNwNtPf
 aZQSfZ2YzwihzIUwk9e/TSQSZF9F7+Tfn+ZIaMS4G663qGALF1pmMxdH0TKE8/7/UJnso6AQx
 Yh6vZL3+6sC56y7IZktrlEamRXbwlW1tV0a6ML6V7NAddusreGkPabj8Ua1yyVMs6yWGwcdnt
 paV4G+MtDHfLWgGCgwSnX1fMnYaiP2Dm8x2ZLnGzUDx7TH2Z+KK0GNZMpzuXeMNNUDzVJjXEx
 +caeAQhpRzv8cCrQ8VHgbE6ehAXpKkYUuNo4wr9kvQzkI/Ly1dxuHLwVYiG/vMY/nVzHIfmWI
 5pf76gRgIC4Ibsvf8X91ue5z/I1OAZNajRd9PtwCSb5++rikDCxt/zuGmxghkUYW6ahJr7Fh0
 wXCQ1rWRvcj47b/3bATd7C7yrvS+PMVgt+DvGSDkpwGcD06jX0BoymuhLhHm5X+UI6dpttMZa
 PyYkP5eccST0Z+TorlouytOkBa7zXvSwH1g0QyPC6hHGs5DxPtPIs9aJ8Cn86HhZyADf4UbU5
 0X9gUJV2MFSHjPUOGkIx4uNwOJYT0DMqxcLDgMuCLGLn5MtT4KXD1cHOBSmunEurpluF17Vau
 TauKwI2XW92Zs8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all ubifs filesystem errors are propagated to userspace.

Export bad magic, bad node and crc errors via sysfs. This allows userspace
to notice filesystem errors:

 /sys/fs/ubifs/ubiX_Y/errors_magic
 /sys/fs/ubifs/ubiX_Y/errors_node
 /sys/fs/ubifs/ubiX_Y/errors_crc

The counters are reset to 0 with a remount.

Signed-off-by: Stefan Schaeckeler <sschaeck@cisco.com>
=2D--
Changes in v2:
  - merged sysfs.h header into ubifs.h.
  - io.c: wrapped incrementing error counters into new functions
    record_*_error().
  - sysfs.c: removed sysfs write callback for clearing stats.
  - sysfs.c: ubifs_sysfs_register(): free c->stats on error.
  - sysfs.c: ubifs_attr_show(): use sysfs_emit().

 fs/ubifs/Makefile |   2 +-
 fs/ubifs/io.c     |  21 +++++++
 fs/ubifs/super.c  |  16 ++++-
 fs/ubifs/sysfs.c  | 153 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h  |  35 +++++++++++
 5 files changed, 225 insertions(+), 2 deletions(-)
 create mode 100644 fs/ubifs/sysfs.c

diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
index 5c4b845754a7..314c80b24a76 100644
=2D-- a/fs/ubifs/Makefile
+++ b/fs/ubifs/Makefile
@@ -5,7 +5,7 @@ ubifs-y +=3D shrinker.o journal.o file.o dir.o super.o sb.=
o io.o
 ubifs-y +=3D tnc.o master.o scan.o replay.o log.o commit.o gc.o orphan.o
 ubifs-y +=3D budget.o find.o tnc_commit.o compress.o lpt.o lprops.o
 ubifs-y +=3D recovery.o ioctl.o lpt_commit.o tnc_misc.o debug.o
-ubifs-y +=3D misc.o
+ubifs-y +=3D misc.o sysfs.o
 ubifs-$(CONFIG_FS_ENCRYPTION) +=3D crypto.o
 ubifs-$(CONFIG_UBIFS_FS_XATTR) +=3D xattr.o
 ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) +=3D auth.o
diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 00b61dba62b7..789a7813f3fa 100644
=2D-- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -194,6 +194,24 @@ int ubifs_is_mapped(const struct ubifs_info *c, int l=
num)
 	return err;
 }

+static void record_magic_error(struct ubifs_stats_info *stats)
+{
+	if (stats)
+		stats->magic_errors++;
+}
+
+static void record_node_error(struct ubifs_stats_info *stats)
+{
+	if (stats)
+		stats->node_errors++;
+}
+
+static void record_crc_error(struct ubifs_stats_info *stats)
+{
+	if (stats)
+		stats->crc_errors++;
+}
+
 /**
  * ubifs_check_node - check node.
  * @c: UBIFS file-system description object
@@ -238,6 +256,7 @@ int ubifs_check_node(const struct ubifs_info *c, const=
 void *buf, int len,
 		if (!quiet)
 			ubifs_err(c, "bad magic %#08x, expected %#08x",
 				  magic, UBIFS_NODE_MAGIC);
+		record_magic_error(c->stats);
 		err =3D -EUCLEAN;
 		goto out;
 	}
@@ -246,6 +265,7 @@ int ubifs_check_node(const struct ubifs_info *c, const=
 void *buf, int len,
 	if (type < 0 || type >=3D UBIFS_NODE_TYPES_CNT) {
 		if (!quiet)
 			ubifs_err(c, "bad node type %d", type);
+		record_node_error(c->stats);
 		goto out;
 	}

@@ -270,6 +290,7 @@ int ubifs_check_node(const struct ubifs_info *c, const=
 void *buf, int len,
 		if (!quiet)
 			ubifs_err(c, "bad CRC: calculated %#08x, read %#08x",
 				  crc, node_crc);
+		record_crc_error(c->stats);
 		err =3D -EUCLEAN;
 		goto out;
 	}
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f0fb25727d96..a4e3a143fb1b 100644
=2D-- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1264,6 +1264,10 @@ static int mount_ubifs(struct ubifs_info *c)
 	if (err)
 		return err;

+	err =3D ubifs_sysfs_register(c);
+	if (err)
+		goto out_debugging;
+
 	err =3D check_volume_empty(c);
 	if (err)
 		goto out_free;
@@ -1641,6 +1645,8 @@ static int mount_ubifs(struct ubifs_info *c)
 	vfree(c->sbuf);
 	kfree(c->bottom_up_buf);
 	kfree(c->sup_node);
+	ubifs_sysfs_unregister(c);
+out_debugging:
 	ubifs_debugging_exit(c);
 	return err;
 }
@@ -1684,6 +1690,7 @@ static void ubifs_umount(struct ubifs_info *c)
 	kfree(c->bottom_up_buf);
 	kfree(c->sup_node);
 	ubifs_debugging_exit(c);
+	ubifs_sysfs_unregister(c);
 }

 /**
@@ -2436,14 +2443,20 @@ static int __init ubifs_init(void)

 	dbg_debugfs_init();

+	err =3D ubifs_sysfs_init();
+	if (err)
+		goto out_dbg;
+
 	err =3D register_filesystem(&ubifs_fs_type);
 	if (err) {
 		pr_err("UBIFS error (pid %d): cannot register file system, error %d",
 		       current->pid, err);
-		goto out_dbg;
+		goto out_sysfs;
 	}
 	return 0;

+out_sysfs:
+	ubifs_sysfs_exit();
 out_dbg:
 	dbg_debugfs_exit();
 	ubifs_compressors_exit();
@@ -2462,6 +2475,7 @@ static void __exit ubifs_exit(void)
 	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) !=3D 0);

 	dbg_debugfs_exit();
+	ubifs_sysfs_exit();
 	ubifs_compressors_exit();
 	unregister_shrinker(&ubifs_shrinker_info);

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
new file mode 100644
index 000000000000..0b6f79b6e2e8
=2D-- /dev/null
+++ b/fs/ubifs/sysfs.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file is part of UBIFS.
+ *
+ * Copyright (C) 2021 Cisco Systems
+ *
+ * Author: Stefan Schaeckeler
+ */
+
+
+#include <linux/fs.h>
+#include "ubifs.h"
+
+enum attr_id_t {
+	attr_errors_magic,
+	attr_errors_node,
+	attr_errors_crc,
+};
+
+struct ubifs_attr {
+	struct attribute attr;
+	enum attr_id_t attr_id;
+};
+
+#define UBIFS_ATTR(_name, _mode, _id)					\
+static struct ubifs_attr ubifs_attr_##_name =3D {				\
+	.attr =3D {.name =3D __stringify(_name), .mode =3D _mode },		\
+	.attr_id =3D attr_##_id,						\
+}
+
+#define UBIFS_ATTR_FUNC(_name, _mode) UBIFS_ATTR(_name, _mode, _name)
+
+UBIFS_ATTR_FUNC(errors_magic, 0444);
+UBIFS_ATTR_FUNC(errors_crc, 0444);
+UBIFS_ATTR_FUNC(errors_node, 0444);
+
+#define ATTR_LIST(name) (&ubifs_attr_##name.attr)
+
+static struct attribute *ubifs_attrs[] =3D {
+	ATTR_LIST(errors_magic),
+	ATTR_LIST(errors_node),
+	ATTR_LIST(errors_crc),
+	NULL,
+};
+
+static ssize_t ubifs_attr_show(struct kobject *kobj,
+			       struct attribute *attr, char *buf)
+{
+	struct ubifs_info *sbi =3D container_of(kobj, struct ubifs_info,
+					      kobj);
+
+	struct ubifs_attr *a =3D container_of(attr, struct ubifs_attr, attr);
+
+	switch (a->attr_id) {
+	case attr_errors_magic:
+		return sysfs_emit(buf, "%u\n", sbi->stats->magic_errors);
+	case attr_errors_node:
+		return sysfs_emit(buf, "%u\n", sbi->stats->node_errors);
+	case attr_errors_crc:
+		return sysfs_emit(buf, "%u\n", sbi->stats->crc_errors);
+	}
+	return 0;
+};
+
+static void ubifs_sb_release(struct kobject *kobj)
+{
+	struct ubifs_info *c =3D container_of(kobj, struct ubifs_info, kobj);
+
+	complete(&c->kobj_unregister);
+}
+
+static const struct sysfs_ops ubifs_attr_ops =3D {
+	.show	=3D ubifs_attr_show,
+};
+
+static struct kobj_type ubifs_sb_ktype =3D {
+	.default_attrs	=3D ubifs_attrs,
+	.sysfs_ops	=3D &ubifs_attr_ops,
+	.release	=3D ubifs_sb_release,
+};
+
+static struct kobj_type ubifs_ktype =3D {
+	.sysfs_ops	=3D &ubifs_attr_ops,
+};
+
+static struct kset ubifs_kset =3D {
+	.kobj	=3D {.ktype =3D &ubifs_ktype},
+};
+
+int ubifs_sysfs_register(struct ubifs_info *c)
+{
+	int ret, n;
+	char dfs_dir_name[UBIFS_DFS_DIR_LEN+1];
+
+	c->stats =3D kzalloc(sizeof(struct ubifs_stats_info), GFP_KERNEL);
+	if (!c->stats) {
+		ret =3D -ENOMEM;
+		goto out_last;
+	}
+	n =3D snprintf(dfs_dir_name, UBIFS_DFS_DIR_LEN + 1, UBIFS_DFS_DIR_NAME,
+		     c->vi.ubi_num, c->vi.vol_id);
+
+	if (n =3D=3D UBIFS_DFS_DIR_LEN) {
+		/* The array size is too small */
+		ret =3D -EINVAL;
+		goto out_free;
+	}
+
+	c->kobj.kset =3D &ubifs_kset;
+	init_completion(&c->kobj_unregister);
+
+	ret =3D kobject_init_and_add(&c->kobj, &ubifs_sb_ktype, NULL,
+				   "%s", dfs_dir_name);
+	if (ret)
+		goto out_put;
+
+	return 0;
+
+out_put:
+	kobject_put(&c->kobj);
+	wait_for_completion(&c->kobj_unregister);
+out_free:
+	kfree(c->stats);
+out_last:
+	ubifs_err(c, "cannot create sysfs entry for ubifs%d_%d, error %d\n",
+		  c->vi.ubi_num, c->vi.vol_id, ret);
+	return ret;
+}
+
+void ubifs_sysfs_unregister(struct ubifs_info *c)
+{
+	kobject_del(&c->kobj);
+	kobject_put(&c->kobj);
+	wait_for_completion(&c->kobj_unregister);
+
+	kfree(c->stats);
+}
+
+int __init ubifs_sysfs_init(void)
+{
+	int ret;
+
+	kobject_set_name(&ubifs_kset.kobj, "ubifs");
+	ubifs_kset.kobj.parent =3D fs_kobj;
+	ret =3D kset_register(&ubifs_kset);
+
+	return ret;
+}
+
+void ubifs_sysfs_exit(void)
+{
+	kset_unregister(&ubifs_kset);
+}
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index c38066ce9ab0..f55828c0a300 100644
=2D-- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -27,6 +27,8 @@
 #include <linux/security.h>
 #include <linux/xattr.h>
 #include <linux/random.h>
+#include <linux/sysfs.h>
+#include <linux/completion.h>
 #include <crypto/hash_info.h>
 #include <crypto/hash.h>
 #include <crypto/algapi.h>
@@ -155,6 +157,13 @@
 #define UBIFS_HMAC_ARR_SZ 0
 #endif

+/*
+ * The UBIFS sysfs directory name pattern and maximum name length (3 for =
"ubi"
+ * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero=
 byte.
+ */
+#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
+#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
+
 /*
  * Lockdep classes for UBIFS inode @ui_mutex.
  */
@@ -990,6 +999,18 @@ struct ubifs_budg_info {
 	int dent_budget;
 };

+/**
+ * ubifs_stats_info - per-FS statistics information.
+ * @magic_errors: number of bad magic numbers (will be reset with a new m=
ount).
+ * @node_errors: number of bad nodes (will be reset with a new mount).
+ * @crc_errors: number of bad crcs (will be reset with a new mount).
+ */
+struct ubifs_stats_info {
+	unsigned int magic_errors;
+	unsigned int node_errors;
+	unsigned int crc_errors;
+};
+
 struct ubifs_debug_info;

 /**
@@ -1251,6 +1272,10 @@ struct ubifs_debug_info;
  * @mount_opts: UBIFS-specific mount options
  *
  * @dbg: debugging-related information
+ * @stats: statistics exported over sysfs
+ *
+ * @kobj: kobject for /sys/fs/ubifs/
+ * @kobj_unregister: completion to unregister sysfs kobject
  */
 struct ubifs_info {
 	struct super_block *vfs_sb;
@@ -1286,6 +1311,9 @@ struct ubifs_info {
 	spinlock_t cs_lock;
 	wait_queue_head_t cmt_wq;

+	struct kobject kobj;
+	struct completion kobj_unregister;
+
 	unsigned int big_lpt:1;
 	unsigned int space_fixup:1;
 	unsigned int double_hash:1;
@@ -1493,6 +1521,7 @@ struct ubifs_info {
 	struct ubifs_mount_opts mount_opts;

 	struct ubifs_debug_info *dbg;
+	struct ubifs_stats_info *stats;
 };

 extern struct list_head ubifs_infos;
@@ -2072,6 +2101,12 @@ void ubifs_compress(const struct ubifs_info *c, con=
st void *in_buf, int in_len,
 int ubifs_decompress(const struct ubifs_info *c, const void *buf, int len=
,
 		     void *out, int *out_len, int compr_type);

+/* sysfs.c */
+int ubifs_sysfs_init(void);
+void ubifs_sysfs_exit(void);
+int ubifs_sysfs_register(struct ubifs_info *c);
+void ubifs_sysfs_unregister(struct ubifs_info *c);
+
 #include "debug.h"
 #include "misc.h"
 #include "key.h"
=2D-
2.33.0

