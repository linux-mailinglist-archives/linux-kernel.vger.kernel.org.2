Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC441EB21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353645AbhJAKqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:46:11 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43326
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhJAKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:46:03 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 34FFF4030D;
        Fri,  1 Oct 2021 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633085058;
        bh=O34Y8o/c2Wg1erpZ/C1tknCRMa2cDe1ONW7Pxy5f7KE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=FRbiFYtvNJVvHal744VlOkzNohq/kvTF9ENdDvKyoLLPVOR7Na50w7YQ3ZNG4Ir5D
         Kf09w6RvoGJGWvGyvvnGUt282b825SeVUJVVqPhjQD0Q1OIgknkK1cjZ/gc8zSW+0D
         l8eoeT9PUb+xx85OZyvrr4rzdPc+MV7oR3cXM3wKGqCA+mQTAABPbmSNbEEyve/PiT
         NAxYwgPwZu8E98jSc6kZ/Q9trBs+cXFtVN/AbS7lq/NdPlHIg8LmqwskNCwPVB2DjI
         2gHAN6I9QRBS13ySBLMYa30oIUlehbi9fMDL/DemmIru6W669Ei+mUn5kAozbc/KEG
         JwtCugeT+lvCg==
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexander Tsoy <alexander@tsoy.me>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: usb-audio: Fix sum of uninitialized variable sample_accum
Date:   Fri,  1 Oct 2021 11:44:17 +0100
Message-Id: <20211001104417.14291-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable sample_accum is not being intialized and then has
ep->sample_rem added to it, leading to a bogus value. One solution
is to initialize it to zero at declaration time, but it is probably
best to just assign it to ep->sample_rem on first use.

Addresses-Coveriry: ("Uninitialized scalar variable")
Fixes: f0bd62b64016 ("ALSA: usb-audio: Improve frames size computation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 42c0d2db8ba8..c6a33732db3f 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -182,7 +182,7 @@ static int next_packet_size(struct snd_usb_endpoint *ep, unsigned int avail)
 	if (ep->fill_max)
 		return ep->maxframesize;
 
-	sample_accum += ep->sample_rem;
+	sample_accum = ep->sample_rem;
 	if (sample_accum >= ep->pps) {
 		sample_accum -= ep->pps;
 		ret = ep->packsize[1];
-- 
2.32.0

