Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03323436F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhJVAwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhJVAwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:52:01 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB111C06122B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:49:43 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id l19-20020a637c53000000b00299c1f17664so972753pgn.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ELleBJgGwd/QzlGLrknppvVil5Df13DleDON559nDrY=;
        b=IoVN2OtLceo85xGHpYlOtSbnTqhQEov8YUUsGUGUUQcJR3uvnRKyFymzC5zQE6Q9wY
         fESNS3YGhZTjODvBZJH7FEh1UM3u/64KtnW12fYf6OMS+InBinUMSHXG0SnXJkDUGCLE
         DIf9OxfHfZLAaoaHM4dOGZGGfIq8+rPBNwFIVxKjMXbzzfp/2bDWfb3eSnRj7F4NGmL6
         sP8R5YORwBcnyUFdhufCqF3ne2mmMJuvWWcEE7DP7h7vHrVEx4eMJcOgpLu6DnO8sS26
         CkH3g+CksBznJ1BUhl2U2UNRR33FnBIiveTsKZsac7nQpLYFxbu/Odl0U8wR9uy4cZZJ
         fdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ELleBJgGwd/QzlGLrknppvVil5Df13DleDON559nDrY=;
        b=Kj6Ijj0UJy45S9xIgyYZ9l7rB2vyEJhikUzXm64u11fVyE6pcb74w+P/QfEbueZV69
         aqXMgrLcpGbxTtXtnhIgcB6yL+udboRhyWOGxpe6OkDqkQDS843NNpKLvU4xToenDzpR
         b/hjPTLi/0iCDIVESiHlLlXz22Uh8s+M8aaTGz/5Mcp+le4eV4XrpZfSq8voOs8heCaG
         HXcJ7G+6jjnSC8FVcsHhnNr9JUTN5lUPwcLWzY1BWREO2Z42kYeYk8bCdGnl7dq4y8bq
         Qz8bEXMPtGILbYaMvn60kAKV/ghhiZ7dDe7iNYAl5sZwbBwDV83Weltb9lxG5keBhSQW
         D6lA==
X-Gm-Message-State: AOAM533TBJ4SPhPq8E+u8TUo/XE9yYc/DcPx2ba6xniT1iNonH1xY3f+
        8fSTdHVJ2wJwN3PrDZR9RgXtwmA2FbD3OQ==
X-Google-Smtp-Source: ABdhPJzWzGuS4vQQDor/WyDaZiAHJC2EJwl3LxtD+DmsMSU5NaDzc9WABU36vm8ybBROQtkU6EtXegEMoKqqTw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5dea:949e:25ba:bd8b])
 (user=dlatypov job=sendgmr) by 2002:a63:cd09:: with SMTP id
 i9mr7015432pgg.129.1634863783114; Thu, 21 Oct 2021 17:49:43 -0700 (PDT)
Date:   Thu, 21 Oct 2021 17:49:36 -0700
Message-Id: <20211022004936.2049804-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH] kunit: tool: fix typecheck errors about loading qemu configs
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we have these errors:
$ mypy ./tools/testing/kunit/*.py
tools/testing/kunit/kunit_kernel.py:213: error: Item "_Loader" of "Optional[_Loader]" has no attribute "exec_module"
tools/testing/kunit/kunit_kernel.py:213: error: Item "None" of "Optional[_Loader]" has no attribute "exec_module"
tools/testing/kunit/kunit_kernel.py:214: error: Module has no attribute "QEMU_ARCH"
tools/testing/kunit/kunit_kernel.py:215: error: Module has no attribute "QEMU_ARCH"

exec_module
===========

pytype currently reports no errors, but that's because there's a comment
disabling it on 213.

This is due to https://github.com/python/typeshed/pull/2626.
The fix is to assert the loaded module implements the ABC
(abstract base class) we want which has exec_module support.

QEMU_ARCH
=========

pytype is fine with this, but mypy is not:
https://github.com/python/mypy/issues/5059

Add a check that the loaded module does indeed have QEMU_ARCH.
Note: this is not enough to appease mypy, so we also add a comment to
squash the warning.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index faa6320e900e..c68b17905481 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -207,12 +207,15 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
 	module_path = '.' + os.path.join(os.path.basename(QEMU_CONFIGS_DIR), os.path.basename(config_path))
 	spec = importlib.util.spec_from_file_location(module_path, config_path)
 	config = importlib.util.module_from_spec(spec)
-	# TODO(brendanhiggins@google.com): I looked this up and apparently other
-	# Python projects have noted that pytype complains that "No attribute
-	# 'exec_module' on _importlib_modulespec._Loader". Disabling for now.
-	spec.loader.exec_module(config) # pytype: disable=attribute-error
-	return config.QEMU_ARCH.linux_arch, LinuxSourceTreeOperationsQemu(
-			config.QEMU_ARCH, cross_compile=cross_compile)
+	# See https://github.com/python/typeshed/pull/2626 for context.
+	assert isinstance(spec.loader, importlib.abc.Loader)
+	spec.loader.exec_module(config)
+
+	if not hasattr(config, 'QEMU_ARCH'):
+		raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
+	params: qemu_config.QemuArchParams = config.QEMU_ARCH  # type: ignore
+	return params.linux_arch, LinuxSourceTreeOperationsQemu(
+			params, cross_compile=cross_compile)
 
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""

base-commit: 17ac23eb43f0cbefc8bfce44ad51a9f065895f9f
-- 
2.33.0.1079.g6e70778dc9-goog

