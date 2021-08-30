Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E61E3FB8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhH3P1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbhH3P1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:27:43 -0400
Received: from mail-wm1-x364.google.com (mail-wm1-x364.google.com [IPv6:2a00:1450:4864:20::364])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A072EC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:26:49 -0700 (PDT)
Received: by mail-wm1-x364.google.com with SMTP id g135so9060649wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RrIvaJZ/GjhxIo37rC4zzq6/oz+qoDd/3ecuQPVux5o=;
        b=BtInqqaRvi+tvj/zNMrgH4HVRQbXbX/Ba2rZoWVSeVgngTXvTbgvFp90mWeXb9IrCq
         +S3gfG263hc1pRVxg9L5dKqFeenwjwxryY2oowIU4Mu1IL9upOGqHuJhixyqFdK+z/dw
         2hXwVRDtSyszZWP6tJGkJr+WXL1iQoyuUWdfiq84UXH3qGSq9mYgZlIVvKnHbevB6PNI
         c59ZUL7l/WQFec1J3Z6nX7KO7c0sS/mnf8damXXOQ+/6w73VfREgsUnsuoNrnZx1/ii8
         sECfak2Ru22f7UymTUF5U9Rav87N2vysKbQYKNVt/IHsnUJhITwsX91OtUm8XFIkBnbu
         DJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RrIvaJZ/GjhxIo37rC4zzq6/oz+qoDd/3ecuQPVux5o=;
        b=ftznffb9kvXFFq4bFDXGjtQ4L97cYSMbtDgdH9dlwm5z6b/bbJJjtbvQBUfIVREk2q
         v/WeRZphAgQKQrK/BBFpuexhXI+nlYAU81xhbnRRNfp11szTMgm+6IwjKSsH52dwvfQ7
         i/qPyDY/BTwpGmlndjtXF/5tsDGPp4pJy+CnB8frufuUAZ6aUEYi4OQ+S2U3vVWspvHK
         LZBS3FiV4Z69+kb8Qt+iy1bIuxzKOKWhWmRcnXajn2eELyh/6VXANMMrgRtNXBlxb5xW
         unCtO4VRo+xg1wXIL85M7tti/xUWm5+Rn5+m4rtplLG9ZUiTvirZUdTIQkcD0Qdsoi1z
         X9hQ==
X-Gm-Message-State: AOAM533nq2hyeRt4uXXq/RRTiPLQx7hmWknpVFp4fQGLz1qKZy6Y2ohY
        S5As41bbrOCRwSdAjOimEc+QfvMlQyuNzhYIBNazqR1lrPC1
X-Google-Smtp-Source: ABdhPJwQT+w11PKVsAe8yvCQ/H4GqlvdAfEUkz0+LgLyA8XAPYXB9B4JwlvqNls5V+2PlbnwFylBF+8mUybR
X-Received: by 2002:a05:600c:3b9c:: with SMTP id n28mr15483219wms.184.1630337207746;
        Mon, 30 Aug 2021 08:26:47 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id g15sm388399wmq.15.2021.08.30.08.26.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Aug 2021 08:26:47 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.38] (port=37560 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1mKjBP-0005mz-AT; Mon, 30 Aug 2021 17:26:47 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH v2 0/3] rsi: fix startup and P2P mode
Date:   Mon, 30 Aug 2021 17:26:43 +0200
Message-Id: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes an occasional startup failure when BT
coexistence is enabled and makes P2P mode work
(the two are unrelated but sending as a series since the same files
are modified).

Tested on RS9116 in P2P client mode against an Android phone (S8, Android 9)

For an unknown reason GO mode does not work against the phone but it
does work against a second RS9116 device.
In this case Android does not send a response to the 3rd WPA handshake
packet. It is difficult to debug this without the phone wpa_supplicant
logs which I don't have.

Regression tested OK for STA and AP modes.

V2:
  * rebase against wireless-drivers-next
  * add cc: stable to patches 2 & 3

Martin Fuzzey (3):
  rsi: fix occasional initialisation failure with BT coex
  rsi: fix key enabled check causing unwanted encryption for vap_id > 0
  rsi: fix rate mask set leading to P2P failure

 drivers/net/wireless/rsi/rsi_91x_core.c     |  2 +
 drivers/net/wireless/rsi/rsi_91x_hal.c      | 10 ++--
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 74 +++++++++--------------------
 drivers/net/wireless/rsi/rsi_91x_main.c     | 16 +++++--
 drivers/net/wireless/rsi/rsi_91x_mgmt.c     | 24 +++++++---
 drivers/net/wireless/rsi/rsi_main.h         | 15 ++++--
 6 files changed, 72 insertions(+), 69 deletions(-)

--
1.9.1

