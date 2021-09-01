Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C063FDF85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbhIAQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:14:57 -0400
Received: from mail-4319.protonmail.ch ([185.70.43.19]:34525 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhIAQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:14:56 -0400
X-Greylist: delayed 14242 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2021 12:14:55 EDT
Date:   Wed, 01 Sep 2021 16:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630512837;
        bh=ozlBt1i7C3ToF9gnvhesed85X7BkG7QEdtTaP9cu3DQ=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=w0UL07xOtLdUqyCTMHfQSEq8PhulgaG/utEZe/LPSDzbSuYfxNJJSFX9EmNbdQfo1
         rk1Gr/0lnFj51kO9zdN74RSHqTCbAy8avcjtkl2n/DjR3Aw1kAF6yaGXJNL/bPekuN
         8WnEB+r9ZTKbRWDCg5EVHPyd9+0SFfxtmk+YHKWU=
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v4 0/3] extcon: usbc-tusb320: Initial TUSB320L support
Message-ID: <20210901161339.223973-1-y.oudjana@protonmail.com>
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

Changes since v3:
 - Remove unused tusb_modes.
 - Remove extra blank line.
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
 drivers/extcon/extcon-usbc-tusb320.c          | 156 +++++++++++++++++-
 2 files changed, 154 insertions(+), 6 deletions(-)

--=20
2.33.0


