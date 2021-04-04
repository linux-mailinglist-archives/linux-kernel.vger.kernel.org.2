Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D56353606
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 02:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhDDApL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 20:45:11 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40929 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236526AbhDDApK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 20:45:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E7B85C008D;
        Sat,  3 Apr 2021 20:45:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 03 Apr 2021 20:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=ool/2/xvmK9HUEwFoYH77h1/nN
        YxJyni5678WQavANY=; b=nikuzIJMmnF2cpB1ra831sJcfPBZrPCnZo90O2JWTg
        WsZYpnuLpInOzJgj6nnSqqgTMSkFmxEUzQLXBz7ybuxJD283+IhMXnGurxIBEvJA
        Ok+eB3xwANIdCK+qrVVh5B/M1PCMFKNdJf0jdBdOdcRuwBq8ddNv2nv2dIolCW25
        Fh0ii+044HxZ+cyIyu5ViUZoCYOh/5TC1X1bok1Zf1DKGfdqVefooMw5gciNRBRs
        WtF15dtjdw6XCSgZH2xTkR7oA5xHRS0lmI2UmGqomOLwWvmB0NVGYfhZh6JfXpgq
        EaD55UkqKYFuOhSAkkivUTIccimemvGCKs1H8ZM5Ot6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ool/2/xvmK9HUEwFo
        YH77h1/nNYxJyni5678WQavANY=; b=J6evn6rpMOxZUH6s8WH2y+G8YUeg/DZlA
        KesE3TCunxtPCjETui0JPlJ0IyLevSd2wfLqIKNNSqY67VRHLFqIH3LbNqIEFnBW
        VdTlYWQwqiIBiYkX6TXE16AogAlhDpHcGzN1z+mjPQd7ptVsWcpkGVVGv2InJPI7
        8OuaTXWcAIZrYFgHfn81UX4e/1HC05cROqwJNrbiAgnf6qFHu3aVaWO+aXU9VWp8
        J7ABPqXkiiT8zuSWmRra6X4xJTgwsIUqe5gSrxn/W9ew5XOYGLavX0CYJ8y1V8fd
        P+9COBK+o1LJv0t/t3zrlbZl0DuKQ1gsWOkoXjjh+JyA5j7wg00BA==
X-ME-Sender: <xms:EQxpYMJOsnZFEbt1dqkOrlA7uw3fyo5mIkvj3EJKBJq2TB2MzQ_3lA>
    <xme:EQxpYMXKzsfq6DY0OVY6nMKe10s9m-fUYTDgOt-sZtEekDv2kn13Ap-xdLAzQ0t57
    BoVubmborAnCGSd1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeiledggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:EQxpYOicr8gub4DEf4L2K9hWJedXTE_bWOTBcJxNjUi_XQg8zkYk4w>
    <xmx:EQxpYH-8ZPmJuxatkNX27f5QX3W2GGMnnz8QLbc5LTRtXFfscY_HWA>
    <xmx:EQxpYIBH6jWomCUEDDB4lCYPrzTLSyoMUucLtSc1Vlw4B1CX45I8pQ>
    <xmx:EgxpYL8hwqwkeAr4urrNkF_4C0qJL--oP-ghG6CuO4b4abetDrpRlg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6584E24005A;
        Sat,  3 Apr 2021 20:45:05 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arend van Spriel <arend@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH] debugfs: Fix use-after-free in debugfs_create_devm_seqfile()
Date:   Sat,  3 Apr 2021 19:45:04 -0500
Message-Id: <20210404004504.5547-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function uses devres to clean up its allocation, but it never removes the
file referencing that allocation. This causes a use-after-free and an oops if
the file is accessed after the owning device is removed.

Fixes: 98210b7f73f1d ("debugfs: add helper function to create device related seq_file")
Fixes: 0d519cbf38eed ("debugfs: remove return value of debugfs_create_devm_seqfile()")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 fs/debugfs/file.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 686e0ad28788..64f1f918e119 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1100,6 +1100,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_regset32);
 struct debugfs_devm_entry {
 	int (*read)(struct seq_file *seq, void *data);
 	struct device *dev;
+	struct dentry *dentry;
 };
 
 static int debugfs_devm_entry_open(struct inode *inode, struct file *f)
@@ -1117,6 +1118,13 @@ static const struct file_operations debugfs_devm_entry_ops = {
 	.llseek = seq_lseek
 };
 
+static void debugfs_devm_entry_release(struct device *dev, void *res)
+{
+	struct debugfs_devm_entry *entry = res;
+
+	debugfs_remove(entry->dentry);
+}
+
 /**
  * debugfs_create_devm_seqfile - create a debugfs file that is bound to device.
  *
@@ -1136,14 +1144,19 @@ void debugfs_create_devm_seqfile(struct device *dev, const char *name,
 	if (IS_ERR(parent))
 		return;
 
-	entry = devm_kzalloc(dev, sizeof(*entry), GFP_KERNEL);
+	entry = devres_alloc(debugfs_devm_entry_release, sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return;
 
 	entry->read = read_fn;
 	entry->dev = dev;
+	entry->dentry = debugfs_create_file(name, S_IRUGO, parent, entry,
+					    &debugfs_devm_entry_ops);
+	if (IS_ERR(entry->dentry)) {
+		devres_free(entry);
+		return;
+	}
 
-	debugfs_create_file(name, S_IRUGO, parent, entry,
-			    &debugfs_devm_entry_ops);
+	devres_add(dev, entry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_devm_seqfile);
-- 
2.26.2

