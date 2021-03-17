Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1603E33EC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhCQJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCQJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:04:37 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E35CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:04:37 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d20so38145321qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/QALeH7PgIqdJCNh1QudPBXuTGR62+LsmILJFDMTZU=;
        b=Cm3JrRcviowCEXj5d5PWA7VutLsPoeca2RGX192F6MIhPYz2pdfayBdfBoUNTJffEw
         OUg16s0Yv3AgeZ4G1uH4XIPDNUeQoRT+anTF8epJcFVt8APP9Tuap03GIX8Y26XKLGMq
         D7YvkgutQAmdHPPXIxOamPPgf8nPI+NCrvKU3kaOermzy9U0GHteC9aBWErpWfS2ijyP
         qqKKjtPZEke1zktT1qN5u2jxzROj6LpkK1iEQF6AVltQ7tkM3sGXsJhFgfYCvPtt4VQ+
         UBHYVNaa4uBeZ1oluy6bkpxXNMWDkm231v9FfdHa3f82kCRLoo1BEM6gfEbjJENjeNEa
         PX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/QALeH7PgIqdJCNh1QudPBXuTGR62+LsmILJFDMTZU=;
        b=GQqzJES8NgwgEXWnWVPFP0/TiXgL6uBJX6Fp0dy8hkimUhbYF8tr2AQAu65r7HiziZ
         4vrLPfCdikPSye/25mClN5GE021Ka05MEm8cQ2vSvIUd8fVSM81Jw1AFKQkHUD/3+3El
         gAN2KQihv/Bznc4jsYJK6Gwc368J2jnCgDHBvaToTSHuGs7BuDPlVgrmYKOvWam0hF6c
         NXsebqbqXvb5oXDgXwZ6igzdKHXhblIwIy7CGpnqutRlWZt3L2f3o24RuxFHvJWpa3q0
         rrgMDhsSCn/91hl3RsmSAhQXkPnPyPm1VojXCyNWIlmIEg4ZilkTwM6N69xa1bO4Y1z3
         s+Cw==
X-Gm-Message-State: AOAM5327uTYlHnR1lzwm9GEaOFni0gOc8mS5MvH3oDcVhwxo3S/Wpqh4
        TyP7mxVbqjASxRYDb044hqs=
X-Google-Smtp-Source: ABdhPJzivtYEMadnDZYNb3ssdC1THxrgwqHVnF917hZwSRkhyIOSGGKk0xS3EV3eUopxGiwdV7HMQw==
X-Received: by 2002:a05:620a:13db:: with SMTP id g27mr3675187qkl.367.1615971876587;
        Wed, 17 Mar 2021 02:04:36 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id z2sm17799618qkg.22.2021.03.17.02.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:04:36 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        jniethe5@gmail.com, unixbhaskar@gmail.com, alistair@popple.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] powerpc: kernel: Trivial typo fix in the file kgdb.c
Date:   Wed, 17 Mar 2021 14:34:13 +0530
Message-Id: <20210317090413.120891-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/procesing/processing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 409080208a6c..7dd2ad3603ad 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -376,7 +376,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 }

 /*
- * This function does PowerPC specific procesing for interfacing to gdb.
+ * This function does PowerPC specific processing for interfacing to gdb.
  */
 int kgdb_arch_handle_exception(int vector, int signo, int err_code,
 			       char *remcom_in_buffer, char *remcom_out_buffer,
--
2.30.2

