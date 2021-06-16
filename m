Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B953A9961
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhFPLii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232509AbhFPLif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:38:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C944461356;
        Wed, 16 Jun 2021 11:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623843389;
        bh=YCOeFow/marJnGVtCdA1iH+F1XVHfkTaFQmJaaygqbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfYpQ9McQuss01l1gYtOO+xD1xQtckWwAoQhg0uQgN6eRx3Ntc7H2yM2LLNuCZviN
         OHUYb+RhgPOtNIYOC75Lq+i6aBcXhDrXUTuC91G5rhdB2pSUuuU51N0mUoIP+3vKoJ
         NLurR+uDMSQj6Uscck75lh2ltCtqzTzXg0gKvaJLQon6H0zkIR3H6jJDgOuIbDc93V
         N5CaYrqcd9GgBqWOtSzmpTNnJvLh4PUZWv20zMESy3evb3H8tkI8I1lVOVErZ2TIn/
         iaw6uuZt6wPNgln35Qgew5V3iz4udtJidL7iB0mW5qFgVZjjkZ3F45iBkLK05uSLEf
         f9is8amBWiLkw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 2/2] mailmap: add my other e-mail address and identity without diacritics
Date:   Wed, 16 Jun 2021 13:36:24 +0200
Message-Id: <20210616113624.19351-2-kabel@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616113624.19351-1-kabel@kernel.org>
References: <20210616113624.19351-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of my commits were sent with identities
  Marek Behun <marek.behun@nic.cz>
  Marek Behún <marek.behun@nic.cz>
while the correct one is
  Marek Behún <kabel@kernel.org>

Put this into mailmap so that git shortlog prints all my commits under
one identity.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index c79a78766c07..db58eedb44f1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -212,6 +212,8 @@ Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
 Manivannan Sadhasivam <mani@kernel.org> <manivannan.sadhasivam@linaro.org>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
+Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
+Marek Behún <kabel@kernel.org> Marek Behun <marek.behun@nic.cz>
 Mark Brown <broonie@sirena.org.uk>
 Mark Starovoytov <mstarovo@pm.me> <mstarovoitov@marvell.com>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
-- 
2.31.1

