Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A88308CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhA2Skg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:40:36 -0500
Received: from mail.v3.sk ([167.172.186.51]:56634 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231195AbhA2Skf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:40:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 01D9BE0B3F;
        Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id c-6-AiePK1Yd; Fri, 29 Jan 2021 18:35:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6D400E0B42;
        Fri, 29 Jan 2021 18:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mOmq7RCAJBYi; Fri, 29 Jan 2021 18:35:45 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 621D3E0B3D;
        Fri, 29 Jan 2021 18:35:45 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] docs: arm: Improvements to Marvell SoC documentation
Date:   Fri, 29 Jan 2021 19:39:45 +0100
Message-Id: <20210129183950.75405-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying the patches chained to this message.

The objective is to deal with the a large amount of dead links to
material that often comes handy in marvel.rst; and improve some details
along the way.

Thank you
Lubo


