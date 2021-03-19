Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65583411E0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCSBEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhCSBDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:03:50 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:03:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id cx5so4217728qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9xP3X9PpAQVd+rZ008IRsIYZNaYtN0YSfrC4kwn0PJA=;
        b=jioiEoX5Hni0cOcDXSr3KUYXZ9qShMOZtKGD5jkIGHLVmibto8cTWSmiyNaHZeFsDh
         6rdXp5o5fBJVwrpulJrPyn93zYFJ6Y9kekOekvf1A4Y0tt4Cdvy7g9FU46inZ1VLO0Ax
         TIzEnAM1iQayWl8TWO/TSacOhRQM/umDBWB1COGgpexBB98buLc2ryNMXD2LD5sha5AG
         CC++rbcCfBEvAB9HpZed6DyaIoXzuLky8ebv6sn/cK92uYVu+oMQKdNcCPjNhGsUHPhl
         Oi+qOd34HfLbTi0svYe0ZX4DhkV28UJB8zzU2cppa+s2rMXvJOAXThuixcDe2T14SuUt
         ZAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9xP3X9PpAQVd+rZ008IRsIYZNaYtN0YSfrC4kwn0PJA=;
        b=hBHcn9c1S1GE+a1GhoUQTIGw63K0GX+c63OWrTsEoHgfc8SyQFyWYqysUVunZk2ObL
         RLS0IAbDyQcSbvmEKmUdFcFp9vSbNwyFIKUBL6j/TvgxJFOJBREroQEdKWcSAIirt7v7
         OcjtBSeXDhjLgcUAjggkdRmxxK1fpufOcJCqe05bi92dWFjGw3+wJdLYUVNXEcNsrVcU
         REsG0eEIf0S4vfjYLfpsUD9Z7Z7Fv+NIoy/QRdaQp2rzzK7LHsdx8Bg7f2A8tda7kZrW
         HFfjFBx7lcDRNkW1mq5n8hiTaVe41XhpEDTuo+KVy3f21W7rkoZz1s9+g9Cp6ekXP0oy
         GiKw==
X-Gm-Message-State: AOAM533pAxQ+bzrrrrdrXMa/ZmTV1aRUGggl1xkxswM4hVL7bSISpyWL
        dMsuDWqAGQ4dP1SxLHdZccw=
X-Google-Smtp-Source: ABdhPJxL3unbct5zQ5bD6qykcBn3/jra6HxeL6/bukPWhZiq4+BAiBeMivTlpsSOGm8AAbut9qesAA==
X-Received: by 2002:a0c:df02:: with SMTP id g2mr7132280qvl.40.1616115829341;
        Thu, 18 Mar 2021 18:03:49 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id p8sm2737322qtu.8.2021.03.18.18.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 18:03:48 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] average: Mundane typo fix
Date:   Fri, 19 Mar 2021 06:31:26 +0530
Message-Id: <20210319010126.9537-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/funtions/functions/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/average.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/average.h b/include/linux/average.h
index a1a8f09631ce..0cb77b3e483c 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -11,7 +11,7 @@
  *
  * This implements a fixed-precision EWMA algorithm, with both the
  * precision and fall-off coefficient determined at compile-time
- * and built into the generated helper funtions.
+ * and built into the generated helper functions.
  *
  * The first argument to the macro is the name that will be used
  * for the struct and helper functions.
--
2.26.2

