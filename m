Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92D30E7F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhBCXyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:54:11 -0500
Received: from mail.v3.sk ([167.172.186.51]:51506 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233723AbhBCXyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:54:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B1196DF61E;
        Wed,  3 Feb 2021 23:49:05 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qCsJZwXITT8D; Wed,  3 Feb 2021 23:49:04 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 46636E0B3D;
        Wed,  3 Feb 2021 23:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PvUNxx1hkyMa; Wed,  3 Feb 2021 23:49:04 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id F3021E09D2;
        Wed,  3 Feb 2021 23:49:03 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 5/5] docs: arm: marvell: rename marvel.rst to marvell.rst
Date:   Thu,  4 Feb 2021 00:53:05 +0100
Message-Id: <20210203235305.506528-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203235305.506528-1-lkundrak@v3.sk>
References: <20210203235305.506528-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This company is not the superheroes you're looking for.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/arm/{marvel.rst =3D> marvell.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/arm/{marvel.rst =3D> marvell.rst} (100%)

diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvell.rst
similarity index 100%
rename from Documentation/arm/marvel.rst
rename to Documentation/arm/marvell.rst
--=20
2.29.2

