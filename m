Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573F83FFD38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbhICJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348833AbhICJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:35:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA21C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:34:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b6so7291402wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmPVtGRb/2K9tPmXsG6OA67ocmyG0ALUk/f00rb/dbE=;
        b=hHVvOW+Rgy49QuZvis0BlK/GsrYJalZPMiwMQPTD9lrJXqg9Q00i1L1yfN730MVnrm
         jozDq/2ArK/bErr+Aj7WpMMX8ropedd0uM4K2ji+NJetIjdWzU4ul4Ii3TmKhngnoKB5
         ED1KVNLfzjpRSV2Rnsc9Goh7o3Jl7fGy5/ofNaf9FyCZPfTw+G3LFulZntmhNfAAagYg
         Rzjt6zKZ9TYfoqM+a8H5fMrALjlmvZwB/lnLSBisQqvZWBvKzSJoAViSpejTOVkjzxij
         sWSYABhSjoto/kzcxQ8W2XpJi7rKwWPnMinkUjzwIB387s4F0EWUXYntG9vcEgzXBqBu
         sJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmPVtGRb/2K9tPmXsG6OA67ocmyG0ALUk/f00rb/dbE=;
        b=Fk8QeBQwS1Tj/S82pQw0GAf9YBoQlQzqrQVhQwYmZ9OsVlZth4Jxxff97qw+kc3Z3D
         QO7u4829/7cc0TgVQe6oWezRGYl6ipx2Pi5ccnu04rkjJuTbk7UgO0JxTV3qE6cPeVEO
         Cviwgi6x4+gg/eBvb0kEYpaB6YptlZ5hQrbAQuxWTB+tRvFCz/tHjHqcx3/C3I2D1LmL
         xo8oxH1VMqCa5mre9ExZCTI2LwKCQGykj2BXAFOyPN6KUd2B/QhvjlYcJmVGbWF4npbW
         cbwXPoxZPgKGJohlWIyvPJ3M/nlUynWN17dC2xVKGnKRXU8mvDi0SVesks73JWjDw+Q+
         Y0nQ==
X-Gm-Message-State: AOAM5310E6ZgSlomaAib2SvazGa2d0A/dtdLmQesdpCglMg9qHZaQ1Xg
        hmzeOmXAXH32GEpBau8qpCY=
X-Google-Smtp-Source: ABdhPJwQiGlWcmsu/7vuL3/Y4mC+eo4GjuY8u2NjtjIQKxzGS+l1VqfQdo+9HHu5SOSm0m9qLcOjWg==
X-Received: by 2002:a5d:410b:: with SMTP id l11mr2996224wrp.76.1630661648823;
        Fri, 03 Sep 2021 02:34:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm3853060wmk.21.2021.09.03.02.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 02:34:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: remove header file rtw_ioctl_rtl.h
Date:   Fri,  3 Sep 2021 11:33:49 +0200
Message-Id: <20210903093354.12645-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903093354.12645-1-straube.linux@gmail.com>
References: <20210903093354.12645-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All functions declared in rtw_ioctl_rtl.h are not implemented.
Remove rtw_ioctl_rtl.h and its includes.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/rtw_ioctl_rtl.h   | 63 -------------------
 .../staging/r8188eu/include/rtw_mp_ioctl.h    |  1 -
 2 files changed, 64 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h

diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h b/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
deleted file mode 100644
index 6d3d1ef923f6..000000000000
--- a/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef _RTW_IOCTL_RTL_H_
-#define _RTW_IOCTL_RTL_H_
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-/*  oid_rtl_seg_01_01 ************** */
-int oid_rt_get_signal_quality_hdl(struct oid_par_priv *poid_par_priv);/* 84 */
-int oid_rt_get_small_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_middle_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_large_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_tx_retry_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_rx_retry_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_rx_total_packet_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_tx_beacon_ok_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_tx_beacon_err_hdl(struct oid_par_priv *poid_par_priv);
-
-int oid_rt_pro_set_fw_dig_state_hdl(struct oid_par_priv *poid_par_priv);/* 8a */
-int oid_rt_pro_set_fw_ra_state_hdl(struct oid_par_priv *poid_par_priv);	/* 8b */
-
-int oid_rt_get_rx_icv_err_hdl(struct oid_par_priv *poid_par_priv);/* 93 */
-int oid_rt_set_encryption_algorithm_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_ap_ip_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_channelplan_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_set_channelplan_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_set_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_set_bcn_intvl_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_dedicate_probe_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_current_tx_power_level_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_enc_key_mismatch_count_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_channel_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_hardware_radio_off_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_key_mismatch_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_supported_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_channel_list_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_scan_in_progress_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_forced_data_rate_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_wireless_mode_for_scan_list_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_bss_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_scan_with_magic_packet_hdl(struct oid_par_priv *poid_par_priv);
-
-/*   oid_rtl_seg_01_03 section start ************** */
-int oid_rt_ap_get_associated_station_list_hdl(struct oid_par_priv *priv);
-int oid_rt_ap_switch_into_ap_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_ap_supported_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_ap_set_passphrase_hdl(struct oid_par_priv *poid_par_priv);
-
-/*  oid_rtl_seg_01_11 */
-int oid_rt_pro_rf_write_registry_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv);
-
-/*   oid_rtl_seg_03_00 section start ************** */
-int oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_set_default_key_id_hdl(struct oid_par_priv *poid_par_priv);
-
-#endif
diff --git a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
index cf99f39a582e..18730dc9f37f 100644
--- a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
+++ b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
@@ -7,7 +7,6 @@
 #include "drv_types.h"
 #include "mp_custom_oid.h"
 #include "rtw_ioctl.h"
-#include "rtw_ioctl_rtl.h"
 #include "rtw_efuse.h"
 #include "rtw_mp.h"
 
-- 
2.33.0

