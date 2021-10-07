Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203A9425E78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhJGVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhJGVQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:16:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F037C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 14:14:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so9671072yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QYGKxotwOcPsXmj43VBoU9pQOLFuT2uLTis5fRvj88s=;
        b=fmXA3WlKA9IYiKNbasInmYKjaJDAYFxX9c/RV7umEiDNCkbwCK05JjD5ASiwR6AqR5
         QJxPX5W1JGFbUmlT2zyWDebPrZrLFbDartfJwvSNbI5wN4+GYcj4hUFQrJ0zKAFdGEl7
         XVdEUUsNRLetemOWYMObcXhQmSXLyKcGIpyfgkwnRIhcT7cdEF1oGXksXeIuYcAO1fMA
         EvdvTdJc7eMl3ofHCXdwJUFm+uXt3nwzEXZMgnG3rJU5K7AVd7hOE3DcNbrPWMpgZK7L
         3z/Vinf+I7MDy7snZc5FdMwXb+ILHgg2fQsxOLa8eNMmZSOMCOaXR13jfERIPF7kw7WH
         8utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QYGKxotwOcPsXmj43VBoU9pQOLFuT2uLTis5fRvj88s=;
        b=pGdHTXQqkQjYud6E/zGbHSJxmmUnnEz+UufwUQFEWl77Jav1w/MnK0grxWsqAtER/y
         KNlJFoymBxaB9enNCP415CGlIhv3PC9fFeOZWd2Rjiv9+SjysV7D9ccQXPMlFHRbCuwg
         DEuP2L95uVIPwebBeexvd+irSITH55ApNzfqjLdtUwrFOj6UDRKGmpyBEFMLsROvSpEy
         Nxh6B9YRcvNvT8E+2RkVtZQaCgMmw7ZHuqdAONW6w4ATMMm1xZqp2xdRYcrK5Ex3R4Sl
         sFVGXvdb5jgsn8CxD9mJYtV1NnaMbUqF6tbL+XuQZgGSZfIIKrqGt00qo96CSV8LBYM3
         awgw==
X-Gm-Message-State: AOAM531xFuv+FWqSl0RzgVN0Y8iJez60DC5c292vho44HZSXrCAKDQHP
        a2gpL6cFm+gDQYo61FSdtNRFjbaU5DABWg==
X-Google-Smtp-Source: ABdhPJyYeXvyhKMpNjfCqT4Dg6TOKoEu+S1T6ztqUBnX7ipEbVB+fVtb3ck49GfPfZ9ZT9CkbSzIn/+pBjbBSQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e436:7947:9f25:884c])
 (user=dlatypov job=sendgmr) by 2002:a25:1845:: with SMTP id
 66mr7248914yby.396.1633641270158; Thu, 07 Oct 2021 14:14:30 -0700 (PDT)
Date:   Thu,  7 Oct 2021 14:14:17 -0700
Message-Id: <20211007211417.728268-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2] kunit: tool: print parsed test results fully incrementally
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the parser rework [1] and run_kernel() rework [2], this allows the
parser to print out test results incrementally.

Currently, that's held up by the fact that the LineStream eagerly
pre-fetches the next line when you call pop().
This blocks parse_test_result() from returning until the line *after*
the "ok 1 - test name" line is also printed.

One can see this with the following example:
$ (echo -e 'TAP version 14\n1..3\nok 1 - fake test'; sleep 2; echo -e 'ok 2 - fake test 2'; sleep 3; echo -e 'ok 3 - fake test 3') | ./tools/testing/kunit/kunit.py parse

Before this patch [1]: there's a pause before 'fake test' is printed.
After this patch: 'fake test' is printed out immediately.

This patch also adds
* a unit test to verify LineStream's behavior directly
* a test case to ensure that it's lazily calling the generator
* an explicit exception for when users go beyond EOF

[1] https://lore.kernel.org/linux-kselftest/20211006170049.106852-1-dlatypov@google.com/
[2] https://lore.kernel.org/linux-kselftest/20211005011340.2826268-1-dlatypov@google.com/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: rebase onto v7 of parser rewrite
https://lore.kernel.org/all/20211007210324.707912-1-dlatypov@google.com/
---
 tools/testing/kunit/kunit_parser.py    | 22 ++++++++++----
 tools/testing/kunit/kunit_tool_test.py | 42 +++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index f01fd565f978..82900a5f9ad6 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -172,42 +172,51 @@ class TestCounts:
 class LineStream:
 	"""
 	A class to represent the lines of kernel output.
-	Provides a peek()/pop() interface over an iterator of
+	Provides a lazy peek()/pop() interface over an iterator of
 	(line#, text).
 	"""
 	_lines: Iterator[Tuple[int, str]]
 	_next: Tuple[int, str]
+	_need_next: bool
 	_done: bool
 
 	def __init__(self, lines: Iterator[Tuple[int, str]]):
 		"""Creates a new LineStream that wraps the given iterator."""
 		self._lines = lines
 		self._done = False
+		self._need_next = True
 		self._next = (0, '')
-		self._get_next()
 
 	def _get_next(self) -> None:
-		"""Advances the LineSteam to the next line."""
+		"""Advances the LineSteam to the next line, if necessary."""
+		if not self._need_next:
+			return
 		try:
 			self._next = next(self._lines)
 		except StopIteration:
 			self._done = True
+		finally:
+			self._need_next = False
 
 	def peek(self) -> str:
 		"""Returns the current line, without advancing the LineStream.
 		"""
+		self._get_next()
 		return self._next[1]
 
 	def pop(self) -> str:
 		"""Returns the current line and advances the LineStream to
 		the next line.
 		"""
-		n = self._next
-		self._get_next()
-		return n[1]
+		s = self.peek()
+		if self._done:
+			raise ValueError(f'LineStream: going past EOF, last line was {s}')
+		self._need_next = True
+		return s
 
 	def __bool__(self) -> bool:
 		"""Returns True if stream has more lines."""
+		self._get_next()
 		return not self._done
 
 	# Only used by kunit_tool_test.py.
@@ -220,6 +229,7 @@ class LineStream:
 
 	def line_number(self) -> int:
 		"""Returns the line number of the current line."""
+		self._get_next()
 		return self._next[0]
 
 # Parsing helper methods:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 6648de1f9ceb..77e61b0a40e8 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -13,9 +13,10 @@ import tempfile, shutil # Handling test_tmpdir
 
 import itertools
 import json
+import os
 import signal
 import subprocess
-import os
+from typing import Iterable
 
 import kunit_config
 import kunit_parser
@@ -319,6 +320,45 @@ class KUnitParserTest(unittest.TestCase):
 				result.status)
 			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
+def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
+	return kunit_parser.LineStream(enumerate(strs, start=1))
+
+class LineStreamTest(unittest.TestCase):
+
+	def test_basic(self):
+		stream = line_stream_from_strs(['hello', 'world'])
+
+		self.assertTrue(stream, msg='Should be more input')
+		self.assertEqual(stream.line_number(), 1)
+		self.assertEqual(stream.peek(), 'hello')
+		self.assertEqual(stream.pop(), 'hello')
+
+		self.assertTrue(stream, msg='Should be more input')
+		self.assertEqual(stream.line_number(), 2)
+		self.assertEqual(stream.peek(), 'world')
+		self.assertEqual(stream.pop(), 'world')
+
+		self.assertFalse(stream, msg='Should be no more input')
+		with self.assertRaisesRegex(ValueError, 'LineStream: going past EOF'):
+			stream.pop()
+
+	def test_is_lazy(self):
+		called_times = 0
+		def generator():
+			nonlocal called_times
+			for i in range(1,5):
+				called_times += 1
+				yield called_times, str(called_times)
+
+		stream = kunit_parser.LineStream(generator())
+		self.assertEqual(called_times, 0)
+
+		self.assertEqual(stream.pop(), '1')
+		self.assertEqual(called_times, 1)
+
+		self.assertEqual(stream.pop(), '2')
+		self.assertEqual(called_times, 2)
+
 class LinuxSourceTreeTest(unittest.TestCase):
 
 	def setUp(self):

base-commit: e3c6457b588d83b7ecd40eb4bd6d95007020fbe4
-- 
2.33.0.882.g93a45727a2-goog

