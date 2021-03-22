Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6373F343969
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVGZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCVGZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:25:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2AC061574;
        Sun, 21 Mar 2021 23:25:13 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c3so9508428qkc.5;
        Sun, 21 Mar 2021 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZVcmpP+UhARS/m30lTvHE+dZzN9PzNCkFcm7OvwBa0=;
        b=fI4TX7ek17FCkiIKIik/zYR/zzXube6XqFTXl7ypQK2fQV/SS0wvIIamtkm5pFpGvY
         oVGegTi/XwVv8s3ye7H7dmfe+Vk3sNOWHLY6WaOmfjbfwTE2H/wCMQgzCbLy2q/WKjax
         TnLOWbzq1eaVtxiIeAXjjlnUaLOrm/eDC+BOcBPVpg1I6N79DqKnhdiHhdBBL67jp7uW
         8q/OfW0HvP7hA2Po/PuSKgacoIBsrXKfOxU2NDN+qIgYYNLwDkDRqVQ2447WzwzGV2vI
         /aO8SOr0UNcQaLoow4N1j7LzumtgSdl8hxooOS4OqndLa+PhlLwatyAKK+JenSU1qZkP
         yxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZVcmpP+UhARS/m30lTvHE+dZzN9PzNCkFcm7OvwBa0=;
        b=D6r+NS9wTbQgAahEhx6pdcDGwlBmO/xcSCZtFRagoC8L9iKINaZY4jhvE1zn8s/Mgx
         cwmWluOJbgusuHbL7Ju888S4/WOz/00yAuz2mKm7aJgvrzSnjhBmleszO1Yj7Aru/kry
         Vv97GsY7b5dpoEHP83n4ah8DNSwcAbn+tLHSj7Wx8vLhlt8VLjI/qLcmZlpvb8sl1z7N
         66AdISu6VMvabdP3fR0Ye/G/ekzdFMqGmHHf76sOCT9B10yuyB/D19ne7ebW93iKBao1
         OaGv25i2pX0bsgp03SxBOy/2D/MIYObt2bXUn4VBQaA6LCstf/Vn4hIjfJ8qmyyC+gXx
         tMdQ==
X-Gm-Message-State: AOAM531kwuDJrvyssCTA40Ldjstc6+zR8jGFqlpn441lCJ0id7Xmso/9
        MVXa0M7eS3KFfhEdWSUKIF8=
X-Google-Smtp-Source: ABdhPJzDteIeotbCZo7rUyWGV2nQDEyu7pM6SIXZRyMwH6OPizPZEwwcf8mfAqB+8yLNZc22NP7/eg==
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr9141795qkx.501.1616394313206;
        Sun, 21 Mar 2021 23:25:13 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
        by smtp.gmail.com with ESMTPSA id t188sm10402244qke.91.2021.03.21.23.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:25:12 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        unixbhaskar@gmail.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] s390/kernel: Fix a typo
Date:   Mon, 22 Mar 2021 11:55:00 +0530
Message-Id: <20210322062500.3109603-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/struture/structure/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/s390/kernel/os_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/os_info.c b/arch/s390/kernel/os_info.c
index 0a5e4bafb6ad..5a7420b23aa8 100644
--- a/arch/s390/kernel/os_info.c
+++ b/arch/s390/kernel/os_info.c
@@ -52,7 +52,7 @@ void os_info_entry_add(int nr, void *ptr, u64 size)
 }

 /*
- * Initialize OS info struture and set lowcore pointer
+ * Initialize OS info structure and set lowcore pointer
  */
 void __init os_info_init(void)
 {
--
2.31.0

