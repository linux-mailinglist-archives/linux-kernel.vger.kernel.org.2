Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32C837F279
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 07:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhEMFE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 01:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEMFE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 01:04:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC457C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 22:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uRMBUjl6/vrG2aHYjuG4PJqVirIhMBCEUqRi98xb0gc=; b=l78r0KUeWt1tr9jKX/D61vZ/Gk
        qSyrYMkRliIKsWw22de7ZP/C3kzr0hHr7UW8mz7o8C48VsqQTGcDjwHxMVYth8/RcSF90KMmjXDQZ
        U3C/gVX411gQIZSPCxKcx4vwIVewDXgIO1xpkyaWXc9a35Hpgx3Y4GIJzLW+eFci3BHtoT5p2wfyw
        PDCipRjQT5ew4XZ3nVHm5JadQ0LhLPowIh86vqxsRB1M6DIRCWyBE6LSlQEeif0isJt/VJCpMxdMa
        t7mltUS1/mgBgqpKTRyFn2ViyQ8CKb4nbdjjZsPge9/sWFlRbWvRtJTdhuf2glH7HbZy2giYjEWsw
        8wkso12g==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lh3Vi-00B15p-Co; Thu, 13 May 2021 05:03:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] thread_info.h: include limits.h for INT_MAX
Date:   Wed, 12 May 2021 22:03:44 -0700
Message-Id: <20210513050344.28303-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header file <linux/limits.h> to make thread_info.h be
self-contained.
Fixes multiple occurrences of this error:

../include/linux/thread_info.h: In function ‘check_copy_size’:
../include/linux/thread_info.h:215:27: error: ‘INT_MAX’ undeclared (first use in this function)
  if (WARN_ON_ONCE(bytes > INT_MAX))
                           ^

Fixes: 6d13de1489b6 ("uaccess: disallow > INT_MAX copy sizes")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/thread_info.h |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2021-0512-2146.orig/include/linux/thread_info.h
+++ mmotm-2021-0512-2146/include/linux/thread_info.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/bug.h>
+#include <linux/limits.h>
 #include <linux/restart_block.h>
 #include <linux/errno.h>
 
