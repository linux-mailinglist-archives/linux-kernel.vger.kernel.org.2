Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00AA3C2406
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhGINN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhGINN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:13:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B7D611AE;
        Fri,  9 Jul 2021 13:10:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1qHC-00096c-On; Fri, 09 Jul 2021 09:10:42 -0400
Message-ID: <20210709130949.717206727@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 09:09:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Some minor clean ups and fixes for 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Baokun Li (1):
      ftrace: Use list_move instead of list_del/list_add

Steven Rostedt (VMware) (2):
      tracing/histograms: Fix parsing of "sym-offset" modifier
      tracing/selftests: Add tests to test histogram sym and sym-offset modifiers

----
 kernel/trace/ftrace.c                                  |  3 +--
 kernel/trace/trace_events_hist.c                       |  7 +++++++
 .../selftests/ftrace/test.d/trigger/trigger-hist.tc    | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)
