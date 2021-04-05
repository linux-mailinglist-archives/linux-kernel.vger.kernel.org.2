Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF80D353C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 09:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhDEHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 03:14:52 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:29801 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhDEHOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 03:14:49 -0400
Date:   Mon, 05 Apr 2021 07:14:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1617606882;
        bh=sm4Wmh33BHBh6HQDVppb0B95nGm+lkWMBV7SXPLkaB0=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=CQljiD1b9ynHNiFaFTUw2j7+RXF4fAtgQe/tEXozTKiPWF/yUOq6Ykw9hAkWkYoQk
         WMv3Ave8s0tc6y1DIR7Ilxu6N48ptIQGGf0c1jaDCZ9AIx8II3NMLx3XCWE3JM53qR
         cHOHEK1MvyhS1UJKkZcfOWMTYvdFqwsulFpaoh6c=
To:     Lee Jones <lee.jones@linaro.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH] Revert "mfd: max8997: Add of_compatible to Extcon and Charger mfd_cell"
Message-ID: <20210405071344.1215429-1-timon.baetz@protonmail.com>
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

This reverts commit 9c03008da125c1007919a9186628af3cc105f526.

commit 41a8a027f4d3 ("regulator: dt-bindings: Document charger-supply
for max8997") introduced a binding which uses a property of the max8997
pmic node to configure charger supply, making subnodes for MFD cells
obsolete.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/mfd/max8997.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 55d3a6f97783..68d8f2b95287 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -29,9 +29,9 @@
 static const struct mfd_cell max8997_devs[] =3D {
 =09{ .name =3D "max8997-pmic", },
 =09{ .name =3D "max8997-rtc", },
-=09{ .name =3D "max8997-battery", .of_compatible =3D "maxim,max8997-batter=
y", },
+=09{ .name =3D "max8997-battery", },
 =09{ .name =3D "max8997-haptic", },
-=09{ .name =3D "max8997-muic", .of_compatible =3D "maxim,max8997-muic", },
+=09{ .name =3D "max8997-muic", },
 =09{ .name =3D "max8997-led", .id =3D 1 },
 =09{ .name =3D "max8997-led", .id =3D 2 },
 };
--
2.25.1


