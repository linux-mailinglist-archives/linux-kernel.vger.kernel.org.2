Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3F30E9E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhBDCCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:02:53 -0500
Received: from mail.v3.sk ([167.172.186.51]:53800 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232768AbhBDCCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:02:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E778EE0BB3;
        Thu,  4 Feb 2021 01:57:52 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XMmrYTYW4xfz; Thu,  4 Feb 2021 01:57:50 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 823C9E0BB2;
        Thu,  4 Feb 2021 01:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ovieJ57w_w99; Thu,  4 Feb 2021 01:57:50 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3E5DDE0BB1;
        Thu,  4 Feb 2021 01:57:50 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Ivan Najdanovic <najdanovicivan@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] clk: mmp2: Enable the 3D GPU clock alongside the 2D clock
Date:   Thu,  4 Feb 2021 03:01:54 +0100
Message-Id: <20210204020155.527556-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please consider applying the sad little patch chained to this message. It
is a workaround that makes the 2D GPU work on MMP3 when the 3D GPU is not
used.

It's been observed that the 2D GPU won't work when what is understood to =
be
the 3D GPU clock is turned off. The etnaviv developers suggest [1][2] tha=
t
perhaps said understanding is wrong and they may be right. Unfortunately =
no
documentation is available, all we know is the register names.

In any case it seems to make more sense to put the workaround in the MMP
clock driver instead of to the etnaviv driver.

[1] https://lists.freedesktop.org/archives/etnaviv/2020-November/003442.h=
tml
[2] https://lists.freedesktop.org/archives/etnaviv/2020-December/003445.h=
tml

Thanks
Lubo


