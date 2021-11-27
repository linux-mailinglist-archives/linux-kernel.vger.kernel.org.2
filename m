Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9044600EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 19:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbhK0S0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 13:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhK0SYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 13:24:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB58C061748
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 10:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3B4EB8091F
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 18:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A109CC53FBF;
        Sat, 27 Nov 2021 18:21:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mr2Jn-000D2F-NV;
        Sat, 27 Nov 2021 13:20:59 -0500
Message-ID: <20211127181957.838045913@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 27 Nov 2021 13:19:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [for-linus][PATCH 0/2] tracing: Two fixes for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending because my email server was not connecting to mail.kernel.org ]

Two fixes to event pid filtering:

- Have created events reflect the current state of pid filtering

- Test pid filtering on discard test of recorded logic.
  (Also clean up the if statement to be cleaner).


Steven Rostedt (VMware) (2):
      tracing: Check pid filtering when creating events
      tracing: Fix pid filtering when triggers are attached

----
 kernel/trace/trace.h        | 24 ++++++++++++++++++------
 kernel/trace/trace_events.c | 12 ++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)
