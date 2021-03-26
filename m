Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D923134A9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhCZOf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhCZOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9E1C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so5895444wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QVmPdW315bcMNCrhn2o1gVugo/fPOa1lxmMCL3Wjz+Y=;
        b=ED8HacYfYn6YJjZ0KkKvWkz8yYZq1TC+nrf/H+kyQ1IIfzl50xLOCLW4Fm+JEwgUzA
         xp+L5FlsRqou4qpw9+VZ+4DEuus50xbo0Qyfh+ZOuySePEB1EW1eGMmG21yX1zb6t1PJ
         czXpkjIvhXlibEKrL1H21gusLkrBcLoEAZw6tXqbE0xJ43SqmvNKX7s/2IdlJ4Ou9Nua
         yLSqhX9Nsy8rJcvbsRS5Rs1gsVJ4BJXZqymsSFboYExammE9/wscC5GgAjUfcJ8BtXrq
         6+MLu3+qYLrXuluhvLsxFQ8zGEbMVYnhjgJuUWklHogHD4KqmjVa4lfpOzhw1bG8qyIG
         yHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVmPdW315bcMNCrhn2o1gVugo/fPOa1lxmMCL3Wjz+Y=;
        b=J5JNAETK5NE8gRpani4CFu/N8xfGXtnishN3lFcgSfg+M0ZxLomPL3kbU+j/htZBeJ
         5jA7HvyXmMkkKx3ZPL2hXyMc/7oRL7uuaYPYiP0RIFbOzoJqleqxOngTLgm5YAlmgsb1
         olN6aT9FkDuWzRmEEc5KO+7+2fHW4b1Eulq6hJW8zBSvz0iclgZv4k2srzfYQN1sAKdM
         359PIBbKsfcyw9jQbO3Rz+yC7rj3LAWN+FWRGbF/ZqQKZPrLPQ22lFBzR6sDMerlKWxE
         F+2V+dS2LDOajdTJvlQ9wqoD5/Ao+S1N8ock2ofsR0dGNGDSn1OPMVjya5QIvxPlHZWB
         pBZw==
X-Gm-Message-State: AOAM5332BLUP1jVhWlDF4qWhH8eHLv4yK7y/qbEpgItn1aJr8G9dV7gv
        uj+kX5Jy/y3oJVjHHvt1ggPwcQ==
X-Google-Smtp-Source: ABdhPJxc+5Hvcu230xbJbWY1bi5eCDiEqxgDh38Ziv7bn5I5Jtxr6pSdOylVXcjcAyF+PLWt6vev1w==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr14405613wrw.178.1616769304525;
        Fri, 26 Mar 2021 07:35:04 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 02/25] HID: ishtp-hid-client: Move variable to where it's actually used
Date:   Fri, 26 Mar 2021 14:34:35 +0000
Message-Id: <20210326143458.508959-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/hid/intel-ish-hid/ishtp-hid.c:11:
     drivers/hid/intel-ish-hid/ishtp-hid.h:24:21: warning: ‘hid_ishtp_guid’ defined but not used [-Wunused-const-variable=]

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Daniel Drubin <daniel.drubin@intel.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 5 +++++
 drivers/hid/intel-ish-hid/ishtp-hid.h        | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 0f1b5283bab42..24599280105d8 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -11,6 +11,11 @@
 #include <linux/sched.h>
 #include "ishtp-hid.h"
 
+/* ISH Transport protocol (ISHTP in short) GUID */
+static const guid_t hid_ishtp_guid =
+	GUID_INIT(0x33AECD58, 0xB679, 0x4E54,
+		  0x9B, 0xD9, 0xA0, 0x4D, 0x34, 0xF0, 0xC2, 0x26);
+
 /* Rx ring buffer pool size */
 #define HID_CL_RX_RING_SIZE	32
 #define HID_CL_TX_RING_SIZE	16
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h b/drivers/hid/intel-ish-hid/ishtp-hid.h
index 5ffd0da3cf1fa..e2423f7d2b547 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.h
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
@@ -20,11 +20,6 @@ extern void (*hid_print_trace)(void *unused, const char *format, ...);
 #define hid_ishtp_trace(client, ...) \
 		(hid_print_trace)(NULL, __VA_ARGS__)
 
-/* ISH Transport protocol (ISHTP in short) GUID */
-static const guid_t hid_ishtp_guid =
-	GUID_INIT(0x33AECD58, 0xB679, 0x4E54,
-		  0x9B, 0xD9, 0xA0, 0x4D, 0x34, 0xF0, 0xC2, 0x26);
-
 /* ISH HID message structure */
 struct hostif_msg_hdr {
 	uint8_t	command; /* Bit 7: is_response */
-- 
2.27.0

