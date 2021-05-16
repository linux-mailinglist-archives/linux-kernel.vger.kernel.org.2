Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C563A381E01
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhEPKU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhEPKTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7442F611BE;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=D3zFdOFBQ734SZ45tSNdikND8nbKTg1RO1R/H4WwiHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8b3WEyCXNpVAtA1kBwXxsaBXkC6cpOgCA7Gb4GBBsrleHqNDGH6BzoxhLDgKGZjh
         SdhECrO5D16uEmfsGxDIXBsrrAlkAaJPd8+whyY30IA3CRqQg9UtwOKeRUbN14eVyF
         kjYbxXUJZF2dQdLdWJutApLMq8I1K6aOeX7UH+43o9cyPh8tlEX57ftKWDPZZakIC1
         Dj9Sipfa6qpG8ovZ5zUVnoMQIXTLMZFJkreS4hBBtXHP5/GLWZkYYLtrATS+70rCCm
         da7kDKLK/e96E6Wn1T4JQuT+VM+nvhzAmK4Y1wrZOBs/d6HXnNgzAcSdRnZwM20X4m
         9akeu5kO8GXPQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o8I-9m; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/16] docs: trace: coresight: coresight-etm4x-reference.rst: replace some characters
Date:   Sun, 16 May 2021 12:18:20 +0200
Message-Id: <355f031f97f42c19e2dd1983409a199e649a1df7.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
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

