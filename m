Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B18E415855
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbhIWGnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbhIWGnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:43:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DCEC061574;
        Wed, 22 Sep 2021 23:41:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p12-20020a17090adf8c00b0019c959bc795so4175999pjv.1;
        Wed, 22 Sep 2021 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KX+BeTvm2OfDvt4yEQs7c9VNutss4NZTW2hQF6gEICw=;
        b=PWpOV/oUWPTrlV37sCziDPsNWy3YQe1lqM0qr+RyHc5qicXsjBJhFRwoZRRoqtaKnX
         np/jzpMuzeWazz9Y6c8b16sYsdloEnVnp9Y81dEu4lih8bQGQ7VjlQbG3wv/0DcJr6iQ
         eXOo5Ye92tGXQF6JA2/sERGfjG2r91nfyWACFjPxY8ibJ/P1NWaflmpjg/l6ScgEg/VI
         JhllzhbPNBbsICX6tcybj8ILPNh2MYS4bSkIKdRHqpfCe9s5uakIAvNoQoOP8jS/VJ5+
         iO7SEeFT11ecfbW0/I4ESZ4lorspzlHZdPs6sjeKq3tbm36gsMXrhUPZT4RUPh2Ye1a4
         hzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KX+BeTvm2OfDvt4yEQs7c9VNutss4NZTW2hQF6gEICw=;
        b=4I2L64/t3Ll/rYgvnrCh83GESf7QV8I/e3d0zascl9H4p/tp7XUt6VgIBAjb9y3NV9
         0sIwkoZ+IiKu5lY3uO1EHNkyvHik1yBEy3TFdj6T+D3+FiOPQRGmbpE69fzXMKptqzLc
         9jD5e8hrTgXYtDFW7kaBn5WLrDKAPx5Pgl6LAygFxXZBEonEuyVkaVQIL9IZiMvhYMvB
         7c3gMgpjyBvmuxny7fMqshcoBayMBggafaiQvLGNSeTqHIlixCHBrWDuGd+W4cTxcv8m
         aA2SMU5jc0C8YkMi3yghuU09804LdZk2miC658xpgIeChMNT8GbeGGDxhLOIoYxBwQ22
         sbsg==
X-Gm-Message-State: AOAM5308ssuydc+T0nq67DVozMIvc2ml4cZXwO23P1raVMF6qOZuUcDy
        ULPIUoYm5ij40yObqquqJcU=
X-Google-Smtp-Source: ABdhPJxPhxlYdylWr11UScIxg4q9qahayxo1GhiVQlNbjddxH0T9o945fCfqI9A0K+XkhmwHt28uPw==
X-Received: by 2002:a17:90a:fd85:: with SMTP id cx5mr16061356pjb.168.1632379308255;
        Wed, 22 Sep 2021 23:41:48 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w11sm4779474pgf.5.2021.09.22.23.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 23:41:47 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/4] Add Unisoc's UMS512 clock support
Date:   Thu, 23 Sep 2021 14:41:33 +0800
Message-Id: <20210923064137.60722-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes since v3:
* Added back 'reg' property as required;
* Added Rob's Reviewed-by on patch 2/4;
* Changed to dual license for sprd,ums512-clk.h;

Changes since v2:
* Fixed bindings check errors;
* Addressed Rob's comments;
* Added an example of syscon which doesn't include "#address-cells",
 "#size-cells", "ranges" properties, so removed these three
  properties from "required".

Changes since v1:
* Fixed errors founded on sprd,ums512-clk.yaml;
* Added a new bindings file for global register which would provide register map for clocks.

Chunyan Zhang (2):
  dt-bindings: clk: sprd: Add bindings for ums512 clock controller
  dt-bindings: mfd: sprd: Add bindings for ums512 global registers

Xiongpeng Wu (2):
  clk: sprd: Add dt-bindings include file for UMS512
  clk: sprd: Add Unisoc's UMS512 clock driver

 .../bindings/clock/sprd,ums512-clk.yaml       |   72 +
 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   68 +
 drivers/clk/sprd/Kconfig                      |    8 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2197 +++++++++++++++++
 include/dt-bindings/clock/sprd,ums512-clk.h   |  396 +++
 6 files changed, 2742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h

-- 
2.25.1

