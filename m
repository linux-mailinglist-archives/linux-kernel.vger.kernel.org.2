Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F3366511
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 07:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhDUFyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 01:54:43 -0400
Received: from mout02.posteo.de ([185.67.36.66]:59823 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhDUFyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 01:54:41 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C3CAC2400FC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:54:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618984447; bh=yz64K1S8MzFsrG6lA1jNOCnHQSaHgRv/O6kDZOx2kiY=;
        h=From:To:Cc:Subject:Date:From;
        b=oGWHZDM03tPRNRqxJ4xjMu8qjwvoaXXCslbdQqM/kEoMpJbkU1b7mgweN5Bb/KwW/
         lpMpZIfhbywv4BG9M9t4BTIm8pucRNt1Gx8abLWiRpUjtYa1eW3QEJvWlq+FJa0IFK
         xDe1bh2t30im7sinyVKxKgiKm9wcSJfwHH2c8UW5Efh/K3P0aHKG326Aah0QFBIY3i
         dtEuvrEv3DbYRDI9vbDWfpGNSuUau9X1BWRi0t/Urn5UXeKqCZprnOJMlqsD17CDZo
         NCfuycuuiGX9lm1wM0GyfVF7RFxtAvHRsDVzyjWdgEyavKfb8g1brIWCtxPAtSyHSI
         2jthfQTO9hPvg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FQ8rH21T8z6tmN;
        Wed, 21 Apr 2021 07:54:07 +0200 (CEST)
From:   Sebastian Fricke <sebastian.fricke@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Fricke <sebastian.fricke@posteo.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: core.c: Improve a comment
Date:   Wed, 21 Apr 2021 05:52:37 +0000
Message-Id: <20210421055236.13148-1-sebastian.fricke@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/regulator may on/regulator may already be enabled/
s/or left on/or was left on/

The aim of this patch is to make the comment more readable and to make
it clear, that this is about a regulator, that is already enabled instead
of a regulator that may be switched on.

Signed-off-by: Sebastian Fricke <sebastian.fricke@posteo.net>
---
 drivers/regulator/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 16114aea099a..1fb1f586bb6d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2650,7 +2650,10 @@ static int _regulator_enable(struct regulator *regulator)
 		goto err_disable_supply;
 
 	if (rdev->use_count == 0) {
-		/* The regulator may on if it's not switchable or left on */
+		/*
+		 * The regulator may already be enabled if it's not switchable
+		 * or was left on
+		 */
 		ret = _regulator_is_enabled(rdev);
 		if (ret == -EINVAL || ret == 0) {
 			if (!regulator_ops_is_valid(rdev,
-- 
2.25.1

