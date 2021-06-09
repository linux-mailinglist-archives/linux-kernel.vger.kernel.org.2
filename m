Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3703A10CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbhFIKEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhFIKEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:04:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34327C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:02:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v22so35769512lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+obMq8PkB/J8Gdch4+1xb+KTFZm3rBY/BnhHmvQsV4=;
        b=eU39jTtEgR1GfHTSSAqzHh+RGy59HSkMiKWeIm09OWilH4HdLfnzNvGEZ0UIpD2qaY
         eoxivEtj4oox16nimgTMac45NRT/pF1gN2ujJrLOvRvG+JRR8NsY1uUqaAg7GxiSWsSh
         142XtSfyxIsOGCjxLemGLwdjL0Zx/6E/VT56/jWdUI0stijRfcsdP4kUK2zSGrwLYiC1
         lQCcxSAUBOQ38Mfn8B8pvm+dGOyj6ISEyKCR7KMPiziySnAvnvuCQk4yNn9xM71Zqhc6
         9aTJmbK39jfklrBfF7fkGAtQ7YVn9eN63Hktfra24OD+kyjQZp63g34zI6w5Cli6uqpa
         8iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+obMq8PkB/J8Gdch4+1xb+KTFZm3rBY/BnhHmvQsV4=;
        b=aneG60N/5pQV8TlKFMDtEkTumNNkcAWzk6zDoaNYD1bnReZmF5q/OhuDPkIn2kVjuv
         VSZa6U0RnYZHdwBIlq78kSORPMWiLo9bcDdVwgrWUbuty24yB7+GPWsfw51JrrMYAt6l
         Qowu7jwqzOvXEJK8Mg6Y930Xz8UiAKyL9YuoNWwaIeiHzCUIl5kN7+y1Nfhgym2qU4+C
         uW+dYztbeIl2wbPo8sQ3Q0TWR3VfUjrb4R3yjSHzlOGw7c3HBkYAVj7oQgkUl7epYL6P
         28yktiTKzqagk3iAkbaoZQfJIIydxwrwW8zGk2jzA7Iqf5pUO9GLX7nDXzD6dAtPREZl
         vujA==
X-Gm-Message-State: AOAM53100EvkLhwjsCUwROkQsatjTmGh9QuWgI1GjqfxNiovTCcsbPWc
        2oalgi6RFHonOCyspIQdV1Wlkw==
X-Google-Smtp-Source: ABdhPJz/JqTi8eCZ9SlLhcOgRDcSvhoHDrLDQjmIIP5Iq56QWpjOlyySou2dxMQOppHxqQHaBYMOlg==
X-Received: by 2002:ac2:5ccd:: with SMTP id f13mr18641335lfq.185.1623232923531;
        Wed, 09 Jun 2021 03:02:03 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id w24sm300041lfa.143.2021.06.09.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:02:02 -0700 (PDT)
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
Subject: [PATCH v3 3/3] PM: runtime: Clarify documentation when callbacks are unassigned
Date:   Wed,  9 Jun 2021 12:01:57 +0200
Message-Id: <20210609100157.97635-1-ulf.hansson@linaro.org>
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

Changes in v3:
	- Fix spelling and further clarified the behaviour, according to
	comments from Alan.

---
 Documentation/power/runtime_pm.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 18ae21bf7f92..3d09c9fd450d 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -827,6 +827,14 @@ or driver about runtime power changes.  Instead, the driver for the device's
 parent must take responsibility for telling the device's driver when the
 parent's power state changes.
 
+Note that, in some cases it may not be desirable for subsystems/drivers to call
+pm_runtime_no_callbacks() for their devices. This could be because a subset of
+the runtime PM callbacks needs to be implemented, a platform dependent PM
+domain could get attached to the device or that the device is power manged
+through a supplier device link. For these reasons and to avoid boilerplate code
+in subsystems/drivers, the PM core allows runtime PM callbacks to be
+unassigned.
+
 9. Autosuspend, or automatically-delayed suspends
 =================================================
 
-- 
2.25.1

