Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8109C353297
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhDCEpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhDCEpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:45:07 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D4AC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:45:05 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o19so3342075qvu.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wo7V3ZR0UK4Q+5RygwAFyrvbbwcmu8ahr7KLFpzX+Xc=;
        b=V1gUNnlZ/xZ4eGqJzQdMbdJ0AcI/qOblKISwL7RNqmkdC4OfY7NMxQejg6p8JG/+7N
         H8fPEFcKJjPrSwUg0btclfSDO1TLIScsNok+HzgW4qFhpKXiT9Y3xQu+TB1ui8yPwcmB
         qvzf1K98MFkrqgldvBhipTfWioesNTDXV39N+Iz5//b9F2Ga53w3t7pg1/CR7WGeadZ7
         LiZY4hwCjPGBlvb5DxmwKHTp7qWJjbUoti3H/NOKNKZKOuCuc4G6TmI+aPPpangtO7jw
         oTuNkCyN8UBWLvDjAIfahLmEcxheBXiaVzzllnmoLWkUVvCbP/mPswpNCSjtlX/xdhim
         ccRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wo7V3ZR0UK4Q+5RygwAFyrvbbwcmu8ahr7KLFpzX+Xc=;
        b=f0BPGMgZImN8zh+5msAEWRgzc00xwbrhETJrEaXHxFUGTum9XakjigTYbi0axt4BbP
         kQelYRhYiLcFo1hgWat8uVbcBYXKZNA4w21qnWhmwPL/6j2pK6GR6hM6zKwEbBmqSLWM
         AenwcZtWY8O0WOTQTsmeGP9NPDarDIC9o596HaYZNInapIJEJkJWyJnpAlJXI1WBDctw
         8u7JNdMrytrk7n0PTW3TkiHkNyKmLw0yILPctLa8Uc7+7a33XhqxduFgfpE4BVpFMG3q
         /gMaCB251HVXstmIm/sxRtqOY7omNGaZA9ME5zsXnlwnqGL8FTVRV9x0X1budh5fEDJs
         BsTQ==
X-Gm-Message-State: AOAM533hTK7kNWzAEobfLA0n57e3wAfLw595BeBIDy5y17A9RhzXToQT
        /F+UsXPEvK6YZTJfefvMYKrPtKsDbrQ6MmTs
X-Google-Smtp-Source: ABdhPJxf80Zy/G/f4QMhxaDfJLoYWfzeBban4BENw50Y8KLjDwPsa04IRrfDdv2yPoWtLWr/ub5hGg==
X-Received: by 2002:ad4:4e53:: with SMTP id eb19mr16112178qvb.8.1617425104311;
        Fri, 02 Apr 2021 21:45:04 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id d24sm8937673qkl.49.2021.04.02.21.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:45:04 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 0/9] w1: ds2438: adding support for calibration of current measurements
Date:   Sat,  3 Apr 2021 01:45:47 -0300
Message-Id: <20210403044547.390226-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
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
Changes in v3:
- I accidentally added a wrong line that would not compile. I'm sorry. Fixed it.

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

