Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD439DFAA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhFGOzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:55:39 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:34768 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhFGOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:55:21 -0400
Received: by mail-qk1-f172.google.com with SMTP id k11so15273774qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1xy5+ZYgA3Gk+562MTFN//SREYWR/vvxvs31rzlarI=;
        b=snKCRIxmZ0rEGpsysvKONFWUn0kliwg3Ig5wdFBW+1RS+z4gW7hBqVy73LUBPNr7ol
         JSYLDNZp+ylF7vwXyqxSLGtZV5Xyx4XWn20R++hnMdjsyMcOaQ7nn1kzb2HhqXSOdavC
         Nbm/woI4YXU+fXPm2nxMzKRxqFJd66ItKiCCwPcNUAuhewMCT18yIULD/cIek7McXq0U
         LgDfHJOceYOUITWCtxHzEEgX1tIwS8S7kADhypnSNOXw0X0CKkXm8AB+/I+Hs2WQSm0S
         J8v1nW+C5IDM8g3GdiJQpLRBMYvM6u0t8kfLE7/agL1u8r14wkzOV1GR0Mr7d3Lfxwbz
         YB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1xy5+ZYgA3Gk+562MTFN//SREYWR/vvxvs31rzlarI=;
        b=GFSFdiOehf8Nbod6vzEJp/6OGnIV6r52ttyLTLR5pge3YAkj79lhLNYkxD0f+LHQwW
         j4b50Fp3YtS/cS1Li2QxKwca1t8fsSZDE2u3o3ulBoVxTA2SbGVVKGlPVSh31KOfuhzV
         XCMKbNLBPgNpAca4JVYEjkS18tUt/TNUaOMLCWsDHbUWFakEa98P4iFr0r8C79hRKv2p
         xARyhSkbLf9SpAdVK0dXexG+zC6YrQ1Odn42bCQTkkyFqsqNZWEJcO9G9oA6Ll56oePL
         yqHilUihJZa6QRRZd84ItQy+qD4GSN2Hi0IBxz+tTQ/UdMrQE0SWVyKLmnEXK+lSDb6V
         F3MQ==
X-Gm-Message-State: AOAM5334OG+hKucRZf+nBi2QnoZNMygGtjmKjpz5+5qmLjzmmJnv++QF
        4QUa1HFfueVpp92ZuhB11gA=
X-Google-Smtp-Source: ABdhPJz4QjbCnJrqRNat4PLSmVCRrxZgAl1QXKvYMEjxq8Q+v/LvENYk9u9/fGOYbcmOP2qPegIRfg==
X-Received: by 2002:a05:620a:a87:: with SMTP id v7mr2202686qkg.468.1623077549502;
        Mon, 07 Jun 2021 07:52:29 -0700 (PDT)
Received: from PK.localdomain ([61.152.208.153])
        by smtp.gmail.com with ESMTPSA id o5sm9676977qkl.25.2021.06.07.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:52:29 -0700 (PDT)
From:   prettykernel <prettykernel@gmail.com>
To:     mingo@redhat.com
Cc:     bp@alien8.de, x86@kernel.org, hpa@zytor.com, jroedel@suse.de,
        keescook@chromium.org, prettykernel@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86: remove unused enum value GATE_CALL
Date:   Mon,  7 Jun 2021 22:52:17 +0800
Message-Id: <20210607145217.6561-1-prettykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GATE_CALL is completely unused.
Just remove it.

Signed-off-by: prettykernel <prettykernel@gmail.com>
---
 arch/x86/include/asm/desc_defs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index f7e7099af595..f6687e4ab78d 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -40,7 +40,6 @@ struct desc_struct {
 enum {
 	GATE_INTERRUPT = 0xE,
 	GATE_TRAP = 0xF,
-	GATE_CALL = 0xC,
 	GATE_TASK = 0x5,
 };
 
-- 
2.25.1

