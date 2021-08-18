Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E43EF99B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhHREmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhHREmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:42:10 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E60AC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y5T2QETkmfGoDiWQT4JfTnoQNmDKxLKaqLzfd5nLplg=; b=AWN6VTWTuCLjVrLDnnawmpxVmT
        itYSi/mirl9Y65Q/FBWkckvw9vFJyjELSYeek/VweiCpHFrGCdrEvLW5OOZ6E7KKHoNa6HwKqeIHK
        FUJHpkA16q4W1vsswtATCSFFuZz4FylAJkfldxqMX1Jp7xpDq1+7BrZHZpE+YtI/ATlA=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1mGDOP-000673-WE; Tue, 17 Aug 2021 21:41:34 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH] staging: rtl8723bs: put '{' on struct's first line
Date:   Tue, 17 Aug 2021 21:41:05 -0700
Message-Id: <20210818044105.23128-1-ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Watson <ozzloy@challenge-bot.com>

Moved the opening curly brace to the end of the opening
line of the phy_stat struct for style consistency.

Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
---
 drivers/staging/rtl8723bs/include/rtl8192c_recv.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtl8192c_recv.h b/drivers/staging/rtl8723bs/include/rtl8192c_recv.h
index c77d172de7d08..9664758e21bef 100644
--- a/drivers/staging/rtl8723bs/include/rtl8192c_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtl8192c_recv.h
@@ -13,8 +13,7 @@
 
 #define MAX_RECVBUF_SZ (10240)
 
-struct phy_stat
-{
+struct phy_stat {
 	unsigned int phydw0;
 
 	unsigned int phydw1;
-- 
2.30.2

