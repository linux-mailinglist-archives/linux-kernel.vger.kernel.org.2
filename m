Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1D308CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhA2Skn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:40:43 -0500
Received: from mail.v3.sk ([167.172.186.51]:56684 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231485AbhA2Skg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:40:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A58EBE0B42;
        Fri, 29 Jan 2021 18:35:48 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TFGthHbzTzyX; Fri, 29 Jan 2021 18:35:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1A3C7E0B4A;
        Fri, 29 Jan 2021 18:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B9T3QNMhkr_Y; Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C3E3AE0B42;
        Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 5/5] docs: arm: marvell: rename marvel.rst to marvell.rst
Date:   Fri, 29 Jan 2021 19:39:50 +0100
Message-Id: <20210129183950.75405-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210129183950.75405-1-lkundrak@v3.sk>
References: <20210129183950.75405-1-lkundrak@v3.sk>
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

