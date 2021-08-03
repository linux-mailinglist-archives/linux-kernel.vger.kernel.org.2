Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF33DF1D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhHCPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbhHCPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:55:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC1C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:54:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p5so25863090wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ekZI3NGXszcB0SL1lyPknxhXIDZbetH0RPF8laxNz4=;
        b=c+eg1E02HSdUpAxZbBpFSUQV02j0nIlnvgH/D7XUHmenEfxEcyI9WsrzOEo68ccbfB
         OO8rm4IXmuV1pyWNl63S64CaKxgyKjhnxnstm7uXWxm6hKhoFBLNMkzVkrY9CjxJDCRW
         eARPQtW9WWsAOqvyyasbzM1FvVjohiLXoV9AwvI2kPslebwEpONoPgJpvYvrQKrrLjNS
         KeBcek20uOGRRIX2UU/xToPERLcBR8tfPyuCHkgm2RFXo3ykhFCVO5Ug/aXUxzLINzjW
         KVHn4mqIBu6d4XMLrGRJBzp1TlQ9Z5+HIaSsuso0kF1vUWaMEsRS4NP2CG6vyTnt1Wtt
         H8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ekZI3NGXszcB0SL1lyPknxhXIDZbetH0RPF8laxNz4=;
        b=edgSSTe04ABA+f/iO7rtFQdbqRp9rAdKi6iyHby//dqZ3rPReazu1FPBqUkrFrDSfk
         p9wNsWaJpZ8jojkXjbjcacFJ6IQF1qDf0Kf5u4YG7kKqj8fZ2bBVEzKL4NXA0gvCPyG7
         EO6qdfhNv5AWXuK26oDSIpb8KTD4MWjWM/gQ8ArqfMTqNyMPtyPehhI5bbFBH+qs7J+o
         3VihMhqJHw6ptBzHrS1L6TwaHcr/VX5+XeMHcDJOv1gLJzBp7RKlb7FsHEo/WYUkpSX5
         TOepxPQonv3yyYI0G00SfTzhB7PmAamEz23ljjN0x09pNiPDFwjIiQNgWCcQEQL6zF+D
         Vh6Q==
X-Gm-Message-State: AOAM530mwVm2MYqZ2a2Hg8lEWuXsiUEMKlEck3COGDk6t92dhFLf+lg5
        dDym/eYpCdPydVGGmefxChmCHw==
X-Google-Smtp-Source: ABdhPJwZAJIWwsXN4h+phJ7hMQSLL6MOXgdKX3w1+JFtr0QiY2daayxpOyK+4ekmBwnl8W36VxwH4w==
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr24388233wre.406.1628006098335;
        Tue, 03 Aug 2021 08:54:58 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id c10sm14058863wmb.40.2021.08.03.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:54:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] reboot: Export reboot_mode
Date:   Tue,  3 Aug 2021 16:54:51 +0100
Message-Id: <20210803155452.435812-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803155452.435812-1-lee.jones@linaro.org>
References: <20210803155452.435812-1-lee.jones@linaro.org>
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
index a6ad5eb2fa733..7ca414aa070b6 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -32,7 +32,9 @@ EXPORT_SYMBOL(cad_pid);
 #define DEFAULT_REBOOT_MODE
 #endif
 enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
+EXPORT_SYMBOL_GPL(reboot_mode);
 enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
+EXPORT_SYMBOL_GPL(panic_reboot_mode);
 
 /*
  * This variable is used privately to keep track of whether or not
-- 
2.32.0.554.ge1b32706d8-goog

