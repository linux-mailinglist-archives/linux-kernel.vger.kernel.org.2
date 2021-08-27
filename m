Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28443F9241
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 04:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbhH0CQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 22:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241128AbhH0CQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 22:16:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF32860C3E;
        Fri, 27 Aug 2021 02:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630030569;
        bh=QblDK89r69AlgT4tCSWh91kQaXFt7iKvNWN+q4Nf/W8=;
        h=From:To:Cc:Subject:Date:From;
        b=fnsSUO+LD6nJ95NShA/TFLUgJY6Lh8mn2R+skmpxAKYfqgap5b/s0CDurVlqBpBBi
         iz45Z2BH34ev+QUl7s9BfgGNlkRwCdiurp2PAHKqgXCKb3824mGp8iqxsRTNuGhBVi
         eMIO2mLS+bCKFAJPBDcPmOG5WokNqmrq18CT0QigMADHnAcRYPA9Aztli+7LzLw3fv
         4NDdKZYvOLUA/sTSUg0HOkF4PpLV2Xn9UrAr0+TORlz92ckWMzK0a2P3897QgOl9Hs
         Ti/Iz2KOuxUFW7LJm9ezTtDkhJuZLt25rXN1RZ75captxFwtGfr7l234Uh5SfOS7rD
         sprUxF2AhpLgQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] bootconfig: Cleanup and reorder the init parameter from bootconfig
Date:   Fri, 27 Aug 2021 11:16:07 +0900
Message-Id: <163003056713.284890.5878333391812608469.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 2nd version of the patches to update the bootconfig.
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

Changes in v2:
 - introduce exit_boot_config() wrapper for !CONFIG_BOOT_CONFIG.

Thank you,

---

Masami Hiramatsu (3):
      init: bootconfig: Remove all bootconfig data when the init memory is removed
      init/bootconfig: Reorder init parameter from bootconfig and cmdline
      docs: bootconfig: Add how to use bootconfig for kernel parameters


 Documentation/admin-guide/bootconfig.rst |   39 +++++++++++++++++++++++++++++-
 init/main.c                              |   37 ++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 12 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
