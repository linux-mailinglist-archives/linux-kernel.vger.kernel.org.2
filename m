Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5540E7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbhIPRnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344579AbhIPRfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:35:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 004AB63230;
        Thu, 16 Sep 2021 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631810938;
        bh=AfyNKaF0xtWhgKji+tagvSCdhOnS9R1W6yf+rMj9Wis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmnmhXpov+7DJDZqwINgpga9ljKjaRde7HuSDR8vN+KhqYYrZiggbiRE8bwD39k1/
         D1mqy6wJ5Ow0/ka6udOeNcKYkh9Bh1Bjfh25Nln07ImOP4vyGcR+YQTbEP5FZFkgV7
         9fliLAAyhDyaYur9D8Tp7RqHmxBIPl+gLL7uHnSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.14 323/432] kselftest/arm64: mte: Fix misleading output when skipping tests
Date:   Thu, 16 Sep 2021 18:01:12 +0200
Message-Id: <20210916155821.784949673@linuxfoundation.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916155810.813340753@linuxfoundation.org>
References: <20210916155810.813340753@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 83e5dcbece4ea67ec3ad94b897e2844184802fd7 ]

When skipping the tests due to a lack of system support for MTE we
currently print a message saying FAIL which makes it look like the test
failed even though the test did actually report KSFT_SKIP, creating some
confusion. Change the error message to say SKIP instead so things are
clearer.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20210819172902.56211-1-broonie@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index f50ac31920d1..0328a1e08f65 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -298,7 +298,7 @@ int mte_default_setup(void)
 	int ret;
 
 	if (!(hwcaps2 & HWCAP2_MTE)) {
-		ksft_print_msg("FAIL: MTE features unavailable\n");
+		ksft_print_msg("SKIP: MTE features unavailable\n");
 		return KSFT_SKIP;
 	}
 	/* Get current mte mode */
-- 
2.30.2



