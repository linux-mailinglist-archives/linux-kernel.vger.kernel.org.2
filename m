Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0573B37BCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhELMw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhELMwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2272D61026;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=4ofQsASU/MTwLwGKXLy4pALcxYirc0LvzC8mUKPB/jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehzI2dkTGNdt5gGWNwWX6aEbUWTKTcHsHA94sroT8TDjUq/Q3pkOpjXDQv+s4Yi/s
         PBHz9zWgtT4LkxetufTeN1UleiUQD/OEl5xiI2fCXEZa9/yG805RxRe76wtalNjJUy
         GHUCgCdyu+0OsC3NIfKKKTcaaH+kBE8g0Zdz1ZUZl8ZGQNOyYYLKIUk3NqN/JeyJtW
         m7G2j4ROxj7snXxIU1NczZuchYo/F5ypGxi2gGbX2mrI0+rBWUsyiWaFi9OY8+KpUk
         k6aDYvX9D1L/hEACwIfirnbguoAcMprcG+OjFdB3vZ9z3ZCUJwE7Lcm/wmhS8+KYFY
         Cb64hvbzq4zAQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018h3-78; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/40] docs: admin-guide: perf: imx-ddr.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:08 +0200
Message-Id: <b892deb6bff0d0781dac0d7a49aff38cd5d5f031.1620823573.git.mchehab+huawei@kernel.org>
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

	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/perf/imx-ddr.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf/imx-ddr.rst b/Documentation/admin-guide/perf/imx-ddr.rst
index 90926d0fb8ec..269d0b564903 100644
--- a/Documentation/admin-guide/perf/imx-ddr.rst
+++ b/Documentation/admin-guide/perf/imx-ddr.rst
@@ -9,7 +9,7 @@ control register which causes a large number of PERF signals to be generated.
 
 Selection of the value for each counter is done via the config registers. There
 is one register for each counter. Counter 0 is special in that it always counts
-“time” and when expired causes a lock on itself and the other counters and an
+"time" and when expired causes a lock on itself and the other counters and an
 interrupt is raised. If any other counter overflows, it continues counting, and
 no interrupt is raised.
 
-- 
2.30.2

