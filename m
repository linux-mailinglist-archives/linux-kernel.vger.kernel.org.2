Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56A036D7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhD1M7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235630AbhD1M7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:59:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 178636141B;
        Wed, 28 Apr 2021 12:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619614728;
        bh=DI2qfz1qyfUTp90qn7RPYRF92PMfG9NKVtm2bLmBgFE=;
        h=Date:From:To:Cc:Subject:From;
        b=UqHQcXwvBE8u0NmQMyV3MhYzhal5tCPaOaySj0PULuuV5pO9kwTJfbXb/gAtRQb4t
         ozXF9ld8ud/GsJWcy2d1hpvxPC6w74VlAfTW9ZEPJHHiQwxDCwjwYv5R/tdjgsqCEY
         K91kn9MknCJ0peLqJl1o9EUR/s5v6QC1telYzfigZAiGjlsAFlVvZbVoD+23fneUoq
         +MLI0xWANEKIV1j7y5sBaoWlgFclifz7Vh7EPhvDp17QAAh3snQgN9Ujj99DAVc465
         yaAC6RVAVHEwdwowDuc8iGT3Qdg+6ut7UPQn4KesXfU+je6d3+Xz5/AVeT6mkaxwqT
         xNwlc/m1vLWrA==
Date:   Wed, 28 Apr 2021 14:58:44 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.13
Message-ID: <YIlcBHhuR9LvKZ7q@gunter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux gunter 5.11.12-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the v5.13 merge window.
A summary can be found in the signed tag.

Thank you,

Jessica

--
The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

   Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.13

for you to fetch changes up to 33121347fb1c359bd6e3e680b9f2c6ced5734a81:

   module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD (2021-03-29 13:08:53 +0200)

----------------------------------------------------------------
Modules updates for v5.13

Summary of modules changes for the 5.13 merge window:

- Fix an age old bug involving jump_calls and static_labels when
   CONFIG_MODULE_UNLOAD=n. When CONFIG_MODULE_UNLOAD=n, it means you
   can't unload modules, so normally the __exit sections of a module are
   not loaded at all. However, dynamic code patching (jump_label,
   static_call, alternatives) can have sites in __exit sections even if
   __exit is never executed.

   Reported by Peter Zijlstra: "Alternatives, jump_labels and static_call
   all can have relocations into __exit code.  Not loading it at all would
   be BAD." Therefore, load the __exit sections even when
   CONFIG_MODULE_UNLOAD=n, and discard them after init.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jessica Yu (1):
       module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD

  kernel/module.c | 9 ++++-----
  1 file changed, 4 insertions(+), 5 deletions(-)
