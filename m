Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E4634799A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhCXN3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbhCXN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:28:55 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057BFC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:28:55 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y5so16396889qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZA4TMh4IQBJtlxJtgRg6PC7dBsn/y/DHlKXiLg69OBw=;
        b=vIAeFill0cXse/9RJBHavhpguN7xSunFa2f+v2bdmqARM2G7mS5PMrrSXhVx41lH6C
         KEoxKR6UuHlDbKnwsl3p8z1F9EFzOiKeQiP6l1rb3/izBA9tTqaPzehpikrq0vZSDJqX
         4aYH5LwedhVmaeOhOF27DD4tsZ7vIEXYAtxgGiJFJze7Yym/DsuR2d8v52g6HBlbPBSJ
         Q83bXj2BXfllIoypNNVaug2C5phbhumK16MeagjM7IQ1G0/qdfuzKUrqONR+ykO933p9
         oUZtP2EDjgf8AIShCLpnSfIN1xoyKJiMYl4vIR+CYy9PfPkNg11J+z29APLScd3neX/j
         inRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZA4TMh4IQBJtlxJtgRg6PC7dBsn/y/DHlKXiLg69OBw=;
        b=SLxWfG3OY9CwUlwzzgmp2S5O/dH3BmjYBq4ZAKonuE99AMbMI0HzPDkgBmdxkHPgH4
         WP+x3MlQ6Sz/d2Bir+rlwtZqNBDwsZ970l8YpxGGoPHr6uleDor4BsCyckTVSY/yhoJ/
         eOgHOPoQ8QkQAsgz9PSIGbCc1gTsSgysUiYb7g69M2veLyZKJoh0SNIltB0tGsUcJS3u
         PsCF9NWj4RcHuJtjSg9IHVr9bPmkPzc9bgop6wLTmyXKL0+PJTu4zsRJ6gXqW9wE985q
         nk6Xp/UDPkdJ59JGnqVj3cFR1i7VD/q3kByze4JXU28WHkgvLpXCOLpc8W8Xd4t8gvV8
         KHGQ==
X-Gm-Message-State: AOAM533WNwS8LOn8e9145MFJPR3E8wCfr+lesQbJ3ruRd2fwslJZXkm5
        GaUVRJr285IX76tvawJdvMA=
X-Google-Smtp-Source: ABdhPJy2CjjpOmQpimqajsFZOrQh+V4XiC9VHO5NNVgJMDvkS8TP9WHAV0Aahm5348sd/33RwTJrfA==
X-Received: by 2002:a37:a2c2:: with SMTP id l185mr2986406qke.178.1616592534322;
        Wed, 24 Mar 2021 06:28:54 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.36.138])
        by smtp.gmail.com with ESMTPSA id k138sm1620627qke.60.2021.03.24.06.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:28:53 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     sstabellini@kernel.org, linux@armlinux.org.uk,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] ARM: xen/mm.c: A mundane typo fix
Date:   Wed, 24 Mar 2021 19:00:36 +0530
Message-Id: <20210324133036.17665-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/acrros/across/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/arm/xen/mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 467fa225c3d0..be7c942c74bf 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -105,7 +105,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 	 *	- The Linux page refers to foreign memory
 	 *	- The device doesn't support coherent DMA request
 	 *
-	 * The Linux page may be spanned acrros multiple Xen page, although
+	 * The Linux page may be spanned across multiple Xen page, although
 	 * it's not possible to have a mix of local and foreign Xen page.
 	 * Furthermore, range_straddles_page_boundary is already checking
 	 * if buffer is physically contiguous in the host RAM.
--
2.30.1

