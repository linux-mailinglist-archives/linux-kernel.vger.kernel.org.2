Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78413B5E14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhF1Mgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbhF1Mgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:36:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47702C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:34:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p8so4966679wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4Piownw0Km7jYaWnqnZYrht6sXkD+M9EE5R9haJeqU=;
        b=RpmUcAWPAA24cki8FV8sIiR/T9iEYHriC0yCwfOOTb4uqcPcCoDIl5um61M0Q3JNhd
         HLRkEqXN2yGFQunfUq1oa3qpnJK4tA757J1lFxhMtcrYkTYFQ78IouFy8QcTrkoarB1i
         m5LRW4Lse26c2JMoWyM41aE6S4UknpZ0ergRk+TbCkxVBPppNAjf8B+FLYj7YdA/jhWc
         j59ruiM34M3XMVVDTLJ3Y46Fwh1xS5SvblR5JFnfoSUspQxn3dS7du34oa2vKwdAXyLQ
         gOxFT0cQnap+TR5FDfLeVOi0G6tEQf88cYFZTES+gIgRw9FyNgUM6PSUae1XYBBudQXb
         Fe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4Piownw0Km7jYaWnqnZYrht6sXkD+M9EE5R9haJeqU=;
        b=Mf2oN5kzHm5kcwytu4WzSuGkQ8ayYZghhiQuheS45r6bEKA1W1eCRAq6yDdbmUesUa
         W+AMbrGnk8WZ44SnzTsdMGB80RNnQJ/sGsvMx0np4zGIE9uujnSYFtQ/3mRhQStZTop0
         oIvxJNQbt7cTM80T8CJoUCgBXDk2XHh1iy8lAJ40n3gmhFEC4YOFqKiR8yFcjStikJ+O
         IS59pnLrdPLx4a++0WG6ltXlvFv1jKibuW2clachQizi/VMgIfyq78MEgh68zjCI6rZ3
         LvypDLq3njjhKo/dZb4wVldQbt/5NcPDF16iiBzDAcynlkmTWnwT7qwSFzF1xWMfnbmX
         nI5A==
X-Gm-Message-State: AOAM531mAy4o7mOlD9p5BCubDWd/dc3wXLEjNC4klJGhH00qEwBD1Qk4
        PH8ni1XXRWlagYzqtsqv1JhSlg==
X-Google-Smtp-Source: ABdhPJynXZUsQ+KCCA2PMCmxfxH2qhUAPGDL5BW7LSSONysZPkBA8RYkV5kdJNx/yJHplx94ajGkIw==
X-Received: by 2002:adf:fac4:: with SMTP id a4mr27567032wrs.189.1624883655814;
        Mon, 28 Jun 2021 05:34:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:e503:e76:4043:c4f7])
        by smtp.gmail.com with ESMTPSA id p7sm2357334wrr.68.2021.06.28.05.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:34:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jgg@ziepe.ca, leon@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, ulf.hansson@linaro.org
Cc:     torvalds@linux-foundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH RFC 0/2] scatterlist: add I/O variant of sg_pcopy & sg_copy and use them
Date:   Mon, 28 Jun 2021 14:34:09 +0200
Message-Id: <20210628123411.119778-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; h=from:subject; bh=iVEMvBLaRZgih5yGs1nmMY9KLw8WXAeUJcp1bYFUiBY=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBg2cGWtsGJ0XA8KWFoXtdBdbBZY/Eo9DjS/KkXuTzv 5/+iniKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYNnBlgAKCRB33NvayMhJ0XPhEA CcU6sOzBX3jxArz37tuZhTke4Yg6dNMPnsx19qObWnWEpWCFEdEzrPxjZH8d2shIfumiocFQt1tlQf NrsBokdpyV2jvNOgHBTsDGYfqBlxKE4tMytf5ooHTErzX9XraDT1cXZKBKAEcYiti/49Hgsd7NQQ3N NGEY0fI8LIpEFotO67MZ7zO9zjqqDnBqQYBpmCAW207JExawMCmAeWUfuV7lJhXqut5nX57hV3Ia6i IKu0l5t319rVU+tLJI7zcVEAZDP63rBK/GCAy4AdY/a2KzZHvjKYFh2MXwoFIx74Xdgzn+mp+pZHQ5 Gy1CZOHdaA7Nd9apmUfVxGq49AkH4GglixwfZC/U1n59sOfZvt3SvEi7LYBDDiORE9+mHr8Eo0DiW4 pGSEU7giItN3JyECFLqjnJt+wQJXZlQYn+nvJtaWz+O00wIA7vKQPl8PbNZGvQEIDdwJyRUdqXjvca +SHOa5/6FnOYt74n+VwOeiXbMXnFCW3mpbR8jdOyRd+oz+VQIE3J82S296md6xTQEe0oQ98nnQ2PUC SsxUoFHiBZyHwoAVVdgtAe+KtcJLSgvOkGmfK4ylJpCH6wxWeZmuecrNTghwCp8Q/x3fZ2Wyf8ogMG IM9QL/KQH/1DL1WHS0A8gqMFvLbjg1m3Xj1DnhnkZvfDbY4d8/Pn5cLa7LpQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A local variant of sg_copy_buffer has been introduced in the meson-gx mmc driver [1] after
a mempcy optimization, fixing the iomem buffer manipulation and the reported system crash [2].

But, the fix is suboptimal in terms of performace/ugliness [3] and a proper I/O variant of
sg_copy_buffer should be added and used instead.

[1] https://lore.kernel.org/r/20210609150230.9291-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/acb244ad-0759-5a96-c659-5c23003d3dcd@samsung.com
[3] https://lore.kernel.org/r/CAPDyKFrLSMpPJOgd5e4B1x3Vwfg4q23zgy4ESc8EmFL2MnyK7g@mail.gmail.com

Neil Armstrong (2):
  scatterlist: add I/O variant of sg_pcopy & sg_copy
  mmc: meson-gx: use sg_copy_to/from_io instead of local version

 drivers/mmc/host/meson-gx-mmc.c |  53 +++-----------
 include/linux/scatterlist.h     |  14 ++++
 lib/scatterlist.c               | 119 ++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 43 deletions(-)

-- 
2.25.1

