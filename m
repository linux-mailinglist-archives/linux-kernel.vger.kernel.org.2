Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1CB395E29
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhEaNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 09:55:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36694 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhEaNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622468093; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gfUVl7YZhJgwEVZk1McsPTAEZWYwBKHQNDM+W2OW6n4vGq0jaUwxoVj2ulqJQl0+Wg
    CHZRhULIo2gTjzFUb1My10Scx9py4zHbdUI69ZYI91rIUIRRhb6+9eaPcN9OytXljq28
    3N4ya7Pvu1pQnFfPUZgSl8STnXSGBMkF/tYnV91SPF8yaJ5jrFju4onXQh1VpdEZa1C/
    5iO14LUB5uUjg18oZM/K5ZDhrhfTjbC0KSWLq2lG1p4VzMZOh/PGCzFgbeuIyELgU1je
    nTaWibFDrEwRAplwfHW7pIi2tnME6+gUQ9Ljy6gXcvR2rqUNUo/lRp0bg51ECshGMxSS
    3ESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468093;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Bd3j0XcQtPQZeB6kngwE4AWG5ssjGYuapxhG+5abQ1Q=;
    b=gMx9+PIyPeaWV1bf+IE2rSVHwgmTiGpxSQ4IdHqxKq5fy7AqNfdwiTyWxtcWc1txcj
    FWADWFKZGsGigwm78kJ3rF2Y+nshQMkf7mUEC0XNuQO+189lRDH06BSS7StMrYbv4swv
    SEPaEXLoTO99dSPe6lx4sj4HhIN8YTZrBtNyPsSwq0TPFYTuOXMSg0EQRHMPRZAe2i/a
    /vbre/2pbTMce+VUvGhKOJxVYTHwbbqFN2/zkzdJBQMy5SJSugbdyHRPbyIBacnreg27
    hzJy788Dklb/A7tVo43SzCgeWzj2/7P/nxZAePHQy0CrJbXVbgbISlJyp0HJUsmxbRSu
    uuXQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468093;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Bd3j0XcQtPQZeB6kngwE4AWG5ssjGYuapxhG+5abQ1Q=;
    b=lqqOgrBhjkOnbIp1sVj4QbgWmRcGogTPNcI4ZmA57BUUWEEGRSjPAGviw0XFQo9SYC
    urVMBaRu8OCrWkQuI+4PxSI5hw7E9n9AJfx6K7vv82lt9ALW9wT1i7L0e8ZTrC+wnmmt
    ClSZq+MWrLyw+gYk16uz9Wj7VMDS5rINxGpIeR31eQyopPIfHTYorBb9Q9fXvW177QdS
    ADWLMSBwA/L6bmZ1c+66qzB4JfHQTuDLDGQAHEcxjb9XZYaIvGVDsC8h6lwBf/dk2a9N
    kU1vcemtCE68dvnBmhz/1hmf4X6SI6v2WOHFN9JfjWy90WipvkAe7NjAxX+JaPd6P/K/
    WMHA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526Kcak="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x4VDYrKx7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 31 May 2021 15:34:53 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 0/6] extcon: sm5502: Add support for SM5504
Date:   Mon, 31 May 2021 15:34:32 +0200
Message-Id: <20210531133438.3511-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for SM5504 to the existing extcon-sm5502
driver. SM5502 and SM5504 are fairly similar so support for SM5504 can
be added with a few simple if statements in the code.

I also put a few cleanup patches in front and convert the device tree
bindings to DT schema.

I tested this patch series on both SM5502 (Samsung Galaxy A5 2015)
and SM5504 (Samsung Galaxy S4 Mini Value Edition) and it seems to work
just fine for both.

---
Changes in v2: Fix compile warning in last patch
v1: https://lore.kernel.org/lkml/20210520112334.129556-1-stephan@gerhold.net/

Stephan Gerhold (6):
  extcon: sm5502: Use devm_regmap_add_irq_chip()
  extcon: sm5502: Implement i2c_driver->probe_new()
  extcon: sm5502: Drop invalid register write in sm5502_reg_data
  dt-bindings: extcon: sm5502: Convert to DT schema
  dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
  extcon: sm5502: Add support for SM5504

 .../bindings/extcon/extcon-sm5502.txt         |  21 --
 .../extcon/siliconmitus,sm5502-muic.yaml      |  52 +++++
 drivers/extcon/Kconfig                        |   2 +-
 drivers/extcon/extcon-sm5502.c                | 180 +++++++++++++++---
 drivers/extcon/extcon-sm5502.h                |  79 ++++++++
 5 files changed, 282 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-sm5502.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml

-- 
2.31.1

