Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DD37BD62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhELMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhELMxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BAB161584;
        Wed, 12 May 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823903;
        bh=ejiB+UWymQa1W+uDq7gSHwijTlvt5QhzfdCJAzX0GHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIYp5ItZkYS8mzagQTW5qnRSBYZO/qEime7xrxULzwqMS/zslIaqWSGlCh9SOrsl4
         WppN1kZYVKca5kYnBBvR6aoCDXqcK191E5NEpDvAYg5O00d74oi4pXOjwzYEgmc7W4
         i20Lr2WICaStaPwE6A7mYI46SMUAbvF1Y0l1zNZCLqF7rQIQA5JR/EMENWoWlLa+BF
         K+leeBs5hKT4+WGkj/pEf8/65t5Xfeh8mStpOz4YE84X2XgV+gKTqiMhYqv46XnviJ
         5EO/n8aeZO7f1H+PiAd0v05GKk14m3FOydA/+yc2Y/1nFUNK09BhG/G+dCR0BwGzBq
         ICuT8HU0H7jGA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKz-0018ic-95; Wed, 12 May 2021 14:51:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/40] docs: scheduler: sched-deadline.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:32 +0200
Message-Id: <730dba19074ce5bc761232a3421b8b933252b262.1620823573.git.mchehab+huawei@kernel.org>
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

	- U+2212 ('−'): MINUS SIGN

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scheduler/sched-deadline.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9d9be52f221a..657ffb04b4d6 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -359,7 +359,7 @@ Deadline Task Scheduling
  More precisely, it can be proven that using a global EDF scheduler the
  maximum tardiness of each task is smaller or equal than
 
-	((M − 1) · WCET_max − WCET_min)/(M − (M − 2) · U_max) + WCET_max
+	((M - 1) · WCET_max - WCET_min)/(M - (M - 2) · U_max) + WCET_max
 
  where WCET_max = max{WCET_i} is the maximum WCET, WCET_min=min{WCET_i}
  is the minimum WCET, and U_max = max{WCET_i/P_i} is the maximum
-- 
2.30.2

