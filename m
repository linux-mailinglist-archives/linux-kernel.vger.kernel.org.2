Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07313D0D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhGUK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbhGUKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:20:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:00:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hc15so2624834ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUwAs+Gp+d+MnfN6VEmwuMCsnF7zFA19A5ZH0CNCb+A=;
        b=ZqJTGxnTo1wPbGjXm99whzWhmnNKFOnlRiwbyzhUWJTDQ9ltCgeJmQOxf2YZlWN+td
         F227X3qIKhHpqxKLDq3GPcA1nYUHpNbf0dAiiDFIHS+HsFbg9vOqOJjdQIkZQqaRFerC
         TaKcwLeIZxgl/YBEdPxruHEpUKlwZkEm1+vu2J/TBqGi8VZFVmlq7hUDmKYNtXA1t33Q
         UgJg6Pze6k4xvrcfXwBm9fJPjP7RLZhn6JhWJs8hGT3o++mmC88lD0YL/uBEIrnr/RYf
         rt1uT6x/07DKF4GvPEJukZpN8Jm/tI/CzzAkt1+sTslqUzDx7JzQ0eqrjlw1tSNjScRs
         sxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUwAs+Gp+d+MnfN6VEmwuMCsnF7zFA19A5ZH0CNCb+A=;
        b=hjSDpgSSDHiNNOrZtS2b5an5f8HhDRCEg5tpXOr9RQCdwKWPZl2iQaJ48AAWAYfZIi
         U4AG0QXoKnc1HTX+DgfpzhlKsWiNloCtQiLlYPUSWvp1FonRj6evqH7bgC9HxtiN7ahL
         If1tcJZCDvTUUJHGN1fRFKVcY3MuGqc1fP33gpeah9yDMtkShd4qvNjBVvzbJ2T76g1k
         gOxGVvLgzc7fYu4QpkzboL3HrhO2iq2cIw7YxgTIJrt2KRKnuR95Oub+ZuceAKnZF+//
         ZK0s8AIsFMntT/sjzM4LxGz8c4s1rcECIArtu2didqnvPr6w+++dGFu6XMmjhllHrqx3
         7Yfg==
X-Gm-Message-State: AOAM533tehCzY77xcJhJDDw1pqowbrxezHIFAbOTsoJUJbhsKVengaMH
        /eGFMpCeZhEtP57W0elh5QE=
X-Google-Smtp-Source: ABdhPJyMSpsqGAoOnYHx+ohabMdXF2biKWKSxiXQUfCg5a13780/YbI3jxY65BjyD1QAKLgJe8MLFQ==
X-Received: by 2002:a17:906:6c91:: with SMTP id s17mr37054907ejr.403.1626865256782;
        Wed, 21 Jul 2021 04:00:56 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id f5sm8102482ejj.45.2021.07.21.04.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:00:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/2] staging: rtl8188eu: Replace a custom function with crc32_le() 
Date:   Wed, 21 Jul 2021 13:00:50 +0200
Message-Id: <20210721110052.26376-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kernel API crc32_le() in place of the custom getcrc32(). Remove no
more used functions and variables after the changes made by patch 1/2. 

v2 --> v3:
Join two related patches in a series because they must be applied in
order (first 1/2, then 2/2). Rebase to the current Greg K-H's tree and resend.

v1 --> v2:
Use cpu_to_le32() to assign native endian return value of crc32_le to
the crc variable in little endian byte order.

Fabio M. De Francesco (2):
  staging: rtl8188eu: Replace a custom function with crc32_le()
  staging: rtl8188eu: Remove no more used functions and variables

 drivers/staging/rtl8188eu/core/rtw_security.c | 59 ++-----------------
 1 file changed, 5 insertions(+), 54 deletions(-)

-- 
2.32.0

