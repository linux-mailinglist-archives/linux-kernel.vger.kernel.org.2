Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB14353A0E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 00:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhDDWYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 18:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhDDWYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 18:24:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABC8C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 15:24:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso4933412pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xbW2w5yQVlrKo7msMrOVrutuhsz59oCxVj2wRLsK5KQ=;
        b=Ez+/ePEATnb3tBEEv8CrHYtzbFqU7i81MOMXApLzJQEszLsfHdIeCvJMlyzvWCYHTm
         aydi5oy7uZ3yqCf/ii2gJAHPeHGkb14YU9iB4UQjYQNhBecKCC+LEIEopWm0eMvDHVTH
         lzwH1NkwRxVabVpw7Rnx0hdy4D0WcVK2sT/2qVjATToXJmpGQBGoDMQY/mzzzvZ0UJoQ
         gvfjXiky3L1fIT9F/1OHV006ajlmNq+rVKJ6U1hnSD6p4dyqWhhT8NgSeOLXGDzQWEHU
         jcdGFEdHJ/+Z6IjdYuAywG/aLeS5A7DD7exwuDLIITibVGEOazHmso7AuNTPauQZfTfx
         RM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xbW2w5yQVlrKo7msMrOVrutuhsz59oCxVj2wRLsK5KQ=;
        b=dQwqUQNSj/qSc04X4W7qS+O2pwvT/Evk9ZFWZqLIzZ6//4RvgFuZABeWEED27lMuE4
         p7i3qCReCQpvYAWd4VS7Wndd3zYBVT1E8yHkXNHLmEfdbcWdNrUi+hs3ufG+CeCCWjeB
         erTnG4WoVfBvnDEfauMufOu2730cTpWvbRc4bTT8TVAGd6SHg242YMQs48Jr4ywpDDrx
         7yfgBm8YJgedfqNx8HL4TqIavzV5RNga9EQcGTwRVEX64Mh5+LMoS7JBdRVQ0kRiTzER
         aXzODEVZhJ0mhXYelkc0OSDsARmkfET5zvicDdZanUjAZy84oOsO0NZLlm5AdhEYwXwd
         02Ug==
X-Gm-Message-State: AOAM532XJ7VMfkxxbLS0fKZn0bKUDr7pv4Sdyy4RWontHLbEAnqGVuuk
        r07PSSMzo4BelDlfupGLO0Q=
X-Google-Smtp-Source: ABdhPJwwRLcBrJhosiy0w6D0YQFSHdRtnAFIPwHSatYfFl1+5fGsA/iuf/znSy76C7lyh/UTjehqpA==
X-Received: by 2002:a17:902:44a:b029:e8:eb05:d0a0 with SMTP id 68-20020a170902044ab02900e8eb05d0a0mr5698810ple.50.1617575047687;
        Sun, 04 Apr 2021 15:24:07 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id d25sm13499574pfo.218.2021.04.04.15.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 15:24:07 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, yashsri421@gmail.com,
        john.oldman@polehill.co.uk, vkor@vkten.in
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH] staging: rtl8192e: move const after static
Date:   Sun,  4 Apr 2021 15:23:49 -0700
Message-Id: <20210404222349.7218-1-deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the const after static to conform with kernel preference for
static const <type> declaration style instead of static <type> const.
Identified by checkpatch: WARNING: Move const after static - use 'static
const char'.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index e340be3ebb97..c53aa2d305ca 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -260,7 +260,7 @@ void rtl92e_dm_watchdog(struct net_device *dev)
 static void _rtl92e_dm_check_ac_dc_power(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	static char const ac_dc_script[] = "/etc/acpi/wireless-rtl-ac-dc-power.sh";
+	static const char ac_dc_script[] = "/etc/acpi/wireless-rtl-ac-dc-power.sh";
 	char *argv[] = {(char *)ac_dc_script, DRV_NAME, NULL};
 	static char *envp[] = {"HOME=/",
 			"TERM=linux",
@@ -1801,7 +1801,7 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 	enum rt_rf_power_state eRfPowerStateToSet;
 	bool bActuallySet = false;
 	char *argv[3];
-	static char const RadioPowerPath[] = "/etc/acpi/events/RadioPower.sh";
+	static const char RadioPowerPath[] = "/etc/acpi/events/RadioPower.sh";
 	static char *envp[] = {"HOME=/", "TERM=linux", "PATH=/usr/bin:/bin",
 			       NULL};
 
-- 
2.17.1

