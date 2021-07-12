Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162C73C63D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhGLTpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhGLTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:44:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F673C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V7+FGrqCE97oONDoHC8Zj/lJXxDhp+XiIcFymDp6zkc=; b=fmgfD2OZAc4ss68kfVkZ5H9h7c
        udmWGMs2sqNQGSK3Cy+rNrOKrkQvJzaKQwXrAafRFSIcFOz3WeTmhkx+UjF4V9/8QrSJ+RUt3RkjJ
        D5gxwQce3gN6EXUXOnuQ/soa0oIWR1M4BW5NQ9ITvfMCf6A1LCZWT5KKLiP2LwM4kJ6AFy9iED4gh
        C74UORY7jBC+2L9xHwRT+1ofjze0GsWIJCZ3FkSRqSqiocMw2MAeI2qeq8URziFFtR+SdQK58QbzE
        qxoUAmYwCyjn825+os/3JqWCSLUoD60FHN793oH8FNCrO6Bioi028RMr9SfDWN8icbRhm2mdPIMNr
        omi8j1ww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31oH-000Nh9-Qk; Mon, 12 Jul 2021 19:41:49 +0000
Date:   Mon, 12 Jul 2021 20:41:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/sparse.c:145:2: warning: int result is returned as long
 value. If the return value is long to avoid loss of information, then you
 have loss of information. [truncLongCastReturn]
Message-ID: <YOya+aBZFFmC476e@casper.infradead.org>
References: <202107130348.6LsVT9Nc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107130348.6LsVT9Nc-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 03:19:06AM +0800, kernel test robot wrote:
> cppcheck warnings: (new ones prefixed by >>)
> >> mm/sparse.c:145:2: warning: int result is returned as long value. If the return value is long to avoid loss of information, then you have loss of information. [truncLongCastReturn]
>     return (nid << SECTION_NID_SHIFT);

Hrm.

include/linux/mmzone.h:#define SECTION_NID_SHIFT                3

I'm going to suggest that we don't allow for 2^29 node IDs in a single
system, so this doesn't actually represent a bug that needs to be fixed.
On the other hand, this type of bug continually bites us, and it would
be good to warn about this kind of thing.  So in the spirit of silencing
the warning by doing the promotion that C should have specified in
the first place ...

--- 8< ---

[PATCH] Avoid a warning in sparse memory support

cppcheck warns that we're possibly losing information by shifting an int.
It's a false positive, because we don't allow for a NUMA node ID that
large, but if we ever change SECTION_NID_SHIFT, it could become a problem,
and in any case this is usually a legitimate warning.  Fix it by adding
the necessary cast, which makes the compiler generate the right code.

diff --git a/mm/sparse.c b/mm/sparse.c
index 6326cdf36c4f..f17bd4f7caaa 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -143,7 +143,7 @@ unsigned long __section_nr(struct mem_section *ms)
  */
 static inline unsigned long sparse_encode_early_nid(int nid)
 {
-	return (nid << SECTION_NID_SHIFT);
+	return ((unsigned long)nid << SECTION_NID_SHIFT);
 }
 
 static inline int sparse_early_nid(struct mem_section *section)
