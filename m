Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96513D25B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhGVNsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGVNsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:48:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2BF61264;
        Thu, 22 Jul 2021 14:28:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m6Zgj-001bB5-8I; Thu, 22 Jul 2021 10:28:37 -0400
Message-ID: <20210722142705.992001628@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jul 2021 10:27:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 0/2] tracing: Allow execnames to be passed as args for synthetic events
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

 - Added patch to have all types be possible const (Masami Hiramatsu)

Steven Rostedt (VMware) (2):
      tracing: Have histogram types be constant when possible
      tracing: Allow execnames to be passed as args for synthetic events

----
 kernel/trace/trace_events_hist.c | 78 ++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 22 deletions(-)
