Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535153531E2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhDCBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhDCBYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC17EC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o5so6782500qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edxuSlfnsQ9fq2SuogDLFXUBB/fAlzXzN8LJEE/s6TA=;
        b=fabp5HAtfs1FUKtpD+WRDirbzBIYp5zIiA1k3FIrp3imAy/bVkFFHWcobsqcB+6LjT
         RG+TptOn/RFMl++c9Sx9Bs6hSqP+xs6Qg5p1TYakNxcb90oCEtwWNRiO9+yB0TBFWdEZ
         ojTno2waBc2acObzSjAIqHJPHSq89C44fBk9cY821YWh/bz9Mou/JHgkms4hcdUbTlx+
         frPOSN8J1/zf6sUJXsETHvED8f6vYHe2UazWe8NTn3BU4wjYWXpUbgt5/x55SEbcSv1E
         M/JUjkeyffnUv86s4Q5c/mL2VacuYC21D7dbJ8n24N0T57vLEcZoCToX94j9G2R2YZSL
         HV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edxuSlfnsQ9fq2SuogDLFXUBB/fAlzXzN8LJEE/s6TA=;
        b=rLpbz++OBw9GYvfkkCwm8T3J7Mw2+FkaRzhQq2FgL0PU8ahgkj1o8h1p7gOT8AW3TR
         AciJbLwaJ3TBL0I6zmZmqChssVsU9AYw2moAAhNRlv22dKHjZ9UQmNcsDTb3K2FkEIfa
         cg8s3Hdew3TxnoJfvnzgPQbEJB7xkJlYXmGs4qnWg9FFq3Mz0jcdri0uXwtj67GWAQz2
         JLutyVxBFkNtVrUzb+C3PcGOraRt9VGsHJ4sABOec1D0VdHoeCwsHwgNn7P++TnrDLxj
         1JoZ/E655sRTTSogB+YffKru3R4MVxJGNI8/2J94+Li1l1pvQT555eZAK4UTsn0pk38L
         nagw==
X-Gm-Message-State: AOAM531pDvBDUziT1SyTHbNcxwrWE2TzZEmTsn9S+2Xsj83bVgJhZp+X
        Yw9G7hNxAOkAMtTSlW2qXag=
X-Google-Smtp-Source: ABdhPJwThQ4bRZt3XhnK9xQ6LKYrCmVrnuJcWKxCt4li+I4D/2biSMUXazLKLO0GyiWuq+rqHdP53g==
X-Received: by 2002:a05:620a:4106:: with SMTP id j6mr15054973qko.223.1617413043691;
        Fri, 02 Apr 2021 18:24:03 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:03 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 0/9] w1: ds2438: adding support for calibration of current measurements
Date:   Fri,  2 Apr 2021 22:24:37 -0300
Message-Id: <20210403012446.381516-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches aim to make a user able to calibrate the current measurement of the DS2438. This chip uses a offset register in page1, which is added to the current register to give the user the current measurement. If this value is wrong, the user will get an offset current value, even if the current is zero, for instance. This patch gives support for reading the page1 registers (including the offset register) and for writing to the offset register. The DS2438 datasheet shows a calibration routine, and with this patch, the user can do this quickly by writing the correct value to the offset register. This patch was tested on real hardware using a power supply and an electronic load.
Please help to review this series of patches.

Best regards!
Sampaio
---
Changes in v2:
- Using git send-email to send the patches
- Adding documentation as requested
- Separating the coding style changes in different patches as requested

Luiz Sampaio (9):
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixing bug that would always get page0
  w1: ds2438: adding support for reading page1
  w1: ds2438: support for writing to offset register

 Documentation/w1/slaves/w1_ds2438.rst |  19 +++-
 drivers/w1/slaves/w1_ds2438.c         | 122 ++++++++++++++++++++++----
 2 files changed, 124 insertions(+), 17 deletions(-)

-- 
2.30.1

