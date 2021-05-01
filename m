Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF1370461
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhEAA1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhEAA1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:27:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E46386143D;
        Sat,  1 May 2021 00:27:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lcdTJ-008tCz-Oj; Fri, 30 Apr 2021 20:27:01 -0400
Message-ID: <20210501002625.540979896@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Apr 2021 20:26:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: A couple of last minute fixes before pushing to 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: aafe104aa9096827a429bc1358f8260ee565b7cc


Steven Rostedt (VMware) (2):
      tracing: Map all PIDs to command lines
      tracing: Restructure trace_clock_global() to never block

----
 kernel/trace/trace.c       | 41 +++++++++++++++--------------------------
 kernel/trace/trace_clock.c | 44 ++++++++++++++++++++++++++++++--------------
 2 files changed, 45 insertions(+), 40 deletions(-)
