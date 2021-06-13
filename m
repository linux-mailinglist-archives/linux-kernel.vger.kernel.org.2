Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E523A5ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhFMWoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:44:55 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:33421 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhFMWoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:44:54 -0400
Received: by mail-wm1-f49.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so8548500wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIfUvlRYRh95NKgqkMImuAxTY1NXOpBQWAoWFLuAQ4w=;
        b=ru0mUj9P3GuRSe7bANL5bgJtl4PZi5kDlROAwbPU+ZmOFYE58pjwvzgJ6hXghTetdK
         02a68fmmAc4UlAAIbxVUibgb4dI9z1JGFhf0TOl7HiJ2TsjTUVkElk7TZjTq2iGb1I5I
         hCbhp9LnyTWNPYyGJNBK6Rh5lvIcuTiqI2K3Za7m0b3O+Sp/Zma7BUKsplAGxYKOVMUC
         fINbyjld1DpU5pAZoM7Lgqi/fiiAD+WnAByVefL9wdlJLAmUT/FaNAzAKQT3EKMUH3fh
         MtUjxIgektCHrrLFlQ1S+POBlzH9hVmt1NHSPlmLF9BKm98TwpAyFZ/jo8O5S4rXrHGW
         MRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIfUvlRYRh95NKgqkMImuAxTY1NXOpBQWAoWFLuAQ4w=;
        b=CBr2i5S9gJpbK6njca3MlZ8QPa7a4qW8o53TNGQl1YIU/kbIiDD38DALjo6QyHPR8z
         HmMNX3z/M6fDpvLOJmXp3kryQKmya+t5atgR+wdZx5rtieL7oUoovtwt9xxvEwonyFC6
         lI/QndmKOS7GXeAHPV95cMw8yDKsqfRsCsBzJ8aLylVGasqRArYEPAzt7GSghmLwdOcK
         ToWnFpCRD9k5J+sJzieEIFlrug27gvRvCdYg0wtFj2XXk5I9yUBXz4k/NXwi8UO6wD72
         y0tpayCIETbU3ChXd5GG9ax7+egxcaHpkZIjh/A8sTe1Vm+FwaGtktaZWV/fEjnOkNLP
         PqHw==
X-Gm-Message-State: AOAM531Ne9PdAXe2/3Sfu+AVnWeWL47HpQnaiiJjqvBuKoVrIa5B5ImK
        5w8nAMPLjBKuBr7E1QVMLmbIVQ==
X-Google-Smtp-Source: ABdhPJx6w6LqgbO/INu6Sj/TZwIiwKXSTZngipchlCSeSj25g9ZRIgsxTaw8oZweByB1tBkRKhZSXg==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr29599904wmc.5.1623624111817;
        Sun, 13 Jun 2021 15:41:51 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id w11sm15120618wrv.89.2021.06.13.15.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:41:51 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, insafonov@gmail.com,
        linux@roeck-us.net, straube.linux@gmail.com, liushixin2@huawei.com,
        gustavoars@kernel.org, christophe.jaillet@wanadoo.fr,
        yepeilin.cs@gmail.com, dan.carpenter@oracle.com, martin@kaiser.cx,
        simon.fodin@gmail.com, romain.perier@gmail.com,
        apais@linux.microsoft.com, mh12gx2825@gmail.com
Subject: [PATCH 0/3] convert more DBG_88E calls and remove dead code
Date:   Sun, 13 Jun 2021 23:41:44 +0100
Message-Id: <20210613224147.1045-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts all DBG_88E and DBG_88E_LEVEL calls in
core/rtw_efuse.c and core/rtw_xmit.c, and also entirely removes
core/rtw_debug.c which is dead code and contains only functions not used
anywhere else. This should contribute to the continuing effort to clean
up the rtl8188eu driver, particularly with regards to its debugging.

Phillip Potter (3):
  staging: rtl8188eu: convert DBG_88E calls in core/rtw_efuse.c
  staging: rtl8188eu: convert DBG_88E calls in core/rtw_xmit.c
  staging: rtl8188eu: remove core/rtw_debug.c

 drivers/staging/rtl8188eu/Makefile            |   1 -
 drivers/staging/rtl8188eu/core/rtw_debug.c    | 187 ------------------
 drivers/staging/rtl8188eu/core/rtw_efuse.c    |  27 ++-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |   2 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c     |  60 +++---
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    |   4 +-
 drivers/staging/rtl8188eu/include/rtw_debug.h |  25 ---
 drivers/staging/rtl8188eu/include/rtw_xmit.h  |   6 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   |   2 +-
 .../staging/rtl8188eu/os_dep/usb_ops_linux.c  |  11 +-
 10 files changed, 69 insertions(+), 256 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_debug.c

-- 
2.30.2

