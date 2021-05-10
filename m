Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C0378329
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhEJKm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232554AbhEJKey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:34:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9326B61879;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642492;
        bh=QcbKsTLJrU0RWPxnRLf5O3Jw/W2H2LnsgdBvj+hAtbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktqacCeEeErAHYWCEMGb8UafPhmvtq/9u0LMBXHSVZPA1hKNyopTzwSVYxNvK2DeH
         DnqjKPnYo3Hv+OwAgNo3SXJZbru4M3GWn6YhGVVoUJBMbeB9PCAhjaVG9pdKYWqbMN
         f/E+O0llfhaatBuhDotjMRRXM6QygrcMZTVDj3nqr0FKzJxBHfWnJAZ2RBZBy54A1j
         ocR799LhJNCwcvlGjmjbduJTpa7gCWZwML1P5cTzlLMNzCBb0oDXule4sBQOfnxIWH
         PNKCtJvvwptxRauqkAgGuulB2ptvzubOOKPuk3CgyLa6niq6mFmEEpvOdoOz3dtm4l
         5tiQ7jh4eWQHA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UYG-Hb; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 48/53] docs: timers: no_hz.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:27:00 +0200
Message-Id: <1a9dd1734c482e154a0b9e26d9a3276503abaf91.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+feff ('﻿'): ZERO WIDTH NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/timers/no_hz.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index c4c70e1aada3..6cadad7c3aad 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -1,4 +1,4 @@
-﻿======================================
+======================================
 NO_HZ: Reducing Scheduling-Clock Ticks
 ======================================
 
-- 
2.30.2

