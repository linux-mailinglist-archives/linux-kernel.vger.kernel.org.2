Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413C38BF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhEUGf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhEUGfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:35:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFA19613B6;
        Fri, 21 May 2021 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621578870;
        bh=NCIcldAJU5SPoXB3qjHHGO+/p/YmRV0uDMHFW4SCUBI=;
        h=From:To:Cc:Subject:Date:From;
        b=YhNZ6ElgVewsgwXr/DR8ULtDATTv0yFkgST/nC/vXRdudCZvbmikhCY3bBxYX4M1h
         8D9fm1kD2n4I2mBipe1JYdaRKiinxbHBQXX+tUg17WERFgjaJy7I8rVSjp20Va8ma9
         i22/wL/khgsF2lpD4mbGEUQbgFVanG7XN8Yh5axTzLR+Cqj1mv7RFsbC/+OQiTm4Te
         +tMafVaRE7Y52YaHfzWDI7D3jhNVZst+7OjqxaGWylCwgMPR09ekUvUlckwUrnzEkq
         7zZ4p5A+WGNiX8wTgmElvUOMhQ1LAN7EWmxcuVXYe8Kdy5kfidqJ9BoVDkPmwqd9/3
         HwlWgeY0w15xg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v2 0/4] bootconfig: Add mixed subkeys and value under the same key
Date:   Fri, 21 May 2021 15:34:26 +0900
Message-Id: <162157886618.78209.11141970623539574861.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of the series which updates bootconfig to
support mixed subkeys and a value under the same key.
Since the kernel cmdline accepts options like 
"aaa.bbb=val1 aaa.bbb.ccc=val2", it is better that the bootconfig
also support it.

In this version, I fixed [1/4] to show /proc/bootconfig correctly
and update the description.

Changes in v2
 [1/4]:
      - Fix /proc/bootconfig accroding to Devin's report (Thanks!)
      - Update patch description to explain why, not what.
      - Use xbc_node_is_array() instead of checking field directly.
 [4/4]:
      - Update an exmaple code.


This series depends on the below bugfix.

 https://lore.kernel.org/lkml/162087519356.442660.11385099982318160180.stgit@devnote2/

With this series, sub-keys and a value can co-exist under a parent key.
For example, following config is allowed.

 foo = value1
 foo.bar = value2

Note, since there is no syntax to put a raw value directly under a
structured key, you have to define it outside of the brace. For example,

 foo {
     bar = value1
     bar {
         baz = value2
         qux = value3
     }
 }

Also, the order of the value node under a key is fixed. If there
are a value and subkeys, the value is always the first child node
of the key. Thus if user specifies subkeys first, e.g.

 foo.bar = value1
 foo = value2

In the program (and /proc/bootconfig), it will be shown as below

 foo = value2
 foo.bar = value1


Thank you,

---

Masami Hiramatsu (4):
      bootconfig: Change array value to use child node
      bootconfig: Support mixing a value and subkeys under a key
      tools/bootconfig: Support mixed value and subkey test cases
      docs: bootconfig: Update for mixing value and subkeys


 Documentation/admin-guide/bootconfig.rst           |   30 +++++++-
 fs/proc/bootconfig.c                               |    2 -
 include/linux/bootconfig.h                         |   38 +++++++++-
 lib/bootconfig.c                                   |   76 +++++++++++++++-----
 tools/bootconfig/main.c                            |   47 ++++++++++--
 tools/bootconfig/samples/bad-mixed-kv1.bconf       |    3 -
 tools/bootconfig/samples/bad-mixed-kv2.bconf       |    3 -
 tools/bootconfig/samples/bad-override.bconf        |    3 -
 tools/bootconfig/samples/bad-override2.bconf       |    3 -
 tools/bootconfig/samples/good-mixed-append.bconf   |    4 +
 tools/bootconfig/samples/good-mixed-kv1.bconf      |    3 +
 tools/bootconfig/samples/good-mixed-kv2.bconf      |    3 +
 tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 ++
 tools/bootconfig/samples/good-mixed-override.bconf |    4 +
 14 files changed, 178 insertions(+), 47 deletions(-)
 delete mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
 delete mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf
 delete mode 100644 tools/bootconfig/samples/bad-override.bconf
 delete mode 100644 tools/bootconfig/samples/bad-override2.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-append.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-kv2.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-kv3.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-override.bconf

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
