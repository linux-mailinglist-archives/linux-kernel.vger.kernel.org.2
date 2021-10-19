Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B701433082
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhJSIGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234698AbhJSIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CA5561374;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=xaf6KuSLcTnttMKNEiXwZh6FOYo6xmMhCzoJ1OhWWM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tm+/c6Y7qmf2d9izKanzk4lPpwADtc4Me9L5s93AKZqxuj4TFoBaAFCzXkzZQXDCC
         /866pWYPhmN+j+E57meWMHjYhm3eAzbyMDhndecQlgvCfGJwyFaMiyKoo1dMyM0DPi
         cAV6WIXDxBcrWWzTj/4T2OrgyF1cw6Mr4MSJtS2f4ady0J+KN+pasyLhs2V/lrmt91
         US9YLLtw3CBTW6Lt3z9zbH+xocA0Szt/WH2yWQLGx3MMdnksfNe83OtjzuSaYWobjo
         fmbQxzYdoIKqwV0KFvzbgsIMmQCU/NG/KB6vulFooOcPbx9VC5Kp90o0L7R4cCgcpw
         DPvjF/Qyu7hCg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJj-9V; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Hannu Hartikainen <hannu@hrtk.in>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/23] Documentation/process: fix a cross reference
Date:   Tue, 19 Oct 2021 09:04:18 +0100
Message-Id: <5a34d27bb99b880579db8d1aafbe4d97705affd5.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cross-reference for the handbooks section works. However, it is
meant to describe the path inside the Kernel's doc where the section
is, but there's an space instead of a dash, plus it lacks the .rst at
the end, which makes:

	./scripts/documentation-file-ref-check

to complain.

Fixes: 604370e106cc ("Documentation/process: Add maintainer handbooks section")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 Documentation/process/submitting-patches.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index b0f31aa82fcd..22d876eda6ef 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -22,8 +22,8 @@ use it, it will make your life as a kernel developer and in general much
 easier.
 
 Some subsystems and maintainer trees have additional information about
-their workflow and expectations, see :ref:`Documentation/process/maintainer
-handbooks <maintainer_handbooks_main>`.
+their workflow and expectations, see
+:ref:`Documentation/process/maintainer-handbooks.rst <maintainer_handbooks_main>`.
 
 Obtain a current source tree
 ----------------------------
-- 
2.31.1

