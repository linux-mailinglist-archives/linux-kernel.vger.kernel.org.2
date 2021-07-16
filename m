Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88F3CB07F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGPBkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhGPBkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:40:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB85F613D0;
        Fri, 16 Jul 2021 01:37:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m4Cmu-000ub7-ON; Thu, 15 Jul 2021 21:37:12 -0400
Message-ID: <20210716013613.954877305@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jul 2021 21:36:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Another update for 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A fix for histogram code that dereferences pointers without checking them.

Take two on the __string_len() macro.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 85f666175d522f9f1c089f04ed9af5aa4ec84202


Steven Rostedt (VMware) (2):
      tracing: Do not reference char * as a string in histograms
      tracing: Add trace_event helper macros __string_len() and __assign_str_len()

----
 include/trace/trace_events.h     | 22 ++++++++++++++++++++++
 kernel/trace/trace_events_hist.c |  6 +++---
 2 files changed, 25 insertions(+), 3 deletions(-)
