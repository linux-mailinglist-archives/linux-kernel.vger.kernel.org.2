Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17E39571E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhEaIkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhEaIj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:39:56 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C35C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:38:17 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id n12-20020a0c8c0c0000b02901edb8963d4dso8474850qvb.18
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tjbMdWg4PO8/eooobp10b8z1ZpbzFZFdpuK8M8h0fLo=;
        b=tDvDLZe5WhMR+9XN/fr/hQFwABYjIvNU2JvatJfqPzN09JN5eP5aMIpPZaEeJZUxZY
         iLgzoLZyhlaX1/9fSyOy/Y/IGjWO7AKtEUHMU8Ws5NDka2dncaU9hI20X/nOxaDWnXKV
         sKMKz51/ZuKer9sdM44wJWpTx7JBx6/Cm0GHRTSUY4VDDtQQ4GY5azSu4nZ16QZI4r5a
         YDifmvyjaBsxo93NaVvDnLcd+wlVfR/Wm/5wyb7bW6YCERNi9x5xVkpecboEJqnJSzzc
         u8ugRJNiUCcDoMn2h/zDs57lrS8JkgZhTQzGud5zBjzcJ44xPj5OcjR068vsXi8KToE3
         cPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tjbMdWg4PO8/eooobp10b8z1ZpbzFZFdpuK8M8h0fLo=;
        b=qKvT0U9Mm8p61AxCL4OSa6HP3KS9rkC8vEm/3RFn+Bn60+fBrMeEPmuK/PrUynVcbG
         c8YgNgdGFKjP/EusDIbxRfM7JAJcc8EcWcFf/5Ltr3UZEvX34FUe/83L9S0fWDALuLMh
         wzn2fTiQvw855sjMyMvei4eK1hAkI61vvoAJ87ounaD3DPV2r+3p/7PLH9RwbfEnNbtm
         2a3lAQUg2Klx5R6WjyS+O3JDlODBvLGfYfQM/gXg4zxRCDXgYXrO6OE1dth2vO5BKMUv
         SkSLTUJZrlyyMS4v9eVaYYVhf6ZCyYoOV2ZHtquVYw2WNfJL0oPK7qWgzGI0gdN2ZukP
         dyoA==
X-Gm-Message-State: AOAM530197PBHHyhd1Davr+n5qZWLyj3LUIN8NOMluI8vrX+RITNHr8g
        B+XtI90oD8TERBTGsKz2xK7zhgP33LPu
X-Google-Smtp-Source: ABdhPJyZcRoSDWVH/ygFRbiMzdMkaOGR+gYo0Zl1J7DcUhFoU2h2bta9jDlzmoiu76s2GQUJ+4RIKL/jyly9
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:a6d1:a727:b17d:154e])
 (user=apusaka job=sendgmr) by 2002:a05:6214:246a:: with SMTP id
 im10mr15568895qvb.2.1622450296211; Mon, 31 May 2021 01:38:16 -0700 (PDT)
Date:   Mon, 31 May 2021 16:37:19 +0800
Message-Id: <20210531083726.1949001-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 0/8] Bluetooth: use inclusive language
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "=?UTF-8?q?Ole=20Bj=C3=B8rn=20Midtb=C3=B8?=" <omidtbo@cisco.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Hi linux-bluetooth maintainers,

This series contains inclusive language patches, to promote usage of
central, peripheral, reject list, and accept list. I tried to divide
the change to several smaller patches to ease downstreamers to make
gradual change.

There are still some occurences in debugfs in which the
original less inclusive terms is still left as-is since it is a
file name, and I afraid replacing them will cause instability to
other systems depending on that file name.

Changes in v2:
* Add details in commit message
* SMP: Use initiator/responder instead of central/peripheral
* reject/accept list: Was actually two patches, squashed together
* Drop patches in L2CAP, RFCOMM, and debugfs

Archie Pusaka (8):
  Bluetooth: use inclusive language in HCI role
  Bluetooth: use inclusive language in hci_core.h
  Bluetooth: use inclusive language to describe CPB
  Bluetooth: use inclusive language in HCI LE features
  Bluetooth: use inclusive language when tracking connections
  Bluetooth: use inclusive language in SMP
  Bluetooth: use inclusive language when filtering devices
  Bluetooth: use inclusive language in comments

 include/net/bluetooth/hci.h      |  98 +++++++++++++-------------
 include/net/bluetooth/hci_core.h |  22 +++---
 include/net/bluetooth/mgmt.h     |   2 +-
 net/bluetooth/amp.c              |   2 +-
 net/bluetooth/hci_conn.c         |  32 ++++-----
 net/bluetooth/hci_core.c         |  46 ++++++-------
 net/bluetooth/hci_debugfs.c      |   8 +--
 net/bluetooth/hci_event.c        | 114 +++++++++++++++----------------
 net/bluetooth/hci_request.c      | 106 ++++++++++++++--------------
 net/bluetooth/hci_sock.c         |  12 ++--
 net/bluetooth/hidp/core.c        |   2 +-
 net/bluetooth/l2cap_core.c       |  16 ++---
 net/bluetooth/mgmt.c             |  36 +++++-----
 net/bluetooth/smp.c              |  86 +++++++++++------------
 net/bluetooth/smp.h              |   6 +-
 15 files changed, 297 insertions(+), 291 deletions(-)

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

