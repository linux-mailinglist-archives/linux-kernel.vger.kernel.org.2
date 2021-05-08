Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA572377033
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhEHG5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhEHG5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:57:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCEAC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 23:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JcxOeJXIxQyTFQxUVECi3/gIdDhVTk5fqNvQuEh5UW0=; b=id2W3YWkh+0chjmYxtwFSCAgez
        cMfLmdBEg/DmmGTbOnbeCGYWKZfb7625bWLyNYMY/7c8kkDtSJglA9rJb/rXJZCJ2mC7929qiqWDc
        ZlQSZYWNxw+OBkOiL7Se2ZLTdRLx0lln4lMPJX6oKkOminTo4sxKZhzJF81Fq7q4AsVowSGNf3DNp
        71K+ZFZ+R5gO5OG7Qyire9yrvJ3u16h9UIDmLB746yfrcB6gsIlcI7Qfyd44+y3uFJ5Ps+SenZVeb
        9n8ebYQiCYGbrtGHMNEXma/HxyhCoie4dxjZrqWRvsaGDmn/i6Ydo2+eSjJfillOR7E7DY5Q+/w1S
        uvUavyZw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lfGsj-007PSw-G4; Sat, 08 May 2021 06:56:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] platform_data: x86/pmc_atom.h: drop a duplicated word
Date:   Fri,  7 May 2021 23:56:07 -0700
Message-Id: <20210508065607.22276-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "of" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v2: Fix email address for Stephen Boyd (was: <sboyd@codeaurora.org>);
    add Cc: Andrew Morton

 include/linux/platform_data/x86/pmc_atom.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210507.orig/include/linux/platform_data/x86/pmc_atom.h
+++ linux-next-20210507/include/linux/platform_data/x86/pmc_atom.h
@@ -47,7 +47,7 @@
 #define	PMC_S0I2_TMR		0x88
 #define	PMC_S0I3_TMR		0x8C
 #define	PMC_S0_TMR		0x90
-/* Sleep state counter is in units of of 32us */
+/* Sleep state counter is in units of 32us */
 #define	PMC_TMR_SHIFT		5
 
 /* Power status of power islands */
