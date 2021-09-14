Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8F40B210
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhINOvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233812AbhINOvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:51:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF54610CE;
        Tue, 14 Sep 2021 14:50:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mQ9lZ-001oOI-9q; Tue, 14 Sep 2021 10:50:33 -0400
Message-ID: <20210914144809.297030763@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 14 Sep 2021 10:48:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 0/2] tracing: Fixes to bootconfig memory handling
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some memory management fixes to the bootconfig code.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 8e9f0934a07e699044d422ca9cfb553f25c72b41


Masami Hiramatsu (2):
      bootconfig: Fix to check the xbc_node is used before free it
      bootconfig: Free copied bootconfig data after boot

----
 init/main.c      | 8 ++++++++
 lib/bootconfig.c | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)
