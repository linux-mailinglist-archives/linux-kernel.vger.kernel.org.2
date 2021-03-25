Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3BE349743
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCYQsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:48:02 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:36538 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhCYQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:47:36 -0400
Received: by mail-io1-f41.google.com with SMTP id f19so2571477ion.3;
        Thu, 25 Mar 2021 09:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGVgOlWWlf7S8lKrv2KpxPAfeld5uIAqgdnxqJDADHQ=;
        b=h172az+ji3DfI/JM5AGf2215bFOoNsTKWgbP+y1ByBMNCKV/hiv8UXqkcPEiu9LAUs
         ce51MrHe80HPGQw4Nd8Otl3qu2wOFZ2tT3ydcwIY+Sfe0ng07L5YaDxUfB7T3irMf1Bp
         0jlL7XIa3/kagqIoBntC6Gh9gxwQea9/PBW0gZNDL58ozGgopNiP5gEaMTdjmWDh4QtY
         GaTo26Q8LUaVOaYfoTBd3ZI08TteJpO7p2LZPR02FbjmaD0PYEIG5hKAwkLFrdW6kGVF
         MgBEUx5JRa2bZNgh3ENR8umbxlYY8iiQdrJIcupg/FLh6iDOPqlRJmqlzW+54d0KdLps
         H68g==
X-Gm-Message-State: AOAM533fXCFJO8/RbEDUbAF30L8EwEkNodoGQx431odvnq0goyw3rHDM
        owLY4I1o8AKEsT7sWeBn5ruhbpe76g==
X-Google-Smtp-Source: ABdhPJzpLAFK+1nJqt6a0/fo6AZZseElktiS83A1EJR3ptEoBY4O4ZHiNOhVnOFOTuKmqdxzLAyqHw==
X-Received: by 2002:a5e:8d09:: with SMTP id m9mr6902992ioj.29.1616690854878;
        Thu, 25 Mar 2021 09:47:34 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id h13sm2868615ila.82.2021.03.25.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:47:32 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 4/8] docs: dt: Make 'Devicetree' wording more consistent
Date:   Thu, 25 Mar 2021 10:47:09 -0600
Message-Id: <20210325164713.1296407-5-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325164713.1296407-1-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a variety of ways 'Devicetree' has been written. This is most
evident in the documentation build contents where we have 'Device Tree',
'DeviceTree', etc. The DT spec has somewhat standardized on
'Devicetree', so let's use that.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
 Documentation/devicetree/changesets.rst                  | 8 ++++----
 Documentation/devicetree/dynamic-resolution-notes.rst    | 8 ++++----
 Documentation/devicetree/index.rst                       | 2 +-
 Documentation/devicetree/of_unittest.rst                 | 6 +++---
 Documentation/devicetree/overlay-notes.rst               | 8 ++++----
 Documentation/devicetree/usage-model.rst                 | 8 ++++----
 Documentation/devicetree/writing-schema.rst              | 2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index 42e86f978be2..51c459909575 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ==========================================
-Submitting devicetree (DT) binding patches
+Submitting Devicetree (DT) binding patches
 ==========================================
 
 I. For patch submitters
diff --git a/Documentation/devicetree/changesets.rst b/Documentation/devicetree/changesets.rst
index c7fd8cd6a270..2091468d4837 100644
--- a/Documentation/devicetree/changesets.rst
+++ b/Documentation/devicetree/changesets.rst
@@ -1,10 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=============
-DT Changesets
-=============
+=====================
+Devicetree Changesets
+=====================
 
-A DT changeset is a method which allows one to apply changes
+A Devicetree changeset is a method which allows one to apply changes
 in the live tree in such a way that either the full set of changes
 will be applied, or none of them will be. If an error occurs partway
 through applying the changeset, then the tree will be rolled back to the
diff --git a/Documentation/devicetree/dynamic-resolution-notes.rst b/Documentation/devicetree/dynamic-resolution-notes.rst
index 570b7e1f39eb..f81ad8daa36f 100644
--- a/Documentation/devicetree/dynamic-resolution-notes.rst
+++ b/Documentation/devicetree/dynamic-resolution-notes.rst
@@ -1,11 +1,11 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==================================
-Device Tree Dynamic Resolver Notes
-==================================
+=================================
+Devicetree Dynamic Resolver Notes
+=================================
 
 This document describes the implementation of the in-kernel
-Device Tree resolver, residing in drivers/of/resolver.c
+DeviceTree resolver, residing in drivers/of/resolver.c
 
 How the resolver works
 ----------------------
diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index 54026763916d..32509e8de8da 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =============================
-Open Firmware and Device Tree
+Open Firmware and Devicetree
 =============================
 
 .. toctree::
diff --git a/Documentation/devicetree/of_unittest.rst b/Documentation/devicetree/of_unittest.rst
index dea05214f3ad..2afe41a37148 100644
--- a/Documentation/devicetree/of_unittest.rst
+++ b/Documentation/devicetree/of_unittest.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==================================
-Open Firmware Device Tree Unittest
-==================================
+=================================
+Open Firmware Devicetree Unittest
+=================================
 
 Author: Gaurav Minocha <gaurav.minocha.os@gmail.com>
 
diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
index c67cc676bbd2..b2b8db765b8c 100644
--- a/Documentation/devicetree/overlay-notes.rst
+++ b/Documentation/devicetree/overlay-notes.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=========================
-Device Tree Overlay Notes
-=========================
+========================
+Devicetree Overlay Notes
+========================
 
 This document describes the implementation of the in-kernel
 device tree overlay functionality residing in drivers/of/overlay.c and is a
@@ -11,7 +11,7 @@ companion document to Documentation/devicetree/dynamic-resolution-notes.rst[1]
 How overlays work
 -----------------
 
-A Device Tree's overlay purpose is to modify the kernel's live tree, and
+A Devicetree's overlay purpose is to modify the kernel's live tree, and
 have the modification affecting the state of the kernel in a way that
 is reflecting the changes.
 Since the kernel mainly deals with devices, any new device node that result
diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
index 1eb83496ca1e..b6a287955ee5 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=========================
-Linux and the Device Tree
-=========================
+========================
+Linux and the Devicetree
+========================
 
 The Linux usage model for device tree data
 
@@ -14,7 +14,7 @@ at devicetree.org\ [1]_.
 
 .. [1] https://www.devicetree.org/specifications/
 
-The "Open Firmware Device Tree", or simply Device Tree (DT), is a data
+The "Open Firmware Device Tree", or simply Devicetree (DT), is a data
 structure and language for describing hardware.  More specifically, it
 is a description of hardware that is readable by an operating system
 so that the operating system doesn't need to hard code details of the
diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index be14dbed6081..23d6579aea2c 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-Writing DeviceTree Bindings in json-schema
+Writing Devicetree Bindings in json-schema
 ==========================================
 
 Devicetree bindings are written using json-schema vocabulary. Schema files are
-- 
2.27.0

