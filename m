Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD144F347
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhKMNRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231555AbhKMNQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:16:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F55060F6B;
        Sat, 13 Nov 2021 13:14:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mlsr7-000Rly-Dg;
        Sat, 13 Nov 2021 08:14:05 -0500
Message-ID: <20211113131340.640683117@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 13 Nov 2021 08:13:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Fixes to 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Three tracing fixes:

 - Make local osnoise_instances static

 - Copy just actual size of histogram strings

 - Properly check missing operands in histogram expressions

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 1cab6bce42e62bba2ff2c2370d139618c1828b42


Daniel Bristot de Oliveira (1):
      tracing/osnoise: Make osnoise_instances static

Kalesh Singh (1):
      tracing/histogram: Fix check for missing operands in an expression

Masami Hiramatsu (1):
      tracing/histogram: Do not copy the fixed-size char array field over the field size

----
 kernel/trace/trace_events_hist.c | 12 +++++++-----
 kernel/trace/trace_osnoise.c     |  3 ++-
 2 files changed, 9 insertions(+), 6 deletions(-)
