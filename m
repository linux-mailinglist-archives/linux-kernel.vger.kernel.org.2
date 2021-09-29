Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB4F41CFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346894AbhI2X1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbhI2X1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:27:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC86FC061768
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:25:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so5604220yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3k/5/Q3FVmwGpvBlwOcSeIO10fDHqoiU1INzIKkbGck=;
        b=pyekV7dNkLHfcmd/KRNZyEpbmyCyLBiobS+q2fL0ZeZe9rvsOWfKuVu+sjI+iwE+PI
         AxvIrbxOweE3/UckGwwp6bXJyTV5+32MaZfGsmbq/SjMQ91PKfXmKrt+eFzLgp2fL1x0
         G1UKGN2eo93mzaAEK3PrymKslz7ayFLQRLSqPGvq/yv0Jw67CHqUoYfaBNzpKzo6Wxvb
         ZM3nWtOHFV/c1Xz5c0s7YHyPIng7ym2DjN8AbLfooZloJ1ByMBxpgqjKWYvo9VHkSDdT
         86LTqUojzoWw3kgRgP0v0IUiWMOd6AihM9rIp2kIob7O6c0gNIvhb1LKs8u3AUG9qiKF
         Vb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3k/5/Q3FVmwGpvBlwOcSeIO10fDHqoiU1INzIKkbGck=;
        b=8BkfpbMGKYY5e9pI0fKkpB4SYIZLNEkYmcP+mk317VRTeFDtdVh9R73Z783fliYKS8
         WhHgUdIfgRqy7CTX7K7H6XnUJ5+QR8bQ/vtHJ/sp3+uljU5lerQlcQKM3iK8IhktRrq3
         H31dJ7P5uCBsnfQnObRE9Hdh8HtuTpIIrRwPqiNi1e5UR/cH15fmoz9E4BgJtZOerAX0
         7T0QWsYIwC9adBJpDqydSpcymEG0/txyPVo6+NHUzvg3FtQvO60rd0xs94edLeZJDZhQ
         qfmIiVRa9qJizr4tJ5Sby2s/93A1AhYZ538C68jau5oJT93GDURGqTuoH/qoliEt/b5o
         R3jQ==
X-Gm-Message-State: AOAM530HV7Fh2MkAY1UUw5541JZz63aXCSWqhcIAAXMq5R61/Yco05hO
        ItHcDAsQN4r6RrANoSCNFnhA4h5p0kozQA==
X-Google-Smtp-Source: ABdhPJwz46ZXct29xbVnwPzD0zpZwmHFQwxPnnJTy8QLu8SC0Q38KtTNwOddxfaK8BpFdIOsovpHYXnzMsqyjA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e473:7cd7:9986:85b7])
 (user=dlatypov job=sendgmr) by 2002:a25:db91:: with SMTP id
 g139mr2883604ybf.391.1632957959133; Wed, 29 Sep 2021 16:25:59 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:25:34 -0700
Message-Id: <20210929232534.1433720-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH] kunit: tool: show list of valid --arch options when invalid
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider this attempt to run KUnit in QEMU:
$ ./tools/testing/kunit/kunit.py run --arch=x86

Before you'd get this error message:
kunit_kernel.ConfigError: x86 is not a valid arch

After:
kunit_kernel.ConfigError: x86 is not a valid arch, options are ['alpha', 'arm', 'arm64', 'i386', 'powerpc', 'riscv', 's390', 'sparc', 'x86_64']

This should make it a bit easier for people to notice when they make
typos, etc. Currently, one would have to dive into the python code to
figure out what the valid set is.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py    | 5 +++--
 tools/testing/kunit/kunit_tool_test.py | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 1870e75ff153..a6b3cee3f0d0 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -198,8 +198,9 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
 		return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
 	elif os.path.isfile(config_path):
 		return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
-	else:
-		raise ConfigError(arch + ' is not a valid arch')
+
+	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
+	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
 def get_source_tree_ops_from_qemu_config(config_path: str,
 					 cross_compile: Optional[str]) -> Tuple[
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index cad37a98e599..2ae72f04cbe0 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -289,6 +289,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				pass
 			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 
+	def test_invalid_arch(self):
+		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
+			kunit_kernel.LinuxSourceTree('', arch='invalid')
+
 	# TODO: add more test cases.
 
 

base-commit: 865a0a8025ee0b54d1cc74834c57197d184a441e
-- 
2.33.0.685.g46640cef36-goog

