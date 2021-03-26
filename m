Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC5349EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCZBa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCZB34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:29:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 18:29:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y2so3206084qtw.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 18:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21Jat5CDIW2CaeRR7v0thvJPDtMpuyraw+ePxHKJEJs=;
        b=IYiwUB6eIqrbGvW6VlRrO5EWEpTgwnebrdNlEYtgc6muSH3ml2GZFNpIfTmVk6PaHD
         H/isypR6M/o9FOsVs5yUWAWx6TbFczh8skVbaI4Xm6Y2ktUL7xfLcaBXi1qm3Qk+WCaN
         8tv4/62dqrq0kG+98QjRaahFGI1rU9SCgCONrrPaXu+iUkUdGaiTBTNL5abDmdC3rKP+
         5jb2PsKsbdrwjgydPXnht5O0R9OoGIcKvKI/DgRSUQOv1NOvD9sLXuEC4y/81Vd6ICJk
         SU8ErpLp59Nb+yjfhdaysKsc4xs8DbDTMzdVdQjuPEAKuY8KvkLYkOAbp4greduviMH3
         oL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21Jat5CDIW2CaeRR7v0thvJPDtMpuyraw+ePxHKJEJs=;
        b=l8Rxbca0jtWyv/O/ETAjM2mxGPLiDJInNprNaGteyISpH0/th/6E8qQ0ZUPmLGODYC
         ulnRqkKyQVGsUtXMnmU+zuP1nvC32GFu21WWVl0uHopmC/bjtGVkbnWO8Xs0cyNx0hhN
         atkrdxJ7MCFdxCaXAYIO/RdfYmKI3t9tlOthtrEn3Vsrn3HTO4/AM6RO/f6gbp08IW6A
         9hhUB53MHVP9+oLt17oVr8UHCNYdwUWIC0bHMO3VpqNLKE0EdsJD62R2N6DISlp7I09k
         FJ5CMrbuXkgfX1S/sUKgWCAGyBxTH7uLbMPaDc2hDYUoJyBa3BNgGIIy5/BEW0zyexAI
         mbrw==
X-Gm-Message-State: AOAM5330psIfvgHqgl1NETWSba5T7dCE6HSyGzyZyCNe10jW2F9kaSRY
        rX1RRvPvwpweyANGWf/ThTw=
X-Google-Smtp-Source: ABdhPJxcslKrCHUgEuTVfmWsPhswjbXaUU4hvfZAmHAIrYOBmJKKp/pFuhm1uUjtNUmzMCQdtAM2/Q==
X-Received: by 2002:ac8:4543:: with SMTP id z3mr10561775qtn.286.1616722195576;
        Thu, 25 Mar 2021 18:29:55 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id i14sm4981694qtq.81.2021.03.25.18.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:29:55 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com, unixbhaskar@gmail.com,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] platforms/iss/simcall.h: Change compitible to compatible
Date:   Fri, 26 Mar 2021 06:57:39 +0530
Message-Id: <20210326012739.18038-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/compitible/compatible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/xtensa/platforms/iss/include/platform/simcall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/include/platform/simcall.h b/arch/xtensa/platforms/iss/include/platform/simcall.h
index f42870ab551b..5ba2454e6c37 100644
--- a/arch/xtensa/platforms/iss/include/platform/simcall.h
+++ b/arch/xtensa/platforms/iss/include/platform/simcall.h
@@ -46,7 +46,7 @@
 #define SYS_socket      26
 #define SYS_sendto      27
 #define SYS_recvfrom    28
-#define SYS_select_one  29      /* not compitible select, one file descriptor at the time */
+#define SYS_select_one  29      /* not compatible select, one file descriptor at the time */
 #define SYS_bind        30
 #define SYS_ioctl	31

--
2.26.2

