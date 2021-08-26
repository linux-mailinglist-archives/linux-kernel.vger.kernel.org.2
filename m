Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593FE3F8432
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhHZJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240568AbhHZJMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:12:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29320610A1;
        Thu, 26 Aug 2021 09:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629969121;
        bh=l9So5wsR4pDo9hK+2y8xILinP5ARijmJOSzefyvKjDA=;
        h=From:To:Cc:Subject:Date:From;
        b=fb/Bmq74Wdv+Kg5CkaVcUS6ahMMiobf23S59yfNHXUUJZphMge1h4kXWAFtAMWWtG
         cQAiz+29FLxverTpwPvW91xf1be6f8ta04eaKzLF9uLT9yBj/dftR0V3HJizD6dHsu
         6PyS0tXLZCMSmUE085As8tRnvuHDLSnAd3fioRoaCxi0SBweTDjlwtgen+0W+Sb8IL
         wMwge+570T2IqaKGjEng+zVS1VaqiHILUTpycoyrryGkpnLMGGiHPgeVbzavv2Ei66
         NZCzs4/F0oHC/lYM3NkFWmv7X/Ok4B6w7Wh9tLnbMDKvytpin5pT67DHN7vnLBQar0
         3qxYYPy07Xyaw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] bootconfig: Cleanup and reorder the init parameter from bootconfig
Date:   Thu, 26 Aug 2021 18:11:59 +0900
Message-Id: <162996911932.236535.7533708592332223449.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some patches to update the bootconfig. The 1st one is for
bootconfig memory cleanup when exiting init stage. The 2nd one and
3rd one are for reordering the init parameters from bootconfig.
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

Masami Hiramatsu (3):
      init: bootconfig: Remove all bootconfig data when the init memory is removed
      init/bootconfig: Reorder init parameter from bootconfig and cmdline
      docs: bootconfig: Add how to use bootconfig for kernel parameters


 Documentation/admin-guide/bootconfig.rst |   39 +++++++++++++++++++++++++++++-
 init/main.c                              |   24 ++++++++++++------
 2 files changed, 53 insertions(+), 10 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
