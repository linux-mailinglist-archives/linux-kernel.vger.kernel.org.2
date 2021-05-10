Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957D6378238
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhEJKdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhEJK3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:29:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAF98616EA;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=zVyx8QmpdSUBFOXHrT+jQKF6iGsY9cxp2c7VRhni3QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3HZqwkwsypHQTmgLvmAE+L/UvAvKs4zeOfLavZj4+9/e/n4sZdDSz7LQx5qyKNFS
         DHHXpLydmHc0MfPZUPhHIeP5OdxBZ8f21uLuptBroqXEKguELghdOKLCdzt2QHHnN0
         EO9XtXN45/F2QvfD4CriDMpokAvIy19bQ2LQP2Wry9opUN+2laFHo6cB4IqExrKJeW
         89+e4t5P2mk1yZ594lwjHFoZOOPJAJ9zUfvhrSHYRQ4/v0fwlsj6951gNa1QytIP+t
         nzQmSg9q/U+DMSAj8DX4OZRFNxdgASXCqQaLdTswLL1HA4bnGVl7R1/S61N5UZeqKX
         bKYiCEeUZlv5Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UOq-NW; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Rafael Aquini <aquini@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Kitt <steve@sk2.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/53] docs: admin-guide: sysctl: kernel.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:20 +0200
Message-Id: <6c4464894d19e99037c699104ae77b1881ea6817.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2014 ('—'): EM DASH

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1d56a6b73a4e..743a7c70fd83 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1285,7 +1285,7 @@ The soft lockup detector monitors CPUs for threads that are hogging the CPUs
 without rescheduling voluntarily, and thus prevent the 'watchdog/N' threads
 from running. The mechanism depends on the CPUs ability to respond to timer
 interrupts which are needed for the 'watchdog/N' threads to be woken up by
-the watchdog timer function, otherwise the NMI watchdog — if enabled — can
+the watchdog timer function, otherwise the NMI watchdog - if enabled - can
 detect a hard lockup condition.
 
 
-- 
2.30.2

