Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907D031F29F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBRW4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:56:30 -0500
Received: from smtpcmd0986.aruba.it ([62.149.156.86]:57998 "EHLO
        smtpcmd0986.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBRW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:56:28 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CsCZl9zcdJFRNCsCalTfMz; Thu, 18 Feb 2021 23:55:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1613688920; bh=cevDCnH9VgTnWHFn0Q8N7lYnLdT+VIm0JJfZ3nBgEkA=;
        h=From:To:Subject:Date:MIME-Version;
        b=GmhH8h4osOTVrBGEanmklTNAiDz/bXn+5Kjb01kIDZb9xDrAVjeX04wsdWjR8JlJK
         tv/uldsWA/7HPMfUOgz46max9zaqu39phsqC3PSypkoDrElodT3y8iPh6jj6Z55Wyk
         s2TsZreCsI72uospadRyHGWs/oSBDERl34Y5JEOXe3wzDcrLlCzrWEdOS0uaray3lc
         cwP1wPd7K56wwmn1q09fQI2+S8gT5zDIXzarWervXyMDIiYKbXJjfAfPX/1JqO0vFh
         3ebhvN+Y0XooxjYkVzgaJti6xeEm22lwVPZWPcnD3ItIi67DvkhI2DwoW/djQhy18g
         mYmFYocAdMcBQ==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>, allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Max Merchel <Max.Merchel@tq-group.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] Add 4 Jenson simple panels
Date:   Thu, 18 Feb 2021 23:54:48 +0100
Message-Id: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHdTWRd/78jkjtTGxaOvGm216CUVCexgY1rAYoipYeZeePYwjHoa0MDE5TcPNsDNMYXxq5yM0D7VG9j8tDYN+1EK8MboyFpH7wskSZDONqmVhVMQ5Hex
 MMpciBIsw14BgjHLgWZ0E7+thx/Fnv8054SGE8H1FiV36E+9KbJ+THv5QVdlrnkuM9OOxAn69NValpuC9IrZI8Y2Edle+7V/VdKhGpDQnvu2XIjNfNwdmgRr
 mQjmUTovZ2W37RPlKJud7caCSfbxp+rgzUJFu0LROvRtx5kORFPxh1lyW3Q7liq/M4ilZxcWkWhDXcSRUdAWckuL6i2bRXJmW77pTYB6e1Vv8jmbCAYpZ/Q7
 16uGm+CVe190vUtElH7H6iZCZ4qteXd3Wdx/rBFaSZNKpUnLpZQh1ktKQ53UfZ7o/aXtIT8UMcCfVMJeMZ+Wj9pRbR/mW2wcJ2ss3YAhmBNuUSpNXGhjRSKA
 UnFjPbiosfxMTFqz/yPBqIPeWALIEPgiDbx/tImJpYkHKY7ov3JL8ch1dbNiwD358ix6p/ZPLOM2olPQSaVEqXZtzvl+kHNFUfnvd3PvQq9TZXw0PCTMImeG
 1CgYD/gzF9Q8ERvnQWYN5Dr95OuBEnLotI1WYqGzbpeGLPZpslgWJS7yH7KMre6mEb4bDwF4UvM3OgtkJX3PR7OTqxBTkB7eE2MVxRBHhr9IWUdBkYArIm3/
 HhyBauWt5ohCeQ8h99kfDeTyfWOzLUw6h/LIsDuwutotVIfl8vx501q1QnXZKyCBRNXv7sjm4js=
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduce Jenson vendor and add 4 of its panels to
panel-simple driver.

Giulio Benetti (9):
  dt-bindings: Add Jenson Display vendor prefix
  dt-bindings: display/panel: add Jenson JT60248-01
  dt-bindings: display/panel: add Jenson JT60249-01
  dt-bindings: display/panel: add Jenson JT60245-01
  dt-bindings: display/panel: add Jenson JT60250-02
  drm/panel: simple: add Jenson JT60245-01
  drm/panel: simple: add Jenson JT60248-01
  drm/panel: simple: add Jenson JT60249-01
  drm/panel: simple: add Jenson JT60250-02

 .../bindings/display/panel/panel-simple.yaml  |   8 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/panel-simple.c          | 108 ++++++++++++++++++
 3 files changed, 118 insertions(+)

-- 
2.25.1

