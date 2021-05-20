Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FE338ACD4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbhETLtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:36 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:23378 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbhETL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:27:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621509956; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eyfekqO1PwEvN9q1r6wzh61MxoBmF/pmWWw9z1+v7Z9VQ9rTX0wRvwSiREDYdzI8PC
    +asQ08qxfvEkjjebT0mXX+wdCzAsEeV5duI1HBi5zCXYCiI1TuIhrlHv+NVnAewyBpX7
    2GWaYZYGi9UeZ0P58lg98AXu8wyqvd2Dqkm4ti9XkvCTQS6Ns/d0+HxoilHu6vfO2Fbl
    fCd8SDsMbhTlQNPLE9SQY5/S4s95pjSVcP8XF1ptOe1D+Ut9jaWiD6gWALSNHaZeuPOw
    Sw9ikBcV681FcvV3Q0dI4374ClooWFWOhmOwTa8SNwc3Vw+IXlovKITSE6GwlK1ucQ1Y
    zhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509956;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=3OIwLg5G6T21CADBxgiWLY2IAgLW+Q2tX2Ttcq8Se/M=;
    b=QwSpcUZ5meIrMaEjC9hfO+F0QWGknb6eZ0IRy/0s2SSOuxJTbzVjUhphiHD9db2pLK
    Yt3yncNMukgFWOqEqhl971jdxmik/0yQQNfgYiN0vhqbGHBzqUPCGpxJ9MXWXrvWBr1u
    gBd6M9LySLx8f1ap+jLaEy0VBOPboK8dfb//mYoqvsmNmJEc2W871rIadGPmTNyy4qm+
    twmFhO0v33FrcyvcZz0SwjQBB5Bue+DaSEaWrW/PHKP5ZhAo7Nh/AILNrEXLTL8y0jW8
    qbMLF1k1SK+pwYUyRFcC83oNXNQv9sZEhORyUWIjIO7VBdYQq++F0XFZC1DfVLrkWHbn
    FhZw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509956;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=3OIwLg5G6T21CADBxgiWLY2IAgLW+Q2tX2Ttcq8Se/M=;
    b=hqpfPiYyD4b9558RqYPWRhLjSyxSbVRVy9M5yWc6JoL1kO5J3hJ7lYCzaGdpLdosGZ
    GzDlwiLIVTl4hU3lleTs5s5yx2mEp7EFSjiIXpArUu91wBflNLB51eJnGrRLXvr03/Po
    2eIf5g7QduHh4XzfZzKeWwNAHFz0Vl/hK7DK/i/1HxhTfio1WBUp9bQKEeihj4wD8CyH
    m9dQ+6SIoybuda9G5SarhOua5nbFRUCRWWKKdqL8ObypLyFbZfKSE+KH7saMUZr0pOl9
    z/zfsHwxyNgDd72Jh9SuVZLsgVYL2c1n/73ka6DIK+KGRpmsT8v5O8iwP9Qy+cm5tz2S
    sM8Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6FtFQ="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 400bd8x4KBPt22R
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 May 2021 13:25:55 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/6] extcon: sm5502: Add support for SM5504
Date:   Thu, 20 May 2021 13:23:28 +0200
Message-Id: <20210520112334.129556-1-stephan@gerhold.net>
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

