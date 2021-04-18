Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72E3635E4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhDROfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 10:35:05 -0400
Received: from mout02.posteo.de ([185.67.36.66]:33137 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhDROfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 10:35:02 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E59402400E5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 16:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618756471; bh=rYz1iYMPPpnH1ROWWWLmEyef4hZdKfqV/2D7gCvZouE=;
        h=From:To:Cc:Subject:Date:From;
        b=aELviN00jquLGqXP5uL5NwJqNp8NNv/s9mcSF5bls56/pDKtn/NKEoSG4m5ciIOr/
         BHPLZ6b8sy4C4FwQ16CpxVzOJDZcvgrhO8aZy7fduOZVXy93Y0YCYJDANfl+c7LLeW
         irDWgmTg3NZRRcFXeUKXb6TE3xxADu+l4PSRaU0u3fxZVyIpqp8Kie5bsxevc8OE33
         3eGmEkbainildUeoeZr75VoQdztHyKIPN9VHWh0m1WzkJOppZuVW4ln7VRrttVPOJp
         tXxKHD6ooJkPleME9gdQEgOygxlW22p5R28tmwXJqTBvenuUsCjOd1SkxgYcJ3/0UC
         aLLDpAnKe+wZw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FNXX73Zcpz6tmB;
        Sun, 18 Apr 2021 16:34:31 +0200 (CEST)
From:   Alexander Egorenkov <egorenar-dev@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Egorenkov <egorenar-dev@posteo.net>
Subject: [PATCH 1/2] lib: scatterlist: Fix loop termination condition in sg_calculate_split()
Date:   Sun, 18 Apr 2021 14:34:24 +0000
Message-Id: <20210418143425.22944-1-egorenar-dev@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nb_splits was decremented one time too much becoming negative. This
leads to the failure of the loop termination conditions which checks
only for nb_splits being zero. Move the loop termination condition
a couple of lines up before nb_splits is decremented again and potentially
becomes negative.

Signed-off-by: Alexander Egorenkov <egorenar-dev@posteo.net>
---
 lib/sg_split.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/sg_split.c b/lib/sg_split.c
index 3d9b32084d78..0920affd12ee 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -60,15 +60,16 @@ static int sg_calculate_split(struct scatterlist *in, int nents, int nb_splits,
 			curr->length_last_sg = len;
 			size -= len;
 		}
-		skip = 0;
-
-		if (!size && --nb_splits > 0) {
-			curr++;
-			size = *(++sizes);
-		}
 
 		if (!nb_splits)
 			break;
+
+		skip = 0;
+
+		if (!size && --nb_splits > 0) {
+			curr++;
+			size = *(++sizes);
+		}
 	}
 
 	return (size || !splitters[0].in_sg0) ? -EINVAL : 0;
-- 
2.31.1

