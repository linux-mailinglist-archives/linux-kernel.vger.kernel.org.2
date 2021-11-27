Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048F1460053
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351640AbhK0Qxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 11:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhK0Qva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 11:51:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 08:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43571B81B67
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 16:48:14 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPS id 4431FC53FBF;
        Sat, 27 Nov 2021 16:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.kernel.org 4431FC53FBF
Authentication-Results: smtp.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.kernel.org; spf=none smtp.mailfrom=goodmis.org
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mr0rs-000Aoo-V3;
        Sat, 27 Nov 2021 11:48:04 -0500
Message-ID: <20211127164720.484358409@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 27 Nov 2021 11:47:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [for-linus][PATCH 0/2] tracing: Updates to 5.16-rc2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Two fixes to event pid filtering:

- Have created events reflect the current state of pid filtering

- Test pid filtering on discard test of recorded logic.
  (Also clean up the if statement to be easier to read).


Steven Rostedt (VMware) (2):
      tracing: Check pid filtering when creating events
      tracing: Fix pid filtering when triggers are attached

----
 kernel/trace/trace.h        | 24 ++++++++++++++++++------
 kernel/trace/trace_events.c | 12 ++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)
