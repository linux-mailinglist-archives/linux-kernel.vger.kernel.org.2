Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1576E3EA7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbhHLPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232854AbhHLPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:50:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C1960F91;
        Thu, 12 Aug 2021 15:50:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mECyU-003thq-80; Thu, 12 Aug 2021 11:50:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v2 0/2] libtracefs: Make hist variable names unique
Date:   Thu, 12 Aug 2021 11:50:27 -0400
Message-Id: <20210812155029.929048-1-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order to be able to have API that can do onmax() and onchange() as well
as include the .save() and .snapshot() actions, we need to make sure that
the variable names are unique even between different events.

The first adds a "randomness" to the name, and the second patch fixes an
issue where the "end" event fields are saved in the same name as they are
called, then the ".save" action can not be used on them.

Changes since v1:

 - Use open coded "rand()" as rand() is not reentrant, and it we use our own
   seed each time.

 - Use gettimeofday() instead of time() as Yordan pointed out that time()
   has a resolution of 1 second, and a thread could call this for different
   synthetic events.


Steven Rostedt (VMware) (2):
  libtracefs: Add random number to keep synthetic variables unique
  libtracefs: Have end event variables not be the end event field name

 src/tracefs-hist.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

-- 
2.30.2

