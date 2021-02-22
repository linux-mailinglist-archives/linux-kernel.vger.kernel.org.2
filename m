Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6807320FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 04:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBVDsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 22:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBVDsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:48:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832DC061574;
        Sun, 21 Feb 2021 19:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KAQyq0oIW/PNfyRqIr8/3EgF6hdr+7f6n/lL9tisUcw=; b=mTni6IvL5Kv0TZZv8wk5n+gIpt
        +Q9+amPF/vgezh6rpnM75dgrCASncHDZQvdRd7kdmO1/Z5nb83XJchxNuL5zv2VcqhmkTNphNhpj+
        kT1L/enxaG37yC7MTWCTleI5eSziKsbMBW34Nt1OJUFxfugElJAHlECOo+gYC9rDNnE6M4hT/8/FE
        jewrf2vhkwX7eTZ7s7exsLYFu8cxkKzmG8prV6zzm2+fJXl3JBeIGj/aBxs/9ke6c2v2CB2catAGY
        eGYEKIuQbnKNfdkfmIJ+8xnGAiEJJUHvKPQXwv6Gb2Pj20kwe6twldnYg8DEa1V8cHBFDYeMhzJcc
        vK4Qtgtg==;
Received: from [2601:1c0:6280:3f0::d05b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lE2C5-00046q-Vw; Mon, 22 Feb 2021 03:47:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH -next] Documentation: proc.rst: add more about the 6 fields in loadavg
Date:   Sun, 21 Feb 2021 19:47:29 -0800
Message-Id: <20210222034729.22350-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address Jon's feedback on the previous patch by adding info about
field separators in the /proc/loadavg file.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/filesystems/proc.rst |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20210219.orig/Documentation/filesystems/proc.rst
+++ linux-next-20210219/Documentation/filesystems/proc.rst
@@ -691,6 +691,10 @@ files are there, and which are missing.
                 number of processes currently runnable (running or on ready queue);
                 total number of processes in system;
                 last pid created.
+                All fields are separated by one space except "number of
+                processes currently runnable" and "total number of processes
+                in system", which are separated by a slash ('/'). Example:
+                  0.61 0.61 0.55 3/828 22084
  locks        Kernel locks
  meminfo      Memory info
  misc         Miscellaneous
