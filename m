Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E560366C62
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbhDUNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242327AbhDUNKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:10:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 263746144C;
        Wed, 21 Apr 2021 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010569;
        bh=G5jxHkhxZ+0HBQefBjYg5uXdXffkVf3buspo6p4Zwjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4MuPf8qqsKyqGovEfuJcZZYJ6EzDaWHxv8ccCi7ldvcFFWN2YyvU/n1auqCTNryC
         5SCBfHl+v+nU0od0MPbZAfeQoJh3+Rfz3PXvYic9dPz+uEn30GZIJeuNrIQTmSwte4
         QH3KQ6jD1IpQ7mRnJ/Xp9g+Gb/gAxoh5wiyy6LEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 148/190] Revert "media: mt312: fix a missing check of mt312 reset"
Date:   Wed, 21 Apr 2021 15:00:23 +0200
Message-Id: <20210421130105.1226686-149-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9502cdf0807058a10029488052b064cecceb7fc9.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Matthias Schwarzott <zzam@gentoo.org>
Cc: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/mt312.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/mt312.c b/drivers/media/dvb-frontends/mt312.c
index d43a67045dbe..1dc6adefb8fe 100644
--- a/drivers/media/dvb-frontends/mt312.c
+++ b/drivers/media/dvb-frontends/mt312.c
@@ -627,9 +627,7 @@ static int mt312_set_frontend(struct dvb_frontend *fe)
 	if (ret < 0)
 		return ret;
 
-	ret = mt312_reset(state, 0);
-	if (ret < 0)
-		return ret;
+	mt312_reset(state, 0);
 
 	return 0;
 }
-- 
2.31.1

