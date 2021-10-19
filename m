Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA61D43381E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhJSOPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJSOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:15:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A349C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:13:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o11so6389404ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/25LReJpLmexJOLsg1U4LuPGd27FRP03kBeKy7B8I5o=;
        b=PtXf40cExBsKA6nV5e77WfUEMxzkT2NFQnPtC51Tu9UOotsDNjZoMbvVM/+d40IM9h
         dQmyjQ1bAXa6nMhcNsNH2cmus5iQJHjWtdU6YRrA7XdZRFtrolWVr+WjdSdYYZ/bMGyR
         W26A2vfhvBBB7zEXD299MRX57UMNCuDQjoEFPTA6SPtj3AnA2XychO6W4PieX3DNtf9n
         jcrILVHDbCcjJPYq0nLZCbndOcZUhR/nPMagLtsQ5TkMPCZHudEuRGJumsgyOWnH9bEB
         vXoR/wUCO7+ZYiW0hKWxQ2kdt2BX0zIgArk+BaLwC+pqtzMwsIsmcDx3vFNl0VGVWn5y
         Wkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/25LReJpLmexJOLsg1U4LuPGd27FRP03kBeKy7B8I5o=;
        b=F+wWJ81LUwdBTzY4SC5Uh6PWs5AOGBJ8nuCsrsfqbMCg3GmCoiCdnoE3RGwgPK3fCY
         XGS60xtMgmLTKMBZT23Pihms7CtIRbPBOi6m11eOU+5WQgs2PwLkmuzzvaA9k9qflVK5
         CathXHsFXTvCeiialEJhESQiZSYUQFUawN4MGh4NsB9ZYORvr6dYFz0azfAK3N9l7XiJ
         6FpFsCKTmHENjk04VImwesYgdpuCvBWU68c9c+xOiimUpTRhHdvhkLvB3hKySedSCU3m
         vXkF4odmEigyNcewaXiRfefQG8dUatWbmLG6t7fBm2WHfElDtVJs1pelpgmp4tE85ch8
         4iOQ==
X-Gm-Message-State: AOAM530tsI6rzdaq/swvdYpRriiU6agU6txohV2uY24RKqE+K2NLHnmg
        736M2XmaVoANVTzlTlmPWNLr+A==
X-Google-Smtp-Source: ABdhPJzPP4EtERsJnIetXPWwwfIY3iWtk4TXNDwY/nr3BsDBbk3teRY3BsGmScoX1PK5HNNXeEvo3A==
X-Received: by 2002:a2e:6818:: with SMTP id c24mr7148268lja.471.1634652789734;
        Tue, 19 Oct 2021 07:13:09 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id d24sm1957805ljc.2.2021.10.19.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:13:09 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     dinguyen@kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, upstream@semihalf.com,
        mw@semihalf.com, jam@semihalf.com, ka@semihalf.com,
        tn@semihalf.com, amstan@google.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v4 0/2] Add support for the Mercury+ AA1 module
Date:   Tue, 19 Oct 2021 16:12:26 +0200
Message-Id: <20211019141228.1271617-1-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add support for the Mercury+ AA1 with an
Arria 10 SoCFPGA.

v4:
* move devicetree aliases to socfpga_arria10.dtsi
* sort arria10 entries in arch/arm/boot/dts/Makefile

v3:
* replace i2c busno property with devicetree aliases
* reset controller patch added to Philipp Zabel's tree

v2:
* remove spi flash node
* rename memory and mdio nodes
* add gpio nodes
* add busno property to designware i2c driver

Paweł Anikiel (2):
  reset: socfpga: add empty driver allowing consumers to probe
  socfpga: dts: move arria10 aliases to socfpga_arria10.dtsi

 arch/arm/boot/dts/socfpga_arria10.dtsi       | 13 ++++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi |  7 +-----
 drivers/reset/reset-socfpga.c                | 26 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.25.1

