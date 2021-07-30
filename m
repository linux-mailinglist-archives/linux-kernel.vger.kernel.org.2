Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA93DBAD1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhG3OmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:42:18 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44726
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhG3OmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:42:17 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 822E33F047
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627656131;
        bh=wofNY4jh0EeYONXo5ssRVDRpz3oYBXrS11XkjMwqwQw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=dstO061qhRzaIUR04Za6rsKuMgcpfY9KIWs/WdRPhlj27DXrxLyC6tLsTMq2ACVFo
         uh4N5IVT/BthBvIgeIkYEd4XRhNarzdZx6Or1DsnOioyklynbWfiYI05aPB5WSV5Qb
         vXNcaKCfuEDxRwnrH5oJLbuoBfsoMQeX90RXmauFb8AFHMrESGAyvSoWqfTq0bCfzC
         htJiBCDh3D0ZvITlyr+ptExVcwg/9r5W9rw81EVWtywT1GIz1RrnjhGLo6yQZQJuFG
         yzO9Xo6gn8EuiT1ShxEHUa1jMR7EOA9afJwXvSyQalVEz0mSk3tZkOpMIaPNmc3jc1
         Pa8+mM5uvtTWg==
Received: by mail-ej1-f69.google.com with SMTP id x5-20020a1709064bc5b02905305454f5d1so3155596ejv.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wofNY4jh0EeYONXo5ssRVDRpz3oYBXrS11XkjMwqwQw=;
        b=mPzMeQ4ef1qDYxwyQl3xyTGYg8WjVKYA0HpL1N4yRFXrRpYNTg2aaObULPaLrXttT/
         GSq/LGReqjWICt4xS6n2J8OveklYAi05RdSNb250aW3BDb3WjVNTVGg4o7MvYUIgdREw
         iyTeTs/HRbrYQ56k9AmjfVZ6Lsb+yeGHOIJr4RUnFwVQnP9kGK9yo9k1lHVeEQrI3zdk
         /s+jmgpF2V/zzgVk4AWh6Y4dGHES9ADGCNlyurQ00KEcDQeaUVkU1wv0Edvw9qiz9ew0
         OisowxoRbqT176DZGdzNcmfGnN0TNqgJO2LgL1jR9KJJtsJo0bzkpnnWJyK9W5hjO159
         aGtQ==
X-Gm-Message-State: AOAM532LM46woNf1mmbBjRf5u7xSZ5FJ0wvfOxiKBR/uOdF3/b4AIMZI
        lxwZ4K0YYYVOXlWAQRrAMfaqrrBW+3vW6g12LQDLbOhhG6QHOm2DZ97iUerYkLh7LuhcFpaTSaU
        SGeR9wzX0vM1iRaZcnkp38rdk/vXHvS1l4ZzA+LCMng==
X-Received: by 2002:a17:907:6218:: with SMTP id ms24mr2871040ejc.367.1627656131224;
        Fri, 30 Jul 2021 07:42:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo7sQHS6Q74F1QUHjdt7MuN7lL1fXicUfjd5B60lldUBFvvc3BbXXsh7pFKlQqUeqpAPjfGQ==
X-Received: by 2002:a17:907:6218:: with SMTP id ms24mr2871028ejc.367.1627656131029;
        Fri, 30 Jul 2021 07:42:11 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id z8sm626325ejd.94.2021.07.30.07.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:42:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] nfc: constify pointed data - missed part
Date:   Fri, 30 Jul 2021 16:41:55 +0200
Message-Id: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This was previously sent [1] but got lost. It was a prerequisite to part two of NFC const [2].

Changes since v2:
1. Drop patch previously 7/8 which cases new warnings "warning: Using
   plain integer as NULL pointer".

Changes since v1:
1. Add patch 1/8 fixing up nfcmrvl_spi_parse_dt()

[1] https://lore.kernel.org/lkml/20210726145224.146006-1-krzysztof.kozlowski@canonical.com/
[2] https://lore.kernel.org/linux-nfc/20210729104022.47761-1-krzysztof.kozlowski@canonical.com/T/#m199fbdde180fa005a10addf28479fcbdc6263eab

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  nfc: mrvl: correct nfcmrvl_spi_parse_dt() device_node argument
  nfc: annotate af_nfc_exit() as __exit
  nfc: hci: annotate nfc_llc_init() as __init
  nfc: constify several pointers to u8, char and sk_buff
  nfc: constify local pointer variables
  nfc: nci: constify several pointers to u8, sk_buff and other structs
  nfc: hci: cleanup unneeded spaces

 drivers/nfc/nfcmrvl/spi.c  |  2 +-
 drivers/nfc/pn544/pn544.c  |  4 +-
 include/net/nfc/nci_core.h | 14 +++---
 include/net/nfc/nfc.h      |  4 +-
 net/nfc/af_nfc.c           |  2 +-
 net/nfc/core.c             |  6 +--
 net/nfc/hci/core.c         |  8 ++--
 net/nfc/hci/llc.c          |  2 +-
 net/nfc/hci/llc_shdlc.c    | 10 ++---
 net/nfc/llcp.h             |  8 ++--
 net/nfc/llcp_commands.c    | 46 +++++++++++---------
 net/nfc/llcp_core.c        | 44 ++++++++++---------
 net/nfc/nci/core.c         | 48 +++++++++++----------
 net/nfc/nci/data.c         | 12 +++---
 net/nfc/nci/hci.c          | 38 ++++++++---------
 net/nfc/nci/ntf.c          | 87 ++++++++++++++++++++------------------
 net/nfc/nci/rsp.c          | 48 +++++++++++----------
 net/nfc/nci/spi.c          |  2 +-
 net/nfc/netlink.c          |  2 +-
 net/nfc/nfc.h              |  2 +-
 20 files changed, 206 insertions(+), 183 deletions(-)

-- 
2.27.0

