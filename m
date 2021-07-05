Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D003BBDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGENwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhGENuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:50:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F365C061765
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 06:48:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x12so23746127eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcvOaG0J/hZEczmyOwGpCy0AJMuPctlmDRDv7xjG04M=;
        b=fPkN13W88SOfEr4WLra8q3YpaKyak9VFrZRiBPEtvbvFEnJS+VjSyssQo0U/dlBslM
         yZ4d4bzHiTahYxKdYteEHrFb8T9JQYyqpt66uhLLWNcFZk8fyFjSM1ssAM5+jAByS4KW
         sha+rTjwSnDIBR0hCwSbOlLZtzSnamuG2zMkeAG1353cmu1nQiTJBDo5giSzL4HMijQF
         3R974UEVm5Bt+cWlgufd0wC1oIMRWNSlgISXMtsdwnPN7ApP1FzKC+4vLEWuQS6j3/KK
         CxEV8UzG3RbR0jq5mPn60WtyST6S26BG+yNteHl0XrUmFjO0BDooQ42QbSIIZBX7rapA
         gxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcvOaG0J/hZEczmyOwGpCy0AJMuPctlmDRDv7xjG04M=;
        b=FyM4OhXa9glAvxROK1tt39AUjx2FBGU+nVmOJczm9oOd93tTPCYY0sJweZebpj56OU
         uWeqKd2Of7L2GF12f9TE9v2LsLJ0sar51Nqkxvvnhowp3RDjB/TjRcZGVUvBML4sxNiG
         7OLrAr7pbDuURQCJzClCzqVDcvgKRu3aNjwQflqqr51l81Ht2eAhGdEAdchErwtC0agU
         3dv2omuldRSM8LIIdegT+3neLfyldNdrqt9xZtT0REYi9WH4/PEWOyzXh4n9tyhWGO3J
         LO1e2lsry9lsfvlw3+eFsiwmJxn7LPETuyZgrolX5AIdcLNB2KAN3ymZHqbfqjnrHVVJ
         77OA==
X-Gm-Message-State: AOAM532/62ulFrdep4oewl+rJbIaaa0/FHHWc2X+V3tJ2/GjAP2lml0L
        KYGMgxI+RWusrF4/cCWi50g7Ow==
X-Google-Smtp-Source: ABdhPJxyU7URfuIYdS/ISsgwZ/de5lyrioYlRyrVpglihitQVVbcdfHO5l4BdSPHFvNgggmVDjgUMA==
X-Received: by 2002:a05:6402:1357:: with SMTP id y23mr14463677edw.244.1625492895897;
        Mon, 05 Jul 2021 06:48:15 -0700 (PDT)
Received: from localhost.localdomain ([89.18.44.40])
        by smtp.gmail.com with ESMTPSA id cf29sm1557637edb.14.2021.07.05.06.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 06:48:15 -0700 (PDT)
From:   Pavo Banicevic <pavo.banicevic@sartura.hr>
To:     linux-doc@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        Max.Merchel@tq-group.com, linux@rempel-privat.de, daniel@0x0f.com,
        shawnguo@kernel.org, sam@ravnborg.org, arnd@arndb.de,
        krzysztof.kozlowski@canonical.com, pavo.banicevic@sartura.hr,
        corbet@lwn.net, lee.jones@linaro.org, pavel@ucw.cz,
        robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        goran.medic@sartura.hr, luka.perkov@sartura.hr,
        luka.kovacic@sartura.hr
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 6/7] Documentation/hwmon: Add iei-wt61p803-puzzle hwmon driver documentation
Date:   Mon,  5 Jul 2021 15:49:38 +0200
Message-Id: <20210705134939.28691-7-pavo.banicevic@sartura.hr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705134939.28691-1-pavo.banicevic@sartura.hr>
References: <20210705134939.28691-1-pavo.banicevic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luka Kovacic <luka.kovacic@sartura.hr>

Add the iei-wt61p803-puzzle driver hwmon driver interface documentation.

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Signed-off-by: Pavo Banicevic <pavo.banicevic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Robert Marko <robert.marko@sartura.hr>
---
 .../hwmon/iei-wt61p803-puzzle-hwmon.rst       | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/hwmon/iei-wt61p803-puzzle-hwmon.rst

diff --git a/Documentation/hwmon/iei-wt61p803-puzzle-hwmon.rst b/Documentation/hwmon/iei-wt61p803-puzzle-hwmon.rst
new file mode 100644
index 000000000000..04b01e53760c
--- /dev/null
+++ b/Documentation/hwmon/iei-wt61p803-puzzle-hwmon.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver iei-wt61p803-puzzle-hwmon
+=======================================
+
+Supported chips:
+ * IEI WT61P803 PUZZLE for IEI Puzzle M801
+
+   Prefix: 'iei-wt61p803-puzzle-hwmon'
+
+Author: Luka Kovacic <luka.kovacic@sartura.hr>
+
+
+Description
+-----------
+
+This driver adds fan and temperature sensor reading for some IEI Puzzle
+series boards.
+
+Sysfs attributes
+----------------
+
+The following attributes are supported:
+
+- IEI WT61P803 PUZZLE for IEI Puzzle M801
+
+/sys files in hwmon subsystem
+-----------------------------
+
+================= == ===================================================
+fan[1-5]_input    RO files for fan speed (in RPM)
+pwm[1-2]          RW files for fan[1-2] target duty cycle (0..255)
+================= == ===================================================
+
+/sys files in thermal subsystem
+-------------------------------
+
+================= == ====================================================
+cur_state         RW file for current cooling state of the cooling device
+                     (0..max_state)
+max_state         RO file for maximum cooling state of the cooling device
+================= == ====================================================
-- 
2.31.1

