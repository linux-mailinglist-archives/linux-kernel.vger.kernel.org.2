Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7B45FD8A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 10:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbhK0JUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 04:20:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39284 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350113AbhK0JSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 04:18:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF53A60AB1;
        Sat, 27 Nov 2021 09:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D46BC53FAD;
        Sat, 27 Nov 2021 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638004493;
        bh=mQdG7NJf5KRZEMd6ciTe3dwMcQC3Grd9Hw3yekFq5zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOOy2J70gRTk1lnxNGOWBIjQYYTup7XtU3Wel6CnqScFXnMiyzJhHdhHyEaj7vhaD
         CpN4gWYRdhiS8H+1CCgyn9iLiL0BmiGtqmLPtZr0sN3rw7FV5KheiXDjbxzUT2x+KA
         fbiJO6d2kBE/RAGpnc/0cha+7bK+Y/jwubiKAUkDaoXG2QEC2f8sYiMXbPSPu4PvXw
         KoWsAOZy1fm7HPepRiEFkggBW6V5nY7Mf1V4rSSuQ5lFfCalqX26rvUZ2XvDY1NNNV
         Ngsoh1AHES5ZskICG/wM5YYg3vCsxI6SrbrxXGzerpuh+3L4KO7U4RcxgirtL8warN
         Y98d9CV9knFVw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mqtnG-0002cb-Q4; Sat, 27 Nov 2021 10:14:50 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Hans Verkuil" <hverkuil@xs4all.nl>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] docs: conf.py: fix support for Readthedocs v 1.0.0
Date:   Sat, 27 Nov 2021 10:14:49 +0100
Message-Id: <80009f0d17ea0840d81e7e16fff6e7677919fdfc.1638004294.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638004294.git.mchehab+huawei@kernel.org>
References: <cover.1638004294.git.mchehab+huawei@kernel.org>
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
	- Sphinx 1.7.9 + sphinx-rtd-theme 0.5.2
	- Sphinx 2.4.4 + sphinx-rtd-theme 0.5.2
	- Sphinx 2.4.4 + sphinx-rtd-theme 1.0.0
	- Sphinx 4.3.0 + sphinx-rtd-theme 1.0.0

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Tested-by: Hans Verkuil <hverkuil@xs4all.nl>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/1] at: https://lore.kernel.org/all/cover.1638004294.git.mchehab+huawei@kernel.org/

 Documentation/conf.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 17f7cee56987..76e5eb5cb62b 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -249,11 +249,16 @@ except ImportError:
 
 html_static_path = ['sphinx-static']
 
-html_context = {
-    'css_files': [
-        '_static/theme_overrides.css',
-    ],
-}
+html_css_files = [
+    'theme_overrides.css',
+]
+
+if major <= 1 and minor < 8:
+    html_context = {
+        'css_files': [
+            '_static/theme_overrides.css',
+        ],
+    }
 
 # Add any extra paths that contain custom files (such as robots.txt or
 # .htaccess) here, relative to this directory. These files are copied
-- 
2.33.1

