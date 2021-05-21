Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27D738C2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhEUJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234120AbhEUJQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:16:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C0FA613AE;
        Fri, 21 May 2021 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621588514;
        bh=thBDHLQvLxMNDS7+U5fqdHxUd6pYMHDOuezM7BDuv1E=;
        h=Date:From:To:Cc:Subject:From;
        b=CGLCDq5jfyGv9YqYeENx/86iaJq0GUiXphV6lkaEgQYQb5jQgccwiGic4ZHVK7G6e
         EmsNqJ1E9ipXF0D6Qjz2nQFQQ8JND21+Lq0mM3U2QWtcnkwkCg8VcwJtRcFn4C8Joh
         f4L0w8AYnhC/BxCMROSzVYfDFxkyUs2dePoGv5k9+n6q0DZClWwOE2RAnu1c4dtDho
         o5JFdMA29bff/f34piMFwG0ezK8kSQ0gikZBqsYIDgxPcb0/CVufuZ67xBzJjjIsRI
         geWlawSaspouCrhSA53vqmDOdmfBMWPD4ls8vzdQZahopKZ3J1WhbrsA242YGGZ5Y2
         4+r0UrZD7be1g==
Date:   Fri, 21 May 2021 11:15:09 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules fixes for v5.13-rc3
Message-ID: <YKd6HcDP7aP0s366@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull for a single modules fix for commit 33121347fb1c ("module:
treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD").
Details can be found in the signed tag below.

Thanks,

Jessica

---
The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.13-rc3

for you to fetch changes up to 055f23b74b20f2824ce33047b4cf2e2aa856bf3b:

   module: check for exit sections in layout_sections() instead of module_init_section() (2021-05-17 09:48:24 +0200)

----------------------------------------------------------------
Modules fixes for v5.13-rc3

- When CONFIG_MODULE_UNLOAD=n, module exit sections get sorted into the
   init region of the module in order to satisfy the requirements of
   jump_labels and static_calls. Previously, the exit section check was
   done in module_init_section(), but the solution there is not completely
   arch-indepedent as ARM is a special case and supplies its own
   module_init_section() function. Instead of pushing this logic further to
   the arch-specific code, switch to an arch-independent solution to check
   for module exit sections in the core module loader code in
   layout_sections() instead.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jessica Yu (1):
       module: check for exit sections in layout_sections() instead of module_init_section()

  kernel/module.c | 17 +++++++++++------
  1 file changed, 11 insertions(+), 6 deletions(-)
