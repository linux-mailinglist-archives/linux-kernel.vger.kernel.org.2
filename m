Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF271445ECB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 04:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhKEDnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 23:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKEDnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 23:43:00 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2351CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 20:40:21 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g13so5706304qtk.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJfLJtH3UXJVM1N+KsS5NvQISO9g/+LT6C94n+yKqUw=;
        b=hSe8XulvDaGNBCo+IkavWu5YWutCjT40QeBhwTvMG+NefVs6/8vcRFhPFalkMq0iJX
         plyzIuQ/8p10xamsYMmV1qtNLc65OGro+Om6a6B0O6IAwHMEF7NxiZJgG90JtZp1AlYD
         r++2Fql4D/I27c+ZLk80pYWG7r/ZeifAzbz3ZYjHW573pAeZXFcp/+LYMQ3+bI42+XPf
         KUe9zWB3KGnPBRDq8Z8cDwLNIpzyWorZoBUGFX4hDS2PtwRX5J2zYIgper4PFwCCnMSW
         NN9Yizy8+Isvm/a6u9idoHv2aPQPxulukZtZL8Q5q1wsMidRwDVygCOiCBO99ZznRypj
         vDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJfLJtH3UXJVM1N+KsS5NvQISO9g/+LT6C94n+yKqUw=;
        b=Sig9Ydu6YG/3Co56dyDNs6EFIFD8EfAbOqczCvhA25vh0JUFLI1qv5+XKsOWR/ZgE/
         zhhcJXBfyrXO53uz9cT4cKt+zhxWZl2LL81RTmTuSbdmPGTxqy5y79VVWHs4DwtOSOde
         olgZPteWOcIs48kNaHdqXvs5Y6rWeDQ9LF+b9NFYOUakXofansvhAQHizF4YVAFqXqbB
         /RpEMmkiP3rqkUx7EAuwl9GPpsR7r8Ku9zNXlLMrUvbSZzCqiZfoJ6ygMimuPOEi8UXH
         D4K57SWH+sTRbhvclaJLv1Vp5bd81949dVQVQeB5odUovfv6APthoXJIrbhi1NY+KlYs
         ACVw==
X-Gm-Message-State: AOAM531gLIvTNHzTBj1Kw2qx6pAx1AvCv5FPzKY85gTf+okCbj9JRzUT
        30sWnxBwKABix6k65hKJqPQ=
X-Google-Smtp-Source: ABdhPJyyCLzj/slZiDgoAbXxqXvP8R6QKFX4FCP+MTr8+4vPEUMNjN0k2oWRhHeBGu+rZGHxGACW+Q==
X-Received: by 2002:ac8:5c14:: with SMTP id i20mr60383542qti.47.1636083620303;
        Thu, 04 Nov 2021 20:40:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bs34sm4937571qkb.97.2021.11.04.20.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 20:40:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, ye.guojin@zte.com.cn,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc: xmon: remove the duplicated operand of the bitwise operator
Date:   Fri,  5 Nov 2021 03:40:11 +0000
Message-Id: <20211105034011.76008-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

The operands of the bitwise OR operator are duplicated, remove one of
them.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 arch/powerpc/xmon/ppc-opc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
index dfb80810b16c..2cab0ec0d162 100644
--- a/arch/powerpc/xmon/ppc-opc.c
+++ b/arch/powerpc/xmon/ppc-opc.c
@@ -6731,9 +6731,9 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 {"fre.",	A(63,24,1),   AFRALFRC_MASK, POWER5,	POWER7|PPCVLE,	{FRT, FRB, A_L}},
 
 {"fmul",	A(63,25,0),	AFRB_MASK,   PPCCOM,	PPCEFS|PPCVLE,	{FRT, FRA, FRC}},
-{"fm",		A(63,25,0),	AFRB_MASK,   PWRCOM,	PPCVLE|PPCVLE,	{FRT, FRA, FRC}},
+{"fm",		A(63, 25, 0),	AFRB_MASK,   PWRCOM,	PPCVLE,	{FRT, FRA, FRC}},
 {"fmul.",	A(63,25,1),	AFRB_MASK,   PPCCOM,	PPCEFS|PPCVLE,	{FRT, FRA, FRC}},
-{"fm.",		A(63,25,1),	AFRB_MASK,   PWRCOM,	PPCVLE|PPCVLE,	{FRT, FRA, FRC}},
+{"fm.",		A(63, 25, 1),	AFRB_MASK,   PWRCOM,	PPCVLE,	{FRT, FRA, FRC}},
 
 {"frsqrte",	A(63,26,0),   AFRAFRC_MASK,  POWER7,	PPCVLE,		{FRT, FRB}},
 {"frsqrte",	A(63,26,0),   AFRALFRC_MASK, PPC,	POWER7|PPCVLE,	{FRT, FRB, A_L}},
-- 
2.25.1

