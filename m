Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773ED36FCC8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhD3Oqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhD3Ops (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86507C061355
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a4so12287053ejk.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMN4zuhUHvB3cXnh9Uh5ILIZdfR0r9cSa/aL/onWxjs=;
        b=ImsevUptTIw5yMnp6rOZ2eKLvSNGzcXZLOo2G2SCEUVKFA57o+Zqc3eL7c5ByaQ1O6
         D326BbqxxAPO/j6MGxBWYuDkUgSjT3oSZ/k0til0L9qqiQgWS9PGFq4LloZVdukj4j4Q
         qBEQDB3zVI2XpedN20CHlvk94K2vfvmU/7jaEqvSptu/G/LH+LSlxScy/ds1sjBfhGPE
         qa8aGwUOuEIzR9UC3gPVthPBpyp5zTu5muzlSmVp+jh4aDvHi48xgUBmWEjvKbl9Z3u9
         kMHohTK67PTfrg0WQf6Lv4Z1nysPnD5FXXZE1q7rTTJNXx+ruUgqJLKj45NDPA9tYBC4
         +ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMN4zuhUHvB3cXnh9Uh5ILIZdfR0r9cSa/aL/onWxjs=;
        b=e6Nrgmt+IKk6fal9RG3CEYzISaynHziSLpa5IA5GqnrkZSIWedEFAHJT5B1eE5ZWLB
         ICxL2+KEvHTKCr1efD3vuJ5Md+P5yNP8fP18dZ9dlct84341miRMCUBrEK6gchsDnf/1
         9A5n4ZU9ns4fXxbDnowjd1F6thJfJvE3fV8eY1uF3N0JF5f7A8aklQhdxd/GmUiDtyOS
         zE7+p/rYtn4BqbqEeD19WFSyVZ47EOIFm/SfBMIh2iiBkC+oaAkkvsVt+/UsWcFZb9Bf
         hUOMN/+djnvKDdc67YZ8Dmyebxo1KjCDhYv0S1Q1uYhAhqL5IYLycPxEXRxGbUH0oYVM
         IcYQ==
X-Gm-Message-State: AOAM533MUcxMeIoe9s6QAe5VIJn4iDd9XTnJ8bvLBKyFOfyCv88daG3M
        oaOPAC8BGQgYLinauU9/qqnsC68X0Ms=
X-Google-Smtp-Source: ABdhPJwUkNGvWqgQ2WWhVBpdIy7+7iBux5Du2fauAeZwClblfs3D1oImyOFLYWvjHogPgIubArzhJg==
X-Received: by 2002:a17:906:32d8:: with SMTP id k24mr4944539ejk.156.1619793895117;
        Fri, 30 Apr 2021 07:44:55 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id ne17sm1953047ejc.56.2021.04.30.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/43] staging: rtl8723bs: remove BTC_PRINT_F macro definition
Date:   Fri, 30 Apr 2021 16:43:57 +0200
Message-Id: <905bdc72245ff8354fe2f4abb995c31f4fc4fd82.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused BTC_PRINT_F macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 36636ad62aac..9c9ad29870e2 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -115,7 +115,6 @@ extern u32 		GLBtcDbgType[];
 /*  The following is for dbgview print */
 #if DBG
 #else
-#define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
 #endif
 
 struct btc_board_info {
-- 
2.20.1

