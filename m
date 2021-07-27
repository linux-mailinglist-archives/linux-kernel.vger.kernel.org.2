Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102F63D726D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhG0J4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:56:38 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:34974 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhG0J4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:56:35 -0400
Date:   Tue, 27 Jul 2021 09:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627379794;
        bh=mij9CFn51wUIIyFl2Gh2dBEt+qOFlfSFmHQ646Jvp6I=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=BkodnMRm2iMI9Fa6tKIBTPzqSvo74CGvv+03RTJX4lftiZecp84x0mwT63yk52bwt
         vpTE420oNHDmep41757iRekrGqjLJ3hR8vCRCj2FAbQdAPVFKABOBkOiGVdUKoXWf3
         eLVW4KsC6ihT8wye6/YvOd/BxbBSP+mUv1JmjUwk=
To:     Michael Auchter <michael.auchter@ni.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 0/3] extcon: usbc-tusb320: Initial TUSB320L support
Message-ID: <a1IcsWeSdRxWaMFcwV1k7z3l1HaAkyRCo2zLdOWb8w@cp4-web-014.plabs.ch>
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
 drivers/extcon/extcon-usbc-tusb320.c          | 164 ++++++++++++++++--
 2 files changed, 152 insertions(+), 16 deletions(-)

--=20
2.32.0


