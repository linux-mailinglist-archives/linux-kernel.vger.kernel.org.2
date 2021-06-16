Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17DE3A9297
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhFPGbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231611AbhFPG3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F62061400;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=9+IwjkK9O4NibLgz3M7pCdhHS/M6MeKEeQDBWbnnZqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFnRs9ZTKF3/X/XE4/LGMzLixde3V13VBMFQGuc1CS68P6qS3HWgzLxkx0mVVL/sd
         n4lkrKZ9bn8IljgXb8irelZITvg555ZNkAsIVwx96/QMRjVfHig3h2fv49MQJioZSH
         eCf0tD2Qh6x7bl7c6htBvX+IHA9xN1fYLtwQAeqLKFVO6oMlgMNvz28NEzVbfQirK3
         AowGLBlXc3+mIQoKINwBkDsmlBE1SxlXECzr7oVjogCftkrzsQ48yjWDyFWeCrKYoH
         m7aDdlvFMri6k0/XaVucAOAjClMYKH4WQnRRvzBkGAo8sy07au+YeB8v/3+TQSOQ1J
         uZUC/tUjq5n5A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kJ0-D9; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/29] docs: devicetree: bindings: submitting-patches.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:26 +0200
Message-Id: <0048c23d47b582dd1a1959628fd2b895209ac826.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/submitting-patches.rst        | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index 104fa8fb2c17..8087780f1685 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -7,8 +7,8 @@ Submitting Devicetree (DT) binding patches
 I. For patch submitters
 =======================
 
-  0) Normal patch submission rules from Documentation/process/submitting-patches.rst
-     applies.
+  0) Normal patch submission rules from
+     Documentation/process/submitting-patches.rst applies.
 
   1) The Documentation/ and include/dt-bindings/ portion of the patch should
      be a separate patch. The preferred subject prefix for binding patches is::
@@ -25,8 +25,8 @@ I. For patch submitters
 
        make dt_binding_check
 
-     See Documentation/devicetree/bindings/writing-schema.rst for more details about
-     schema and tools setup.
+     See Documentation/devicetree/bindings/writing-schema.rst for more details
+     about schema and tools setup.
 
   3) DT binding files should be dual licensed. The preferred license tag is
      (GPL-2.0-only OR BSD-2-Clause).
@@ -84,7 +84,8 @@ II. For kernel maintainers
 III. Notes
 ==========
 
-  0) Please see :doc:`ABI` for details regarding devicetree ABI.
+  0) Please see Documentation/devicetree/bindings/ABI.rst for details
+     regarding devicetree ABI.
 
   1) This document is intended as a general familiarization with the process as
      decided at the 2013 Kernel Summit.  When in doubt, the current word of the
-- 
2.31.1

