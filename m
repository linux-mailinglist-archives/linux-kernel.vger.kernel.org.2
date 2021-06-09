Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B713A1FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhFIWHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFIWHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:07:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A13613E7;
        Wed,  9 Jun 2021 22:05:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr6KP-002aSr-TA; Wed, 09 Jun 2021 18:05:37 -0400
Message-ID: <20210609220457.220164154@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 18:04:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracing: Simplify and document the trace event filtering temp buffer code
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When filtering trace events, a temp buffer is used because the extra copy
from the temp buffer into the ring buffer is still faster than the direct
write into the ring buffer followed by a discard if the filter does not
match.

But the data that can be stored in the temp buffer is a PAGE_SIZE minus the
ring buffer event header. The calculation of that header size is complex,
but using the helper macro "struct_size()" can simplify it.

Also, add more documentation about what is going on.

Link: https://lore.kernel.org/stable/CAHk-=whKbJkuVmzb0hD3N6q7veprUrSpiBHRxVY=AffWZPtxmg@mail.gmail.com/

Steven Rostedt (VMware) (2):
      tracing: Simplify the max length test when using the filtering temp buffer
      tracing: Add better comments for the filtering temp buffer use case

----
 kernel/trace/trace.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)
