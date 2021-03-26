Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA65E349D24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCZACy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:02:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:15382 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhCZACo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:02:44 -0400
IronPort-SDR: 9VPZ8WMGxF5micnHezF1D0OweUgygtGcWW0AqrQZ16/4uU3qD7fVW1Na1Rl4Fy8pjv8ws1M5no
 dm7EgY2etMag==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="187748030"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="187748030"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:02:43 -0700
IronPort-SDR: gLJz0BwHCmgVNDiaqW5MlbUChXZa6AsyEHICSctf/pEvxXIir85Mmm4YXns4B5H9vSKRHWlFju
 RLAdbzXhES7A==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="416265832"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:02:42 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        =?UTF-8?q?HORIGUCHI=20NAOYA=28=20=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>
Subject: [RFC 0/4] Fix machine check recovery for copy_from_user
Date:   Thu, 25 Mar 2021 17:02:31 -0700
Message-Id: <20210326000235.370514-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this is the way forward?  I made some poor choices before
to treat poison consumption in the kernel when accessing user data
(get_user() or copy_from_user()) ... in particular assuming that
the right action was sending a SIGBUS to the task as if it had
synchronously accessed the poison location.

First three patches may need to be combined (or broken up differently)
for bisectablilty. But they are presented separately here since they
touch separate parts of the problem.

Second part is definitley incomplete. But I'd like to check that it
is the right approach before expending more brain cells in the maze
of nested macros that is lib/iov_iter.c

Last part has been posted before. It covers the case where the kernel
takes more than one swing at reading poison data before returning to
user.

Tony Luck (4):
  x86/mce: Fix copyin code to return -EFAULT on machine check.
  mce/iter: Check for copyin failure & return error up stack
  mce/copyin: fix to not SIGBUS when copying from user hits poison
  x86/mce: Avoid infinite loop for copy from user recovery

 arch/x86/kernel/cpu/mce/core.c     | 63 +++++++++++++++++++++---------
 arch/x86/kernel/cpu/mce/severity.c |  2 -
 arch/x86/lib/copy_user_64.S        | 18 +++++----
 fs/iomap/buffered-io.c             |  8 +++-
 include/linux/sched.h              |  2 +-
 include/linux/uio.h                |  2 +-
 lib/iov_iter.c                     | 15 ++++++-
 7 files changed, 77 insertions(+), 33 deletions(-)

-- 
2.29.2

