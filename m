Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058A7383964
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbhEQQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345116AbhEQPuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 458F06143F;
        Mon, 17 May 2021 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621262745;
        bh=TpbOr6elZi+PPwNfI3J7bCp2pEpHJnlhWoG5yRXdSxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIEsOJ6nZxbNnrNwZEdnl7iaR629gL/7qdXNm70gzlJEUct57pPA6O5yKMksHJLaz
         Ief6Uq+hbRlx9tAOTW7uKnEiLJstRzxN8yTbH2d+6mDMvMYwHUF21xrYlAc3L6HWpz
         DTnXoPEUovmZq2JLaee0fVjjWjeRUlNf+sr1MpDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10 289/289] ASoC: rsnd: check all BUSIF status when error
Date:   Mon, 17 May 2021 16:03:34 +0200
Message-Id: <20210517140314.875434789@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517140305.140529752@linuxfoundation.org>
References: <20210517140305.140529752@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit a4856e15e58b54977f1c0c0299309ad4d1f13365 upstream.

commit 66c705d07d784 ("SoC: rsnd: add interrupt support for SSI BUSIF
buffer") adds __rsnd_ssi_interrupt() checks for BUSIF status,
but is using "break" at for loop.
This means it is not checking all status. Let's check all BUSIF status.

Fixes: commit 66c705d07d784 ("SoC: rsnd: add interrupt support for SSI BUSIF buffer")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/874kgh1jsw.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/ssi.c |    2 --
 1 file changed, 2 deletions(-)

--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -797,7 +797,6 @@ static void __rsnd_ssi_interrupt(struct
 						       SSI_SYS_STATUS(i * 2),
 						       0xf << (id * 4));
 					stop = true;
-					break;
 				}
 			}
 			break;
@@ -815,7 +814,6 @@ static void __rsnd_ssi_interrupt(struct
 						SSI_SYS_STATUS((i * 2) + 1),
 						0xf << 4);
 					stop = true;
-					break;
 				}
 			}
 			break;


