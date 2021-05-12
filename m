Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1089337BD21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhELMxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhELMwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3844D613FC;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=tiztELb5VMV5JjRFGKumELNKo9NifoAHMsnm7x1qrik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtCTqWdHLRSvLn8qTI99Wk/oQLGQGPRapk0tVtcq7P0KQ4PvV6t4AxaVh+UHkOzER
         Eo+kXQn9Ph4fRlVSpdrmma2P6yrols4kffj6hDAGBtT+I9hc5zypcQiewLr3vzYWQH
         qZXlNQkbPJ6cANDOjdBrd7v1CJwRlPeQfERr0H3EMfztz/v1zHPouvJC1JxMNgwUkO
         l4ZO5hhrzRHaGw6T6b0K7NLqGQGhJZBLJHdFJs3msO1Sxb19QqYAtGycxlavhRfwBA
         +ZtFd/ejXA26g8eRpPb64fLctWzvlYvT6X2l3LijI4ongqd96hLiMVFRos/MvFYEqw
         iu3XUZmXDl0jA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018hR-DM; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/40] docs: driver-api: firmware: other_interfaces.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:14 +0200
Message-Id: <f0862a53e1f54aa3a18902e69316c98168d86bf8.1620823573.git.mchehab+huawei@kernel.org>
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

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/firmware/other_interfaces.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index b81794e0cfbb..6711b3572408 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -23,7 +23,7 @@ Exception Level 3 (EL3).
 
 The Intel Stratix10 SoC service layer provides an in kernel API for
 drivers to request access to the secure features. The requests are queued
-and processed one by one. ARM’s SMCCC is used to pass the execution
+and processed one by one. ARM's SMCCC is used to pass the execution
 of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-- 
2.30.2

