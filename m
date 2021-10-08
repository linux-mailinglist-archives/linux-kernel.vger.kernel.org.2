Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20016426349
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbhJHDrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhJHDrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:47:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343FC061570;
        Thu,  7 Oct 2021 20:45:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c4so5303256pls.6;
        Thu, 07 Oct 2021 20:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hX9WiA94/+jITIvegMFY+BuTehbQ371zzW5Ogx2JYVE=;
        b=PstNJ6j+e+spvgvj/PM3BNyz6iThcz8hLiTZ8+8dPRItcTo8jpoS3i5D8fkk7DWGgU
         lfRHcOVpEYXRNZDQOktbeczSlRPGYRqn44Ifvs4DlCqo0I6BlxXObFR9bI0lc21wNqpZ
         ybDQ55HTvTTGgq4H1uF2OkLU6ziPjL5L5omzki6DZbNncYllPwVtfZiNzrz9O0dWO3Lv
         jRgUdKsM/+A0NdMiLyIB7+D3A5dbV6+8PvEdUYzlknoHks27YFaHfFHs0w8IyDK8G1in
         zX8r2R1X+krF6/NV1W5meykRiqtbggctfgyougL7nFrhaOWXmC7z6CjtpYlLeVU5NjE0
         NW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hX9WiA94/+jITIvegMFY+BuTehbQ371zzW5Ogx2JYVE=;
        b=Aw1EqnXbDJaIjE0qyxjJErcPaTMdQ/kRJoIw3tk0laz3qyLvlmc4x5XYFPvn7qEoCm
         +JXxxn3xWJOZ/2Ye7VHbOpPRzMxN5A3A7pv0KJbz519bdR9Z2VHjnUNSiKfpGBaoKR82
         ibB/dG6nJMqJbm7dD6prPg47R15PqJVQwO7FPHmw4D91zG+CRjXSQhjBMdnNHgu7FaTU
         WG/x9RIpYMLW6LxHPpOX1kjEVA4n3X+uOWERh+t29RMN3ker49SbM8orJEkTvyjTn+RH
         SAR5oHX+HC/fHY/X14DJYqGhQhEAHrNt68LCsoU2a61IF9fWCk/0S5DfAcnlycq0nNBX
         QSrA==
X-Gm-Message-State: AOAM530pIJtrR7rvDNAkMb/1botUf7GGdQihBFIrOy6KxwpFRp/08BKZ
        F9PIjgnOnXROh8s3HYu2d4g=
X-Google-Smtp-Source: ABdhPJwB+r1IpmlatcbsfmuqWj+ewWl15JdshFm3gch2kAxCjvlYZWE6/bMa9OLzG887MLO57o1khg==
X-Received: by 2002:a17:902:f703:b029:12c:982:c9ae with SMTP id h3-20020a170902f703b029012c0982c9aemr7593316plo.20.1633664756205;
        Thu, 07 Oct 2021 20:45:56 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s3sm9253776pjr.1.2021.10.07.20.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 20:45:55 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add Unisoc's UMS512 support
Date:   Fri,  8 Oct 2021 11:45:31 +0800
Message-Id: <20211008034533.343167-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Unisoc's UMS512 has Octa-core ARM Cortex A55 application processor.

Changes since v1:
* Renamed regulator node name and add required 'reg' property for it;
* Removed sprd-uart.yaml which got merged already;
* Added Rob's Acked-by for bindings changes.

Chunyan Zhang (2):
  dt-bindings: arm: Add bindings for Unisoc's UMS512
  arm64: dts: Add support for Unisoc's UMS512

 .../devicetree/bindings/arm/sprd/sprd.yaml    |   5 +
 arch/arm64/boot/dts/sprd/Makefile             |   3 +-
 arch/arm64/boot/dts/sprd/sc2730.dtsi          | 263 +++++
 arch/arm64/boot/dts/sprd/ums512-1h10.dts      |  69 ++
 arch/arm64/boot/dts/sprd/ums512.dtsi          | 919 ++++++++++++++++++
 5 files changed, 1258 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc2730.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/ums512-1h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/ums512.dtsi

-- 
2.25.1

