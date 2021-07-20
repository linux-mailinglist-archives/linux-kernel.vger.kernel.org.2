Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4429B3CFF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhGTPiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:38:50 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:40910
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235368AbhGTPgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:36:35 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 42B8B40605;
        Tue, 20 Jul 2021 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626797831;
        bh=ovWvZYpFeH2hDUTYYPI0Dy/ZjyO3fV33Wt5GPE9ZRIo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=O1Js6ANgPeOxlDdF/qT7ORtEBigap9LaPwaPQbw+228N0cQf8XW6H/kf55Cb4NwSD
         HQwUfqt58DrJ0lVKwzmGONK4pEE31xHdWRxsuhxUgXyB2MBODlcYdH8+DsLRYCi09X
         YtCWOn+DbOd/zowSeBO0nrrACQGGtwaS8pxEjj1m/Lj4EPYrx0UxBHn8NdGX70+qpp
         7ZhM1rotaaYpb/zwU8G7HFXE7rsSvSRAzV5J6pXHaOpKt5ygGiHarzeRdci1n+MSaB
         3T/7bQSyzAsegfCy48MB3/WTu/1VkboUsKGbEl97PoC2bzdx1jgClSmePuvN/m7uGK
         z1zNCzLYOE2ug==
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: sc6000: Fix incorrect sizeof operator
Date:   Tue, 20 Jul 2021 17:17:07 +0100
Message-Id: <20210720161707.74197-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Static analysis is warning that the sizeof being used is should be
of *vport and not vport. Although these are the same size it is not
a portable assumption to assume this is true for all cases.  Fix this
by using sizeof(*vport).

Addresses-Coverity: ("Sizeof not portable")
Fixes: 111601ff76e9 ("ALSA: sc6000: Allocate resources with device-managed APIs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/sc6000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 6236c4fa766a..44c05b55fc15 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -552,7 +552,7 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 
 
 	err = snd_devm_card_new(devptr, index[dev], id[dev], THIS_MODULE,
-				sizeof(vport), &card);
+				sizeof(*vport), &card);
 	if (err < 0)
 		return err;
 
-- 
2.31.1

