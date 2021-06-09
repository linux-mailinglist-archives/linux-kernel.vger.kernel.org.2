Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324AA3A10D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbhFIKI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhFIKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:08:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AE9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:06:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id v22so35787764lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kziI9SCt0c63nrukquSSDGhvQsklkwm80pK2jCkKV/8=;
        b=ocAQ/4+bpUOUubmy0uU8rzGkEcreB5FA8DJQDdC+qjuGWhw5aunQ5NGgkRjkWMQmrS
         ZPkmgqCIy7BQt934bRcyJXeojgGvACSQecdfuhspGw+IHhl4dH0Tndk70mE+WUPhwk/h
         fzd99G0iK1QAAGArcBXPMp0CzMbmaK5h7saGzD/089u7NTMvI9ou7jvtlPn8v37tBxHy
         ONC7IItbCe0GKsL68GQ5ylKowtkGn5LC9KfwaSKYBYA5bVSzLlssptqwJxn13WRqsj6y
         EeGLF3fmtLVHXMmFNybGofjBwZiPN1StkB20aD+hzMSRJtbfxUE2LF6zKNZKqCduqiFV
         wf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kziI9SCt0c63nrukquSSDGhvQsklkwm80pK2jCkKV/8=;
        b=Lsx3oM7VvqN3jwpLeTieQsCcJ1vu2gKe8Z3PfwGFlJtJP/9kDnfO6CyUDbCIYB2lkY
         jzomx2sVF40mJ8YO4dG6W15ef1F+LU+H/jzQ/WJwY8MJ7WYD4a0k7Y/no9QSo50hAk5b
         LS8A3ZGKhpQyEEnwJW65S8WDIayIYU2jH6Nlwqd3tKmljxSFZcC+aREPSsTnflZocGRx
         ezD6OZbMZIX8Gvb8UJlfbY4jXwelTNEHpylnJ6xQ6Lz36vNHWoD5ZhAdfELqplkiet4J
         QkZbuKKUwjIzqdggwEP/up+Ox/5OGLpvt4zzE3D7ezxELROMfRwrbhY62t5KLlZTKxLV
         gM9A==
X-Gm-Message-State: AOAM533oOMiVZZ3Rwg0DPE0YOSn99f0rj4qm8z9FWl0HBLCsPNXaSH5Y
        aWoN6DndRDq8KhzpBs9H2XKehw==
X-Google-Smtp-Source: ABdhPJy3vLoeOu5r0E1JMWc+45Y9k4iikqrd7OlIr7swkKp5Gezd4tXOsSa6ac2rXxjOp9Hlx3QnrQ==
X-Received: by 2002:a05:6512:31cd:: with SMTP id j13mr18401644lfe.445.1623233176628;
        Wed, 09 Jun 2021 03:06:16 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id f11sm304406lfk.9.2021.06.09.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:06:14 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] PM: runtime: Clarify documentation when callbacks are unassigned
Date:   Wed,  9 Jun 2021 12:06:10 +0200
Message-Id: <20210609100610.97830-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to the PM core allows ->runtime_suspend|resume callbacks to
be unassigned.

In the earlier behaviour the PM core would return -ENOSYS, when trying to
runtime resume a device, for example. Let's update the documentation to
clarify this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
        - This time, really, fix spelling and further clarified the behaviour,
	according to comments from Alan.

---
 Documentation/power/runtime_pm.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 18ae21bf7f92..8a0a43811e3a 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -827,6 +827,15 @@ or driver about runtime power changes.  Instead, the driver for the device's
 parent must take responsibility for telling the device's driver when the
 parent's power state changes.
 
+Note that, in some cases it may not be desirable for subsystems/drivers to call
+pm_runtime_no_callbacks() for their devices. This could be because a subset of
+the runtime PM callbacks needs to be implemented, a platform dependent PM
+domain could get attached to the device or that the device is power managed
+through a supplier device link. For these reasons and to avoid boilerplate code
+in subsystems/drivers, the PM core allows runtime PM callbacks to be
+unassigned. More precisely, if a callback pointer is NULL, the PM core will act
+as though there was a callback and it returned 0.
+
 9. Autosuspend, or automatically-delayed suspends
 =================================================
 
-- 
2.25.1

