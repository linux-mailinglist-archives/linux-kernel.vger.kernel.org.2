Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D498381EBC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhEPMbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhEPMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:31:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ECCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:30:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h7so1733128plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WG3vPr7jTrZWJiot95jPYHU2QyOXWk1phufGNJD2xZI=;
        b=V3RGkfHJyAKNttBRs2ZB9e2X2di/5AI8Fn9ZsnPjqhfBwRFgo2GYZKZY9uUCX3c95Z
         6odMZIGiOvl5adcoBnz57aSGgNutvwkLdbe6y1vBj65SY4o06lad5cZhXyrcF49UGz/N
         ugjrryLmomOpVA+tCMuxxAEMT2tZ0uxcZRMogCMPwkvlZOFsDbjltywQGJcXnLJMjeV7
         t9Cva5qVoD/ui5GxLv4M0Zcib/BeBWLYten2D2bhtqHawqBjMewBIkivp6AGfnqzYwlb
         uMFyF1nr+ZxVUb7ucwMgsxdlBIFwO8lQghEvF5VJCmZjUYMLE86nhpbH+WoRlNFA7qiP
         8w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WG3vPr7jTrZWJiot95jPYHU2QyOXWk1phufGNJD2xZI=;
        b=JBh1ujql3z1CHXabiFP6s55LSb9/tH62sddyh/UyPr/5zPIWxHvYAKb5Oz/pdPqx5U
         T1JISlYUI2v1WEJvwJqyVuIMeW1H7CeDIEFUDnHJdcp5YWP7JybXjnlYGkKkg6xrof3F
         DKfFA7EyqqsbN1tK8GCqRjq1E54QAeU6pryjx0q7lzBQwYiJeTSG5BRE1x4/Mx2rSAdf
         s6yHnNR6tzOmfDZ3/nFAkwaxeswqQy9tJgzcnGD5oEvpYbcS+RAfAB9xVgCXxKpZz7lM
         4cQv5iMHhLOAHhopueKpLVeJ5MfDZGcUnVTZqH72jmm3Cm7W1lrCeqirUxbvOhnk2ty7
         wuAA==
X-Gm-Message-State: AOAM532MXc9CYj7frqCGCrC3K8c/JsTGZ5sNlL5FRdWtvXslcMy+l5Z7
        GmW319+DnMiz/UGhllXCToUaqk53sJEp6WhRDgKiCA==
X-Google-Smtp-Source: ABdhPJz9HzuN+RORcmcoIvkv93+pVKdpSAysrxX7o5ANQJDnTKBK7nhLOY0A+n2+atJI4ufmFMcKVg==
X-Received: by 2002:a17:90a:94c5:: with SMTP id j5mr12062466pjw.121.1621168202092;
        Sun, 16 May 2021 05:30:02 -0700 (PDT)
Received: from localhost.localdomain ([111.223.96.126])
        by smtp.gmail.com with ESMTPSA id k186sm8004318pgk.82.2021.05.16.05.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 05:30:01 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/7] Staging: rtl8723bs: fix warnings in HalBtc8723b1Ant.c
Date:   Sun, 16 May 2021 08:29:20 -0400
Message-Id: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes 134 checkpatch.pl warnings in the file drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c

Although checkpatch.pl reports a large number of checks, these are for issues that were present in the original code. In fact, in the process of fixing warnings, the total number of checks decreased from 548 to 546.

All patches are syntax fixes and no logic is changed. As there are a lot of different warnings, to make things easier to review, each patch addresses a different set of warnings in the following order:

- braces {} are not necessary for any arm of this statement
- please, no space before tabs
- suspect code indent for conditional statements
- Statements should start on a tabstop (this type of warning is solved alongside the previous warning type in the same patch because the fix for one warning addresses the other)
- Comparisons should place the constant on the right side of the test
- Missing a blank line after declarations
- Avoid unnecessary line continuations
- Block comments use * on subsequent lines

Desmond Cheong Zhi Xi (7):
  Staging: rtl8723bs: remove unnecessary braces in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix spaces in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix indentation in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix comparison formatting in HalBtc8723b1Ant.c
  Staging: rtl8723bs: add missing blank line in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix line continuations in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix block comment in HalBtc8723b1Ant.c

 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 335 +++++++++---------
 1 file changed, 158 insertions(+), 177 deletions(-)

-- 
2.25.1

