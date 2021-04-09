Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B803592D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhDIDPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhDIDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:14:59 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D058C061760;
        Thu,  8 Apr 2021 20:14:47 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c4so4568690qkg.3;
        Thu, 08 Apr 2021 20:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZiprd9+Hf6r7a0JoFuV8d3gv0FqZBsdqu1SoRuQYt8=;
        b=dKk0y6ePOHMzVVV0irh602uvaPx0DDMmesTsB7R2yaaIHHZ1Qedwx0Ol3cn9VdWTZ3
         UDetmDTpM5Skrbi/i1UhJvlHqL4YNAfLk3tyU2ZWxy/uYmHysEjanPR4q5MeSQdvsFYB
         5WGD1jiXPABXWZq3CikLBrEwIQRFwdp+gbA7UIUpTDRBaw9Mx2Zeo26G2ZEjotJCBIrV
         CEq7lmuuAKWY6fB6n3HWV+8WtV91lctK8UBd8pGlkCTjjNNzPKUC+gmrbO8qdxfgMLoa
         CAxSacGhS748BIB1KRijKPjZt7OoHcHhfE4NNj4zV9Re8TnuP5H9jvh4e775irgw73b8
         2H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZiprd9+Hf6r7a0JoFuV8d3gv0FqZBsdqu1SoRuQYt8=;
        b=iGEkaI4HVLHtvh1RuGVd3XdDEqRHb1kdgY1nqvaJb3PkE9SaEzkT7hnYjawp5z0/R8
         NXQY1a9QpzHeKcrwptTfsna4qC7o8X7dvf1OYzgqrlUTZgZ0yZ+GdmYiNyP8oKvSAsUu
         wOwKiOlZJs++VnZChZvYxnLuRYoZ+99M4Hw6jtUxEn0FXAutCxf8E+EOkkArTmVl4nNm
         igrrzoUc2Hdp5HrB2cvOhCuNxaCg1EHcqbttKyf5iJwI9OsZuyss0nX99jlpPw0IvpAw
         00zDgH/6ZdfVs+eFtxWmQj0+Ux4E+AIt/fYaREzVMLpRaAS7EDUfObQ0kQaNVEDmv97p
         7Gtw==
X-Gm-Message-State: AOAM530HjScqpUWyuHgSt6uAj3pTkOMivEkmHTuZnOHxZ5Bo6s+gkIlf
        kzaGZFBt2RNtA+NqKXRzAAM=
X-Google-Smtp-Source: ABdhPJweBCLfIttaNMfavl9GZDYoco+hIi3rFw/ohyp8BQODuCtAk8iyVjZKmslzbKbb3xIlOKy2KA==
X-Received: by 2002:a37:6c3:: with SMTP id 186mr11591295qkg.279.1617938086590;
        Thu, 08 Apr 2021 20:14:46 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id x1sm1003167qtr.97.2021.04.08.20.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:14:46 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v6 0/9] w1: ds2438: adding support for calibration of current measurements
Date:   Fri,  9 Apr 2021 00:15:27 -0300
Message-Id: <20210409031533.442123-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409030942.441830-1-sampaio.ime@gmail.com>
References: <20210409030942.441830-1-sampaio.ime@gmail.com>
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
Changes in v6:
- Actually changing from BIN_ATTR to BIN_ATTR_RW

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

