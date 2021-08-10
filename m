Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4E63E5856
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbhHJK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbhHJK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:26:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E9C061798;
        Tue, 10 Aug 2021 03:26:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x12so2068976wrr.11;
        Tue, 10 Aug 2021 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mjY7O/pC2TcqSPG82GtWi58hA2y8Bv1MoiaYMqZ4vVI=;
        b=JqZnHfY+P04gFemljz3QJ5119I8BJNqCNkUXZP5Xde3C5M5XZV3mRmZBXGuiJuLpuB
         y3lC/DGEoe8U/yHxUKIXY7d6aIZSOu5Jv+QLcxNvqPyAc+v2IKx8WNXvc/Bw7Nu5gom8
         x5fCDWDc81FXxtuv0RXvtBTGPVRq/fPMA73v+Mu+RGgqGKeL+mO3uDea/96adeaT2Pbg
         dB+XoIuwYkqdY2AHaneALcojWzeoVQD6HVo1EeA8PWrrTLbFGA6zKgUTF9lloaMFt1Hw
         qN5Wt1E5w+7Fc1HxALUVnDRT73yqcMTZrOVswCb/o2Sum269O24oFFy03R4VwB+B6Vyk
         gnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mjY7O/pC2TcqSPG82GtWi58hA2y8Bv1MoiaYMqZ4vVI=;
        b=h1uytK6R1Ph6oLMSrwYYotFbSVnMs958pqKPheAllJcmxoukAjkkjVL84bvKtkoRFF
         r0FRQmrukVwgqX1XsN/gTWw9+Bg37KctPv0LWNTLNmN15QXxWoi3X1CpHmhbZbkud7JP
         lBU4o8rcOWjRdtMtOuhg2zuspjNR0bpPkfWzTQhrNtVP6N0yQJ9uCstqBDUaPEq8ej8n
         0cbek7naXv6EGYJX+d+TUZrMfpF/MscNeQjw1R7AtN5LzStEzy7Skbx3ixup5omamvWv
         D3hqeM5e9LuFFcAFdAOd8IGjke5p3BmmmYzoWe9n/JLN1sLuXehDjt0FBA3EibdCmzI9
         KNXA==
X-Gm-Message-State: AOAM533F8mphk3EIXLiUp5DU53Prprwrtf8dOWkp25wDLfhqrthPKe2W
        94rEDjOiMjg1S4ny0s8ru+8=
X-Google-Smtp-Source: ABdhPJxJg8rlUTfz4vqYgqJ+QF4oQlBfbwNVQj2jbNaJV9TqYAZAW7wdJV5HauBzT23Z/v/xvERvzg==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr30011954wrm.220.1628591177334;
        Tue, 10 Aug 2021 03:26:17 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j194sm1582998wmj.3.2021.08.10.03.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:26:16 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/2] arm64: dts: amlogic: add support for Radxa Zero
Date:   Tue, 10 Aug 2021 10:26:11 +0000
Message-Id: <20210810102613.25149-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Radxa Zero SBC. The device-tree is loosely
based upon existing support for SEI510 and U200 (also G12A boards)
and has been developed with the 4/32 board configuration.

Changes since v1:
- Drop flash_1v8 and use vcc_1v8
- Rename dc_in to ao_5v
- Rename vcc_5v to hdmi_pw and drop GPIO control

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for Radxa Zero
  arm64: dts: amlogic: add support for Radxa Zero

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-g12a-radxa-zero.dts     | 407 ++++++++++++++++++
 3 files changed, 409 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts

-- 
2.17.1

