Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37343458F58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbhKVNaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:30:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhKVNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:30:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 09E10217BA;
        Mon, 22 Nov 2021 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637587629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZOqoB6LrLA0edOmgFk3g+T1lzcj5WWJLexHPanjjwxY=;
        b=TyQDPRkiGPWDsM/SklH8myiiP+oJa/KxfXnKMEmxeiGEQkOHW7UBUkWNBWkabeRVZPXWT/
        10GrmJ/mS28xoiRLkC9h4JcVrjU0hGI+pXrr1ODP28dNyXEl26nllet3eDqH7+zcG0LP7D
        cdeQH/3Z5eBWO6qbf3BUPHZX4IHx3fc=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id B5B68A3B83;
        Mon, 22 Nov 2021 13:27:07 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/5] printk/console: Registration code cleanup - part 1
Date:   Mon, 22 Nov 2021 14:26:44 +0100
Message-Id: <20211122132649.12737-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The console registration code has several twists that are hard to follow.
It is result of various features added over the last few decades.

I have already spent many days to understand all the effects and
the desired behavior. I am always scared to touch the console registration
code even after years working as printk maintainer.

There were several changes in the code that had to be reverted because
they caused regression, for example:

   + commit dac8bbbae1d0ccba96402 ("Revert "printk: fix double printing
     with earlycon")

   + commit c6c7d83b9c9e6a8b3e6d ("Revert "console: don't prefer first
     registered if DT specifies stdout-path")


This patchset removes the most tricky twists from my POV. I have worked
on it when time permitted since January. I have spent most of the time
writing the commit message, understanding, and explaining the effects.
I am not sure if I succeeded but it is time to send this.


Behavior change:

There is one behavior change caused by 4th patch. I consider it bug fix.
It should be acceptable. See the commit message for more details.


Future plans:

I already have additional 18 patches that do further clean up of
the console registration code. They still need more love.

I send this 5 patchset first because they are clear win from my POV.
And I wanted to do it by smaller steps.

I would appreciate if anyone double checks logic of the changes.
Anyway, we could put it into linux-next and see. I am quite
confident and optimistic ;-)


Petr Mladek (5):
  printk/console: Split out code that enables default console
  printk/console: Rename has_preferred_console to need_default_console
  printk/console: Remove unnecessary need_default_console manipulation
  printk/console: Remove need_default_console variable
  printk/console: Clean up boot console handling in register_console()

 kernel/printk/printk.c | 104 +++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 46 deletions(-)

-- 
2.26.2

