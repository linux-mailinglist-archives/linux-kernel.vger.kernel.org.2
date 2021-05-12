Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891EB37BD67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhELMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhELMxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7E7361454;
        Wed, 12 May 2021 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823907;
        bh=VpLsYBUyxDPAUDeiKOZVygRyVEGODhV1GMIGsuEHRw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4ErpNmWuXPXwpYmM0WD3X3ndNvX6sdaPHNGfQox7AganJxqVD8ocW4BEWnv4nmKn
         XJTJvPp6CoXKohvw2txq7Ia6t/6Duy85XYaH/SZss+4lvjGHh1A4W8cBE2HCEdW1ee
         28A2w8PErov9IzB9E6gHlP5wEmnyox03kNDKNZPVItCOsZbxIwMWlQHfwQQJ2Xe+7F
         NTY9V12DhSzXMyj49d1frFU3PmSdOTt1aqVQpo2jziGcr9mQw+9kYpS64xhA9Hnmto
         jmeXAwbSkKb2RT1erWYvNYfiRiE3lArGVMEqCqnhfDdLkvviVtfgCdVp1XDan0twvu
         t9JgY28eMeI7A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoL3-0018nT-IX; Wed, 12 May 2021 14:51:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 32/40] docs: gpu: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:36 +0200
Message-Id: <2edfac4e4081d531f039cbebd9545789ebdcca6c.1620823573.git.mchehab+huawei@kernel.org>
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

Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/gpu/i915.rst       | 2 +-
 Documentation/gpu/komeda-kms.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 486c720f3890..2cbf54460b48 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -361,7 +361,7 @@ Locking Guidelines
 	  real bad.
 
 #. Do not nest different lru/memory manager locks within each other.
-   Take them in turn to update memory allocations, relying on the object’s
+   Take them in turn to update memory allocations, relying on the object's
    dma_resv ww_mutex to serialize against other operations.
 
 #. The suggestion for lru/memory managers locks is that they are small
diff --git a/Documentation/gpu/komeda-kms.rst b/Documentation/gpu/komeda-kms.rst
index eb693c857e2d..c2067678e92c 100644
--- a/Documentation/gpu/komeda-kms.rst
+++ b/Documentation/gpu/komeda-kms.rst
@@ -324,7 +324,7 @@ the control-abilites of device.
 
 We have &komeda_dev, &komeda_pipeline, &komeda_component. Now fill devices with
 pipelines. Since komeda is not for D71 only but also intended for later products,
-of course we’d better share as much as possible between different products. To
+of course we'd better share as much as possible between different products. To
 achieve this, split the komeda device into two layers: CORE and CHIP.
 
 -   CORE: for common features and capabilities handling.
-- 
2.30.2

