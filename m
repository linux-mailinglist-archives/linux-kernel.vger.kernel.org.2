Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAFC45819B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 04:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhKUDwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 22:52:35 -0500
Received: from mail-40140.protonmail.ch ([185.70.40.140]:32454 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbhKUDwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 22:52:34 -0500
Date:   Sun, 21 Nov 2021 03:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1637466568;
        bh=53Aep61SjwN1bbt2NyvZwMWupKmypuNkQjTA36s/OVg=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=HORvAdfG+HPlrNr6POGaISJA/EBDYJxagqLkEXCvsxEP2bjRLVudPvBHUfzmWYWwG
         w61hrT4IuCptHTuN4i8jOogZMz17eYPjh9k2LjQK3J32S596zcW559hdhswutNlneW
         NMs4i8w48aBCyU/DOYPAUAAjpypzbsdJKeoQtIVQ=
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
Subject: [PATCH v3 0/2] drm/panel: Add support for LG.Philips SW43101 DSI video mode panel
Message-ID: <20211121034748.158296-1-y.oudjana@protonmail.com>
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

Changes since v2:
 - Make the DT schema patch first in the series.
 - Use backlight_get_brightness where needed.
 - Remove 0xff mask from return value in sw43101_bl_get_brightness.
 - Constify struct backlight_properties props in sw43101_create_backlight.
Changes since v1:
 - Add regulator support.
 - Add MAINTAINERS entry.
 - Dual-license DT binding.

Yassine Oudjana (2):
  dt-bindings: display: Add DT schema for LG.Philips SW43101
  drm/panel: Add driver for LG.Philips SW43101 DSI video mode panel

 .../display/panel/lgphilips,sw43101.yaml      |  75 ++++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-lgphilips-sw43101.c   | 358 ++++++++++++++++++
 5 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lgphili=
ps,sw43101.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-lgphilips-sw43101.c

--=20
2.33.1


