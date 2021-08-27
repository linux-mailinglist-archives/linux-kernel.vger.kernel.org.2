Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4833F975E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbhH0Jmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244824AbhH0Jmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:42:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83167C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:41:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so9467470wrn.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKt2tmYkZ0IptmRVmfOgQO1U+SQBIYl0R7WV2vqUGho=;
        b=cabkzZE1nV14beTnXHvEQ2SKv9m1DM8aNZk4QPtcfT27wQWld2aUEHQK4zc9gpI6g0
         rN0z0DvDMXhhtHHNQfxHo1qoz7x2eHHlX24WxTalD6xX4QOBwC+5FNUTi8TuVSqtC6mj
         RhL73T1piCF81qjSx4JYvjuxtRYhINI6g1V/DVBHHYGSFAlcsQ7KI3cZ7z/CaTOLTqYe
         sqEYH5BsuoOinINLpG2rMYho+GlU8yCxm9uXPjKaXekeviI2WbTjv5A8O+z9tzs5/5TR
         Xkqn1NpuW4XyA0xWcdm0mDk5jYPQfRI/ZNW8NP9W4xnY58ArbOPWQEMA0BUg6Duv/+kj
         GJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKt2tmYkZ0IptmRVmfOgQO1U+SQBIYl0R7WV2vqUGho=;
        b=SWh8rTUmxHvfqpC2+8s6QKBh21DnleT9wAEbqaCf6Vw5RXMxxzrredUfnZhmk7qHL4
         S3D7mf76UP+18/9a7GBs5THKJlvDyiupojfAzgN3I7EQqbOW4f5wnx85zjs50o9KZuVL
         k86FM0ps9zgWZ4W17ikbPu62m8UP7ZYd7zPA0DNR+CYdhKEq93UjDYhnSKK2r8F+Rujn
         kN7HBTfehKZVVDCv6yJ2pf9gij5P0YNnk76Z/KsfogPjlpykdFmvNs5xbaggR6vZdQk+
         a00pL+8iWMZC1NXxsHcVjmBZ6ces5Yn89TH6LhAvhR4fYnVxtUwi49sshwW0XMkDT9PN
         HRtQ==
X-Gm-Message-State: AOAM532kGgvRPa/nWNGr456B35pHWdxok4JTjDS/sC2FUfRLzmJxBzDT
        Wm+Q6cvja3Eb+8p18JFbMvc=
X-Google-Smtp-Source: ABdhPJyaC+2XnLNLDpKrdhgqNpYzyUTOzvxHAGy71LThWc826IZqvNohubT3GGItQ2jw3820Estsjg==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr8796964wrw.324.1630057312200;
        Fri, 27 Aug 2021 02:41:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with ESMTPSA id b15sm6500034wru.1.2021.08.27.02.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 02:41:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: clean up some camel case naming
Date:   Fri, 27 Aug 2021 11:41:40 +0200
Message-Id: <20210827094144.13290-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up some camel case naming and removes the unused
function ODM_DynamicPrimaryCCA_DupRTS().

Michael Straube (4):
  staging: r8188eu: rename struct field Wifi_Error_Status
  staging: r8188eu: rename fields of struct dyn_primary_cca
  staging: r8188eu: remove ODM_DynamicPrimaryCCA_DupRTS()
  staging: r8188eu: rename fields of struct rtl_ps

 drivers/staging/r8188eu/core/rtw_sreset.c     | 18 +++---
 drivers/staging/r8188eu/hal/odm.c             | 64 +++++++++----------
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 13 +---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  4 +-
 drivers/staging/r8188eu/include/odm.h         | 21 +++---
 .../staging/r8188eu/include/odm_RTL8188E.h    |  2 -
 drivers/staging/r8188eu/include/rtw_sreset.h  |  2 +-
 7 files changed, 59 insertions(+), 65 deletions(-)

-- 
2.32.0

