Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A803BF178
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhGGVmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233017AbhGGVmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:42:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33DF261C3C;
        Wed,  7 Jul 2021 21:39:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1FGL-00172v-Up; Wed, 07 Jul 2021 17:39:21 -0400
Message-ID: <20210707213623.250212325@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 07 Jul 2021 17:36:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 0/2 v3] tracing/histogram: Add buckets to group data in
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a .buckets modifier to group the data instead of having every key saved
in its own entry, and in a linear fashion instead of like the log2 modifier.

Changes since v2:

 - Rename "grouping" field in hist_field to "buckets"
 - Updated documentation to describe the new modifier


Steven Rostedt (VMware) (2):
      tracing: Add linear buckets to histogram logic
      tracing/histogram: Update the documentation for the buckets modifier

----
 Documentation/trace/histogram.rst | 92 ++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace.c              |  1 +
 kernel/trace/trace_events_hist.c  | 65 ++++++++++++++++++++++++---
 3 files changed, 145 insertions(+), 13 deletions(-)
