Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4D319348
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBKTny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhBKTnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:43:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BBFF64E42;
        Thu, 11 Feb 2021 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613072591;
        bh=HYQW80z4K0noHv5L7r9hyhC3nj8nYE9aI2nuZrWMx9k=;
        h=From:To:Cc:Subject:Date:From;
        b=u2mlhBNozwgDVQ1DKrn0/lKFUJaN9SJB1msd4qMtS3xvOixybCmlwGL1U9GHNcSwG
         86kT75BC15GPRgdiaLBWii2jEh90BYcZxEjpP6mlCwu1IyTgDI6xtPmso1/APxEYrZ
         zFkjIK9hgAkIEaVYAaZIzzq4bqP3mjqGyqvYtVdWzhCQsw9yYdZL8WAJHrn5AlTOE/
         wl+S8L2P5VtVgk1HyF+baTo6hLG7qy3/53le1Ouia71O4yOclmlJZ0K7QiDe4Wzfwx
         Ln2ztLodkFRJi6LybVtUs9BvOW/mlWXVX2hKbVjhJ4/riqKmrVj8NVwNBu/JIbyNbV
         DkPJb5q18xRTg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
Date:   Thu, 11 Feb 2021 12:42:58 -0700
Message-Id: <20210211194258.4137998-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
which violates clang's CFI checking because fw_cfg_showrev()'s second
parameter is 'struct attribute', whereas the ->show() member of 'struct
kobj_structure' expects the second parameter to be of type 'struct
kobj_attribute'.

$ cat /sys/firmware/qemu_fw_cfg/rev
3

$ dmesg | grep "CFI failure"
[   26.016832] CFI failure (target: fw_cfg_showrev+0x0/0x8):

Fix this by converting fw_cfg_rev_attr to 'struct kobj_attribute' where
this would have been caught automatically by the incompatible pointer
types compiler warning. Update fw_cfg_showrev() accordingly.

Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")
Link: https://github.com/ClangBuiltLinux/linux/issues/1299
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/firmware/qemu_fw_cfg.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 0078260fbabe..172c751a4f6c 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -299,15 +299,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
+static ssize_t fw_cfg_showrev(struct kobject *k, struct kobj_attribute *a,
+			      char *buf)
 {
 	return sprintf(buf, "%u\n", fw_cfg_rev);
 }
 
-static const struct {
-	struct attribute attr;
-	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
-} fw_cfg_rev_attr = {
+static const struct kobj_attribute fw_cfg_rev_attr = {
 	.attr = { .name = "rev", .mode = S_IRUSR },
 	.show = fw_cfg_showrev,
 };

base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
-- 
2.30.1

