Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED3400577
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350619AbhICTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhICTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:06:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B727C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:05:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u16so92136wrn.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGjCcoCfsKc5nOLWhuXqF/48+OAzPEG2ZVBrM3dGEWk=;
        b=HZk5le5JAtvCcFATezsYrwuRukTLJn4cDBIsS1ilVZc+8gR4Yw8uY9032wSs+BiRYg
         5OH4uVtnmtlnOdRGEBX9nDofgIG1oLzcg3WMRvSAv+w7JPuTrJI0dnrd/9mnSZQF55i6
         NhjXzPceW1wHCR/RuZIhC9Q70e6Hx0QqEvYdLVpYsgI9O7U8nOhW5D1tX6x85Q0VpxsX
         iP7MKYZ9gLqtKswPHmOJWvszh0+ptPO5aP0sX1gxL/U25dIjoT+ArtNFVwolhU1V4eve
         6S0Hx6Dht9dMLHHKhltauMiZvsSoE7Z0C24qxSAKvMogF7po30B2t0n8klNfmL18pFyZ
         puCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGjCcoCfsKc5nOLWhuXqF/48+OAzPEG2ZVBrM3dGEWk=;
        b=YCPuUKOAfDTO06BqLHKWCMhhJKKq162wBuu95AF1okS2HCv3pn9foWbt5suOfZuEen
         USYLK8XE4EA8IGF3Cy/Yqlw9blrAxPq6X4gwdGmBZ3oejWthtwjfl+WaIlfTJUPo59j6
         NPDDF/lJkujbpLJ6aOI74Qt85gDIH8c3Bt8t6HxG7ODJ88kMWif18iMdfI3f2Zlz6DCW
         RoBO2xTo22p6KHkEt3Gg8WJ71rNKUIg+Up/jyciwLc7i62Nu7etqA3gyjMi+VyqOjWze
         B7ZD1KmL5uYKSneTzN++anDjmTZOgrTqc19tW3R5OMaHvaOZ3aGwce0bdIf9LSOJFJMI
         kb9w==
X-Gm-Message-State: AOAM5327/spDQeipIKjF/LRJN3O4c4DYd3eJZ05mPGnlOuR0FJa+jmsl
        +FVy00zyYBDHeBI6Y1fORUg=
X-Google-Smtp-Source: ABdhPJxalX5b9bt7SlCR3opFgt8BzJiDjjgTjyu4DYUPmbtzDFboVHWtm88r3ZaNBG5RW9XCGIzx/w==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr598397wrj.72.1630695900023;
        Fri, 03 Sep 2021 12:05:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::848c])
        by smtp.gmail.com with ESMTPSA id u25sm229291wmj.10.2021.09.03.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:04:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: clean up dead code and use in-kernel arc4
Date:   Fri,  3 Sep 2021 21:04:41 +0200
Message-Id: <20210903190444.15585-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the unused function rtw_use_tkipkey_handler()
and constant CRC32_POLY.

And it converts the driver to use in-kernel arc4 encryption instead
of a custom implementation for WEP and TKIP.

Tested with Inter-Tech DMG-02 and TP-Link TL-WA901N access point in
WEP and TKIP mode.

Michael Straube (3):
  staging: r8188eu: remove unused constant CRC32_POLY
  staging: r8188eu: use in-kernel arc4 encryption
  staging: r8188eu: remove rtw_use_tkipkey_handler()

 drivers/staging/r8188eu/core/rtw_security.c   | 123 +++---------------
 .../staging/r8188eu/include/rtw_security.h    |   6 +-
 2 files changed, 25 insertions(+), 104 deletions(-)

-- 
2.33.0

