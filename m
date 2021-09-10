Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4344073A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhIJXFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhIJXFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:05:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED1C611AD;
        Fri, 10 Sep 2021 23:04:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mOpYx-001JHT-Md; Fri, 10 Sep 2021 19:04:03 -0400
Message-ID: <20210910230327.606986082@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Sep 2021 19:03:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 0/3] tracing: Another update for 5.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Minor fixes to the processing of the bootconfig tree.


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 5dfe50b05588010f347cb2f436434bf22b7a84ed


Masami Hiramatsu (3):
      tracing/boot: Fix trace_boot_hist_add_array() to check array is value
      tracing/boot: Fix to check the histogram control param is a leaf node
      bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()

----
 include/linux/bootconfig.h |  4 ++--
 kernel/trace/trace_boot.c  | 37 ++++++++++++++++++-------------------
 lib/bootconfig.c           |  8 ++++----
 3 files changed, 24 insertions(+), 25 deletions(-)
