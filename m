Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35BD3983F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhFBIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhFBIU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61CB8613AC;
        Wed,  2 Jun 2021 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622621924;
        bh=3Zg/l4qDreSFie/dAbOt177GD4Aph6mxpyB76fhG6aI=;
        h=From:To:Cc:Subject:Date:From;
        b=mUt4vlhxG3PrIxvwQqZNAXqjmKwcdrvdAOhYMeail2zrL+iYkPJgd1PB2aAzaPUs4
         WNnRYiEE4MtJlybf03PTleidHSx5nXVgfEcONlGoFWpAh6SK3MHaAI0bWXHWl3MYrM
         IGwyyDWw36LjiJeTg8RE0n3mIJi6v2Zp/Z88mgOysSGMGlNqN5VlYZz25FkcS2ClRS
         4fuW1ScGnmE1W47aV+4dHEwh8MTgXO9MbaooETCq96TSyLqbizior3Bk6tuIDXa2VB
         XaI04hGiHDO10LsClgbdC2+oVUoUpgXEmyailxR+hK9IzQooewvDxKJA4ky55dSUSE
         N/9WNpUPkSLGg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v4 0/6] bootconfig: Add mixed subkeys and value under the same key
Date:   Wed,  2 Jun 2021 17:18:41 +0900
Message-Id: <162262192121.264090.6540508908529705156.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 4th version of the series which updates bootconfig to
support mixed subkeys and a value under the same key.
The 3rd version is completely wrong. I missed to picked up the older
(v1) patches to v3. So please ignore v3.

Since the kernel cmdline accepts options like 
"aaa.bbb=val1 aaa.bbb.ccc=val2", it is better that the bootconfig
also support it.

Here is the previous series (v2):
  https://lore.kernel.org/lkml/162157886618.78209.11141970623539574861.stgit@devnote2/

In this version, I rebased on top of the latest linus tree and
add the build error fix [1/6](*) and a cleanup patch [6/6].

(*) https://lore.kernel.org/lkml/162087519356.442660.11385099982318160180.stgit@devnote2/

Changes in v4
 [1/6]:
     - Added from separated thread. This is a fundamental fix.
 [6/6]:
     - New cleanup patch.


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

Masami Hiramatsu (6):
      tools/bootconfig: Fix a build error accroding to undefined fallthrough
      bootconfig: Change array value to use child node
      bootconfig: Support mixing a value and subkeys under a key
      tools/bootconfig: Support mixed value and subkey test cases
      docs: bootconfig: Update for mixing value and subkeys
      bootconfig: Share the checksum function with tools


 Documentation/admin-guide/bootconfig.rst           |   30 +++++++-
 fs/proc/bootconfig.c                               |    2 -
 include/linux/bootconfig.h                         |   58 ++++++++++++++-
 init/main.c                                        |   12 ---
 lib/bootconfig.c                                   |   76 +++++++++++++++-----
 tools/bootconfig/include/linux/bootconfig.h        |    4 +
 tools/bootconfig/main.c                            |   62 +++++++++++-----
 tools/bootconfig/samples/bad-mixed-kv1.bconf       |    3 -
 tools/bootconfig/samples/bad-mixed-kv2.bconf       |    3 -
 tools/bootconfig/samples/bad-override.bconf        |    3 -
 tools/bootconfig/samples/bad-override2.bconf       |    3 -
 tools/bootconfig/samples/good-mixed-append.bconf   |    4 +
 tools/bootconfig/samples/good-mixed-kv1.bconf      |    3 +
 tools/bootconfig/samples/good-mixed-kv2.bconf      |    3 +
 tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 ++
 tools/bootconfig/samples/good-mixed-override.bconf |    4 +
 16 files changed, 205 insertions(+), 71 deletions(-)
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
