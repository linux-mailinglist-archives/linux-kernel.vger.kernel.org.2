Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41D3782E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhEJKlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhEJKcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEAF361965;
        Mon, 10 May 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=HMuEeamWkEOzbII9kC7GXZuYB/aImVAw7I4Ml7ib+1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZikLCbaoG0FlaXiH0nka7Z9ArHhPVu0RFubQ7saUAgascpbiro4W0wf/xvXtp6cZ
         EfutuTcCy+DuSvt9vXCeHev7f2OE18SCs0TTTTEqQX/eSkaGwTWh4nxbdXHQFd0SCe
         AGa5550YiLeUea+GPd0PAcJ8/UaGJQqrev2wW4XSHde0wP0ATWkQA6Fs7rk0IIDZFu
         hSNpgWQsQzbhtS8MxYEgly+8C8sWhxoT4iVxk388t6Pjnzo0iD0I1NDly0NSoovKf7
         ZVQUm4z9pOyw3c/du+W0dVx78N1rFjXnJO8pFmHOQ1x77VePL3AV7PIKm3i4GlINBr
         hW6DmmdySO7+g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UQC-Nn; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Pater <02joepater06@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 29/53] docs: kernel-hacking: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:41 +0200
Message-Id: <07079c7721c3dda39b23527b6ece8b0f9746e3e7.1620641727.git.mchehab+huawei@kernel.org>
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

	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/kernel-hacking/hacking.rst | 2 +-
 Documentation/kernel-hacking/locking.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index 451523424942..e8f9cff4b016 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -741,7 +741,7 @@ make a neat patch, there's administrative work to be done:
    In your description of the option, make sure you address both the
    expert user and the user who knows nothing about your feature.
    Mention incompatibilities and issues here. **Definitely** end your
-   description with “if in doubt, say N” (or, occasionally, \`Y'); this
+   description with "if in doubt, say N" (or, occasionally, \`Y'); this
    is for people who have no idea what you are talking about.
 
 -  Edit the ``Makefile``: the CONFIG variables are exported here so you
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index ed1284c6f078..f8ab299314b4 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -872,7 +872,7 @@ the name field.
 Note also that I added a comment describing what data was protected by
 which locks. This is extremely important, as it describes the runtime
 behavior of the code, and can be hard to gain from just reading. And as
-Alan Cox says, “Lock data, not code”.
+Alan Cox says, "Lock data, not code".
 
 Common Problems
 ===============
-- 
2.30.2

