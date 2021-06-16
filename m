Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CBC3A9357
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhFPG5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231309AbhFPG5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0211F613BF;
        Wed, 16 Jun 2021 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623826518;
        bh=D3zFdOFBQ734SZ45tSNdikND8nbKTg1RO1R/H4WwiHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBfnEgSxtkmwNya+3LUHb17ShvI2y8dtsXZFtx/MMb7eh6LbpebsKQrp0j2DKelt/
         mMvLNdkLEVFIp9aHeLGDo3QRooR4WohZ9TrOdJup2Uvu1fchx8N4gLdf4pNLhC4AJ+
         uf59DHUwa5RLqIhkxqnaqHjXdi4GsYjjjBEnhCbsfEWu3Bhz4LCElYQ7stILgPfela
         O5uYSOQ6/IetOjf+o+mAIU9Uqb/BYypRS4mkKQ/wWqz8t1Tsjt58B/nNieltei812Q
         AGE/oUnDdYHLju0gbYdUHEsU58vTN760cD45RpgCRYCPaXw6NtKF8mGLxKfV1ZUOgh
         tdTiXxid6JgaQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltPSG-004lCJ-9Y; Wed, 16 Jun 2021 08:55:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] docs: trace: coresight: coresight-etm4x-reference.rst: replace some characters
Date:   Wed, 16 Jun 2021 08:55:08 +0200
Message-Id: <b6a04e881bc80a3c1d3d23ccbc8208ca3c9053fd.1623826294.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623826294.git.mchehab+huawei@kernel.org>
References: <cover.1623826294.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+00a0 (' '): NO-BREAK SPACE
	  as it can cause lines being truncated on PDF output

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/trace/coresight/coresight-etm4x-reference.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
index b64d9a9c79df..d25dfe86af9b 100644
--- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
+++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
@@ -427,7 +427,7 @@ the ‘TRC’ prefix.
 :Syntax:
     ``echo idx > vmid_idx``
 
-    Where idx <  numvmidc
+    Where idx <  numvmidc
 
 ----
 
-- 
2.31.1

