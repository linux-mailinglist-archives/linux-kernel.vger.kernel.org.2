Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2D38994D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhESWa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:30:56 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AF6C061574;
        Wed, 19 May 2021 15:29:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 5so7713368qvk.0;
        Wed, 19 May 2021 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPe29nBUqioUnaGp7VmbMwpIqyxLsVu+OHx0UyfkHXc=;
        b=pgAaBxknPORKh+FLBVNtFKbW69u6wTNFWahqYf0YBMvwei6Sodnfp7xKssu6LEVtRh
         wDCiGtK1BHUSgZB2r5rKi3E5vlyjRpWuA0/TIuRvSYlmz2h2a5L9ta14D3T/mZ/8Jufs
         zkDSZT+YmFeMuQXWGf9OvXlFSXI1F4NegVNDTpAbVa1dGJW87gs55n2UnWoDqtWSAhfK
         CWlm7y+bx84yZ60D4eaKUUdnVJtZpyOwVekggV/6iHSXLlx7LZFNZxrFmzJvOrg5FTCW
         sTsMG3N0O8xq6zw7qHyXaKqv6+SQWAJDSCUCils4IjRp2JvEhmJBrsnidGDJCIVU6sqi
         XyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPe29nBUqioUnaGp7VmbMwpIqyxLsVu+OHx0UyfkHXc=;
        b=hsj3bVLqKFlfWhA9ptrBNXPrPZHPfG8VFk0GRqsmuxOrFLSya7T0ERtwyrJQ5mBkFf
         XqK8kqqU68TNYnomYeDBE3PkPi7NxPjsGR4jS01GMs4q935k6Vmqwvei1weut5KQyls3
         pCoqkv/r+Ilojb30auu6IjniToifFrkbpCrAKr3XwhDZfTCDanuDZFDt7vHzr8oEWo4w
         plMKTpPabaO4AbWC10mPS2J/B0WH2XCzlLxR3Ppw4D4xoVWnC7hLZ9G32P52PW3qd9bq
         ftRqypqu39RrG1wsO/fuJBUxosymiWlGWsvOGK3jbMxI4eRfbFaaRdiiuuKKR4Kyx5N9
         TRkA==
X-Gm-Message-State: AOAM533sWYbIUKPmQ62EcP8dRXEI+0b2u0UgH6rWuyl1PzehnxbnRckf
        gjbTCF74BabKcEgYjXZ3pBg=
X-Google-Smtp-Source: ABdhPJylZ5t/foP9g/9RLhCJCFJe5cDNsQNSHTUOs7cjs73r46V+fred9ZUrfKofkyfdkWPJ40pnkg==
X-Received: by 2002:a05:6214:7af:: with SMTP id v15mr1957418qvz.17.1621463374756;
        Wed, 19 May 2021 15:29:34 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8175:da27:c352:bf96:2102:fa64])
        by smtp.gmail.com with ESMTPSA id d18sm823716qkc.28.2021.05.19.15.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:29:34 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v8 0/6] w1: ds2438: adding support for calibration of current measurements
Date:   Wed, 19 May 2021 19:30:40 -0300
Message-Id: <20210519223046.13798-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409031533.442123-1-sampaio.ime@gmail.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches aim to make a user able to calibrate the current
measurement of the DS2438. This chip uses a offset register in page1, which
is added to the current register to give the user the current measurement.
If this value is wrong, the user will get an offset current value, even if
the current is zero, for instance. This patch gives support for reading the
page1 registers (including the offset register) and for writing to the
offset register. The DS2438 datasheet shows a calibration routine, and with
this patch, the user can do this quickly by writing the correct value to
the offset register. This patch was tested on real hardware using a power
supply and an electronic load.
Please help to review this series of patches.

Best regards!
Sampaio
---
Changes in v8:
- Fixing bot identation warning

Changes in v7:
- Build test again

Changes in v6:
- Actually changing from BIN_ATTR to BIN_ATTR_RW

---
Changes in v5:
- Merged all brackets coding style issue in one patch
- Changing from BIN_ATTR to BIN_ATTR_RW in w1_ds2438.c
- Wrapping email lines
- Addind Documentation/ABI/

Changes in v4:
- Fixing different patches with identical subject lines as requested

Changes in v3:
- I accidentally added a wrong line that would not compile. I'm sorry. Fixed it.

Changes in v2:
- Using git send-email to send the patches
- Adding documentation as requested
- Separating the coding style changes in different patches as requested

Luiz Sampaio (6):
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed if brackets coding style issue
  w1: ds2438: changed sysfs macro for rw file
  w1: ds2438: fixing bug that would always get page0
  w1: ds2438: adding support for reading page1
  w1: ds2438: support for writing to offset register

 .../ABI/stable/sysfs-driver-w1_ds2438         |  13 ++
 Documentation/w1/slaves/w1_ds2438.rst         |  19 ++-
 drivers/w1/slaves/w1_ds2438.c                 | 122 +++++++++++++++---
 3 files changed, 137 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-w1_ds2438

-- 
2.30.1

