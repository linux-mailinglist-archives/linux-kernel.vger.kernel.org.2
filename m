Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57D372366
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhECXHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhECXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89AC561008;
        Mon,  3 May 2021 23:06:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1ldheT-009Y8D-76; Mon, 03 May 2021 19:06:57 -0400
Message-ID: <20210503230657.078872210@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 May 2021 19:05:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        "John Warthog9 Hawley (VMware)" <warthog9@eaglescrag.net>
Subject: [for-next][PATCH 1/7] ktest: Minor cleanup with uninitialized variable $build_options
References: <20210503230510.845068955@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>

Signed-off-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 4e2450964517..18fd4fd117dd 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2594,6 +2594,9 @@ sub build {
     # Run old config regardless, to enforce min configurations
     make_oldconfig;
 
+    if (not defined($build_options)){
+	$build_options = "";
+    }
     my $build_ret = run_command "$make $build_options", $buildlog;
 
     if (defined($post_build)) {
-- 
2.30.1


