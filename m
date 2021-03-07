Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2168F32FE7F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 04:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhCGDM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 22:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCGDMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 22:12:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B00EC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 19:12:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so1260741pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 19:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiRhle4TTum29WBndw3nlIp4Qv2NDLxbnTie42IDOu4=;
        b=NmPk+Kxg1z7kuzVBw3tqljeRtZKghfrQkQc54IbKIUjCljpfFAoNUe6EED0099ejIT
         axeNugqurE27yihRz7oj6uWLk7iiLVvsJko9xYVMDv7dDcGhFwq3IfNehPGbyqiBydWV
         qPz6qOd/AZY3BUYULTpuQ9AyQLI5irCodk7gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiRhle4TTum29WBndw3nlIp4Qv2NDLxbnTie42IDOu4=;
        b=QBE55fB1lWQxxKAX7kdcZDUtulknKtSoSgEACacOgHNY/Ntpk8r2hFkNN/l1gbSkuB
         Cw9C9/x1kZw4cd9D5fjujBb1s6IOiEZmT0uWl1joIjSlPJiXIdy4E2CYBX8GOzEsm4k3
         2o0qnTfp+ld7rGr+wbIe/e27JZOUd0YVd0zy7s6yIkwtis+RGKFAomB5WGmlsvspWNH7
         issHzIRgCqzxHwQmXtyQ5bJvQldMf8r1RmU4feaA3gGA44msR3i2y9HI932opw5XQgr6
         Azo5kbGgX2mXb64VBILimJa2JNcCsrMrrQWiDPdpk2Vmq4Xs7GpSe8h0zotIatqeCQHz
         PRFw==
X-Gm-Message-State: AOAM530upoq2OZDugQnUZk2c/aadzH8D8RxUffeff22n4Sx1DQvEfd5d
        4fKh9qAlr6uQYlKyb4HZRsXHNg==
X-Google-Smtp-Source: ABdhPJyTwPvdlRukE8dmyMuxmUCWUcOVgAe4lw67VL5ziFeAgfWeZFDGN9TdazTssdzF+wunVzgrGw==
X-Received: by 2002:a17:90a:d311:: with SMTP id p17mr17904181pju.43.1615086748344;
        Sat, 06 Mar 2021 19:12:28 -0800 (PST)
Received: from braindead.localdomain (c-71-202-115-154.hsd1.ca.comcast.net. [71.202.115.154])
        by smtp.gmail.com with ESMTPSA id s194sm6329911pfs.57.2021.03.06.19.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 19:12:27 -0800 (PST)
From:   Wren Turkal <wt@penguintechs.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Wren Turkal <wt@penguintechs.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Expose the bus kernel docs to the build docs.
Date:   Sat,  6 Mar 2021 19:12:19 -0800
Message-Id: <20210307031219.53800-1-wt@penguintechs.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307014445.GT2723601@casper.infradead.org>
References: <20210307014445.GT2723601@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before, the bus type related APIs that were defined in the
include/linux/device/bus.h were not referenced anywhere in the docs, so
I linked it to the bus types api documentation.

Signed-off-by: Wren Turkal <wt@penguintechs.org>
---
 Documentation/driver-api/driver-model/bus.rst | 8 ++++++++
 Documentation/driver-api/infrastructure.rst   | 3 +--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
index 016b15a6e8ea..6bed459b87cc 100644
--- a/Documentation/driver-api/driver-model/bus.rst
+++ b/Documentation/driver-api/driver-model/bus.rst
@@ -1,3 +1,5 @@
+.. _bus_types:
+
 =========
 Bus Types
 =========
@@ -144,3 +146,9 @@ sysfs directory using::
 
 	int bus_create_file(struct bus_type *, struct bus_attribute *);
 	void bus_remove_file(struct bus_type *, struct bus_attribute *);
+
+Fucntions and Structures
+========================
+
+.. kernel-doc:: include/linux/device/bus.h
+.. kernel-doc:: drivers/base/bus.c
diff --git a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
index 683bd460e222..eb2a2c9e3c0c 100644
--- a/Documentation/driver-api/infrastructure.rst
+++ b/Documentation/driver-api/infrastructure.rst
@@ -41,8 +41,7 @@ Device Drivers Base
 .. kernel-doc:: drivers/base/platform.c
    :export:
 
-.. kernel-doc:: drivers/base/bus.c
-   :export:
+:ref:`bus_types`
 
 Device Drivers DMA Management
 -----------------------------
-- 
2.30.1

