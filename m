Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C3313E16
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhBHSw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:52:56 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52671 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhBHRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:00:43 -0500
Received: from orion.localdomain ([95.115.15.83]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmUcL-1lZNoE1JUP-00iTIg; Mon, 08 Feb 2021 17:58:07 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org
Subject: [PATCH] of: base: improve error message in of_phandle_iterator_next()
Date:   Mon,  8 Feb 2021 17:58:06 +0100
Message-Id: <20210208165806.25466-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:550q3+4NZYJj/XjtVh/TKc17E963AF7x0y0SFyh8Xe8xvkP5OFD
 a1KKYQfCbhK3MVNOD8LgerjSH2fsZX/Ft0DkLIG5YYHtuHuxBYEvD+mwLw6xK7GO/v0RwNU
 tL+b/NLCyNWAwWcIyPgGJ4DsJxAuuZhJVr+5iIMbseWlfq0PXvjOxQ4FS1ThkxbDVghuI/g
 ioQ3vLueoZ3E/p6EyAZ3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Em2hHDZMQno=:hrqFR3VrYxOTMEpAR+b3qT
 0qct2G9R/hS+7huDuxxCXuhrHRfVI3YlxZiL7wY2X6eDzI7ymn0RDcEcIQPS3/JkAwvL8RU6F
 Tgp15LZQV6BgD+uyDAC/gZjWEPZQeA+V6RvLHMK1Fc1DDvUgJy0Uo38ZFhzp9f+J35gMq5U1u
 UeMk55+ms7jvXc4xBYBk2EmhSm7CdWKogT9aZLx5vuijqo6++5RTirSy7ur2p+yUqxphx7vme
 S+P2tWCk9WWByeAYN44eKwZ7NzzJmczJNFVVuqqhu9qXB2y5qddqTVLwQuCfDkw9oYHQ0Nhi8
 Df6xeumLfymRj0DLOe+xxSaNrACAZ95hSLP8wlHmZGKkCdPG/ewNMRIgVKrxx+vZ1zkY/M6gO
 2TAfNGOHB3TTcHCV5dUVBV7Mautaf/nSH3/v1fzgy8WU/+7gdPbpao6FFd966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also print out the phandle ID on error message, as a debug aid.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/of/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 161a23631472..8a348f0d3c5e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1297,8 +1297,8 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 
 		if (it->cells_name) {
 			if (!it->node) {
-				pr_err("%pOF: could not find phandle\n",
-				       it->parent);
+				pr_err("%pOF: could not find phandle %d\n",
+				       it->parent, it->phandle);
 				goto err;
 			}
 
-- 
2.11.0

