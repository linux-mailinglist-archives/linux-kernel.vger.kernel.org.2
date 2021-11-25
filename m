Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7BD45E13E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350614AbhKYUFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349970AbhKYUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:03:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95210C06175C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so13909951wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KS6RiUdjt27X6hxnbtiq414OVvlBCUbwLO8x8hx0P1s=;
        b=bukNTslaLbTyX8iFzV5F5TWJT02FEphXZWHpNBgZ/ZK1A1EY7pfCurB+mfmQDV4qSH
         CLVFVTtr7/po8dxhK+z50u8gtDPOjD2Acngp51Cpxq8XJRQGbCj762dwqb1JaIPNxwiP
         JispjwHWannm9eVfj2xdTaMcU9HpSin/9ykIsF1MbLbPEBK2n+3h2E7xrTsnjXhREnXj
         0Ktl0gVUXPsEH4k8rMX9Tm0kxP3L5BSF3wZpR3TanzM8pTT5SCYV2Dk1fwpxVArZxNsx
         tyZfdWRbYRNyZUBmIxKzCbTxwLbFBb6lPqKeSjU2O7r+MsxOlpfL1NTCQy2zdhJeUvp9
         2/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KS6RiUdjt27X6hxnbtiq414OVvlBCUbwLO8x8hx0P1s=;
        b=hHcU4oxETQufEbp8Ns36RZEsNMz2vvRQZfpidC5COrDxqp663NOSVIOvIMivp47GAA
         SVlgCpJVOMsUhcFk2492Aog8jAHUYttiLQIGfiuoyMbUoJfKNTQht7gsL4nnFEfppTBG
         w7tcUlfJJsaXfaCV3/B695MaNapIIctPU2wlk7R+dgC+M+LQ6x4mep9CcN4hlkFAxZej
         bFv1+06Ce/4gsUBRAlflpNLghNSktbQU+POLWSl8lgJ1YGWZTH123+UMSSgfhHtHHSxW
         1w5PSubVdxeUOVMeeylR603WFEOcNbpaFn61Glb7fwLtfWMg+6qAsOu4AoGooZll40mT
         exsA==
X-Gm-Message-State: AOAM532mT76yFFACrv6QeCUYi+zBDRZrmGyfkFmoAyWLdWA2BJwWVcma
        t1VqYbHZazK/CYLjz56a1zw=
X-Google-Smtp-Source: ABdhPJzVWBsdz8kAeieJkGYlcWhGTG0jVZNpZm7BxBhMr2004UwIp8hPzHFE2SuHkGVjfrm3n/n1Eg==
X-Received: by 2002:a05:6000:547:: with SMTP id b7mr9619488wrf.543.1637870388265;
        Thu, 25 Nov 2021 11:59:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id h13sm3762721wrx.82.2021.11.25.11.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:59:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove more usages of rf_type
Date:   Thu, 25 Nov 2021 20:59:31 +0100
Message-Id: <20211125195936.10060-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some more usages of rf_type to get one step
closer to remove rf_type from the hal_data_8188e structure.

Tested with InterTech DMG-02 on x86_64.

Michael Straube (5):
  staging: r8188eu: remove rf_type from rtw_update_ht_cap()
  staging: r8188eu: remove rf_type from issue_assocreq()
  staging: r8188eu: remove rf_type from storePwrIndexDiffRateOffset()
  staging: r8188eu: remove rf_type from getTxPowerIndex88E()
  staging: r8188eu: remove TxCount from getTxPowerIndex88E()

 drivers/staging/r8188eu/core/rtw_mlme.c       | 12 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 25 ++----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 85 +++----------------
 3 files changed, 20 insertions(+), 102 deletions(-)

-- 
2.33.1

