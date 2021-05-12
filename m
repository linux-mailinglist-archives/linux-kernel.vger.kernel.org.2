Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EBB37BD40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhELMxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231311AbhELMww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 674E361428;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=bW1V1RS0uCd5qekrUEbI+REXkBN1xgkUq0jrb4qKg2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqDRxWr9NAB0GEHXE7d5bz7ZP7GMtDCoDsKtr8ckvUGuUp+y2haFw5pHZdO/Lw+lj
         YpvumptQTi4YafjbSkPx8Q8QoW4NZQGbK0S6cEKSDo4z1ZNHg/LYrklGocQl4Ua+Kd
         +aq2WceKqdOKsjf7WZzoU4hz8KR4x8SKx33su0NON7IISrVQLknHcsaQLXr4bHGII4
         mYC0gwh6ntvpLX8i8SJHCFlvZhhC0hlusRBZOY2gvfO2wXsl4sAdiGudXEbIGXYrn5
         wXG2xdZajYacikVKWCimyqlpbnmIXhWdQnIfebPbP7oFrlxBar7nG56WLB/cPbKxf6
         HIZfOF/LA9MLg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018hd-I9; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/40] docs: process: code-of-conduct.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:17 +0200
Message-Id: <5ce150c26d95a6d2e8c496a446fddc48ea382e3a.1620823573.git.mchehab+huawei@kernel.org>
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
 Documentation/process/code-of-conduct.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index be50294aebd5..2060834b9cee 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -32,7 +32,7 @@ Examples of unacceptable behavior by participants include:
   advances
 * Trolling, insulting/derogatory comments, and personal or political attacks
 * Public or private harassment
-* Publishing others’ private information, such as a physical or electronic
+* Publishing others' private information, such as a physical or electronic
   address, without explicit permission
 * Other conduct which could reasonably be considered inappropriate in a
   professional setting
-- 
2.30.2

