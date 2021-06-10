Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2823A37E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhFJXbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:31:13 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44926 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFJXbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:31:12 -0400
Received: by mail-wr1-f43.google.com with SMTP id f2so4016878wri.11;
        Thu, 10 Jun 2021 16:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NkHOILVMygEEoZYONCaDsk6m76wqea7EMgUYfwAkp6E=;
        b=AyrM6aYYpCk/W3IH4jtqrK0gdAw7TpdyWoH75b18wAoaCzycuAPB/OMesODG2n27Ak
         CJhmqFVk5R6G7f3zjKNhxwJvEeqTKVRhaNjSv2oHwSwzcLmMANt4ydOCjHqWDhPgCjQs
         qwYoIk+YNbxnj+/Ww8DLfV+gwj7y0KZD5oFvuo36CxEu8kwPKfdsCuvI4UU4vFk+OeoR
         Ij93lWV/1GQ94JZ+/TbrCxe2vQrhrZ4sfAvO/IvSqSpICf1n1iK3f7VoVeZPHCsgGSRO
         jFx74kMtQU5BaLC7+huYoNyI6c9N1alScZmUAyg0a9oYC50y+820qMlRIIPt6AuIa4YQ
         0nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NkHOILVMygEEoZYONCaDsk6m76wqea7EMgUYfwAkp6E=;
        b=RBHRpBIHpeCxGqH8LnglD2g27wgv6rw7tDnGE5ECbgCl7dx9KdX2eHY2cZ4oygHA1t
         mLcwgfIFg1has3m4B5Skhohjj/4TjhIIGJ1Fmk65u1Xu9tsOUaFw59bSi4Af+umjgbNq
         gSDruRcb/YN3WhGyrLsWb2GeH3y5C2agLn5mK/9lx5zzwEg0Q3FD9RfAZDSkeVOSMJKy
         n/pbkrwGZ3E85pZ9qWo+B+9gIFUDoGtqYpyKXgRvLsqm02Hnl6jnmmAYa9KsUlxfPh4W
         gzNBkkADGhZlWDOXrB3Vu+D6hWYMu3X9wG7lSoLaOkTBbwKgE/t2ykaXOf1l3+xcQOlr
         xfdw==
X-Gm-Message-State: AOAM531EeP9y2T7F8cTWYbJALYLAd1XOJo3HYlHlYsHX8JeTg9CR2Rnd
        +YUEVRHWxqssiqOfecNDIIs9/eWmrsY=
X-Google-Smtp-Source: ABdhPJypWTWUMZFBvZneUf16gGGhOmY/Vj3MErZvt8ucDJz8tXaOY9ccvLRmQnYzWdMk9kcOr9TuVA==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr754337wrn.127.1623367694702;
        Thu, 10 Jun 2021 16:28:14 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id w13sm5478549wrc.31.2021.06.10.16.28.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 16:28:14 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] ARM: dts: NSP: add Meraki MX64/MX65
Date:   Fri, 11 Jun 2021 00:27:12 +0100
Message-Id: <20210610232727.1383117-1-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
- add dtb entries to Makefile
- add bindings entries to brcm,nsp.yaml
- change naming to include Meraki name
- remove unnecessary portions, including pinctrl from meraki-mx6x-common
- add A0 variant for MX64

Matthew Hagan (5):
  dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
  ARM: dts: NSP: Add Meraki MX64/MX65 to Makefile
  ARM: dts: NSP: Add common bindings for MX64/MX65
  ARM: dts: NSP: Add DT files for Meraki MX64 series
  ARM: dts: NSP: Add DT files for Meraki MX65 series

 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml |   6 +
 arch/arm/boot/dts/Makefile                    |   6 +
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 298 ++++++++++++++++++
 .../boot/dts/bcm958625-meraki-kingpin.dtsi    | 131 ++++++++
 .../arm/boot/dts/bcm958625-meraki-mx64-a0.dts |  45 +++
 arch/arm/boot/dts/bcm958625-meraki-mx64.dts   |  15 +
 .../boot/dts/bcm958625-meraki-mx64w-a0.dts    |  55 ++++
 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts  |  23 ++
 arch/arm/boot/dts/bcm958625-meraki-mx65.dts   |  15 +
 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts  |  23 ++
 .../dts/bcm958625-meraki-mx6x-common.dtsi     | 148 +++++++++
 11 files changed, 765 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx65.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi

-- 
2.26.3

