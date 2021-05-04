Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDAA372C84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhEDOwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhEDOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:52:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ACBC061347
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:51:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d14so10744550edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3N6g2UZbr5ImaLmOMaKuHosTydvdNGVUAq4Ih6ZjGg=;
        b=Q+3Uut+DEXFu3aeJtAdIHi1TB0Z2UM+XTM6YX00MQ4hY0mYpdOcKqYVPRvd3a+/nf9
         3RGradfSOzpRF/pwVnxLfmH4eXS5rIH/6jYkID4LLwE5yzJVsmLx5w/f5+9+apjqfino
         Gj6I9Pu/AE0mW1pmPWfpW4KCujvT5uc1L5kduchyZXgbjyR/OcaAvQqKRrNYTkT1PuiG
         +EWDz/Bnz0a92J72yBLlwkJKkHyrLxUVD4SC5KVPE24jrBpGk5D/geCiWDvlDHzFJAKB
         3chniEoqSOnmfPMJk3R5obAkg1Ueh5m9S8dvdcRslTgbQXhImNKm+iuMc5ooXvDE21Ul
         quKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3N6g2UZbr5ImaLmOMaKuHosTydvdNGVUAq4Ih6ZjGg=;
        b=BVsekeYO/Lytmp7fikUzPDRGRbLB8gWFC9P0F40gA/CFGV8LwOcuRpNlXxt+CjCuYi
         8qRAKjmrNT1iLjDofawMDNanuaNW9GHS1daSQm61/b7JyP0x7JOV8qR7XiY0GfO+8+zT
         ZN0V/BIoDZl0AA5s9wcWkw1jdOqfHTsK3I49gK/UnPEjcmLMCB+sDlamsc5YHiB4haer
         tYleiPSXLY/zqcJ1AyIV3vvswj3VJHKgRw0hZObICBuZPevnHqqdT8s+1K2apX673cEb
         vb6ZKwzBbYT4NJRsXX8v56H+A1wylr5yiwA+HmNv005wRwaGqUj0Q+H3X2Yrn52gO9Cz
         vRUA==
X-Gm-Message-State: AOAM5302/OX+XEs0Dsoi9TDFP1dhJw+Hk8HbALeTpzhIJQ5ewK896nQf
        Ii0pMQTvDUGbk43yA2Ghv9UV3WLm1mOmsQ==
X-Google-Smtp-Source: ABdhPJwsEgQN9zyPIxU3vzTcGYP3pY3KxBCFZM2yvkApgd5OvH1PYiyNc1z7JT0JEZ8tFL6mUfVV1A==
X-Received: by 2002:aa7:c2cc:: with SMTP id m12mr26296094edp.1.1620139902688;
        Tue, 04 May 2021 07:51:42 -0700 (PDT)
Received: from agape ([5.171.72.210])
        by smtp.gmail.com with ESMTPSA id t7sm13644977eds.26.2021.05.04.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:51:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] staging: rtl8723bs: use in-kernel aes encryption
Date:   Tue,  4 May 2021 16:51:37 +0200
Message-Id: <cover.1620139727.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces the private AES routines used to
encrypt data with in-kernel ones.

NOT tested.
--------------------------------------
Changes in v3:
	- Added NOT tested advice in cover letter

Changes in v2:
        - Move aes.h include file in .c
          file, where it is needed


Fabio Aiuto (3):
  staging: rtl8723bs: align argument position in a new line
  staging: rtl8723bs: use in-kernel aes encryption in OMAC1 routines
  staging: rtl8723bs: use in-kernel aes encryption

 drivers/staging/rtl8723bs/core/rtw_security.c | 328 +-----------------
 1 file changed, 15 insertions(+), 313 deletions(-)

-- 
2.20.1

