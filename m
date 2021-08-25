Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CCE3F79DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhHYQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhHYQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:08:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F3C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:07:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n12so3177959plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/l5cLUlCqQuOmI9NOmST1rS3slCz2wAxqBsla1LtrEo=;
        b=ibv558tfKD2EGwE3AuzA/JnRlUcJi1r5X6W78sOo+uBrn56+kdcAIWVg3u2rvY+2Wx
         lr0GXiSLK9To2578biszUzs+RkAMNF9Mrv+UG/qmH54Ow2m2YshzVs4kuTB3OXOQdgT5
         GQShwOY4bwOO6rzdcNiIdXDuHpuPLcM/Okksg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/l5cLUlCqQuOmI9NOmST1rS3slCz2wAxqBsla1LtrEo=;
        b=uHvfdX0CFgTKvmdgSUetWn3eH32bxtJGDM9VP2DSe8YQ5NPv/Mi0tnxkfA+VIe28ym
         RtD1XI9nUfeyXTPZ+gsiI2s5B9f6PYFDMpFnGfXpTi+jtO6fRE/11B+QCAFtkwgkaqZO
         9ZBeesEPJgUQojL4R1lLLASKEPoNdsCXp8QULKI1+dhjrjOdzoQO9b7UZ+R+OXolt4/9
         jFvSi2NUl/OZbDkwCia0/dLGjJEj+avVFTgCSg1+MhdyFYcFmSL1gLw+TYtTXxIvn9z1
         I1JvJs8q3LwOM3gWcYCgCutsefE9Xt/ZIotzI2g+SKqGxKj+eDHQuf6BO+WG1UVAnHjn
         1OHQ==
X-Gm-Message-State: AOAM531IBWNQxsd27pR71rypiY8ZSdV8ZbTxq6Xn2GNsjYsoUGABL75c
        m+h8J5aEEWpon44x7hq9tc9vSH/lQc4D7Q==
X-Google-Smtp-Source: ABdhPJzcn3M/RGUv2vmIIIjnTPhjD6UJCKPAhfdFZM7OYaXVGFIXicuAZMiX6IY1qGNOTTly4Qq4WQ==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr11404502pjb.116.1629907672421;
        Wed, 25 Aug 2021 09:07:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q21sm434957pgk.71.2021.08.25.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:07:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Andy Lavr <andy.lavr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH][RFC] platform/x86: dell-smbios-wmi: Avoid false-positive memcpy() warning
Date:   Wed, 25 Aug 2021 09:07:49 -0700
Message-Id: <20210825160749.3891090-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; h=from:subject; bh=qXsdfbAnxeyDMKPf/8AeuTAwgsFnkIChdg6LvC6u8KI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhJmrUmxMtdLH2DxKjuRGAk4B4ozE+e7SiCLYZqSp9 DtvjLmmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSZq1AAKCRCJcvTf3G3AJteyD/ 9bq6aea/3GOxMrowBT27fyllzGBBs72gKCYBqk/wi662CuzVNNvJFN0kk4nsNkHssQpZrFn2DideLd IyJ668p6UmrQyfXTMqKsCO86VQ1grM821PgK28F416tdDhZtzB2d+x8k7FHJ1/9W/Sbx6T3qV9kRse IaSJ0HROFAzVCePL+RF6wr6H7T8apjput2yNKjHfw0+7ioQcEMrQ0u6vdXsnGjXBd9XWagCnDJ39i7 KZ6FXWm2pu0POcYgxQlxq2x0tPyme6m5T+ErM+5mlv0MLvQb5PfvOTGKlWcvsGQ0YYXQ3DSnWYuSVQ QMU+cNeGlTjAKprcx6ToUvSx9B9WkxaGK5oALUpZwwed9n9af3v+tTDeuyP5JdMYtUPotLI9Q4/i8n VfoZEzz+M+e/EKyNih5AzXLSrEajPMQbsXhsx+Ix3kklu702f21rdKvacUoI7Qh7qR3UJMXJt12fIJ 7j/ijOvIHh79WuLA6Vfp9TuiQjLiH5bJb6KBgJun0m6v1dTLQKJ+iQe4VZkrfLp8HOSCJbRwdYCs3q 8tkJUY7nbrcdCY3lJ9bjIOiK668or4z80tXNnszrNqPoBsFx08diPFjMDOsVRcjwmPpZ9hajDUQJQB BXY7BFkQLRkIgn2MBxIZKg+m3zTWL9GtdttU6dLWR6OxGYTNncrelEv4G/kQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Since all the size checking has already happened, use input.pointer
(void *) so memcpy() doesn't get confused about how much is being
written.

Avoids this false-positive warning when run-time memcpy() strict
bounds checking is enabled:

memcpy: detected field-spanning write (size 4096) of single field (size 36)
WARNING: CPU: 0 PID: 357 at drivers/platform/x86/dell/dell-smbios-wmi.c:74 run_smbios_call+0x110/0x1e0 [dell_smbios]

Note: is there a missed kfree() in the marked error path?

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <mgross@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>
Cc: "Pali Rohár" <pali@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Dell.Client.Kernel@dell.com
Cc: platform-driver-x86@vger.kernel.org
Reported-by: Andy Lavr <andy.lavr@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/platform/x86/dell/dell-smbios-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platform/x86/dell/dell-smbios-wmi.c
index 33f823772733..c410d6d920b8 100644
--- a/drivers/platform/x86/dell/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
@@ -69,9 +69,10 @@ static int run_smbios_call(struct wmi_device *wdev)
 		if (obj->type == ACPI_TYPE_INTEGER)
 			dev_dbg(&wdev->dev, "SMBIOS call failed: %llu\n",
 				obj->integer.value);
+		/* output.pointer memory allocation leak? */
 		return -EIO;
 	}
-	memcpy(&priv->buf->std, obj->buffer.pointer, obj->buffer.length);
+	memcpy(input.pointer, obj->buffer.pointer, obj->buffer.length);
 	dev_dbg(&wdev->dev, "result: [%08x,%08x,%08x,%08x]\n",
 		priv->buf->std.output[0], priv->buf->std.output[1],
 		priv->buf->std.output[2], priv->buf->std.output[3]);
-- 
2.30.2

