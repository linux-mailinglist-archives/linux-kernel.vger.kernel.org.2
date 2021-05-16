Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD7381DEC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhEPKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhEPKTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6057E61186;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=qVFGdhd3RiCLKZC/IOh05kkJiYS3/3QY2KmfYni5bpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/7sVgVIVeenpgtXM22PmERbNqbaDsKooEGPYO0m5ikUTRVKTL2BDrtrGchDtjVEA
         xf5fwYSOAs0KjC/atkJAifDHesl1iYk/Yw3EoDKfSnX5IKarXzGB2t4NN3qCyetwtO
         jEfMPX5rIe5udRbT+e4XqHvOqo08I/NxfxKhFIZ3g596fqk/wgeMyJNpF+pWps+BEY
         MSzapuhr0asw5a5mpxytW3bJanK3t0cYuAeqY0absTQHa+FIL/V+WJOEJeoT9bRRT5
         r6bSP6ZuiYsufgF5FLkMPsYJI2R5bkowoQMxJmwEBD4UPjzNJI13Hbxuxr1z/VeVtg
         sSzHxaBzK4c1A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o8F-8O; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/16] docs: admin-guide: reporting-issues.rst: replace some characters
Date:   Sun, 16 May 2021 12:18:19 +0200
Message-Id: <5625907ed95964321c39a8688b70c54bac6d8e95.1621159997.git.mchehab+huawei@kernel.org>
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
 Documentation/admin-guide/reporting-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 18d8e25ba9df..d7ac13f789cc 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -1248,7 +1248,7 @@ paragraph makes the severeness obvious.
 
 In case you performed a successful bisection, use the title of the change that
 introduced the regression as the second part of your subject. Make the report
-also mention the commit id of the culprit. In case of an unsuccessful bisection,
+also mention the commit id of the culprit. In case of an unsuccessful bisection,
 make your report mention the latest tested version that's working fine (say 5.7)
 and the oldest where the issue occurs (say 5.8-rc1).
 
-- 
2.31.1

