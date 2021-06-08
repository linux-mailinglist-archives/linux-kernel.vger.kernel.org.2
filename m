Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21F039F1A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFHJGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:06:05 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35684 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhFHJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:06:01 -0400
Received: by mail-lj1-f171.google.com with SMTP id n17so8882339ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehN5ksOKPDeXaQtxFuYUYGE2SbISLeBDzZHvbFwjLMU=;
        b=YXZJiLTXuA3ySx4PD3wFxfxV+h5X01WFA/yCzSnXtG/SROViS31q2Xpf7c6R6T2uXn
         /QeDgMD14hOG36l9z4wdggSIniQ0PWuRpuOs6HNWGlfvUy4BZp4+z1wm8G8818dfoF13
         Rwyen/We5cQJntTe4/vHwQG9ZrKl+eEwgrYwNso5O/dSf6iTkIHUIlEEyRGc4SY8BiWo
         1VMRoJIHaYmSJ/ocMiVmEPvfFc2Af7tNKsRLJ3+gH8OzIxbVgXOIRGjNxDDmO2duNy4t
         A+b4Fv/FLcq+ITMNhQrGRmPh6NVEUQdJ3BupS+5llrFBcnvUG+7cIrsTXp4ZFQw/Exmh
         WNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehN5ksOKPDeXaQtxFuYUYGE2SbISLeBDzZHvbFwjLMU=;
        b=V8v0rRw4YCl5coVXzns2ziFktbEPrV144BUgnWux14FnNDIF20tMRylQqWQNovxKkB
         4MX0jWlrwgSHr9Vtt07HuX6gyAjVYL+auYraP5hC1CSh+TvpGt0GVS8IANBrKtsKCo0N
         9G7k9T+0eYDiWvSfRNMI1Mq4vVY1KqkaJimWNV86E4Z9J1GLqlvvpwxS2XKlhlThJbbh
         s+UVqPvhoI+S5yxAADfH/baMBfD2rTMm2Amqdq0+H0yvHDaqsZjzxsZ+FCGZ+Xqj2jLn
         YemZn+wOCz91yuikwjHw/tNFoqafMi0NmNQczozNyiQjF8/KzHKh8Vzufo3m27dI3zou
         Zn8Q==
X-Gm-Message-State: AOAM531aO65FWmJCm6Hi11Lrzt0tFnvDPTiTlLkHsttghiDKVRUo7fIR
        h81qHixAt0+KcaymMnJt3wwPBA==
X-Google-Smtp-Source: ABdhPJz3SwQ9T24mG2HslSdPG6wDOlx6diMgH43qf1V0qfrzdC4lFXrnIIfuLG0XzfSUioSrputIGQ==
X-Received: by 2002:a2e:a603:: with SMTP id v3mr18072187ljp.175.1623142987476;
        Tue, 08 Jun 2021 02:03:07 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id n17sm1295197lfq.118.2021.06.08.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:03:06 -0700 (PDT)
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
Subject: [PATCH v2 3/3] PM: runtime: Clarify documentation when callbacks are unassigned
Date:   Tue,  8 Jun 2021 11:02:50 +0200
Message-Id: <20210608090250.85256-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608090250.85256-1-ulf.hansson@linaro.org>
References: <20210608090250.85256-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- Added a new patch for the updating the docs, as pointed out by Alan.

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

