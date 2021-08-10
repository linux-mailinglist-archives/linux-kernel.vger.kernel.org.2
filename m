Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2B73E8664
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhHJXV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235242AbhHJXVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:21:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E258460EE9;
        Tue, 10 Aug 2021 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628637691;
        bh=n8nRteX6xTvqDie1E7IAtuwWc0AX6awBcGo5w8xx/B0=;
        h=To:Cc:From:Subject:Date:From;
        b=K1djQ8vapHsMr7nIbo7PDEAt+O0ILzdESkqw+VG3LxJWm/jep3SXTHj90QikewbYT
         nzYBmNPtNwN3IpuXcl2DOry/XWUxqJGTCIlZZo0zaf7GaDJJDEJwLtW+7rrnZLjmxH
         Gc1KFz85ZeMIIEFEkFQGajM3ZBx46aPq1R5DIWxw62vD6VVxktBsXVNvBnLgv7gd9X
         Firb75zmzkObir47MREwLk5Pw1dMXKJL+855b13AvbVCYGywQl42Uo/+d0lIUySi8+
         8+qNBiOJzEtpe0O6r/sKdo7Zs8Y30//kZmvoSH2lygfOZ6Y22qyog32NSqKJS7980W
         VoEKwDZC9z48A==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jinchao Wang <wjc@cdjrlc.com>
From:   Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC updates for 5.14-rc6
Message-ID: <931efd74-4b45-fd24-8c88-97f57f97e01c@kernel.org>
Date:   Tue, 10 Aug 2021 16:21:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

ARC fixes for 5.14-rc6. Please pull.

Thx,
-Vineet

------------>
The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

   Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ 
tags/arc-5.14-rc6

for you to fetch changes up to 669d94219d91a2ba950bb12ece69cf0ada53ad4f:

   MAINTAINERS: update Vineet's email address (2021-08-09 15:17:14 -0700)

----------------------------------------------------------------
ARC updates for 5.14-rc6

  - Fix FPU_STATUS update

  - Update my email address

  - Other spellos and fixes

----------------------------------------------------------------
Colin Ian King (1):
       arc: Fix spelling mistake and grammar in Kconfig

Guenter Roeck (1):
       ARC: Fix CONFIG_STACKDEPOT

Jinchao Wang (1):
       arc: Prefer unsigned int to bare use of unsigned

Vineet Gupta (2):
       ARC: fp: set FPU_STATUS.FWE to enable FPU_STATUS update on 
context switch
       MAINTAINERS: update Vineet's email address

  MAINTAINERS                       |  2 +-
  arch/arc/Kconfig                  |  2 +-
  arch/arc/include/asm/checksum.h   |  2 +-
  arch/arc/include/asm/perf_event.h |  2 +-
  arch/arc/kernel/fpu.c             |  9 ++++++---
  arch/arc/kernel/unwind.c          | 10 +++++-----
  arch/arc/kernel/vmlinux.lds.S     |  2 ++
  7 files changed, 17 insertions(+), 12 deletions(-)
