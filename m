Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30650372C55
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhEDOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhEDOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:46:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C1FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:45:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r9so13595859ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrNRRP5SJ6baqKnknhBwCQY1Z26L7q2lhMbIH9OHrkU=;
        b=iwMfWsESQAHEPLFYNV7ya22UK2nRMhI/L2LIJhVqE1Vu8cgg7M9nI4VzmTfUloSSIT
         B5JIp8Eq33vPY1z2+Ax6M3oK0iYibC9q2ge+5KpEc7u7DVKPSEc02KUbE/QWS9Xc3rMP
         7ghLp4Xt+BaA70PXu5tBuCmrdckCjXfxtGGtFzxP9kdV3+GeozZMFUyR/G8EOzGpUXuD
         NEN42ivq59XnIJ4cq2J9aya4YkunbAoLv5PKpgp625WBHgU7nTDRIKFaiOIz9cFAHyAW
         8YoBivl1Wdc5+fB+IuCUdL38nSqbU/w26wgZ0sf6JNyJKdmTzRTziChV8nXX6cNrxbBU
         Gc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrNRRP5SJ6baqKnknhBwCQY1Z26L7q2lhMbIH9OHrkU=;
        b=DIWD5Nkb9IGLB28VDubmDB8Fr4lY8mMA0FE7S+PsKi4eoeVIHbAmE031F6oB6tC9Wb
         g9ALy4oppjkq+4yA1yQYM6gdZDboqJ0x/wwlosAZd4vVsGzIhhEkiuCE5VvVE6Nybzu8
         AvkjYznUAaJYsm7crcj1hD58CQ51qkL8InmR7FbOMic25RVuoJZymJs4+24TdLwFDuu2
         nJOVMayozsAJG+82dT39PzWb2rV71cMFHHe2wAnn6gEwQGg7FXbQzzU/4vt4KS1Xj2Tg
         2SqS1gkRi06e4RYBOVjKdmTY4UuMD7LBHf72rknKajLP+GqYA37weaPLn/mXHXv0vbRD
         5y0A==
X-Gm-Message-State: AOAM531HOW76TGRbJcr3ac1J6Lw7F5M7j3UKrX9ub2JlePGZFxVxZWun
        y0xWOUwB9pzGTwW9rubWq0pZVdtX788HZg==
X-Google-Smtp-Source: ABdhPJw3mtfpiE5JPvkG9j5fK2Iy3mMEMe4PzbI0Q88UOzvFRKxZtDLeyZOGaAmhG1Em1f51H77yug==
X-Received: by 2002:a17:906:8693:: with SMTP id g19mr19100701ejx.270.1620139532930;
        Tue, 04 May 2021 07:45:32 -0700 (PDT)
Received: from agape ([5.171.72.210])
        by smtp.gmail.com with ESMTPSA id cf19sm1549686ejb.24.2021.05.04.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:45:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: rtl8723bs: use in-kernel aes encryption
Date:   Tue,  4 May 2021 16:45:28 +0200
Message-Id: <cover.1620139318.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces the private AES routines used to
encrypt data with in-kernel ones.

--------------------------------------
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

