Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7279403068
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347354AbhIGVmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:42:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:50461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347360AbhIGVmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631050859;
        bh=kWZ78VBSWxFcbUf6kabzO2DbnWdWyGeN3XeY5rhy2vw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bfEwvLfsw0E+u5F+pORreEB4yQTTBaI95VyqoWd4UN1mImJSzAX+YRxk7bKnOzuGp
         MhXe/JNJnVDGZ/LtPVEWJDiNzEjkrb4Po5xlCz+ob+HauW5fAAHKafDk3qTg2eHYzA
         ETPJIHWcCf6sHEgkyllzptUVq+vdQ2K7F8AMMUYI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.131]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mq2nA-1mj3M02WkU-00nBfp; Tue, 07 Sep 2021 23:40:59 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id 390B1899915; Tue,  7 Sep 2021 14:40:43 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Schaeckeler <schaecsn@gmx.net>,
        Stefan Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH 1/1] ubifs: ubifs to export filesystem error counters
Date:   Tue,  7 Sep 2021 14:40:34 -0700
Message-Id: <20210907214034.11676-2-schaecsn@gmx.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907214034.11676-1-schaecsn@gmx.net>
References: <20210907214034.11676-1-schaecsn@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jXi2kbpUZnyp78T+zMG4FCJlGT+JufVc5+/C/spkX8ymuUR7MaM
 cRMYbO57zrn/N4USoJZpw9HdepbyjZ/uggAtWRvqz8r0xmmQr3QikZLJqdhcweKI28FVmoP
 2ZLtYioIyqHdTgzKrJjudTlvRC855FxePfa4pCYKiTYPzM/pdSoTdZX+WqO52V+dpbKJiI+
 67yJ/LaSr5IYeYlyvwSzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JFne9iDOlvk=:Md07mO/9L1kvUsgRw1sRDE
 7h9EOcwP/wgtcwTMpOA3E7MiYx6eH5eI9yXbGN0jmc7OCol/ehHI0fUrk8YTmRDUFANgrtyci
 I288ojsoLj1TO6OTyle3DD1FYUpf0smiOoCpaUwt1c4o71051xf4B1IxylZ+Vr5skj6uBCQ4f
 bxQ0TFtNSri9eAouitHTxKgC5xU9TYfSt9cIAbfny4rokMh0eLmC0spOsOrbOa/U3mopOxkqh
 Szz9r95CX8lfmF44RoXNJobhLkIRKJlGCynOy5t/xpnZOCo90gE4dFQ3n5ISdWCGfEXa9NlK7
 F92HatmmpU4a+Cio1Wd8eR8tqkk2OndD+l7B1JntHO5IGofbFDMGtKQrVaY6WA4e6h0jOihMS
 SUCqWTtUQrQJivislNSnkmPMLoA8H4dpKmawzVZG8Vz5GmXUb/hRZQUK4c3z/O3Zrdj7eUyF3
 DF8rEsPEutVC0Ez00uMMlv6XWdcpsIYnDl6FJnDRCvCCKDw2LuNAlHs2zxu7s00sVhb3BnrDv
 9TBuzTH9PX6NFuOrJ1DxCl8+iiXPmS2llKsdlWHgDSO78Y8nqhz5H9Y5yVwZ2fUFTLuoHz6TH
 cwgZ06TFf/pY8dNbMNTsl39pwYKYfbYfAKEHPMCwf/ayRORxoj6WfirgWG/XRQ3W2XOaspnfW
 pie4UOyhn32chbbaHMqEIxCd/BHSruQof88EbedOBpYM9FTBVj9iyzs4T6KAv4EZkNutDiW/m
 UNsnj9UWcD6wno8Z7pVNhoSLpbQT40LXl4lkO9bSwi/IlRJpHzxXil1757ttsjlMGIv2LsFxE
 di106v2nCGP+EWyIh1HbNUxk1bVhrnuEK4y0hpdbqvop+c0Ffy3nMSkpt2bC6O1BP5PfOthMi
 RLvnLxRke0Y9/F2Eg2/Sfx31KlxNTL0OF3OiggvhK3OmhfUOvTK56a3v9gdsGS6mYWuu8Eqz/
 DLNkAJN3EyVGHIMGmiGSUNetD9ywA10xOc0IQcRuYX9RIdzQhxlAlNTEUPYgEYFtlU/PICKFX
 9u9JOJzM6Pk79uaUy8OL96/18CE2Lp0zdu4rlkhukL3dZZmUWdBs126QU/52vMqW9yrPEyW2l
 J6pZVUcac2vVSewCZwxSDCxxCO5h5XNO3PEuMc3fuviGnBe4qVtLEVM2w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all ubifs filesystem errors are propagated to userspace.

Export bad magic, bad node and crc errors via sysfs. This allows userspace
to notice filesystem errors:

 /sys/fs/ubifs/ubiX_Y/errors_magic
 /sys/fs/ubifs/ubiX_Y/errors_node
 /sys/fs/ubifs/ubiX_Y/errors_crc

The counters are reset to 0 with a remount. Writing anything into the
counters also clears them.

Signed-off-by: Stefan Schaeckeler <sschaeck@cisco.com>
=2D--
 fs/ubifs/Makefile |   2 +-
 fs/ubifs/io.c     |   6 ++
 fs/ubifs/super.c  |  17 ++++-
 fs/ubifs/sysfs.c  | 187 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/sysfs.h  |  39 ++++++++++
 fs/ubifs/ubifs.h  |  11 +++
 6 files changed, 260 insertions(+), 2 deletions(-)
 create mode 100644 fs/ubifs/sysfs.c
 create mode 100644 fs/ubifs/sysfs.h

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
index 00b61dba62b7..0b158e420cc1 100644
=2D-- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -238,6 +238,8 @@ int ubifs_check_node(const struct ubifs_info *c, const=
 void *buf, int len,
 		if (!quiet)
 			ubifs_err(c, "bad magic %#08x, expected %#08x",
 				  magic, UBIFS_NODE_MAGIC);
+		if (c->stats)
+			c->stats->magic_errors++;
 		err =3D -EUCLEAN;
 		goto out;
 	}
@@ -246,6 +248,8 @@ int ubifs_check_node(const struct ubifs_info *c, const=
 void *buf, int len,
 	if (type < 0 || type >=3D UBIFS_NODE_TYPES_CNT) {
 		if (!quiet)
 			ubifs_err(c, "bad node type %d", type);
+		if (c->stats)
+			c->stats->node_errors++;
 		goto out;
 	}

@@ -270,6 +274,8 @@ int ubifs_check_node(const struct ubifs_info *c, const=
 void *buf, int len,
 		if (!quiet)
 			ubifs_err(c, "bad CRC: calculated %#08x, read %#08x",
 				  crc, node_crc);
+		if (c->stats)
+			c->stats->crc_errors++;
 		err =3D -EUCLEAN;
 		goto out;
 	}
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f0fb25727d96..50b934854a84 100644
=2D-- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -24,6 +24,7 @@
 #include <linux/mount.h>
 #include <linux/math64.h>
 #include <linux/writeback.h>
+#include "sysfs.h"
 #include "ubifs.h"

 static int ubifs_default_version_set(const char *val, const struct kernel=
_param *kp)
@@ -1264,6 +1265,10 @@ static int mount_ubifs(struct ubifs_info *c)
 	if (err)
 		return err;

+	err =3D ubifs_sysfs_register(c);
+	if (err)
+		goto out_debugging;
+
 	err =3D check_volume_empty(c);
 	if (err)
 		goto out_free;
@@ -1641,6 +1646,8 @@ static int mount_ubifs(struct ubifs_info *c)
 	vfree(c->sbuf);
 	kfree(c->bottom_up_buf);
 	kfree(c->sup_node);
+	ubifs_sysfs_unregister(c);
+out_debugging:
 	ubifs_debugging_exit(c);
 	return err;
 }
@@ -1684,6 +1691,7 @@ static void ubifs_umount(struct ubifs_info *c)
 	kfree(c->bottom_up_buf);
 	kfree(c->sup_node);
 	ubifs_debugging_exit(c);
+	ubifs_sysfs_unregister(c);
 }

 /**
@@ -2436,14 +2444,20 @@ static int __init ubifs_init(void)

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
@@ -2462,6 +2476,7 @@ static void __exit ubifs_exit(void)
 	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) !=3D 0);

 	dbg_debugfs_exit();
+	ubifs_sysfs_exit();
 	ubifs_compressors_exit();
 	unregister_shrinker(&ubifs_shrinker_info);

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
new file mode 100644
index 000000000000..bac53a0f0451
=2D-- /dev/null
+++ b/fs/ubifs/sysfs.c
@@ -0,0 +1,187 @@
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
+
+#include "sysfs.h"
+#include "ubifs.h"
+
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
+UBIFS_ATTR_FUNC(errors_magic, 0644);
+UBIFS_ATTR_FUNC(errors_crc, 0644);
+UBIFS_ATTR_FUNC(errors_node, 0644);
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
+		return snprintf(buf, PAGE_SIZE, "%u\n",
+				sbi->stats->magic_errors);
+	case attr_errors_node:
+		return snprintf(buf, PAGE_SIZE, "%u\n",
+				sbi->stats->node_errors);
+	case attr_errors_crc:
+		return snprintf(buf, PAGE_SIZE, "%u\n",
+				sbi->stats->crc_errors);
+	}
+	return 0;
+};
+
+
+static ssize_t ubifs_attr_store(struct kobject *kobj,
+			       struct attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct ubifs_info *sbi =3D container_of(kobj, struct ubifs_info,
+					      kobj);
+
+	struct ubifs_attr *a =3D container_of(attr, struct ubifs_attr, attr);
+
+	switch (a->attr_id) {
+	case attr_errors_magic:
+		sbi->stats->magic_errors =3D 0;
+		break;
+	case attr_errors_node:
+		sbi->stats->node_errors =3D 0;
+		break;
+	case attr_errors_crc:
+		sbi->stats->crc_errors =3D 0;
+		break;
+	}
+	return len;
+}
+
+
+static void ubifs_sb_release(struct kobject *kobj)
+{
+	struct ubifs_info *c =3D container_of(kobj, struct ubifs_info, kobj);
+
+	complete(&c->kobj_unregister);
+}
+
+
+static const struct sysfs_ops ubifs_attr_ops =3D {
+	.show	=3D ubifs_attr_show,
+	.store	=3D ubifs_attr_store,
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
+		goto out_last;
+	}
+
+	c->kobj.kset =3D &ubifs_kset;
+	init_completion(&c->kobj_unregister);
+
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
diff --git a/fs/ubifs/sysfs.h b/fs/ubifs/sysfs.h
new file mode 100644
index 000000000000..a10a82585af8
=2D-- /dev/null
+++ b/fs/ubifs/sysfs.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This file is part of UBIFS.
+ *
+ * Copyright (C) 2021 Cisco Systems
+ *
+ * Author: Stefan Schaeckeler
+ */
+
+#ifndef __UBIFS_SYSFS_H__
+#define __UBIFS_SYSFS_H__
+
+struct ubifs_info;
+
+/*
+ * The UBIFS sysfs directory name pattern and maximum name length (3 for =
"ubi"
+ * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero=
 byte.
+ */
+#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
+#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
+
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
+int ubifs_sysfs_init(void);
+void ubifs_sysfs_exit(void);
+int ubifs_sysfs_register(struct ubifs_info *c);
+void ubifs_sysfs_unregister(struct ubifs_info *c);
+
+#endif
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index c38066ce9ab0..bfc0f20b41a1 100644
=2D-- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -27,12 +27,15 @@
 #include <linux/security.h>
 #include <linux/xattr.h>
 #include <linux/random.h>
+#include <linux/sysfs.h>
+#include <linux/completion.h>
 #include <crypto/hash_info.h>
 #include <crypto/hash.h>
 #include <crypto/algapi.h>

 #include <linux/fscrypt.h>

+#include "sysfs.h"
 #include "ubifs-media.h"

 /* Version of this UBIFS implementation */
@@ -1251,6 +1254,10 @@ struct ubifs_debug_info;
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
@@ -1286,6 +1293,9 @@ struct ubifs_info {
 	spinlock_t cs_lock;
 	wait_queue_head_t cmt_wq;

+	struct kobject kobj;
+	struct completion kobj_unregister;
+
 	unsigned int big_lpt:1;
 	unsigned int space_fixup:1;
 	unsigned int double_hash:1;
@@ -1493,6 +1503,7 @@ struct ubifs_info {
 	struct ubifs_mount_opts mount_opts;

 	struct ubifs_debug_info *dbg;
+	struct ubifs_stats_info *stats;
 };

 extern struct list_head ubifs_infos;
=2D-
2.32.0

