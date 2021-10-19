Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041AF4331FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhJSJSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhJSJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:18:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63180C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:15:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r18so46465919wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMikHHYdhthJbeJEBvk8HzAZHkgdghZW5I1MkpMHkMQ=;
        b=aztoQ8aI6DpVnptER/lAbnP9cPIah29iyr8KKtoYgLutVOh3KSQSoLfbd1HoCza0GP
         ie9SXeGnapgYpAU/b2wPx7sjHCG2hfFlAGrxVFvi6ekwqORLGhb6lV0ZsqaTegRqbva/
         AKHm7vmf4mtcr0muUtndfcAZlLoFeS6M3ig/i7fMrRUGWGHonUP2h3f9QatFmupiyw9E
         JWLWQpxOS6MOIBvmAa/c6WCwOSXGRFj2KTdMGLpcJ8ix+YpKpvkl+AE6BACOHnQXqa49
         /x8HiJVO3I5ygKOgKFGi+vVVh3inFe9Q7JuBgnGYGyAZ8vsogvh7JKfcTVtjvTLnV9jF
         6Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMikHHYdhthJbeJEBvk8HzAZHkgdghZW5I1MkpMHkMQ=;
        b=QAiGpWw5O4K/fefhGrZ5KjMntp70yz9i1bqVAny9NSWsrxYaLyNFKlaDLZluBIhJv+
         24sK90H6eiaxtpP6eE0Nhoz8mop6+B1HxBPDxnd2VEZJNLPydVuh7hTh3VxPnA7Jgxg4
         /XTtwbk0lkL8t7Vv+4szr2WkXG2w51G0xmwOsNxVnzoz8yVOTR4a1hV3BAaEgPReN2JR
         1ydRiqQYEyvjtN4A4UJOjpSElzkdCAXjeFT36DGvwGLtSLoEgbsJ7t7IBhEx4SLfOEuq
         ljMUjofwNMjviaBj7iAJ/K89nVek5MWSdYgLnT81IEVihLPOv6ZlFypgrvVq3k2Ic/bb
         kg7A==
X-Gm-Message-State: AOAM5308D/9K2/5S1jid4T8sPyoywzql0cKh2J5qRPy7+tot06Vtu3Oc
        ifcymbiEYYLMf18p//cWle/7ocs3o1hG/g==
X-Google-Smtp-Source: ABdhPJypUHddDwVVPm0zL+gjnwBZDvHEUwA8BhDlmuTKR86zSqMpXYvCZ62DoqJDPBi4VNMINRSnYg==
X-Received: by 2002:a05:6000:11:: with SMTP id h17mr42506933wrx.278.1634634948924;
        Tue, 19 Oct 2021 02:15:48 -0700 (PDT)
Received: from precision.. (aftr-62-216-202-35.dynamic.mnet-online.de. [62.216.202.35])
        by smtp.gmail.com with ESMTPSA id y191sm2029281wmc.36.2021.10.19.02.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:15:41 -0700 (PDT)
From:   Mete Polat <metepolat2000@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Mete Polat <metepolat2000@gmail.com>
Subject: [PATCH 1/2] rbtree: Expose a test tree to userspace
Date:   Tue, 19 Oct 2021 11:13:48 +0200
Message-Id: <20211019091349.39788-2-metepolat2000@gmail.com>
In-Reply-To: <20211019091349.39788-1-metepolat2000@gmail.com>
References: <20211019091349.39788-1-metepolat2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose rbtree manipulation functions on debugfs. These can be used for
testing the core rbtree implementation from userspace against a verified
oracle (a mathematically proven correct Red-Black tree):

<debugfs>/rbt_if/cmd
  write:
    0 = Reset rbtree (remove all nodes).
    1 = Insert key (see other file) into rbtree.
    2 = Delete key (see other file) from rbtree.
read:
  Print tree.

<debugfs>/rbt_if/key
  Read or write the key used for cmds
---
 lib/Kconfig.debug           |  19 +++++
 lib/Makefile                |   1 +
 lib/test_rbtree_interface.c | 161 ++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 lib/test_rbtree_interface.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3266fef7cb53..675c1a9fab67 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2623,6 +2623,25 @@ config TEST_CLOCKSOURCE_WATCHDOG
 
 	  If unsure, say N.
 
+config TEST_RBTREE_INTERFACE
+	tristate "Expose an Red-Black tree instance to userspace for testing"
+	depends on DEBUG_FS
+	help
+	  Exposes rbtree maniplation functions on debugfs. These can be used for
+	  testing the core rbtree implementation from userspace against a
+	  verified oracle (a mathematically proven correct Red-Black tree):
+	  <debugfs>/rbt_if/cmd
+		write:
+		0 = Reset rbtree (remove all nodes).
+		1 = Insert key (see other file) into rbtree.
+		2 = Delete key (see other file) from rbtree.
+		read:
+		Print tree.
+	  <debugfs>/rbt_if/key
+		Read or write the key used for cmds
+
+	  If unsure, say N.
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/Makefile b/lib/Makefile
index b0cb89451cd3..8e563b959c60 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
+obj-$(CONFIG_TEST_RBTREE_INTERFACE) += test_rbtree_interface.o
 
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
diff --git a/lib/test_rbtree_interface.c b/lib/test_rbtree_interface.c
new file mode 100644
index 000000000000..627c41c78a7a
--- /dev/null
+++ b/lib/test_rbtree_interface.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
+
+#include <linux/debugfs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/rbtree_augmented.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+enum Cmd { RESET, INSERT, DELETE };
+
+static struct dentry *rbt_if_root;
+static struct rb_root rbt = RB_ROOT;
+static u64 input_key;
+
+struct data {
+	struct rb_node node;
+	u64 key;
+};
+
+#define data_from_node(from) (rb_entry(from, struct data, node))
+
+#define print(...) seq_printf(m, __VA_ARGS__)
+#define print_parent print(" (%llu,%s) ", \
+		data_from_node(parent)->key, rb_is_red(parent) ? "Red" : "Black")
+
+static int cmd_show(struct seq_file *m, void *p)
+{
+	struct rb_node *node = rbt.rb_node, *parent = NULL;
+	bool left = false;
+	while(true) {
+		if (!node) {
+			print("Leaf");
+
+			if (!parent)
+				break;
+
+			if (left) {
+				print_parent;
+				node = parent->rb_right;
+				left = false;
+			} else {
+				while (rb_parent(parent) && parent->rb_right == node) {
+					print(")");
+					node = parent;
+					parent = rb_parent(node);
+				}
+
+				if (parent->rb_right == node)
+					break;
+
+				print_parent;
+				node = parent->rb_right;
+				left = false;
+			}
+		} else {
+			if (parent)
+				print("(");
+
+			print("Node ");
+			parent = node;
+			node = node->rb_left;
+			left = true;
+		}
+
+	}
+	print("\n");
+	return 0;
+}
+
+static int key_cmp(const void *_a, const struct rb_node *_b)
+{
+	u64 a = *(typeof(a) *) _a;
+	u64 b = data_from_node(_b)->key;
+	if (a < b)
+		return -1;
+	if (a > b)
+		return 1;
+	else
+		return 0;
+}
+
+static int node_cmp(struct rb_node *a, const struct rb_node *b)
+{
+	return key_cmp(&data_from_node(a)->key, b);
+}
+
+ssize_t cmd_exec(struct file *file, const char __user *ubuf, size_t len, loff_t *offp)
+{
+	int cmd;
+	struct data *data, *_n;
+	struct rb_node *node;
+	int ret = kstrtoint_from_user(ubuf, len, 10, &cmd);
+	if (ret)
+		return ret;
+
+	switch (cmd) {
+	case RESET:
+		rbtree_postorder_for_each_entry_safe(data, _n, &rbt, node)
+			kfree(data);
+		rbt = RB_ROOT;
+		break;
+	case INSERT:
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		data->key = input_key;
+		rb_find_add(&data->node, &rbt, node_cmp);
+		break;
+	case DELETE:
+		node = rb_find(&input_key, &rbt, key_cmp);
+		if (!node)
+			break;
+		rb_erase(node, &rbt);
+		kfree(data_from_node(node));
+		break;
+	default:
+		return -EINVAL;
+	}
+	return len;
+}
+
+static int cmd_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cmd_show, inode->i_private);
+}
+
+static const struct file_operations cmd_fops = {
+	.owner		= THIS_MODULE,
+	.open		= cmd_open,
+	.read		= seq_read,
+	.write		= cmd_exec,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+int __init rbt_if_init(void)
+{
+	rbt_if_root = debugfs_create_dir("rbt_if", NULL);
+	if (IS_ERR(rbt_if_root))
+		return PTR_ERR(rbt_if_root);
+
+	debugfs_create_file("cmd", 0644, rbt_if_root, NULL, &cmd_fops);
+	debugfs_create_u64("key", 0644, rbt_if_root, &input_key);
+	return 0;
+}
+
+void __exit rbt_if_exit(void)
+{
+	struct data *_n, *pos;
+	debugfs_remove_recursive(rbt_if_root);
+	rbtree_postorder_for_each_entry_safe(pos, _n, &rbt, node)
+		kfree(pos);
+
+}
+
+module_init(rbt_if_init);
+module_exit(rbt_if_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mete Polat <metepolat2000@gmail.com>");
-- 
2.33.1

