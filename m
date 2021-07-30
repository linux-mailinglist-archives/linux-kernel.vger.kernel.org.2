Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57D83DB404
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhG3G5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:57:03 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:55274
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237600AbhG3G5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:57:02 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id E6D923F0FF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627628216;
        bh=H0iqXvcx2Sb6gUihpF2rOO1152k8ULgDqjgBbDt6/wQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=WuoCXE7p1ViXZA1n9mL0SYV+xIkaEp7ILvOr00UfwLZjFfYmmjQPnQITUIQUsvJqJ
         ifNKNkE7OZUUXHnhalqaVoWE2zdmIJvctb7zebqqUrNkaQF93UUL5R9Ug9Rw8LN8ED
         3kc9Qy3nuNfEkPK+uEY455wA71DdPBIuCuYndlVG4uHsvMubU4sntDvx+RCnEwXLj3
         YS8jYM/m06Fvp5gpz3UT4qleQ8G+JgSvidzLRzeJZwioUEQALjwlNCvVogDpR2t+pR
         gnPFfNaPAtyW1oYaYDJ0LSErFtMZ4hYZEgPH1RGLugtDMjsGRQZm8CLqZq8RpmSnWJ
         fPAVOe5iGB16g==
Received: by mail-ed1-f72.google.com with SMTP id b13-20020a056402278db029039c013d5b80so4161822ede.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H0iqXvcx2Sb6gUihpF2rOO1152k8ULgDqjgBbDt6/wQ=;
        b=o01ACgPY23KfCNyIzlF0Npt383K3WZ/2V2nFbqC0wDL5jRdqLsNhZuPrgqnlxMOH+i
         9O7YIOaeeR3tzA5WBV358DL2kZIwWZ/kPuOi8IyqYWKDYQdDajTRybOzrKpRKEOE76Qa
         Xa1CqeEpfimvkSv+2OsR7QrfrXs2Llz5twZ9sj/Ou650joO3IkqHZUF4Ynwi524yuxDI
         Np3Snxw6ZLCKJ0T8YQ6EHJNPC16WZMhMRnP44vT3K+jwR587LDzklg1MPuRwSqD1mbWH
         NWJmUOCS+sDKASkWhjihXZqltLEPq8nMn6JrMtQ6HVyXGDq09zxqHuHKocpScP8xJC6j
         mxNw==
X-Gm-Message-State: AOAM532GdzUypa3cVEJLCl5Mp/L0HP/EMwgpWYyyVAkASl4qxNm2mgBn
        OVfNcOYraKFc8yJG27O0iZfhv6hsom07GI7U84KD0ipvl5bOZCZZYcsHyQDKyVrklbx+5kAxaz/
        96dmvLVxrd0IAoszbx83iwgb1OkFaN/vm05G17tuouw==
X-Received: by 2002:a17:906:9251:: with SMTP id c17mr1210630ejx.516.1627628216643;
        Thu, 29 Jul 2021 23:56:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdiRODyaxS5ozEQ1SGCvSq92XcTRg9NN5AZlQaqiA2V+ZljzQ10rzB6+WfdmPHGFnit/Pcsw==
X-Received: by 2002:a17:906:9251:: with SMTP id c17mr1210618ejx.516.1627628216466;
        Thu, 29 Jul 2021 23:56:56 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id m9sm238518ejn.91.2021.07.29.23.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 23:56:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] nfc: constify pointed data - missed part
Date:   Fri, 30 Jul 2021 08:56:17 +0200
Message-Id: <20210730065625.34010-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This was previously sent [1] but got lost. It was a  prerequisite to part two of NFC const [2].

Changes since v1:
1. Add patch 1/8 fixing up nfcmrvl_spi_parse_dt()

[1] https://lore.kernel.org/lkml/20210726145224.146006-1-krzysztof.kozlowski@canonical.com/
[2] https://lore.kernel.org/linux-nfc/20210729104022.47761-1-krzysztof.kozlowski@canonical.com/T/#m199fbdde180fa005a10addf28479fcbdc6263eab

Best regards,
Krzysztof


Krzysztof Kozlowski (8):
  nfc: mrvl: correct nfcmrvl_spi_parse_dt() device_node argument
  nfc: annotate af_nfc_exit() as __exit
  nfc: hci: annotate nfc_llc_init() as __init
  nfc: constify several pointers to u8, char and sk_buff
  nfc: constify local pointer variables
  nfc: nci: constify several pointers to u8, sk_buff and other structs
  nfc: hci: pass callback data param as pointer in nci_request()
  nfc: hci: cleanup unneeded spaces

 drivers/nfc/nfcmrvl/spi.c  |   2 +-
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
 20 files changed, 255 insertions(+), 238 deletions(-)

-- 
2.27.0

