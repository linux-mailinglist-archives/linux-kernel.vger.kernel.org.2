Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD84F4531E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhKPMOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235896AbhKPMOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:14:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1B8E61B3D;
        Tue, 16 Nov 2021 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637064686;
        bh=3+EhTIUfEc1VH5uixDDqkGJAXlgO8/E7oFMAmXUNQ6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmnXcSw9GafJu8rPcR4xfJLerj1gz+Rba+SEKfcRsQzFDSmst402cDzZrmRUEGzKu
         g0HKln+6+jyGF8TUs762ev+JMnwLVIb/fncr7kcZg3NS/BMFCjuC4MbI3g/wrNCSLG
         rbS7yQhmYvDiU3KuXHyJm0i9DWJd7DYjYGK2UBLZ3UpmlFmvYtlIJOG6/EFO3/vlgl
         q7UvoKl1TrF8njc18EmjAD2QhU4s1n3xlRIs0Ll99ifsffp8c56e0ceCkUuYYmGQYu
         4xkwm0DYrLeGgT528VRMa9Az2WCpg9RzM6V1n88ojwBNm2+G9Y+QRsBuNMnPJGYIyg
         wWFua4dJFgYwA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mmxJ6-00A9La-Cv; Tue, 16 Nov 2021 12:11:24 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Hannu Hartikainen <hannu@hrtk.in>,
        Jakub Kicinski <kuba@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Documentation/process: fix a cross reference
Date:   Tue, 16 Nov 2021 12:11:23 +0000
Message-Id: <f03c43389f024751e1056c54e240bef64ac4b2ed.1637064577.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637064577.git.mchehab+huawei@kernel.org>
References: <cover.1637064577.git.mchehab+huawei@kernel.org>
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
See [PATCH 0/4] at: https://lore.kernel.org/all/cover.1637064577.git.mchehab+huawei@kernel.org/

 Documentation/process/submitting-patches.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index a0cc96923ea7..da085d63af9b 100644
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
2.33.1

