Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9738FF10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhEYKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhEYKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:31:19 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7143C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:29:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l19-20020a0ce5130000b02901b6795e3304so30047490qvm.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zoy+4W/3/sbzCy2eBQFApCM1tWMVKvshKU4YFh54bgs=;
        b=a8FudH0wExQkY7wLuZMDUOjwr4S7wJFralFBImSl2T+58oBJi/suoDa6+ZxRHqbK4V
         Zwd9IED4hCPZAoE5caYJ+/I/LXw0y2VwVaMdgjwpZRJ2rIqTm8GPqWNy3ZF1lX6kIBbp
         Z7ggciKTRy3+0gWn7ePsX+U2HqqVMl7J1dHfZ3/T6e06ARz3J01qV7f/D0sfsUwe2lf6
         bMqeYR+pEYWdFxKJVok8lU/HrMSI5WpDTPZjU1nbrtkTjmk7f28Hp7mokC0eVOcyj9se
         KkPzU9q0U/LkAKq0rRl9emYwO771FFckUGKdbhJtctoQ73hXRXbWquGThIxctFrwP4w9
         qRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zoy+4W/3/sbzCy2eBQFApCM1tWMVKvshKU4YFh54bgs=;
        b=cRjgnnw0v1Vft6Vdgadf7vRXYnRA+PeQnwHbaT0NBoCYSLekr78U3fkT68Qa9FWqBl
         L/DBdEiFXGCHhVbGsenE+aIZU7NQCar3m5iOmxaszWQltPsfqNoUpXGcLvQvPO+UTEAO
         wN10k2QLryWsU6APlCxVSn0DbZLn1Cf6fBbCQiLYZh9B1Q3Jmzlz7DUSgzRCb6qVno2W
         PemF+xyXErGZSVrsoToDgwQc0HQHbJy5pfTRrA9Krt2z3Ve7Xhqimw2LkmXKC0bSPpRg
         QZ3uobshgO6KFreDScuFKs/8iOOmYZvKtZNF0/A4EJgoj9Z6I+L9pJQdyKrVqrZQ4pyO
         RJ1g==
X-Gm-Message-State: AOAM5309l25VRQHxuakgEsApajUszyML5M/JeVHlOyynsaOpABRh44j+
        SyoiTS0lQrf8jogFBx9vUNrIvXt4uCrl
X-Google-Smtp-Source: ABdhPJwXVbnEqm9XK/f6kHGLi6eohydjkOT23hK7pu/W7KHN2GRKxAnwxEvItAkIYhILzWcgjqYPSqM0jxXV
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:ad4:53cc:: with SMTP id
 k12mr35863559qvv.49.1621938588615; Tue, 25 May 2021 03:29:48 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:29 +0800
Message-Id: <20210525102941.3958649-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 00/12] Bluetooth: use inclusive language
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Miao-chen Chou <mcchou@chromium.org>,
        "=?UTF-8?q?Ole=20Bj=C3=B8rn=20Midtb=C3=B8?=" <omidtbo@cisco.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
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

There are still three occurences in debugfs (patch 09/12) in which the
original less inclusive terms is still left as-is since it is a
file name, and I afraid replacing them will cause instability to
other systems depending on that file name.


Archie Pusaka (12):
  Bluetooth: use inclusive language in HCI role
  Bluetooth: use inclusive language in hci_core.h
  Bluetooth: use inclusive language to describe CPB
  Bluetooth: use inclusive language in HCI LE features
  Bluetooth: use inclusive language in L2CAP
  Bluetooth: use inclusive language in RFCOMM
  Bluetooth: use inclusive language when tracking connections
  Bluetooth: use inclusive language in SMP
  Bluetooth: use inclusive language in debugfs
  Bluetooth: use inclusive language when filtering devices out
  Bluetooth: use inclusive language when filtering devices in
  Bluetooth: use inclusive language in comments

 include/net/bluetooth/hci.h      |  98 +++++++++++++-------------
 include/net/bluetooth/hci_core.h |  22 +++---
 include/net/bluetooth/l2cap.h    |   2 +-
 include/net/bluetooth/mgmt.h     |   2 +-
 include/net/bluetooth/rfcomm.h   |   2 +-
 net/bluetooth/amp.c              |   2 +-
 net/bluetooth/hci_conn.c         |  32 ++++-----
 net/bluetooth/hci_core.c         |  46 ++++++-------
 net/bluetooth/hci_debugfs.c      |  20 +++---
 net/bluetooth/hci_event.c        | 114 +++++++++++++++----------------
 net/bluetooth/hci_request.c      | 106 ++++++++++++++--------------
 net/bluetooth/hci_sock.c         |  12 ++--
 net/bluetooth/hidp/core.c        |   2 +-
 net/bluetooth/l2cap_core.c       |  16 ++---
 net/bluetooth/l2cap_sock.c       |   4 +-
 net/bluetooth/mgmt.c             |  36 +++++-----
 net/bluetooth/rfcomm/sock.c      |   4 +-
 net/bluetooth/smp.c              |  86 +++++++++++------------
 net/bluetooth/smp.h              |   6 +-
 19 files changed, 309 insertions(+), 303 deletions(-)

-- 
2.31.1.818.g46aad6cb9e-goog

