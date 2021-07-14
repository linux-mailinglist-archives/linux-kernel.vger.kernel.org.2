Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53C93C89FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbhGNRqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:46:22 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:35043 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGNRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:46:22 -0400
Date:   Wed, 14 Jul 2021 17:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1626284606;
        bh=djL0oKEwgHyyu0eyGYeM5enV1letI9OTk2xft4IC0nk=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=nRVEtkyVi0Xee36MzW161Gf/+b57x68fs+yZ0Ef227ThhjsnBxhGi3bkkQwn0NV1y
         uI13UMnRFiwUll+IATIDtng4u3epaqIqmVkt5ny0blDWb3GDWD1ZsdJ0alrnqyk/Yt
         W/QUyrp5TmmnndnRdrz1lQOSM5MVIFQZjWRxUsAE=
To:     Michael Auchter <michael.auchter@ni.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 0/2] extcon: usbc-tusb320: Initial TUSB320L support
Message-ID: <ZVtY8ZdnQnXI65vHO2wlw6ULY212Ppn0NvzEEXzCoc@cp3-web-033.plabs.ch>
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

Yassine Oudjana (2):
  extcon: usbc-tusb320: Add support for TUSB320L reset and mode setting
  dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string

 .../bindings/extcon/extcon-usbc-tusb320.yaml  |   4 +-
 drivers/extcon/extcon-usbc-tusb320.c          | 172 ++++++++++++++++--
 2 files changed, 159 insertions(+), 17 deletions(-)

--=20
2.32.0


