Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546A94097D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbhIMPvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343720AbhIMPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:51:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA84C09B09A;
        Mon, 13 Sep 2021 08:39:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f097300886079c88d3e49d7.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7300:8860:79c8:8d3e:49d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78C3E1EC0521;
        Mon, 13 Sep 2021 17:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631547592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zgekov23z1GZtEbng4sGaeDZqkXyds/rilndrnqihYo=;
        b=Hi32wKOTdaxsNWREUuEtHaIJDFYwC3dT1Ygc/Pv5+wW8av/JYX/TTty4J9mnDATDpFd3O8
        2pxIdKWb537Hcg3hcGz5lLkiw5vJq81kP/2kE7ojXN2JF9u1u7hO+zbEZqTYn2nzLA426J
        qdclL4ltWK4TlbB34gQSUoln+oavB/4=
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     X86 ML <x86@kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] Documentation/process: Add maintainer handbooks section
Date:   Mon, 13 Sep 2021 17:39:41 +0200
Message-Id: <20210913153942.15251-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210913153942.15251-1-bp@alien8.de>
References: <20210913153942.15251-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

General rules for patch submission, coding style and related details are
available, but most subsystems have their subsystem-specific extra rules
which differ or go beyond the common rules.

Mark suggested to add a subsystem/maintainer handbook section, where
subsystem maintainers can explain their specific quirks.

Add the section and link to it from the submitting-patches document.

  [ bp: Add a SPDX identifier. ]

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20181107171149.074948887@linutronix.de
---
 Documentation/process/index.rst                |  1 +
 Documentation/process/maintainer-handbooks.rst | 16 ++++++++++++++++
 Documentation/process/submitting-patches.rst   |  4 ++++
 3 files changed, 21 insertions(+)
 create mode 100644 Documentation/process/maintainer-handbooks.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index dd231ffc8422..9f1b88492bb3 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -27,6 +27,7 @@ Below are the essential guides that every developer should read.
    submitting-patches
    programming-language
    coding-style
+   maintainer-handbooks
    maintainer-pgp-guide
    email-clients
    kernel-enforcement-statement
diff --git a/Documentation/process/maintainer-handbooks.rst b/Documentation/process/maintainer-handbooks.rst
new file mode 100644
index 000000000000..cd707727dc8f
--- /dev/null
+++ b/Documentation/process/maintainer-handbooks.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _maintainer_handbooks_main:
+
+Subsystem and maintainer tree specific development process notes
+================================================================
+
+The purpose of this document is to provide subsystem specific information
+which is supplementary to the general development process handbook
+:ref:`Documentation/process <development_process_main>`.
+
+Contents:
+
+.. toctree::
+   :numbered:
+   :maxdepth: 2
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 8ad6b93f91e6..f5ae1efd8cb6 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -21,6 +21,10 @@ If you're unfamiliar with ``git``, you would be well-advised to learn how to
 use it, it will make your life as a kernel developer and in general much
 easier.
 
+Some subsystems and maintainer trees have additional information about
+their workflow and expectations, see :ref:`Documentation/process/maintainer
+handbooks <maintainer_handbooks_main>`.
+
 Obtain a current source tree
 ----------------------------
 
-- 
2.29.2

