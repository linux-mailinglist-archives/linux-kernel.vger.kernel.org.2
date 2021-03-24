Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C65347CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhCXPu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbhCXPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:50:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCDC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:50:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e18so24956411wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izXHtp00Qyo59De+uNdVzosuHl+EhCiFQYmGaB3NbeU=;
        b=fAfNqhO67Tm4SbIzUwIhGYcToWSgXPOwf/Izs0y4rcCh6rSj6UQuKn4M+kpR2B3TMK
         dvM4Ojxd9gpP+Z53Pha5N0vkmDSXdr7YHG1OYTLjHm6zFvc6UjOJ5GMlOrGJSWu3tD5b
         xAsNyxdsRHEjTPOGVUwzF+DOf6YqLvbKaq4lpT4ecY7qtQxreV/dgEzBvRpjCS42JwBP
         Mem8D7diaIJkfx3D8hBC2a7PQbiRfwalwR066axqwyqQ10OQcb2tGXJT577hbP+qFpy0
         wtHy2oj48vubSvAWjeDylGpBs2UoSpXPIWruE6ljyH+B7blOJZjJPOu9gH/GOO1cXH+1
         26SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izXHtp00Qyo59De+uNdVzosuHl+EhCiFQYmGaB3NbeU=;
        b=b0yG4njlQ5oTG3v+jjKVbqQFop5irKxvO99NC0UP7CawuqRpOxW0omiPn1WFq1bYV1
         hEXwlicQs1oJiDWVoIxZPVO9+wdrWa0zqRFh4bJ7RSLHIBX71YBXPljEp5wjMhORsIEy
         w2LU0tpgH13s3M6HuLyqG0wEgGTDLucoieu9wWVsUYIBByji9mz1RiycYL9wD6R0S50Q
         iDnVLW+Z8PgDOn77q3m8BDuBJriH0OFdjSuR1PFdct8LXMj/4PTSPIgNMZ9MlZvGCpBt
         T5kjP8vPmKmZbBaui/Zm5iR7ujgK10+q2R1p7z1FBX+XILxnDd/c83twS7zbUFwW36lG
         /8KQ==
X-Gm-Message-State: AOAM533gI/1dsbVLk+7Pq+WiE0U6CY9OSx6JIXocu0kNF0JsmFY9QAeL
        x03t69R1N4dGBNOi5dRT0TX3BaBRLp0=
X-Google-Smtp-Source: ABdhPJzNaAZ2WVQLcvj1npiQboGwDS6G+JVmgMPmodEKP/J6VqTCYgNPC2hRrNmfUqBzQhJj4Hyt/A==
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr4203339wra.419.1616601049314;
        Wed, 24 Mar 2021 08:50:49 -0700 (PDT)
Received: from agape ([5.171.72.168])
        by smtp.gmail.com with ESMTPSA id u2sm3600578wmm.5.2021.03.24.08.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:50:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 0/3] staging: rtl8723bs: remove assignment in conditions
Date:   Wed, 24 Mar 2021 16:50:33 +0100
Message-Id: <cover.1616600897.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all assignment in conditions in rtl8723bs, 
warned by checkpatch.pl

Fabio Aiuto (3):
  staging: rtl8723bs: remove assignment in condition in
    core/rtw_ieee80211.c
  staging: rtl8723bs: remove assignment in condition in
    os_dep/ioctl_cfg80211.c
  staging: rtl8723bs: remove assignment in condition in
    os_dep/ioctl_linux.c

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c    |  5 +++--
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 13 ++++++++-----
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    |  9 ++++++---
 3 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.20.1

