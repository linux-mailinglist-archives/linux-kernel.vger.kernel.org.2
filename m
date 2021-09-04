Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF35400BF9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhIDPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhIDPzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A85E160E76;
        Sat,  4 Sep 2021 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630770844;
        bh=1Bd7tJ9fKZam3ksaFV7H1b063UOCtZvKw1Oxp/zzHJk=;
        h=From:To:Cc:Subject:Date:From;
        b=oxV7sy0fz8Mv9I0PiXMuVjw4R48LZpnKfVHnim9Ifp1XXLd8oQNZe38Dpie1HL2YH
         kHqyF0pHcQgeg7fahBSeTiHP/1vBvT9s3T5ttcoffv4FZa5OL3NN/87+yJMajBFG3y
         9itxe4P/UQqOFwVNT4an5PJEUl9PjaM6vh7cR+DRBHbWKInH3oO9r8d/Ti2DU2bNzY
         tBS6XMiqCfeZpkOAYhtPoUYnUqTRQ07fIUHlEdKU+g9nAw55mt/0Abj9lbuEmorFjH
         wWsoL2dhv4DjgSNzMw+8Y2aLrf2rTDnFNzivamV/7sBvagkJrpZv+zG/wCDeXYUxom
         lTPn6WNbX0/HQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] bootconfig: Cleanup and reorder the init parameter from bootconfig
Date:   Sun,  5 Sep 2021 00:54:01 +0900
Message-Id: <163077084169.222577.4459698040375322439.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Here is the 3rd version of the patches to update the bootconfig.
I added 3 patches to fix some issues. One issue is from Julio which
fixes a compilation error ([5/6]*). And the other 2 are fixing
ftrace2bconf script ([4/6]) and cleanup test script ([6/6]).

* https://lore.kernel.org/all/20210831033256.5973-1-jcfaracco@gmail.com/T/#u

The 1st one is for bootconfig memory cleanup when exiting init stage.
The 2nd one and 3rd one are for reordering the init parameters from
bootconfig.
Since the current kernel concatenate the kernel cmdline and the
bootconfig parameters as below.

[bootconfig kernel params][cmdline] -- [init cmdline][bootconfig init params]

This is bit odd because for the kernel parameters, user passed cmdline
can override the previous (bootconfig) one, but for the init cmdline,
bootconfig may override the parameter.
Thus, this series invert the order as the following.

[bootconfig kernel params][cmdline] -- [bootconfig init params][init cmdline]

The 3rd patch is adding how to use the bootconfig for passing kernel
and init parameters.

Thank you,

---

Julio Faracco (1):
      bootconfig: Fix missing return check of xbc_node_compose_key function

Masami Hiramatsu (5):
      init: bootconfig: Remove all bootconfig data when the init memory is removed
      init/bootconfig: Reorder init parameter from bootconfig and cmdline
      docs: bootconfig: Add how to use bootconfig for kernel parameters
      tools/bootconfig: Fix tracing_on option checking in ftrace2bconf.sh
      tools/bootconfig: Show whole test command for each test case


 Documentation/admin-guide/bootconfig.rst |   39 +++++++++++++++++++++++++++++-
 init/main.c                              |   37 ++++++++++++++++++++--------
 tools/bootconfig/main.c                  |    4 ++-
 tools/bootconfig/scripts/ftrace2bconf.sh |    4 ++-
 tools/bootconfig/test-bootconfig.sh      |    4 ++-
 5 files changed, 71 insertions(+), 17 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
