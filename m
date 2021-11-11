Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1885544DCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhKKVCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhKKVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:02:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AD2C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:59:43 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso5538654pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYIYWvTKaNiKh2FFVLH9BIOQfrhImcibkGPrOfuAKQg=;
        b=UcE6QNl2XRCnDx+XrGKPl1xkr6JDSUStc3RsBtpXSFFdxe++LPO8CeWfR6GJNndXPy
         J+38XN0mhf6/S25ZaGevpo8iLUntXgAJxhu44bKvEqyeGs6teQtFOnXXeNfSXIIAI6eU
         TCqlqGnj87r+fX6zsBSzmX36COIwz0+fwod2SqIIaiAizBP7U1snmQA1xwXn5X9BUs2U
         Xs1yYu1nK8VcClOL/YpHWDNqN/1lOLcWzjs62D0LuTJWj8F1ZUZwVm0cyHRd1tEbY2ge
         rNpi1kjQ2pe1BNb/nUcPSA0Wq61TpMkCI47eHxkQkWx3zKEIJiy5xjg3I1jl1nKcOOkT
         LVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYIYWvTKaNiKh2FFVLH9BIOQfrhImcibkGPrOfuAKQg=;
        b=Avt8RdbcvyiuF9AQjhP2BnmgDirtifYxxwNcmIoDoLkJDrrC+YT1IwUseCdHQDqhkv
         qk882NGjDAam7IMLWvxvTaDVPDjV2GrqKIa0wInP9QOqUocgSfSm0w7lERFTm05JirdY
         3S5ma1PnvW9gjP2nw60uzA2g/UjK8VMIPrRuVRzEJ6jpCkLov3qkoueaDvYcJlDmJVUl
         brOnDSIF+A3xiyS41v95IUtbjC1/9FX/8VkWTrLJJpcfXKUYF6Bnf//lTW8KlwqGU4Oz
         OaCuXx2/7Pv3jWg6r1tohAnv4HdI843cMoLUnRlQm+1Ymw4sY/K1jclvrI2s9A/xNbEV
         KPzg==
X-Gm-Message-State: AOAM531nofLhY2y0ve6WTh6dVseSlTN3Sr+aUwQ+WSob/k9MzyDVWRf4
        1z7AIcFZLw3iEaLl5IrC39BdIw==
X-Google-Smtp-Source: ABdhPJylh8+qntfUSHiBAFlKENV8+xDWePE09jd/UmpP1PbprE9ejv8q8N+jiiFonhOc9DxJUuBm2Q==
X-Received: by 2002:a17:902:ce8c:b0:141:d218:954 with SMTP id f12-20020a170902ce8c00b00141d2180954mr2011937plg.1.1636664382585;
        Thu, 11 Nov 2021 12:59:42 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id g5sm9134575pjt.15.2021.11.11.12.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:59:42 -0800 (PST)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     jmaloy@redhat.com
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] tipc: check for null after calling kmemdup
Date:   Thu, 11 Nov 2021 12:59:15 -0800
Message-Id: <20211111205916.37899-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup can return a null pointer so need to check for it, otherwise
the null key will be dereferenced later in tipc_crypto_key_xmit as
can be seen in the trace [1].

Cc: Jon Maloy <jmaloy@redhat.com>
Cc: Ying Xue <ying.xue@windriver.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: tipc-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 5.15, 5.14, 5.10

[1] https://syzkaller.appspot.com/bug?id=bca180abb29567b189efdbdb34cbf7ba851c2a58

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 net/tipc/crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index dc60c32bb70d..988a343f9fd5 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -597,6 +597,11 @@ static int tipc_aead_init(struct tipc_aead **aead, struct tipc_aead_key *ukey,
 	tmp->cloned = NULL;
 	tmp->authsize = TIPC_AES_GCM_TAG_SIZE;
 	tmp->key = kmemdup(ukey, tipc_aead_key_size(ukey), GFP_KERNEL);
+	if (!tmp->key) {
+		free_percpu(tmp->tfm_entry);
+		kfree_sensitive(tmp);
+		return -ENOMEM;
+	}
 	memcpy(&tmp->salt, ukey->key + keylen, TIPC_AES_GCM_SALT_SIZE);
 	atomic_set(&tmp->users, 0);
 	atomic64_set(&tmp->seqno, 0);
-- 
2.33.1

