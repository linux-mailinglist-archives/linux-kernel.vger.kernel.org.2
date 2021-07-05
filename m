Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36D3BC377
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 22:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhGEUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 16:50:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF517C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 13:47:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p16so6997991lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owhVWKFHyC3J6cH4NpobqXULLDkgBMIGsGNSqbFG3XY=;
        b=BSa6nUfzprgzTdHEWOMOnQZNeKGkfS+raoadhZ5IYkwWNTWbbXvOWo6MFDhISb502k
         te88t8goVaVMnOIRvcY0mNdFzdK5kAKeg1dju+bn/Ffq/U/+BFvHl1k5nP6vyDDNIzeN
         x6PgrClLlMWC1gU67W0xpOQbjF/VZEfi3JfA841iE/EXaIKV91IK/YgM+8wo4wYZ3oC1
         2ZyjzwxjhFaO3Cg1vN8mzfck6QqyNKu3KMfOYwdinUEecYExcNvLLIiFhsiNOHAYHd58
         ZsaR3A89kREWM8b+d6sHvES+YgV8XK9N6s6xKVtQGe043+pmEGbzPEBfd8F02WhMDbI+
         4XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owhVWKFHyC3J6cH4NpobqXULLDkgBMIGsGNSqbFG3XY=;
        b=A9OnC0hPLWn78FWc4cK9wUmi/qYVwNVLwS2RSD+PX1H4teFzTVknc02TBYjsaFRTqW
         3SUz81LpzGPfytQI0FKGAdCP6juDmcabd158c02ePsMfJ+rtw6uvW9s3PfeJpv6r117D
         lJ3GkzFOX0hdH2m+AlW+3t7iwrBEtK1OU7LVJCNJj+GZqc2T8/q2FI6LAk3npjjMBWbM
         dyIgzCnnuY8/Rm7E8lF4yXzS9AL8pxOBl3hJk+6pvcQXFTzxCnJYRhC5wJG2ePy0G6eX
         sWXYDGgGsEMN7PB3CuykNs/DSsOC6qpMnMb/xUFypWEO4msFiatIVdiR0h3HqyEW4lsJ
         BJcg==
X-Gm-Message-State: AOAM532bE1AFEnebnI/Xcy1/amHNUwv6xTJ6k45xLJEd6Gc9BtQFtTBR
        6SFnmD19TUVyJ9PDm4h8HIk=
X-Google-Smtp-Source: ABdhPJzw9wLP5AtgjFm5rlh3Gh9CZFw6f6g0a83kkxQ8w6DcJZZAqZowRzR4YyaG81qS5iwuQcvEcA==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr12101439lfe.5.1625518049895;
        Mon, 05 Jul 2021 13:47:29 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id b19sm1506702ljo.37.2021.07.05.13.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 13:47:29 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     geert@linux-m68k.org, pstehlik@sophics.cz, milan.jurik@xylab.cz,
        schmitz@debian.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] m68k: emu: fix invalid free in nfeth_cleanup()
Date:   Mon,  5 Jul 2021 23:47:27 +0300
Message-Id: <20210705204727.10743-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In for loop all nfeth_dev array members should be freed, not only
the first one. Freeing only first array member can cause double-free bug.

Fixes: 9cd7b148312f ("m68k/atari: ARAnyM - Add support for network
access")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 arch/m68k/emu/nfeth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/emu/nfeth.c b/arch/m68k/emu/nfeth.c
index d2875e32abfc..79e55421cfb1 100644
--- a/arch/m68k/emu/nfeth.c
+++ b/arch/m68k/emu/nfeth.c
@@ -254,8 +254,8 @@ static void __exit nfeth_cleanup(void)
 
 	for (i = 0; i < MAX_UNIT; i++) {
 		if (nfeth_dev[i]) {
-			unregister_netdev(nfeth_dev[0]);
-			free_netdev(nfeth_dev[0]);
+			unregister_netdev(nfeth_dev[i]);
+			free_netdev(nfeth_dev[i]);
 		}
 	}
 	free_irq(nfEtherIRQ, nfeth_interrupt);
-- 
2.32.0

