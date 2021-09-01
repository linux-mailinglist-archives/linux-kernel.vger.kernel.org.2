Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446E3FE1C3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhIASIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:08:17 -0400
Received: from mail-4318.protonmail.ch ([185.70.43.18]:24817 "EHLO
        mail-4318.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344186AbhIASIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:08:16 -0400
Date:   Wed, 01 Sep 2021 18:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630519637;
        bh=uir4PzcrAGtJv0MOdHgIa+arRXdiTMZ57zGd4NlaWNs=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Iy273D2utq+j9HfHAKnRbLZ2eW5jhWvz3Ox85lJtkns6/APwMt/ChNwdluULYoacj
         /aMn1Ssk71m520VWz9Q9XMRifom5KyYYMZJJBjvVnXJHOuVJiyedEgXXkdQtW7FdNP
         DdIBrUBj4gCV0LfmvsKNZTfQfELf/IVgzjYdGaZM=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 0/2] drm/panel: Add support for LG.Philips SW43101 DSI video mode panel
Message-ID: <20210901180644.248177-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a driver for the LG.Philips SW43101 FHD (1080x1920) 58Hz OLED DSI
video mode panel, found on the Xiaomi Mi Note 2.

Yassine Oudjana (2):
  drm/panel: Add driver for LG.Philips SW43101 DSI video mode panel
  dt-bindings: display: Add binding for LG.Philips SW43101

 .../display/panel/lgphilips,sw43101.yaml      |  52 +++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-lgphilips-sw43101.c   | 331 ++++++++++++++++++
 4 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lgphili=
ps,sw43101.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-lgphilips-sw43101.c

--=20
2.33.0


