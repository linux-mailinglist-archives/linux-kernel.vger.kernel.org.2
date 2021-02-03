Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA630D230
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhBCDdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhBCDd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:33:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A0C061573;
        Tue,  2 Feb 2021 19:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=i036O3N23XFL3NA6kuzu8UTdLLHCPWiMJL4KTHjaD7w=; b=PBNtr26C/AimXkELPhFK5K6zPK
        4J/v6tmFl/9MWJOZGcl7UeNHbKGJSXe1EC8RghCzOVPJgboyv9bgChsHGQkVt5CpZruRRNga2qXwg
        WtQoYwGkdPGO8HyX9StPElrNsEf8oIoHjqGUSMoCBJAQ0jWGtQIGzJ+4NnpbmJvELV6ZQKHxlhTmp
        PBQ9NVPmK4M9b9Ii9uQa1nzxogdeSRoUs3CVYoHt4c0shwoGTcoZyBElgEFbJX9tHYA4IH8ZKlY73
        pFO+i0/MukUtFfI40wb+4yAO+l5hzyom+ZLzSr9s0ZTUI0rV072Fjlx907FvCjm1M3etxQ+HhAEJq
        pinhxPsw==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l78uM-0001bZ-QY; Wed, 03 Feb 2021 03:32:47 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: /proc/loadavg: add 3 more field descriptions
Message-ID: <fe55b139-bd03-4762-199b-83be873cf7dd@infradead.org>
Date:   Tue, 2 Feb 2021 19:32:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Update contents of /proc/loadavg: add 3 more fields.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
---
 Documentation/filesystems/proc.rst |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-next-20210202.orig/Documentation/filesystems/proc.rst
+++ linux-next-20210202/Documentation/filesystems/proc.rst
@@ -687,7 +687,10 @@ files are there, and which are missing.
  kcore        Kernel core image (can be ELF or A.OUT(deprecated in 2.4))
  kmsg         Kernel messages
  ksyms        Kernel symbol table
- loadavg      Load average of last 1, 5 & 15 minutes
+ loadavg      Load average of last 1, 5 & 15 minutes;
+                number of processes currently runnable (running or on ready queue);
+                total number of processes in system;
+                last pid created.
  locks        Kernel locks
  meminfo      Memory info
  misc         Miscellaneous

