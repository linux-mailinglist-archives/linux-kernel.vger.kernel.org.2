Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C134150F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhIVUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhIVUG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:06:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE65C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so10418257wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEaQvr3VC+onuDR73XZ9fOvEJ6JR6IVQTYkFzDHUZt0=;
        b=Ed1FWW2C6t0N8NOuiWAedXT0KB4tMy56FDZng3mwXnuGIOxpJtxtOc2/ZMf9rid9z7
         JUUq+8oL9KF3gkkei5kOI6H68iLMj/R5P8fiQSnS7tYZRQA02yLfWJZfChFw1TE6vwW3
         EHsOLCrQq5fH0nq8jVT1EC9l3iv6IQaA+syxdGC3CvCu7zmflBFfy5QWYMhDUMH1pwwr
         9qdL7z8nKCwmnchICv3nHA7apSA1M+F1poFAAiWYSMTmCo60M7XzZoqtYba6a21JKw0o
         mt5Bn5w3OFwYVi+D55D6w1fYe9FLo0SLU3+CChA9p87t5bpQmiJ4DnEYLxUxBQA0QJvR
         wk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEaQvr3VC+onuDR73XZ9fOvEJ6JR6IVQTYkFzDHUZt0=;
        b=X+5n/nuRfLzYSxLHJmgJr+3JVkcqAfNlqOtl6HwwtLsB1iYdPatTzCi7juQtLsUj3c
         0KQR3YfDw5g1XFWNAtqablCD10JGMjcpGqJ66aaqWndmUKKqrUaspk+yB9w1tnpy8FkS
         Qdo9OMerSOjTARO8P3/5+64BYYlKbqIYn+0PShVWYyf0misu1LPrDft3igN9uc6QFB2e
         NPrCrDqvnQtnCvXMcji6fkrQdWkd5uSGQqUo02UpbLyvff7z50cnEXKbyjpCScVmia06
         +so0xX4eLvlnJ6vLpGvIiQEGpAIYL39gNEuV3A+XeLf9h5oUT4YQB1tvBOAMLy4O4oEB
         OKSg==
X-Gm-Message-State: AOAM53043qaHj4BSOM7BKouXTsdgT0kkUk0vveCZtlPcPsvwr2zJKg8H
        gvyFQgADqFlKgeTh30JfTkU=
X-Google-Smtp-Source: ABdhPJy+WRPt8Lp3xdfAdduQcqpw3ihSoPzH+mtKXSni1sV+oWcBD7HmknYqNAFwrc4mOj/H/XLQ8g==
X-Received: by 2002:a05:6000:18a4:: with SMTP id b4mr930578wri.96.1632341125898;
        Wed, 22 Sep 2021 13:05:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/47] staging: r8188eu: remove unused functions
Date:   Wed, 22 Sep 2021 22:03:33 +0200
Message-Id: <20210922200420.9693-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes a bunch of unused functions and one unused enum.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (47):
  staging: r8188eu: remove EFUSE_ShadowRead()
  staging: r8188eu: remove efuse_GetCurrentSize()
  staging: r8188eu: remove efuse_GetMaxSize()
  staging: r8188eu: remove rtw_BT_efuse_map_write()
  staging: r8188eu: remove rtw_efuse_access()
  staging: r8188eu: remove rtw_efuse_map_write()
  staging: r8188eu: remove rtw_BT_efuse_map_read()
  staging: r8188eu: remove rtw_efuse_map_read()
  staging: r8188eu: remove _rtw_dequeue_network()
  staging: r8188eu: remove _rtw_enqueue_network()
  staging: r8188eu: remove rtw_get_timestampe_from_ie()
  staging: r8188eu: remove rtw_scan_abort()
  staging: r8188eu: remove issue_action_spct_ch_switch()
  staging: r8188eu: remove issue_probereq_p2p_ex()
  staging: r8188eu: remove sreset_get_wifi_status()
  staging: r8188eu: remove build_deauth_p2p_ie()
  staging: r8188eu: remove rtw_freq2ch()
  staging: r8188eu: remove rtw_set_802_11_add_key()
  staging: r8188eu: remove rtw_set_802_11_remove_key()
  staging: r8188eu: remove rtw_set_802_11_remove_wep()
  staging: r8188eu: remove rtw_set_country()
  staging: r8188eu: remove rtw_set_scan_mode()
  staging: r8188eu: remove rtw_validate_ssid()
  staging: r8188eu: remove rtw_set_channel_plan()
  staging: r8188eu: remove rtw_atoi()
  staging: r8188eu: remove rtw_cbuf_push()
  staging: r8188eu: remove rtw_cbuf_full()
  staging: r8188eu: remove rtw_os_read_port()
  staging: r8188eu: remove rtw_IOL_cmd_buf_dump()
  staging: r8188eu: remove action_public_str()
  staging: r8188eu: remove dump_ies()
  staging: r8188eu: remove hal_ch_offset_to_secondary_ch_offset()
  staging: r8188eu: remove secondary_ch_offset_to_hal_ch_offset()
  staging: r8188eu: remove ieee80211_get_hdrlen()
  staging: r8188eu: remove ieee80211_is_empty_essid()
  staging: r8188eu: remove rtw_action_frame_parse()
  staging: r8188eu: remove rtw_ies_remove_ie()
  staging: r8188eu: remove rtw_set_ie_ch_switch()
  staging: r8188eu: remove rtw_set_ie_mesh_ch_switch_parm()
  staging: r8188eu: remove rtw_set_ie_secondary_ch_offset()
  staging: r8188eu: remove enum secondary_ch_offset
  staging: r8188eu: remove rtw_dequeue_recvbuf()
  staging: r8188eu: remove rtw_enqueue_recvbuf()
  staging: r8188eu: remove rtw_enqueue_recvbuf_to_head()
  staging: r8188eu: remove rtw_init_recvframe()
  staging: r8188eu: remove rtw_calculate_wlan_pkt_size_by_attribue()
  staging: r8188eu: remove rtw_sctx_done()

 drivers/staging/r8188eu/core/rtw_efuse.c      | 377 ------------------
 drivers/staging/r8188eu/core/rtw_ieee80211.c  | 301 --------------
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 374 -----------------
 drivers/staging/r8188eu/core/rtw_iol.c        |  17 -
 drivers/staging/r8188eu/core/rtw_mlme.c       |  64 ---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  96 -----
 drivers/staging/r8188eu/core/rtw_p2p.c        |   7 -
 drivers/staging/r8188eu/core/rtw_recv.c       |  58 ---
 drivers/staging/r8188eu/core/rtw_rf.c         |  17 -
 drivers/staging/r8188eu/core/rtw_sreset.c     |  30 --
 drivers/staging/r8188eu/core/rtw_xmit.c       |  23 --
 drivers/staging/r8188eu/include/ieee80211.h   |  31 --
 .../staging/r8188eu/include/osdep_service.h   |   4 -
 drivers/staging/r8188eu/include/recv_osdep.h  |   2 -
 drivers/staging/r8188eu/include/rtw_efuse.h   |  11 -
 .../staging/r8188eu/include/rtw_ioctl_set.h   |   8 -
 drivers/staging/r8188eu/include/rtw_iol.h     |   1 -
 drivers/staging/r8188eu/include/rtw_mlme.h    |   6 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   4 -
 drivers/staging/r8188eu/include/rtw_p2p.h     |   1 -
 drivers/staging/r8188eu/include/rtw_recv.h    |   5 -
 drivers/staging/r8188eu/include/rtw_rf.h      |   1 -
 drivers/staging/r8188eu/include/rtw_sreset.h  |   1 -
 drivers/staging/r8188eu/include/rtw_xmit.h    |   3 -
 .../staging/r8188eu/os_dep/osdep_service.c    |  49 ---
 drivers/staging/r8188eu/os_dep/recv_linux.c   |  14 -
 26 files changed, 1505 deletions(-)

-- 
2.33.0

