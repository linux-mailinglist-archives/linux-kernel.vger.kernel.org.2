Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F490325BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBZCtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhBZCtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:49:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA4D64EE7;
        Fri, 26 Feb 2021 02:48:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lFTAw-0012i2-KY; Thu, 25 Feb 2021 21:48:18 -0500
Message-ID: <20210226024751.443534071@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 25 Feb 2021 21:47:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] Tracing: Fixes for 5.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Two fixes:

 - Fix an unsafe printf string usage in a kmem trace event
 - Fix spelling in output from the latency-collector tool


Colin Ian King (1):
      tracing/tools: fix a couple of spelling mistakes

Steven Rostedt (VMware) (1):
      mm, tracing: Fix kmem_cache_free trace event to not print stale pointers

----
 include/trace/events/kmem.h               | 6 +++---
 tools/tracing/latency/latency-collector.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
