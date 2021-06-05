Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1839C89B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFENUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhFENU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 979F461418;
        Sat,  5 Jun 2021 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899117;
        bh=xcfRrSbIcqTm3T+UKP24MyVZeyMtewq5A8yaR3rp+m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgWK6sJKud42d9RnPIJfJm2jWlCo2BXcLWVAWMQ+ig6xWYD92FUt8z9dtoh8M26k4
         9POZUiPwieCSOGhvUaOco0fXW5GIRntA6HqI/4takQGEdIDSh0tK68prjfq0hHzQrd
         0NyoKq9eunNFgwBRnRb3FojD5JbHjZZmcA4p1VNPTPy4FagNpMLvy5CT6eV7mY1lOK
         Wc02weXpe4L0XA5FL0bckbSN0Hu42EWVVeXKlog+mOF2VRG/BE0u6NTjrw0bBc5dAi
         JaQiEDZL9JJw+gb5VMiWe2jppCr/ALcb2WoRcS4Lp/Vu313ekhhUI/+BDac6UxWds3
         yO7nk+roaqrZg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCB-008GEz-Jf; Sat, 05 Jun 2021 15:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/34] docs: admin-guide: hw-vuln: avoid using ReST :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:07 +0200
Message-Id: <8624b461dda80606e9f0e48701e070f1509fad94.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
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
 .../hw-vuln/special-register-buffer-data-sampling.rst          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
index 3b1ce68d2456..966c9b3296ea 100644
--- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
@@ -3,7 +3,8 @@
 SRBDS - Special Register Buffer Data Sampling
 =============================================
 
-SRBDS is a hardware vulnerability that allows MDS :doc:`mds` techniques to
+SRBDS is a hardware vulnerability that allows MDS
+Documentation/admin-guide/hw-vuln/mds.rst techniques to
 infer values returned from special register accesses.  Special register
 accesses are accesses to off core registers.  According to Intel's evaluation,
 the special register reads that have a security expectation of privacy are
-- 
2.31.1

