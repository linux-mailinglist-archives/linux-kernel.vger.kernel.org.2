Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377BE3A3486
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFJUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhFJUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:07:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A181EC061574;
        Thu, 10 Jun 2021 13:05:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g8so1060522ejx.1;
        Thu, 10 Jun 2021 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKbNHhsAoamlFszCkXqhYM1B8ImnEWiEi2eaiXGc2bk=;
        b=d92lr/DjUvI3R66OIgy6FRfS8cKnLvu9JUb9Xa7M/oRg0XsIE5RCVHIBe2maBs4RvL
         w+/QXcJp4pPa2i0PWDza9CtZiRUp0Zpb6vgIEdPuTjxfMV5nPZKcl3/UYurGK5ZpbqJc
         iBk9QkAZq8Qa1R/HD/Vaw36MriYZQwqk8a/sYsI/KUKu1RowzchNvNcFpZxeyksFJojV
         G5vcnHgOzUhFK9ZwaZ6qCwPJytWvy4Q42hfnAsiWVa5ahnmkfYvx2ptq1OfsVCCozBrT
         E4iejmkeYBe9jyCh3J6UPGlPq4dywNhNdYQn9rE4zMtnC6oWuXmlbg18S8aYizz+/Bcd
         RMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKbNHhsAoamlFszCkXqhYM1B8ImnEWiEi2eaiXGc2bk=;
        b=sNCx4OP5pzybGqGN+rEVH3iKP1tcG5svlO2A+lxpHQ7HLRA5v+sM0A431hUGjzKyT9
         dx804zic+7LGtvqcWHeURH63cywfvcG/lJJhzJqKJboQ1o4fUEY+ra3bGCf8Gip5aOqm
         3CrXSxrJQbSgwkYRl58iGJ/4XXS3r5PnG6Ma1/lpKrdW3XxUCxQvqNveCk+gSizevXE2
         0F6D0EqLYxcRiWR1E7vIJ0n2wdac5gG6sEJOXwoA1u/Z29gX7iwlkjggxJUBNeDO2z0P
         h6OedUpFznvlVt80K0xY5oYk2/CBu3wPiSxXZgVoC5uyzlp3RBf/oEnPi8K7AEUyKsAt
         8unQ==
X-Gm-Message-State: AOAM533Nod6+MzyZY/dtu5gv/7b52UzcFhWQiQi7rgjKIzZn84VtUXO1
        S4t4HBotDGqdpY0PID5dsF4=
X-Google-Smtp-Source: ABdhPJx00vJz2as8HSHYn/jhTPzO/+DPBWEDYVa6xVv8VYKZ47olPVql9JMiSfTBQTFyCdItTLF4JQ==
X-Received: by 2002:a17:907:20f7:: with SMTP id rh23mr301499ejb.414.1623355529261;
        Thu, 10 Jun 2021 13:05:29 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id du7sm1800978edb.1.2021.06.10.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 13:05:28 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/6] Improve clock support for Actions S500 SoC
Date:   Thu, 10 Jun 2021 23:05:20 +0300
Message-Id: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on a driver to support the Actions Semi Owl Ethernet MAC,
I found and fixed some issues on the existing implementation of the S500
SoC clock subsystem and, additionally, I added two missing clocks.

Thanks,
Cristi

Changes in v3:
- Fixed swapped flags between "ahbprediv_clk" and "ahb_clk" in patch 4/6
- Added Reviewed-by tags from Mani
- Rebased patch series on v5.13-rc5

Changes in v2 (according to Mani's review):
- Re-added entry "{ 24, 1, 25 }" to sd_factor_table, according to the
  datasheet (V1.8+), this is a valid divider
- Re-added OWL_GATE_HW to SENSOR[0-1], according to the datasheet they
  are gated, even though the vendor implementation states the opposite
- Reverted the addition of the clock div table for H clock to support the
  '1' divider (according to the datasheet), even though the vendor
  implementation marks it as reserved
- Reordered "nic_clk_mux_p" after "ahbprediv_clk_mux_p" to follow the reg
  field ordering
- Rebased patch series on v5.13-rc3

Cristian Ciocaltea (6):
  clk: actions: Fix UART clock dividers on Owl S500 SoC
  clk: actions: Fix SD clocks factor table on Owl S500 SoC
  clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC
  clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
  dt-bindings: clock: Add NIC and ETHERNET bindings for Actions S500 SoC
  clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC

 drivers/clk/actions/owl-s500.c               | 92 +++++++++++++-------
 include/dt-bindings/clock/actions,s500-cmu.h |  6 +-
 2 files changed, 65 insertions(+), 33 deletions(-)

-- 
2.32.0

