Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658C732F6BA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhCEXpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:45:13 -0500
Received: from smtpcmd02102.aruba.it ([62.149.158.102]:55336 "EHLO
        smtpcmd15177.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229597AbhCEXoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:44:38 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IK7Ql1dnx4WhhIK7QloTFc; Sat, 06 Mar 2021 00:44:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614987876; bh=tMO301YBNGQILSS/q8i5FANdCpgCVqKVYK0idqTu+Wk=;
        h=From:To:Subject:Date:MIME-Version;
        b=O08qk03jfoUar4QzIBTMMNFxKiO9SFjWhRsegvE0PySfbGdgBg4EN5uCTScGPa1CU
         Cp3L6RhJzpo7wVuGL8tpVawxH/HKheCSTf+QWry8oO80B0jS+7X63x1W6xhsx2EHfn
         gfbP/U06J4CpmuoW/OdK7/4z18aXFECAC2I7HmfI1XXQOt5B7TQbOqBG64mu2DF6E8
         SMXVcvXEoijSfxcp9hu6B+VpygifGjqsnW3sfJkASxCEz4Oo4mv7lw6W5ski9R2r6e
         2XMitncU40ZxMnWjbf5kphrcL/CfuAS+O034Tnj0lUIfnWeAb5yRzJUn1gAGqBRMqh
         9owFMM/53wmzg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Palmer <daniel@0x0f.com>, allen <allen.chen@ite.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 0/9] Add 4 Jenson simple panels
Date:   Sat,  6 Mar 2021 00:44:17 +0100
Message-Id: <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305225444.GA792026@robh.at.kernel.org>
References: <20210305225444.GA792026@robh.at.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOffs5pqnnRBLcapguHYPVJojdxbjXchYQJdCxJkREg5DMPkVndksiIgWrFHD+CwXjHKudCRTvLoJXgpGtw5HfHkChKZVtIYia6e3kdElrdQVC51A9r+
 QVl85IyGvQSAv+X3vPueoQgXnOw70xJY3M5aZwOqYda1ORHnxhoSUxNbwXkPK/4vy7VdeaEVlHxdYAj4Un+9VWXTz1/0SEhkitQxF1r2+O+juHI1Zpqm1/me
 A5TsRTaqoGUFb6QZwkt6Q6PZZ7l2Pv/cLIY3CSIsR5WJ8mlRfyA9dGfDhznPAKTyCqpPqqH9GeuElv9jP7Luy/90ecgxVxtRYz8mssCA8Jfdi8/0eomDJ3mJ
 JbATtDmP/q3grqE1CLgUnGtF5BSj7CGkvpuZvdAalGNQ5/Cgj06fUul+N9psu/6XyCKUoebPKYZmG98rgeqDbAAyLKsIn3npfUDGoVlAqkD8bsdsOAn8h4Fc
 cYYH44EJBdvS+7mRykEUrHFCF3EfcYZcewFWTBOChk8Qjt/unTxlWy0Y2JXpXzGU0G/DHL/bsufKoCAfzPllxdeHmXbx9N9ylSSzklm0PuFh1Dy9tIuvdXbb
 jtDttsBLeA1y5HM9SY0zQOMJ1rMW0jPFIxHRkQgkKy09VGn7u4bMLRbULMRsRGWLw76f/DfEhK1Jek4aGWgiY2M2uYfZm3/zpA8h08WXvykCSj9SHzaTdHk/
 25gJ516Gq/Idh3WYRsy0oH9PH/4skKxApESCwBwHvqRQgx7NXHSBNA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

This patchset introduce Jenson vendor and add 4 of its panels to
panel-simple driver.

Giulio Benetti (9):
  dt-bindings: Add Jenson Display vendor prefix
  dt-bindings: display/panel: add Jenson JT60245-01
  dt-bindings: display/panel: add Jenson JT60248-01
  dt-bindings: display/panel: add Jenson JT60249-01
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

