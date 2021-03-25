Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4698D349744
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCYQsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:48:05 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:42734 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhCYQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:47:38 -0400
Received: by mail-io1-f50.google.com with SMTP id r193so2540319ior.9;
        Thu, 25 Mar 2021 09:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7sJu5rhLqNCGvoHbFMmH4l9oipcNGbXw2wa6pIJXQE=;
        b=oGkshcRd+iNDJbkC6OGhVGaiA9AiHBfikpsdCpC+48JPh4UB88Httuk9+v5Lpba6fp
         czVAY6gYohz73pcL5Ny0mIAG+KFKQa3s5Wqmmu5Wn6EDy9uk+Mr8CE8tUawfPSxe+llu
         w6rDNPkAeXy4ZEaNgAX+frf8OljiID2Teeb33r5IRkSfqEcqH6lQp3p/mqZDD8A+EzOx
         xhPtgUi3v1BLDxO4jC3rKNIH7LWWOpboa4gHGAHKHnYiSZZD1+chlZu1MFAAXgZMrIDH
         +wkrDzchGy4+K0J3i+P0zedsiLdT2xXakRNisaet7qs4Gb2YcOH0pmfBZCdryVK/V8aa
         sZuA==
X-Gm-Message-State: AOAM532peCgj7hQbEoyWFtv1KRSbFwCqp6QPyIS97QoQW9ZAPACtE8GG
        IMViOMhJRYrAfmi0NuRdgR1TABC4mg==
X-Google-Smtp-Source: ABdhPJwBdKPGZz3rOFxiwyJpHLSrd4idMM3MwXzZq3c5b05sPqoUJvx4ayJqVAn2eD9w21Y8cvsYFA==
X-Received: by 2002:a5d:9659:: with SMTP id d25mr7345782ios.146.1616690857349;
        Thu, 25 Mar 2021 09:47:37 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id h13sm2868615ila.82.2021.03.25.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:47:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 5/8] docs: dt: Group DT docs into relevant sub-sections
Date:   Thu, 25 Mar 2021 10:47:10 -0600
Message-Id: <20210325164713.1296407-6-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325164713.1296407-1-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT docs are currently all just lumped together in the doc build.
Let's organize the documents by kernel specifics, overlays and bindings.

As writing-schema.rst is about bindings, let's move it to the bindings
directory.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/index.rst      |  7 ++-----
 .../devicetree/{ => bindings}/writing-schema.rst |  0
 Documentation/devicetree/index.rst               | 16 ++++++++++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/{ => bindings}/writing-schema.rst (100%)

diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
index 3837b17c234f..d9002a3a0abb 100644
--- a/Documentation/devicetree/bindings/index.rst
+++ b/Documentation/devicetree/bindings/index.rst
@@ -1,12 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-===========
-Device Tree
-===========
-
 .. toctree::
    :maxdepth: 1
 
    ABI
-   submitting-patches
    writing-bindings
+   writing-schema
+   submitting-patches
diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
similarity index 100%
rename from Documentation/devicetree/writing-schema.rst
rename to Documentation/devicetree/bindings/writing-schema.rst
diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index 32509e8de8da..70b5dcdbcf07 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -4,14 +4,26 @@
 Open Firmware and Devicetree
 =============================
 
+Kernel Devicetree Usage
+=======================
 .. toctree::
    :maxdepth: 1
 
    usage-model
-   writing-schema
+   of_unittest
+
+Devicetree Overlays
+===================
+.. toctree::
+   :maxdepth: 1
+
    changesets
    dynamic-resolution-notes
-   of_unittest
    overlay-notes
 
+Devicetree Bindings
+===================
+.. toctree::
+   :maxdepth: 1
+
    bindings/index
-- 
2.27.0

