Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59D42037C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhJCSwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhJCSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:52:05 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BF9C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 11:50:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r9so16048754ile.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/g9IRQ0oMpAFsxMXU5KrqLiXvoZwE7jlG8cifYdh8w8=;
        b=V2J6d5YV6tO3MJLX/FJLZ1g2OKHp6jfXANis/6L9pAUY1SxApQed/iR2PSk/X9Z9BM
         7vF8ItVoitq5eTFAi6aWycTj5abC8S4h5KJpWKSdw6skUDVy0mJyAa91VbqSSWtDT4lX
         sgJptqY5GL8krvi9gwGKvK62372Xbt4H3tPqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/g9IRQ0oMpAFsxMXU5KrqLiXvoZwE7jlG8cifYdh8w8=;
        b=hm+Fu2UnlKBtlbNSY0skALJ2zf0KNso6gvlCnqWRW5WzCCRYdu5GU1losF57AuEBlT
         5wqK0CbpkAVj5fhIf39Y+qJvIW0lq94Bb0NQ7llG6FSfLbNTHFxKWL+HJCAr1tMYMxGs
         PCjAhHMjMULAdH2/A18vD2jXIt/KQCIdEql1atDWq4fhFwTgJfX1e6UgA7/dEonl9yEI
         y6wKRtmiPeU5p7GkMEClKodFcpdavKV7BhBvxqA34mbfsdf+fbimVUebUGmIgIdz1BJp
         ZSxqaA24hHDRx6cdMQpXibnqHkHFJSOzcnHuZz4OYoYu65stsxeolMjtwheRvp01OJYT
         GJaw==
X-Gm-Message-State: AOAM533cFBqBKrzAUPxAfBuswykmtt6sM6rkbq4pvyWPLEanZ/MNouUH
        XAyB6c/c1ky+EnufXY2ctWCliA==
X-Google-Smtp-Source: ABdhPJyMZgAXsNfm8lJHXv2Cdt+VA2LHzESHPN7d8rXdEv6SIoRxCXW1T1kS8sYap09iOH5c43zyJw==
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr6775611ilu.201.1633287017336;
        Sun, 03 Oct 2021 11:50:17 -0700 (PDT)
Received: from kiwi.bld.corp.google.com (c-67-190-101-114.hsd1.co.comcast.net. [67.190.101.114])
        by smtp.gmail.com with ESMTPSA id h23sm8192612ila.32.2021.10.03.11.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 11:50:16 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs: dt: Fix a few grammar nits in the binding/schema docs
Date:   Sun,  3 Oct 2021 12:50:06 -0600
Message-Id: <20211003124936.1.Idc7beddc77250bca0cfb5912b56be719d9073bc4@changeid>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing hyphens and reword one sentence for clarity.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../devicetree/bindings/example-schema.yaml   | 14 ++++-----
 .../devicetree/bindings/writing-bindings.rst  |  2 +-
 .../devicetree/bindings/writing-schema.rst    | 29 ++++++++++---------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index ff6ec65145cf13..c078796ae1b556 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -119,7 +119,7 @@ properties:
     # valid for this binding.
 
   clock-frequency:
-    # The type is set in the core schema. Per device schema only need to set
+    # The type is set in the core schema. Per-device schema only need to set
     # constraints on the possible values.
     minimum: 100
     maximum: 400000
@@ -133,24 +133,24 @@ properties:
   # *-supply is always a single phandle, so nothing more to define.
   foo-supply: true
 
-  # Vendor specific properties
+  # Vendor-specific properties
   #
-  # Vendor specific properties have slightly different schema requirements than
+  # Vendor-specific properties have slightly different schema requirements than
   # common properties. They must have at least a type definition and
   # 'description'.
   vendor,int-property:
-    description: Vendor specific properties must have a description
+    description: Vendor-specific properties must have a description
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [2, 4, 6, 8, 10]
 
   vendor,bool-property:
-    description: Vendor specific properties must have a description. Boolean
+    description: Vendor-specific properties must have a description. Boolean
       properties are one case where the json-schema 'type' keyword can be used
       directly.
     type: boolean
 
   vendor,string-array-property:
-    description: Vendor specific properties should reference a type in the
+    description: Vendor-specific properties should reference a type in the
       core schema.
     $ref: /schemas/types.yaml#/definitions/string-array
     items:
@@ -158,7 +158,7 @@ properties:
       - enum: [baz, boo]
 
   vendor,property-in-standard-units-microvolt:
-    description: Vendor specific properties having a standard unit suffix
+    description: Vendor-specific properties having a standard unit suffix
       don't need a type.
     enum: [ 100, 200, 300 ]
 
diff --git a/Documentation/devicetree/bindings/writing-bindings.rst b/Documentation/devicetree/bindings/writing-bindings.rst
index f7dfb98c156ee5..18d9e0689d4993 100644
--- a/Documentation/devicetree/bindings/writing-bindings.rst
+++ b/Documentation/devicetree/bindings/writing-bindings.rst
@@ -44,7 +44,7 @@ Properties
   of prior implementations. DO add new compatibles in case there are new
   features or bugs.
 
-- DO use a vendor prefix on device specific property names. Consider if
+- DO use a vendor prefix on device-specific property names. Consider if
   properties could be common among devices of the same class. Check other
   existing bindings for similar devices.
 
diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 23d6579aea2c26..ea21c72aeb37a6 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -4,7 +4,7 @@ Writing Devicetree Bindings in json-schema
 ==========================================
 
 Devicetree bindings are written using json-schema vocabulary. Schema files are
-written in a JSON compatible subset of YAML. YAML is used instead of JSON as it
+written in a JSON-compatible subset of YAML. YAML is used instead of JSON as it
 is considered more human readable and has some advantages such as allowing
 comments (Prefixed with '#').
 
@@ -22,16 +22,16 @@ $id
   URI typically containing the binding's filename and path. For DT schema, it must
   begin with "http://devicetree.org/schemas/". The URL is used in constructing
   references to other files specified in schema "$ref" properties. A $ref value
-  with a leading '/' will have the hostname prepended. A $ref value a relative
-  path or filename only will be prepended with the hostname and path components
-  of the current schema file's '$id' value. A URL is used even for local files,
-  but there may not actually be files present at those locations.
+  with a leading '/' will have the hostname prepended. A $ref value with only a
+  relative path or filename will be prepended with the hostname and path
+  components of the current schema file's '$id' value. A URL is used even for
+  local files, but there may not actually be files present at those locations.
 
 $schema
   Indicates the meta-schema the schema file adheres to.
 
 title
-  A one line description on the contents of the binding schema.
+  A one-line description on the contents of the binding schema.
 
 maintainers
   A DT specific property. Contains a list of email address(es)
@@ -45,8 +45,8 @@ description
 
 select
   Optional. A json-schema used to match nodes for applying the
-  schema. By default without 'select', nodes are matched against their possible
-  compatible string values or node name. Most bindings should not need select.
+  schema. By default, without 'select', nodes are matched against their possible
+  compatible-string values or node name. Most bindings should not need select.
 
 allOf
   Optional. A list of other schemas to include. This is used to
@@ -56,7 +56,8 @@ allOf
 properties
   A set of sub-schema defining all the DT properties for the
   binding. The exact schema syntax depends on whether properties are known,
-  common properties (e.g. 'interrupts') or are binding/vendor specific properties.
+  common properties (e.g. 'interrupts') or are binding/vendor-specific
+  properties.
 
 A property can also define a child DT node with child properties defined
 under it.
@@ -81,23 +82,23 @@ Property Schema
 
 The 'properties' section of the schema contains all the DT properties for a
 binding. Each property contains a set of constraints using json-schema
-vocabulary for that property. The properties schemas are what is used for
+vocabulary for that property. The properties schemas are what are used for
 validation of DT files.
 
-For common properties, only additional constraints not covered by the common
+For common properties, only additional constraints not covered by the common,
 binding schema need to be defined such as how many values are valid or what
 possible values are valid.
 
-Vendor specific properties will typically need more detailed schema. With the
+Vendor-specific properties will typically need more detailed schema. With the
 exception of boolean properties, they should have a reference to a type in
 schemas/types.yaml. A "description" property is always required.
 
-The Devicetree schemas don't exactly match the YAML encoded DT data produced by
+The Devicetree schemas don't exactly match the YAML-encoded DT data produced by
 dtc. They are simplified to make them more compact and avoid a bunch of
 boilerplate. The tools process the schema files to produce the final schema for
 validation. There are currently 2 transformations the tools perform.
 
-The default for arrays in json-schema is they are variable sized and allow more
+The default for arrays in json-schema is they are variable-sized and allow more
 entries than explicitly defined. This can be restricted by defining 'minItems',
 'maxItems', and 'additionalItems'. However, for DeviceTree Schemas, a fixed
 size is desired in most cases, so these properties are added based on the
-- 
2.33.0.800.g4c38ced690-goog

