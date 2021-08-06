Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CEB3E200F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbhHFAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbhHFAkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:40:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258C7C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:40:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id x17so4461152wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 17:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oISZJr8Fi5GT7T+pxi9D17g6rw6l8wM7jO5drTaEEK4=;
        b=kN0CLFbFWMQ4cIrPs5JEohh3co8KFaSsU7OdRzME8Ive6wCTyl+48lLhM/b4ctrkFq
         PJYliLqXc0z6f6xEfl6FCGWHfXYXL9b0dvbS/2bG7vAJ8U2tUtuXNC7N5PJRYg0zbtfY
         dwP8vL2J60WkIJ9KtWdetrzWW4Yodv91p/fBgxmruprtd2VeJD2YK5RWhyfCN8pa5m7P
         RnxtafT7uNO2p38DnBizOBPSmiFHORZ2jxQVOzIJt7vhUim2w5ZHjJv5yX5rwuGXll8J
         Wz9MGBoGNNFh4f+X2b1P4fLOzHBOyWJG44D8gh76u7o/PkY5U5aWKakg94YndkQOkhEX
         snkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oISZJr8Fi5GT7T+pxi9D17g6rw6l8wM7jO5drTaEEK4=;
        b=LMmfsxGjYXSEYeIwynXBq9SZRPMchxJ4mGJsHh3GiJ/yjpb7IxNCF/s5jN2SkGW23I
         y0MFbdnVpbgX91BwAlBG1ko26r1BcrpPGY/p7rIr++ZrEg9d78qCTVD52yNLEWVsHhxP
         8d79iiTqkI/r0blFMKDHoC8ixuQWRWhDr6+r2T6rq6RbvECIy32D/H0IHD5nYrweZJH4
         GOCFXf3iJnRkOk7iEnLUCC7r19vzxtC0JnZXeMxz3YqfEL9rrpIEPxdL48lec2nM833Y
         2/mXAJ//gDIgMkog0+SKf25ISR9HwaireelY0NRn6t2uCpL+0+MSK/NK4ycVn5Zzf2we
         /D6A==
X-Gm-Message-State: AOAM531nMa7HNl/6i99pov2aZf3fp8ss4kpKj31PdFX4WQZPkn8cHDrb
        vRBdXV8OJlg8EQueDn3X+7ypAM7RXvjU0fQT
X-Google-Smtp-Source: ABdhPJz3bhWxi7JOdsCUygLq0dX5WsnnzbXYpj9WGzm7a5l0pdNXVD77SR6dU7ONFEBy7afgydOtbQ==
X-Received: by 2002:a1c:a4c1:: with SMTP id n184mr683384wme.8.1628210437202;
        Thu, 05 Aug 2021 17:40:37 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y19sm10727181wmq.5.2021.08.05.17.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:40:36 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH v2 00/11] staging: r8188eu: remove core dir RT_TRACE calls
Date:   Fri,  6 Aug 2021 01:40:23 +0100
Message-Id: <20210806004034.82233-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v2 series just contains new versions of the patches that could not
apply to the staging-testing branch due to the level of change caused by
other commits. It also fixes up some kernel test robot warnings
introduced by the patches that did merge properly from the first series.

Phillip Potter (11):
  staging: r8188eu: remove RT_TRACE calls from core/rtw_cmd.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_ioctl_set.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme_ext.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_mp.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_security.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_sta_mgt.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_xmit.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_recv.c
  staging: r8188eu: fix unused variable warnings in core/rtw_ieee80211.c
  staging: r8188eu: remove two set but unused variables in
    core/rtw_mp_ioctl.c

 drivers/staging/r8188eu/core/rtw_cmd.c        |  66 +-----
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |   4 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 218 +-----------------
 drivers/staging/r8188eu/core/rtw_mlme.c       | 130 +----------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  39 +---
 drivers/staging/r8188eu/core/rtw_mp.c         |  12 +-
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |   6 +-
 drivers/staging/r8188eu/core/rtw_recv.c       | 161 +------------
 drivers/staging/r8188eu/core/rtw_security.c   |  44 +---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |   8 -
 drivers/staging/r8188eu/core/rtw_xmit.c       |  83 +------
 drivers/staging/r8188eu/include/rtw_mlme.h    |   2 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   4 +-
 13 files changed, 53 insertions(+), 724 deletions(-)

-- 
2.31.1

