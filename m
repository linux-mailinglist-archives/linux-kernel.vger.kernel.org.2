Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE553749F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhEEVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:11:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:35031 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbhEEVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:11:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620249018; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=ljqGh4vdZ4x6txKvkOy9TSMun4WY4aIky27Q4tklUF4=; b=BSckRQp6dQmX8tD83uSwpnCRm1PmQU4BbBPmBbbi59u+G5PAv3m9NfsoONxkgC/3ObQ7vt8Z
 7Z14nZKMSwb5oWxCorMJ+zh/bUA2bgaULKDDjhs6ZRhbfvuPNiBooMb8ssF4IgmbyRjVZvNH
 XAA576YhzLnMvvhbaZcad55EceU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 609309a8c39407c327b1eb6d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 May 2021 21:10:00
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08772C4323A; Wed,  5 May 2021 21:10:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F077C433F1;
        Wed,  5 May 2021 21:09:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 May 2021 16:09:59 -0500
From:   bcain@codeaurora.org
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     sidneym@codeaurora.org,
        'clang-built-linux' <clang-built-linux@googlegroups.com>
Subject: [GIT PULL] hexagon changes for v5.13
Message-ID: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
X-Sender: bcain@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following changes for Hexagon: they contain build fixes.

Thanks,
-Brian

===


The following changes since commit 
9ccce092fc64d19504fa54de4fd659e279cc92e7:

   Merge tag 'for-linus-5.13-ofs-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux (2021-05-02 
14:13:46 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux 
tags/hexagon-5.13-0

for you to fetch changes up to f1f99adf05f2138ff2646d756d4674e302e8d02d:

   Hexagon: add target builtins to kernel (2021-05-03 11:04:22 -0500)

----------------------------------------------------------------
Hexagon architecture build fixes + builtins

Small build fixes applied:
- use -mlong-calls to build
- extend jumps in futex_atomic_*
- etc

Also, for convenience and portability, the hexagon compiler builtin
functions like memcpy etc have been added to the kernel -- following the
idiom used by other architectures.

----------------------------------------------------------------
Sid Manning (4):
       Hexagon: fix build errors
       Hexagon: change jumps to must-extend in futex_atomic_*
       Hexagon: remove DEBUG from comet config
       Hexagon: add target builtins to kernel

  arch/hexagon/Makefile                    |  6 +--
  arch/hexagon/configs/comet_defconfig     |  1 -
  arch/hexagon/include/asm/futex.h         |  4 +-
  arch/hexagon/include/asm/timex.h         |  3 +-
  arch/hexagon/kernel/hexagon_ksyms.c      |  8 ++--
  arch/hexagon/kernel/ptrace.c             |  4 +-
  arch/hexagon/lib/Makefile                |  3 +-
  arch/hexagon/lib/divsi3.S                | 67 
++++++++++++++++++++++++++++++++
  arch/hexagon/lib/memcpy_likely_aligned.S | 56 
++++++++++++++++++++++++++
  arch/hexagon/lib/modsi3.S                | 46 ++++++++++++++++++++++
  arch/hexagon/lib/udivsi3.S               | 38 ++++++++++++++++++
  arch/hexagon/lib/umodsi3.S               | 36 +++++++++++++++++
  12 files changed, 258 insertions(+), 14 deletions(-)
  create mode 100644 arch/hexagon/lib/divsi3.S
  create mode 100644 arch/hexagon/lib/memcpy_likely_aligned.S
  create mode 100644 arch/hexagon/lib/modsi3.S
  create mode 100644 arch/hexagon/lib/udivsi3.S
  create mode 100644 arch/hexagon/lib/umodsi3.S


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
