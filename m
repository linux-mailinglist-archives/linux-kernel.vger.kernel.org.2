Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD836D31A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhD1H3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1H2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:28:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11805C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:28:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h15so9616706wre.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efUOtH1GOvz6NSai+6Hd8qlLS9PJZIYKB1/QiO+LILw=;
        b=MKkSUqBv1BRIp1keezHtJDrc6V5C4QsQ0azTFEccEXoe47wncEk90tuQuYy33znffs
         5grkN+Mm3ccZIIpogCoYbPAlwtyloFI9kxUWB61A8UGQAz9iCIlylpTtUoOWX8hV4atU
         7cBCZN6kDTJdBsXUU0gwpZcnGTkchmzwCsNyuIk2Ty2z3BRmmfCwjxJPhYaV+stmoOJK
         5sj2qJOloVB9x/qTTX7zihARjWY6u+c+lGhg8y2yxGEIDkf+KkixhPdWZ8iKjoB3ZviQ
         Iq0LI9d+iFeLxL70QwMO808lnMzqckIdCYQ6EqWrWKnxJhURGXy61IFe10X/SJjhEVip
         5gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efUOtH1GOvz6NSai+6Hd8qlLS9PJZIYKB1/QiO+LILw=;
        b=GncllBlPFh/ZYanytWkKuegDPE3y6epfQezPxd53tWW//PN5X/i/SeBq/AsNUPcWTo
         DbEDLk5ZoRAzETTKzQkOVi5A0BwN/HaGM4DfVjj0imyHs6HAKMuATdLyvjUHCc/NrOMr
         3nXYxlXj5oJgizGiHXiLNDZWTUmG7j8mQs4xrDrfVlKQti6WhVM0RDJYYthdlmvoANFU
         lx81mvgG9OJ7aqIw86lmQZRFCnIu5Nq57g6VKQmNxov/tjnfe/7YAwMzcTJBNo4xQmNy
         Pm0Mfx6aXV2qqVBCiIhWEq4Dn2R115hY0s5BVnXv9MeuQ6X2jCpTjsCrnkyVhwNqxVgP
         rMGA==
X-Gm-Message-State: AOAM532qxMrO58JsR7LioZXIZ02zhcpeItdniTI5ygAT0tCIEWvlq4g+
        ZMoPZKwq6wTnO2xHoSDC8EneEWZJatTGOQ==
X-Google-Smtp-Source: ABdhPJyy5Iou7jTyK3U2tMGFutIRwlzeZIOomr/rV2s7iSYyaL46SmySvRJl8snaXmoO9dn5SHfX/A==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr6911669wrw.49.1619594887695;
        Wed, 28 Apr 2021 00:28:07 -0700 (PDT)
Received: from agape ([5.171.72.119])
        by smtp.gmail.com with ESMTPSA id s10sm7094058wrt.23.2021.04.28.00.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:28:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8723bs: remove unnecessary hex dump logs
Date:   Wed, 28 Apr 2021 09:28:03 +0200
Message-Id: <cover.1619594707.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro removes unnecessary hex dump in kernel logs.

Used the following semantic patch:

@@
@@

-	print_hex_dump_debug(...);

Remove macro left unused after print_hex_dump_debug()
deletion.

Fabio Aiuto (2):
  staging: rtl8723bs: remove unnecessary hex dumps
  staging: rtl8723bs: remove unused macro DRIVER_PREFIX

 drivers/staging/rtl8723bs/hal/hal_com.c        |  6 ------
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c   | 18 ------------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  3 ---
 drivers/staging/rtl8723bs/include/rtw_debug.h  |  2 --
 4 files changed, 29 deletions(-)

-- 
2.20.1

