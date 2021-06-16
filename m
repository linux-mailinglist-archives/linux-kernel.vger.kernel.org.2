Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B893A928C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhFPGas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhFPG34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA6C6613F5;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=VxITOezhtTRlPeNLxYiTzu+1PNHHFzqaLGTg9BpfoXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBS1rceGjYfNh5LREtfcm+z8JSMZvU3hzFbXwh1pGZEPfZFyFtFxvBPws/+aAKnwM
         WWaa4rfSrx9VQSp9Du7QqHyWjRUaF14dP6Rs6RyANzPB6emTJiRKnD0Jxa8HXz4SET
         5Kcu0asWMTSHfb5D6im7ySPZ+cMoI+lhyYi1cuQw2pbo3gOjFfBufJXQqhJCwHv29I
         OLxDPqOjE9fZgucoBlffveKgqaSGrBHWOzDVch8joE66/Zs262gNUy6Qpj7mNv/GFd
         5rkJ+I8TvezGM5fs8FORWn3fk/Lgsh1B+YBmYWStlYX41oEsRbGhEHI0SFaoSQUUjG
         YaGMeznWxJosg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1f-004kJm-1Q; Wed, 16 Jun 2021 08:27:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Drew DeVault <sir@cmpwn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/29] docs: process: submitting-patches.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:38 +0200
Message-Id: <d172ab629c3e32c8d27ed4b9d2a209933e2a7178.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/submitting-patches.rst | 32 +++++++++-----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index c66a19201deb..0852bcf73630 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -10,10 +10,11 @@ can greatly increase the chances of your change being accepted.
 
 This document contains a large number of suggestions in a relatively terse
 format.  For detailed information on how the kernel development process
-works, see :doc:`development-process`. Also, read :doc:`submit-checklist`
+works, see Documentation/process/development-process.rst. Also, read
+Documentation/process/submit-checklist.rst
 for a list of items to check before submitting code.  If you are submitting
-a driver, also read :doc:`submitting-drivers`; for device tree binding patches,
-read :doc:`submitting-patches`.
+a driver, also read Documentation/process/submitting-drivers.rst; for device
+tree binding patches, read Documentation/process/submitting-patches.rst.
 
 This documentation assumes that you're using ``git`` to prepare your patches.
 If you're unfamiliar with ``git``, you would be well-advised to learn how to
@@ -178,8 +179,7 @@ Style-check your changes
 ------------------------
 
 Check your patch for basic style violations, details of which can be
-found in
-:ref:`Documentation/process/coding-style.rst <codingstyle>`.
+found in Documentation/process/coding-style.rst.
 Failure to do so simply wastes
 the reviewers time and will get your patch rejected, probably
 without even being read.
@@ -238,7 +238,7 @@ If you have a patch that fixes an exploitable security bug, send that patch
 to security@kernel.org.  For severe bugs, a short embargo may be considered
 to allow distributors to get the patch out to users; in such cases,
 obviously, the patch should not be sent to any public lists. See also
-:doc:`/admin-guide/security-bugs`.
+Documentation/admin-guide/security-bugs.rst.
 
 Patches that fix a severe bug in a released kernel should be directed
 toward the stable maintainers by putting a line like this::
@@ -246,9 +246,8 @@ toward the stable maintainers by putting a line like this::
   Cc: stable@vger.kernel.org
 
 into the sign-off area of your patch (note, NOT an email recipient).  You
-should also read
-:ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
-in addition to this file.
+should also read Documentation/process/stable-kernel-rules.rst
+in addition to this document.
 
 If changes affect userland-kernel interfaces, please send the MAN-PAGES
 maintainer (as listed in the MAINTAINERS file) a man-pages patch, or at
@@ -305,8 +304,8 @@ decreasing the likelihood of your MIME-attached change being accepted.
 Exception:  If your mailer is mangling patches then someone may ask
 you to re-send them using MIME.
 
-See :doc:`/process/email-clients` for hints about configuring your e-mail
-client so that it sends your patches untouched.
+See Documentation/process/email-clients.rst for hints about configuring
+your e-mail client so that it sends your patches untouched.
 
 Respond to review comments
 --------------------------
@@ -324,7 +323,7 @@ for their time.  Code review is a tiring and time-consuming process, and
 reviewers sometimes get grumpy.  Even in that case, though, respond
 politely and address the problems they have pointed out.
 
-See :doc:`email-clients` for recommendations on email
+See Documentation/process/email-clients.rst for recommendations on email
 clients and mailing list etiquette.
 
 
@@ -562,10 +561,10 @@ method for indicating a bug fixed by the patch. See :ref:`describe_changes`
 for more details.
 
 Note: Attaching a Fixes: tag does not subvert the stable kernel rules
-process nor the requirement to Cc: stable@vger.kernel.org on all stable 
+process nor the requirement to Cc: stable@vger.kernel.org on all stable
 patch candidates. For more information, please read
-:ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
-     
+Documentation/process/stable-kernel-rules.rst.
+
 .. _the_canonical_patch_format:
 
 The canonical patch format
@@ -824,8 +823,7 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
 
-Kernel Documentation/process/coding-style.rst:
-  :ref:`Documentation/process/coding-style.rst <codingstyle>`
+Kernel Documentation/process/coding-style.rst
 
 Linus Torvalds's mail on the canonical patch format:
   <https://lore.kernel.org/r/Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
-- 
2.31.1

