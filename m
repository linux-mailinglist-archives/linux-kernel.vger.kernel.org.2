Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58C3B4613
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhFYOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:50:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38206 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhFYOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:50:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87D6521CD8;
        Fri, 25 Jun 2021 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624632513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aDKc2sUUuqzsaNgqaaJJMe7pZHE+SjbV9/47hMBhTNA=;
        b=LV7yM8b82FGsU+VWDq435TKFBEs5osvyYWWd4K4KoeYnkiQiS6ns8zH1wfiTb2ALEoSBcQ
        WFLhvk2BTmt8mvARqhFHsrr3cHK7gUww7VMLHG03l/H44IlJ8YqOcMJRVxWGNbVjNSs7Aw
        wZJu7LP1sWyouQ2vl4Sueiba29m/E64=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 58B1111A97;
        Fri, 25 Jun 2021 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624632513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aDKc2sUUuqzsaNgqaaJJMe7pZHE+SjbV9/47hMBhTNA=;
        b=LV7yM8b82FGsU+VWDq435TKFBEs5osvyYWWd4K4KoeYnkiQiS6ns8zH1wfiTb2ALEoSBcQ
        WFLhvk2BTmt8mvARqhFHsrr3cHK7gUww7VMLHG03l/H44IlJ8YqOcMJRVxWGNbVjNSs7Aw
        wZJu7LP1sWyouQ2vl4Sueiba29m/E64=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 3H1uFMHs1WBNIAAALh3uQQ
        (envelope-from <jgross@suse.com>); Fri, 25 Jun 2021 14:48:33 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.13-rc8
Date:   Fri, 25 Jun 2021 16:48:32 +0200
Message-Id: <20210625144832.20839-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc8-tag

xen: branch for v5.13-rc8

It contains a fix for a regression introduced in 5.12: when migrating
an irq related to a Xen user event to another cpu, a race might result
in a WARN() triggering.

Thanks.

Juergen

 drivers/xen/events/events_base.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Juergen Gross (1):
      xen/events: reset active flag for lateeoi events later
