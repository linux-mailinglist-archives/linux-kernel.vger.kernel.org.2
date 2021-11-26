Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23A45EBF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhKZK4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239865AbhKZKyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:54:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55B8C61052;
        Fri, 26 Nov 2021 10:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637923857;
        bh=G3vMPca04ZK7HxL85YF0sdjtoWv7Xp9VblHZYnndAxk=;
        h=From:To:Cc:Subject:Date:From;
        b=JBuymLfdKV5IiF3m+BbdnNxs/+JfUTx1bG/Dgv+zCFL93+jKnIJI8l4EGVeg2QRPr
         mC8EpuW+N/QquKsypA1dCdcrCWhU+rmQIxHL2PcrzKDJ+U+SKq/1yU2MC/hs7oSSn4
         laH26vbwIJ4NFvYtIH6DComPtrAkNBkUynnCBy7q2x0CIXkXKGuJbJ0UVCpRFi23e8
         tRkTNRwKagK3Z+cu/+dSz+OvqIUEtNW+CZf3+UU1QXH64MjW3Z0fZDh58LGEL8kYHy
         ZrIhIMk+JmkU9HWIPFcXPBjhMB3/PCZmANZn379lQ6AxyjsnNrp2+wB4R3nU3vTK5h
         uJ6a0QH3sGnpA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mqYog-0003ta-5v; Fri, 26 Nov 2021 11:50:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Hans Verkuil" <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
Date:   Fri, 26 Nov 2021 11:50:53 +0100
Message-Id: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described at:
	https://stackoverflow.com/questions/23211695/modifying-content-width-of-the-sphinx-theme-read-the-docs

since Sphinx 1.8, the standard way to setup a custom theme is
to use html_css_files. While using html_context is OK with RTD
0.5.2, it doesn't work with 1.0.0, causing the theme to not load,
producing a very weird html.

Tested with:
	- Sphinx 2.4.4 + sphinx-rtd-theme 0.5.2
	- Sphinx 2.4.4 + sphinx-rtd-theme 1.0.0
	- Sphinx 4.3.0 + sphinx-rtd-theme 1.0.0

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 17f7cee56987..7bc72be63fd2 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -249,11 +249,16 @@ except ImportError:
 
 html_static_path = ['sphinx-static']
 
-html_context = {
-    'css_files': [
+if major <= 1 and (minor < 8):
+    html_context = {
+        'css_files': [
+            '_static/theme_overrides.css',
+        ],
+    }
+else:
+    html_css_files = [
         '_static/theme_overrides.css',
-    ],
-}
+    ]
 
 # Add any extra paths that contain custom files (such as robots.txt or
 # .htaccess) here, relative to this directory. These files are copied
-- 
2.33.1

