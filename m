Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AB53ACAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhFRMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:23:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50168 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhFRMX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:23:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0574E21B53;
        Fri, 18 Jun 2021 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624018876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=r4F0dIun8vyxV86seED4iHdQUCjoQWDB8lHysoL/yJE=;
        b=fBI5nnMG1VchhXBQfwRGgpLwaufap1q/YpB8pfWEbD8v85pAtbX24gwqxoZvcj4RPnt2CW
        CwV23ui34xdaPGJ+7QH8CLTeyjHp7JOnTMkVIFYVdbcGofJ1P2akc+VDkUW02cM3SIPx8s
        eKriE1pqWM9FDrABEfggVIdOmpMWfuM=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B2873A3BBC;
        Fri, 18 Jun 2021 12:21:15 +0000 (UTC)
Date:   Fri, 18 Jun 2021 14:21:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk fixup for 5.13
Message-ID: <YMyPuzVfVbShxdeJ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull a printk fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.13-fixup

=========================

- Fix misplaced EXPORT_SYMBOL(vsprintf).

=========================

It has been introduced in 5.13-rc1 and causes non-necessary churn in
the RT tree where the printk rework is being prepared.

I am sorry for the noise at this stage.

----------------------------------------------------------------
Punit Agrawal (1):
      printk: Move EXPORT_SYMBOL() closer to vprintk definition

 kernel/printk/printk_safe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
