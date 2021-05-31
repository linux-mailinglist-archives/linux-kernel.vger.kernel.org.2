Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF73964F7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhEaQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233606AbhEaOlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:41:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99DD961C73;
        Mon, 31 May 2021 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622469212;
        bh=NmajkwAUErgh7ORHx1VP5JA7EmeSO4Cym94XZ5/sbXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sELenWbBdJvtwEq/yBb4hLjiagsvVwnLp6Rg/lqho/HSnRc2PkDz9u1SRQikhOxlY
         QgA3FIbJ7ZcT6kP5uicU9+10Zo1NJu9G8tm9U3/ATAoZQnR05znSTUFN/blvqUOonB
         jcyRhEslKeqqXx213Wc1j+ufxAYEy+BfkkX6pP38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhouchuangao <zhouchuangao@vivo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.12 112/296] fs/nfs: Use fatal_signal_pending instead of signal_pending
Date:   Mon, 31 May 2021 15:12:47 +0200
Message-Id: <20210531130707.696742094@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531130703.762129381@linuxfoundation.org>
References: <20210531130703.762129381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhouchuangao <zhouchuangao@vivo.com>

commit bb002388901151fe35b6697ab116f6ed0721a9ed upstream.

We set the state of the current process to TASK_KILLABLE via
prepare_to_wait(). Should we use fatal_signal_pending() to detect
the signal here?

Fixes: b4868b44c562 ("NFSv4: Wait for stateid updates after CLOSE/OPEN_DOWNGRADE")
Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1682,7 +1682,7 @@ static void nfs_set_open_stateid_locked(
 		rcu_read_unlock();
 		trace_nfs4_open_stateid_update_wait(state->inode, stateid, 0);
 
-		if (!signal_pending(current)) {
+		if (!fatal_signal_pending(current)) {
 			if (schedule_timeout(5*HZ) == 0)
 				status = -EAGAIN;
 			else
@@ -3458,7 +3458,7 @@ static bool nfs4_refresh_open_old_statei
 		write_sequnlock(&state->seqlock);
 		trace_nfs4_close_stateid_update_wait(state->inode, dst, 0);
 
-		if (signal_pending(current))
+		if (fatal_signal_pending(current))
 			status = -EINTR;
 		else
 			if (schedule_timeout(5*HZ) != 0)


