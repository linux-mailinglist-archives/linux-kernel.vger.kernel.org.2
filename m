Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84AA44B24F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbhKISHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbhKISHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:07:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024A4C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:05:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t21so22366776plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOAcleOptN1xyi4hYDxDvcZ/sK0NPHGslLP0U4ipTto=;
        b=K3ArgL21TdjPNCyZtEH9lbLPJALBkkJ3tshRC/Y6A1f0suoKDV6MFWf3GIXvlQFtJZ
         fZnWK20Dck8uCbPOIDGzgN7Z0v38cqMmVqf7DBATa5OrrsbQdOiVYH0tutpyU3uT0jtB
         oH8+05jhtOtRH+1RB+CQcjz0Dqat5k2wRBGz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOAcleOptN1xyi4hYDxDvcZ/sK0NPHGslLP0U4ipTto=;
        b=rQr7O2J7xr5iw5auhkcX68QUwSQaZ8HKSUQwiVJyKtbDr3Fe5ereXwvhTOB8ArHVpg
         0D6zhI3QrQ6HbJyD9LAmltV2HydjdFHrufAVMnVC218f8rUfhCWGmmWZNDSkxii8WRSh
         NO52d6xQybak21UsuEuAH0NTQp4Eja96xjZx/WRptnRwcbTr3SK03n6SZYwgcCf/AwgV
         hVDe83eicMRjz7DZwyZOlqKOy3m3yMRuk74HyZZsV4tgMwpLWJ3ognf+d0p58hMVNqaD
         Ndn0b9TAHqfwYrqdxHavvP6ddTE8K+MT2yhUc0GccWy/ilI+yOP2enNX9O6MaCdvovZp
         Zx9Q==
X-Gm-Message-State: AOAM530b8CoPN2nKbXDuZq/uA4lVTpgBzD85kTtjIV+OuglGE83QDhKC
        Nmg67ebIzYXQIesM9sl+wNzh3w==
X-Google-Smtp-Source: ABdhPJxASeOj178DxpvJmISUQEWd8F0zjibZtzjJFkHgk8HvQvdiDhKpN/0coRC4kWI4WMpLsBUT0A==
X-Received: by 2002:a17:90a:a513:: with SMTP id a19mr9483584pjq.26.1636481099551;
        Tue, 09 Nov 2021 10:04:59 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c210:f056:2a4e:e420])
        by smtp.gmail.com with ESMTPSA id u22sm2882690pfk.148.2021.11.09.10.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 10:04:59 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Avoid unpowered AUX xfers that caused crashes
Date:   Tue,  9 Nov 2021 10:04:18 -0800
Message-Id: <20211109100403.1.I4e23470d681f7efe37e2e7f1a6466e15e9bb1d72@changeid>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you happened to try to access `/dev/drm_dp_aux` devices provided by
the MSM DP AUX driver too early at bootup you could go boom. Let's
avoid that by only allowing AUX transfers when the controller is
powered up.

Specifically the crash that was seen (on Chrome OS 5.4 tree with
relevant backports):
  Kernel panic - not syncing: Asynchronous SError Interrupt
  CPU: 0 PID: 3131 Comm: fwupd Not tainted 5.4.144-16620-g28af11b73efb #1
  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
  Call trace:
   dump_backtrace+0x0/0x14c
   show_stack+0x20/0x2c
   dump_stack+0xac/0x124
   panic+0x150/0x390
   nmi_panic+0x80/0x94
   arm64_serror_panic+0x78/0x84
   do_serror+0x0/0x118
   do_serror+0xa4/0x118
   el1_error+0xbc/0x160
   dp_catalog_aux_write_data+0x1c/0x3c
   dp_aux_cmd_fifo_tx+0xf0/0x1b0
   dp_aux_transfer+0x1b0/0x2bc
   drm_dp_dpcd_access+0x8c/0x11c
   drm_dp_dpcd_read+0x64/0x10c
   auxdev_read_iter+0xd4/0x1c4

I did a little bit of tracing and found that:
* We register the AUX device very early at bootup.
* Power isn't actually turned on for my system until
  hpd_event_thread() -> dp_display_host_init() -> dp_power_init()
* You can see that dp_power_init() calls dp_aux_init() which is where
  we start allowing AUX channel requests to go through.

In general this patch is a bit of a bandaid but at least it gets us
out of the current state where userspace acting at the wrong time can
fully crash the system.
* I think the more proper fix (which requires quite a bit more
  changes) is to power stuff on while an AUX transfer is
  happening. This is like the solution we did for ti-sn65dsi86. This
  might be required for us to move to populating the panel via the
  DP-AUX bus.
* Another fix considered was to dynamically register / unregister. I
  tried that at <https://crrev.com/c/3169431/3> but it got
  ugly. Currently there's a bug where the pm_runtime() state isn't
  tracked properly and that causes us to just keep registering more
  and more.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/msm/dp/dp_aux.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index eb40d8413bca..6d36f63c3338 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -33,6 +33,7 @@ struct dp_aux_private {
 	bool read;
 	bool no_send_addr;
 	bool no_send_stop;
+	bool initted;
 	u32 offset;
 	u32 segment;
 
@@ -331,6 +332,10 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 	}
 
 	mutex_lock(&aux->mutex);
+	if (!aux->initted) {
+		ret = -EIO;
+		goto exit;
+	}
 
 	dp_aux_update_offset_and_segment(aux, msg);
 	dp_aux_transfer_helper(aux, msg, true);
@@ -380,6 +385,8 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 	}
 
 	aux->cmd_busy = false;
+
+exit:
 	mutex_unlock(&aux->mutex);
 
 	return ret;
@@ -431,8 +438,13 @@ void dp_aux_init(struct drm_dp_aux *dp_aux)
 
 	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
 
+	mutex_lock(&aux->mutex);
+
 	dp_catalog_aux_enable(aux->catalog, true);
 	aux->retry_cnt = 0;
+	aux->initted = true;
+
+	mutex_unlock(&aux->mutex);
 }
 
 void dp_aux_deinit(struct drm_dp_aux *dp_aux)
@@ -441,7 +453,12 @@ void dp_aux_deinit(struct drm_dp_aux *dp_aux)
 
 	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
 
+	mutex_lock(&aux->mutex);
+
+	aux->initted = false;
 	dp_catalog_aux_enable(aux->catalog, false);
+
+	mutex_unlock(&aux->mutex);
 }
 
 int dp_aux_register(struct drm_dp_aux *dp_aux)
-- 
2.34.0.rc0.344.g81b53c2807-goog

