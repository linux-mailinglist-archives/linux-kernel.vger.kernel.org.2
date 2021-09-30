Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96CD41D160
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbhI3CZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3CZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:25:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8445C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:24:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x8so2898528plv.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEWI0423/PRfxjLty8QeTE6Lf5eYEtIkwg1J70TQIqI=;
        b=KWC6PSy6aud4u1T3CDn/D2q0KFfxs9CUhRPNalJiNa9CLUXyKUNdcv7DiaijbLTeMt
         6Wtp2YdEdBE8Cg/SrzkALYkwCHhQkSH5UAPKQiccHwnfD2kNAsUSIs5LRur80sSohASp
         K4PMxrFfiBBgWcE6rpLwM0M+oto+N1ypSP3QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEWI0423/PRfxjLty8QeTE6Lf5eYEtIkwg1J70TQIqI=;
        b=2JYOKIIr0zSQBPIuBQyIge5Ejn3jsBczx6hOctZVNpfrjd8ZE4Dejol7xCoLBOH7dN
         +bzvxtv1BRsRL4Hdyor/M0HFp/6ORrMdrsuQRAWm5+N0fDD/rj9p85vmfF57A18CZo8T
         40wyje1NC9RwDN33Ig6DZWMd+/5K4/v4r8hNFxLpPn9I8qKYmEuiBRp1g1gRY/9anTFz
         k/1FxGvDUwzw2Eg1nlsBrPTwhqk7cK9x2heJymnTCrut1PxUJZ8Q3Ev54e0OAJcI8niN
         AwOkTJTr1AqIdI5IyfdEojmLkaAhmYA+UnHMNs4VSRehQqw6AkZp05gKy3cWyD7DnHXr
         wvrQ==
X-Gm-Message-State: AOAM530K1/SCrnDHs3LumIU1a6Gs1S+ItTqE6IVPCNRZFOTTPtMhIw5A
        oJuYVmhPLidNa3DC6Pfjm9RITNR8lR7TCQ==
X-Google-Smtp-Source: ABdhPJxZuuF5BohMrsCQ4IUczmedd5yjTGBIWNFK4FkdiqXcfDDvkepCgF82myoA+Z+iK1tKatAGyA==
X-Received: by 2002:a17:903:1207:b0:138:e2f9:6c98 with SMTP id l7-20020a170903120700b00138e2f96c98mr1755552plh.11.1632968652883;
        Wed, 29 Sep 2021 19:24:12 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:479:c131:ee9:f257])
        by smtp.gmail.com with ESMTPSA id 126sm898070pgi.86.2021.09.29.19.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 19:24:12 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/5] platform/chrome: Make cros_ec_pd_command() reusable
Date:   Wed, 29 Sep 2021 19:23:46 -0700
Message-Id: <20210930022403.3358070-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a short series to relocate and rename cros_ec_pd_command() to
cros_ec_proto.c. This function is useful for sending host command
messages, so the 1st 4 patches move it a more central location, and
modify the arguments to allow other users to use it.

The final patch updates cros-ec-typec to use the new function and get
rid of its own copy.

Prashant Malani (5):
  platform/chrome: cros_usbpd_notify: Rename cros_ec_pd_command()
  platform/chrome: cros_usbpd_notify: Move ec_command()
  platform/chrome: cros_ec_proto: Make data pointers void
  platform/chrome: cros_ec_proto: Add version for ec_command
  platform/chrome: cros_ec_typec: Use cros_ec_command()

 drivers/platform/chrome/cros_ec_proto.c     | 48 ++++++++++++++
 drivers/platform/chrome/cros_ec_typec.c     | 69 ++++++---------------
 drivers/platform/chrome/cros_usbpd_notify.c | 50 +--------------
 include/linux/platform_data/cros_ec_proto.h |  3 +
 4 files changed, 72 insertions(+), 98 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

