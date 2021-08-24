Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7883F6C10
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhHXXHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhHXXH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:07:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FEC061757;
        Tue, 24 Aug 2021 16:06:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h4so3376063wro.7;
        Tue, 24 Aug 2021 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b8RsIwtrHebeEjKbu+TNLK9lOiVtyrKG0JS/QJtlmIE=;
        b=sm+89/JL5v7cIcK/QDlNnKAaNX34h8LnHXGXQe4ZozOQQshUQbN9SUIua+LShiIRIU
         sGIkN0umzrU9XH6Ay8Ucdik70pNe0vNUO5Fj1b1iECKPkmkmWckwvFhhQFz5n7XR9TMh
         ghsi9qUTeOxdbK6iqhUio45ZfyJNMN/A8f6YCDA4u2jmvl5ADQRTt0yBDEPma/YnqEvX
         aOvcpp3OOzCkxUTcMLe984cTzz3UgYjBxKX2/m23bqLHDaX6gpZgIwpJnHiVagxWyjFv
         Mzvsl7m6vVHAy5KjxnTGWgR0kYkDAvC7e+hUBPHK+l5U6FScNbbYFaI9HDYDhkHMuO19
         M1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8RsIwtrHebeEjKbu+TNLK9lOiVtyrKG0JS/QJtlmIE=;
        b=GUCok7CU3FZLv+d6viG39qKGcwq0uxB0Si0EOizaRs3YKvU8pN6lIgcCXsAhnjEtX0
         XGSOQ5xduP4IQZCeA2Oi+7CY5C8JJX+kiDFHXay4lpG7h8i90SysG8a7VB3mYjTmdfF3
         0vhoUALA39B8hH7NvUxcuz08kkYT9Iuc6F6eU+QvR34t/nHGtQ9W9z75K16jKnLFaZDW
         zHe9yQ8oisXUZGXDZxz8qcoA5XFZ0U5rqXJI+5dey2ir9LCrlOjagZVLsRicqScgsprp
         ZF41LytTzs0/eSNQhipVnQeUmczJU/D1YDQp2lP3T0E20A58rjwclyT4hbOH5kYUfSaW
         kfbw==
X-Gm-Message-State: AOAM533XNYD4vmuwzibnH4atHomk+aef/HpPRZNjiAUjdzzQAAWxXAqT
        M6ps2lqFAHnMhybwquB/hHPZw2cytNE=
X-Google-Smtp-Source: ABdhPJyqVAL/+HYgSbU1MO3tW4JkVTDVTOHPAvpGDfyMZ25IdvEUZXzY3fP+zzu6312KNAvAoNR4vQ==
X-Received: by 2002:a5d:58da:: with SMTP id o26mr22728213wrf.140.1629846401971;
        Tue, 24 Aug 2021 16:06:41 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id q10sm3477868wmq.12.2021.08.24.16.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 16:06:41 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC PATCH v2 2/3] Documentation: power: Document regulator_lookup_list
Date:   Wed, 25 Aug 2021 00:06:19 +0100
Message-Id: <20210824230620.1003828-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824230620.1003828-1-djrscally@gmail.com>
References: <20210824230620.1003828-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some explanatory documentation to machine.rst detailing when and
how to use the new regulator lookup functionality.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:
	- Patch introduced

 Documentation/power/regulator/machine.rst | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/power/regulator/machine.rst b/Documentation/power/regulator/machine.rst
index 22fffefaa3ad..7ad64e59b649 100644
--- a/Documentation/power/regulator/machine.rst
+++ b/Documentation/power/regulator/machine.rst
@@ -95,3 +95,34 @@ Finally the regulator devices must be registered in the usual manner::
 
   /* register regulator 2 device */
   platform_device_register(&regulator_devices[1]);
+
+Alternatively, if the struct regulator_init_data is being created in a process
+distinct from the registration of the regulator devices themselves (for example
+if the regulator devices themselves are enumerated through devicetree or ACPI
+but the system lacks regulator_init_data in firmware), then it must be added to
+a lookup table that will be checked when the regulator devices are registered.
+
+  static struct regulator_lookup regulator1_lookup = {
+	.device_name = "regulator.1",
+	.regulator_name = "Regulator-1",
+	.init_data = {
+		.constraints = {
+			.name = "Regulator-1",
+			.min_uV = 3300000,
+			.max_uV = 3300000,
+			.valid_ops_mask = REGULATOR_MODE_NORMAL,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(regulator1_consumers),
+		.consumer_supplies = regulator1_consumers,
+	},
+  };
+
+  regulator_add_lookup(&regulator1_lookup);
+
+The .device_name field should match that of the struct device that the
+regulator driver will bind to. The .regulator_name field should match the name
+field in the struct regulator_desc that is used to register the regulator that
+this regulator_init_data is intended to be mapped to. Neither field can be null
+since regulator_register() will not allow the name field of the regulator_desc
+to be null, and without at least the device name we cannot guarantee we're
+passing the init_data to the right regulator.
-- 
2.25.1

