Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF36E322268
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhBVWxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhBVWxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:53:34 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65952C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:52:54 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f7so8894304pgp.19
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WCWa6LwM2bR7pmLc5+vjMwUQ7Td6/ol6HmkorD+Rs9E=;
        b=lDd76rRs/xcSBBfRk70gFbmfgQxT9We6bVeJPObs5IDgLOlnPbzKIFIM/1ZOsf0aq+
         WmPsPewXicb1MUkmTReT9/qGkuKCE6luXgSHW7iEKpAf62OLjNkjciRCDsmt92SULBEw
         ADEQc+NSwaqo194CKHIQuqgHc65keoQ6nhjn0pVAVXQzuLSbNH7EMK4sXlTEA4Q0Cp6B
         kZ+i6jYHuS74AQ1ZftWm4fMMnfp9B/ymM9NLFaiqlDJ7hCkJHLlaa6BGeiq7IlofQg4C
         Yt1VGSjTumokX/yM6XK/cStxXbO4IqsXMuIbwMUpx+EeR0H8V/wiISMSpUCeYyrWn3Rt
         kdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WCWa6LwM2bR7pmLc5+vjMwUQ7Td6/ol6HmkorD+Rs9E=;
        b=V4uxW0m+us3tcnwinNEvMx/Xa9Dg9TWFN3DTkcqyWXzDtUqdVQPw7vqiVGmAzoTDyD
         KtYW5BvlgXy8q2vaFhqxKq/wIVO5YGlYLyIYx+BvaCj96Lxz9/wai+Btr3wp6fdxnnpq
         dqJkjt3Ka+2QrWrKWwDnmw/ZWTYXHxwYnov+oBIqbspNOjXQTdrr9/P9PsJvWhjNOD8x
         GS1qA+RMOg81vveM/iAWAleGjXfSTm6WYTolL3Ryb5362NSiRJ2i5e741pTdXyEyOMn7
         2kYAFOwxHZCbpGSnoPFhMtUfIWE4qAHOBbJHeS1U1FAhJaAI2tZvJZ2ROOvqMCk8175e
         mmlw==
X-Gm-Message-State: AOAM532dyOsDSrZJaldrMI5IMIei6ZQsuZ0rmV/gR9zr7teCx1S5sE3E
        JY2ybiV7gexrO5mQQVNE1xLAxW/Z40a9Lw==
X-Google-Smtp-Source: ABdhPJwtHV6TBb9PF8vdxnwdg9i2ZEKDTAqAQRVyGEyJFdwR2yHkcqOSNcIG9NoO4tbOg7DEs6lhwUOXlxNwfQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1ce2:63d4:4764:e103])
 (user=dlatypov job=sendgmr) by 2002:a62:8f0c:0:b029:1ed:8c8d:6910 with SMTP
 id n12-20020a628f0c0000b02901ed8c8d6910mr9773014pfd.31.1614034373814; Mon, 22
 Feb 2021 14:52:53 -0800 (PST)
Date:   Mon, 22 Feb 2021 14:52:41 -0800
Message-Id: <20210222225241.201145-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] kunit: tool: make --kunitconfig accept dirs, add lib/kunit fragment
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, tytso@mit.edu,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit

Per suggestion from Ted [1], we can reduce the amount of typing by
assuming a convention that these files are named '.kunitconfig'.

In the case of [1], we now have
$ ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4

Also add in such a fragment for kunit itself so we can give that as an
example more close to home (and thus less likely to be accidentally
broken).

[1] https://lore.kernel.org/linux-ext4/YCNF4yP1dB97zzwD@mit.edu/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/.kunitconfig                 | 3 +++
 tools/testing/kunit/kunit.py           | 4 +++-
 tools/testing/kunit/kunit_kernel.py    | 2 ++
 tools/testing/kunit/kunit_tool_test.py | 6 ++++++
 4 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 lib/kunit/.kunitconfig

diff --git a/lib/kunit/.kunitconfig b/lib/kunit/.kunitconfig
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/lib/kunit/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index d5144fcb03ac..5da8fb3762f9 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -184,7 +184,9 @@ def add_common_opts(parser) -> None:
 			    help='Run all KUnit tests through allyesconfig',
 			    action='store_true')
 	parser.add_argument('--kunitconfig',
-			     help='Path to Kconfig fragment that enables KUnit tests',
+			     help='Path to Kconfig fragment that enables KUnit tests.'
+			     ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
+			     'will get  automatically appended.',
 			     metavar='kunitconfig')
 
 def add_build_opts(parser) -> None:
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index f309a33256cd..89a7d4024e87 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -132,6 +132,8 @@ class LinuxSourceTree(object):
 			return
 
 		if kunitconfig_path:
+			if os.path.isdir(kunitconfig_path):
+				kunitconfig_path = os.path.join(kunitconfig_path, KUNITCONFIG_PATH)
 			if not os.path.exists(kunitconfig_path):
 				raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
 		else:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 1ad3049e9069..2e809dd956a7 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -251,6 +251,12 @@ class LinuxSourceTreeTest(unittest.TestCase):
 		with tempfile.NamedTemporaryFile('wt') as kunitconfig:
 			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
 
+	def test_dir_kunitconfig(self):
+		with tempfile.TemporaryDirectory('') as dir:
+			with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
+				pass
+			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
+
 	# TODO: add more test cases.
 
 

base-commit: b12b47249688915e987a9a2a393b522f86f6b7ab
-- 
2.30.0.617.g56c4b15f3c-goog

