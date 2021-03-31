Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67663346B77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhCWV6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233630AbhCWV55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:57:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87955619D1;
        Tue, 23 Mar 2021 21:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616536677;
        bh=8EtGiHDV0aGfT6JHT+y8795nI5qrUiRVp2/1aJHgw3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Y6HWEAfJnMhDMS30qt92NgDTbvw6z2SvltX0zWvOBGC+Aq4XD42KCSK9aYwjYALH9
         7N5oQUlCAXsNln2A6HUuZH5spYzMZEPaQVm6mKYwjBNmADVqF7QOpucHszg8oirOsL
         h7hrD+8gENTosITtjfpQ2Jzh93nIazoQ6rO+uMfF0aDAP3AGf/D92uRdt1cjIMn2VS
         pQP071aW3wTtLePyD6hS/qkn6zZte2vp/Gj8T2iE4pLRo/n4/LQIU9GQYOz0w6eNjS
         Tc0mXVoopoVuprZmhLQ8kuqFlC9cxH8Dq++C9NUD88z8n9pMeCXg7B2rd0e5EYtRMp
         X81FOjyEq92lg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philip J Kelleher <pjk1939@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] rsxx: remove extraneous 'const' qualifier
Date:   Tue, 23 Mar 2021 22:57:26 +0100
Message-Id: <20210323215753.281668-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The returned string from rsxx_card_state_to_str is 'const',
but the other qualifier doesn't change anything here except
causing a warning with 'clang -Wextra':

drivers/block/rsxx/core.c:393:21: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
static const char * const rsxx_card_state_to_str(unsigned int state)

Fixes: f37912039eb0 ("block: IBM RamSan 70/80 trivial changes.")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rsxx/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 5ac1881396af..813b0a554d4a 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -392,7 +392,7 @@ static irqreturn_t rsxx_isr(int irq, void *pdata)
 }
 
 /*----------------- Card Event Handler -------------------*/
-static const char * const rsxx_card_state_to_str(unsigned int state)
+static const char *rsxx_card_state_to_str(unsigned int state)
 {
 	static const char * const state_strings[] = {
 		"Unknown", "Shutdown", "Starting", "Formatting",
-- 
2.29.2

