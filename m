Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499803CFE05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbhGTPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:03:35 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33958
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241915AbhGTO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:57:52 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8CF2D40601;
        Tue, 20 Jul 2021 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626795469;
        bh=vSe9B2XKzwjqZRJOAWXj0xGJqQPCF7dn+Fs2x2z3Q1I=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=AWXqm5bpaoeROqEvOTnTWyCjK4OkcAn9n7m1/mRm13jhExQrZuXnXvdpW96IMiphy
         grMU6M85EtazGbM+1gKalYq8jm5SoubL/fwFxMIMXerLFz/YRZuaHnZiannfgZIjV9
         Q8zP/eoKSnFbGPCnI0sFWFa+j/FD6WxQdqbJymskqIqh0Z8iFwtqzZopoowtDmbOip
         cS/80tYRdfAx2wRpvtQIXVcT34nNJi0G64YDvf4PA49+ymeytfN6RCa+isSeArvxp8
         W28rja8512PMiUUx6Lt95FEMcOwgPIo6/Y5j6YvC3g//9gl3h8zTxVoSyziCxzR+s0
         qk4o7F3MEjuIQ==
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: opti9xx: fix missing { } around an if block
Date:   Tue, 20 Jul 2021 16:37:41 +0100
Message-Id: <20210720153741.73230-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the { } braces are missing around an if block causing subsequent
code after the return to become unreachable. Fix this by adding the
missing { }.

Addresses-Coverity: ("Structurally dead code")
Fixes: 2973ee4a5b54 ("ALSA: opti9xx: Allocate resources with device-managed APIs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/opti9xx/opti92x-ad1848.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 8988de8cca96..4beeb32fe2a7 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -1096,9 +1096,10 @@ static int snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
 	if (error)
 		return error;
 	error = snd_opti9xx_read_check(card, chip);
-	if (error)
+	if (error) {
 		snd_printk(KERN_ERR "OPTI chip not found\n");
 		return error;
+	}
 	error = snd_opti9xx_probe(card);
 	if (error < 0)
 		return error;
-- 
2.31.1

