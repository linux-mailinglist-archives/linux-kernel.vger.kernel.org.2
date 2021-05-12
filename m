Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB64337BD56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhELMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhELMxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C272E61407;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=Dgt/5RNBXLwhp7IpWFWWhXwA82SIU4D7mPP56pRZkYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFM269r+rL0dDCvdWti601yMJnfDe663NZwFfab8hxkR2BRRo1KGCzY43NolNTeq0
         viTJbMGv/28zlZb/DiuCNu6MIHLUwZY0AZEhcQb0p0PDYTsC34HVn2n4/BiZov0Ox4
         dP3eYR+xUHJNSnjyumwMorNAMBRn3h/lfof1rzPKli1PYfhC1nTMIcNcL0pUqYLx9p
         1Ar7HhjhMAX1HAUMeIeLkBDwQST3pKptHeHVByuZJLdIf1wbh17uEIRAfjVma1eRLh
         WQUlXLchSNmNNdNlKHp61w2TFsAjp2GeoS5g/cqwA9q6O9BNg78SgY/NskKuOVktKN
         TaXaCkKKauFIg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018i5-Tb; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Pater <02joepater06@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/40] docs: kernel-hacking: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:24 +0200
Message-Id: <81ce51d6970ca773aa8b3fec9a9e66e03924d82b.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

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

