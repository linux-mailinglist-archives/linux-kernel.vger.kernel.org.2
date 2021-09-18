Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4D4103AF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 06:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhIREwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 00:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhIREwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 00:52:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAECC061574;
        Fri, 17 Sep 2021 21:51:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k23-20020a17090a591700b001976d2db364so8835701pji.2;
        Fri, 17 Sep 2021 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNZGMzb9nyB3MBMeK+QJjWLcTHItRnQ+7G/+BEDduNE=;
        b=Bo2jvmWsFr1hFGLC/xPMcs2O1qJ2I6XbQkEh52guZiJqM4FfbS0OYR51O/D5RdvxPl
         wMHz2rE+M5hyFwW+MiCZquf72SAg4oPpZzFKDLzW80WrZe+mi6umYwDILiuz2EhvYheQ
         tDQu53wRf9kFG4S2a0Te+9pZKZjF4Jchs9ash+KDemOPgzNa7noFMP/mOz4UPHxhPVS8
         46apqtJVWkeD6Tt3uoKAkX7sbkLTt2J4aY+oJBECFxMKwt++WDXS6yQXC3rhpADmYiSh
         TKDeqDADk8+Xo5LMtyc2aRgchvN7lMEGmVS8FMPdxTE6RuqUhFct6TvKxuqQ31GeRrnU
         4KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNZGMzb9nyB3MBMeK+QJjWLcTHItRnQ+7G/+BEDduNE=;
        b=K3vbbO1W365RAdcvQ/p4TXen0r3pqHH79yk7YBCQ8P5Itmst8s1DPU5GFFB6ALpAd9
         /zFNtZg1aIRlHN86QBxvzhPKhWNwmT63wlYUD7lBEdcY7y5P4s9lDEA7CrI3/DCOMmrx
         ujGZrLeujmwEzn6Gl73DQ/eETZnOIU3QfoDHhsSkELfMpT8LMbvLXu2mDGE6/nJNl+X/
         QvhfvmDIeACkHfdx74KuyS2x6GzZrzwnMBkEN4acXXps4bQZ7K/WNDkrKVzx/GjTe5uD
         afr1olaEtrjYKWZsRIbeuHgYYfFpISiVXIyic+z+/2TOcSFJTegJN3nwjlhYVGoGdqKp
         TeLA==
X-Gm-Message-State: AOAM533eHElnd2A4YRayjOOu7qt2u3bYIYDEjpEzWtLGmhlVbvK127vE
        zChU/+tujwxZ6QieiyiWyII=
X-Google-Smtp-Source: ABdhPJwVwe1tdbys8AUd/o80ED7iL8hOIFvgcH5y6yHMv0ePGFoWjh/646L9AUpCkLngtPyTuD3lPw==
X-Received: by 2002:a17:90b:791:: with SMTP id l17mr16434601pjz.155.1631940689460;
        Fri, 17 Sep 2021 21:51:29 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id p5sm7663101pfp.218.2021.09.17.21.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 21:51:28 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] Add Unisoc's UMS512 clock support
Date:   Sat, 18 Sep 2021 12:51:10 +0800
Message-Id: <20210918045114.387005-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

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

 .../bindings/clock/sprd,ums512-clk.yaml       |   88 +
 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   68 +
 drivers/clk/sprd/Kconfig                      |    8 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2197 +++++++++++++++++
 include/dt-bindings/clock/sprd,ums512-clk.h   |  396 +++
 6 files changed, 2758 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h

-- 
2.25.1

