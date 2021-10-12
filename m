Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4242AF54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhJLVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 17:55:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:29658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234845AbhJLVy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:54:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227177850"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="227177850"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 14:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="659280302"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Oct 2021 14:52:51 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1maPha-0003wK-Vh; Tue, 12 Oct 2021 21:52:50 +0000
Date:   Wed, 13 Oct 2021 05:52:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [RFC PATCH] lib/stackdepot: stack_depot_init_mutex can be static
Message-ID: <20211012215233.GA41525@800d2291961c>
References: <20211012090621.1357-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012090621.1357-1-vbabka@suse.cz>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/stackdepot.c:150:1: warning: symbol 'stack_depot_init_mutex' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 stackdepot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 9bb5333bf02f61..89b67aef9b320b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -147,7 +147,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
 #define STACK_HASH_SEED 0x9747b28c
 
-DEFINE_MUTEX(stack_depot_init_mutex);
+static DEFINE_MUTEX(stack_depot_init_mutex);
 static bool stack_depot_disable;
 static struct stack_record **stack_table;
 
