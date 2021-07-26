Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B823D5C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhGZOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:12:33 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47760
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234721AbhGZOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:12:09 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 780DD3F322
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627311152;
        bh=P0l7ucawZtHhjUJpWjjS78w5LayhCUV4MmW7+VY+YFU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=mweqI1ywT2MEPAGkv5aGUpzkJRW0/+QKeLqdWmjagINa+9DGJdai4u9TH2wWwGcFn
         U2uMJl8KA4ivA6UT1QLt3Yaxott7m93hZexIjFPqQpvsiZFic5cAvgTIMp12EC4Ite
         UXccgkbuzWgGGInfBlXu4AVgiKgQTYJSqpCOU+3ZyNMVAn0C8Hdo6EIgaPtXHX9tZy
         ngoMVnHiZII8bePaMALnwSr+cgA6PZb4n1MD6l2Sl1eriHvg1x+f27GTbReShYqzjW
         l0x01V8AUwqn9zbzZEE6A+r01kpbiS+RPfVV003CRBekGwT0/epkNU9qvym6YuZqbn
         ITkCwtsPx2xUA==
Received: by mail-ed1-f72.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso4847112edh.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0l7ucawZtHhjUJpWjjS78w5LayhCUV4MmW7+VY+YFU=;
        b=EiWEEO+TDIaYq4KFs+jq8BjQ33g3q6gUlW4OEcB0JkATbKOmMPYh7PWah7J39xic+p
         jUBXqs2Rhn0Ip2MoKIQYoKvsjkOrsKqxtFpdH+V0uVp/Pw8wlcAcDfTsfcq7TXmWb6fj
         KyAY4i+5NhNeM+GssxnBNLbK1/z7pQWJzSDHyT+p/s6hXn9xGLIb//UPl9oBG6vVrJ9k
         Y+GfU4/0NAQNscxtC5Kb+pf355dBs5t8KpcxMerF825/HoWOjk4e9wm8QRQL48bGtIHe
         BWTSHuO7+lYmh3dVFKQ4dHc2t8JvyCPCHz4jxUXAtGeWol0xhTUFKewckEfjD9+Msvz5
         KjZg==
X-Gm-Message-State: AOAM5335USrPbFlypUfxdPUpOgHzDCB4opOBvJEYLpoMton6g4v4qc+4
        q2utUTPsc+VYptRM9vmCrRciu6mYZ8Yv/IcZGPdUDLkEUsH05GLZHF4SKC4yY3tE48OvgjfEBLg
        w3fSJvUk1mUuqJy0U9sheapI1cziycKO6N64j7/MBPQ==
X-Received: by 2002:a17:907:e87:: with SMTP id ho7mr17518025ejc.184.1627311151436;
        Mon, 26 Jul 2021 07:52:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbGOBrT7HrBw1RufsByTXKDeTJ2h4upbT0ndwDrZuwP/ONxaeOmoEJ+bHKjJt9zMXOsmYbKA==
X-Received: by 2002:a17:907:e87:: with SMTP id ho7mr17518017ejc.184.1627311151224;
        Mon, 26 Jul 2021 07:52:31 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id l16sm12750753eje.67.2021.07.26.07.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:52:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bongsu Jeon <bongsu.jeon@samsung.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] nfc: constify pointed data
Date:   Mon, 26 Jul 2021 16:52:17 +0200
Message-Id: <20210726145224.146006-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patchset makes const the data pointed by several pointers.  Not
extensively tested, hoping most of it has only build-time impact.

Best regards,
Krzysztof


Krzysztof Kozlowski (7):
  nfc: annotate af_nfc_exit() as __exit
  nfc: hci: annotate nfc_llc_init() as __init
  nfc: constify several pointers to u8, char and sk_buff
  nfc: constify local pointer variables
  nfc: nci: constify several pointers to u8, sk_buff and other structs
  nfc: hci: pass callback data param as pointer in nci_request()
  nfc: hci: cleanup unneeded spaces

 drivers/nfc/pn544/pn544.c  |   4 +-
 include/net/nfc/nci_core.h |  18 ++---
 include/net/nfc/nfc.h      |   4 +-
 net/nfc/af_nfc.c           |   2 +-
 net/nfc/core.c             |   6 +-
 net/nfc/hci/core.c         |   8 +--
 net/nfc/hci/llc.c          |   2 +-
 net/nfc/hci/llc_shdlc.c    |  10 +--
 net/nfc/llcp.h             |   8 +--
 net/nfc/llcp_commands.c    |  46 +++++++------
 net/nfc/llcp_core.c        |  44 ++++++------
 net/nfc/nci/core.c         | 134 ++++++++++++++++++-------------------
 net/nfc/nci/data.c         |  12 ++--
 net/nfc/nci/hci.c          |  52 +++++++-------
 net/nfc/nci/ntf.c          |  87 +++++++++++++-----------
 net/nfc/nci/rsp.c          |  48 +++++++------
 net/nfc/nci/spi.c          |   2 +-
 net/nfc/netlink.c          |   2 +-
 net/nfc/nfc.h              |   2 +-
 19 files changed, 254 insertions(+), 237 deletions(-)

-- 
2.27.0

