Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4B3DCB03
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhHAKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 06:07:10 -0400
Received: from mail-40137.protonmail.ch ([185.70.40.137]:24406 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhHAKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 06:07:09 -0400
Date:   Sun, 01 Aug 2021 10:06:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627812420;
        bh=42l6hVE9Xr44CgagISwVflfD2mKF0Ky6NzWxUv5UoPo=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=RwR2LXK8GUzSX20EvWPH6/Ystxc3MKlISINBT7xyzKE3tT5XEiqSvSakfwMroBHYQ
         ZsFjdNgdiCwDG/BMltZod6oYHOI2bJylIzl3MGlyPrCxDNe3lHUVybETuthoFUTK25
         HT1wnnqPjxrDwdsX/Aj6+4oF+LHatoBVeFhoZ0b4=
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v3 0/3] extcon: usbc-tusb320: Initial TUSB320L support
Message-ID: <20210801100519.440574-1-y.oudjana@protonmail.com>
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

The TUSB320L is a newer chip with additional features. It is close enough t=
o TUSB320 so it works
to some extent out-of-the-box, but for some reason it can start in UFP mode=
 which is not desirable.

This series adds support for reset and mode setting for both chips, and doe=
s that while probing
to ensure the chip starts with the default mode of following the PORT pin.

Changes since v2:
 - Read state before setting default mode, then update it again after reset=
ting.
 - Remove mode tracing from irq handler
 - Add a delay after reset to handle tSOFT_RESET
 - Use a separate mode setting function for each of TUSB320 and TUSB320L.
Changes since v1:
 - Split first patch into two patches, one adding support for mode setting =
and reset on TUSB320,
   and the other adding support for TUSB320L.
 - Fix dt_binding_check warning:
   ../Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml:15:=
6: [warning] wrong indentation: expected 6 but found 5 (indentation)

Yassine Oudjana (3):
  extcon: usbc-tusb320: Add support for mode setting and reset
  extcon: usbc-tusb320: Add support for TUSB320L
  dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string

 .../bindings/extcon/extcon-usbc-tusb320.yaml  |   4 +-
 drivers/extcon/extcon-usbc-tusb320.c          | 164 +++++++++++++++++-
 2 files changed, 162 insertions(+), 6 deletions(-)

--=20
2.32.0


