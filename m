Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8537AA16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhEKPCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhEKPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7471861363;
        Tue, 11 May 2021 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620745297;
        bh=ql3fH9YF+Tp5Cdc+ks9xGMNWAcomJ3IyUAsw5MhHPbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHtpyBNisnriqDe3uxmTK4KqCU2B5H7tfIvgqTFnV5/kA9l3mKN0afwMpfL2kI/rU
         nGkSaAC+U0T6sEfgOrtaQ2BeP6+KaBG4kE3B72Nf4UsnFsrgTSFVwOGQWfm7EB7ovM
         OQj0Zr+dOQe+OUtonQA2G4pDnllcJfXJks2u5IpwtwQ7lcBOMw1v9PHjRcgmhIdWKz
         GThl4CTzJ1+DPXPxTmjyAJtQ3N7vkNJ30QoqAI1TXSh7xpUyueu/CWbyz/d/P25VRU
         DnRT6FaHWGBd+/Z7iPOoV7IJSi34QYez8Amfg7fYWqjaE0pgRrkoXXgtSS6gdcj0+S
         k15XVMB3dIlsg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgTt7-000k18-T5; Tue, 11 May 2021 17:01:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] docs: ABI: remove some spurious characters
Date:   Tue, 11 May 2021 17:01:30 +0200
Message-Id: <6d774ad6cb3795a177309503a39f8f1b5e309d64.1620744606.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620744606.git.mchehab+huawei@kernel.org>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KernelVersion tag contains some spurious UTF-8 characters
for no reason. Drop them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-module | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index a485434d2a0f..88bddf192ceb 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -37,13 +37,13 @@ Description:	Maximum time allowed for periodic transfers per microframe (μs)
 
 What:		/sys/module/*/{coresize,initsize}
 Date:		Jan 2012
-KernelVersion:»·3.3
+KernelVersion:	3.3
 Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Module size in bytes.
 
 What:		/sys/module/*/taint
 Date:		Jan 2012
-KernelVersion:»·3.3
+KernelVersion:	3.3
 Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Module taint flags:
 			==  =====================
-- 
2.30.2

