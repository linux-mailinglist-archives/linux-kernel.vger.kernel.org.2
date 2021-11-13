Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD91544F19E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 06:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhKMFvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 00:51:50 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:18050 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbhKMFvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 00:51:45 -0500
X-QQ-mid: bizesmtp51t1636782518t4rlqw4m
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Nov 2021 13:48:37 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000C00A0000000
X-QQ-FEAT: W6nSwEQQYT/zLvTaMck+UA5HuWSWNNTR2iRVR/PtD0oRdGmXXAaG2q1qySIui
        ZWFWtsaUl+n1dd7/vZXqUQuB+yOuoJvmMqfd475Y2jJNp2w0xFwPPlmyQsGKCMGm1zuh6/d
        6DiSAMRKDGeU+x5SZlt8Fj1k8pHxWZqWF6Tne/9Pmf1F+H6Ipsmok8R199U0dgNOQKkVUsG
        ayKSC4sbkzqo9fBfmEnDSpeUItI9pLYTlN/1OmM1TWOEp5oY73NrpDFJr8zNvi2BeDLRdNU
        5d5uZUFPWJuVm3LxOq7R6JXzLElOjYsDxQovrQwqNnQRQ5eai3hVPwBlfosnQCY+DoBOrS6
        /GcK614YFmgg5y4vBIAc3H/RM1vOw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] platform/x86: samsung-laptop: Fix typo in a comment
Date:   Sat, 13 Nov 2021 13:48:27 +0800
Message-Id: <20211113054827.199517-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `it' is repeated in a comment, therefore one of them
is removed.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/platform/x86/samsung-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 7ee010aa740a..c1d9ed9b7b67 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -152,7 +152,7 @@ struct sabi_config {
 
 static const struct sabi_config sabi_configs[] = {
 	{
-		/* I don't know if it is really 2, but it it is
+		/* I don't know if it is really 2, but it is
 		 * less than 3 anyway */
 		.sabi_version = 2,
 
-- 
2.33.0

