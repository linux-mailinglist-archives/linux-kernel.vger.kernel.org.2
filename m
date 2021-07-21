Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF69A3D1238
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhGUOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239510AbhGUOmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:42:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 751B761244;
        Wed, 21 Jul 2021 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626880991;
        bh=Uq8RegiTiFFlvPPR3xFmNGqgN5QCZVi7GNDBgvrHvpc=;
        h=From:To:Cc:Subject:Date:From;
        b=PPujmvNZzVwUpu36V5BazOdj/YVcmfmAD4FCDwo2Bcp8IkQi/FAv3CQLcmi97J8dh
         O3bL8yiKsV78d2OsnDADbunuOfXLjSuts3Q+kR9h/gNpYPJddNt3aCuPT0KD8L0dMz
         HD0tsvkkBXgRsPVXlpaGmrGTg6WOXoz2mOYzaYldV97Rud5utCoAJbeNTJwhGohWhG
         EXVwFo6OavjXzehNjDU5lCtb24LO1sDTwsQuOe0lTGgqYwjluNTzFYJUc+x8B8r4v+
         qMuSR15mIG0vItSGxzUtIT4GtXaTlvPtgx3rmJNrV7uNNZjvobnfWfbUR8PmuPeRg4
         Nuf1PqP7HcxQQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: boot: add a missing fallthrough statement
Date:   Wed, 21 Jul 2021 17:23:02 +0200
Message-Id: <20210721152308.2785319-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This instance seems to have slipped through the mass
conversions to the fallthrough keyword:

arch/x86/boot/printf.c:248:31: error: this statement may fall through [-Werror=implicit-fallthrough=]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/boot/printf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/printf.c b/arch/x86/boot/printf.c
index 1237beeb9540..c0ec1dc355ab 100644
--- a/arch/x86/boot/printf.c
+++ b/arch/x86/boot/printf.c
@@ -246,6 +246,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 
 		case 'x':
 			flags |= SMALL;
+			fallthrough;
 		case 'X':
 			base = 16;
 			break;
-- 
2.29.2

