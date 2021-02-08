Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0860231419A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbhBHVV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236623AbhBHULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:11:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C09764E7A;
        Mon,  8 Feb 2021 20:10:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l9Cry-00AfN8-Nx; Mon, 08 Feb 2021 15:10:50 -0500
Message-ID: <20210208200922.215867530@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 08 Feb 2021 15:09:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 0/2 v3] tracepoints: Stop punishing non-static call users
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broke this up into two patches now. See the second patch for the
description of waht this series is doing.

Changes since v2:

 Added a patch to remove "data_args", as it was causing issues with
 handling of "__data", especially when it wasn't needed.


Steven Rostedt (VMware) (2):
      tracepoints: Remove unnecessary "data_args" macro parameter
      tracepoints: Do not punish non static call users

----
 include/linux/tracepoint.h | 52 ++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)
