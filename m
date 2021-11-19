Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C84457613
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhKSRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbhKSRwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:52:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8BA6117A;
        Fri, 19 Nov 2021 17:49:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mo80T-001NIC-HG;
        Fri, 19 Nov 2021 12:49:01 -0500
Message-ID: <20211119174730.441176580@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Nov 2021 12:47:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Fixes for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix double free in destroy_hist_field

 - Harden memset() of trace_iterator structure

 - Do not warn in trace printk check when test buffer fills up

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 2ef75e9bd2c998f1c6f6f23a3744136105ddefd5


Kalesh Singh (1):
      tracing/histogram: Fix UAF in destroy_hist_field()

Kees Cook (1):
      tracing: Use memset_startat() to zero struct trace_iterator

Nikita Yushchenko (1):
      tracing: Don't use out-of-sync va_list in event printing

----
 kernel/trace/trace.c             | 16 +++++++++++++---
 kernel/trace/trace_events_hist.c | 41 +++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 22 deletions(-)
