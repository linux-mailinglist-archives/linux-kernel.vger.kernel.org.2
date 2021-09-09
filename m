Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47AA405898
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351321AbhIIOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348741AbhIIOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:05:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20626C0355D1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 05:04:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1282053wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EthtBWdKPfSvjNDHY91II6u6SjXUqSpnwm/Zof13TQQ=;
        b=Id7rgTtAdJXJgBg1knsHgi5MJXwTze3ZT40EaZHsoqdHW3ixK5BPVJplLqiM9nEVlb
         i8HGvw+nj/eINT+x/XWcrHYmBG7aoy42m+mX806ZILzohVhOADUpzNLKQKEds2edAq1q
         7kH4Dnkecm8ANH/RvzkUKf7UFlzyOtXova5wzL3uoUpTeCoMxc111hMStQ7V4FBxh1Iv
         /UB/K9hmUYx8YTJaYQOWal86qQ7Nin/ilxvDuASIVqborSjxQD6JFo4k95lnNixDfZcC
         iDVHAmpNg/53UD8LhapW6djc0hWBbFqegidMbflMH3nvHP68T+/h+WCqIxxkOmJO6aJm
         BLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EthtBWdKPfSvjNDHY91II6u6SjXUqSpnwm/Zof13TQQ=;
        b=5xSdEmk5qhYCEd3TAeCiObFDmf8lq94EDIWlDlcCQz9s1oJkr/a9bNkqjT349F2Zjb
         oe9sqlOs8WNDVMJ8xELp+ZlMQB/T3hhoX8YHUVIGSdOUvQ7D8gtnoyq5algncjL7wTia
         0JlbOZyNc9qxUXsf/oQ60DNK+VCGwJeI1XqTwkr+iiLCURpYrwJ+wY3zQd9VO5GX2P2L
         agoJJHXwL0MMz7/zCXjkmD5E7jXNcEaxfni52ItxyaqFHDoThXBWLpRxaXVnG0mljLJ7
         F+vqXBEn0pIySZy1cAv12nr871v3aD/5XbSkZbYE25y9Eu1ydeOjKbo3XREqioxAmn1S
         3AVA==
X-Gm-Message-State: AOAM533Q7zaSbyfIz4UM7UjDXekybY0H8IHGRifwWf/L2RLY8nEd7rDo
        EpV6aB1ewUJKg2O3uvwY3NzdiA==
X-Google-Smtp-Source: ABdhPJywDaQzNQ9eLZC1KwAFFSwdsBD6diKKNsiBhdDHpihrdYEKLYlg3eETB1S2pdTHPfJebXoO+w==
X-Received: by 2002:a1c:7417:: with SMTP id p23mr2624122wmc.144.1631189068689;
        Thu, 09 Sep 2021 05:04:28 -0700 (PDT)
Received: from localhost.localdomain ([95.148.6.201])
        by smtp.gmail.com with ESMTPSA id n66sm1437498wmn.2.2021.09.09.05.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:04:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/3] reboot: Export reboot_mode
Date:   Thu,  9 Sep 2021 13:04:20 +0100
Message-Id: <20210909120421.1313908-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210909120421.1313908-1-lee.jones@linaro.org>
References: <20210909120421.1313908-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elliot Berman <eberman@codeaurora.org>

Export reboot_mode to support kernel modules wishing to modify reboot_mode.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index f7440c0c7e434..957ef52b8af44 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -33,7 +33,9 @@ EXPORT_SYMBOL(cad_pid);
 #define DEFAULT_REBOOT_MODE
 #endif
 enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
+EXPORT_SYMBOL_GPL(reboot_mode);
 enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
+EXPORT_SYMBOL_GPL(panic_reboot_mode);
 
 /*
  * This variable is used privately to keep track of whether or not
-- 
2.33.0.153.gba50c8fa24-goog

