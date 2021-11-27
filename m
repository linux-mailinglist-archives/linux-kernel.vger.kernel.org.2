Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA445FE0C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 11:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350029AbhK0KQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 05:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhK0KOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 05:14:55 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9643C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 02:11:40 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u22so23657439lju.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 02:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZy0QgWyWJd+Rli7BtfMIcm+ydCOROO/RTbEeioRQrA=;
        b=QMgSIWp8m9RVSPcE/vlS1gubdjALvyjqOdX/OG1cyd11F/5KoPzL8lpHTMsG0G3WWc
         vjwjeD6QZ5GS40f25eGIxHFZiKINGADnvpLtzCT2WV1SSZzImIZMdul/0GA6eT0rGn4Z
         OvVvrOR9eCNH1s2zqfKOi/9JLc1b1gqZX55IpulpGbEuYb8XL8o5Cax7Ye7xophiSJen
         MA/NpfrPm8cyeSUw5MUrzxiPax0yk6r3WBqA1f0Ly3eVqKSGEuOVP1HZB0acTT+eBDKz
         bfeQDVADrxYAsP8l4QrImD+Wrc4rgVG3FaMgZ/DGmueR5AQnszkfpuI7MGRpxtpL9S34
         p8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZy0QgWyWJd+Rli7BtfMIcm+ydCOROO/RTbEeioRQrA=;
        b=BMJ8Ykmqps5+OmYJ2SgLoyr1uoRbUyQW+m/ljq4JZkC511NUiL+BgpXJ9jhGdghZM2
         m8ga/UTt1BE+GiqRMMGAR7a0yw0bxbcoUfQX9Bd/uTkMyQBduDMs3YdW8l4gl6bo64vL
         FnEVX11dWrU+FIIYR1Tj6j4CjhFoqokwxocGiBLJBPWShNpL1/v+z9khh5mNreVG67FN
         ePBuEgT9c8LJWMYIvnRguGtuE2d/P+t+HW10RIMRzHLJuD3ohIDlHfRXQnbd255hW+gO
         zcCQoYT4HsstTURbqEitp2sbvxDBkKleR56b3edhVbWShU7hT+mOAmsHKhex/g8wabr+
         YLSw==
X-Gm-Message-State: AOAM531eRnChSXsOi+ZexrG3zNc6siosFUA0CUGcvzwlLZbzmb+a6lDk
        2EHGQGpEqFBuu4dH8fhRqDtPeNJGB0Q=
X-Google-Smtp-Source: ABdhPJz2mEb9mar3wnhRqf786gyLMdgX59sA7PUmhEzZiIr8BaeYjFSxDnq3BEsosIkY7zStZe8gZg==
X-Received: by 2002:a2e:a688:: with SMTP id q8mr37081219lje.349.1638007899028;
        Sat, 27 Nov 2021 02:11:39 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id a29sm701767lfi.302.2021.11.27.02.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 02:11:38 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] const_structs.checkpatch: add frequently used ops structs
Date:   Sat, 27 Nov 2021 11:11:34 +0100
Message-Id: <20211127101134.33101-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add commonly used structs (>50 instances) which are always or almost
always const.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 scripts/const_structs.checkpatch | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 3980985205a0..1eeb7b42c5b9 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -12,19 +12,27 @@ driver_info
 drm_connector_funcs
 drm_encoder_funcs
 drm_encoder_helper_funcs
+dvb_frontend_ops
+dvb_tuner_ops
 ethtool_ops
 extent_io_ops
+fb_ops
 file_lock_operations
 file_operations
 hv_ops
+hwmon_ops
+ib_device_ops
 ide_dma_ops
 ide_port_ops
+ieee80211_ops
+iio_buffer_setup_ops
 inode_operations
 intel_dvo_dev_ops
 irq_domain_ops
 item_operations
 iwl_cfg
 iwl_ops
+kernel_param_ops
 kgdb_arch
 kgdb_io
 kset_uevent_ops
@@ -32,25 +40,33 @@ lock_manager_operations
 machine_desc
 microcode_ops
 mlxsw_reg_info
+mtd_ooblayout_ops
 mtrr_ops
+nand_controller_ops
 neigh_ops
 net_device_ops
+nft_expr_ops
 nlmsvc_binding
 nvkm_device_chip
 of_device_id
 pci_raw_ops
 phy_ops
+pinconf_ops
 pinctrl_ops
 pinmux_ops
 pipe_buf_operations
 platform_hibernation_ops
 platform_suspend_ops
+proc_ops
 proto_ops
+pwm_ops
 regmap_access_table
 regulator_ops
+reset_control_ops
 rpc_pipe_ops
 rtc_class_ops
 sd_desc
+sdhci_ops
 seq_operations
 sirfsoc_padmux
 snd_ac97_build_ops
@@ -67,6 +83,13 @@ uart_ops
 usb_mon_operations
 v4l2_ctrl_ops
 v4l2_ioctl_ops
+v4l2_subdev_core_ops
+v4l2_subdev_internal_ops
+v4l2_subdev_ops
+v4l2_subdev_pad_ops
+v4l2_subdev_video_ops
+vb2_ops
 vm_operations_struct
 wacom_features
+watchdog_ops
 wd_ops
-- 
2.34.1

